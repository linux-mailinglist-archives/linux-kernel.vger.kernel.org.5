Return-Path: <linux-kernel+bounces-89858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB3A86F698
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 735DCB2123F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EADD76402;
	Sun,  3 Mar 2024 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="zeq9LFaY"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE311E527
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709491865; cv=none; b=oPDI+ZDU7BURAMx8QsiKcXYMnYnuJsTxwRiCQ2RR/UZOTifeAvvRWFK3ZWEb6AMlGpLTuFtgYF5lIyURc4MKEFhBfDQdGnRxYoQ4JOhfpU5O0CLLAy85z7k7OV3vTPr2G1nNKpQKdcVubTEgM4utvQu1aplp6T8uv++SfDt41vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709491865; c=relaxed/simple;
	bh=pPIhuIEeeq6aoywacXPcqyBusXMhcCAkgcOO881oztk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnkbdL1TD8nhQ0PKZptvE8ptblb5eK92BxfrqpzKnioi9CTxDptSGNH9lywLNwXOflGXHMSdFATCxF0iy/nBEyz+5B4CuLje0rbgI8CmxIB09cV4dc5exiJqvlN1wOSNbufWTOqG31txJFnudDH60dAK5Qfp2Oeos4dxbiV3cNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=zeq9LFaY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412de18edcaso4043895e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 10:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1709491861; x=1710096661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Re+YLOUi8CgBqM4vJu+S4L9dIyzZA+N06u7JCIzyfz8=;
        b=zeq9LFaYt3d3jsXUfb4/ed8tmYoRd4KxPxD9eLJ5lZwUhwMFwaDmz5zHZT/7NkyUEE
         68olMsnBu8RoMScDF/AQIG0mu76HXy9Nc++2YTB6F/cUdcaWhb3+QtRM2ZyOVwZ/MILN
         BT0h7zWVeDyKRHmMFIQ/821Mz22JewFf6oxNnRJqiJ9N9S5LV/I0FAUPsbM9GxjTZlUB
         GZD3vqaUkFKLxpDHWrnbCCfeAa0e92UenWIyM1AOgTT8VnQN8m5ZPcXbgHbCwm97CLuf
         wNd1RvBcKalDS0vrxai7qXiTufVGrEQmh/RQxTRNDonzIJp08Pp7qp5wmY46nxcBvq57
         XNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709491861; x=1710096661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re+YLOUi8CgBqM4vJu+S4L9dIyzZA+N06u7JCIzyfz8=;
        b=JU1oFYP9qubGAXsmkSfasDBP2vnGgko0c32iJlEXIuHs9pDCRa/+iLX9r/w+sUngw6
         cJ2MDijWdy9ctg58u2rRa7twFw3Tq2uD96YjT0ynKV9zSHW7TNN2XF/ZC0c61ozUMdkP
         koZybHiMEEvqYkFlOlCQcWTaNqhWino49U72j6E998MsRz4Ld5ElpE/kinOf/yywmu91
         3m0YoqE5Y90hwUjQEfi38xpUO/YmcENnM9h4KKzYiq/fjx03/fAG0pXO6SViVPWas+BZ
         ZjcmYwkchJlST0Boh9rc40qdktJeNXdhca70djgz+yT4eLx+mGjVkznbuszmYT8TmgTZ
         fDWw==
X-Forwarded-Encrypted: i=1; AJvYcCWLJh1jYSxTy/18osN1seyUTZc6cwOUa4qp4VjxmY8dNXBWGBS48WE7sJIljwjPvCc7Pt3V5MRC6qkAhk8CFWLWo5rlkvMOs46UFRAq
X-Gm-Message-State: AOJu0YyACxMGF0vwujqzZ0qtQnT0xPCvAXQJ3FQzfjYajmx4OVMYF5Kf
	RiwtM48SfsINKftH9dJzeG1n4wJeoQVySiJWOg50JTk4t1xOUmTyJPmjfbCMSqE=
X-Google-Smtp-Source: AGHT+IGYPQEoTRP4wkd0kPwkz9PscgUFvRLfv/kzTbawwko9GeYOmiqoQsolhE5HaIwjHqSmF+baYQ==
X-Received: by 2002:a05:600c:5489:b0:412:d45e:839 with SMTP id iv9-20020a05600c548900b00412d45e0839mr3562523wmb.18.1709491861498;
        Sun, 03 Mar 2024 10:51:01 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id co17-20020a0560000a1100b0033e3ca55a4esm900226wrb.21.2024.03.03.10.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 10:51:01 -0800 (PST)
Date: Sun, 3 Mar 2024 18:50:59 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
	yu.c.chen@intel.com, dietmar.eggemann@arm.com,
	linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
	aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com,
	pierre.gondois@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v4 1/2] sched/fair: Add EAS checks before updating
 overutilized
