Return-Path: <linux-kernel+bounces-70431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A48597A5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41B61F21313
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DAF6D1AF;
	Sun, 18 Feb 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="NEyC/sQF"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A686BB44
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708270503; cv=none; b=lC+68GDpkqcyqPrfGD0/U2mOiILMy2qY3Sc2xSNm0q+xB5KsVvM8VO7+dZ48wVAWbW0PiGUMgS9JyeKbp9LXOYfV4LOGXGUDsSOo99OsV9sqy6PnHOgoh6FubHHbcqWYxOawgq2PCH6TAJB7tgFo0kqFVCXR1u7vZSQYkDbFtxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708270503; c=relaxed/simple;
	bh=F7I2LrOjlEp2qAZiCFZTJ7ZQzHJHlFpK0pNegozALpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDtgPuDfQwSx3PWzi9A/VQZIdUS3H2FBjLC2plWIQnRfsn/HWudMqxC4wS/SdnHCfNyychvkTtXKahUiguUWEkY9auMOD/RrxOeUxlc69L1O2Fp3+kIYcA7RM3Yt/NdWavQUbOSF9u9EkB6AEk2zuBsLWYcVZFqzCExee2SMfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=NEyC/sQF; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708270194;
	bh=4fRSGqhQu6+Ft3OxeuS/RVv3QuBc/38aa5FYMsAwInQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NEyC/sQFF0ixc+ZKeL9A4icuLM++rrtp9M1jqiO0Sk4KQJSxA57DPCs4e0tQRD5nd
	 Wb615ZrZshF8gBtDlLECrZNs0jdDlGFx8l6Zbyu1VUgJKsuNq6bjl8ZCZBj8bmrhN3
	 ITr9yPB7/LR8zMOkBAC+tov26hzX79T2N4auGseY=
Received: from [IPV6:2409:8a60:2a63:47a0:d83a:fd45:cca4:d0ee] ([2409:8a60:2a63:47a0:d83a:fd45:cca4:d0ee])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 41B8DAD0; Sun, 18 Feb 2024 23:16:27 +0800
X-QQ-mid: xmsmtpt1708269387thxny1wqh
Message-ID: <tencent_6EFB821C2775D38F99EBFC6C9F7FAB82A809@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yneRpBbz2MOtsPciZmyzYOjaxvYxN8HR0g0JTUubk0sppxpk5Oa9B
	 xW6uDgg5k5v8ayDO8S/9ajk3yCQZTO3JIxkeZJy7sc2KL69jiLy5jTy73uKgAAT/S9l3YJVj4uC0
	 Jde4XZhT3mEHGxg01LYIXXA7IfEl5YOz7j0UFf1i0dNvA8d92faKM6gFId8oDxHH/v+75nFYbP8B
	 uAPRIz1ndv6B39e4121bJxbm8wtF5DmXzkJZ/nsHcbK0PJT+eDlti8oelkPJe8kC8Lsn0JauEgPI
	 Afk0gXaLvPo+4Dmje828cJ4b8Or5kp16r9X/PIpDXKk1mgrXk3XpUY3xkFXrLXIQdOi0305W2BMy
	 NKgAnOZ6LUjIB+WOg14lBRVFZbPywKQhEg4GcxYLzzNbDkuabqaEwozzY/YDYvgyG46Wt/l5DRhE
	 CN1+SoiBIwUnOL6dKAqa++NH5ptvD0k5gYxIMcz4PmzmzVbOBZZP/s3QxtDCKBLsiVsN/f6LU88i
	 iIyngNfFaoDfRTDYzaFmWUz4TOq474toORkOmuZRuS2GK8vJrNVEQQxPJ+PQrOuheU5yXVEQeFdA
	 ahkkj6D/kGc8+j5yWxn2x+NcroQ53oC5GT+o9TXUivKB24VwnF8y6WFM6/whUEVLx5lg/lfPj9rZ
	 cr8ysK0RmqMz3GnzjbKU+q6PihcRz7qcgUAmlbY0ZwDS/KuW7Swlbu7BIc347424C8/UJMBKAhwa
	 HZ73R7NNK1yEQixWQ8kGSTF1M4dpjOGiNPbZ6kY0uJdzPSSFUlnDvtK1xQe4y6kK33lo/Os02Xmr
	 SagCKUU+ZlKPZWzM7fzysPdH07GWcL9BgRzOBIAoDbYOUGt8q+DPYptBN3fVazwZ1qJTnRA51g0d
	 d8RTDN8N5SqEAHhzrFCRwXgOuSJ6CLAiP+6Rx1OPM0ebCoisy9AIl4YJneq0TkMcHP5zROrku2kx
	 szjoy3sH1GO37nTXVncvZ0ylV+Rd6OM3iL8n0UTNV0YFGmNBFPBasLufnRS9yJ
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-OQ-MSGID: <c0276e4b-2f30-0c51-99d9-4e3c3359533d@foxmail.com>
Date: Sun, 18 Feb 2024 23:16:27 +0800
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
To: Oleg Nesterov <oleg@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
 <20240217104924.GB10393@redhat.com>
