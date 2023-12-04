Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE148039D7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344566AbjLDQMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDQMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:12:45 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A5095
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:12:50 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58dd6d9ae96so1853448eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701706369; x=1702311169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JLr5RBoxBA30EKhuC+h/AobbR9T0hqVt40OPr8dzbVQ=;
        b=QD9pqkSHO9nCl/Da6qYM77u3BWmUFMZZKQQ47dqlwLmo6dkoRUEC4/FPIGvoYVN9MH
         4eTFMWU5HkTbzmH1x0b9TCOnoj0h4jjO7tYrj9y0gZ10V+ZE1ob8uOAuGux0EWqS7bzM
         bSymVJMEwSK4aNhMJsbZUxAASvBYZcO9ILd/N9Ap1gBfOLLB+KYM1fGkA+3GX8V/AP4b
         RNYKjeGzfReoCnrI2I/5Yc3fRZCMVSrmcy+trdFPUlBNF/JKZ7CgkD4nK95XA9UdE0oV
         v6QZ85p8mtjfLfj2GJO6yOGPnyrDXmZAzT2vrdQeCYtG60D6tKLFEkekOuPknTg43pNm
         mPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701706369; x=1702311169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JLr5RBoxBA30EKhuC+h/AobbR9T0hqVt40OPr8dzbVQ=;
        b=TTLOm6FpmeccEeajOrDLWgt6ep4zx+T0PV5jneflHu5pd9Faf24DHL/8rRYFvAj4Um
         w22Yq2Nn4nUtLyg71o8mGMWjmDyLHA7OEZKA7Pe6Fzb6yuWu1iQF+oZpPc9EPhahpuEe
         QReRPr6ogvcxKtGArdD8MqYzK93kCYUIu8EO7wSKNIRMECSRbbyMEtLSYA8KXh6ocTco
         XToluXvXcr4+cOZY29aCm2/OQ4M1piiYgLi2dJ5Gqg1apRHGHmz1BLDH53/fkw2L8VKC
         IQ7NfW+O3TDF/6mzYV4gUyL2xyDaNbNzlHs+IOdJqvUYRJEX7R7ix8NoAcCGQyPZSefx
         1w8A==
X-Gm-Message-State: AOJu0Yyd+Gt48kcyMciiYWG0k6MMdOc0QssyYZcFP+HMt0kuY6PkazQ6
        /AJ9qXVxfUBWfhyBL5g3nA6yk2SPUQr8IKiulpYGfw==
X-Google-Smtp-Source: AGHT+IFe4zj2l5E/avHidZinbgjXbSpSbd5ItlhKax1gRuMQ54H4mH4x9nTM6kBTtozIbV/kDotdWs7OcCZDh8HIlYk=
X-Received: by 2002:a05:6358:3417:b0:170:1070:27ce with SMTP id
 h23-20020a056358341700b00170107027cemr1599327rwd.24.1701706369090; Mon, 04
 Dec 2023 08:12:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1696345700.git.Hongyan.Xia2@arm.com> <20231203002544.d4zx3oyvjugohh22@airbuntu>
 <7f1f7dd0-e3b5-4e16-a44e-c08fca567f97@arm.com>
