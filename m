Return-Path: <linux-kernel+bounces-89860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84C786F69C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0830D1C20ED1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B263276417;
	Sun,  3 Mar 2024 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="va8pU1cK"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178035FEE3
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709492087; cv=none; b=l4DntwWLLjIoH6I9DZI2/IqleNTcYa/mHk1gH5hCbkE8PuWGUDFqAfJjwXZywrdB5/AavZm+/bfaTpKRdSpn03nPeFb2euSN2ld2mLTqmypirb8FXh7Hsai3k1KroYkyzk5gFOsYB33Ncwg9NrUdrQ0omzfbcQlMpkCUCquXUy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709492087; c=relaxed/simple;
	bh=iwq+sGovXovBXD38LyxkWIOjH510WLGP2Qoco8AQv0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmVYJqF3a6v6Vtnfyv2FFQL2+GG0uXjit0qfrCtUSWbrHbWwvOCYsxgkSHXxe1gfq2QpjWLyzxfzhxHTZgVOHvndwCrIe8BC16X4/QpvV2w1YOlaH+8poSslmP8AfgGSFXMTU74nijTnHurTd8sttwEDIB2ajgR4ZsHzGHnUJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=va8pU1cK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d28468666so2484133f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 10:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1709492083; x=1710096883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pxJlWnXbvEoKyXuye3QkRbIfgBWxXZHW+bMIprOkjrY=;
        b=va8pU1cKXUc91wVnHHjYeG+kDwGQpJV3gCTK3+HirKP11pLFkdmWcdGY7D/J5mSKac
         QuQRuO3oWGiSr6ITEsqH6WCVjGPhBjtwcG3/9wknNkvLnDWtyX4D3ESH2GbDDSLFutul
         DNYGSMwoezZrTzM/Gg1+DVanCH/GP8i9z8MYQgEyto88JiPpMOFThG+vtAONUeb3zxaU
         VLrUoz2cOfsYHKMJaumW60t6XkGPW+OaXVRgL+HyJdYQ/SYmfevOC4DKUptUpmkjg7N9
         0AiJyruRvxpG0FKrqUh542xZsFLUb5yzEucw9+DO3FJ03AEHSDJxk7kp70UoA5zbkH6c
         V/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709492083; x=1710096883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxJlWnXbvEoKyXuye3QkRbIfgBWxXZHW+bMIprOkjrY=;
        b=AeOyE9epttoyOqIrz5X3vP9YyC4N4jrRP2F1kuVtT0D20ej0hNW6mJto23fD3m0Tvf
         17RzxGEW8YYd5BrZk22nSFKxuUejzvruIhoQd7OdyD+09IQ4rSDNZL0bZsey84ParIvO
         nw44/zXRiruK80kT+3bc43j/6BgTHryg4RX00YPvCXsoi77TtIiWcgrJSLHCCt8ZkFIC
         4TN286z2coW/UzcFMp0Lvmw9uD1r6K3s1EL70W/kUEf/JZ1OQrI2mL9GoGhRzjximKXa
         Z7jMEB7d7Pxs5mzGFj+EYap8h3gQYfu7Ouxp7rIMDEw7jqBhO22rBTi2Gzpukamqfp6R
         zxbg==
X-Forwarded-Encrypted: i=1; AJvYcCWMYBJNBnwS+l79rSPU7Gpe54Dip0KXWNf/Kjd5IB0d8FSmv2P2o/5gCBjYFMl/X+V4bmEVF0YIg5ZoJUW7z7acw0SU8zbluedgMZRP
X-Gm-Message-State: AOJu0Yzbdr29nypxzFJx25zcjgyIgFMYIA4dkedJ/Qt88W+uzofWzOiH
	jLaSYelmlc6xdaAjKRePDPXl0aqj67C1CDKk0hVo68Wu39IB1RBOcyrhdKc43LQ=
X-Google-Smtp-Source: AGHT+IEu7OpwO3vckO/49wnkxr2YfTUnYTBGWCdjP71DqCS253cvgVy9PMaQeUZjtUvZyW6xUar5CA==
X-Received: by 2002:adf:cf0e:0:b0:33e:21e:26aa with SMTP id o14-20020adfcf0e000000b0033e021e26aamr5372090wrj.7.1709492083128;
        Sun, 03 Mar 2024 10:54:43 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id i6-20020adfb646000000b0033e033898c5sm10221725wre.20.2024.03.03.10.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 10:54:42 -0800 (PST)
Date: Sun, 3 Mar 2024 18:54:41 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
	yu.c.chen@intel.com, dietmar.eggemann@arm.com,
	linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
	aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com,
	pierre.gondois@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v4 2/2] sched/fair: Use helper function to access
 rd->overutilized
Message-ID: <20240303185441.km7c4u7yui3b5nl2@airbuntu>
References: <20240301151725.874604-1-sshegde@linux.ibm.com>
 <20240301151725.874604-3-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301151725.874604-3-sshegde@linux.ibm.com>

On 03/01/24 20:47, Shrikanth Hegde wrote:
> Overutilized field is accessed directly in multiple places.
> So it could use a helper function. That way one might be more
> informed that it needs to be used only in case of EAS.
> 
> No change in functionality intended.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Can we do the same for rd->overload too? A set_rd_overload_status() would be
a nice addition too. Anyway.

Reviewed-by: Qais Yousef <qyousef@layalina.io>


Thanks!

--
Qais Yousef

> ---
>  kernel/sched/fair.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a71f8a1506e4..650909a648d0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6670,6 +6670,15 @@ static inline bool cpu_overutilized(int cpu)
>  	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
>  }
> 
> +/*
> + * Ensure that caller can do EAS. overutilized value
> + * make sense only if EAS is enabled
> + */
> +static inline int is_rd_overutilized(struct root_domain *rd)
> +{
> +	return READ_ONCE(rd->overutilized);
> +}
> +
>  static inline void set_rd_overutilized_status(struct root_domain *rd,
>  					      unsigned int status)
>  {
> @@ -6686,13 +6695,14 @@ static inline void check_update_overutilized_status(struct rq *rq)
>  	if (!sched_energy_enabled())
>  		return;
> 
> -	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
> +	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
>  		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>  }
>  #else
>  static inline void check_update_overutilized_status(struct rq *rq) { }
>  static inline void set_rd_overutilized_status(struct root_domain *rd,
>  					      unsigned int status) { }
> +static inline int is_rd_overutilized(struct root_domain *rd) { }
>  #endif
> 
>  /* Runqueue only has SCHED_IDLE tasks enqueued */
> @@ -7974,7 +7984,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> 
>  	rcu_read_lock();
>  	pd = rcu_dereference(rd->pd);
> -	if (!pd || READ_ONCE(rd->overutilized))
> +	if (!pd || is_rd_overutilized(rd))
>  		goto unlock;
> 
>  	/*
> @@ -10859,7 +10869,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  	if (sched_energy_enabled()) {
>  		struct root_domain *rd = env->dst_rq->rd;
> 
> -		if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> +		if (rcu_dereference(rd->pd) && !is_rd_overutilized(rd))
>  			goto out_balanced;
>  	}
> 
> --
> 2.39.3
> 