Content-Language: en-US
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20240217104924.GB10393@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/2/17 18:49, Oleg Nesterov wrote:
> On 02/17, wenyang.linux@foxmail.com wrote:
>> From: Wen Yang <wenyang.linux@foxmail.com>
>>
>> Currently coredump_task_exit() takes some time to wait for the generation
>> of the dump file. But if the user-space wants to receive a notification
>> as soon as possible it maybe inconvenient.
>>
>> Add the new trace_sched_process_coredump() into coredump_task_exit(),
>> this way a user-space monitor could easily wait for the exits and
>> potentially make some preparations in advance.
> Can't comment, I never know when the new tracepoint will make sense.
>
> Stupid question.
> Oleg.

Thanks for your help.

trace_sched_process_exit() is located after the PF_EXITING flag is set,
so it could not be moved to there.
Could we make the following modifications?

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index dbb01b4b7451..53e9420540dc 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -334,6 +334,13 @@ DEFINE_EVENT(sched_process_template, 
sched_process_exit,
              TP_PROTO(struct task_struct *p),
              TP_ARGS(p));

+/*
+ * Tracepoint for killing a task by a signal:
+ */
+DEFINE_EVENT(sched_process_template, sched_process_kill,
+            TP_PROTO(struct task_struct *p),
+            TP_ARGS(p));
+
  /*
   * Tracepoint for waiting on task to unschedule:
   */
diff --git a/kernel/signal.c b/kernel/signal.c
index 9b40109f0c56..571342799824 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2866,6 +2866,7 @@ bool get_signal(struct ksignal *ksig)
                  * Anything else is fatal, maybe with a core dump.
                  */
                 current->flags |= PF_SIGNALED;
+               trace_sched_process_kill(current);

                 if (sig_kernel_coredump(signr)) {
                         if (print_fatal_signals)

--

Best wishes,

Wen


>
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
>>   include/trace/events/sched.h | 7 +++++++
>>   kernel/exit.c                | 1 +
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
>> index dbb01b4b7451..ce7448065986 100644
>> --- a/include/trace/events/sched.h
>> +++ b/include/trace/events/sched.h
>> @@ -334,6 +334,13 @@ DEFINE_EVENT(sched_process_template, sched_process_exit,
>>   	     TP_PROTO(struct task_struct *p),
>>   	     TP_ARGS(p));
>>
>> +/*
>> + * Tracepoint for a task coredumping:
>> + */
>> +DEFINE_EVENT(sched_process_template, sched_process_coredump,
>> +	     TP_PROTO(struct task_struct *p),
>> +	     TP_ARGS(p));
>> +
>>   /*
>>    * Tracepoint for waiting on task to unschedule:
>>    */
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index 493647fd7c07..c11e12d73f4e 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -425,6 +425,7 @@ static void coredump_task_exit(struct task_struct *tsk)
>>   			self.next = xchg(&core_state->dumper.next, &self);
>>   		else
>>   			self.task = NULL;
>> +		trace_sched_process_coredump(tsk);
>>   		/*
>>   		 * Implies mb(), the result of xchg() must be visible
>>   		 * to core_state->dumper.
>> --
>> 2.25.1
>>


