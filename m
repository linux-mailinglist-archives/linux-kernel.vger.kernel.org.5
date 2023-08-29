Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC6878C9C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbjH2QiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbjH2Qhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:37:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED572129
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:37:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso39642925e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693327062; x=1693931862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5NFsJWiFLxuFwl1EtWT4+lMNFFFs9m756sXu41LDDc=;
        b=la4/8wPcMgNVCUJ1o/pxJDjq95ELpHln+3N6PIBdnXMRiLzK+iYsWDQaIxNSQmbBG7
         jH8T+Hwk2+UCjACgbZ0K5jqHnR9dgYnpns4ZtqewZ6+sn7h78wvSR8Ujr2Ukg1i0Lydi
         WcM7zASit5IboH2hn9cHso9ie0lLUPpvMymTiYcxIbTyRLildi2IcUcrgwFiVdahekU/
         NXjmsJ2YALyJ+kHxMp8L6FpkDkEEK1wODOf6d/KybBEkFhJnpiRh9PkBCyDNM3xV/kbV
         oRZMb2dYAWP7vzAGu4fPAR3fPihfzWfHoylfwW/SeLGDaDFf/Kb1j/U8IIuEABO4+bwb
         YwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693327062; x=1693931862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5NFsJWiFLxuFwl1EtWT4+lMNFFFs9m756sXu41LDDc=;
        b=MPYBjI7KDuAFGxIAk3n2PFtDnGRkSSUEcydsBfCRVsHLTinLkLliTIc9C6Hnrw1Qvn
         hzZcqWbjfjeFhNKljs7igUcbiuZXbbMhWPgc8MrjGA+gVE2qbTHniqDiyS9+FzG5M/St
         dggc5f7SFU4U80HG3a+Ww9hPW5k2t/I5zxWRHGHZsrytvICd9lI2cbnlnZU+MeLfpB6o
         zjvG2h5HblrNATuLcGXm+RusXHEQ7z8RahVjdTQLS4jeuLzxYaiHqY7twp1V8F5kCD8m
         5bMnZNPqLzhrIiYPMDMnV4Q89Fnb1z+9r2EETMTxvqvFGSrXCBXyhAV3XxYANkGVz5g7
         9DHw==
X-Gm-Message-State: AOJu0YyUnXe+jd6Y3ox4kOv0+mO9vQRxQVvWMT49pEAHhHZubVfB1wdc
        GKtvvg3jdUC7D7bIY/jc8AXi5w==
X-Google-Smtp-Source: AGHT+IEAYaMnD3Vdtzozuhq2AHDXpWlJzF4wgiZrhLV0vLTlTtr05Z49Uzvc2y8r4muGhZRIieHp/w==
X-Received: by 2002:a05:600c:3653:b0:401:b0f2:88b4 with SMTP id y19-20020a05600c365300b00401b0f288b4mr10942322wmq.26.1693327062257;
        Tue, 29 Aug 2023 09:37:42 -0700 (PDT)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id k8-20020a7bc408000000b003fe23b10fdfsm17599960wmi.36.2023.08.29.09.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 09:37:41 -0700 (PDT)
Date:   Tue, 29 Aug 2023 17:37:40 +0100
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
Message-ID: <20230829163740.uadhv2jfjuumqk3w@airbuntu>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <20230820210640.585311-3-qyousef@layalina.io>
 <CAKfTPtDY48jpO+b-2KXawzxh-ty+FMKX6YUXioNR7kpgO=ua6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDY48jpO+b-2KXawzxh-ty+FMKX6YUXioNR7kpgO=ua6Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/23 16:35, Vincent Guittot wrote:
> On Sun, 20 Aug 2023 at 23:08, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > DVFS headroom is applied after we calculate the effective_cpu_util()
> > which is where we honour uclamp constraints. It makes more sense to
> > apply the headroom there once and let all users naturally get the right
> > thing without having to sprinkle the call around in various places.
> 
> You have to take care of not mixing scheduler and cpufreq constraint and policy.
> 
> uclamp is a scheduler feature to highlight that the utilization
> requirement of a task can't go above a level.

uclamp is a performance hint, which utilization is how we represent it
internally. A task with uclamp of 800 is not the same as util being actually
800. In our previous discussions around util_fits_cpu() we had similar
discussion on how the two can't be treated the same.

Same with uclamp_min; if it is set to 1024 but there is a task with util say
100, this task shouldn't cause overutilized as its actual utilization actually
fits, but it just asked to run at a higher performance point. The actual
utilization has to be in the over utilized range. Unless uclamp_max forces it
to fit of course.

So uclamp_max sets a cap to the performance that the task is allowed to reach.
And this translates into frequency selection and cpu selection (in case of HMP)
by design.

I don't think we're mixing matters here. But the headroom should be applied to
actual utilization, not uclamp. If the rq is capped to a specific performance
level, we should honour this.

We do the same with iowait boost where it is capped by uclamp_max. A task
capped by uclamp_max shouldn't be the trigger of running at a frequency higher
than this point. Otherwise we'd need to expose all these internal details to
the user, which I think we all agree isn't something to consider at all.

> 
> dvfs head room is a cpufreq decision to anticipate either hw
> limitation and responsiveness problem or performance hints.
> 
> they come from different sources and rational and this patch mixed
> them which i'm not sure is a correct thing to do

I don't think I'm mixing them up to be honest.

