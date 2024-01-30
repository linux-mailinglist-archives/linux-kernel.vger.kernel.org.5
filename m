Return-Path: <linux-kernel+bounces-43693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D73C8417D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4313B1C22C46
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4338536117;
	Tue, 30 Jan 2024 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="1SLUgotX"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFE336119
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575658; cv=none; b=POUPQjiWafx5jWbBIziIP/kmWBKvd3033pXkCxw/E1Qswy2mQb+OPwv1YfEBW3mm2ZBzXazCqMVSYjkRYGULnwa5mKNHdzwl2UoHrsLXPXGuILGtrb0OjH3WPnZuIKOdAGR/3SaGdklkWIa8LcSyaqOr8/xp304MpIoeVH7NDhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575658; c=relaxed/simple;
	bh=H55ScsU7XFIvk8ZTSbfIKdI+aBuV57Hz8xfuSv++AKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdMf5YDc7AyNB2LuVRbG7rCLbGyyeDx+cS9Li34oLY/IEpVljgvk0ykbw2VCqqYfUnBu9zofrs/UH5bf8srvd93xblw/j+vJN03V84OOSU3gRw24VoXIkdkApKeuL6GcudSZxeJYe/9YuEDjPFoysbsBwCcYpktZD7DJ+s0kx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=1SLUgotX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40ef75adf44so12787495e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706575654; x=1707180454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V5qz5fSOd7NYLMQBx4DrAwXMw/ILLYRo+Krbi1mMzGg=;
        b=1SLUgotXLLxadRqdRClCXLUyIjNiNb/+3nXJHBoyu7fqaDEoe33xcxxkYz953rKD3i
         82JRtoTaQEXYIVfykNAYAcIK2HUBPCzhCUxU/reHnDrDqalolOobItDEQ7DN1+0l48wZ
         VRMinLz7wWI+y0nDknr7CqxRQBhneCirBpx3KB1qc7AfvQGeqNXTgxS7QfRw6L0kPCUq
         6f8KyBcT3+8jyQYbtGyGw+Xf/6dYS5ubsd14uY0mTUYzy0Ez1jz88mITPI5YwEAAQlpY
         B7CJaJN7AFiAzwGiakZAQnTcqjMjisH/u9Y/ygkSFAUtt+DmB4/McyLKg3qt9vRsyV4W
         Y5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706575654; x=1707180454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5qz5fSOd7NYLMQBx4DrAwXMw/ILLYRo+Krbi1mMzGg=;
        b=VKCW/9l+A541scVc/Qyw9HXPgkAHyVpVzMaJR7ihm/zPlHAMuPAOtNKr/WwW+MlGpe
         43O7VNMmZRpa/aEj0SIQ7EO3DUr0+LURSwpE9Bnw73uEIUr3ikTEZXaX5vlX/85cxiix
         w+nJi+HPN4zc/h82ZlKVGFowUqbLaAqz3ti2naNIRO5LWBYv6v7xOyqgvb2mofcw4rjl
         rB9ZcGPw1r8mK91fU/EUn8Vtf1hNmkP96Mv14I1Zg/xuqyCHS7bzskkpsKE2ahi8w9WR
         Q8ipO6JFvhAt2PniuDz7vTBaBYWYFvKxGdx9zej98wXI5UoVZdJa5oZ9gKuu0hQJoE1w
         /19A==
X-Gm-Message-State: AOJu0Yx73x9+YOrueFS69soNqThmNgqgzh8kSjX5e9/78eOn1YU9wxvy
	czV8si/5im+Ez0vxSLpFN7pZwBW3lJ01WBGkjgF8I3cB+8ZQkoiTdpufmAXceBE=
X-Google-Smtp-Source: AGHT+IHf289ZE8Uf05indestVIxap96Hg0/9v5b8eikN8G47TX4HRgecH7zVq8/oOuscYBZpNez0bA==
X-Received: by 2002:a5d:588a:0:b0:33a:f45e:fecd with SMTP id n10-20020a5d588a000000b0033af45efecdmr2131659wrf.33.1706575654246;
        Mon, 29 Jan 2024 16:47:34 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4c87000000b0033af9b7db6esm368093wrs.22.2024.01.29.16.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:47:33 -0800 (PST)
