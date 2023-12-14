Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84534812A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjLNIgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjLNIgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:36:07 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DC4E8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:36:12 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cda22140f2so7399082b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702542972; x=1703147772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rmTGfO2FxAA4cbItOCZChcdN7RtnblkoXqKLhrBxV2I=;
        b=lheSNyGuxxxmuPrhJWZlK0ETW6zVmPs2PNbGarbWuSwib6JOMqqTh2GWphz6QMNjJZ
         /vY9BOs+uppSj5Xwa4RL1s+J8Kx8CoGLSmmOVpKB06vn7q8g2EdKF5AWvoS0lqUhyq9z
         q0kiQS6SgrAJnKdHf/aVDRWuxIYfxor1ZvNUw374KJPUjvuRYEI6fcRE2epMh5FE5h14
         jUsgZQUHjVtHMkS2wovp4sxTv6rqPhbZPbYf9QJpm84H/5lhk21aFJ/0kcFdhh/uC5sO
         a8i1bAYiUI3a1jLJvDS/2SW413SnXHXoFnFKG+XGjpzs1snhVahGLL1FmJtUgnwVq8/L
         pdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702542972; x=1703147772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmTGfO2FxAA4cbItOCZChcdN7RtnblkoXqKLhrBxV2I=;
        b=mYEYk2q8iYB4MsSyr6hfzOrPQGkyjGzgP2rLFIQZ38tYELNWPgiMaIYpEU9nTMUEH5
         fpIw+vj/YCiaEUFWNkTOCJ5jdVm/3/PXG6v6cTk/Z+HKgcK+TIvIkFWXQ9JAWR/4s1/s
         4PdOATvRr71ODXkMwFCkpN6gT8f8OvCLExolFMILpLNsWf1PAXwW8dSw9Tuf/aKX/PPg
         aZWvq98YAXQoYqpt72+3T6J8fDO1l6e7Bjy1FiKFbco4CnrcVTxA9tHOn2g7o0SCun3p
         qk5AiRNWKKGplJ9v/RSyKBZT/jhy9inIl/X4guPfjJ2iX609f8R6AQ8ak7hOiaoGTe79
         IxGw==
X-Gm-Message-State: AOJu0YxOVmGJ7DKC9dX0EXpwXTLTg5QLffryJe8PMfh19qlPpadoc5Qp
        /dPapW8j2V+bqYB9kIF2JJDqviwOtKC589bg9aegog==
X-Google-Smtp-Source: AGHT+IGuEOl7GKJEod2eYaQ/bBD2x8H0/Yu+/zNEqh+fdkv3OHAFEu/UBrVTLYJR30/7Grb7RrhwvUu/nUV1pEN71w8=
X-Received: by 2002:a05:6a00:6509:b0:6d0:dff8:39b3 with SMTP id
 hc9-20020a056a00650900b006d0dff839b3mr1009165pfb.58.1702542971834; Thu, 14
 Dec 2023 00:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-5-vincent.guittot@linaro.org> <274a6562-46c9-4b03-9295-c24e5eb9e6cd@arm.com>
In-Reply-To: <274a6562-46c9-4b03-9295-c24e5eb9e6cd@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 14 Dec 2023 09:36:00 +0100
Message-ID: <CAKfTPtDKRfF7QzwoDwkGKZ_DJS3ewBncifC37LADfNJwtQfiYA@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched: Rename arch_update_thermal_pressure into arch_update_hw_pressure
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     catalin.marinas@arm.com, bristot@redhat.com,
        linux-pm@vger.kernel.org, juri.lelli@redhat.com, agross@kernel.org,
        viresh.kumar@linaro.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        dietmar.eggemann@arm.com, mgorman@suse.de,
        linux-trace-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, konrad.dybcio@linaro.org,
        andersson@kernel.org, rostedt@goodmis.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bsegall@google.com,
        vschneid@redhat.com, will@kernel.org, sudeep.holla@arm.com,
        daniel.lezcano@linaro.org, mhiramat@kernel.org,
        amit.kachhap@gmail.com
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

On Thu, 14 Dec 2023 at 09:30, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
> On 12/12/23 14:27, Vincent Guittot wrote:
> > Now that cpufreq provides a pressure value to the scheduler, rename
> > arch_update_thermal_pressure into hw pressure to reflect that it returns
> > a pressure applied by HW with a high frequency and which needs filtering.
>
> I would elaborte this meaning 'filtering' here. Something like:
> '... high frequency and which needs filtering to smooth the singal and
> get an average value. That reflects available capacity of the CPU in
> longer period'

Ok I will update the commit message to provide more details

