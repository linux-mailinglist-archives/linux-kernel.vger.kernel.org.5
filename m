Return-Path: <linux-kernel+bounces-9935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E1481CD7C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA512846E7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA1B28E33;
	Fri, 22 Dec 2023 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBDhPyyn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB1428E13;
	Fri, 22 Dec 2023 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703264942; x=1734800942;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jrbK3JxBO1NzBg6D2UAI0w9iU17c+JQnpCe0XS7kc6Y=;
  b=nBDhPyynnvh/QOLBnUOsFkwXnbV0K/yfYMiyFLhsyprgYWmGmvBaXOCQ
   DhuzgC0fvlq/10ZaFLb+F7lI6Lz+PieKLVAwOpvzWlzRv0svPV1qVQA/T
   T/b5KPfkNcR18TsVScl8SjznaI5CvSryXe7Iy4PoGJAi3mzHxA2j48zTr
   J30r8SaSKzvBpRkaeFUoS4xnjTq+0il6k8f6Y/7PaSKBGq0RPuJcjVzNk
   ZH2ODrSpT2i9SGUlJ57Jkc0cikEHQ0yEjl+21maIaA83bxFGKMVLfJw74
   H5pLUDHC0sJqGfqOm2aybltdrS10IklHy+odueATPg4N3Toz8QkWE+256
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="9536686"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="9536686"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 09:09:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="1108514958"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="1108514958"
Received: from kambika-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.152.51])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 09:08:54 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: lakshmi.sowjanya.d@intel.com, tglx@linutronix.de, jstultz@google.com,
 giometti@enneenne.com, corbet@lwn.net, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, andriy.shevchenko@linux.intel.com,
 eddie.dong@intel.com, christopher.s.hall@intel.com,
 jesse.brandeburg@intel.com, davem@davemloft.net,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, perex@perex.cz, linux-sound@vger.kernel.org,
 anthony.l.nguyen@intel.com, pandith.n@intel.com,
 mallikarjunappa.sangannavar@intel.com, thejesh.reddy.t.r@intel.com,
 lakshmi.sowjanya.d@intel.com
Subject: Re: [RFC PATCH v2 01/10] x86/tsc: Add base clock properties in
 clocksource structure
In-Reply-To: <20231221093254.9599-2-lakshmi.sowjanya.d@intel.com>
References: <20231221093254.9599-1-lakshmi.sowjanya.d@intel.com>
 <20231221093254.9599-2-lakshmi.sowjanya.d@intel.com>
Date: Fri, 22 Dec 2023 14:08:51 -0300
Message-ID: <87v88qjhb0.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

lakshmi.sowjanya.d@intel.com writes:

> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>
> Remove convert_art_to_tsc() and convert_art_ns_to_tsc(), as this patch
> series introduces a generic function ktime_real_to_base_clock() to
> convert realtime to base clock domain.
>
> Add hardware abstraction, struct clocksource_base in clocksource.
>
> Add clocksource ID for x86 ART(Always Running Timer).
>
> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
> Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> ---

This patch is breaking compilation. I guess it needs to be split into
two.

You are removing functions that drivers are using. You have to convert
the drivers to the new abstractions, and only after all in-tree users
are converted you remove the old functions.

