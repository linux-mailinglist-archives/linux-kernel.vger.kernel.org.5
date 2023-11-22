Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1037F3EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjKVHi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjKVHiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:38:51 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF8BB2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:38:47 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c25dfc0aeaso1147894a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700638727; x=1701243527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FHv3v4zMtadRDYgbIgBMHVtVwmSmXQEpws2g8Cp+jAE=;
        b=usR0qey9YMHUOEFeV8kD3F3kWcYfmEnuZL9XWKSHT3u4nF049634bSyUlbtCQ1V3pF
         iktw9JctQygcp3cJcDF8Efx/bCuwkL1PdMn0VyC86Vk+N9SSjsuPHKcYOjTCdIyXmubI
         3PXPgNdh9ufyQlsmkS3CyDFTT6PUMYg+xnLkKJkI21jrGGAe69Jq/BTLHm/W3YdYVQc3
         axO+QNSCSSBdBrqkSnLlLMAeX6712A5PmNup7X2e75w0aDf+3Edj9HIaOpnRMRXXP18/
         CpEvM/gjt03M9R9erk7iKM0+kUIIR4zK3uMi46p+lRhMdiMzYf44SM5hcr/itfAlccQq
         PTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700638727; x=1701243527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHv3v4zMtadRDYgbIgBMHVtVwmSmXQEpws2g8Cp+jAE=;
        b=tv+M/dFac8Y8Iec6vbogKFlnZARtRkTM9xS60yub1d6etZx1N2maiLFwZzkkLafLWt
         a+u8t46EOeDJwemmHUKaUFvJvlDeYwwHk3K8IXxqDuiRzlCnJN3Q3DxQG3ct8fvGtHDH
         f+VXiaKk2euhvi2Oxr/lgDlJClTxiNhZ94urLXAEmKKj3Y+bYH0UvabfCfHgwyvM2cWo
         HZ8Oot319Q/81QUrLSXTlVYrW7lusumf/Rt7YX+YhiJe6EM81ehcAbrmPpQC60Uf+e16
         vDgana/7xR120xmDy+ngXv89O9RbZ0zXp4H/8zI+4jVPQ8EuYqmg98213HMXhHNi0EBx
         MmBw==
X-Gm-Message-State: AOJu0Yzfw/TWH581wW/eUthWC6sRUaalHbSx9lZAKpWrLsWs2UVgh08U
        9YGV8H58PhGZTsxvXJSyIS3NuUMv69rTwspdHKJJbA==
X-Google-Smtp-Source: AGHT+IFi7IIz+aBSKpx/8e0LzZWvWK6f9EazpqXLPI5zDQ51dr+gRMbi4GBs61tW5z4WcQnHxxCHcyBW7etZgF3ntHE=
X-Received: by 2002:a05:6a20:428a:b0:187:5c6a:9f17 with SMTP id
 o10-20020a056a20428a00b001875c6a9f17mr1536702pzj.62.1700638726692; Tue, 21
 Nov 2023 23:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
 <20231103131821.1176294-2-vincent.guittot@linaro.org> <20231114205422.k5m6y4m5vnw7dvzj@airbuntu>
