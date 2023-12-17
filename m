Return-Path: <linux-kernel+bounces-2766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7B3816184
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D901F21A75
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F70D47A66;
	Sun, 17 Dec 2023 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="hoDrg9cJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D347A78
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33668cdb982so59892f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 10:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702836018; x=1703440818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DjTCpnUGn4KBlZ0Ywyu5H1cv+f2lB6j5TM6mv3JNV0I=;
        b=hoDrg9cJXlVpL6hgzpuT5WaNlmEQ9O4uJ3GNmydCGdeEFNo11IaQ3Va5iPZVhplEbL
         emIqzBrhTZVtQvp4Hqg6Aw4zblP+PKsoGeixXWMKoZBNasQtExRXk/nAhTJd2PH8EzKg
         8MzvLhhyc1T1Fgu3w2ZsjFkj/O/D6VyF7LYGh4EJtC9L7pRUH432rTeBVeI3eBQKlh97
         awhI3sGQ2Kuj5MhwmKQRF90t16DaOHKr6de51Nvv2sDv1DI0BbCnE222XcRP5MI3TYff
         UP7UJixjBxRip1cPD9M3jDheeCvO201QR9O76OYqXSTx3vpnEq78e0XYnDPebRNt0wWZ
         XEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702836018; x=1703440818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjTCpnUGn4KBlZ0Ywyu5H1cv+f2lB6j5TM6mv3JNV0I=;
        b=NQ/E9vOBYC+MMPWmZQdMMmZkNQ57D1C3X+djfXlNOIB6coFAbD5MwWG6eCf0YDF2lZ
         /tM7IykoOCEblIgMDD1cuvN4Vit9guIJKEmfGbuTCqxrzHIWOT794XXBdKrz3E01GMkX
         PMHHsV/bnLoDp41/ZPdjFNm52iaTJMaE6/ubv4oeIQU32mpRBQVY5HzzWO8DuosXTmOc
         KRyCdpNMhsDuPd4hjuZpo0H8MNpwk0893VEsoAYySBP+S+2L6AcW+DwkiYn86K2Gcr6r
         vjGfMnup0YD1bIjmiDkkYT7yX7fBZ6zO/7ymAH2sfn42zLJAKJTb2e2qpua3rJH/52v8
         +W7g==
X-Gm-Message-State: AOJu0YyzcCFURiT3n1f+7BC8HtJjZX3r/h6piBtoWTWVjfrokpWgW8XH
	aYZofx8Id4uBDrC1oGuUyQIPaw==
X-Google-Smtp-Source: AGHT+IGfozpQr3KKqaJ1UK2NQKXWnaZvIuddDDjwDFgis6eUGTO4PaiwnyHzZ0hPXGFxJIlNXmilzA==
X-Received: by 2002:a5d:4486:0:b0:336:64fd:72e7 with SMTP id j6-20020a5d4486000000b0033664fd72e7mr536883wrq.52.1702836018138;
        Sun, 17 Dec 2023 10:00:18 -0800 (PST)
Received: from airbuntu (host86-135-101-43.range86-135.btcentralplus.com. [86.135.101.43])
        by smtp.gmail.com with ESMTPSA id h15-20020a5d504f000000b00336566b885csm6591930wrt.87.2023.12.17.10.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 10:00:17 -0800 (PST)
Date: Sun, 17 Dec 2023 18:00:16 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 13/23] PM: EM: Add performance field to struct
 em_perf_state
Message-ID: <20231217180016.wkkatrjuanuk5x52@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-14-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129110853.94344-14-lukasz.luba@arm.com>

