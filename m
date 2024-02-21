Return-Path: <linux-kernel+bounces-75027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D3385E1E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5F31C23FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3C880BFE;
	Wed, 21 Feb 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="cs78EL+o"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B36C8002D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530671; cv=none; b=do9CsasExLYKxwliqMxfZvk35JQnvadsAGqGdRjQiWmpWBtNK5Mp55eaY7VN5ZQhuOwku3H1SPQ73v80oQGHIUsz+acKy/MNTKMl3pbLIrobIIThn0zZL04MgO4ehLxNY0gg7ySLg5Tvskz6S2bjAwmWG95JI8a08wf3PIsR6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530671; c=relaxed/simple;
	bh=vEoM1UN5fw8alEuNhj3NG53aylvxNxq2uZ8DS3N6ANs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpX+9mRm1Wq9gs9S99JzaG44rWiWhVQRc6Tw1u3ax1Q8rIJQ5QkxDZDoT5qmo+O12ikKOT8x5XqSbTMRrJJ8e98JpeLo7motHou1ndv7uD1X9ipd3c5kf8I/b4ueuG8Wie39hbt3eJz1MXmwFXum2u+LuKUNa5ESQc2IhPE0Tsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=cs78EL+o; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708530361;
	bh=sKtJeLMhCOAL5wfw/Z58CF7RfJkhujGF5xFaWZx4CKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cs78EL+omCfN77vdA7iQ0DmgMkqzk+ng8QqI/XfrB+sGosDYvZpZQzphlMiR0/+Qx
	 vZylD/RJkwdn5hBbNymT/eckZsA2pkoBnjsezqk2ljlRm3gWt6gu9pDVu6Pic0VI8l
	 CXT79mLmnYw66qkZE1I7C8O/h6TlTvOeE7ynv+A8=
Received: from [IPV6:2409:8a60:2a61:ef40:1517:f202:3311:4bf] ([2409:8a60:2a61:ef40:1517:f202:3311:4bf])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id B7AAB49D; Wed, 21 Feb 2024 23:45:58 +0800
X-QQ-mid: xmsmtpt1708530358t3pny71lz
Message-ID: <tencent_649330BFF9D93CB7540D508B05514FCEA40A@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJoGk7u5nYniAJ4Up/dNZVH2qBLkC6pDqrKaGd1/G1th+DGipfTH
	 e9oOUXIULI29mRd7NpqutYBOpRckNLhxdLJfKvaRIBjslO/xHp7VT8GBonIT9WXdvoGERq/YfH12
	 Wxb1XLcoTPIoTJaqpRDBpqiD1yq8ruckc8V3F034BtD515leRQZReOECXCjI4/2j8s1+7dIr84ZH
	 UlIQaEnm1D/E7svyKzgRpavbXYB+XHZVmW2LWCTJWX9BbEHzn3tqCGr0nB9BRUrs6Ab4CNw3BEPe
	 EEDRxaf1c7PBwIpRf2R8Slvb/8saHDUljrRdhIfOzffyUAtqHkmsYfsf3Tk7VMcK/iRnLX0oTt8a
	 4OI37Z1OnG2pRDQcqIX3DFEUkjetGIrR+muujne3tp45wN+2i9lsfowzqL5NRt3vsBbHAsIzKlVe
	 uy+bQfN6ap+4jRczQm9Y46qr1fqzEFcO3TpJk9QP+eUFgexbPyZ5he9xiaJJo/+eDIrAlkUpO9XE
	 7mdcxcKQqu1ll/1MTY/uce+fvaRAVcnw5lqbS3utln8nWFSahyUyp7LFsrFekxSG+mZBpXfSgxCH
	 YIQykuodOEkRWNmGhP6WTL1HsUkvAMNCDvY3ViBJLy8GEuKN7X735Z/e5CG3+C+9hWEZTAqVex7b
	 aU3je6jhzTwca2duzRHxyFaGbcfCIdPKtnSJtn9FXaqpUc2ziuQksK/hNjRQ+hudPgzr9U/8pZWH
	 GdIkKK0WJ83Eskl3/+31FgmAEZ2s8ynMAQ6Lcobad31Rxnxq55IScrL7iIe8aWOrZunuVsSokJ2S
	 sYIIyvBKldYu9GvYRvFIYf3+fV0VHNrqIf02/0r1HbA9aXbqnWlwEp8tgM/uI/l9eRIxHk6+pIRw
	 N+JPeSUHgIWWneNSHFkrQ1aNM1odJtfwtPLlfMBMZWKadTrLQeYLEGv6b7O3yRUwBQfMFi6D2Wgt
	 bk44eovs7zgVXM1oUTzL6J1kLF82IupcRgVY6eI8tYP9zDEG5ljaGu0GFj/4zX5kEKMyYdjd00Rw
	 I2q9vYYUxeNgXmcJr0WzmpK2qoCsY=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <5167001c-a318-addd-2470-80376b5096df@foxmail.com>
