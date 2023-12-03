Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC21802000
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 01:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjLCAZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 19:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCAZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 19:25:42 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9398103
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 16:25:47 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b4d9e81deso34215895e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 16:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701563146; x=1702167946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpWCRLeCkd/AhvoqxESuoE6u4Rm9t7W35Btxa8PnHBc=;
        b=wEB1YXKXXcIZN6KrjU9uyQrd9vpWT1DvBuBi1G8mxEJF3lhTc2/BSH+d15pISFyr2x
         pWdFZ9Ql5lGj2gOniUDK+TezCUeyc79XiWjNXBBBNQ3XkZVGu+F7NDaDpJAzYa6czRMc
         /fM5W8OVSGY7/7LssJHySkphRimr0O9/R+cPp2mvn1+Ou3vg8UpGpQWpKs1FmCJDLcgq
         ckmi8FXFAo/yi75K7UYIJTKnZ9dlj1ENgYCIEJbH3UJUGs4+tv+76wAkPEGnZioR4pJG
         zxv627X7xGobNr9g/5OTcAu969H03NAHCCUuitWWY5vf7Zf/nKjC3OrhSseD5cJbrGHd
         aU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701563146; x=1702167946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpWCRLeCkd/AhvoqxESuoE6u4Rm9t7W35Btxa8PnHBc=;
        b=tnlPRTsCC2cXtceFl59zHLV9RL5gV3t94K235MtZp1Uc6ccoA3kMPuv5XrXKV3cGCo
         3+gqgcmW2EMKBrZSEY/PnM3Btg0JOJq30frRidkNUFHIapCamDYdaz+ikAcc0aY9kanF
         fz9a8mBCZpA1w9/MMpx+f/K+kZeaQRqN2mHG2+k5nuI2Qo1jVDoA46RTAZfWPNmEGSAL
         Uy1iGnz8OfOCm+GYCQvTiE9vQDSMWiLDy02hJ3MgKRgy+5cMpCycAXId3scg3i0M7dGk
         VQkRxuGWghgH+0YSrHL8d2fA7PZ/bVmJx9kcBUPvgAr2hXGWK8fd/QyAXSYvYtfIAOvZ
         LLZA==
X-Gm-Message-State: AOJu0YzknsTChaVMfDA4Ijoyz2yB/FaBlvIXrseshJeKWlRpWQbIdRYp
        XxU0WO3qs/nmLp970ZxQLIR5ZA==
X-Google-Smtp-Source: AGHT+IGvU4dhUhbJ3+FKHBXypdrsHnTb9jrOmC6RlcmNRB4UtLleSW2eOCb4q4hWIztUI+5g3nGUQA==
X-Received: by 2002:a05:600c:81e:b0:3fe:4cbc:c345 with SMTP id k30-20020a05600c081e00b003fe4cbcc345mr1416459wmp.41.1701563146026;
        Sat, 02 Dec 2023 16:25:46 -0800 (PST)
Received: from airbuntu (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id a13-20020a05600c348d00b0040b5377cf03sm13896876wmq.1.2023.12.02.16.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 16:25:45 -0800 (PST)
Date:   Sun, 3 Dec 2023 00:25:44 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Hongyan Xia <Hongyan.Xia2@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] sched: uclamp sum aggregation
Message-ID: <20231203002544.d4zx3oyvjugohh22@airbuntu>
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696345700.git.Hongyan.Xia2@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hongyan

On 10/04/23 10:04, Hongyan Xia wrote:
> Current implementation of uclamp leaves many things to be desired.
> There are several problems:
> 
> 1. Max aggregation is fragile. A single task with a high UCLAMP_MAX (or
>    with the default value, which is 1024) can ruin the previous
>    settings the moment it is enqueued, as shown in the uclamp frequency
>    spike problem in Section 5.2 of
>    Documentation/scheduler/sched-util-clamp.rst. Constantly running at
>    1024 utilization implies that the CPU is driven at its max capacity.
>    However, with UCLAMP_MAX, this assumption is no longer true. To
>    mitigate this, one idea is to filter out uclamp values for
>    short-running tasks. However, the effectiveness of this idea remains
>    to be seen.