On 11/29/23 11:08, Lukasz Luba wrote:
> The performance doesn't scale linearly with the frequency. Also, it may
> be different in different workloads. Some CPUs are designed to be
> particularly good at some applications e.g. images or video processing
> and other CPUs in different. When those different types of CPUs are
> combined in one SoC they should be properly modeled to get max of the HW
> in Energy Aware Scheduler (EAS). The Energy Model (EM) provides the
> power vs. performance curves to the EAS, but assumes the CPUs capacity
> is fixed and scales linearly with the frequency. This patch allows to
> adjust the curve on the 'performance' axis as well.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 11 ++++++-----
>  kernel/power/energy_model.c  | 27 +++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index ae3ccc8b9f44..e30750500b10 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -13,6 +13,7 @@
>  
>  /**
>   * struct em_perf_state - Performance state of a performance domain
> + * @performance:	Non-linear CPU performance at a given frequency
>   * @frequency:	The frequency in KHz, for consistency with CPUFreq
>   * @power:	The power consumed at this level (by 1 CPU or by a registered
>   *		device). It can be a total power: static and dynamic.
> @@ -21,6 +22,7 @@
>   * @flags:	see "em_perf_state flags" description below.
>   */
>  struct em_perf_state {
> +	unsigned long performance;
>  	unsigned long frequency;
>  	unsigned long power;
>  	unsigned long cost;
> @@ -207,14 +209,14 @@ void em_free_table(struct em_perf_table __rcu *table);
>   */
>  static inline int
>  em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
> -			  unsigned long freq, unsigned long pd_flags)
> +			  unsigned long max_util, unsigned long pd_flags)
>  {
>  	struct em_perf_state *ps;
>  	int i;
>  
>  	for (i = 0; i < nr_perf_states; i++) {
>  		ps = &table[i];
> -		if (ps->frequency >= freq) {
> +		if (ps->performance >= max_util) {
>  			if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
>  			    ps->flags & EM_PERF_STATE_INEFFICIENT)
>  				continue;
> @@ -246,8 +248,8 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  				unsigned long allowed_cpu_cap)
>  {
>  	struct em_perf_table *runtime_table;
> -	unsigned long freq, scale_cpu;
>  	struct em_perf_state *ps;
> +	unsigned long scale_cpu;
>  	int cpu, i;
>  
>  	if (!sum_util)
> @@ -274,14 +276,13 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  
>  	max_util = map_util_perf(max_util);
>  	max_util = min(max_util, allowed_cpu_cap);
> -	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
>  
>  	/*
>  	 * Find the lowest performance state of the Energy Model above the
>  	 * requested frequency.
>  	 */
>  	i = em_pd_get_efficient_state(runtime_table->state, pd->nr_perf_states,
> -				      freq, pd->flags);
> +				      max_util, pd->flags);
>  	ps = &runtime_table->state[i];
>  
>  	/*
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 614891fde8df..b5016afe6a19 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -46,6 +46,7 @@ static void em_debug_create_ps(struct em_perf_state *ps, struct dentry *pd)
>  	debugfs_create_ulong("frequency", 0444, d, &ps->frequency);
>  	debugfs_create_ulong("power", 0444, d, &ps->power);
>  	debugfs_create_ulong("cost", 0444, d, &ps->cost);
> +	debugfs_create_ulong("performance", 0444, d, &ps->performance);
>  	debugfs_create_ulong("inefficient", 0444, d, &ps->flags);
>  }
>  
> @@ -171,6 +172,30 @@ em_allocate_table(struct em_perf_domain *pd)
>  	return table;
>  }
>  
> +static void em_init_performance(struct device *dev, struct em_perf_domain *pd,
> +				struct em_perf_state *table, int nr_states)
> +{
> +	u64 fmax, max_cap;
> +	int i, cpu;
> +
> +	/* This is needed only for CPUs and EAS skip other devices */
> +	if (!_is_cpu_device(dev))
> +		return;
> +
> +	cpu = cpumask_first(em_span_cpus(pd));
> +
> +	/*
> +	 * Calculate the performance value for each frequency with
> +	 * linear relationship. The final CPU capacity might not be ready at
> +	 * boot time, but the EM will be updated a bit later with correct one.
> +	 */
> +	fmax = (u64) table[nr_states - 1].frequency;
> +	max_cap = (u64) arch_scale_cpu_capacity(cpu);
> +	for (i = 0; i < nr_states; i++)
> +		table[i].performance = div64_u64(max_cap * table[i].frequency,
> +						 fmax);

Should we sanity check the returned performance value is correct in case we got
passed a malformed table? Maybe the table is sanity checked and sorted before
we get here; I didn't check to be honest.

I think a warning that performance is always <= max_cap would be helpful in
general as code evolved in the future.


Cheers

--
Qais Yousef

> +}
> +
>  static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>  			    struct em_data_callback *cb, int nr_states,
>  			    unsigned long flags)
> @@ -331,6 +356,8 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>  		table[i].frequency = prev_freq = freq;
>  	}
>  
> +	em_init_performance(dev, pd, table, nr_states);
> +
>  	ret = em_compute_costs(dev, table, cb, nr_states, flags);
>  	if (ret)
>  		return -EINVAL;
> -- 
> 2.25.1
> 

