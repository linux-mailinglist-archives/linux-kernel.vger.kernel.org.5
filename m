Return-Path: <linux-kernel+bounces-75080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F0E85E2AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0557E1C2319E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF03381748;
	Wed, 21 Feb 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="x63z3L9w"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0560181740
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532053; cv=none; b=giqWL4rUEyxEVUYwTBT0mmXRE6+DfHDThXHkZ1ZdLKHkEN/8LlJQ7nf/2KcMNsYVxAAELGdcs9FdqR9kC4uTJL8ZjfdkYb7h3OArOqeZi6drUGWZB6ilzawqNBls9tfGJLT5r+X2xg0HMkcCSfaIGCfPW3h9GuV/iS5GIwUBvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532053; c=relaxed/simple;
	bh=o30YxW+0vC5nhH8nIdtk++JEI6g7NEVrxqIYs8Uhm8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9bjBOJ6fZSUjYInqnEq4bBtdOJHAS1d/fGcKhvieCkyNkrRUI6e6uQxNiCk6GvG6FggCXCOvMGwn4XOdx0505xEVNUwj4GoxfHfIYWCLj7IJNroDm9tmYZd6G9Wos3Tu6zP0Chpx6jv+DPQ6WT8HHLWn8GLhIIFnx4/B+rArhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=x63z3L9w; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708532049;
	bh=lo2sqSQSOVhDGBNAF0F7wDJW1xK+XfdFElPtmyue/5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=x63z3L9w2DN8D/HPnTxgVpQRPtqusX4WvK8AuJZVfZED71Vapi9fApu1oYDWioP2a
	 51hg/StRPIIzrLyg80DVhuBkVB1pBVW8Z1ocp7CEDkRdtwRo1uDPr3hqBvdZVS/Cp3
	 S8TR7uUaTWeyXtNJVXLh7AbKm7+e4Sgg2CX1E6SM=