This was proved when I was at arm and it is used in products now too. It is
effective.

> 
> 2. No way to differentiate between UCLAMP_MAX throttled CPU or a CPU
>    running at its peak, as both show utilization of 1024. However, in
>    certain cases it's important to tell the difference, as we still want
>    to take the opportunity to enqueue tasks in the former case.
> 
> It's also debatable whether uclamp should be a frequency hint. An

It is not debatable. Uclamp is a performance hint which translates into task
placement (for HMP) and frequency selection. On SMP the latter is the only
meaning for uclamp. For the time being at least until we get a new technology
that can impact performance ;-)

> example is a system with a mid CPU of capacity 500, and a little CPU
> with capacity 100. If we have 10 tasks with UCLAMP_MIN of 101, then
> util_fits_cpu() will schedule them on the mid CPU because feec()
> thinks they don't fit on the little, even though we should use the
> little core at some point instead of making the mid even more crowded.

This is not a problem. One of the major design points for uclamp is to allow
small tasks to request to run faster. So if you have 100 tasks that run for
100us and to meet that they need to run at mid CPU that is fine. That doesn't
necessarily mean they'll overutilized the cluster.

If the cluster gets overutilized, then EAS will be disabled and
find_idle_capacity() will spread into highest spare capacity idle CPU, which
includes little CPUs. And this behavior is no different to have tasks with util
greater than 100 wanting to run on mid cores. The only difference is that we
can pack more on mid core before overutilized can be triggered. Which is the
desired effect.

So this is a no issue and we should spread once the cluster is busy.

> Of course, this in reality doesn't happen because of other mechanisms
> like load balancing, but it's also not good when other mechanisms can
> cancel the effect of uclamp in feec(). A CPU running at capacity 500 for
> 1ms or for 1000ms gives completely different performance levels, so
> trying to fit only the frequency does not give us any performance
> guarantees. If we then talk about not only running at some frequency but
> also for some amount of time, then what we really mean is a capacity
> hint, not a frequency hint.

I'm not sure I parsed that. But again, it's a performance hint which implies
both.

> 
> It's even worse when the tasks scheduled on the mid CPU also have
> UCLAMP_MAX values. In the previous example, instead of running at 500, a
> single UCLAMP_MAX, assuming it's 110, can make the mid CPU run at a much
> lower frequency than 500, so it is then a really bad decision to honor
> the UCLAMP_MIN frequency hint and place it on the mid CPU, instead of
> running it on the little CPU which is less crowded, and has pretty much
> the same capacity (100 vs 110) anyway.

I can't follow this reasoning.

It seems you're assuming the user has picked 110 by mistake and it is okay to
ignore it.

FYI, one of the use cases is to set uclamp_min to capacity_of(little_core)+1
because they're so crappy to handle their workload. It is still better than
using affinity as when the system gets busy we can still use the little core.
But only when the system is busy and crowded already.

I don't know what's the reference to the mid core having a task with
uclamp_max, but seems a bug in feec() if not predicting the frequency
correctly.

> 
> This series attempts to solve these problems by tracking a
> util_avg_uclamp signal in tasks and cfs_rq. At task level,

This was discussed offline and brought several times on the list already.
uclamp is a performance not a bandwidth hint. I remember Dietmar was suggesting
this concept in the past and I objected that this converts uclamp into
a bandwidth hint. This overlaps with CFS bandwidth controller. We can use that
if somebody wants to limit the bandwidth the task can consume. uclamp is about
limiting the performance level it can reach. ie: it is not about cycles
consumed, but Performance Point reached.

> p->se.avg.util_avg_uclamp is basically tracking the normal util_avg, but
> clamped within its uclamp min and max. At cfs_rq level, util_avg_uclamp
> must always be the sum of all util_avg_uclamp of all the entities on
> this cfs_rq. As a result, cfs_rq->avg.util_avg_uclamp is the sum
> aggregation of all the clamped values, which indicates the frequency
> this rq should run at and what the utilization is.