Message-ID: <20240303185059.wvjkrrn7liwl4wtv@airbuntu>
References: <20240301151725.874604-1-sshegde@linux.ibm.com>
 <20240301151725.874604-2-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301151725.874604-2-sshegde@linux.ibm.com>

On 03/01/24 20:47, Shrikanth Hegde wrote:
> Overutilized field of root domain is only used for EAS(energy aware scheduler)
> to decide whether to do load balance or not. It is not used if EAS
> not possible.
> 
> Currently enqueue_task_fair and task_tick_fair accesses, sometime updates
> this field. In update_sd_lb_stats it is updated often. This causes cache
> contention due to true sharing and burns a lot of cycles. overload and
> overutilized are part of the same cacheline. Updating it often invalidates
> the cacheline. That causes access  to overload to slow down due to
> false sharing. Hence add EAS check before accessing/updating this field.
> EAS check is optimized at compile time or it is a static branch.
> Hence it shouldn't cost much.
> 
> With the patch, both enqueue_task_fair and newidle_balance don't show
> up as hot routines in perf profile.
> 
> 6.8-rc4:
> 7.18%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
> 6.78%  s                [kernel.vmlinux]              [k] newidle_balance
> +patch:
> 0.14%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
> 0.00%  swapper          [kernel.vmlinux]              [k] newidle_balance
> 
> Minor change: trace_sched_overutilized_tp expect that second argument to
> be bool. So do a int to bool conversion for that.
> 
> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
> Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 49 +++++++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6a16129f9a5c..a71f8a1506e4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6670,15 +6670,29 @@ static inline bool cpu_overutilized(int cpu)
>  	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
>  }
> 
> -static inline void update_overutilized_status(struct rq *rq)
> +static inline void set_rd_overutilized_status(struct root_domain *rd,
> +					      unsigned int status)
>  {
> -	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
> -		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> -		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
> -	}

Can we add

	if (!sched_energy_enabled())
		return;

here and avoid sprinkling the condition in other various places instead?

> +	WRITE_ONCE(rd->overutilized, status);
> +	trace_sched_overutilized_tp(rd, !!status);
> +}
> +
> +static inline void check_update_overutilized_status(struct rq *rq)
> +{
> +	/*
> +	 * overutilized field is used for load balancing decisions only
> +	 * if energy aware scheduler is being used
> +	 */

nit: I think this comment is unnecessary but I don't mind keeping it

> +	if (!sched_energy_enabled())
> +		return;
> +
> +	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
> +		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>  }
>  #else
> -static inline void update_overutilized_status(struct rq *rq) { }
> +static inline void check_update_overutilized_status(struct rq *rq) { }
> +static inline void set_rd_overutilized_status(struct root_domain *rd,
> +					      unsigned int status) { }
>  #endif
> 
>  /* Runqueue only has SCHED_IDLE tasks enqueued */
> @@ -6779,7 +6793,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	 * and the following generally works well enough in practice.
>  	 */
>  	if (!task_new)
> -		update_overutilized_status(rq);
> +		check_update_overutilized_status(rq);
> 
>  enqueue_throttle:
>  	assert_list_leaf_cfs_rq(rq);
> @@ -9902,7 +9916,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		if (nr_running > 1)
>  			*sg_status |= SG_OVERLOAD;
> 
> -		if (cpu_overutilized(i))
> +		if (sched_energy_enabled() && cpu_overutilized(i))

I think we can drop sched_energy_enable() here if we add it to
set_rd_overutilized_status()

>  			*sg_status |= SG_OVERUTILIZED;
> 
>  #ifdef CONFIG_NUMA_BALANCING
> @@ -10596,19 +10610,16 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
> 
>  	if (!env->sd->parent) {
> -		struct root_domain *rd = env->dst_rq->rd;
> -
>  		/* update overload indicator if we are at root domain */
> -		WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
> +		WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
> 
>  		/* Update over-utilization (tipping point, U >= 0) indicator */
> -		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
> -		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
> -	} else if (sg_status & SG_OVERUTILIZED) {
> -		struct root_domain *rd = env->dst_rq->rd;
> -
> -		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> -		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
> +		if (sched_energy_enabled()) {

ditto

> +			set_rd_overutilized_status(env->dst_rq->rd,
> +						   sg_status & SG_OVERUTILIZED);
> +		}
> +	} else if (sched_energy_enabled() && (sg_status & SG_OVERUTILIZED)) {

ditto

> +		set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
>  	}
> 
>  	update_idle_cpu_scan(env, sum_util);
> @@ -12609,7 +12620,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  		task_tick_numa(rq, curr);
> 
>  	update_misfit_status(curr, rq);
> -	update_overutilized_status(task_rq(curr));
> +	check_update_overutilized_status(task_rq(curr));
> 
>  	task_tick_core(rq, curr);
>  }
> --
> 2.39.3
> 

