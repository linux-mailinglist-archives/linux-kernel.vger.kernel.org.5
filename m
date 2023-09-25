Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64937AD7AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjIYMHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjIYMGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:06:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B981712
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:06:22 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-573c62b3cd2so3646230a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695643582; x=1696248382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B+U6aD5x/VGpbdQ+U4y+MwY0gu5QAzijgLSvIiCbWdI=;
        b=KiKn8KrEfutFalCfDd2TwOTblbpIWOc0u8WAsGPUuejZYezFb2Ls6mjPyd19P/fDes
         St4pclT9pgrIdXlEbLXeNkcUZDlibJDiOibHhsGfav3Tf6519ienwL0IJXqz+NLiD7SZ
         dYDio4hu6fNOcjTeU3XR3nV3xvd5bYnlMjSzqEJInbmK9FSWyxFFdj6NtA0t0IRGUgOd
         bq8pAk3zVnqUL8PYGaa1MguXokL9kfaS6TpLJK1xM//WwTG0TDoYjEuZiHiPRSwDpeDA
         UHh0/JOuDotKeJ5p12YF8Z8IjHhDCb7yS5bD+TMo8DXAbk294a9vHM046reZB7RiiB1B
         fofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695643582; x=1696248382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+U6aD5x/VGpbdQ+U4y+MwY0gu5QAzijgLSvIiCbWdI=;
        b=H9nwuGlMXWbwnEjZN9k+hM8DSIlt8P5+glLU12g0t1rt0HazADRHlxZtWH2j44qAJ1
         Ft3ra4orFbpbMC050SWDBW83JwKj5g0/DEyUT/qCaO7CwL16q9Oguik3iUkLv0zhJzGa
         Xjx12vQvSv21Sqln9c8Txy48UorPkYqyp6JRzGsslT5NwGv5s3fMV1rbKkKZ7UkAhIdy
         GEiDuSkzMyl8LTaUXhWkyN4vJtHeQga/W+7s0n6OQ6ZMM26ac8WxpWpnRfaSsrvxdrKC
         kRL9M534+OxaTA8DipeRVsxF3ohMu+XbKhqkc5kdbSoqd5lyMSU7RXC5uKZqFFMwaIJ+
         DMlw==
X-Gm-Message-State: AOJu0Yx0Tbb5bjGCyhCqwyH2sJUVvvDzoQXnxIO0FWndeTTQXrx9HvUd
        +zaXPL4y+LpTkOMCond3uEXil9V0xuLKKAm6YXsp5A==
X-Google-Smtp-Source: AGHT+IF00Q7WAgbYXTduPsXYR+4Ir2vd7dif5dbXa6HjTMAbxFAfyV8XpwzQDXVHZ161+wFToPCdOAjQP0LAVXM8BRc=
X-Received: by 2002:a17:90a:c692:b0:274:111c:c14d with SMTP id
 n18-20020a17090ac69200b00274111cc14dmr3887972pjt.13.1695643581678; Mon, 25
 Sep 2023 05:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-3-vincent.guittot@linaro.org> <ZQwGHBGg9B8SjzeS@arm.com>
In-Reply-To: <ZQwGHBGg9B8SjzeS@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 25 Sep 2023 14:06:10 +0200
Message-ID: <CAKfTPtDbH94S74ok6SQGHC29dnZfmRfHG+N+j_p-moguTY2T-A@mail.gmail.com>
Subject: Re: [PATCH 2/4] topology: add a new arch_scale_freq_reference
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sept 2023 at 11:00, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hi Vincent,
>
> On Friday 01 Sep 2023 at 15:03:10 (+0200), Vincent Guittot wrote:
> > Create a new method to get a unique and fixed max frequency. Currently
> > cpuinfo.max_freq or last item of performance domain are used as the max
> > frequency when computing the frequency for a level of utilization but:
> > - cpuinfo_max_freq can change at runtime. boost is one example of
> >   such change.
> > - cpuinfo.max_freq and last item of the PD can be different leading to
> >   different results betwen cpufreq and energy model.
> >
> > We need to save the max frequency that has been used when computing the
> > CPUs capacity and use this fixed and coherent value to convert between
> > frequency and CPU's capacity.
> >
> > In fact, we already save the frequency that has been used when computing
> > the capacity of each CPU. We extend the precision to save khZ instead of
> > Mhz currently and we modify the type to be aligned with other variables
> > used when converting frequency to capacity and the other way.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  arch/arm/include/asm/topology.h   | 1 +
> >  arch/arm64/include/asm/topology.h | 1 +
> >  arch/riscv/include/asm/topology.h | 1 +
> >  drivers/base/arch_topology.c      | 9 +++------
> >  include/linux/arch_topology.h     | 7 +++++++
> >  5 files changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> > index c7d2510e5a78..853c4f81ba4a 100644
> > --- a/arch/arm/include/asm/topology.h
> > +++ b/arch/arm/include/asm/topology.h
> > @@ -13,6 +13,7 @@
> >  #define arch_set_freq_scale topology_set_freq_scale
> >  #define arch_scale_freq_capacity topology_get_freq_scale
> >  #define arch_scale_freq_invariant topology_scale_freq_invariant
> > +#define arch_scale_freq_ref topology_get_freq_ref
>
> The "reference" frequency or performance of a CPU has a specific meaning
> in the ACPI specification as a fixed frequency of a constant clock and its
> associated performance level, usually used for performance to frequency
> conversions. This is not guaranteed to be the maximum
> performance/frequency and it's definitely not the case for arm systems
> where this is tied to the system timer - 1-50Mhz.
>
> So I believe it might create some confusion to call this "reference"
> frequency.
>
> Any reason for not calling it arch_scale_freq_max? I know not all max
> frequencies are equal :) but it would still drive the point that this is
> intended to act as a chosen maximum for the scheduler's use, especially
> if there's a well place comment.

