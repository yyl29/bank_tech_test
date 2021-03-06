require 'account'
require 'timecop'

describe Account do
  subject(:account) { described_class.new }

  describe '#balance' do
    it 'initializes with a balance of 0' do
      expect(account.balance).to eq 0
    end
  end

  describe '#deposit' do
    it 'can make a deposit' do
      account.deposit(1000)
      expect(account.balance).to eq 1000
    end

    it 'returns the amount that was deposited' do
      expect(account.deposit(1000)).to eq 1000
    end
  end

  describe '#withdraw' do
    it 'can make a withdrawal' do
      account.deposit(1000)
      account.withdraw(500)
      expect(account.balance).to eq 500
    end

    it 'returns the amount that was withdrawn' do
      account.deposit(1000)
      expect(account.withdraw(500)).to eq 500
    end

    context 'when overdraft' do
      it 'raises an error' do
        message = 'Cannot withdraw: not enough money in this account'
        expect { account.withdraw(500) }.to raise_error message
      end
    end
  end

  describe '#statement' do
    it 'starts with empty entries' do
      expect(account.statement).to be_empty
    end

    it 'stores the transaction info' do
      time_now = Time.local(2012, 1, 10)
      Timecop.freeze(time_now)
      account.deposit(1000)
      expect(account.statement).to eq [{date: time_now, amount: 1000, balance: 1000}]
    end
  end
end