Received: from [IPV6:2409:8a60:2a61:ef40:13de:49e4:e117:4535] ([2409:8a60:2a61:ef40:13de:49e4:e117:4535])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 3733CE9; Thu, 22 Feb 2024 00:00:55 +0800
X-QQ-mid: xmsmtpt1708531255tcqq3g14c
Message-ID: <tencent_842730EBF8FD3CA3564D50CF04654D52A40A@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeie/LinN1MEGkxd71++CII6n4zoODpFSn1bXWkn6ir62udQUnGbba
	 YtaxOKUQjqdNDNQPxv0MW0xxsoQQWEPCgqlRp7NpP5t5Pu42lVg0FOcQpZxSE9D3rWJFiAyLdx1E
	 Y8Y7FUSBys2vp7BWGWQqky8ZuONy8QQAcWefF5Lk7NG00A66BFQNwIXlx/a7Eop4SfMiNtuR4BjH
	 HkQt2MXKUtLEC2fyWtBBD1QIQVefghrQaIeyM1/ClYYKIy80nIaV/7tpTRWZRnxtLI0BiT90+MBD
	 QZm9tUSZQc02fo/DTx/LA88l1FUiC0B3DkzvWj8ISCN+FqnmzyytLFMRVhatu3UtNjdb4g+RU5h3
	 iNpmLDpMtSISF9XBqTJQqBL5BEVPDxc95+miBhtaABqdVObKB06sz8/hOv2FNmCWRxmOa2+xhypX
	 /6zoDk1zv91ZIeb+A3xtwCZVcHurb50MB4ORFqxKu583vWxnlu8dh0cGNGgj0B1hwam+SO9+7Z3E
	 y4K+eRtRZKEIhZBXyQaV4DqmWnMwhXUFwVf+7vCMKVW90ZzeWw1dbQ/9lLYhfD5+ykh6eddED5dH
	 rye3ZdDafU0VDh0a14sOnmEGy5GcxIAPKaNWx43Rs55KDXEikzmliCrtS9P6ksbUAyhzNxnQXvtI
	 DZ4E+9C63IBTskyWhWvhzWgLXLQ6gWltXNo/oFFJLOoQze8aKb3w45/G78Yl7/Zd0RT6jDB0B8TF
	 JR9QYweT/AWqJy0xT8y7JOVvcDbuhc+nitsE3bx6MOFCC5fEW/EWsYilHoKNF/FYFIUUExJHaG2y
	 2U0+k7JCovaCvGRn/RVYM0iNo0n6oZq9sdEY/dZgRA99YMJCWOpgwGnmmcWPXb50GafOf0FIn7Bh
	 yT4WADLa6WZiRM7Gx6jqY3vNLTAbzURGtDFWS6BqL2qSu1BE4Guua82S8mDbSgjEHEGGj5tlBir+
	 6IT8FhOdtOhdhaYQQlKfwrxWLOAfeU
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <cb147ab8-fd24-2680-2a6a-9cdfb3ae48e8@foxmail.com>
Date: Thu, 22 Feb 2024 00:00:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] coredump debugging: add a tracepoint to report the
 coredumping
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
 <20240217104924.GB10393@redhat.com>
 <20240219112926.77ac16f8@gandalf.local.home>
 <20240219170038.GA710@redhat.com>
 <20240219122825.31579a1e@gandalf.local.home>
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20240219122825.31579a1e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/20 01:28, Steven Rostedt wrote:
> On Mon, 19 Feb 2024 18:00:38 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
> 
>>> void __noreturn do_exit(long code)
>>> {
>>> 	struct task_struct *tsk = current;
>>> 	int group_dead;
>>>
>>> [...]
>>> 	acct_collect(code, group_dead);
>>> 	if (group_dead)
>>> 		tty_audit_exit();
>>> 	audit_free(tsk);
>>>
>>> 	tsk->exit_code = code;
>>> 	taskstats_exit(tsk, group_dead);
>>>
>>> 	exit_mm();
>>>
>>> 	if (group_dead)
>>> 		acct_process();
>>> 	trace_sched_process_exit(tsk);
>>>
>>> There's a lot that happens before we trigger the above event.
>>
>> and a lot after.
> 
> True. There really isn't a meaningful location here is there?
> 
> I actually use this tracepoint in my pid tracing.
> 
> The set_ftrace_pid and set_event_pid from /sys/kernel/tracing will add and
> remove PIDs if the options function-fork or event-fork are set respectively.
> 
> I hook to the sched_process_fork tracepoint to add new PIDs if the parent
> pid is already in one of the files, and remove a PID via the
> sched_process_exit function.
> 
> Honestly, if anything, it should probably be moved down right next to
> () (I never understood why  needed its own hooks
> and not just use tracepoints).
> 

Perhaps it's just because perf appeared earlier, and it doesn't rely on 
TRACEPOINTS.
It is indeed reasonable to replace perf_event_exit_task() with 
TRACEPOINT, and we are willing to try to modify it. It will require some 
work and time.

--
Best wishes,
Wen

>>
>> To me the current placement of trace_sched_process_exit() looks absolutely
>> random.
> 
> Agreed.
> 
>>
>>> I could
>>> imagine that there are users expecting those actions to have taken place by
>>> the time the event triggered. Like the "exit_mm()" call, as well as many
>>> others.
>>>
>>> I would be leery of moving that tracepoint.
>>
>> And I agree. I am always scared of every user-visible change, simply
>> because it is user-visbible.
>>
>> If it was not clear, I didn't try to nack this patch. I simply do not know
>> how people use the tracepoints and for what. Apart from debugging.
>>
>> But if we add the new one into coredump_task_exit(), then we probably want
>> another one in ptrace_event(PTRACE_EVENT_EXIT) ? It too can "take some time"
>> before the exiting task actually exits.
>>
>> So I think this needs some discussion, and the changelog should probably say
>> more.
>>
>> In short: I am glad you are here, I leave this to you and Wen ;)
> 
> I still would like to have your input too ;-)
> 
> -- Steve


