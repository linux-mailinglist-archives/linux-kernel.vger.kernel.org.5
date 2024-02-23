Return-Path: <linux-kernel+bounces-78014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0C9860DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E373EB23252
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0BE5CDC0;
	Fri, 23 Feb 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fp1X1XJO"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733522067
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680637; cv=none; b=s2dZejQEm1IQ0l6+NmKfQlbHjbLgzsZgDFECyRw3DagMHsk21VPcRx60x2tgW0/VMFFfZzgdV5KWDLbR0qC6Ssg+k5hSnZ7rtRt1UtBnx7X7AOhpi7bKGVQCVSogfzlPLJSyELZ4SFgWNT8MTmmZ0+dKUai0Om7WkS6foreocSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680637; c=relaxed/simple;
	bh=0X+kVH/61QMgqZQaa2Os4+EPghceV1wIHbj+rBO8Ukw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFza11u4yGGvX65Yh/3QBpVDDlM/VTA+8nCXJlsu2+XiPnJf5zGJvME5BexRodVdSmffNB/DF/kbIXTDOUJtLuCtl/WvxA/jN8dy9x2n1EgYm5YgjVj2i4RG7ORFjV8ip5n3VxFaq9xeS2P4/u6trfh028XxTiyGP1N0ovHhuUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fp1X1XJO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33adec41b55so453798f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708680634; x=1709285434; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Fp6W9g3vD5RwtjACPaXueQika+ummbHKpHwtAJ8mQY=;
        b=fp1X1XJOE0LzBTH1QZWLsLZJvjaTtvzUv/s5iCIlUfOwNi1iefDoVyCTJ5hc17nvKk
         CAyiHRugo0GN2s+Il39BwcjwG1bs/W2efOZ7+uWGSi6yiXwe5QPJ7wLGifzNUhyXclUw
         MaB/dn1BeN/zn0TJa/SUiV4Bjm2Un5DhD5pfh2R1SiW/oV+vJZyQeBOp9zOeBdV4re2n
         irNz8h2VG+0UhMBQlgw5x/gSG+teE/uwJZuC42ctDkTi6GTxly1t+eMgC3STa2LZYRwl
         86glwRRXiiG6mlYIw9/odqzwjuM6ZYb1uoUP3fsgKQ3pCmxB4UzGLiOlAHRqqhoxBCBz
         Om6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708680634; x=1709285434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Fp6W9g3vD5RwtjACPaXueQika+ummbHKpHwtAJ8mQY=;
        b=F9uMGke5TMIzLjqmVMh25Kpu6v1lawdew6P+lwbYLR12IqvEKcT55i3sxGnOYUm+vF
         wU/lqX4GKBup9YJHm7CbsPGsJvKtEIpl4USr4cYZyO2s6drwUg8RsY8v1X6sabXQcjIY
         S0ZQ/Z8cpj36mArOeQIujlWG9Oy2V1QKtc07pOjn6PqqN9ofZ/3Wto2dIJWBFDo2Sbpw
         0ZvYG3ewHuQpIdv+YxCF8gRDxvOBaYiFO2A+/cQ5hOgigrGVuT+t5Ef7qKM8yzlBK0NS
         xxoompWG4uHeexkffAH5ntzMqaQuGbwgIDk1/LYFOTjTBhzt4k7uW13/9PDsb16Z3X+5
         n3Lw==
X-Forwarded-Encrypted: i=1; AJvYcCX1K/6AfIceZleLzlcu+7X4tLeURpfZda2bEz01XXNA1JieznVCMURjRqClpka2CnlaYye7vLQ1uVCM00/q07CojXbu2OO42bid1bNy
X-Gm-Message-State: AOJu0YzsMpODiz7Mvy2pvaQi7jEk92gqeeAv9jNR5nsLF2DwJhbRwqRA
	1IEKJLTV+TgRYbzfHfVP4kddhffZPowx+A3VH2RzQnl0/dsAno2kL8SBJgT2tbqsidoAVGBmpGr
	9
