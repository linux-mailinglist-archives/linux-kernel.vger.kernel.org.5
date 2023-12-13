Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43FC810BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378754AbjLMIGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378768AbjLMIGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:06:06 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D3E113
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:06:10 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5906e03a7a4so3729830eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702454770; x=1703059570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J9mdWEzAG/9B8MCr9zuWWWlq43lPTrGVYB8WYYi38CU=;
        b=wBcyXsS3VLLMZzv6mh2T6+9UP9DbW22sYycB2IGiwfFltk3f1QtcQwm4kg/eaCbpfK
         6a853NgEUCQww3GbYSMDYvUirWHYUFNUYQiw3KHHAx++3DXEJ78oWHcTTsaJOTdundpe
         jeDy6zL3LKVQeD6b23UgDa6+3HgE7UAoD5LanXoZTK2t2su4xgprwML9mWnJidWVeSwv
         /t6id/RUiTpp6e29g693iZ3YMUnU2NOM/Vn4B3PZWohunN3N6Gd3zWmCdW2HvOW2kx3J
         YfK/HqHmxn6YChzN4ZbG9lw72Sw5iOracIR5v/O52DS84pmu37aHGYkD4dtJpWDRQJ3t
         U1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702454770; x=1703059570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9mdWEzAG/9B8MCr9zuWWWlq43lPTrGVYB8WYYi38CU=;
        b=ZJkLvthTShRmMlJr0Hdrt/iBth3D7jYG7WLjZ89H+LjzxWFZkMwpDggI8D1nVoV5pw
         CtoRFXDE7/Wcccf6dKbFlInMKCDLIfJ8vg8TApUBMyDqxrHFUVy75RTyeqUikmE1Nj88
         JQl04DxOPGo4OaN43dGKxDMNVSIu7oE0w+JWLvhrS24J8e1w4tBPLz/C6uCOZ0yBJ2wS
         503HqQRO9Iq5sBaC3w9gOQzJLSHpdVhWXZ826B2z9VW9bA98qgtAiBTHs66C/4WKGrA1
         e2ArKP7QyxEpWmlBDMOUB9VW1w2/JVMepTMtE2kmyey+XlgZ9NmhUnA0agfHnp/xFjub
         2c0A==
X-Gm-Message-State: AOJu0YxeJqT02zbzBud1E+Fj2Eb+9razlXhslBqZDAsuvKGsvxh4YyVA
        VUGgSmTl9YObWBIEhDq2Jz9MNy/+wI6Xtk3+1EnEow==
X-Google-Smtp-Source: AGHT+IGPgs3V4zKi7zlA4zBph0PJYT5cticd6roWHX31QolvnAMu5tV34TepBxpazBzOHiCzl+aZKfaUZeUBEZiKtP8=
X-Received: by 2002:a05:6359:6006:b0:170:2013:c8f5 with SMTP id
 rw6-20020a056359600600b001702013c8f5mr3758020rwb.53.1702454769816; Wed, 13
 Dec 2023 00:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-2-vincent.guittot@linaro.org> <20231213071722.u6n2fokrfs7hf3nb@vireshk-i7>
In-Reply-To: <20231213071722.u6n2fokrfs7hf3nb@vireshk-i7>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 13 Dec 2023 09:05:57 +0100
Message-ID: <CAKfTPtC=C3ERO_RDUxxe_Nvq1NuLcNsCsdj=G=vinXmhfpUQZw@mail.gmail.com>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq pressure feedback for the scheduler
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
        rafael@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, lukasz.luba@arm.com,
        rui.zhang@intel.com, mhiramat@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 at 08:17, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 12-12-23, 15:27, Vincent Guittot wrote:
