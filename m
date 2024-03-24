Return-Path: <linux-kernel+bounces-112538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8256B887B4E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C36B214B1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 01:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AEB10F7;
	Sun, 24 Mar 2024 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="kaxNwg+M"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BA064A
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711242986; cv=none; b=tIgKQzRY+1Ih4VBqVgVxho2a3/IdyLZ8eNB7v6uMq6m6uHy+58bNnAyYn1hRzFQPfjzlmh8oJwV/KS88Bb5cElOXrIk5P/cR9LCWnt/BZ/tahWqzwhV1kc+eKRKbXKvkvsLnI6nnBROC8sRq2o6wDlyw63W++V2XbjXi4C4yT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711242986; c=relaxed/simple;
	bh=b1LIcs3eiQw7N+NGlUYBvHfjzd3LDeBvz5zCkXmit3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dx51Y8zUqa3U5tlN5ZZuTazJRAtjY1pGWcBA3vhooMSxRCWKnP/jMBcSZZYUR16K5+iFIOOSnFbSTidAhknokGJPRo8nrk2BrRBBgwe+VmlpkUgMJAX8EDIZPHZYumk+1bHgdy55QFX9chdR9/kHx6LEPxGdbG8a9FRFEwTS4n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=kaxNwg+M; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41400a9844aso24710825e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 18:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1711242983; x=1711847783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj3nbqsaWy4/WykWj9OgUFJmXIp54cueJHiM6uesgks=;
        b=kaxNwg+MRlC4met1zCvsRTV2H4tEZov/XyqwnGUVyRvNWhTDhu/WuC1EkLWHdLky0d
         yAxsmJm2+o03j7eiM+Y5LFcQCi/EcGWKFHAgDvb2BthfSm+C3xYoB9uoYJuuQABYopvk
         uVGW+QxDkMk0xOMmV4F3KTkQkVT5Ozh8i7E1H7ET8GGwQWzERRiVZsv3dq4vekT/fv76
         ufhesSq0cHf3WoXDlXUh1GTY+l3j9EhzzxzLhXp/n6ryeeDSI69lUzxyIJpNc/iip/bC
         2MjAKJmgBTeK92BcgFd5IvNrwEf22hIGlnzZ15lGjJfFkNz/88qWN9ibOWbcHP1nNqoG
         Pl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711242983; x=1711847783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj3nbqsaWy4/WykWj9OgUFJmXIp54cueJHiM6uesgks=;
        b=DIRagkFpyaFiBAVC5IniaLkr4pLg/30GGYOrT0njHletLFIV/v0oXvZD05OgqBZ/6r
         EI5uSZ5ABqchAhJou7PEbjsXhiaaQCiZBPv3S9uJC3MtLopfFGYupHi9DpwUVM70IETC
         e2l61zaAlWgEthUNtNL6B70hFfRqbyZafjhbmuFe0C64p0gz6VIt6Fum36jOx5KwS61p
         ODDP+/pHuwKzCUrifDJYFPuePCqHp+NzzkHcdJunpieO+84TKoSy6sE9ZreAOArEO2UJ
         o+D76nyEcLdh0a7G3l6b+Bz64vJO1RGPlAWp9z5hGqvQxui4PRNfzbirJT6QGr20tZsQ
         tllQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPr3/nP22F9lzJdz2Mxbhoz4gxQtElbVGQZEBhp8C2onhH896TIrO7hLaDinMWgr6uP6ta5bbPki/70Uxt7f/yWm1JgbRRjNGuaEgE
X-Gm-Message-State: AOJu0YxrWtA3cBMY4CHD7N21P+XddLyev8o7P+mGGacBuOHzRz0RWTMP
	VwkMnDCenKb2eRc4ndBhZIBB+iYxjutihgkUwuQ0NghHL0NbImWFuUU9e7JuHu4=