>
> > This pressure is not always related to thermal mitigation but can also be
> > generated by max current limitation as an example.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   arch/arm/include/asm/topology.h               |  6 ++---
> >   arch/arm64/include/asm/topology.h             |  6 ++---
> >   drivers/base/arch_topology.c                  | 26 +++++++++----------
> >   drivers/cpufreq/qcom-cpufreq-hw.c             |  4 +--
> >   include/linux/arch_topology.h                 |  8 +++---
> >   include/linux/sched/topology.h                |  8 +++---
> >   .../{thermal_pressure.h => hw_pressure.h}     | 14 +++++-----
> >   include/trace/events/sched.h                  |  2 +-
> >   init/Kconfig                                  | 12 ++++-----
> >   kernel/sched/core.c                           |  8 +++---
> >   kernel/sched/fair.c                           | 12 ++++-----
> >   kernel/sched/pelt.c                           | 18 ++++++-------
> >   kernel/sched/pelt.h                           | 16 ++++++------
> >   kernel/sched/sched.h                          |  4 +--
> >   14 files changed, 72 insertions(+), 72 deletions(-)
> >   rename include/trace/events/{thermal_pressure.h => hw_pressure.h} (55%)
> >
> > diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> > index 853c4f81ba4a..e175e8596b5d 100644
> > --- a/arch/arm/include/asm/topology.h
> > +++ b/arch/arm/include/asm/topology.h
> > @@ -22,9 +22,9 @@
> >   /* Enable topology flag updates */
> >   #define arch_update_cpu_topology topology_update_cpu_topology
> >
> > -/* Replace task scheduler's default thermal pressure API */
> > -#define arch_scale_thermal_pressure topology_get_thermal_pressure
> > -#define arch_update_thermal_pressure topology_update_thermal_pressure
> > +/* Replace task scheduler's default hw pressure API */
> > +#define arch_scale_hw_pressure topology_get_hw_pressure
> > +#define arch_update_hw_pressure      topology_update_hw_pressure
> >
> >   #else
> >
> > diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> > index a323b109b9c4..a427650bdfba 100644
> > --- a/arch/arm64/include/asm/topology.h
> > +++ b/arch/arm64/include/asm/topology.h
> > @@ -35,9 +35,9 @@ void update_freq_counters_refs(void);
> >   /* Enable topology flag updates */
> >   #define arch_update_cpu_topology topology_update_cpu_topology
> >
> > -/* Replace task scheduler's default thermal pressure API */
> > -#define arch_scale_thermal_pressure topology_get_thermal_pressure
> > -#define arch_update_thermal_pressure topology_update_thermal_pressure
> > +/* Replace task scheduler's default hw pressure API */
>
> s/hw/HW/ ?
>
> > +#define arch_scale_hw_pressure topology_get_hw_pressure
> > +#define arch_update_hw_pressure      topology_update_hw_pressure
> >
> >   #include <asm-generic/topology.h>
> >
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 0906114963ff..3d8dc9d5c3ad 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -22,7 +22,7 @@
> >   #include <linux/units.h>
> >
> >   #define CREATE_TRACE_POINTS
> > -#include <trace/events/thermal_pressure.h>
> > +#include <trace/events/hw_pressure.h>
> >
> >   static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
> >   static struct cpumask scale_freq_counters_mask;
> > @@ -160,26 +160,26 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
> >       per_cpu(cpu_scale, cpu) = capacity;
> >   }
> >
> > -DEFINE_PER_CPU(unsigned long, thermal_pressure);
> > +DEFINE_PER_CPU(unsigned long, hw_pressure);
> >
> >   /**
> > - * topology_update_thermal_pressure() - Update thermal pressure for CPUs
> > + * topology_update_hw_pressure() - Update hw pressure for CPUs
>
> same here: HW?
>
> >    * @cpus        : The related CPUs for which capacity has been reduced
> >    * @capped_freq : The maximum allowed frequency that CPUs can run at
> >    *
> > - * Update the value of thermal pressure for all @cpus in the mask. The
> > + * Update the value of hw pressure for all @cpus in the mask. The
>
> HW?
>
> >    * cpumask should include all (online+offline) affected CPUs, to avoid
> >    * operating on stale data when hot-plug is used for some CPUs. The
> >    * @capped_freq reflects the currently allowed max CPUs frequency due to
> > - * thermal capping. It might be also a boost frequency value, which is bigger
> > + * hw capping. It might be also a boost frequency value, which is bigger
>
> HW?
>
> >    * than the internal 'capacity_freq_ref' max frequency. In such case the
> >    * pressure value should simply be removed, since this is an indication that
> > - * there is no thermal throttling. The @capped_freq must be provided in kHz.
> > + * there is no hw throttling. The @capped_freq must be provided in kHz.
>
> HW?
>
> >    */
> > -void topology_update_thermal_pressure(const struct cpumask *cpus,
> > +void topology_update_hw_pressure(const struct cpumask *cpus,
> >                                     unsigned long capped_freq)
> >   {
> > -     unsigned long max_capacity, capacity, th_pressure;
> > +     unsigned long max_capacity, capacity, hw_pressure;
> >       u32 max_freq;
> >       int cpu;
> >
> > @@ -189,21 +189,21 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
> >
> >       /*
> >        * Handle properly the boost frequencies, which should simply clean
> > -      * the thermal pressure value.
> > +      * the hw pressure value.
>
> HW?
>
> >        */
> >       if (max_freq <= capped_freq)
> >               capacity = max_capacity;
> >       else
> >               capacity = mult_frac(max_capacity, capped_freq, max_freq);
> >
> > -     th_pressure = max_capacity - capacity;
> > +     hw_pressure = max_capacity - capacity;
> >
> > -     trace_thermal_pressure_update(cpu, th_pressure);
> > +     trace_hw_pressure_update(cpu, hw_pressure);
> >
> >       for_each_cpu(cpu, cpus)
> > -             WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
> > +             WRITE_ONCE(per_cpu(hw_pressure, cpu), hw_pressure);
> >   }
> > -EXPORT_SYMBOL_GPL(topology_update_thermal_pressure);
> > +EXPORT_SYMBOL_GPL(topology_update_hw_pressure);
> >
> >   static ssize_t cpu_capacity_show(struct device *dev,
> >                                struct device_attribute *attr,
> > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > index 70b0f21968a0..a619202ba81d 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > @@ -347,8 +347,8 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
> >
> >       throttled_freq = freq_hz / HZ_PER_KHZ;
> >
> > -     /* Update thermal pressure (the boost frequencies are accepted) */
> > -     arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
> > +     /* Update hw pressure (the boost frequencies are accepted) */
>
> HW?
>
> > +     arch_update_hw_pressure(policy->related_cpus, throttled_freq);
> >
>
> [snip]
>
> >
> >       if (housekeeping_cpu(cpu, HK_TYPE_TICK))
> > @@ -5669,8 +5669,8 @@ void scheduler_tick(void)
> >       rq_lock(rq, &rf);
> >
> >       update_rq_clock(rq);
> > -     thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> > -     update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
> > +     hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
> > +     update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
>
> We switch to task clock here, could you tell me why?
> Don't we have to maintain the boot command parameter for the shift?

This should have been part of the patch5 that I finally removed. IMO,
the additional time shift with rq_clock_thermal is no more needed now
that we have 2 separates signals

>
> >       curr->sched_class->task_tick(rq, curr, 0);
> >       if (sched_feat(LATENCY_WARN))
> >               resched_latency = cpu_resched_latency(rq);
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 11d3be829302..07050955d6e0 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4936,7 +4936,7 @@ static inline unsigned long get_actual_cpu_capacity(int cpu)
> >   {
> >       unsigned long capacity = arch_scale_cpu_capacity(cpu);
> >
> > -     capacity -= max(thermal_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
> > +     capacity -= max(hw_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
> >
> >       return capacity;
> >   }
> > @@ -4968,7 +4968,7 @@ static inline int util_fits_cpu(unsigned long util,
> >        * Similarly if a task is capped to arch_scale_cpu_capacity(little_cpu), it
> >        * should fit a little cpu even if there's some pressure.
> >        *
> > -      * Only exception is for thermal pressure since it has a direct impact
> > +      * Only exception is for hw or cpufreq pressure since it has a direct impact
>
> HW?
>
> >        * on available OPP of the system.
> >        *
> >        * We honour it for uclamp_min only as a drop in performance level
> > @@ -9224,7 +9224,7 @@ static inline bool others_have_blocked(struct rq *rq)
> >       if (READ_ONCE(rq->avg_dl.util_avg))
> >               return true;
> >
> > -     if (thermal_load_avg(rq))
> > +     if (hw_load_avg(rq))
> >               return true;
> >
> >   #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
> > @@ -9256,7 +9256,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
> >   {
> >       const struct sched_class *curr_class;
> >       u64 now = rq_clock_pelt(rq);
> > -     unsigned long thermal_pressure;
> > +     unsigned long hw_pressure;
> >       bool decayed;
> >
> >       /*
> > @@ -9265,11 +9265,11 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
> >        */
> >       curr_class = rq->curr->sched_class;
> >
> > -     thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> > +     hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
> >
> >       decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> >                 update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> > -               update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure) |
> > +               update_hw_load_avg(now, rq, hw_pressure) |
>
> Here also the rq_clock_thermal() is not used anymore. Shouldn't we
> remove the rq_clock_thermal() if not used anymore (I cannot se this in
> the patch)?
>
> >                 update_irq_load_avg(rq, 0);
> >
> >       if (others_have_blocked(rq))
>
> [snip]
>
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index e58a54bda77d..7eaf186d071e 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1078,8 +1078,8 @@ struct rq {
> >   #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
> >       struct sched_avg        avg_irq;
> >   #endif
> > -#ifdef CONFIG_SCHED_THERMAL_PRESSURE
> > -     struct sched_avg        avg_thermal;
> > +#ifdef CONFIG_SCHED_HW_PRESSURE
> > +     struct sched_avg        avg_hw;
> >   #endif
> >       u64                     idle_stamp;
> >       u64                     avg_idle;
>
> I don't see that rq_clock_thermal() removal in this header.
> Maybe I miss some patch?
>
> BTW, I like the name 'HW pressure' for this information/signal.