In-Reply-To: <20231114205422.k5m6y4m5vnw7dvzj@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Nov 2023 08:38:35 +0100
Message-ID: <CAKfTPtDMEes6V2xRHavAwWrVuiZBdFAsaaxv9=-psAZCTPQWKg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] sched/schedutil: Rework performance estimation
To:     Qais Yousef <qyousef@layalina.io>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 at 17:43, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 11/03/23 14:18, Vincent Guittot wrote:
> > @@ -7410,45 +7405,41 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> >        * update_irq_load_avg().
> >        */
> >       irq = cpu_util_irq(rq);
> > -     if (unlikely(irq >= max))
> > -             return max;
> > +     if (unlikely(irq >= scale)) {
> > +             if (min)
> > +                     *min = scale;
> > +             if (max)
> > +                     *max = scale;
> > +             return scale;
> > +     }
> > +
> > +     /*
> > +      * The minimum utilization returns the highest level between:
> > +      * - the computed DL bandwidth needed with the irq pressure which
> > +      *   steals time to the deadline task.
> > +      * - The minimum bandwidth requirement for CFS and/or RT.
>
> s/bandwidth for CFS/performance for CFS/?
>
> I've seen a lot of confusion on what both means. I think you've used bandwidth
> to refer to performance but most of us look at bandwidth as actual
> cpu.share/time actually consumed by the task. I think it's important to keep
> the two concept distinguished and use common terminology as it has been a point
> of contention in various discussions on and off the list.
>
> > +      */
> > +     if (min)
> > +             *min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
> >
> >       /*
> >        * Because the time spend on RT/DL tasks is visible as 'lost' time to
> >        * CFS tasks and we use the same metric to track the effective
> >        * utilization (PELT windows are synchronized) we can directly add them
> >        * to obtain the CPU's actual utilization.
> > -      *
> > -      * CFS and RT utilization can be boosted or capped, depending on
> > -      * utilization clamp constraints requested by currently RUNNABLE
> > -      * tasks.
> > -      * When there are no CFS RUNNABLE tasks, clamps are released and
> > -      * frequency will be gracefully reduced with the utilization decay.
> >        */
> >       util = util_cfs + cpu_util_rt(rq);
> > -     if (type == FREQUENCY_UTIL)
> > -             util = uclamp_rq_util_with(rq, util, p);
> > -
> > -     dl_util = cpu_util_dl(rq);
> > +     util += cpu_util_dl(rq);
> >
> >       /*
> > -      * For frequency selection we do not make cpu_util_dl() a permanent part
> > -      * of this sum because we want to use cpu_bw_dl() later on, but we need
> > -      * to check if the CFS+RT+DL sum is saturated (ie. no idle time) such
> > -      * that we select f_max when there is no idle time.
> > -      *
> > -      * NOTE: numerical errors or stop class might cause us to not quite hit
> > -      * saturation when we should -- something for later.
> > +      * The maximum hint is a soft bandwidth requirement which can be lower
> > +      * than the actual utilization because of uclamp_max requirements
> >        */
> > -     if (util + dl_util >= max)
> > -             return max;
> > +     if (max)
> > +             *max = min(scale, uclamp_rq_get(rq, UCLAMP_MAX));
> >
> > -     /*
> > -      * OTOH, for energy computation we need the estimated running time, so
> > -      * include util_dl and ignore dl_bw.
> > -      */
> > -     if (type == ENERGY_UTIL)
> > -             util += dl_util;
> > +     if (util >= scale)
> > +             return scale;
> >
> >       /*
> >        * There is still idle time; further improve the number by using the
> > @@ -7459,28 +7450,15 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> >        *   U' = irq + --------- * U
> >        *                 max
> >        */
> > -     util = scale_irq_capacity(util, irq, max);
> > +     util = scale_irq_capacity(util, irq, scale);
> >       util += irq;
> >
> > -     /*
> > -      * Bandwidth required by DEADLINE must always be granted while, for
> > -      * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
> > -      * to gracefully reduce the frequency when no tasks show up for longer
> > -      * periods of time.
> > -      *
> > -      * Ideally we would like to set bw_dl as min/guaranteed freq and util +
> > -      * bw_dl as requested freq. However, cpufreq is not yet ready for such
> > -      * an interface. So, we only do the latter for now.
> > -      */
> > -     if (type == FREQUENCY_UTIL)
> > -             util += cpu_bw_dl(rq);
> > -
> > -     return min(max, util);
> > +     return min(scale, util);
> >  }
> >
> >  unsigned long sched_cpu_util(int cpu)
> >  {
> > -     return effective_cpu_util(cpu, cpu_util_cfs(cpu), ENERGY_UTIL, NULL);
> > +     return effective_cpu_util(cpu, cpu_util_cfs(cpu), NULL, NULL);
> >  }
> >  #endif /* CONFIG_SMP */
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 458d359f5991..38accd8c854b 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -47,7 +47,7 @@ struct sugov_cpu {
> >       u64                     last_update;
> >
> >       unsigned long           util;
> > -     unsigned long           bw_dl;
> > +     unsigned long           bw_min;
> >
> >       /* The field below is for single-CPU policies only: */
> >  #ifdef CONFIG_NO_HZ_COMMON
> > @@ -143,7 +143,6 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >       unsigned int freq = arch_scale_freq_invariant() ?
> >                               policy->cpuinfo.max_freq : policy->cur;
> >
> > -     util = map_util_perf(util);
> >       freq = map_util_freq(util, freq, max);
> >
> >       if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> > @@ -153,14 +152,35 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >       return cpufreq_driver_resolve_freq(policy, freq);
> >  }
> >
> > +unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> > +                              unsigned long min,
> > +                              unsigned long max)
> > +{
> > +     struct rq *rq = cpu_rq(cpu);
> > +
> > +     if (rt_rq_is_runnable(&rq->rt))
> > +             return max;
>
> I think this breaks old behavior. When uclamp_is_used() the frequency of the RT
> task is determined by uclamp_min; but you revert this to the old behavior where
> we always return max, no? You should check for !uclamp_is_used(); otherwise let
> the rest of the function exec as usual.

Yes, I made a shortcut assuming that max would be adjusted to the max
allowed freq for RT task whereas it's the min freq that is adjusted by
uclamp and that should also be adjusted without uclamp. Let me fix
that in effective_cpu_util and remove this early return from
sugov_effective_cpu_perf()

>
> > +
> > +     /* Add dvfs headroom to actual utilization */
> > +     actual = map_util_perf(actual);
>
> Can we rename this function please? It is not mapping anything, but applying
> a dvfs headroom (I suggest apply_dvfs_headroom()). Which would make the comment
> also unnecessary ;-)

I didn't want to add unnecessary renaming which often confuses
reviewers so I kept  the current function name. But this can the be
rename in a follow up patch

