Return-Path: <linux-kernel+bounces-77780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B5C860A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989B51C231EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3042611716;
	Fri, 23 Feb 2024 05:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="bNtK8dMH"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2711714
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708665481; cv=none; b=A7V/fQfY7WB2WvXDTvUbeds3f6rl9uVzLxTHS0XCqJWuAdtFnBdhwjbkk1uWVe2hX+IvyF7EAE3sIociFZQX78y7lM6lEG6XZeuZCyJRs2J5ikJFLtEgDOpDC7zQXb5RYakeYU6iUf/pAd7xKNcoqXwpYB3OGUSpuI/IY2WQLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708665481; c=relaxed/simple;
	bh=X/W5DwQO7kT7FYswAnD6pfP/r7ijSZmYe1K+mAC1F3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLDrczYW7JrM2v8bZr2pyLV1iRkuCcD+Jp1hsng55bTbwLzVPx46d3vCji3XoTz9cECGZQDKUQN6pN1lJ0xy+sx0k5c1X0GlTxVLADUtvWI+NbFZgDECSgcm1M/QlezB7QL7v66v8zEw73F8bHqqsYhv/nRzndVgo/dT9z2VyOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=bNtK8dMH; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708665474;
	bh=7BRUNUShwwd1gbD7m9jCq76qqkjH47dO+405L2MFVRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bNtK8dMHNaXcKCTyoO7tQhbCTNJyzuSHUkjYup3CG4erhViR/Y6RJOUqMvxCtnPZR
	 dxwBo1fn+8CcaX6kIp74+/rpT5Ekj5Ah/v0bLFFwxTFvzWVgQwpCmgWPfOiB2sM0S5
	 3lOvwRiexXE+6ChQ2Hax0E+NYJVDfEtPW62dbHnE=
Received: from [IPV6:2409:8961:2a00:95cb:ea24:ca0f:4466:39d5] ([2409:8961:2a00:95cb:ea24:ca0f:4466:39d5])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 4731E03F; Fri, 23 Feb 2024 13:17:51 +0800
X-QQ-mid: xmsmtpt1708665471ta754ocoi
Message-ID: <tencent_92BA1C33B05FC533465532B55650E4645106@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2nQUV7WtK8TK7JidjFHCKiemiGG1RIe+Sce/bIdazkayQW/jwVt
	 0esl/eyHmqiuP9zpuflDaPwEeEVtqHDvLHjyefZiNAeVy53ZhaYqA2P/FEWRjQSBa2/iPZrM1ffY
	 pJq3uUMG82q899oZtEWtGbarmLgXcKT1vf0Fh+vNCPHegm17mRw4VGuffXNMuwanHDes70Fxu+ZF
	 9P6h/3elX3h4CAdXHuZL0N6plFOsVn0BlXejPbkFq7PMegOMDjByRfXq08Lo/ymmO5/gsCxvNpEJ
	 tuWvAFcArQg506f4qBb6s+DLglc2YDDve2j1BMl/RGIosqhGI90lt3WK47iwrtA6UITrvPe8+0NB
	 F0L40+BbARcMRD7Zz+bUvUaZDtQyXQWg9X8XRYrJRtraIWZvGfPXsIx5dZxXnRJVP+UStXYM/8L0
	 MQh7b8SCGju1iasYL87rAgGeCSAAq2yoMWRkn9I1yc1JRk9dkpcqi7KHkUrflLFSwfrPnzGfPz0T
	 JAtg8LK2uu7SPZ62P7Pdj/hTnXCE82ldu3cE6Wpx3OuJRq/0AwIO/yW51tU3B+Pqg2ySoZWNRf7a
	 +jHd5whRLc796u59oGF79Abr9lqzTOI7g+ZujBw9gznMBogP6u/sOwc0umXzs9luiXKRMElRsazJ
	 7H3YTT6DdScJlWqKhfEecn2etI7JLjGk7ar0ib9GcUcbHsys8F4yEYahLfShk/pGByGkXy3ELy+g
	 VuBrNBwwfzt+wjTVcG04fgSxeu9NqfWhi+HqPT307nI6P498GQsZ8yxF4aQOp6w9khfJ5IiPhcNq
	 ovwE/dCjfW8NynyowNQR4Km4VQQJYqkDafUsEeAVEEXP4FXSO6tM7I4OeNqOV20//7N7qXSDvA4w
	 r6nEkS7shmsA5/uJtvwcnfkInMkT/Z8y/sEf94Kv2TBWwvWdx8nMIUbOpBFuwldCgIaxRP9mfP5O
	 FeFghsVoPZwF43YuzJHWGUIVHE5535HKCMkxYHuNU3jNZlYbethyjr08wzPStARaKD559KbtjF75
	 ZjVTA8CENmv5cEWMJtmUnhVK5ovpttSaFhEfjzXu87hTB6eB+k
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <acaf7b2f-c510-49be-fdb8-ca540af445f8@foxmail.com>
Date: Fri, 23 Feb 2024 13:17:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] exit: add a tracepoint for profiling a task that is
 starting to exit
