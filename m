Return-Path: <linux-kernel+bounces-74886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E411285DF24
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211811C2395D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917D17C6C0;
	Wed, 21 Feb 2024 14:25:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FC669E00;
	Wed, 21 Feb 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525508; cv=none; b=hxJRE2S/kK3mkVMd7zxZv3FQUwgN0qNXLPnNYW9Ca1UVrHxfsecIhmqAGrlyj0Mzzi06yqC+O0pifxeFMlAM1T8X7il0XTnxdjOh3Mdc8sx8N3S85EGFkfsFlVaEjN5kHi/sphTiUESMYO0a9K1IbAopJojzVCdDb+Kh7e0RQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525508; c=relaxed/simple;
	bh=Gy89qptAv2iTAYRcZ3FZRFKQzMSJu/13BzdF9/IZBqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9pnPQwN5smPcKNLSo+ZsRA9+tNUy8ZSJUn1BeJdb5l2fKbsIq1w1eQ5pETqI1EE1Q1ef52rn4yG3N+xLejO8xzicFaSePtUZYJXN+4juJ7LZf/ZaQSI+8mGwwfkuKG+maJCjwr/eYel0khgh1IoAPQEBogdMFUPST50ktq+amg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F19BE1007;
	Wed, 21 Feb 2024 06:25:43 -0800 (PST)
Received: from [10.1.37.53] (e132833.arm.com [10.1.37.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D5113F762;
	Wed, 21 Feb 2024 06:25:01 -0800 (PST)
Message-ID: <10e83b13-bce5-4544-8923-1ee90a2135a8@arm.com>
Date: Wed, 21 Feb 2024 14:24:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Add trace events for Proxy Execution (PE)
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
 Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>,
 Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-team@android.com, linux-trace-kernel@vger.kernel.org
References: <20240202083338.1328060-1-metin.kaya@arm.com>
 <20240221092309.00432f37@gandalf.local.home>
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20240221092309.00432f37@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/02/2024 2:23 pm, Steven Rostedt wrote:
> On Fri,  2 Feb 2024 08:33:38 +0000
> Metin Kaya <metin.kaya@arm.com> wrote:
> 
>> Add sched_[start, finish]_task_selection trace events to measure the
>> latency of PE patches in task selection.
>>
>> Moreover, introduce trace events for interesting events in PE:
>> 1. sched_pe_enqueue_sleeping_task: a task gets enqueued on wait queue of
>>     a sleeping task (mutex owner).
>> 2. sched_pe_cross_remote_cpu: dependency chain crosses remote CPU.
>> 3. sched_pe_task_is_migrating: mutex owner task migrates.
>>
>> New trace events can be tested via this command:
>> $ perf trace \
>>    -e sched:sched_start_task_selection \
>>    -e sched:sched_finish_task_selection \
>>    -e sched:sched_pe_enqueue_sleeping_task \
>>    -e sched:sched_pe_cross_remote_cpu \
>>    -e sched:sched_pe_task_is_migrating
>>
>> Notes:
>> 1. These trace events are not intended to merge upstream. Instead, they
>>     are only for making PE tests easier and will be converted to trace
>>     points once PE patches hit upstream.
> 
> I wonder if the tracepoints should be added though? That is, not adding the
> trace_events that show up in tracefs, but just the tracepoints so that bpf
> or local modules could hook to them?

Yep, the intention is providing necessary support for modules (e.g., 
https://github.com/ARM-software/lisa/blob/main/lisa/_assets/kmodules/lisa/tp.c). 


> 
> -- Steve
> 
> 
>> 2. This patch is based on John's Proxy Execution v7 patch series (see
>>     the link below) which is also available at
>>     https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v7-6.7-rc6/.
>>
>> Link: https://lore.kernel.org/linux-kernel/CANDhNCrHd+5twWVNqBAhVLfhMhkiO0KjxXBmwVgaCD4kAyFyWw@mail.gmail.com/
> 