This is a no go for me. A task performance requirements can not be added to
resemble the 'size' of the tasks. Tasks with util_avg 100 but a uclamp_min of
1024 should allow us to pack them in the big core. Which is an important use
case to use. A bunch of small tasks that need to run faster are okay to pack on
a bigger core if they need to run faster as long as this doesn't cause
overutilized to trigger.

> 
> This idea solves Problem 1 by capping the utilization of an
> always-running task throttled by UCLAMP_MAX. Although the task (denoted
> by Task A) has no idle time, the util_avg_uclamp signal gives its
> UCLAMP_MAX value instead of 1024, so even if another task (Task B) with
> a UCLAMP_MAX value at 1024 joins the rq, the util_avg_uclamp is A's
> UCLAMP_MAX plus B's utilization, instead of 1024 plus B's utilization,
> which means we no longer have the frequency spike problem caused by B.
> This should mean that we might completely avoid the need for uclamp
> filtering.
> 
> It also solves Problem 2 by tracking the capped utilization of a rq.
> Using util_avg_uclamp, we are able to differentiate between a CPU
> throttled by UCLAMP_MAX and one that is actually running at its peak
> capacity. An always-running rq with a task having UCLAMP_MAX at 300 will
> report a cfs_rq util_avg_uclamp at 300, not 1024, which means task
> placement sees spare capacity on this CPU and will allocate some tasks
> to it, instead of treating it the same way as a CPU actually running at

We don't need to know the actual spare capacity, though that would be nice to
have.

But generally in my view this CPU should be available for non capped task to
run on. I view this a load balancer problem where wake up path can consider
this CPU as a candidate and rely on load balancer to move this task away to
another (smaller) CPU ASAP. If this capped task is already on the smaller CPU
and there's nowhere else to place the uncapped task in the system then we must
be quite busy already.

If userspace ends up capping too many tasks too hard that we end up with no
idle time in the system (where otherwise we should) I consider this a bad usage
in the userspace and will ask them not to cap that hard. This is a case of one
shooting themselves in the foot. Maybe we need to care in the future, but so
far this doesn't seem a valid problem to address. I'd like to see why userspace
has failed to do proper management first before jumping to fix this.

What I'd expect more use cases of tasks that are truly 1024 but being capped.
In this case there's truly no idle time on the CPU and your proposal won't
address this. I don't think we have a way to distinguish between the two cases
at the moment.

> the peak. This brings us closer to the benefits of Android's sum
> aggregation (see code related to CONFIG_USE_GROUP_THROTTLE at
> https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviole-5.10-android12-d1/drivers/soc/google/vh/kernel/sched/fair.c#510),
> which shows energy benefits because we are able to schedule tasks on
> smaller cores which are UCLAMP_MAX capped, instead of finding a fresh

You're jumping to the wrong conclusion about why this is being used. This was
to overcome issues when using cpu.shares. This has nothing to do with
UCLAMP_MAX. uclamp_max filter is what is being used. Based on the proposal
I posted long ago

	https://android-review.googlesource.com/c/kernel/common/+/1914696

> big CPU. However, a major difference is that this series has an
> amortized cost of O(1), instead of O(n) in cpu_util_next() in Android
> kernels.
> 
> It avoids the shortcomings from uclamp-being-a-frequency-hint. Under sum

This is not a short coming. Performance implies frequency. We should not
confused how schedutil works to estimate perf requirement based on historical
run time (util_avg) and the fact that a task with short historical runtime
needs to run faster. Running faster means increasing frequency.

> aggregation, the scheduler sees the sum aggregated util_avg_uclamp and
> will avoid the problem of enqueueing too many tasks just to fit the
> frequency, and will place tasks on little CPUs in the previous example.

I think the issue of uclamp being a performance but not a bandwidth hint was
raised several times. Did I miss something that makes this not converting it to
a bandwidth hint?

Generally I think the max-aggregation should go away too. We've been
overcompensating for a problem that must be fixed by cpufreq governor. I've
been building up to this solution with patches to improve the governor and will
post them soon.


Cheers

--
Qais Yousef