In-Reply-To: <7f1f7dd0-e3b5-4e16-a44e-c08fca567f97@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 4 Dec 2023 17:12:37 +0100
Message-ID: <CAKfTPtBZ+7STLsRH7h+WeitcH1i4623J4xb0XQKTzsp=XNV_-w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] sched: uclamp sum aggregation
To:     Hongyan Xia <hongyan.xia2@arm.com>
Cc:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 at 02:48, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>
> Hi Qais,
>
> On 03/12/2023 00:25, Qais Yousef wrote:
> > Hi Hongyan
> >
> > On 10/04/23 10:04, Hongyan Xia wrote:
> >> Current implementation of uclamp leaves many things to be desired.
> >> There are several problems:
> >>
> >> 1. Max aggregation is fragile. A single task with a high UCLAMP_MAX (or
> >>     with the default value, which is 1024) can ruin the previous
> >>     settings the moment it is enqueued, as shown in the uclamp frequency
> >>     spike problem in Section 5.2 of
> >>     Documentation/scheduler/sched-util-clamp.rst. Constantly running at
> >>     1024 utilization implies that the CPU is driven at its max capacity.
> >>     However, with UCLAMP_MAX, this assumption is no longer true. To
> >>     mitigate this, one idea is to filter out uclamp values for
> >>     short-running tasks. However, the effectiveness of this idea remains
> >>     to be seen.
> >
> > This was proved when I was at arm and it is used in products now too. It is
> > effective.
> >
> >>
> >> 2. No way to differentiate between UCLAMP_MAX throttled CPU or a CPU
> >>     running at its peak, as both show utilization of 1024. However, in
> >>     certain cases it's important to tell the difference, as we still want
> >>     to take the opportunity to enqueue tasks in the former case.
> >>
> >> It's also debatable whether uclamp should be a frequency hint. An
> >
> > It is not debatable. Uclamp is a performance hint which translates into task
> > placement (for HMP) and frequency selection. On SMP the latter is the only
> > meaning for uclamp. For the time being at least until we get a new technology
> > that can impact performance ;-)
>
> I agree. In this new series, uclamp is still a performance hint which
> affects task placement and frequency, so we don't have a disagreement here.
>
> >> example is a system with a mid CPU of capacity 500, and a little CPU
> >> with capacity 100. If we have 10 tasks with UCLAMP_MIN of 101, then
> >> util_fits_cpu() will schedule them on the mid CPU because feec()
> >> thinks they don't fit on the little, even though we should use the
> >> little core at some point instead of making the mid even more crowded.
> >
> > This is not a problem. One of the major design points for uclamp is to allow
> > small tasks to request to run faster. So if you have 100 tasks that run for
> > 100us and to meet that they need to run at mid CPU that is fine. That doesn't
> > necessarily mean they'll overutilized the cluster.
>
> I understand. This design point is what sum aggregation does as well.
> This alone is not a problem, but moving a CPU to another CPU to fit
> uclamp_min requirement can be a problem, when the destination CPU is
> crowded and mixed with uclamp_max. I will elaborate on this below.
>
> >
> > If the cluster gets overutilized, then EAS will be disabled and
> > find_idle_capacity() will spread into highest spare capacity idle CPU, which
> > includes little CPUs. And this behavior is no different to have tasks with util
> > greater than 100 wanting to run on mid cores. The only difference is that we
> > can pack more on mid core before overutilized can be triggered. Which is the
> > desired effect.
> >
> > So this is a no issue and we should spread once the cluster is busy.
> >> Of course, this in reality doesn't happen because of other mechanisms
> >> like load balancing, but it's also not good when other mechanisms can
> >> cancel the effect of uclamp in feec(). A CPU running at capacity 500 for
> >> 1ms or for 1000ms gives completely different performance levels, so
> >> trying to fit only the frequency does not give us any performance
> >> guarantees. If we then talk about not only running at some frequency but
> >> also for some amount of time, then what we really mean is a capacity
> >> hint, not a frequency hint.
> >
> > I'm not sure I parsed that. But again, it's a performance hint which implies
> > both.
> >
> >>
> >> It's even worse when the tasks scheduled on the mid CPU also have
> >> UCLAMP_MAX values. In the previous example, instead of running at 500, a
> >> single UCLAMP_MAX, assuming it's 110, can make the mid CPU run at a much
> >> lower frequency than 500, so it is then a really bad decision to honor
> >> the UCLAMP_MIN frequency hint and place it on the mid CPU, instead of
> >> running it on the little CPU which is less crowded, and has pretty much
> >> the same capacity (100 vs 110) anyway.
> >
> > I can't follow this reasoning.
> >
> > It seems you're assuming the user has picked 110 by mistake and it is okay to
> > ignore it.
> >
> > FYI, one of the use cases is to set uclamp_min to capacity_of(little_core)+1
> > because they're so crappy to handle their workload. It is still better than
> > using affinity as when the system gets busy we can still use the little core.
> > But only when the system is busy and crowded already.
> >
> > I don't know what's the reference to the mid core having a task with
> > uclamp_max, but seems a bug in feec() if not predicting the frequency
> > correctly.
>
> The example in the cover letter might be complex. I can simplify as a "N
> tasks" problem.
>
> Say 2 CPUs, one with capacity 1024 and the other 512. Assume there's a
> task with uclamp_min 513 and uclamp_max of 800, then the big CPU can, in
> theory, fit an infinite number of such tasks on the big CPU, without
> triggering overutilization. What does uclamp_min even mean when this
> happens? uclamp_min should be a hint of a minimum performance it should
> get, but it breaks down when there are N tasks, so the hint from
> uclamp_min is divided by N. Under max aggregation, uclamp_min doesn't
> give you the "performance" of this task. It gives performance of the
> CPU, and this is not the performance of this task when N > 1. In fact, N
> can be infinity. This is the same problem shared by multiple uclamp
> users from LPC, where max aggregation hints the performance of the CPU,
> but not the task itself.
>
> As to "FYI, one of the use cases is to set uclamp_min to
> capacity_of(little_core)+1 because they're so crappy to handle their
> workload", I'm afraid I disagree with this. I think uclamp is a simple
> hinting mechanism to the scheduler to say: please try to give me
> [uclamp_min, uclamp_max] performance. It's then the job of EAS to pick

