Return-Path: <linux-kernel+bounces-123805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBD9890E51
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCBB1F24739
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705E51327E8;
	Thu, 28 Mar 2024 23:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="TI5UFin6"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E47F471
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667409; cv=none; b=RbZWT8BhDzIniPMYV8rrTqFUR0f1sYspZED8LQ7w50UzOdbtm8Th0OXtZweu4KUo1YvFawPhdBOQlihRemIOZ02YYMack83dtKZ8zOx1R5YhfAWC/sSgliQVYktiDNWy+rNY2J4e3DLx4q/r8W/it/ur2NkeHMBMuU4uis9ltZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667409; c=relaxed/simple;
	bh=TMme5ZXKNnHSKd975NADNN1dvWbPPdeLtyyKmkGZOEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH0qf6KwviSqaNOzS0XP4Ou1791i+JeN6s91e0jediASQvgX0RvZ4ypkLVriMXc6LU4N+JRKo0rlbUvMQpjZnukVyfGUQapQ7JKwb/66DlsoF4nZJX0WjutuWx8xaO6CtxS9mbAAOAiY0ss9v5L/k6Xo3cucrrL2dNliiArkC7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=TI5UFin6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4154d24cc77so1617895e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1711667406; x=1712272206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1tO7ueWHoEepGddrFg7zTdu8r8oeX1Rtt58bpd+DL1I=;
        b=TI5UFin68EuLmUobM0MoQNe8A/KD+V4pp6R/ZZiU3gaEXOZbi9cRe40/VjonTUt6km
         HfgW/N1tVnAhCuFRqNdYmFwz0Z4xjb5FxYWAkRm7DNID4MpnaKIwJ8FU3Pqvrn7q1uhe
         Qh0qBuhOX1huyyj2HSExikmn8mBi+nU52aUOPzfS0LKv5DPSTCA4YRrvvtOUmIRxSXxN
         v+5jVW2XLiVrV5jnPo3gHJhUIJeB9G8qkm7DlyZKWECBGB50j3pOGslC3cgx96S8p1dA
         m+ftdEhm6XbFo4GvMs8uHnKRQLoQ6xjCSZQoOnJNJBk6ZSrLZ/+EJhUChUdXWMa/TZlJ
         ILpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711667406; x=1712272206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tO7ueWHoEepGddrFg7zTdu8r8oeX1Rtt58bpd+DL1I=;
        b=D7XbV2N0HUBNSZNS872pgi04eFUwaUjA6jQg3yj9qIn1/tn9MylYZlyaqg1jpalfK9
         h19B+8fRVlRN+suzSR5HQmpWeFRdgyMZtA5uNWzwDb6BSsnmOZbaHTQqRnvr9zPCVMl+
         BzRIfjJM76PiweE7E4+fKLn30PJb3KQRtVeVK4USvtYq/y0DoTe1+1eW+Pa4Ak/fxe2r
         3ptMtdjPU1etQS0AOIrKS5RzvdL+Dxz9LEN11Hll1yRG9RoJCfyEg58bPdcNf4HkG129
         8kqs9KmXJEjwNDYpXj19XLbzJT0iwg+QzZ3cPS9zlRleQaLkSCouYxm8LLXsl80iTHCN
         jOKg==
X-Gm-Message-State: AOJu0Yx7Ykz3LxZxpKjPA8lTkr9TMvSey9HRcpjvB4YU9g/9e5T2HSw3
	rJzjaFgLR07rgnI7X9ET14RuulrIDdUoypWSmD9n4LmoRp9R1sWf3vXbnZv2UYQ=
X-Google-Smtp-Source: AGHT+IGtv6Z6wrekG698P4dqfoqZoaq1wgGJGqbHO+TJKNv2oXfTlt6+QPfVRk1xfGTD9OygG7ACmw==
X-Received: by 2002:a05:600c:4f90:b0:414:726:87d9 with SMTP id n16-20020a05600c4f9000b00414072687d9mr612127wmq.12.1711667405898;
        Thu, 28 Mar 2024 16:10:05 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id jg2-20020a05600ca00200b0041490d1cd06sm3575459wmb.40.2024.03.28.16.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:10:05 -0700 (PDT)
Date: Thu, 28 Mar 2024 23:10:04 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
	mingo@redhat.com, rafael@kernel.org, dietmar.eggemann@arm.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched/uclamp: Fix iowait boost UCLAMP_MAX escape
Message-ID: <20240328231004.fw7y4noyi6fbhxlc@airbuntu>
References: <20240326180054.487388-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240326180054.487388-1-christian.loehle@arm.com>