> > Provide to the scheduler a feedback about the temporary max available
> > capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> > filtered as the pressure will happen for dozens ms or more.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 48 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/cpufreq.h   | 10 ++++++++
> >  2 files changed, 58 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 44db4f59c4cc..7d5f71be8d29 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2563,6 +2563,50 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
> >  }
> >  EXPORT_SYMBOL(cpufreq_get_policy);
> >
> > +DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
> > +EXPORT_PER_CPU_SYMBOL_GPL(cpufreq_pressure);
> > +
> > +/**
> > + * cpufreq_update_pressure() - Update cpufreq pressure for CPUs
> > + * @cpus        : The related CPUs for which max capacity has been reduced
> > + * @capped_freq : The maximum allowed frequency that CPUs can run at
> > + *
> > + * Update the value of cpufreq pressure for all @cpus in the mask. The
> > + * cpumask should include all (online+offline) affected CPUs, to avoid
> > + * operating on stale data when hot-plug is used for some CPUs. The
> > + * @capped_freq reflects the currently allowed max CPUs frequency due to
> > + * freq_qos capping. It might be also a boost frequency value, which is bigger
> > + * than the internal 'capacity_freq_ref' max frequency. In such case the
> > + * pressure value should simply be removed, since this is an indication that
> > + * there is no capping. The @capped_freq must be provided in kHz.
> > + */
> > +static void cpufreq_update_pressure(const struct cpumask *cpus,
>
> Since this is defined as 'static', why not just pass policy here ?

Mainly because we only need the cpumask and also because this follows
the same pattern as other place like arch_topology.c

>
> > +                                   unsigned long capped_freq)
> > +{
> > +     unsigned long max_capacity, capacity, pressure;
> > +     u32 max_freq;
> > +     int cpu;
> > +
> > +     cpu = cpumask_first(cpus);
> > +     max_capacity = arch_scale_cpu_capacity(cpu);
>
> This anyway expects all of them to be from the same policy ..
>
> > +     max_freq = arch_scale_freq_ref(cpu);
> > +
> > +     /*
> > +      * Handle properly the boost frequencies, which should simply clean
> > +      * the thermal pressure value.
> > +      */
> > +     if (max_freq <= capped_freq)
> > +             capacity = max_capacity;
> > +     else
> > +             capacity = mult_frac(max_capacity, capped_freq, max_freq);
> > +
> > +     pressure = max_capacity - capacity;
> > +
>
> Extra blank line here.
>
> > +
> > +     for_each_cpu(cpu, cpus)
> > +             WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
> > +}
> > +
> >  /**
> >   * cpufreq_set_policy - Modify cpufreq policy parameters.
> >   * @policy: Policy object to modify.
> > @@ -2584,6 +2628,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >  {
> >       struct cpufreq_policy_data new_data;
> >       struct cpufreq_governor *old_gov;
> > +     struct cpumask *cpus;
> >       int ret;
> >
> >       memcpy(&new_data.cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
> > @@ -2618,6 +2663,9 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >       policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
> >       trace_cpu_frequency_limits(policy);
> >
> > +     cpus = policy->related_cpus;
>
> You don't need the extra variable anyway, but lets just pass policy
> instead to the routine.

In fact I have followed what was done in cpufreq_cooling.c with
arch_update_thermal_pressure().

Will remove it

>
> > +     cpufreq_update_pressure(cpus, policy->max);
> > +
> >       policy->cached_target_freq = UINT_MAX;
> >
> >       pr_debug("new min and max freqs are %u - %u kHz\n",
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index afda5f24d3dd..b1d97edd3253 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -241,6 +241,12 @@ struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
> >  void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
> >  void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
> >  bool has_target_index(void);
> > +
> > +DECLARE_PER_CPU(unsigned long, cpufreq_pressure);
> > +static inline unsigned long cpufreq_get_pressure(int cpu)
> > +{
> > +     return per_cpu(cpufreq_pressure, cpu);
> > +}
> >  #else
> >  static inline unsigned int cpufreq_get(unsigned int cpu)
> >  {
> > @@ -263,6 +269,10 @@ static inline bool cpufreq_supports_freq_invariance(void)
> >       return false;
> >  }
> >  static inline void disable_cpufreq(void) { }
> > +static inline unsigned long cpufreq_get_pressure(int cpu)
> > +{
> > +     return 0;
> > +}
> >  #endif
> >
> >  #ifdef CONFIG_CPU_FREQ_STAT
> > --
> > 2.34.1
>
> --
> viresh
