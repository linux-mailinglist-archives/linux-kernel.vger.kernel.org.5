Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74920797E26
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbjIGV4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIGV4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:56:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BBE1BE4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:55:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso16069405e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694123758; x=1694728558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3SCGs5Jx75wQk08k4llHSBIu4lV0L9xv4ja8pIZKOmo=;
        b=fl4rKOCGFb3Nw2wJay/dPH8yOzqhxbjKmLUy37bJxVkRaVgxY3RSskvHI+dCWSBFWr
         C0n22T3sZr4VQ7YKkP6qon8DGRVQOFxlzjGxYanu8NvlM5kGzuTcVCLMe8R10fD2nALq
         xMxVu3CPnxczk4Wm5Og84Y4Qa9gVJC18dA1o11e0DifIGiM3JRBdL1+kMpfm6b46W5AE
         Az3cYbm0Iz6UUU4EP1TlM5fsMw67gGr1t+NOMg6g/Kaj24J2DzjUATKQpVxBX8HsmaNQ
         f2hXeewccW/+D8rXn8KhTVz8F3yRtdiSDU/hf1n/WGEZLRQkVqD8Y82pM0ljMQHpqY8q
         BZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694123758; x=1694728558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SCGs5Jx75wQk08k4llHSBIu4lV0L9xv4ja8pIZKOmo=;
        b=sf1RYicAjNscybffnEdycfMdw80BQ3fqBYcZu6CnX5OylLv6ga5Vw05VJhdaqoRSxc
         2iE0P6eZ6hlC1y4hIDhtek4Za6a87quMVG2UCv2HKoE64OEyc2hLtXHvESOtxMcLWqRh
         kCzBQsxCjKubTdmGIlnkvRF7n5atEBhnItl0HwkBS8ebxy161g4tQd8io10Grz5eEbrA
         h+050OIb7celYwo1lfFoWyDlybg2juOae9adXq68WF52+kTTtIbXmyeNBemCJYtcGccx
         1WG7Amj9G7McFNVwOFth2fMDbd9YzkGGx/UECyuQf0QxJObunuB4FdxrZy673RXl2LKA
         xRZA==
X-Gm-Message-State: AOJu0YyxjjwJFrdZjxAQ0ck4UbnqDK/ijgqzSkawbfOswMq/4ObV5oF7
        NoRk545XlTsk/6JJLtxP5vnuUQ==
X-Google-Smtp-Source: AGHT+IHuzT1g7pV47TeWt3IwMFQM71WA3jv3wD5z1GNHFjOGatTpXoKbrJ4NnAGeSw7aZF9i/SS2Xw==
X-Received: by 2002:a05:600c:24c:b0:401:b204:3b84 with SMTP id 12-20020a05600c024c00b00401b2043b84mr627376wmj.40.1694123757756;
        Thu, 07 Sep 2023 14:55:57 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id s14-20020a7bc38e000000b00401d8181f8bsm3544051wmj.25.2023.09.07.14.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 14:55:57 -0700 (PDT)
Date:   Thu, 7 Sep 2023 22:55:55 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
Message-ID: <20230907215555.exjxho34ntkjmn6r@airbuntu>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <20230820210640.585311-3-qyousef@layalina.io>
 <CAKfTPtDY48jpO+b-2KXawzxh-ty+FMKX6YUXioNR7kpgO=ua6Q@mail.gmail.com>
 <20230829163740.uadhv2jfjuumqk3w@airbuntu>
 <CAKfTPtCP6uX79dOrzN4PxFTMBFrDAMOOrWyZrsVypUQ0RY7BAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCP6uX79dOrzN4PxFTMBFrDAMOOrWyZrsVypUQ0RY7BAA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/23 15:47, Vincent Guittot wrote:
