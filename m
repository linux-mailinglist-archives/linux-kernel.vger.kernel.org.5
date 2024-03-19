Return-Path: <linux-kernel+bounces-107887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B9D880307
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E49D1C2242B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007C718C05;
	Tue, 19 Mar 2024 17:05:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10D1171A1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867940; cv=none; b=kK7TpfYdI3cpClg4leJHg9sXRwSOXznkYMZe6l2UDEaQVxu9uwE+gjwOCGwHwN8ddak4RtVwyfB41JzD8t/GVmEOdR5bcC7Rh5BFquKN1Uouu+QtXq2/Vxegs2OmFBMFHGEG5njn1b9wmjcnmhdLawImVR2bUJEtQS6wTXOaXfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867940; c=relaxed/simple;
	bh=m3AmCp2d6STrFkXDov5OL40gpXmXzlECYI8H6pyhN/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFi/5nJcBX66qOx8JitzY1xBYNpZH+xQXQ1Qz4sxJIOpXfEmw4b4krRRb8DXhZHmew7qhIthHuQGRVFhMlD+WATV2exG8802Kfea3hNwFSb3Y8BSXIQq2Z0tfB07I6A8Z8AygM2Ri2G2eqnJ6L/PjbLJ2G8eflpfuFBeAFbUi0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84570106F;
	Tue, 19 Mar 2024 10:06:06 -0700 (PDT)
Received: from [10.1.36.47] (e133649.arm.com [10.1.36.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EA773F67D;
	Tue, 19 Mar 2024 10:05:27 -0700 (PDT)
Message-ID: <bae6421c-5192-44e6-9ed9-1d32e7122cb7@arm.com>
Date: Tue, 19 Mar 2024 17:05:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/7] Revert "sched/uclamp: Set max_spare_cap_cpu
 even if max_spare_cap is 0"
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, linux-kernel@vger.kernel.org,
 David Dai <davidai@google.com>, Saravana Kannan <saravanak@google.com>
References: <cover.1706792708.git.hongyan.xia2@arm.com>
 <b29e7df921ce07c2c2dbbde390e234d162756c42.1706792708.git.hongyan.xia2@arm.com>
 <37be0494-7e38-4275-b6eb-62a2eb2f6d46@arm.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <37be0494-7e38-4275-b6eb-62a2eb2f6d46@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/03/2024 15:34, Dietmar Eggemann wrote:
> On 01/02/2024 14:11, Hongyan Xia wrote:
>> From: Hongyan Xia <Hongyan.Xia2@arm.com>
>>
>> That commit creates further problems because 0 spare capacity can be
>> either a real indication that the CPU is maxed out, or the CPU is
>> UCLAMP_MAX throttled, but we end up giving all of them a chance which
>> can results in bogus energy calculations. It also tends to schedule
>> tasks on the same CPU and requires load balancing patches. Sum
>> aggregation solves these problems and this patch is not needed.
>>
>> This reverts commit 6b00a40147653c8ea748e8f4396510f252763364.
> 
> I assume you did this revert especially for the 'Scenario 5: 8 tasks
> with UCLAMP_MAX of 120' testcase?

More or less. Actually you can already see the problem in Scenario 1. 
Ideally the 4 uclamp_max tasks should be evenly distributed on 4 little 
CPUs, but from time to time task placement places more than 1 such task 
on the same CPU, leaving some other little CPUs not occupied.

> IMHO, the issue is especially visible in compute_energy()'s busy_time
> computation with a valid destination CPU (dst_cpu >= 0). I.e. when we
> have to add performance domain (pd) and task busy time.
> 
> find_energy_efficient_cpu() (feec())
> 
>   for each pd
>    for each cpu in pd
> 
>     set {prev_,max}_spare_cap
> 
>   bail if prev_ and max_spare_cap < 0 (was == 0 before )
> 
>   {base_,prev_,cur_}energy = compute_energy
> 
> So with the patch we potentially compute energy for a saturated PD
> according:
> 
>   compute_energy()
> 
>    if (dst_cpu >= 0)
>     busy_time = min(eenv->pd_cap, eenv->busy_time + eenv->task_busy_time)
>                     <----(a)--->  <--------------(b)------------------->
> 
>    energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap)
> 
> If (b) > (a) then we're saturated and 'energy' is bogus.

Yeah, I think what's happening is because placing more tasks on the same 
CPU won't increase energy computation, so in the end task placement 
thinks it's the better decision. The root issue is that once you have 
uclamp_max, you can theoretically fit an infinite number of such tasks 
on the same CPU.

> The way to fix this is up for discussion:
> 
> (1) feec() returning prev_cpu
> (2) feec() returning -1 (forcing wakeup into sis() -> sic())
> (3) using uclamped values for task and rq utilization
> 
> None of those have immediately given the desired task placement on
> mainline (2 tasks on each of the 4 little CPUs and no task on the 2 big
> CPUs on my [l B B l l l] w/ CPU capacities = [446 1024 1024 446 446 446]
> machine) you can achieve with uclamp sum aggregation.

Personally from the results I've seen I definitely prefer (3), although 
(3) has other problems. One thing is that sum aggregation pushes up 
utilization with uclamp_min, but its energy consumption definitely won't 
be that high. The real energy is between its util_avg and util_avg_uclamp.

I haven't seen this as a real problem, but maybe we can see even better 
task placement if this is accounted for.

> [...]

