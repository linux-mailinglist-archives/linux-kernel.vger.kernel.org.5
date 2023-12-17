Return-Path: <linux-kernel+bounces-2767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4F8816186
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4211F21C54
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0889B47F55;
	Sun, 17 Dec 2023 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="qf2/Lnt/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2130047A57
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40b5155e154so28614465e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 10:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702836040; x=1703440840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8MOpwItWBsHYymvYej4FDwDnmAuo53HAqT3OQ9IvZgA=;
        b=qf2/Lnt/eISxvS+ZM7W6iw/xdwzXmrklZ4MB94nI/gA98P8EEdB8SZX/j4jIZAlmei
         3LbMSTQ5AiCgPQacrTbvG35WThVqYljRSDTF+osnZfzKtVsZX1sBzy+lhHBwiuISUKDd
         YB2xATtMUolu+tU8d8nngQXhwlDQFs5o6qbTl/bRK/AoUD3ke6UXV++Q04hY2xphmd7/
         LjT7jKOXg3RUTZOtlML2ftqoUVOhmloMBOahkhzIISBMrjnv3NI0Q4yaaQsDf0YlbYVY
         JLVeBzvoKTWFyXaN74XUHGXq1uOHL8yihoJTqQd33yMTB1FK4MyuAaWHimT9XY2aooWk
         dZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702836040; x=1703440840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MOpwItWBsHYymvYej4FDwDnmAuo53HAqT3OQ9IvZgA=;
        b=k/yej257a5JSjtI5yn1leFc+enLXlbSQLXEVyWMqKPuekjoPDR7W7KXUvwgCoIPk/Z
         K7MBAIjukt/xYwKwmCOyatVeTbsBfmm6JKmqGMgIadiDbH4ghu6nwVpOXIAE6fBB/zxQ
         i4lG9tkPwF9XVceIO1Qzz8Kv+vNIqKIeOs4B62kafHkFUJpXGqIAxtIk3r4BZMfCsC4D
         ej7KD+R6PcEXnyJLwPEFYZaSvOlyoWVlffyIZLb7TGG4iaT6ERyZn/vcDwmxYlw9HvmW
         ollIUlLqAPfzf907NQgwXYJvm+pGjup9FkMgFgfwVPe8BZJ3iDnXAp64RNPdyeX5IoQ+
         bBOw==
X-Gm-Message-State: AOJu0YwxqB21n2hzhqj4MTvNF6uTmPIldKPqZNxbl/bioFiWRDDEsdlr
	Yt99CS2iS0+OlT//2o/zO1DHOg==
X-Google-Smtp-Source: AGHT+IHwheY/rHa12G+ia3nNLKUnQG1KK1+g37BPE3XZeZ9ZgajPBvcoWAWHtH++FIqChraDc2YieQ==
X-Received: by 2002:a7b:c388:0:b0:40b:5e1f:6fd5 with SMTP id s8-20020a7bc388000000b0040b5e1f6fd5mr6705877wmj.42.1702836040341;
        Sun, 17 Dec 2023 10:00:40 -0800 (PST)
Received: from airbuntu (host86-135-101-43.range86-135.btcentralplus.com. [86.135.101.43])
        by smtp.gmail.com with ESMTPSA id be9-20020a05600c1e8900b0040596352951sm41152643wmb.5.2023.12.17.10.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 10:00:40 -0800 (PST)
Date: Sun, 17 Dec 2023 18:00:38 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 14/23] PM: EM: Support late CPUs booting and capacity
 adjustment
Message-ID: <20231217180038.vcyaaoni3nvmlf6f@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-15-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129110853.94344-15-lukasz.luba@arm.com>