The governor is driven by effective_cpu_util() to tell it what is the
effective_cpu_util() when making frequency selection. This function takes into
account all the factors that could impact frequency selection including all type
of rq pressures (except thermal). I think it is appropriate to take headroom
into account there and make sure we honour uclamp_max hint to cap the
performance appropriately based on the effective uclamp_max value of the rq.

For example if actually util was 640, then after the headroom it'd be 800. And
if uclamp_max is 800, then this task will still get the 1.25 headroom. We are
not changing this behavior.

But if the task goes beyond that, then it'll stop at 800 because this what the
request is all about. A headroom beyond this point is not required because the
task (or rq to be more precise) is capped to this performance point and
regardless how busy the cpu gets in terms of real utilization or headroom, it
shouldn't go beyond this point. ie: if a task is a 1024 but uclamp_max of is
800 then it'll only get a performance equivalent to OPP@800 would give.

If we don't do that uclamp_max range effectively is from 0-819 (based on
current headroom setting of 1.25). Which is not what we want or what we're
telling userspace. Userspace sees the whole system performance levels
abstracted from 0 - 1024. As it should. The only effect they would observe and
there's no way around it is that OPPs are discrete points. So in reality our
0-1024 is a staircase where a range of util values will map to the same OPP and
then we'll get a jump. So the user can end up requesting for example 700 and
720 and not notice any difference because they both map to the same OPP.
I don't think we can fix that - but maybe I should add it to the uclamp doc as
a caveat when setting uclamp.

> 
> >
> > Before this fix running
> >
> >         uclampset -M 800 cat /dev/zero > /dev/null
> >
> > Will cause the test system to run at max freq of 2.8GHz. After the fix
> > it runs at 2.2GHz instead which is the correct value that matches the
> > capacity of 800.
> 
> So a task with an utilization of 800 will run at higher freq than a
> task clamped to 800 by uclamp ? Why should they run at different freq
> for the same utilization ?

Because uclamp sets an upper limit on the performance level the task should be
able to achieve. Imagine a task is 1024 and capped to 800, it should not run at
max frequency, right? What's the point of the uclamp_max hint if the headroom
will cause it to run at max anyway? We lost the meaning of the hint. And if
this headroom changes in the future, people will start observing different
behavior for existing uclamp_max settings on the same system because of this
this rightfully hidden and unaccounted for factor.

> 
> >
> > Note that similar problem exist for uclamp_min. If util was 50, and
> > uclamp_min is 100. Since we apply_dvfs_headroom() after apply uclamp
> > constraints, we'll end up with util of 125 instead of 100. IOW, we get
> > boosted twice, first time by uclamp_min, and second time by dvfs
> > headroom.
> >
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >  include/linux/energy_model.h     |  1 -
> >  kernel/sched/core.c              | 11 ++++++++---
> >  kernel/sched/cpufreq_schedutil.c |  5 ++---
> >  3 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> > index 6ebde4e69e98..adec808b371a 100644
> > --- a/include/linux/energy_model.h
> > +++ b/include/linux/energy_model.h
> > @@ -243,7 +243,6 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> >         scale_cpu = arch_scale_cpu_capacity(cpu);
> >         ps = &pd->table[pd->nr_perf_states - 1];
> >
> > -       max_util = apply_dvfs_headroom(max_util);
> >         max_util = min(max_util, allowed_cpu_cap);
> >         freq = map_util_freq(max_util, ps->frequency, scale_cpu);
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index efe3848978a0..441d433c83cd 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7439,8 +7439,10 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> >          * frequency will be gracefully reduced with the utilization decay.
> >          */
> >         util = util_cfs + cpu_util_rt(rq);
> > -       if (type == FREQUENCY_UTIL)
> > +       if (type == FREQUENCY_UTIL) {
> > +               util = apply_dvfs_headroom(util);
> 
> This is not the same as before because utilization has not being
> scaled by irq steal time yet

We do the scaling below, no?

AFAICS, we had:

	(util_cfs + util_rt + irq + ((max-irq)*(util_cfs + util_rt)/max)+ dl_bw) * scale

Using U = (util_cfs + util_rt) * scale

we can write this after the multiplication

	U + irq * scale + ((max-irq)*U/max) + dl_bw * scale

> 
> >                 util = uclamp_rq_util_with(rq, util, p);
> > +       }
> >
> >         dl_util = cpu_util_dl(rq);
> >
> > @@ -7471,9 +7473,12 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> >          *              max - irq
> >          *   U' = irq + --------- * U
> >          *                 max
> > +        *
> > +        * We only need to apply dvfs headroom to irq part since the util part
> > +        * already had it applied.
> >          */
> >         util = scale_irq_capacity(util, irq, max);
> > -       util += irq;
> > +       util += type ==  FREQUENCY_UTIL ? apply_dvfs_headroom(irq) : irq;
> >
> >         /*
> >          * Bandwidth required by DEADLINE must always be granted while, for
> > @@ -7486,7 +7491,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> >          * an interface. So, we only do the latter for now.
> >          */
> >         if (type == FREQUENCY_UTIL)
> > -               util += cpu_bw_dl(rq);
> > +               util += apply_dvfs_headroom(cpu_bw_dl(rq));
> 
> If we follow your reasoning with uclamp on the dl bandwidth, should we
> not skip this as well ?

I do remove this in patch 4. Can fold that one into this one if you like.
I opted to keep the current behavior in this patch and remove these later in
patch 4.

I do think that both RT and DL shouldn't need DVFS headroom in general as they
both 'disable' it by default.


Thanks!

--
Qais Yousef
