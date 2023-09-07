Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8B5797413
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344826AbjIGPdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbjIGPcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:11 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3026135
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:31:46 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-44e8d9e6ca0so427660137.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100657; x=1694705457; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=leZnxQ3mc0Y64TrxYwQ1se3DBG/OZoqkOEKgPH9MpQQ=;
        b=Wp5Fj1v0sAc7wogd0yZ6ewanOXeSc3/WP8pziEVmyAB4R+CNYg80LhvwGSKDh+BpTj
         HtprPhQrY0dHi3Hy1g+KSqQufoIdeVB0WYY0+uB0yNZKE+S/RlRjvzs7nsTEAgbPyGuP
         NREo9nb3o48g3IBE4N/wtE9VATTXf4cXoIaBYWCO3EKAQlJFCQ8AqsW2RU2T7m+zQ4vF
         O2+vT+hvXO749aigxP3lNc2Wr2Hl1GocpI8YCHUEoxEWHn3EwN8DEuEhfbaBc3yXAjca
         x4oDhkSRF2G5WczuUe6Mbqkl3D8TlBvIlOE3i0CoEwY55myrWalFT4frwybNB4Vd0kE4
         c7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100657; x=1694705457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leZnxQ3mc0Y64TrxYwQ1se3DBG/OZoqkOEKgPH9MpQQ=;
        b=lde9Q8lwDPy/RFRx8xgPLzbGfmBg0TiWtFWa8s0GEit6e97vkAa2sIZUjqEaTy3GHh
         SpRTx5OklEOPCJj20yqKR/8O1nazHj9LFzPHLsQfIr1l++qnEVlzqNZz3RVX+5GXxaIZ
         MezJJUAaYk+Qm4NfQBuP1W69XAY52zyoZocuTFES0cTAF8850Xv7PUMQem2qJIx6wikL
         QuUOMnj8RXZm/4XM/P9EbAsVPw30/I4wqnyE1ZOz47UH84R4aqN9gbbb/wlwGy0jlhc+
         /ue5SwoihA/FLz3hF0FH4WHGXYTrLIEQEpNbQlNYTkQU+hYEiRLCJTCZ49aZeJoGZai0
         guog==
X-Gm-Message-State: AOJu0Yzxv9o9EqycWXWb+tSkpeMwc/ssN2SI5h8TZrnpFppUaz05vdIu
        oLbLfhI05Y22EF9SsFLthTe+t9mh7MfzdE+Dni/M7cU9SchOYG1nIYU=
X-Google-Smtp-Source: AGHT+IEBVVh25I8axDv4eSe1s2AmtWC7nch4AjPksBX9fVwsSKmVvEAvIs4oH6u6oUQFPX4VBHAjoxwYg4YPHSHon98=
X-Received: by 2002:a17:90a:408f:b0:26b:13b7:22f9 with SMTP id
 l15-20020a17090a408f00b0026b13b722f9mr14918323pjg.22.1694094457611; Thu, 07
 Sep 2023 06:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230820210640.585311-1-qyousef@layalina.io> <20230820210640.585311-3-qyousef@layalina.io>
 <CAKfTPtDY48jpO+b-2KXawzxh-ty+FMKX6YUXioNR7kpgO=ua6Q@mail.gmail.com> <20230829163740.uadhv2jfjuumqk3w@airbuntu>
In-Reply-To: <20230829163740.uadhv2jfjuumqk3w@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 7 Sep 2023 15:47:26 +0200
Message-ID: <CAKfTPtCP6uX79dOrzN4PxFTMBFrDAMOOrWyZrsVypUQ0RY7BAA@mail.gmail.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
To:     Qais Yousef <qyousef@layalina.io>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 18:37, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 08/29/23 16:35, Vincent Guittot wrote:
> > On Sun, 20 Aug 2023 at 23:08, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > DVFS headroom is applied after we calculate the effective_cpu_util()
> > > which is where we honour uclamp constraints. It makes more sense to
> > > apply the headroom there once and let all users naturally get the right
> > > thing without having to sprinkle the call around in various places.
> >
> > You have to take care of not mixing scheduler and cpufreq constraint and policy.
> >
> > uclamp is a scheduler feature to highlight that the utilization
> > requirement of a task can't go above a level.
>
> uclamp is a performance hint, which utilization is how we represent it
> internally. A task with uclamp of 800 is not the same as util being actually
> 800. In our previous discussions around util_fits_cpu() we had similar
> discussion on how the two can't be treated the same.
>
> Same with uclamp_min; if it is set to 1024 but there is a task with util say
> 100, this task shouldn't cause overutilized as its actual utilization actually
> fits, but it just asked to run at a higher performance point. The actual
> utilization has to be in the over utilized range. Unless uclamp_max forces it
> to fit of course.
>
> So uclamp_max sets a cap to the performance that the task is allowed to reach.
> And this translates into frequency selection and cpu selection (in case of HMP)
> by design.

