Return-Path: <linux-kernel+bounces-12818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A2B81FA65
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAED281A18
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126E4F9E9;
	Thu, 28 Dec 2023 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="qBrGohN7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA592F9CD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d4a7f0c4dso54209505e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 09:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1703785533; x=1704390333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t17zhnvUZMrwPe4M90D7rizbLoQ1mPsaQ/6pYkn8TPU=;
        b=qBrGohN71R+JQBJd22bnE4v8kJEYC5En0f8Pfn/rYOszoo9nOohLIXOaD50SS6RFAP
         MxMtDGBXDEQT48PcLzmuFp1lyT3J1kjdjvW7u/KVyHYwj6/RDK10Ys54RipesWkdYuS0
         KzEzNwE3RLwEczHjoyc3kzEserb090ehsL+Dr/SYGM/33aB1RQ9huJgszbwhvcZobRmn
         iClEsUo3oi2gULgWWFcWcVNxYx4P+Ebfm6ISNsW8PoEXTEsULB6b7Xm/ALg8oi6w5+mz
         oXbnZ9unNnznVeHLQ3J/3bO5QRWRGnDvkA2WTBNAMgMaogC8QAlfemuB5xXuSg3E/FhD
         ILlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703785533; x=1704390333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t17zhnvUZMrwPe4M90D7rizbLoQ1mPsaQ/6pYkn8TPU=;
        b=EXDx9sYkeKUSr8wUaCWhvp0BHWZ3NORI2slEz5mj/W/mtWkfCyKXwonlTSpNhffUB8
         GJ+oaPxuYwyNndirTxR9jk6Tg0bKCU6LIxZS96R5fDiu1MJ6Pm785DqVoHHeceDt8uVK
         ai0ApkAkQb+qBP+Qhh9q1x1iXUpDhtcJtZ+34x93GHF5XdXi9hZeUizdT+h8iKY/N0HK
         105iq3ygrknLaTu+7UuetQiNO/SvPXfzANprFlZSHnPLqlPOMZo25RcNet6krev0za87
         40rxouEaSw7MBDz1BH+rCj26tt1qBizX2T8W8AjiiTANBDAVdncmBU4xEZLbO2iAozUl
         O+kA==
X-Gm-Message-State: AOJu0Yy2pBfUl8LsyZc0RdO9EUcSkwA/nVQ2MVNjm6q1bsnoCXS4H2KW
	hu5v7nX1fT1MiD1PozCnzWY2+jgNcx/xokwN7TvhhTqVujc=
X-Google-Smtp-Source: AGHT+IFll7vT6kM9borH5xvYjMHoCPQmIe/6bYQfqRFdoeP0QrW+l0VDdEWLy2iioeMbz2VHA3QEdA==
X-Received: by 2002:a05:600c:19c8:b0:40d:5f64:3498 with SMTP id u8-20020a05600c19c800b0040d5f643498mr1297942wmq.59.1703785532897;
        Thu, 28 Dec 2023 09:45:32 -0800 (PST)