Date: Wed, 21 Feb 2024 23:45:58 +0800
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
To: Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
 <20240217104924.GB10393@redhat.com>
 <20240219112926.77ac16f8@gandalf.local.home>
 <20240219170038.GA710@redhat.com>
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20240219170038.GA710@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/20 01:00, Oleg Nesterov wrote:
> On 02/19, Steven Rostedt wrote:
>>
>> On Sat, 17 Feb 2024 11:49:24 +0100
>> Oleg Nesterov <oleg@redhat.com> wrote:
>>
>>> On 02/17, wenyang.linux@foxmail.com wrote:
>>>>
>>>> From: Wen Yang <wenyang.linux@foxmail.com>
>>>>
>>>> Currently coredump_task_exit() takes some time to wait for the generation
>>>> of the dump file. But if the user-space wants to receive a notification
>>>> as soon as possible it maybe inconvenient.
>>>>
>>>> Add the new trace_sched_process_coredump() into coredump_task_exit(),
>>>> this way a user-space monitor could easily wait for the exits and
>>>> potentially make some preparations in advance.
>>>
>>> Can't comment, I never know when the new tracepoint will make sense.
>>>
>>> Stupid question. Can we simply shift trace_sched_process_exit() up
>>> before coredump_task_exit() ?
>>
>> Reading the rest of the thread and looking at the code, we do have this:
>>
>> void __noreturn do_exit(long code)
>> {
>> 	struct task_struct *tsk = current;
>> 	int group_dead;
>>
>> [...]
>> 	acct_collect(code, group_dead);
>> 	if (group_dead)
>> 		tty_audit_exit();
>> 	audit_free(tsk);
>>
>> 	tsk->exit_code = code;
>> 	taskstats_exit(tsk, group_dead);
>>
>> 	exit_mm();
>>
>> 	if (group_dead)
>> 		acct_process();
>> 	trace_sched_process_exit(tsk);
>>
>> There's a lot that happens before we trigger the above event.
> 
> and a lot after.
> 
> To me the current placement of  looks absolutely
> random.
> 
>> I could
>> imagine that there are users expecting those actions to have taken place by
>> the time the event triggered. Like the "exit_mm()" call, as well as many
>> others.
>>
>> I would be leery of moving that tracepoint.
> 
> And I agree. I am always scared of every user-visible change, simply
> because it is user-visbible.
> 
> If it was not clear, I didn't try to nack this patch. I simply do not know
> how people use the tracepoints and for what. Apart from debugging.
> 
> But if we add the new one into coredump_task_exit(), then we probably want
> another one in ptrace_event(PTRACE_EVENT_EXIT) ? It too can "take some time"
> before the exiting task actually exits.
> 
> So I think this needs some discussion, and the changelog should probably say
> more.
> 
> In short: I am glad you are here, I leave this to you and Wen ;)
> 

Thank you Oleg, thank you Steven，

We could first put trace_sched_process_exit() aside and take a look at 
these three patches:

2d4bcf886e42f0f4846a3d9bdc3a90d278903a2e ("exit: Remove 
profile_task_exit & profile_munmap")

586b58cac8b4683eb58a1446fbc399de18974e40 (“exit: Move preemption fixup 
up, move blocking operations down”)

And the original: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2


Could we add a new TP similar to profile_task_exit()?

--
Best wishes,
Wen