> On Tue, 29 Aug 2023 at 18:37, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 08/29/23 16:35, Vincent Guittot wrote:
> > > On Sun, 20 Aug 2023 at 23:08, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > DVFS headroom is applied after we calculate the effective_cpu_util()
> > > > which is where we honour uclamp constraints. It makes more sense to
> > > > apply the headroom there once and let all users naturally get the right
> > > > thing without having to sprinkle the call around in various places.
> > >
> > > You have to take care of not mixing scheduler and cpufreq constraint and policy.
> > >
> > > uclamp is a scheduler feature to highlight that the utilization
> > > requirement of a task can't go above a level.
> >
> > uclamp is a performance hint, which utilization is how we represent it
> > internally. A task with uclamp of 800 is not the same as util being actually
> > 800. In our previous discussions around util_fits_cpu() we had similar
> > discussion on how the two can't be treated the same.
> >
> > Same with uclamp_min; if it is set to 1024 but there is a task with util say
> > 100, this task shouldn't cause overutilized as its actual utilization actually
> > fits, but it just asked to run at a higher performance point. The actual
> > utilization has to be in the over utilized range. Unless uclamp_max forces it
> > to fit of course.
> >
> > So uclamp_max sets a cap to the performance that the task is allowed to reach.
> > And this translates into frequency selection and cpu selection (in case of HMP)
> > by design.
> 
> The dvfs head room is a sole property of cpufreq and the scheduler
> doesn't care about it. Scheduler should provide some cpu utilization
> hints. Then what cpufreq will do based on the utilization, the HW
> constraint and the policy is out of scheduler scope.
> 
> This headroom is there only because energy model wants to forecast
> what will be the frequency that cpufreq will select later on but
> scheduler doesn't care
> 
> >
> > I don't think we're mixing matters here. But the headroom should be applied to
> > actual utilization, not uclamp. If the rq is capped to a specific performance
> > level, we should honour this.
> >
> > We do the same with iowait boost where it is capped by uclamp_max. A task
> > capped by uclamp_max shouldn't be the trigger of running at a frequency higher
> > than this point. Otherwise we'd need to expose all these internal details to
> > the user, which I think we all agree isn't something to consider at all.
> >
> > >
> > > dvfs head room is a cpufreq decision to anticipate either hw
> > > limitation and responsiveness problem or performance hints.
> > >
> > > they come from different sources and rational and this patch mixed
> > > them which i'm not sure is a correct thing to do
> >
> > I don't think I'm mixing them up to be honest.
> >
> > The governor is driven by effective_cpu_util() to tell it what is the
> > effective_cpu_util() when making frequency selection. This function takes into
> > account all the factors that could impact frequency selection including all type
> > of rq pressures (except thermal). I think it is appropriate to take headroom
> > into account there and make sure we honour uclamp_max hint to cap the
> > performance appropriately based on the effective uclamp_max value of the rq.
> >
> > For example if actually util was 640, then after the headroom it'd be 800. And
> > if uclamp_max is 800, then this task will still get the 1.25 headroom. We are
> > not changing this behavior.
> >
> > But if the task goes beyond that, then it'll stop at 800 because this what the
> > request is all about. A headroom beyond this point is not required because the
> > task (or rq to be more precise) is capped to this performance point and
> > regardless how busy the cpu gets in terms of real utilization or headroom, it
> > shouldn't go beyond this point. ie: if a task is a 1024 but uclamp_max of is
> > 800 then it'll only get a performance equivalent to OPP@800 would give.
> >
> > If we don't do that uclamp_max range effectively is from 0-819 (based on
> > current headroom setting of 1.25). Which is not what we want or what we're
> > telling userspace. Userspace sees the whole system performance levels
> > abstracted from 0 - 1024. As it should. The only effect they would observe and
> > there's no way around it is that OPPs are discrete points. So in reality our
> > 0-1024 is a staircase where a range of util values will map to the same OPP and
> > then we'll get a jump. So the user can end up requesting for example 700 and
> > 720 and not notice any difference because they both map to the same OPP.
> > I don't think we can fix that - but maybe I should add it to the uclamp doc as
> > a caveat when setting uclamp.
> >
> > >
> > > >
> > > > Before this fix running
> > > >
> > > >         uclampset -M 800 cat /dev/zero > /dev/null
> > > >
> > > > Will cause the test system to run at max freq of 2.8GHz. After the fix
> > > > it runs at 2.2GHz instead which is the correct value that matches the
> > > > capacity of 800.
> > >
> > > So a task with an utilization of 800 will run at higher freq than a
> > > task clamped to 800 by uclamp ? Why should they run at different freq
> > > for the same utilization ?
> >
> > Because uclamp sets an upper limit on the performance level the task should be
> > able to achieve. Imagine a task is 1024 and capped to 800, it should not run at
> > max frequency, right? What's the point of the uclamp_max hint if the headroom
> 
> Who knows ? Here we try to predict the coming utilization of the cpu
> and this prediction is only partial so cpufreq might want to keep some
> headroom even if uclamp max is applied to a cfs rq. Anticipate
> unpredictable irq stolen time