I don't like max_freq because most will assume this is the cpufreq max
value whereas this value is the actual frequency that has been used as
a reference for computing the cpu capacity and should be used as the
reference for any further computation

>
> >  #endif
> >
> >  /* Replace task scheduler's default cpu-invariant accounting */
> > diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> > index 9fab663dd2de..a323b109b9c4 100644
> > --- a/arch/arm64/include/asm/topology.h
> > +++ b/arch/arm64/include/asm/topology.h
> > @@ -23,6 +23,7 @@ void update_freq_counters_refs(void);
> >  #define arch_set_freq_scale topology_set_freq_scale
> >  #define arch_scale_freq_capacity topology_get_freq_scale
> >  #define arch_scale_freq_invariant topology_scale_freq_invariant
> > +#define arch_scale_freq_ref topology_get_freq_ref
> >
> >  #ifdef CONFIG_ACPI_CPPC_LIB
> >  #define arch_init_invariance_cppc topology_init_cpu_capacity_cppc
> > diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
> > index e316ab3b77f3..61183688bdd5 100644
> > --- a/arch/riscv/include/asm/topology.h
> > +++ b/arch/riscv/include/asm/topology.h
> > @@ -9,6 +9,7 @@
> >  #define arch_set_freq_scale          topology_set_freq_scale
> >  #define arch_scale_freq_capacity     topology_get_freq_scale
> >  #define arch_scale_freq_invariant    topology_scale_freq_invariant
> > +#define arch_scale_freq_ref          topology_get_freq_ref
> >
> >  /* Replace task scheduler's default cpu-invariant accounting */
> >  #define arch_scale_cpu_capacity      topology_get_cpu_scale
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index b741b5ba82bd..75fa67477a9d 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -26,7 +26,7 @@
> >  static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
> >  static struct cpumask scale_freq_counters_mask;
> >  static bool scale_freq_invariant;
> > -static DEFINE_PER_CPU(u32, freq_factor) = 1;
> > +DEFINE_PER_CPU(unsigned long, freq_factor) = 1;
>
> Given its new wider use, it might be good for this to get a more
> relevant name as well. Previously freq_factor made sense for its role
> in using the dmips/mhz values to obtain CPU capacities. But if this is
> now returned from arch_scale_freq_ref() it would be more difficult still
> to easily understand what this value is supposed to reflect, when
> reading the function name or the per-cpu variable name alone.

As long as it was used internally behind a function i didn't see a
problem but I will probably have cppc_cpufreq to set it while
registering its Energy model so I will change it

>
> Thanks,
> Ionela.
>
> >
> >  static bool supports_scale_freq_counters(const struct cpumask *cpus)
> >  {
> > @@ -183,10 +183,7 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
> >
> >       cpu = cpumask_first(cpus);
> >       max_capacity = arch_scale_cpu_capacity(cpu);
> > -     max_freq = per_cpu(freq_factor, cpu);
> > -
> > -     /* Convert to MHz scale which is used in 'freq_factor' */
> > -     capped_freq /= 1000;
> > +     max_freq = arch_scale_freq_ref(cpu);
> >
> >       /*
> >        * Handle properly the boost frequencies, which should simply clean
> > @@ -411,7 +408,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
> >       cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
> >
> >       for_each_cpu(cpu, policy->related_cpus)
> > -             per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq / 1000;
> > +             per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq;
> >
> >       if (cpumask_empty(cpus_to_visit)) {
> >               topology_normalize_cpu_scale();
> > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> > index a07b510e7dc5..7a2dba9c3dc0 100644
> > --- a/include/linux/arch_topology.h
> > +++ b/include/linux/arch_topology.h
> > @@ -27,6 +27,13 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
> >
> >  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
> >
> > +DECLARE_PER_CPU(unsigned long, freq_factor);
> > +
> > +static inline unsigned long topology_get_freq_ref(int cpu)
> > +{
> > +     return per_cpu(freq_factor, cpu);
> > +}
> > +
> >  DECLARE_PER_CPU(unsigned long, arch_freq_scale);
> >
> >  static inline unsigned long topology_get_freq_scale(int cpu)
> > --
> > 2.34.1
> >
> >