The dvfs head room is a sole property of cpufreq and the scheduler
doesn't care about it. Scheduler should provide some cpu utilization
hints. Then what cpufreq will do based on the utilization, the HW
constraint and the policy is out of scheduler scope.

This headroom is there only because energy model wants to forecast
what will be the frequency that cpufreq will select later on but
scheduler doesn't care

>
> I don't think we're mixing matters here. But the headroom should be applied to
> actual utilization, not uclamp. If the rq is capped to a specific performance
> level, we should honour this.
>
> We do the same with iowait boost where it is capped by uclamp_max. A task
> capped by uclamp_max shouldn't be the trigger of running at a frequency higher
> than this point. Otherwise we'd need to expose all these internal details to
> the user, which I think we all agree isn't something to consider at all.
>
> >
> > dvfs head room is a cpufreq decision to anticipate either hw
> > limitation and responsiveness problem or performance hints.
> >
> > they come from different sources and rational and this patch mixed
> > them which i'm not sure is a correct thing to do
>
> I don't think I'm mixing them up to be honest.
>
> The governor is driven by effective_cpu_util() to tell it what is the
> effective_cpu_util() when making frequency selection. This function takes into
> account all the factors that could impact frequency selection including all type
> of rq pressures (except thermal). I think it is appropriate to take headroom
> into account there and make sure we honour uclamp_max hint to cap the
> performance appropriately based on the effective uclamp_max value of the rq.
>
> For example if actually util was 640, then after the headroom it'd be 800. And
> if uclamp_max is 800, then this task will still get the 1.25 headroom. We are
> not changing this behavior.
>
> But if the task goes beyond that, then it'll stop at 800 because this what the
> request is all about. A headroom beyond this point is not required because the
> task (or rq to be more precise) is capped to this performance point and
> regardless how busy the cpu gets in terms of real utilization or headroom, it
> shouldn't go beyond this point. ie: if a task is a 1024 but uclamp_max of is
> 800 then it'll only get a performance equivalent to OPP@800 would give.
>
> If we don't do that uclamp_max range effectively is from 0-819 (based on
> current headroom setting of 1.25). Which is not what we want or what we're
> telling userspace. Userspace sees the whole system performance levels
> abstracted from 0 - 1024. As it should. The only effect they would observe and
> there's no way around it is that OPPs are discrete points. So in reality our
> 0-1024 is a staircase where a range of util values will map to the same OPP and
> then we'll get a jump. So the user can end up requesting for example 700 and
> 720 and not notice any difference because they both map to the same OPP.
> I don't think we can fix that - but maybe I should add it to the uclamp doc as
> a caveat when setting uclamp.
>
> >
> > >
> > > Before this fix running
> > >
> > >         uclampset -M 800 cat /dev/zero > /dev/null
> > >
> > > Will cause the test system to run at max freq of 2.8GHz. After the fix
> > > it runs at 2.2GHz instead which is the correct value that matches the
> > > capacity of 800.
> >
> > So a task with an utilization of 800 will run at higher freq than a
> > task clamped to 800 by uclamp ? Why should they run at different freq
> > for the same utilization ?
>
> Because uclamp sets an upper limit on the performance level the task should be
> able to achieve. Imagine a task is 1024 and capped to 800, it should not run at
> max frequency, right? What's the point of the uclamp_max hint if the headroom

Who knows ? Here we try to predict the coming utilization of the cpu
and this prediction is only partial so cpufreq might want to keep some
headroom even if uclamp max is applied to a cfs rq. Anticipate
unpredictable irq stolen time

IMO, dvfs_headroom should never be visible in scheduler code. This is
the case now; it's only visible by cpufreq which is the "owner" and
energy model which tries to predict cpufreq behavior