On 11/29/23 11:08, Lukasz Luba wrote:
> The patch adds needed infrastructure to handle the late CPUs boot, which
> might change the previous CPUs capacity values. With this changes the new
> CPUs which try to register EM will trigger the needed re-calculations for
> other CPUs EMs. Thanks to that the em_per_state::performance values will
> be aligned with the CPU capacity information after all CPUs finish the
> boot and EM registrations.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 121 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index b5016afe6a19..d3fa5a77de80 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -25,6 +25,9 @@ static DEFINE_MUTEX(em_pd_mutex);
>  
>  static void em_cpufreq_update_efficiencies(struct device *dev,
>  					   struct em_perf_state *table);
> +static void em_check_capacity_update(void);
> +static void em_update_workfn(struct work_struct *work);
> +static DECLARE_DELAYED_WORK(em_update_work, em_update_workfn);
>  
>  static bool _is_cpu_device(struct device *dev)
>  {
> @@ -596,6 +599,10 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>  
>  unlock:
>  	mutex_unlock(&em_pd_mutex);
> +
> +	if (_is_cpu_device(dev))
> +		em_check_capacity_update();
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(em_dev_register_perf_domain);
> @@ -631,3 +638,117 @@ void em_dev_unregister_perf_domain(struct device *dev)
>  	mutex_unlock(&em_pd_mutex);
>  }
>  EXPORT_SYMBOL_GPL(em_dev_unregister_perf_domain);
> +
> +/*
> + * Adjustment of CPU performance values after boot, when all CPUs capacites
> + * are correctly calculated.
> + */
> +static void em_adjust_new_capacity(struct device *dev,
> +				   struct em_perf_domain *pd,
> +				   u64 max_cap)
> +{
> +	struct em_perf_table __rcu *runtime_table;
> +	struct em_perf_state *table, *new_table;
> +	int ret, table_size;
> +
> +	runtime_table = em_allocate_table(pd);
> +	if (!runtime_table) {
> +		dev_warn(dev, "EM: allocation failed\n");
> +		return;
> +	}
> +
> +	new_table = runtime_table->state;
> +
> +	table = em_get_table(pd);
> +	/* Initialize data based on older runtime table */
> +	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
> +	memcpy(new_table, table, table_size);
> +
> +	em_put_table();
> +
> +	em_init_performance(dev, pd, new_table, pd->nr_perf_states);
> +	ret = em_compute_costs(dev, new_table, NULL, pd->nr_perf_states,
> +			       pd->flags);
> +	if (ret) {
> +		em_free_table(runtime_table);
> +		return;
> +	}
> +
> +	ret = em_dev_update_perf_domain(dev, runtime_table);
> +	if (ret)
> +		dev_warn(dev, "EM: update failed %d\n", ret);
> +
> +	/*
> +	 * This is one-time-update, so give up the ownership in this updater.
> +	 * The EM fwk will keep the reference and free the memory when needed.
> +	 */
> +	em_free_table(runtime_table);
> +}
> +
> +static void em_check_capacity_update(void)
> +{
> +	cpumask_var_t cpu_done_mask;
> +	struct em_perf_state *table;
> +	struct em_perf_domain *pd;
> +	unsigned long cpu_capacity;
> +	int cpu;
> +
> +	if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
> +		pr_warn("no free memory\n");
> +		return;
> +	}
> +
> +	/* Check if CPUs capacity has changed than update EM */
> +	for_each_possible_cpu(cpu) {

Can't we instead hook into cpufreq_online/offline() to check if we need to
do any em related update for this policy?


Cheers

--
Qais Yousef

> +		struct cpufreq_policy *policy;
> +		unsigned long em_max_perf;
> +		struct device *dev;
> +		int nr_states;
> +
> +		if (cpumask_test_cpu(cpu, cpu_done_mask))
> +			continue;
> +
> +		policy = cpufreq_cpu_get(cpu);
> +		if (!policy) {
> +			pr_debug("Accessing cpu%d policy failed\n", cpu);
> +			schedule_delayed_work(&em_update_work,
> +					      msecs_to_jiffies(1000));
> +			break;
> +		}
> +		cpufreq_cpu_put(policy);
> +
> +		pd = em_cpu_get(cpu);
> +		if (!pd || em_is_artificial(pd))
> +			continue;
> +
> +		cpumask_or(cpu_done_mask, cpu_done_mask,
> +			   em_span_cpus(pd));
> +
> +		nr_states = pd->nr_perf_states;
> +		cpu_capacity = arch_scale_cpu_capacity(cpu);
> +
> +		table = em_get_table(pd);
> +		em_max_perf = table[pd->nr_perf_states - 1].performance;
> +		em_put_table();
> +
> +		/*
> +		 * Check if the CPU capacity has been adjusted during boot
> +		 * and trigger the update for new performance values.
> +		 */
> +		if (em_max_perf == cpu_capacity)
> +			continue;
> +
> +		pr_debug("updating cpu%d cpu_cap=%lu old capacity=%lu\n",
> +			 cpu, cpu_capacity, em_max_perf);
> +
> +		dev = get_cpu_device(cpu);
> +		em_adjust_new_capacity(dev, pd, cpu_capacity);
> +	}
> +
> +	free_cpumask_var(cpu_done_mask);
> +}
> +
> +static void em_update_workfn(struct work_struct *work)
> +{
> +	em_check_capacity_update();
> +}
> -- 
> 2.25.1
> 