Received: from airbuntu (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id q11-20020a05600c46cb00b0040d2d33312csm28200226wmo.2.2023.12.28.09.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 09:45:32 -0800 (PST)
Date: Thu, 28 Dec 2023 17:45:31 +0000
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
Message-ID: <20231228174531.zackmuqatd5c2mup@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-14-lukasz.luba@arm.com>
 <20231217180016.wkkatrjuanuk5x52@airbuntu>
 <315089c4-7a22-4661-8581-2d052c25e158@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <315089c4-7a22-4661-8581-2d052c25e158@arm.com>

On 12/20/23 08:21, Lukasz Luba wrote:
> 
> 
> On 12/17/23 18:00, Qais Yousef wrote:
> > On 11/29/23 11:08, Lukasz Luba wrote:
> > > The performance doesn't scale linearly with the frequency. Also, it may
> > > be different in different workloads. Some CPUs are designed to be
> > > particularly good at some applications e.g. images or video processing
> > > and other CPUs in different. When those different types of CPUs are
> > > combined in one SoC they should be properly modeled to get max of the HW
> > > in Energy Aware Scheduler (EAS). The Energy Model (EM) provides the
> > > power vs. performance curves to the EAS, but assumes the CPUs capacity
> > > is fixed and scales linearly with the frequency. This patch allows to
> > > adjust the curve on the 'performance' axis as well.
> > > 
> > > Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > > ---
> > >   include/linux/energy_model.h | 11 ++++++-----
> > >   kernel/power/energy_model.c  | 27 +++++++++++++++++++++++++++
> > >   2 files changed, 33 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> > > index ae3ccc8b9f44..e30750500b10 100644
> > > --- a/include/linux/energy_model.h
> > > +++ b/include/linux/energy_model.h
> > > @@ -13,6 +13,7 @@
> > >   /**
> > >    * struct em_perf_state - Performance state of a performance domain
> > > + * @performance:	Non-linear CPU performance at a given frequency
> > >    * @frequency:	The frequency in KHz, for consistency with CPUFreq
> > >    * @power:	The power consumed at this level (by 1 CPU or by a registered
> > >    *		device). It can be a total power: static and dynamic.
> > > @@ -21,6 +22,7 @@
> > >    * @flags:	see "em_perf_state flags" description below.
> > >    */
> > >   struct em_perf_state {
> > > +	unsigned long performance;
> > >   	unsigned long frequency;
> > >   	unsigned long power;
> > >   	unsigned long cost;
> > > @@ -207,14 +209,14 @@ void em_free_table(struct em_perf_table __rcu *table);
> > >    */
> > >   static inline int
> > >   em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
> > > -			  unsigned long freq, unsigned long pd_flags)
> > > +			  unsigned long max_util, unsigned long pd_flags)
> > >   {
> > >   	struct em_perf_state *ps;
> > >   	int i;
> > >   	for (i = 0; i < nr_perf_states; i++) {
> > >   		ps = &table[i];
> > > -		if (ps->frequency >= freq) {
> > > +		if (ps->performance >= max_util) {
> > >   			if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
> > >   			    ps->flags & EM_PERF_STATE_INEFFICIENT)
> > >   				continue;
> > > @@ -246,8 +248,8 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> > >   				unsigned long allowed_cpu_cap)
> > >   {
> > >   	struct em_perf_table *runtime_table;
> > > -	unsigned long freq, scale_cpu;
> > >   	struct em_perf_state *ps;
> > > +	unsigned long scale_cpu;
> > >   	int cpu, i;
> > >   	if (!sum_util)
> > > @@ -274,14 +276,13 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> > >   	max_util = map_util_perf(max_util);
> > >   	max_util = min(max_util, allowed_cpu_cap);
> > > -	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
> > >   	/*
> > >   	 * Find the lowest performance state of the Energy Model above the
> > >   	 * requested frequency.
> > >   	 */
> > >   	i = em_pd_get_efficient_state(runtime_table->state, pd->nr_perf_states,
> > > -				      freq, pd->flags);
> > > +				      max_util, pd->flags);
> > >   	ps = &runtime_table->state[i];
> > >   	/*
> > > diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> > > index 614891fde8df..b5016afe6a19 100644
> > > --- a/kernel/power/energy_model.c
> > > +++ b/kernel/power/energy_model.c
> > > @@ -46,6 +46,7 @@ static void em_debug_create_ps(struct em_perf_state *ps, struct dentry *pd)
> > >   	debugfs_create_ulong("frequency", 0444, d, &ps->frequency);
> > >   	debugfs_create_ulong("power", 0444, d, &ps->power);
> > >   	debugfs_create_ulong("cost", 0444, d, &ps->cost);
> > > +	debugfs_create_ulong("performance", 0444, d, &ps->performance);
> > >   	debugfs_create_ulong("inefficient", 0444, d, &ps->flags);
> > >   }
> > > @@ -171,6 +172,30 @@ em_allocate_table(struct em_perf_domain *pd)
> > >   	return table;
> > >   }
> > > +static void em_init_performance(struct device *dev, struct em_perf_domain *pd,
> > > +				struct em_perf_state *table, int nr_states)
> > > +{
> > > +	u64 fmax, max_cap;
> > > +	int i, cpu;
> > > +
> > > +	/* This is needed only for CPUs and EAS skip other devices */
> > > +	if (!_is_cpu_device(dev))
> > > +		return;
> > > +
> > > +	cpu = cpumask_first(em_span_cpus(pd));
> > > +
> > > +	/*
> > > +	 * Calculate the performance value for each frequency with
> > > +	 * linear relationship. The final CPU capacity might not be ready at
> > > +	 * boot time, but the EM will be updated a bit later with correct one.
> > > +	 */
> > > +	fmax = (u64) table[nr_states - 1].frequency;
> > > +	max_cap = (u64) arch_scale_cpu_capacity(cpu);
> > > +	for (i = 0; i < nr_states; i++)
> > > +		table[i].performance = div64_u64(max_cap * table[i].frequency,
> > > +						 fmax);
> > 
> > Should we sanity check the returned performance value is correct in case we got
> > passed a malformed table? Maybe the table is sanity checked and sorted before
> > we get here; I didn't check to be honest.
> 
> The frequency values are checked if they have asc sorting order. It's
> done in the em_create_perf_table(). There is even an error printed and
> returned, so the EM registration will fail.
> 
> > 
> > I think a warning that performance is always <= max_cap would be helpful in
> > general as code evolved in the future.
> 
> I don't see that need. There are needed checks for frequency values and
> this simple math formula is just linear. Nothing can happen when
> frequencies are sorted asc. The whole EAS relies on that fact:
> 
> Frequencies are sorted ascending, thus
> fmax = (u64) table[nr_states - 1].frequency
> is always true.

I saw that but wasn't sure if this is always guaranteed. It seems it is from
you're saying, then yes no issues here then.