> will cause it to run at max anyway? We lost the meaning of the hint. And if
> this headroom changes in the future, people will start observing different
> behavior for existing uclamp_max settings on the same system because of this
> this rightfully hidden and unaccounted for factor.
>
> >
> > >
> > > Note that similar problem exist for uclamp_min. If util was 50, and
> > > uclamp_min is 100. Since we apply_dvfs_headroom() after apply uclamp
> > > constraints, we'll end up with util of 125 instead of 100. IOW, we get
> > > boosted twice, first time by uclamp_min, and second time by dvfs
> > > headroom.
> > >
> > > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > > ---
> > >  include/linux/energy_model.h     |  1 -
> > >  kernel/sched/core.c              | 11 ++++++++---
> > >  kernel/sched/cpufreq_schedutil.c |  5 ++---
> > >  3 files changed, 10 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> > > index 6ebde4e69e98..adec808b371a 100644
> > > --- a/include/linux/energy_model.h
> > > +++ b/include/linux/energy_model.h
> > > @@ -243,7 +243,6 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> > >         scale_cpu = arch_scale_cpu_capacity(cpu);
> > >         ps = &pd->table[pd->nr_perf_states - 1];
> > >
> > > -       max_util = apply_dvfs_headroom(max_util);
> > >         max_util = min(max_util, allowed_cpu_cap);
> > >         freq = map_util_freq(max_util, ps->frequency, scale_cpu);
> > >
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index efe3848978a0..441d433c83cd 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -7439,8 +7439,10 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> > >          * frequency will be gracefully reduced with the utilization decay.
> > >          */
> > >         util = util_cfs + cpu_util_rt(rq);
> > > -       if (type == FREQUENCY_UTIL)
> > > +       if (type == FREQUENCY_UTIL) {
> > > +               util = apply_dvfs_headroom(util);
> >
> > This is not the same as before because utilization has not being
> > scaled by irq steal time yet
>
> We do the scaling below, no?
>
> AFAICS, we had:
>
>         (util_cfs + util_rt + irq + ((max-irq)*(util_cfs + util_rt)/max)+ dl_bw) * scale

I think it's only :
  ((util_cfs + util_rt) * (max -irq) / max + irq + dl_bw) * scale

and it' s effectively similar

>
> Using U = (util_cfs + util_rt) * scale
>
> we can write this after the multiplication
>
>         U + irq * scale + ((max-irq)*U/max) + dl_bw * scale
>
> >
> > >                 util = uclamp_rq_util_with(rq, util, p);
> > > +       }
> > >
> > >         dl_util = cpu_util_dl(rq);
> > >
> > > @@ -7471,9 +7473,12 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> > >          *              max - irq
> > >          *   U' = irq + --------- * U
> > >          *                 max
> > > +        *
> > > +        * We only need to apply dvfs headroom to irq part since the util part
> > > +        * already had it applied.
> > >          */
> > >         util = scale_irq_capacity(util, irq, max);
> > > -       util += irq;
> > > +       util += type ==  FREQUENCY_UTIL ? apply_dvfs_headroom(irq) : irq;
> > >
> > >         /*
> > >          * Bandwidth required by DEADLINE must always be granted while, for
> > > @@ -7486,7 +7491,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> > >          * an interface. So, we only do the latter for now.
> > >          */
> > >         if (type == FREQUENCY_UTIL)
> > > -               util += cpu_bw_dl(rq);
> > > +               util += apply_dvfs_headroom(cpu_bw_dl(rq));
> >
> > If we follow your reasoning with uclamp on the dl bandwidth, should we
> > not skip this as well ?
>
> I do remove this in patch 4. Can fold that one into this one if you like.
> I opted to keep the current behavior in this patch and remove these later in
> patch 4.
>
> I do think that both RT and DL shouldn't need DVFS headroom in general as they
> both 'disable' it by default.

and the scheduler in general doesn't care about DVFS headroom.

I don't think it's the right way to fix your problem of selecting the
right frequency on your platform. It would be better to get a proper
interface between EM and cpufreq like
cpufreq_give_me_freq_for_this_utilization_ctx.

And  cpufreq needs 2 information:
- the utilization of the cpu
- the uclamp/performance/bandwidth hints on this cpu because the
uclamp_max hints are screwed up by irq scaling anyway.

For example:

irq = 256
util = 800 but uclamp=512

If I follow your reasoning about the uclamp being a performance hint
and uclamp=512 means that we should not go above 512 just for cfs+rt,
we should stay at 512 in this case because irq only needs 256 which is
below the 512 bandwidth. The utilization reported to cpufreq will be
above 512 whatever the current (720)  formula or your proposal (608).
In the case of uclamp, it should be applied after having been scaled
by irq time.

So we should have reported utilization of 720 with a bandwidth
requirement of 512 and then cpufreq can applies its headroom if needed

>
>
> Thanks!
>
> --
> Qais Yousef
