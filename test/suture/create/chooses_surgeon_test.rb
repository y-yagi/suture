require "suture/create/chooses_surgeon"

module Suture
  class ChoosesSurgeonTest < UnitTest
    def setup
      super
      @subject = ChoosesSurgeon.new
    end

    def test_no_op
      plan = Value::Plan.new

      result = @subject.choose(plan)

      assert_kind_of Surgeon::NoOp, result
    end

    def test_record_calls
      plan = Value::Plan.new(:record_calls => true)

      result = @subject.choose(plan)

      assert_kind_of Surgeon::Observer, result
    end

    def test_call_both
      plan = Value::Plan.new(:call_both => true)

      result = @subject.choose(plan)

      assert_kind_of Surgeon::Auditor, result
    end

    def test_fallback_on_error
      plan = Value::Plan.new(:fallback_on_error => true)

      result = @subject.choose(plan)

      assert_kind_of Surgeon::Remediator, result
    end

    def test_disable_flag
      plan = Value::Plan.new(:disable => true, :fallback_on_error => true)

      result = @subject.choose(plan)

      assert_kind_of Surgeon::NoOp, result
    end
  end
end