You get the point. It's an EAS decision and must stay in EAS not going
into PELT. You have all the information: actual utilization,
uclamp_min uclamp_max. Make EAS smarter


> the most efficient CPU. We know the little CPU is crappy because we have
> deep knowledge of the device, but uclamp values could just come from
> game developers (using ADPF) who have no knowledge of the SoC, and in
> the game developer's view, asking uclamp of little CPU + 1 is simply
> because he/she wants that performance, not because the developer thinks
> the little CPU should be avoided. I don't think a soft-affinity-like
> property belongs here. We should improve EM and let EAS do its job
> instead of teaching it to interpret uclamp as affinity hints.
>
> >>
> >> This series attempts to solve these problems by tracking a
> >> util_avg_uclamp signal in tasks and cfs_rq. At task level,
> >
> > This was discussed offline and brought several times on the list already.
> > uclamp is a performance not a bandwidth hint. I remember Dietmar was suggesting
> > this concept in the past and I objected that this converts uclamp into
> > a bandwidth hint. This overlaps with CFS bandwidth controller. We can use that
> > if somebody wants to limit the bandwidth the task can consume. uclamp is about
> > limiting the performance level it can reach. ie: it is not about cycles
> > consumed, but Performance Point reached.
>
> I'd argue the current max aggregation implementation is further away
> from a performance hint. The moment there are more tasks interacting
> with each other on the same rq, the performance hinting ability of max
> aggregation tends to do worse, like uclamp_min being divided by N,
> frequency spikes, uneven task distribution (both shown in the evaluation
> section of my cover letter) etc, whereas sum aggregation still performs
> well.
>
> Other shortcomings are not that critical, but the fact that uclamp_min's
> effectiveness is divided by N under max aggregation I think is not
> acceptable.

Change EAS task placement policy in this case to take into account
actual utilization and uclamp_min/max