>  arch/x86/include/asm/tsc.h      |  3 --
>  arch/x86/kernel/tsc.c           | 94 +++++++--------------------------
>  include/linux/clocksource.h     | 27 ++++++++++
>  include/linux/clocksource_ids.h |  1 +
>  4 files changed, 47 insertions(+), 78 deletions(-)
>
> diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
> index 594fce0ca744..5e36495cc821 100644
> --- a/arch/x86/include/asm/tsc.h
> +++ b/arch/x86/include/asm/tsc.h
> @@ -27,9 +27,6 @@ static inline cycles_t get_cycles(void)
>  }
>  #define get_cycles get_cycles
>  
> -extern struct system_counterval_t convert_art_to_tsc(u64 art);
> -extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
> -
>  extern void tsc_early_init(void);
>  extern void tsc_init(void);
>  extern void mark_tsc_unstable(char *reason);
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 868f09966b0f..b45ce594cfef 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -51,9 +51,9 @@ int tsc_clocksource_reliable;
>  
>  static int __read_mostly tsc_force_recalibrate;
>  
> -static u32 art_to_tsc_numerator;
> -static u32 art_to_tsc_denominator;
> -static u64 art_to_tsc_offset;
> +static struct clocksource_base art_base_clk = {
> +	.id    = CSID_X86_ART,
> +};
>  static bool have_art;
>  
>  struct cyc2ns {
> @@ -1075,7 +1075,7 @@ core_initcall(cpufreq_register_tsc_scaling);
>   */
>  static void __init detect_art(void)
>  {
> -	unsigned int unused[2];
> +	unsigned int unused;
>  
>  	if (boot_cpu_data.cpuid_level < ART_CPUID_LEAF)
>  		return;
> @@ -1090,13 +1090,14 @@ static void __init detect_art(void)
>  	    tsc_async_resets)
>  		return;
>  
> -	cpuid(ART_CPUID_LEAF, &art_to_tsc_denominator,
> -	      &art_to_tsc_numerator, unused, unused+1);
> +	cpuid(ART_CPUID_LEAF, &art_base_clk.denominator,
> +		&art_base_clk.numerator, &art_base_clk.freq_khz, &unused);
>  
> -	if (art_to_tsc_denominator < ART_MIN_DENOMINATOR)
> +	art_base_clk.freq_khz /= KHZ;
> +	if (art_base_clk.denominator < ART_MIN_DENOMINATOR)
>  		return;
>  
> -	rdmsrl(MSR_IA32_TSC_ADJUST, art_to_tsc_offset);
> +	rdmsrl(MSR_IA32_TSC_ADJUST, art_base_clk.offset);
>  
>  	/* Make this sticky over multiple CPU init calls */
>  	setup_force_cpu_cap(X86_FEATURE_ART);
> @@ -1297,69 +1298,6 @@ int unsynchronized_tsc(void)
>  	return 0;
>  }
>  
> -/*
> - * Convert ART to TSC given numerator/denominator found in detect_art()
> - */
> -struct system_counterval_t convert_art_to_tsc(u64 art)
> -{
> -	u64 tmp, res, rem;
> -
> -	rem = do_div(art, art_to_tsc_denominator);
> -
> -	res = art * art_to_tsc_numerator;
> -	tmp = rem * art_to_tsc_numerator;
> -
> -	do_div(tmp, art_to_tsc_denominator);
> -	res += tmp + art_to_tsc_offset;
> -
> -	return (struct system_counterval_t) {
> -		.cs_id = have_art ? CSID_X86_TSC : CSID_GENERIC,
> -		.cycles = res
> -	};
> -}
> -EXPORT_SYMBOL(convert_art_to_tsc);
> -
> -/**
> - * convert_art_ns_to_tsc() - Convert ART in nanoseconds to TSC.
> - * @art_ns: ART (Always Running Timer) in unit of nanoseconds
> - *
> - * PTM requires all timestamps to be in units of nanoseconds. When user
> - * software requests a cross-timestamp, this function converts system timestamp
> - * to TSC.
> - *
> - * This is valid when CPU feature flag X86_FEATURE_TSC_KNOWN_FREQ is set
> - * indicating the tsc_khz is derived from CPUID[15H]. Drivers should check
> - * that this flag is set before conversion to TSC is attempted.
> - *
> - * Return:
> - * struct system_counterval_t - system counter value with the ID of the
> - *	corresponding clocksource
> - *	@cycles:	System counter value
> - *	@cs_id:		Clocksource ID corresponding to system counter value.
> - *			Used by timekeeping code to verify comparability of two
> - *			cycle values.
> - */
> -
> -struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
> -{
> -	u64 tmp, res, rem;
> -
> -	rem = do_div(art_ns, USEC_PER_SEC);
> -
> -	res = art_ns * tsc_khz;
> -	tmp = rem * tsc_khz;
> -
> -	do_div(tmp, USEC_PER_SEC);
> -	res += tmp;
> -
> -	return (struct system_counterval_t) {
> -		.cs_id = have_art ? CSID_X86_TSC : CSID_GENERIC,
> -		.cycles = res
> -	};
> -}
> -EXPORT_SYMBOL(convert_art_ns_to_tsc);
> -
> -
>  static void tsc_refine_calibration_work(struct work_struct *work);
>  static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
>  /**
> @@ -1461,8 +1399,10 @@ static void tsc_refine_calibration_work(struct work_struct *work)
>  	if (tsc_unstable)
>  		goto unreg;
>  
> -	if (boot_cpu_has(X86_FEATURE_ART))
> +	if (boot_cpu_has(X86_FEATURE_ART)) {
>  		have_art = true;
> +		clocksource_tsc.base = &art_base_clk;
> +	}
>  	clocksource_register_khz(&clocksource_tsc, tsc_khz);
>  unreg:
>  	clocksource_unregister(&clocksource_tsc_early);
> @@ -1487,8 +1427,10 @@ static int __init init_tsc_clocksource(void)
>  	 * the refined calibration and directly register it as a clocksource.
>  	 */
>  	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
> -		if (boot_cpu_has(X86_FEATURE_ART))
> +		if (boot_cpu_has(X86_FEATURE_ART)) {
>  			have_art = true;
> +			clocksource_tsc.base = &art_base_clk;
> +		}
>  		clocksource_register_khz(&clocksource_tsc, tsc_khz);
>  		clocksource_unregister(&clocksource_tsc_early);
>  
> @@ -1512,10 +1454,12 @@ static bool __init determine_cpu_tsc_frequencies(bool early)
>  
>  	if (early) {
>  		cpu_khz = x86_platform.calibrate_cpu();
> -		if (tsc_early_khz)
> +		if (tsc_early_khz) {
>  			tsc_khz = tsc_early_khz;
> -		else
> +		} else {
>  			tsc_khz = x86_platform.calibrate_tsc();
> +			clocksource_tsc.freq_khz = tsc_khz;
> +		}
>  	} else {
>  		/* We should not be here with non-native cpu calibration */
>  		WARN_ON(x86_platform.calibrate_cpu != native_calibrate_cpu);
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 1d42d4b17327..0a1110a0e660 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -21,6 +21,7 @@
>  #include <asm/div64.h>
>  #include <asm/io.h>
>  
> +struct clocksource_base;
>  struct clocksource;
>  struct module;
>  
> @@ -48,6 +49,7 @@ struct module;
>   * @archdata:		Optional arch-specific data
>   * @max_cycles:		Maximum safe cycle value which won't overflow on
>   *			multiplication
> + * @freq_khz:		Clocksource frequency in khz.
>   * @name:		Pointer to clocksource name
>   * @list:		List head for registration (internal)
>   * @rating:		Rating value for selection (higher is better)
> @@ -70,6 +72,8 @@ struct module;
>   *			validate the clocksource from which the snapshot was
>   *			taken.
>   * @flags:		Flags describing special properties
> + * @base:		Hardware abstraction for clock on which a clocksource
> + *			is based
>   * @enable:		Optional function to enable the clocksource
>   * @disable:		Optional function to disable the clocksource
>   * @suspend:		Optional suspend function for the clocksource
> @@ -105,12 +109,14 @@ struct clocksource {
>  	struct arch_clocksource_data archdata;
>  #endif
>  	u64			max_cycles;
> +	u32			freq_khz;
>  	const char		*name;
>  	struct list_head	list;
>  	int			rating;
>  	enum clocksource_ids	id;
>  	enum vdso_clock_mode	vdso_clock_mode;
>  	unsigned long		flags;
> +	struct clocksource_base *base;
>  
>  	int			(*enable)(struct clocksource *cs);
>  	void			(*disable)(struct clocksource *cs);
> @@ -294,4 +300,25 @@ static inline void timer_probe(void) {}
>  extern ulong max_cswd_read_retries;
>  void clocksource_verify_percpu(struct clocksource *cs);
>  
> +/**
> + * struct clocksource_base - hardware abstraction for clock on which a clocksource
> + *			is based
> + * @id:			Defaults to CSID_GENERIC. The id value is used for conversion
> + *			functions which require that the current clocksource is based
> + *			on a clocksource_base with a particular ID in certain snapshot
> + *			functions to allow callers to validate the clocksource from
> + *			which the snapshot was taken.
> + * @freq_khz:		Nominal frequency of the base clock in kHz
> + * @offset:		Offset between the base clock and the clocksource
> + * @numerator:		Numerator of the clock ratio between base clock and the clocksource
> + * @denominator:	Denominator of the clock ratio between base clock and the clocksource
> + */
> +struct clocksource_base {
> +	enum clocksource_ids	id;
> +	u32			freq_khz;
> +	u64			offset;
> +	u32			numerator;
> +	u32			denominator;
> +};
> +
>  #endif /* _LINUX_CLOCKSOURCE_H */
> diff --git a/include/linux/clocksource_ids.h b/include/linux/clocksource_ids.h
> index a4fa3436940c..2bb4d8c2f1b0 100644
> --- a/include/linux/clocksource_ids.h
> +++ b/include/linux/clocksource_ids.h
> @@ -9,6 +9,7 @@ enum clocksource_ids {
>  	CSID_X86_TSC_EARLY,
>  	CSID_X86_TSC,
>  	CSID_X86_KVM_CLK,
> +	CSID_X86_ART,
>  	CSID_MAX,
>  };
>  
> -- 
> 2.35.3
>
>

-- 
Vinicius