Date: Tue, 30 Jan 2024 00:47:32 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	lukasz.luba@arm.com, rui.zhang@intel.com, mhiramat@kernel.org,
	daniel.lezcano@linaro.org, amit.kachhap@gmail.com, corbet@lwn.net,
	gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 4/5] sched: Rename arch_update_thermal_pressure into
 arch_update_hw_pressure
Message-ID: <20240130004732.pydozyieuy2rn4zv@airbuntu>
References: <20240109164655.626085-1-vincent.guittot@linaro.org>
 <20240109164655.626085-5-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240109164655.626085-5-vincent.guittot@linaro.org>

On 01/09/24 17:46, Vincent Guittot wrote:
> Now that cpufreq provides a pressure value to the scheduler, rename
> arch_update_thermal_pressure into HW pressure to reflect that it returns
> a pressure applied by HW (i.e. with a high frequency change) and not
> always related to thermal mitigation but also generated by max current
> limitation as an example. Such high frequency signal needs filtering to be
> smoothed and provide a value that reflects the average available capacity
> into the scheduler time scale.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Reviewed-by: Qais Yousef <qyousef@layalina.io>

>  arch/arm/include/asm/topology.h               |  6 ++---
>  arch/arm64/include/asm/topology.h             |  6 ++---
>  drivers/base/arch_topology.c                  | 26 +++++++++----------
>  drivers/cpufreq/qcom-cpufreq-hw.c             |  4 +--
>  include/linux/arch_topology.h                 |  8 +++---
>  include/linux/sched/topology.h                |  8 +++---
>  .../{thermal_pressure.h => hw_pressure.h}     | 14 +++++-----
>  include/trace/events/sched.h                  |  2 +-
>  init/Kconfig                                  | 12 ++++-----
>  kernel/sched/core.c                           |  8 +++---
>  kernel/sched/fair.c                           | 16 ++++++------
>  kernel/sched/pelt.c                           | 18 ++++++-------
>  kernel/sched/pelt.h                           | 16 ++++++------
>  kernel/sched/sched.h                          | 10 +++----
>  14 files changed, 77 insertions(+), 77 deletions(-)
>  rename include/trace/events/{thermal_pressure.h => hw_pressure.h} (55%)
> 
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index 853c4f81ba4a..ad36b6570067 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -22,9 +22,9 @@
>  /* Enable topology flag updates */
>  #define arch_update_cpu_topology topology_update_cpu_topology
>  
> -/* Replace task scheduler's default thermal pressure API */
> -#define arch_scale_thermal_pressure topology_get_thermal_pressure
> -#define arch_update_thermal_pressure	topology_update_thermal_pressure
> +/* Replace task scheduler's default HW pressure API */
> +#define arch_scale_hw_pressure topology_get_hw_pressure
> +#define arch_update_hw_pressure	topology_update_hw_pressure
>  
>  #else
>  
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index a323b109b9c4..0f6ef432fb84 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -35,9 +35,9 @@ void update_freq_counters_refs(void);
>  /* Enable topology flag updates */
>  #define arch_update_cpu_topology topology_update_cpu_topology
>  
> -/* Replace task scheduler's default thermal pressure API */
> -#define arch_scale_thermal_pressure topology_get_thermal_pressure
> -#define arch_update_thermal_pressure	topology_update_thermal_pressure
> +/* Replace task scheduler's default HW pressure API */
> +#define arch_scale_hw_pressure topology_get_hw_pressure
> +#define arch_update_hw_pressure	topology_update_hw_pressure
>  
>  #include <asm-generic/topology.h>
>  
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 5aaa0865625d..331ffc468ceb 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -22,7 +22,7 @@
>  #include <linux/units.h>
>  
>  #define CREATE_TRACE_POINTS
> -#include <trace/events/thermal_pressure.h>
> +#include <trace/events/hw_pressure.h>
>  
>  static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
>  static struct cpumask scale_freq_counters_mask;
> @@ -160,26 +160,26 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
>  	per_cpu(cpu_scale, cpu) = capacity;
>  }
>  
> -DEFINE_PER_CPU(unsigned long, thermal_pressure);
> +DEFINE_PER_CPU(unsigned long, hw_pressure);
>  
>  /**
> - * topology_update_thermal_pressure() - Update thermal pressure for CPUs
> + * topology_update_hw_pressure() - Update HW pressure for CPUs
>   * @cpus        : The related CPUs for which capacity has been reduced
>   * @capped_freq : The maximum allowed frequency that CPUs can run at
>   *
> - * Update the value of thermal pressure for all @cpus in the mask. The
> + * Update the value of HW pressure for all @cpus in the mask. The
>   * cpumask should include all (online+offline) affected CPUs, to avoid
>   * operating on stale data when hot-plug is used for some CPUs. The
>   * @capped_freq reflects the currently allowed max CPUs frequency due to
> - * thermal capping. It might be also a boost frequency value, which is bigger
> + * HW capping. It might be also a boost frequency value, which is bigger
>   * than the internal 'capacity_freq_ref' max frequency. In such case the
>   * pressure value should simply be removed, since this is an indication that
> - * there is no thermal throttling. The @capped_freq must be provided in kHz.
> + * there is no HW throttling. The @capped_freq must be provided in kHz.
>   */
> -void topology_update_thermal_pressure(const struct cpumask *cpus,
> +void topology_update_hw_pressure(const struct cpumask *cpus,
>  				      unsigned long capped_freq)
>  {
> -	unsigned long max_capacity, capacity, th_pressure;
> +	unsigned long max_capacity, capacity, hw_pressure;
>  	u32 max_freq;
>  	int cpu;
>  
> @@ -189,21 +189,21 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
>  
>  	/*
>  	 * Handle properly the boost frequencies, which should simply clean
> -	 * the thermal pressure value.
> +	 * the HW pressure value.
>  	 */
>  	if (max_freq <= capped_freq)
>  		capacity = max_capacity;
>  	else
>  		capacity = mult_frac(max_capacity, capped_freq, max_freq);
>  
> -	th_pressure = max_capacity - capacity;
> +	hw_pressure = max_capacity - capacity;
>  
> -	trace_thermal_pressure_update(cpu, th_pressure);
> +	trace_hw_pressure_update(cpu, hw_pressure);
>  
>  	for_each_cpu(cpu, cpus)
> -		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
> +		WRITE_ONCE(per_cpu(hw_pressure, cpu), hw_pressure);
>  }
> -EXPORT_SYMBOL_GPL(topology_update_thermal_pressure);
> +EXPORT_SYMBOL_GPL(topology_update_hw_pressure);
>  
>  static ssize_t cpu_capacity_show(struct device *dev,
>  				 struct device_attribute *attr,
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 70b0f21968a0..ec8df5496a0c 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -347,8 +347,8 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>  
>  	throttled_freq = freq_hz / HZ_PER_KHZ;
>  
> -	/* Update thermal pressure (the boost frequencies are accepted) */
> -	arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
> +	/* Update HW pressure (the boost frequencies are accepted) */
> +	arch_update_hw_pressure(policy->related_cpus, throttled_freq);
>  
>  	/*
>  	 * In the unlikely case policy is unregistered do not enable
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index a63d61ca55af..b721f360d759 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -60,14 +60,14 @@ void topology_scale_freq_tick(void);
>  void topology_set_scale_freq_source(struct scale_freq_data *data, const struct cpumask *cpus);
>  void topology_clear_scale_freq_source(enum scale_freq_source source, const struct cpumask *cpus);
>  
> -DECLARE_PER_CPU(unsigned long, thermal_pressure);
> +DECLARE_PER_CPU(unsigned long, hw_pressure);
>  
> -static inline unsigned long topology_get_thermal_pressure(int cpu)
> +static inline unsigned long topology_get_hw_pressure(int cpu)
>  {
> -	return per_cpu(thermal_pressure, cpu);
> +	return per_cpu(hw_pressure, cpu);
>  }
>  
> -void topology_update_thermal_pressure(const struct cpumask *cpus,
> +void topology_update_hw_pressure(const struct cpumask *cpus,
>  				      unsigned long capped_freq);
>  
>  struct cpu_topology {
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index a6e04b4a21d7..e3b2cf7de018 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -264,17 +264,17 @@ unsigned long arch_scale_cpu_capacity(int cpu)
>  }
>  #endif
>  
> -#ifndef arch_scale_thermal_pressure
> +#ifndef arch_scale_hw_pressure
>  static __always_inline
> -unsigned long arch_scale_thermal_pressure(int cpu)
> +unsigned long arch_scale_hw_pressure(int cpu)
>  {
>  	return 0;
>  }
>  #endif
>  
> -#ifndef arch_update_thermal_pressure
> +#ifndef arch_update_hw_pressure
>  static __always_inline
> -void arch_update_thermal_pressure(const struct cpumask *cpus,
> +void arch_update_hw_pressure(const struct cpumask *cpus,
>  				  unsigned long capped_frequency)
>  { }
>  #endif
> diff --git a/include/trace/events/thermal_pressure.h b/include/trace/events/hw_pressure.h
> similarity index 55%
> rename from include/trace/events/thermal_pressure.h
> rename to include/trace/events/hw_pressure.h
> index b68680201360..b9cd68854128 100644
> --- a/include/trace/events/thermal_pressure.h
> +++ b/include/trace/events/hw_pressure.h
> @@ -1,27 +1,27 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #undef TRACE_SYSTEM
> -#define TRACE_SYSTEM thermal_pressure
> +#define TRACE_SYSTEM hw_pressure
>  
>  #if !defined(_TRACE_THERMAL_PRESSURE_H) || defined(TRACE_HEADER_MULTI_READ)
>  #define _TRACE_THERMAL_PRESSURE_H
>  
>  #include <linux/tracepoint.h>
>  
> -TRACE_EVENT(thermal_pressure_update,
> -	TP_PROTO(int cpu, unsigned long thermal_pressure),
> -	TP_ARGS(cpu, thermal_pressure),
> +TRACE_EVENT(hw_pressure_update,
> +	TP_PROTO(int cpu, unsigned long hw_pressure),
> +	TP_ARGS(cpu, hw_pressure),
>  
>  	TP_STRUCT__entry(
> -		__field(unsigned long, thermal_pressure)
> +		__field(unsigned long, hw_pressure)
>  		__field(int, cpu)
>  	),
>  
>  	TP_fast_assign(
> -		__entry->thermal_pressure = thermal_pressure;
> +		__entry->hw_pressure = hw_pressure;
>  		__entry->cpu = cpu;
>  	),
>  
> -	TP_printk("cpu=%d thermal_pressure=%lu", __entry->cpu, __entry->thermal_pressure)
> +	TP_printk("cpu=%d hw_pressure=%lu", __entry->cpu, __entry->hw_pressure)
>  );
>  #endif /* _TRACE_THERMAL_PRESSURE_H */
>  
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index dbb01b4b7451..d115d64c4011 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -752,7 +752,7 @@ DECLARE_TRACE(pelt_dl_tp,
>  	TP_PROTO(struct rq *rq),
>  	TP_ARGS(rq));
>  
> -DECLARE_TRACE(pelt_thermal_tp,
> +DECLARE_TRACE(pelt_hw_tp,
>  	TP_PROTO(struct rq *rq),
>  	TP_ARGS(rq));
>  
> diff --git a/init/Kconfig b/init/Kconfig
> index 9ffb103fc927..37ceeb67e01c 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -538,24 +538,24 @@ config HAVE_SCHED_AVG_IRQ
>  	depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
>  	depends on SMP
>  
> -config SCHED_THERMAL_PRESSURE
> +config SCHED_HW_PRESSURE
>  	bool
>  	default y if ARM && ARM_CPU_TOPOLOGY
>  	default y if ARM64
>  	depends on SMP
>  	depends on CPU_FREQ_THERMAL
>  	help
> -	  Select this option to enable thermal pressure accounting in the
> -	  scheduler. Thermal pressure is the value conveyed to the scheduler
> +	  Select this option to enable HW pressure accounting in the
> +	  scheduler. HW pressure is the value conveyed to the scheduler
>  	  that reflects the reduction in CPU compute capacity resulted from
> -	  thermal throttling. Thermal throttling occurs when the performance of
> -	  a CPU is capped due to high operating temperatures.
> +	  HW throttling. HW throttling occurs when the performance of
> +	  a CPU is capped due to high operating temperatures as an example.
>  
>  	  If selected, the scheduler will be able to balance tasks accordingly,
>  	  i.e. put less load on throttled CPUs than on non/less throttled ones.
>  
>  	  This requires the architecture to implement
> -	  arch_update_thermal_pressure() and arch_scale_thermal_pressure().
> +	  arch_update_hw_pressure() and arch_scale_thermal_pressure().
>  
>  config BSD_PROCESS_ACCT
>  	bool "BSD Process Accounting"
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index db4be4921e7f..a6f084bdf1c5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -107,7 +107,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_rt_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
> -EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_thermal_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_hw_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_cpu_capacity_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
> @@ -5658,7 +5658,7 @@ void scheduler_tick(void)
>  	struct rq *rq = cpu_rq(cpu);
>  	struct task_struct *curr = rq->curr;
>  	struct rq_flags rf;
> -	unsigned long thermal_pressure;
> +	unsigned long hw_pressure;
>  	u64 resched_latency;
>  
>  	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
> @@ -5669,8 +5669,8 @@ void scheduler_tick(void)
>  	rq_lock(rq, &rf);
>  
>  	update_rq_clock(rq);
> -	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> -	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
> +	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
> +	update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure);
>  	curr->sched_class->task_tick(rq, curr, 0);
>  	if (sched_feat(LATENCY_WARN))
>  		resched_latency = cpu_resched_latency(rq);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e54bbf8b4936..f1c3d600d6d6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -78,7 +78,7 @@ static unsigned int normalized_sysctl_sched_base_slice	= 750000ULL;
>  
>  const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
>  
> -int sched_thermal_decay_shift;
> +int sched_hw_decay_shift;
>  static int __init setup_sched_thermal_decay_shift(char *str)
>  {
>  	int _shift = 0;
> @@ -86,7 +86,7 @@ static int __init setup_sched_thermal_decay_shift(char *str)
>  	if (kstrtoint(str, 0, &_shift))
>  		pr_warn("Unable to set scheduler thermal pressure decay shift parameter\n");
>  
> -	sched_thermal_decay_shift = clamp(_shift, 0, 10);
> +	sched_hw_decay_shift = clamp(_shift, 0, 10);
>  	return 1;
>  }
>  __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
> @@ -4914,7 +4914,7 @@ static inline unsigned long get_actual_cpu_capacity(int cpu)
>  {
>  	unsigned long capacity = arch_scale_cpu_capacity(cpu);
>  
> -	capacity -= max(thermal_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
> +	capacity -= max(hw_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
>  
>  	return capacity;
>  }
> @@ -4947,7 +4947,7 @@ static inline int util_fits_cpu(unsigned long util,
>  	 * Similarly if a task is capped to arch_scale_cpu_capacity(little_cpu), it
>  	 * should fit a little cpu even if there's some pressure.
>  	 *
> -	 * Only exception is for thermal pressure since it has a direct impact
> +	 * Only exception is for HW or cpufreq pressure since it has a direct impact
>  	 * on available OPP of the system.
>  	 *
>  	 * We honour it for uclamp_min only as a drop in performance level
> @@ -9202,7 +9202,7 @@ static inline bool others_have_blocked(struct rq *rq)
>  	if (READ_ONCE(rq->avg_dl.util_avg))
>  		return true;
>  
> -	if (thermal_load_avg(rq))
> +	if (hw_load_avg(rq))
>  		return true;
>  
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
> @@ -9234,7 +9234,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>  {
>  	const struct sched_class *curr_class;
>  	u64 now = rq_clock_pelt(rq);
> -	unsigned long thermal_pressure;
> +	unsigned long hw_pressure;
>  	bool decayed;
>  
>  	/*
> @@ -9243,11 +9243,11 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>  	 */
>  	curr_class = rq->curr->sched_class;
>  
> -	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> +	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
>  
>  	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
>  		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> -		  update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure) |
> +		  update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure) |
>  		  update_irq_load_avg(rq, 0);
>  
>  	if (others_have_blocked(rq))
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index 63b6cf898220..f951c44f1d52 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -384,30 +384,30 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_SCHED_THERMAL_PRESSURE
> +#ifdef CONFIG_SCHED_HW_PRESSURE
>  /*
> - * thermal:
> + * hardware:
>   *
>   *   load_sum = \Sum se->avg.load_sum but se->avg.load_sum is not tracked
>   *
>   *   util_avg and runnable_load_avg are not supported and meaningless.
>   *
>   * Unlike rt/dl utilization tracking that track time spent by a cpu
> - * running a rt/dl task through util_avg, the average thermal pressure is
> - * tracked through load_avg. This is because thermal pressure signal is
> + * running a rt/dl task through util_avg, the average HW pressure is
> + * tracked through load_avg. This is because HW pressure signal is
>   * time weighted "delta" capacity unlike util_avg which is binary.
>   * "delta capacity" =  actual capacity  -
> - *			capped capacity a cpu due to a thermal event.
> + *			capped capacity a cpu due to a HW event.
>   */
>  
> -int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
>  {
> -	if (___update_load_sum(now, &rq->avg_thermal,
> +	if (___update_load_sum(now, &rq->avg_hw,
>  			       capacity,
>  			       capacity,
>  			       capacity)) {
> -		___update_load_avg(&rq->avg_thermal, 1);
> -		trace_pelt_thermal_tp(rq);
> +		___update_load_avg(&rq->avg_hw, 1);
> +		trace_pelt_hw_tp(rq);
>  		return 1;
>  	}
>  
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index 9e1083465fbc..2150062949d4 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -7,21 +7,21 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
>  int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
>  
> -#ifdef CONFIG_SCHED_THERMAL_PRESSURE
> -int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
> +#ifdef CONFIG_SCHED_HW_PRESSURE
> +int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity);
>  
> -static inline u64 thermal_load_avg(struct rq *rq)
> +static inline u64 hw_load_avg(struct rq *rq)
>  {
> -	return READ_ONCE(rq->avg_thermal.load_avg);
> +	return READ_ONCE(rq->avg_hw.load_avg);
>  }
>  #else
>  static inline int
> -update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
>  {
>  	return 0;
>  }
>  
> -static inline u64 thermal_load_avg(struct rq *rq)
> +static inline u64 hw_load_avg(struct rq *rq)
>  {
>  	return 0;
>  }
> @@ -202,12 +202,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>  }
>  
>  static inline int
> -update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
>  {
>  	return 0;
>  }
>  
> -static inline u64 thermal_load_avg(struct rq *rq)
> +static inline u64 hw_load_avg(struct rq *rq)
>  {
>  	return 0;
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e58a54bda77d..677d24202eec 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1078,8 +1078,8 @@ struct rq {
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  	struct sched_avg	avg_irq;
>  #endif
> -#ifdef CONFIG_SCHED_THERMAL_PRESSURE
> -	struct sched_avg	avg_thermal;
> +#ifdef CONFIG_SCHED_HW_PRESSURE
> +	struct sched_avg	avg_hw;
>  #endif
>  	u64			idle_stamp;
>  	u64			avg_idle;
> @@ -1531,11 +1531,11 @@ static inline u64 rq_clock_task(struct rq *rq)
>   *	3			256
>   *	4			512
>   */
> -extern int sched_thermal_decay_shift;
> +extern int sched_hw_decay_shift;
>  
> -static inline u64 rq_clock_thermal(struct rq *rq)
> +static inline u64 rq_clock_hw(struct rq *rq)
>  {
> -	return rq_clock_task(rq) >> sched_thermal_decay_shift;
> +	return rq_clock_task(rq) >> sched_hw_decay_shift;
>  }
>  
>  static inline void rq_clock_skip_update(struct rq *rq)
> -- 
> 2.34.1
> 