I struggle to see why we need headroom after uclamp_max. But I think I'm
starting to see what you're getting at. I think you'd like not to make
assumption in the scheduler and hide this logic in the governor itself?

> 
> IMO, dvfs_headroom should never be visible in scheduler code. This is
> the case now; it's only visible by cpufreq which is the "owner" and
> energy model which tries to predict cpufreq behavior

Okay.

> 
> > will cause it to run at max anyway? We lost the meaning of the hint. And if
> > this headroom changes in the future, people will start observing different
> > behavior for existing uclamp_max settings on the same system because of this
> > this rightfully hidden and unaccounted for factor.
> >
> > >
> > > >
> > > > Note that similar problem exist for uclamp_min. If util was 50, and
> > > > uclamp_min is 100. Since we apply_dvfs_headroom() after apply uclamp
> > > > constraints, we'll end up with util of 125 instead of 100. IOW, we get
> > > > boosted twice, first time by uclamp_min, and second time by dvfs
> > > > headroom.
> > > >
> > > > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > > > ---
> > > >  include/linux/energy_model.h     |  1 -
> > > >  kernel/sched/core.c              | 11 ++++++++---
> > > >  kernel/sched/cpufreq_schedutil.c |  5 ++---
> > > >  3 files changed, 10 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> > > > index 6ebde4e69e98..adec808b371a 100644
> > > > --- a/include/linux/energy_model.h
> > > > +++ b/include/linux/energy_model.h
> > > > @@ -243,7 +243,6 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> > > >         scale_cpu = arch_scale_cpu_capacity(cpu);
> > > >         ps = &pd->table[pd->nr_perf_states - 1];
> > > >
> > > > -       max_util = apply_dvfs_headroom(max_util);
> > > >         max_util = min(max_util, allowed_cpu_cap);
> > > >         freq = map_util_freq(max_util, ps->frequency, scale_cpu);
> > > >
> > > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > > index efe3848978a0..441d433c83cd 100644
> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -7439,8 +7439,10 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> > > >          * frequency will be gracefully reduced with the utilization decay.
> > > >          */
> > > >         util = util_cfs + cpu_util_rt(rq);
> > > > -       if (type == FREQUENCY_UTIL)
> > > > +       if (type == FREQUENCY_UTIL) {
> > > > +               util = apply_dvfs_headroom(util);
> > >
> > > This is not the same as before because utilization has not being
> > > scaled by irq steal time yet
> >
> > We do the scaling below, no?
> >
> > AFAICS, we had:
> >
> >         (util_cfs + util_rt + irq + ((max-irq)*(util_cfs + util_rt)/max)+ dl_bw) * scale
> 
> I think it's only :
>   ((util_cfs + util_rt) * (max -irq) / max + irq + dl_bw) * scale
> 
> and it' s effectively similar

+1

> 
> >
> > Using U = (util_cfs + util_rt) * scale
> >
> > we can write this after the multiplication
> >
> >         U + irq * scale + ((max-irq)*U/max) + dl_bw * scale
> >
> > >
> > > >                 util = uclamp_rq_util_with(rq, util, p);
> > > > +       }
> > > >
> > > >         dl_util = cpu_util_dl(rq);
> > > >
> > > > @@ -7471,9 +7473,12 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> > > >          *              max - irq
> > > >          *   U' = irq + --------- * U
> > > >          *                 max
> > > > +        *
> > > > +        * We only need to apply dvfs headroom to irq part since the util part
> > > > +        * already had it applied.
> > > >          */
> > > >         util = scale_irq_capacity(util, irq, max);
> > > > -       util += irq;
> > > > +       util += type ==  FREQUENCY_UTIL ? apply_dvfs_headroom(irq) : irq;
> > > >
> > > >         /*
> > > >          * Bandwidth required by DEADLINE must always be granted while, for
> > > > @@ -7486,7 +7491,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> > > >          * an interface. So, we only do the latter for now.
> > > >          */
> > > >         if (type == FREQUENCY_UTIL)
> > > > -               util += cpu_bw_dl(rq);
> > > > +               util += apply_dvfs_headroom(cpu_bw_dl(rq));
> > >
> > > If we follow your reasoning with uclamp on the dl bandwidth, should we
> > > not skip this as well ?
> >
> > I do remove this in patch 4. Can fold that one into this one if you like.
> > I opted to keep the current behavior in this patch and remove these later in
> > patch 4.
> >
> > I do think that both RT and DL shouldn't need DVFS headroom in general as they
> > both 'disable' it by default.
> 
> and the scheduler in general doesn't care about DVFS headroom.
> 
> I don't think it's the right way to fix your problem of selecting the
> right frequency on your platform. It would be better to get a proper
> interface between EM and cpufreq like
> cpufreq_give_me_freq_for_this_utilization_ctx.

