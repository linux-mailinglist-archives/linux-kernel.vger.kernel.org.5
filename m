Return-Path: <linux-kernel+bounces-92575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C16872267
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C776E1F23E18
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C27A1272B2;
	Tue,  5 Mar 2024 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="WqBIfNBC"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95781272CF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651130; cv=none; b=dr+WxLD3uizz3Sw/3fI/TaNd5NC/mSPIuhA1fg5TqdvsLcEi/grj5K4k3Q4fLCa3rZ5GqWytTRsBI0+HxyDFS7E4cdYmuBMKThzD6Xqyb5VMDm+NK+ydcCVNkCmYSwNRFsHpTjRxHhh/RHEKsV613LnO2cnz1hYCfuv+kBybJBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651130; c=relaxed/simple;
	bh=TynlGi2O2X9ZJu35GOBWTCAwbupHPeb1UedUN/h08HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqoXGEAmdWDECLfnZjSMU2POK2PWpnn4XwwlPLCxeLNLWlvjjTSg5teYt0qDBWNawYPCRqQvMd1aJd51KCb7SAFTFz1Tp2RKxMobFoQYtuR/9JhT5USdhpyvu9DJD6KJcoDkCORx7G0JaY9EH98yR+NgzLfZDIOhDJQcC1nQ5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=WqBIfNBC; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709651114;
	bh=JeeRcaxPLQbzizSTFNZrfXDOVnIrtfwlif9prYEunhk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WqBIfNBC4ESRBeToKQ51UnniIEsX25mJe4tNz00hqnNnRVMT9nxt074/nTXI8YcHN
	 OMWVBiSw8NtW9e8SujFTiuCfT2eew8Jue01VtmgpM4XHD37IKursyvQgDIDL4lvstl
	 42fpHgEKK0PHedRnwA6sunJr2+j5zn3mczEAscKw=
Received: from [IPV6:2409:8a60:2a60:3eb0:b7e8:6096:c47e:5603] ([2409:8a60:2a60:3eb0:b7e8:6096:c47e:5603])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id EAF05A48; Tue, 05 Mar 2024 22:58:47 +0800
X-QQ-mid: xmsmtpt1709650727tqhalpor6
Message-ID: <tencent_A3F43166353FC8679F2A05EA9E20A549A107@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9rPcsJdS8kI76gzktG8a19kIzehvNWuyuEFwbFROSShXRv7nH0H
	 zrfnbOjHzTsFbLAGOC9mu7kMMu9gYOn8e1IJmHhqsgGdx02fSWU6qht57ooSTTpaVoed8E08qAcL
	 WzM9fgL0RMLVNEwqB/YhEFmRZXiZil3b4DbHpWik/iQNilsj/MSumQBV283u3IHjXMFxb5VFwK2g
	 TAFb9K0CtCtTG7H+XcMp28HkQP03zlfTW09vLdlt32RfretcKmYKYuudgt2ccz/TrzpEKZcTFwMT
	 gVGeNaOX5SDewz9M4gBBgVq2EudMwtlb4HshRGG1k/TI24qZRHJ/iGLb8MRJSOIrfobe0qw0mAfj
	 VS6HiaKoI2DbmN1aY0+MmXcaqyUdSaRZBRo7atQP+8WBeEZ03szBqKZHTghwNH2k47NnMjtt6Rq3
	 /SKsbOQcOoBWZ5Cl+D6WHx2OLmBdjE+F88FRrlg1eFpMoWZT2u++x/8g++mtjtPgte9qyN7nUSeK
	 YZaV79EqAd5/J1f7eWR4toku1b6cz+yQ5071PLxWmvPjAl2leYKEVWXpE2JStRyjdkhXjTKi6Jz/
	 7uJ+V3FepqRH1fXsi6/rJoTHmWF9wGLQjIdNkGzLAZHkqDzfRdcts8nCpjm6z7uVGyPqMJEf/9AK
	 cEgI6HfChyUPJb/ggzfrHbjBoHZxkeVItvZJIbHxSCDTok8KyqMU3S2IjsAk/PMforAsxHxO2PT8
	 pJrscfmz4a1QUctelBXV9z9ob+EZitaGKBbwned9UipXfw2k57v2q2OvA7LUx1+OwOEkrhltlTbA
	 Hq/rMsDeXdlf3/U02kjr0AwEJ7Kwv4wEX6LO0y+HNLi+bj+PFgwTvuGkw2BCfkTll4ATFTOa06Jy
	 aT6dP2/n/fTptIVCix4dDQPbPWKLpG09M0izMgpukQigYCTtLqsYrsl5/Wk1KgXGIVZyZpNuWH59
	 FAhU6A7iOPcO8sZIkg1fTLUQ8qeZFlXzeyWfQt3ME9t39kmYTm7XyO/TX6/lBF7M4ATvzWqz8vGi
	 sC8VX6IlsIBTIDCLbQZGNux9gPoII=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <bc21fdad-3e7f-2bf0-a3c1-b86ac52737e0@foxmail.com>
