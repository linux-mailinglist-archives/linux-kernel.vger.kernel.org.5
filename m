Return-Path: <linux-kernel+bounces-112396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656B887946
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4151C20CDD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829BF42045;
	Sat, 23 Mar 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="hONCOWa2"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48410A0C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711208370; cv=none; b=ByPRJqPGJH9RDxQNY6+meCNioax31XmJ7NLa9/Y7aS5kFPxuezeWXvrk/83Rvt0kPIxVKkbAdFEG7BFxZhQIZhjqEpI/csUgxXK/XQyJu4aKNFGTiGj18SzScO9rr29AayGY8vaDW82sCClAOBmix91aERhIPqu5lRgC+Dv4/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711208370; c=relaxed/simple;
	bh=X5drTCGVnFNvYsWmKRrpMurp8YrmWqPIXfCQR0Sss14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2R3U77VpQhFbc9EnbW+biNkXK4Kdl+Two46jNKpGBemRR/jmyF6Hln5m1hwb9P7iHuZZ+2vnNSVFCkKqxzpYCH/FYKIhz480rs0wrjYpejGSfWZDcCGj3muBQ9CyV65FRS+hrBJR1f0SdlFtqm5X3TQGu0SsrQ71tgkUvcyOo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=hONCOWa2; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1711208358;
	bh=Lonx8elIV9uUpMEDFAlZA3gic+/1fWuNBvPxLbnanGo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hONCOWa2ziQfnvMdDb3KVFFPzx+7Ov9GBlCkG1yaJy7mH8F7wDokHf37xZNWzTVCj
	 YG5mA8CHxTi/isndof+htq+Px7A/VJSjjXtGKCER0wiG4KFPDFyvELyKLCZ24o8EFY
	 AFekDSzftd81sA+zJM/vcJqvH3vOMXELo7bZqzvw=
Received: from [IPV6:2409:8a60:2a60:b160:9480:99e2:5707:aea7] ([2409:8a60:2a60:b160:9480:99e2:5707:aea7])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 798AE2D3; Sat, 23 Mar 2024 23:30:24 +0800
X-QQ-mid: xmsmtpt1711207824t75efaqzh
Message-ID: <tencent_2A5F9506756CD0DC2443BA00339BDFCF3306@qq.com>
X-QQ-XMAILINFO: MNsLylogNlqcpJ/isr7oWafWpQfMMlt6fQVFDbj0T2H0KQzFQJmn7vERKvR4BN
	 zjJ4A4qIthI+/z3MWFAHRRB5xo8BO8D1u27QU086bTE6iDcAQN5gZsv+RD4Cfw/Avbvv1jZ2WsV5
	 7W9C6TykK1r7FEiMbBySN8p8dXPQbynDG9esgAr8GvzoCLea4wxzOIN5g6vZuyOKnqvMZ1wjSELY
	 eLfSbKCLkOzovmWjoojfJWCZpxXgv+tK09xLMjwM16RQjwUZDPM+K+k+1/d0dgQ8d1XFnJDcWshf
	 ti7GKHWtS9i7Jemlaj90u9qbotpQHoTXg48pBOZtg1PUWiExSVSnIBgUsswbtuO2Sc9nZc6tl4VH
	 ypta7fY2y0+3//KxeXwY/KBLGw3UDIWrQZOjDmO/ZXJq6VcuibEKDb3mq/tzAfjiyBo1TL4NG92E
	 HYkca5U5x0nbb3dJMrsPmXKDlXH02JzfGHN7XnifD6WpIXpw0VzumwVn+p7FVhKnO3pdfYGUD3fN
	 oVGPVgaOC6CiKJJaPfrr4bEY8jQHnMOlXLBYXy1Jt1Q2uo2O0rg7evlG8D+T8sdfJ0XDFBhjo62X
	 /xdAYEF6tayBkod4i4Qm8U+BM2pXbWys+soDsjhI7lmkE1V6NCHWytoe64RyPcQDsN2gyL0JPPpG
	 iC49dMtPJjtUgPyfSHTXC+d388w+8BzOPNd9zSJ2tPUDaQ0kvm7RgMQ6+PDHlwwPN0+ebxpwi3rP
	 rYMqb30BocKamgOBxFff3vOvlEQbigAbcWXcXTf2cOkqTUpdLbvpp64xtb2GKuk2eGAKtL3f2Rkl
	 omp++H+wXMM6z8VNP4lTNMzeR8Zkl8I2lfH4Ka96s4QXnVHXAFi/ECKmlwyfylMKuU86PIeIXrtC
	 0DzGs21eGZoaoInTHUM3HwiPryAh046QHx6a+0z9iaKhpVuMTrGc9QBbfz1Xd0WDCQjWOTrcO8ku
	 Zvvtygx+8+dthQ0xF2zqYQT1AwFHps/9o+CBH+FLuISxHsoCShyocSTdDuMEg09gxKQOfjbAX9de
	 420TYWgozoNhbsW7tB
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-OQ-MSGID: <14e98e31-8cee-dcd6-f6ad-6f1fe707cd77@foxmail.com>
Date: Sat, 23 Mar 2024 23:30:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] exit: move trace_sched_process_exit earlier in
 do_exit()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <tencent_277EBFCF545587D4FD41EF932AE972CC6708@qq.com>
 <20240319145718.2bfb0d526ff441c8b37eab09@linux-foundation.org>
Content-Language: en-US
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20240319145718.2bfb0d526ff441c8b37eab09@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/20 05:57, Andrew Morton wrote:
> On Sun, 10 Mar 2024 13:25:29 +0800 wenyang.linux@foxmail.com wrote:
> 
>> From: Wen Yang <wenyang.linux@foxmail.com>
>>
>> Currently coredump_task_exit() takes some time to wait for the generation
>> of the dump file. But if the user-space wants to receive a notification
>> as soon as possible it maybe inconvenient.
> 
> If userspace is awaiting this notification to say "it's now OK to read
> the dump file" then it could break things?
> 

Thanks for your comments.

This could also be achieved in the nearby proc_exit_connector().

In addition, this issue has been discussed in detail in the following link:
https://lkml.org/lkml/2024/2/23/1018


>> Move trace_sched_process_exit() earlier in do_exit().
>> This way a user-space monitor could detect the exits and
>> potentially make some preparations in advance.
>>
>> Oleg initially proposed this suggestion, and Steven further provided some
>> detailed suggestions, and Mathieu carefully checked the historical code
>> and said:
>> : I've checked with Matthew Khouzam (maintainer of Trace Compass)
>> : which care about this tracepoint, and we have not identified any
>> : significant impact of moving it on its model of the scheduler, other
>> : than slightly changing its timing.
>> : I've also checked quickly in lttng-analyses and have not found
>> : any code that care about its specific placement.
>> : So I would say go ahead and move it earlier in do_exit(), it's
>> : fine by me.
> 
> I'm not seeing a clear need for this change.  "maybe inconveniant" is
> quite thin.  Please fully describe what motivated you to work on this?
> 

Thanks.
We hope to address this issue in our Advanced Driver Assistance System:
When certain critical processes exit abnormally, prompt information can 
be reported to the monitoring program as soon as possible.

We have also attempted to add a new TP, as follows:
https://lkml.org/lkml/2024/2/23/5

But after some discussion, it is still considered more reasonable to 
move trace_sched_process_exit() earlier.

We also look forward to your suggestions, thanks again.


--
Best wishes,
Wen