On 03/26/24 18:00, Christian Loehle wrote:
> A task, regardless of UCLAMP_MAX value, was previously allowed to
> build up the sg_cpu->iowait boost up to SCHED_CAPACITY_SCALE when
> enqueued. Since the boost was only uclamped when applied this led
> to sugov iowait boosting the rq while the task is dequeued.
> 
> The fix introduced by
> commit d37aee9018e6 ("sched/uclamp: Fix iowait boost escaping uclamp restriction")
> added the uclamp check before the boost is applied. Unfortunately
> that is insufficient, as the iowait_boost may be built up purely by
> a task with UCLAMP_MAX task, but since this task is in_iowait often,
> the clamps are no longer active during the in_iowait periods.
> So another task (let's say with low utilization) may immediately
> receive the iowait_boost value previously built up under UCLAMP_MAX
> restrictions.

This is the intended behavior. Like utilization value, it should build up
normally but at key decision points it gets clamped and the result of this
clamping operation is used to make the decision. The reason is that this
performance restriction could be left at any point of time and the system/task
should go to the original behavior when this constraint is left.

Beside the current design for iowait boost doesn't differentiate between who
added the boost. So we are in for unnecessary complexity for a mechanism that
needs to evolve anyway.

As an alternative We could say that tasks with uclamp_max shouldn't cause
iowait boost to increase, which can be a reasonable assumption for many cases.
But not a safe one in practice as it makes assumptions on who should use
uclamp_max and restrict the benefit for other use cases. And we don't want to
impose restrictions on who can benefit from it.

> 
> The issue is less prevalent than the above might suggest, since if
> the dequeuing of the UCLAMP_MAX set task will turn the cpu idle the
> previous UCLAMP_MAX value is preserved by uclamp_idle_value().
> Nonetheless anything being enqueued on the rq during the in_iowait
> phase will falsely receive the iowait_boost.
> 
> Can be observed with a basic single-threaded benchmark running with
> UCLAMP_MAX of 0, the iowait_boost is then triggered by the occasional
> kworker.

I think this a combination of two problems:

1. The max aggregation problem that have been discussed several times already.
2. It is a limitation of the current mechanism. Moving to per-task iowait boost
   we can do smarter behavior to handle this.

I think we should focus on handling these two issues. For this particular use
case, the latter is the major problem. Once the iowait boosted task is
dequeued, the CPU shouldn't need to run at faster frequency. The iowait boosted
tasks are usually short running too. So the latter improvement should mean the
CPU can move to lower frequency during its waiting time. Though we'll have to
see if the boost need to extend until the softirq has finished.

So overall I don't think we have a problem on how the hint is applied,
but we need to fix problems elsewhere to make the overall behavior better.


Thanks!

--
Qais Yousef

> 
> Fixes: 982d9cdc22c9 ("sched/cpufreq, sched/uclamp: Add clamps for FAIR and RT tasks")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 36 +++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index eece6244f9d2..bfd79762b28d 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -205,6 +205,25 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
>  	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
>  }
>  
> +/**
> + * sugov_iowait_clamp() - Clamp the boost with UCLAMP_MAX
> + * @sg_cpu: the sugov data for the CPU
> + * @boost: the requested new boost
> + *
> + * Clamps the iowait boost according to the rq's UCLAMP_MAX restriction.
> + */
> +static void sugov_iowait_clamp(struct sugov_cpu *sg_cpu, unsigned int boost)
> +{
> +#if CONFIG_UCLAMP_TASK
> +	unsigned int boost_scaled = (boost *
> +		arch_scale_cpu_capacity(sg_cpu->cpu)) >> SCHED_CAPACITY_SHIFT;
> +
> +	if (uclamp_rq_get(cpu_rq(sg_cpu->cpu), UCLAMP_MAX) < boost_scaled)
> +		return;
> +#endif
> +	sg_cpu->iowait_boost = boost;
> +	sg_cpu->iowait_boost_pending = true;
> +}
>  /**
>   * sugov_iowait_reset() - Reset the IO boost status of a CPU.
>   * @sg_cpu: the sugov data for the CPU to boost
> @@ -225,8 +244,8 @@ static bool sugov_iowait_reset(struct sugov_cpu *sg_cpu, u64 time,
>  	if (delta_ns <= TICK_NSEC)
>  		return false;
>  
> -	sg_cpu->iowait_boost = set_iowait_boost ? IOWAIT_BOOST_MIN : 0;
> -	sg_cpu->iowait_boost_pending = set_iowait_boost;
> +	if (set_iowait_boost)
> +		sugov_iowait_clamp(sg_cpu, IOWAIT_BOOST_MIN);
>  
>  	return true;
>  }
> @@ -249,6 +268,7 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>  			       unsigned int flags)
>  {
>  	bool set_iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
> +	unsigned int iowait_boost;
>  
>  	/* Reset boost if the CPU appears to have been idle enough */
>  	if (sg_cpu->iowait_boost &&
> @@ -262,17 +282,17 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>  	/* Ensure boost doubles only one time at each request */
>  	if (sg_cpu->iowait_boost_pending)
>  		return;
> -	sg_cpu->iowait_boost_pending = true;
>  
>  	/* Double the boost at each request */
>  	if (sg_cpu->iowait_boost) {
> -		sg_cpu->iowait_boost =
> -			min_t(unsigned int, sg_cpu->iowait_boost << 1, SCHED_CAPACITY_SCALE);
> -		return;
> +		iowait_boost = min_t(unsigned int, sg_cpu->iowait_boost << 1,
> +				SCHED_CAPACITY_SCALE);
> +	} else {
> +		/* First wakeup after IO: start with minimum boost */
> +		iowait_boost = IOWAIT_BOOST_MIN;
>  	}
>  
> -	/* First wakeup after IO: start with minimum boost */
> -	sg_cpu->iowait_boost = IOWAIT_BOOST_MIN;
> +	sugov_iowait_clamp(sg_cpu, iowait_boost);
>  }
>  
>  /**
> -- 
> 2.34.1
> 