X-Google-Smtp-Source: AGHT+IGa3XYU1Qr16pIb6Ki/O3WgooDFUgl+hE+/WEHodWOsta/O3VvJfkOmGwGqf1pRbnpjaFi7uA==
X-Received: by 2002:a05:6000:1286:b0:33d:7164:abfd with SMTP id f6-20020a056000128600b0033d7164abfdmr1016614wrx.32.1708680633953;
        Fri, 23 Feb 2024 01:30:33 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:d721:6df1:db5f:d33c])
        by smtp.gmail.com with ESMTPSA id g11-20020adff3cb000000b0033d1500b639sm2127909wrp.30.2024.02.23.01.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 01:30:33 -0800 (PST)
Date: Fri, 23 Feb 2024 10:30:31 +0100
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v6 2/4] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <Zdhlt9GZe502wpPy@vingu-book>
References: <20240220225622.2626569-1-qyousef@layalina.io>
 <20240220225622.2626569-3-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220225622.2626569-3-qyousef@layalina.io>

Le mardi 20 févr. 2024 à 22:56:20 (+0000), Qais Yousef a écrit :
> If a misfit task is affined to a subset of the possible cpus, we need to
> verify that one of these cpus can fit it. Otherwise the load balancer
> code will continuously trigger needlessly leading the balance_interval
> to increase in return and eventually end up with a situation where real
> imbalances take a long time to address because of this impossible
> imbalance situation.
> 
> This can happen in Android world where it's common for background tasks
> to be restricted to little cores.
> 
> Similarly if we can't fit the biggest core, triggering misfit is
> pointless as it is the best we can ever get on this system.
> 
> To be able to detect that; we use asym_cap_list to iterate through
> capacities in the system to see if the task is able to run at a higher
> capacity level based on its p->cpus_ptr. We do that when the affinity
> change, a fair task is forked, or when a task switched to fair policy.
> We store the max_allowed_capacity in task_struct to allow for cheap
> comparison in the fast path.
> 
> Improve check_misfit_status() function by removing redundant checks.
> misfit_task_load will be 0 if the task can't move to a bigger CPU. And
> nohz_load_balance() already checks for cpu_check_capacity() before
> calling check_misfit_status().
> 
> Test:
> =====
> 
> Add
> 
> 	trace_printk("balance_interval = %lu\n", interval)
> 
> in get_sd_balance_interval().
> 
> run
> 	if [ "$MASK" != "0" ]; then
> 		adb shell "taskset -a $MASK cat /dev/zero > /dev/null"
> 	fi
> 	sleep 10
> 	// parse ftrace buffer counting the occurrence of each valaue
> 
> Where MASK is either:
> 
> 	* 0: no busy task running
> 	* 1: busy task is pinned to 1 cpu; handled today to not cause
> 	  misfit
> 	* f: busy task pinned to little cores, simulates busy background
> 	  task, demonstrates the problem to be fixed
> 
> Results:
> ========
> 
> Note how occurrence of balance_interval = 128 overshoots for MASK = f.
> 
> BEFORE
> ------
> 
> 	MASK=0
> 
> 		   1 balance_interval = 175
> 		 120 balance_interval = 128
> 		 846 balance_interval = 64
> 		  55 balance_interval = 63
> 		 215 balance_interval = 32
> 		   2 balance_interval = 31
> 		   2 balance_interval = 16
> 		   4 balance_interval = 8
> 		1870 balance_interval = 4
> 		  65 balance_interval = 2
> 
> 	MASK=1
> 
> 		  27 balance_interval = 175
> 		  37 balance_interval = 127
> 		 840 balance_interval = 64
> 		 167 balance_interval = 63
> 		 449 balance_interval = 32
> 		  84 balance_interval = 31
> 		 304 balance_interval = 16
> 		1156 balance_interval = 8
> 		2781 balance_interval = 4
> 		 428 balance_interval = 2
> 
> 	MASK=f
> 
> 		   1 balance_interval = 175
> 		1328 balance_interval = 128
> 		  44 balance_interval = 64
> 		 101 balance_interval = 63
> 		  25 balance_interval = 32
> 		   5 balance_interval = 31
> 		  23 balance_interval = 16
> 		  23 balance_interval = 8
> 		4306 balance_interval = 4
> 		 177 balance_interval = 2
> 
> AFTER
> -----
> 
> Note how the high values almost disappear for all MASK values. The
> system has background tasks that could trigger the problem without
> simulate it even with MASK=0.
> 
> 	MASK=0
> 
> 		 103 balance_interval = 63
> 		  19 balance_interval = 31
> 		 194 balance_interval = 8
> 		4827 balance_interval = 4
> 		 179 balance_interval = 2
> 
> 	MASK=1
> 
> 		 131 balance_interval = 63
> 		   1 balance_interval = 31
> 		  87 balance_interval = 8
> 		3600 balance_interval = 4
> 		   7 balance_interval = 2
> 
> 	MASK=f
> 
> 		   8 balance_interval = 127
> 		 182 balance_interval = 63
> 		   3 balance_interval = 31
> 		   9 balance_interval = 16
> 		 415 balance_interval = 8
> 		3415 balance_interval = 4
> 		  21 balance_interval = 2
> 
> Signed-off-by: Qais Yousef <qyousef@layalina.io>