>
> >> p->se.avg.util_avg_uclamp is basically tracking the normal util_avg, but
> >> clamped within its uclamp min and max. At cfs_rq level, util_avg_uclamp
> >> must always be the sum of all util_avg_uclamp of all the entities on
> >> this cfs_rq. As a result, cfs_rq->avg.util_avg_uclamp is the sum
> >> aggregation of all the clamped values, which indicates the frequency
> >> this rq should run at and what the utilization is.
> >
> > This is a no go for me. A task performance requirements can not be added to
> > resemble the 'size' of the tasks. Tasks with util_avg 100 but a uclamp_min of
> > 1024 should allow us to pack them in the big core. Which is an important use
> > case to use. A bunch of small tasks that need to run faster are okay to pack on
> > a bigger core if they need to run faster as long as this doesn't cause
> > overutilized to trigger.
>
> I see. I now understand where we start to diverge. It seems we want
> completely different things from uclamp.
>
> Max aggregation: please try to place me on a CPU that can give CPU
> capacity [uclamp_min, uclamp_max] and run that CPU within that range.
> Sum aggregation: please try to treat me like a task with utilization
> within [uclamp_min, uclamp_max].
>
> Like I mentioned in the previous comment, I'm afraid I disagree with
> using uclamp as a CPU affinity hint, even if it's just a soft affinity.
> Its job should just be a performance hint and EM should tell EAS which
> CPU to pick under that hint. If the little CPU is crappy, then the
> crappiness should be reflected in the EM, and maybe dynamic EM can help.
>
> >>
> >> This idea solves Problem 1 by capping the utilization of an
> >> always-running task throttled by UCLAMP_MAX. Although the task (denoted
> >> by Task A) has no idle time, the util_avg_uclamp signal gives its
> >> UCLAMP_MAX value instead of 1024, so even if another task (Task B) with
> >> a UCLAMP_MAX value at 1024 joins the rq, the util_avg_uclamp is A's
> >> UCLAMP_MAX plus B's utilization, instead of 1024 plus B's utilization,
> >> which means we no longer have the frequency spike problem caused by B.
> >> This should mean that we might completely avoid the need for uclamp
> >> filtering.
> >>
> >> It also solves Problem 2 by tracking the capped utilization of a rq.
> >> Using util_avg_uclamp, we are able to differentiate between a CPU
> >> throttled by UCLAMP_MAX and one that is actually running at its peak
> >> capacity. An always-running rq with a task having UCLAMP_MAX at 300 will
> >> report a cfs_rq util_avg_uclamp at 300, not 1024, which means task
> >> placement sees spare capacity on this CPU and will allocate some tasks
> >> to it, instead of treating it the same way as a CPU actually running at
> >
> > We don't need to know the actual spare capacity, though that would be nice to
> > have.
> >
> > But generally in my view this CPU should be available for non capped task to
> > run on. I view this a load balancer problem where wake up path can consider
> > this CPU as a candidate and rely on load balancer to move this task away to
> > another (smaller) CPU ASAP. If this capped task is already on the smaller CPU
> > and there's nowhere else to place the uncapped task in the system then we must
> > be quite busy already.
>
> I'm not quite sure relying on the load balancer is a good idea, because
> then it means we need uclamp code in the load balancer and the

But you will have because uclamp_max can make any task behaving like
an always running task (ie without wakeup event to migrate the task)