Hmm is the problem then that effective_cpu_util() was moved to scheduler and it
should move back to schedutil and provide a proper interface to connect the two
in abstracted way?

> 
> And  cpufreq needs 2 information:
> - the utilization of the cpu
> - the uclamp/performance/bandwidth hints on this cpu because the
> uclamp_max hints are screwed up by irq scaling anyway.
> 
> For example:
> 
> irq = 256
> util = 800 but uclamp=512
> 
> If I follow your reasoning about the uclamp being a performance hint
> and uclamp=512 means that we should not go above 512 just for cfs+rt,

Yes. We already limit it to 512 now. With the change we'll limit it after the
headroom is applied to them.

> we should stay at 512 in this case because irq only needs 256 which is
> below the 512 bandwidth. The utilization reported to cpufreq will be

Hmm IIUC, no. irq pressure will be added on top as normal. It's just cfs+rt
will be restricted by their uclamp settings _after_ the headroom is applied.

> above 512 whatever the current (720)  formula or your proposal (608).
> In the case of uclamp, it should be applied after having been scaled
> by irq time.

I lost you a bit here. I'm not sure how you reached the 720 and 608 numbers.

So the way I'm proposing it here

	util = cfs + rt + dvfs_headroom(cfs+rt) = 800 + 0.25 * 800 = 1000
	util = uclamp_rq_util_with(rq, util, NULL) = 512
	util = scale_rq_capacity(512, 256, 1024) = 0.75 * 512 = 384
	util += dvfs_headroom(irq) = 384 + 256 + 0.25 * 256 = 704
	util += dvfs_headroom(dl_bw) = 704

> 
> So we should have reported utilization of 720 with a bandwidth
> requirement of 512 and then cpufreq can applies its headroom if needed

The key part I'm changing is this

	util = cfs + rt + dvfs_headroom(cfs+rt) = 800 + 0.25 * 800 = 1000
	util = uclamp_rq_util_with(rq, util, NULL) = 512

Before we had (assume irq, rt and dl are 0 for simplicity and a single task is
running)

	util = cfs = 800
	util = uclamp_rq_util_with(rq, util, NULL) = 512
	util = dvfs_headroom(util) = 512 * 0.25 * 512 = 640

So we are running higher than we are allowed to. So applying the headroom
after taking uclamp constraints into account is the problem.

IIUC and your concerns are about how scheduler and schedutil are interacting
loses some abstraction, then yeah this makes sense and can refactor code to
better abstract the two and keep them decoupled.

But if you think the order the headroom is applied should be the way it is,
then this doesn't fix the problem.

A good use case to consider is a single task running at 1024. If I want to
limit it to 80% using uclamp_max, how can this be enforced? With current code,
the task will continue to run at 1024; which is the problem.

Running at 640 instead of 512 is still a problem too as this could be 1 or
2 OPP higher than what we want to allow; and there could be significant power
difference between those OPPs.


Thanks!

--
Qais Yousef