I have a comment below but anyway

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  include/linux/sched.h |  1 +
>  init/init_task.c      |  1 +
>  kernel/sched/fair.c   | 77 +++++++++++++++++++++++++++++++++----------
>  3 files changed, 61 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index ffe8f618ab86..774cddbeab09 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -835,6 +835,7 @@ struct task_struct {
>  #endif
>  
>  	unsigned int			policy;
> +	unsigned long			max_allowed_capacity;
>  	int				nr_cpus_allowed;
>  	const cpumask_t			*cpus_ptr;
>  	cpumask_t			*user_cpus_ptr;
> diff --git a/init/init_task.c b/init/init_task.c
> index 7ecb458eb3da..b3dbab4c959e 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -77,6 +77,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
>  	.cpus_ptr	= &init_task.cpus_mask,
>  	.user_cpus_ptr	= NULL,
>  	.cpus_mask	= CPU_MASK_ALL,
> +	.max_allowed_capacity	= SCHED_CAPACITY_SCALE,
>  	.nr_cpus_allowed= NR_CPUS,
>  	.mm		= NULL,
>  	.active_mm	= &init_mm,
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8e30e2bb77a0..20006fcf7df2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5092,24 +5092,35 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
>  
>  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>  {
> +	unsigned long cpu_cap;
> +	int cpu = cpu_of(rq);
> +
>  	if (!sched_asym_cpucap_active())
>  		return;
>  
> -	if (!p || p->nr_cpus_allowed == 1) {
> -		rq->misfit_task_load = 0;
> -		return;
> -	}
> +	if (!p || p->nr_cpus_allowed == 1)
> +		goto out;
>  
> -	if (task_fits_cpu(p, cpu_of(rq))) {
> -		rq->misfit_task_load = 0;
> -		return;
> -	}
> +	cpu_cap = arch_scale_cpu_capacity(cpu);
> +
> +	/*
> +	 * Affinity allows us to go somewhere higher?  Or are we on biggest
> +	 * available CPU already?
> +	 */
> +	if (cpu_cap == p->max_allowed_capacity)
> +		goto out;
> +
> +	if (task_fits_cpu(p, cpu))
> +		goto out;

I think the below is easier to read:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 209f5da17d79..0929e6704b44 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5095,35 +5095,25 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)

 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 {
-       unsigned long cpu_cap;
        int cpu = cpu_of(rq);

        if (!sched_asym_cpucap_active())
                return;

-       if (!p || p->nr_cpus_allowed == 1)
-               goto out;
-
-       cpu_cap = arch_scale_cpu_capacity(cpu);
-
        /*
         * Affinity allows us to go somewhere higher?  Or are we on biggest
-        * available CPU already?
+        * available CPU already? Or do we fit into this CPU ?
         */
-       if (cpu_cap == p->max_allowed_capacity)
-               goto out;
-
-       if (task_fits_cpu(p, cpu))
-               goto out;
-
-       /*
-        * Make sure that misfit_task_load will not be null even if
-        * task_h_load() returns 0.
-        */
-       rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
-       return;
-out:
-       rq->misfit_task_load = 0;
+       if (!p || (p->nr_cpus_allowed == 1) ||
+          (arch_scale_cpu_capacity(cpu) == p->max_allowed_capacity) ||
+          task_fits_cpu(p, cpu))
+               rq->misfit_task_load = 0;
+       else
+               /*
+                * Make sure that misfit_task_load will not be null even if
+                * task_h_load() returns 0.
+                */
+               rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
 }

 #else /* CONFIG_SMP */




>  
>  	/*
>  	 * Make sure that misfit_task_load will not be null even if
>  	 * task_h_load() returns 0.
>  	 */
>  	rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
> +	return;
> +out:
> +	rq->misfit_task_load = 0;
>  }
>  
>  #else /* CONFIG_SMP */
> @@ -8241,6 +8252,36 @@ static void task_dead_fair(struct task_struct *p)
>  	remove_entity_load_avg(&p->se);
>  }
>  
> +/*
> + * Check the max capacity the task is allowed to run at for misfit detection.
> + */
> +static void set_task_max_allowed_capacity(struct task_struct *p)
> +{
> +	struct asym_cap_data *entry;
> +
> +	if (!sched_asym_cpucap_active())
> +		return;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(entry, &asym_cap_list, link) {
> +		cpumask_t *cpumask;
> +
> +		cpumask = cpu_capacity_span(entry);
> +		if (!cpumask_intersects(p->cpus_ptr, cpumask))
> +			continue;
> +
> +		p->max_allowed_capacity = entry->capacity;
> +		break;
> +	}
> +	rcu_read_unlock();
> +}
> +
> +static void set_cpus_allowed_fair(struct task_struct *p, struct affinity_context *ctx)
> +{
> +	set_cpus_allowed_common(p, ctx);
> +	set_task_max_allowed_capacity(p);
> +}
> +
>  static int
>  balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
> @@ -8249,6 +8290,8 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  
>  	return newidle_balance(rq, rf) != 0;
>  }
> +#else
> +static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
>  #endif /* CONFIG_SMP */
>  
>  static void set_next_buddy(struct sched_entity *se)
> @@ -9601,16 +9644,10 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
>  				(arch_scale_cpu_capacity(cpu_of(rq)) * 100));
>  }
>  
> -/*
> - * Check whether a rq has a misfit task and if it looks like we can actually
> - * help that task: we can migrate the task to a CPU of higher capacity, or
> - * the task's current CPU is heavily pressured.
> - */
> -static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
> +/* Check if the rq has a misfit task */
> +static inline bool check_misfit_status(struct rq *rq, struct sched_domain *sd)
>  {
> -	return rq->misfit_task_load &&
> -		(arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
> -		 check_cpu_capacity(rq, sd));
> +	return rq->misfit_task_load;
>  }
>  
>  /*
> @@ -12645,6 +12682,8 @@ static void task_fork_fair(struct task_struct *p)
>  	rq_lock(rq, &rf);
>  	update_rq_clock(rq);
>  
> +	set_task_max_allowed_capacity(p);
> +
>  	cfs_rq = task_cfs_rq(current);
>  	curr = cfs_rq->curr;
>  	if (curr)
> @@ -12768,6 +12807,8 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
>  {
>  	attach_task_cfs_rq(p);
>  
> +	set_task_max_allowed_capacity(p);
> +
>  	if (task_on_rq_queued(p)) {
>  		/*
>  		 * We were most likely switched from sched_rt, so
> @@ -13139,7 +13180,7 @@ DEFINE_SCHED_CLASS(fair) = {
>  	.rq_offline		= rq_offline_fair,
>  
>  	.task_dead		= task_dead_fair,
> -	.set_cpus_allowed	= set_cpus_allowed_common,
> +	.set_cpus_allowed	= set_cpus_allowed_fair,
>  #endif
>  
>  	.task_tick		= task_tick_fair,
> -- 
> 2.34.1
> 