Date: Tue, 5 Mar 2024 22:58:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] exit: add exit_code to trace_sched_process_exit and
 move it earlier in do_exit()
To: Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <tencent_20932DE952CC4B7E12CF2E5530D45641BF08@qq.com>
 <20240226194434.GC9510@redhat.com>
Content-Language: en-US
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20240226194434.GC9510@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/27 03:44, Oleg Nesterov wrote:
> Well. since I have already participated in the previous discussions...
> 
> As I said, I can't ack this (user-visible) patch even if I tried to
> suggest this from the very beginning, I leave it to the maintainers.
> 
> I see nothing wrong in this change, but let me ask: do we really need
> to report the exit code? this makes this patch even more user-visible
> and I have no idea if it can break the current users.
> 


Sorry, I forgot to add a "Suggested by".

The original purpose of reporting the exit code here is to facilitate 
users in obtaining signals that cause the process to exit.

We will make modifications according to your comments and do not report 
the exit code, as the kernel module can also obtain signals and only 
requires a trace point.



--
Best wishes,
Wen


> On 02/23, wenyang.linux@foxmail.com wrote:
>>
>> From: Wen Yang <wenyang.linux@foxmail.com>
>>
>> Currently coredump_task_exit() takes some time to wait for the generation
>> of the dump file. But if the user-space wants to receive a notification
>> as soon as possible it maybe inconvenient.
>>
>> Add exit_code to the TP trace_sched_process_exit() and move it earlier in
>> do_exit(). This way a user-space monitor could detect the exits and
>> potentially make some preparations in advance.
>>
>> : Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   include/trace/events/sched.h | 28 +++++++++++++++++++++++++---
>>   kernel/exit.c                |  2 +-
>>   2 files changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
>> index dbb01b4b7451..c2e8655fd453 100644
>> --- a/include/trace/events/sched.h
>> +++ b/include/trace/events/sched.h
>> @@ -330,9 +330,31 @@ DEFINE_EVENT(sched_process_template, sched_process_free,
>>   /*
>>    * Tracepoint for a task exiting:
>>    */
>> -DEFINE_EVENT(sched_process_template, sched_process_exit,
>> -	     TP_PROTO(struct task_struct *p),
>> -	     TP_ARGS(p));
>> +TRACE_EVENT(sched_process_exit,
>> +
>> +	TP_PROTO(struct task_struct *task, long code),
>> +
>> +	TP_ARGS(task, code),
>> +
>> +	TP_STRUCT__entry(
>> +		__array(	char,	comm,	TASK_COMM_LEN	)
>> +		__field(	pid_t,	pid			)
>> +		__field(	int,	prio			)
>> +		__field(	long,	code			)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
>> +		__entry->pid		= task->pid;
>> +		__entry->prio		= task->prio;
>> +		__entry->code		= code;
>> +	),
>> +
>> +	TP_printk("comm=%s pid=%d prio=%d exit_code=0x%lx",
>> +		  __entry->comm, __entry->pid, __entry->prio,
>> +		  __entry->code)
>> +);
>> +
>>   
>>   /*
>>    * Tracepoint for waiting on task to unschedule:
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index 493647fd7c07..48b6ed7f7760 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -826,6 +826,7 @@ void __noreturn do_exit(long code)
>>   
>>   	WARN_ON(tsk->plug);
>>   
>> +	trace_sched_process_exit(tsk, code);
>>   	kcov_task_exit(tsk);
>>   	kmsan_task_exit(tsk);
>>   
>> @@ -866,7 +867,6 @@ void __noreturn do_exit(long code)
>>   
>>   	if (group_dead)
>>   		acct_process();
>> -	trace_sched_process_exit(tsk);
>>   
>>   	exit_sem(tsk);
>>   	exit_shm(tsk);
>> -- 
>> 2.25.1
>>
> 