Content-Language: en-US
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Mel Gorman
 <mgorman@techsingularity.net>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org
References: <tencent_09CF49556CD442411A93D0E92ACC2B7E5D08@qq.com>
 <c411eda5-5378-4511-bea3-d1566174c8c7@efficios.com>
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <c411eda5-5378-4511-bea3-d1566174c8c7@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/23 00:25, Mathieu Desnoyers wrote:
> On 2024-02-22 11:04, wenyang.linux@foxmail.com wrote:
>> From: Wen Yang <wenyang.linux@foxmail.com>
>>
>> Currently coredump_task_exit() takes some time to wait for the generation
>> of the dump file. But if the user-space wants to receive a notification
>> as soon as possible it maybe inconvenient.
>>
>> Commit 2d4bcf886e42 ("exit: Remove profile_task_exit & profile_munmap")
>> simplified the code, but also removed profile_task_exit(), which may
>> prevent third-party kernel modules from detecting process exits timely.
>>
>> Add the new trace_sched_profile_task_exit() this way a user-space monitor
>> could detect the exits and potentially make some preparations in advance.
> 
> I don't see any explanation justifying adding an extra tracepoint
> rather than just moving trace_sched_process_exit() earlier in do_exit().
> 
> Why is moving trace_sched_process_exit() earlier in do_exit() an issue,
> considering that any tracer interested in knowing the point where a task
> is really reclaimed (from zombie state) is trace_sched_process_free()
> called from delayed_put_task_struct() ?
> 
> Thanks,
> 
> Mathieu
> 

Thanks.
We will make the modifications according to your suggestions.

--
Best wishes,
Wen

>>
>> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   include/trace/events/sched.h | 28 ++++++++++++++++++++++++++++
>>   kernel/exit.c                |  1 +
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
>> index dbb01b4b7451..750b2f0bdf69 100644
>> --- a/include/trace/events/sched.h
>> +++ b/include/trace/events/sched.h
>> @@ -341,6 +341,34 @@ DEFINE_EVENT(sched_process_template, 
>> sched_wait_task,
>>       TP_PROTO(struct task_struct *p),
>>       TP_ARGS(p));
>> +/*
>> + * Tracepoint for profiling a task that is starting to exit:
>> + */
>> +TRACE_EVENT(sched_profile_task_exit,
>> +
>> +    TP_PROTO(struct task_struct *task, long code),
>> +
>> +    TP_ARGS(task, code),
>> +
>> +    TP_STRUCT__entry(
>> +        __array(    char,    comm,    TASK_COMM_LEN    )
>> +        __field(    pid_t,    pid            )
>> +        __field(    int,    prio            )
>> +        __field(    long,    code            )
>> +    ),
>> +
>> +    TP_fast_assign(
>> +        memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
>> +        __entry->pid        = task->pid;
>> +        __entry->prio        = task->prio;
>> +        __entry->code        = code;
>> +    ),
>> +
>> +    TP_printk("comm=%s pid=%d prio=%d exit_code=0x%lx",
>> +          __entry->comm, __entry->pid, __entry->prio,
>> +          __entry->code)
>> +);
>> +
>>   /*
>>    * Tracepoint for a waiting task:
>>    */
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index 493647fd7c07..f675f879a1b2 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -826,6 +826,7 @@ void __noreturn do_exit(long code)
>>       WARN_ON(tsk->plug);
>> +    trace_sched_profile_task_exit(tsk, code);
>>       kcov_task_exit(tsk);
>>       kmsan_task_exit(tsk);
> 