X-Google-Smtp-Source: AGHT+IHflvLhmel8QwO8scfz+plP+5vxLslqjuEFmb8+UDJJ+6nPk0a9pQQQAU9hiijCFr0cli5P0w==
X-Received: by 2002:a05:6000:381:b0:341:a63c:58bc with SMTP id u1-20020a056000038100b00341a63c58bcmr2515999wrf.2.1711242982577;
        Sat, 23 Mar 2024 18:16:22 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id bl40-20020adfe268000000b0033e03d37685sm5555058wrb.55.2024.03.23.18.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 18:16:22 -0700 (PDT)
Date: Sun, 24 Mar 2024 01:16:20 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
	vschneid@redhat.com, qperret@google.com
Subject: Re: [PATCH v2 2/2] sched/fair: Use helper functions to access
 rd->overload
Message-ID: <20240324011620.f3mmywh44htvlb5m@airbuntu>
References: <20240322141632.28654-1-sshegde@linux.ibm.com>
 <20240322141632.28654-3-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240322141632.28654-3-sshegde@linux.ibm.com>

On 03/22/24 19:46, Shrikanth Hegde wrote:
> rd->overload is accessed at multiple places. Instead it could use helper
> get/set functions. This would make the code more readable and easy to
> maintain.
> 
> No change in functionality intended.
> 
> Suggested-by: Qais Yousef <qyousef@layalina.io>

Thanks for following up!

> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c  |  7 ++++---
>  kernel/sched/sched.h | 14 ++++++++++++--
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index eeebadd7d9ae..cee99c93e6a4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10621,8 +10621,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> 
>  	if (!env->sd->parent) {
>  		/* update overload indicator if we are at root domain */
> -		if (READ_ONCE(env->dst_rq->rd->overload) != (sg_status & SG_OVERLOAD))
> -			WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
> +		if (is_rd_overloaded(env->dst_rq->rd) != (sg_status & SG_OVERLOAD))
> +			set_rd_overload_status(env->dst_rq->rd,
> +					       sg_status & SG_OVERLOAD);

A bit picky, but..

Wouldn't it be better to encapsulate the check of whether we're writing a new
value inside set_rd_overload_status()? Only write if it the value changed and
all future users wouldn't care then.

I think no need to wrap the line too.

> 
>  		/* Update over-utilization (tipping point, U >= 0) indicator */
>  		set_rd_overutilized_status(env->dst_rq->rd,
> @@ -12344,7 +12345,7 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
>  	rcu_read_lock();
>  	sd = rcu_dereference_check_sched_domain(this_rq->sd);
> 
> -	if (!READ_ONCE(this_rq->rd->overload) ||
> +	if (!is_rd_overloaded(this_rq->rd) ||
>  	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> 
>  		if (sd)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 41024c1c49b4..c91eb8811bef 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -918,6 +918,16 @@ extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
>  extern void sched_get_rd(struct root_domain *rd);
>  extern void sched_put_rd(struct root_domain *rd);
> 
> +static inline int is_rd_overloaded(struct root_domain *rd)
> +{
> +	return READ_ONCE(rd->overload);
> +}
> +
> +static inline void set_rd_overload_status(struct root_domain *rd, int status)
> +{
> +	WRITE_ONCE(rd->overload, status);
> +}
> +
>  #ifdef HAVE_RT_PUSH_IPI
>  extern void rto_push_irq_work_func(struct irq_work *work);
>  #endif
> @@ -2518,8 +2528,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
> 
>  #ifdef CONFIG_SMP
>  	if (prev_nr < 2 && rq->nr_running >= 2) {
> -		if (!READ_ONCE(rq->rd->overload))
> -			WRITE_ONCE(rq->rd->overload, 1);
> +		if (!is_rd_overloaded(rq->rd))
> +			set_rd_overload_status(rq->rd, 1);

While at it, could you write SG_OVERLOAD instead of 1?

Both patches LGTM otherwise

Reviewed-by: Qais Yousef <qyousef@layalina.io>


Thanks!

--
Qais Yousef

>  	}
>  #endif
> 
> --
> 2.39.3
> 