>
> > +     /* Actually we don't need to target the max performance */
> > +     if (actual < max)
> > +             max = actual;
> > +
> > +     /*
> > +      * Ensure at least minimum performance while providing more compute
> > +      * capacity when possible.
> > +      */
> > +     return max(min, max);
> > +}
> > +
> >  static void sugov_get_util(struct sugov_cpu *sg_cpu)
> >  {
> > -     unsigned long util = cpu_util_cfs_boost(sg_cpu->cpu);
> > -     struct rq *rq = cpu_rq(sg_cpu->cpu);
> > +     unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
> >
> > -     sg_cpu->bw_dl = cpu_bw_dl(rq);
> > -     sg_cpu->util = effective_cpu_util(sg_cpu->cpu, util,
> > -                                       FREQUENCY_UTIL, NULL);
> > +     util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
> > +     sg_cpu->bw_min = map_util_perf(min);
>
> Hmm. I don't think we need to apply_dvfs_headroom() to min here. What's the
> rationale to give headroom for min perf requirement? I think the headroom is
> only required for actual util.

This headroom only applies for bw_min that is used with
cpufreq_driver_adjust_perf(). Currently it only takes cpu_bw_dl()
which seems too low because IRQ can preempt DL. So I added the average
irq utilization into bw_min which is only an estimate and needs some
headroom. That being said I can probably stay with current behavior
for now and remove headroom

>
> And is it right to mix irq and uclamp_min with bw_min which is for DL? We might

cpu_bw_dl() is not the actual utilization by DL task but the computed
bandwidth which can be seen as min performance level

> be mixing things up here. If not, I think we need a comment on how bw_min now
> should be looked at/treated.
>
>
> Thanks!
>
> --
> Qais Yousef
>
> > +     sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
> >  }
> >
> >  /**
> > @@ -306,7 +326,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
> >   */
> >  static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
> >  {
> > -     if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
> > +     if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)
> >               sg_cpu->sg_policy->limits_changed = true;
> >  }
> >
> > @@ -407,8 +427,8 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
> >           sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
> >               sg_cpu->util = prev_util;
> >
> > -     cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
> > -                                map_util_perf(sg_cpu->util), max_cap);
> > +     cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
> > +                                sg_cpu->util, max_cap);
> >
> >       sg_cpu->sg_policy->last_freq_update_time = time;
> >  }
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8767988242ee..ed64f2eaaa2a 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7671,7 +7671,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
> >       for_each_cpu(cpu, pd_cpus) {
> >               unsigned long util = cpu_util(cpu, p, -1, 0);
> >
> > -             busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
> > +             busy_time += effective_cpu_util(cpu, util, NULL, NULL);
> >       }
> >
> >       eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
> > @@ -7694,7 +7694,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
> >       for_each_cpu(cpu, pd_cpus) {
> >               struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
> >               unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
> > -             unsigned long eff_util;
> > +             unsigned long eff_util, min, max;
> >
> >               /*
> >                * Performance domain frequency: utilization clamping
> > @@ -7703,7 +7703,23 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
> >                * NOTE: in case RT tasks are running, by default the
> >                * FREQUENCY_UTIL's utilization can be max OPP.
> >                */
> > -             eff_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL, tsk);
> > +             eff_util = effective_cpu_util(cpu, util, &min, &max);
> > +
> > +             /* Task's uclamp can modify min and max value */
> > +             if (tsk && uclamp_is_used()) {
> > +                     min = max(min, uclamp_eff_value(p, UCLAMP_MIN));
> > +
> > +                     /*
> > +                      * If there is no active max uclamp constraint,
> > +                      * directly use task's one otherwise keep max
> > +                      */
> > +                     if (uclamp_rq_is_idle(cpu_rq(cpu)))
> > +                             max = uclamp_eff_value(p, UCLAMP_MAX);
> > +                     else
> > +                             max = max(max, uclamp_eff_value(p, UCLAMP_MAX));
> > +             }
> > +
> > +             eff_util = sugov_effective_cpu_perf(cpu, eff_util, min, max);
> >               max_util = max(max_util, eff_util);
> >       }
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 2e5a95486a42..302b451a3fd8 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2961,24 +2961,14 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
> >  #endif
> >
> >  #ifdef CONFIG_SMP
> > -/**
> > - * enum cpu_util_type - CPU utilization type
> > - * @FREQUENCY_UTIL:  Utilization used to select frequency
> > - * @ENERGY_UTIL:     Utilization used during energy calculation
> > - *
> > - * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
> > - * need to be aggregated differently depending on the usage made of them. This
> > - * enum is used within effective_cpu_util() to differentiate the types of
> > - * utilization expected by the callers, and adjust the aggregation accordingly.
> > - */
> > -enum cpu_util_type {
> > -     FREQUENCY_UTIL,
> > -     ENERGY_UTIL,
> > -};
> > -
> >  unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> > -                              enum cpu_util_type type,
> > -                              struct task_struct *p);
> > +                              unsigned long *min,
> > +                              unsigned long *max);
> > +
> > +unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> > +                              unsigned long min,
> > +                              unsigned long max);
> > +
> >
> >  /*
> >   * Verify the fitness of task @p to run on @cpu taking into account the
> > --
> > 2.34.1
> >