> complexity keeps growing. An example is that after applying the patch
>
> 'sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0'
>
> even though the scheduler now knows that CPUs with 0 spare capacity are
> now candidates, it creates a very unbalanced task placement and CPU0
> tends to receive a lot of tasks in my tests. This certainly needs some
> uclamp-aware code in the load balancer, whereas sum aggregation has no
> such problem and balance is achieved during task placement in the first
> place.
>
> > If userspace ends up capping too many tasks too hard that we end up with no
> > idle time in the system (where otherwise we should) I consider this a bad usage
> > in the userspace and will ask them not to cap that hard. This is a case of one
> > shooting themselves in the foot. Maybe we need to care in the future, but so
> > far this doesn't seem a valid problem to address. I'd like to see why userspace
> > has failed to do proper management first before jumping to fix this.
> >
> > What I'd expect more use cases of tasks that are truly 1024 but being capped.
> > In this case there's truly no idle time on the CPU and your proposal won't
> > address this. I don't think we have a way to distinguish between the two cases
> > at the moment.
>
> I don't quite get what you mean. In the examples in my cover letter the
> capped tasks are truly 1024. Two CPUs, one with an uncapped 1024 task
> and the other a 1024 task but with uclamp_max of 300. The scheduler sees
> cfs_rq->avg.util_avg_uclamp of 1024 in the first CPU and 300 in the 2nd,
> so my proposal indeed sees the difference, and will have the opportunity
> to place more tasks on the 2nd CPU without any corner case code.
>
> >> the peak. This brings us closer to the benefits of Android's sum
> >> aggregation (see code related to CONFIG_USE_GROUP_THROTTLE at
> >> https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviole-5.10-android12-d1/drivers/soc/google/vh/kernel/sched/fair.c#510),
> >> which shows energy benefits because we are able to schedule tasks on
> >> smaller cores which are UCLAMP_MAX capped, instead of finding a fresh
> >
> > You're jumping to the wrong conclusion about why this is being used. This was
> > to overcome issues when using cpu.shares. This has nothing to do with
> > UCLAMP_MAX. uclamp_max filter is what is being used. Based on the proposal
> > I posted long ago
> >
> >       https://android-review.googlesource.com/c/kernel/common/+/1914696
> >
>
> Maybe I need to rephrase. I said that GROUP_THROTTLE can give us some
> energy benefits. I didn't draw any conclusion that this was why it was
> invented. I was also trying to suggest that, under sum aggregation, the
> same code can work for both uclamp and GROUP_THROTTLE. However, I
> probably need to better understand the issues around cpu.shares before
> saying this concretely.
>
> Also, uclamp filtering might be another example why I think max
> aggregation is over-complicated. Sum aggregation has only around 300
> lines of code so far without the need for filtering at all.
>
> >> big CPU. However, a major difference is that this series has an
> >> amortized cost of O(1), instead of O(n) in cpu_util_next() in Android
> >> kernels.
> >>
> >> It avoids the shortcomings from uclamp-being-a-frequency-hint. Under sum
> >
> > This is not a short coming. Performance implies frequency. We should not
> > confused how schedutil works to estimate perf requirement based on historical
> > run time (util_avg) and the fact that a task with short historical runtime
> > needs to run faster. Running faster means increasing frequency.
> >
> >> aggregation, the scheduler sees the sum aggregated util_avg_uclamp and
> >> will avoid the problem of enqueueing too many tasks just to fit the
> >> frequency, and will place tasks on little CPUs in the previous example.
> >
> > I think the issue of uclamp being a performance but not a bandwidth hint was
> > raised several times. Did I miss something that makes this not converting it to
> > a bandwidth hint?
> >
>
> I wonder what does performance hint even mean if it doesn't at least
> correlate to bandwidth in some way? Yes, specifying uclamp_min under max
> aggregation can run the CPU at least at that frequency, but if you have
> N tasks on the same rq, then each task can only get a share of
> uclamp_min/N. I highly doubt that when a mobile phone developer
> increases the uclamp_min of an application, he or she is okay with
> doubling the CPU frequency when it runs and running it only for 1/10 of
> the time because it gets moved to a crowded big CPU, which essentially
> gives 0.2x the "performance" in my opinion, so I'm not sure fully
> disconnecting bandwidth from performance is meaningful. Of course, a
> (not yet) uclamp-aware load balancer could come in and migrate those
> tasks, but why not avoid this problem in the first place via sum
> aggregation without involving the load balancer, especially when today
> we don't have any indication of how well a uclamp-aware load balancer
> can perform anyway?
>
> In the end I may still not be able to fully grasp what the issues of sum
> aggregations are. I think so far I get that it's closer to "bandwidth"
> and not "performance" (which I think "performance" doesn't mean much if
> it doesn't correlate to bandwidth) and it doesn't work as a CPU affinity
> hint (it actually does to some degree, but the uclamp values need to be
> different). But I think focusing on these ignores the whole picture,
> which are the benefits of sum aggregation (already presented in the
> evaluation section of the cover letter of this series):
>
> 1. It's fewer than 350 lines of code (max aggregation is 750+ and still
> growing).
> 2. It doesn't suffer from frequency spikes or load balancing issues.
> 3. It needs no code to consider uclamp as a corner case in the
> scheduler. No need to carry around uclamp_min and uclamp_max in so many
> functions. util_fits_cpu() is just one line of code.
> 4. It's effective. When you say a uclamp_min of X, the scheduler really
> tries to give you X for your task, not for the CPU you are on, as seen
> in 54% reduction of jank in jankbench, without increasing energy
> consumption.
> 5. It looks like something multiple developers want from LPC 2023. The
> use cases of "additive uclamp", and hinting the host from the VM via
> util_guest can be achieved exactly by uclamp sum aggregation.
>
> Given these benefits, I think it's probably a good idea to give sum
> aggregation a serious look. On my Pixel 6, sum aggregation either gives
> better benchmark scores at the same energy as max aggregation, or
> consumes less power at the same benchmark scores. I'll keep benchmarking
> it but so far so good.
>
> Hongyan
