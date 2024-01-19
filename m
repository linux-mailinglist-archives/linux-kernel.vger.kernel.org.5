Return-Path: <linux-kernel+bounces-31325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0C6832C82
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEDD7284D35
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D8654F99;
	Fri, 19 Jan 2024 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXIke1hf"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D154F87
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679354; cv=none; b=uQ0I3KDZUDmc/D4TRvp4t3s6VlTSW2ARaHnG0au0gPxr8YDqIbsWxHpdq+rKvETQOXSQlqWaTLEVgm2RBqPfVcBMb7OrD5L9Dqfhb0OyCUNKNo2wYJ+xuf4r8enEX5dmBxlPJANCkZ4U/hdkhcHo2LE9J0GYqgHtW885n1UtBWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679354; c=relaxed/simple;
	bh=ukd8lgAS8mkUlXaFfGGD+2VLPywWab4A2H1fZgyGbr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxOopoLc+tcq75bDEBWP3GJmPotu5BQf+i1QjDr9+PEjZph249wkL+Xio/2b+xITxy4RYYPljfG7U380SyC65YiXH44oNq9jFI20R/PJTR7zEjzbP1cSZkqRx9jF6/b+RlYfIbqL3sE3kmHoxz5JAmT1HItmvMHosQlrsGy2eg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NXIke1hf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso9777405e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705679350; x=1706284150; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DJCOJrM5uAeYWzffiza/Y1SSVgClIZfy3CNOrCYjLv4=;
        b=NXIke1hfSIfxgXhdHjw6wV5Zzt7XrePjPSP8g1oGG3K+IaNA6xxQaC4GtkX5DHsSCx
         VGpmRD0sLuGI0cTwZPwgJFHlHx8/SPjqXbDFY7YUqcGS9PvUYT1zVCaKU1kB4doleQeg
         IXapLP3FXQIoa0Z/bNpj8oe3W8NFQXjd390f64lU8SkyBsnSSAkrNGt4XNex+JiDHsMa
         cvpN4330KZ79iZkTTCMpSrZIS1IcLwFNiiXG+jfGa+gySJuS5PnvMgllpSma2RBqj7eQ
         yhOelOKU6C/+Jp768rBjSkIznksk/M4Ce4r3MTIsigB6ujBugvwSq5CHvHNFTb2MhKyt
         ummg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705679350; x=1706284150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJCOJrM5uAeYWzffiza/Y1SSVgClIZfy3CNOrCYjLv4=;
        b=ZKoD2F+DxNOBP0k7Rt+Ygckh2VExO5aRAwPIceUQ10lCBwEgD9jIdeZri9X6xBExpk
         t/2jTlOTCKpSLv0uZPTMjF06WOrt3eKij7d++JCvzB23l3Jz1k5BEJwekG+im1y/KrPK
         LKbojkZUiUBRghVS6jDDkI5b+dqlPJhE2hU4Yo2H+NJXa2sXAESEAh58C5RS7W7b59SV
         D0mK/J/Ex5cKjTn/nmiNUD4v6cltgTLW/i1ZBkQTpy46cECgq2QgF717Gxqg3iUTsbsK
         h+jM0NOWYWBEbRd7Uq7BwOgODkUT3EONLc/hBc/1haFyBYUTT7srpOT3QWCI7z4xDHVT
         OpOg==
X-Gm-Message-State: AOJu0Yxwtg4++yzCXWsckayx8Ch/G8JYwytjAsqJSVNYCUbEN2/7I6Eh
	jVTYnd7dot1eHziphJuJP6RlkmXz18DSCVg5q7zFHAPewblcwUQLF17vYcOX0ho=
X-Google-Smtp-Source: AGHT+IGt+Ic6TmYhme3qLr6jE1/68NER1BpVZ+X3fxsIbn5gfmAli+tnqmvjZjUMJ3vS8Xa0akDxSA==
X-Received: by 2002:a05:600c:2192:b0:40e:867d:7c27 with SMTP id e18-20020a05600c219200b0040e867d7c27mr1121821wme.262.1705679350236;
        Fri, 19 Jan 2024 07:49:10 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:be5a:dd18:16a0:a9e5])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b0040e53f24ceasm29455083wmq.16.2024.01.19.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 07:49:09 -0800 (PST)
Date: Fri, 19 Jan 2024 16:49:07 +0100
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] sched/fair: Do not scan non-movable tasks
 several times
Message-ID: <ZaqZ8wXzNvqUH8Jn@vingu-book>
References: <20240115105052.398761-1-khorenko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115105052.398761-1-khorenko@virtuozzo.com>

Le lundi 15 janv. 2024 à 13:50:52 (+0300), Konstantin Khorenko a écrit :
> If busiest rq is small, nr_running < SCHED_NR_MIGRATE_BREAK and all
> tasks are not movable, detach_tasks() should not iterate more than tasks
> available in the busiest rq.
> 
> Before commit: b0defa7ae03e ("sched/fair: Make sure to try to detach at
> least one movable task"), the (env->loop > env->loop_max) condition
> prevented us from scanning non-movable tasks more than rq size times,
> but after we start checking the LBF_ALL_PINNED flag, the "all tasks are
> not movable" case is under threat.
> 
> Note: in case all tasks in the rq could not be moved in detach_tasks()
> we always increase loop_break by SCHED_NR_MIGRATE_BREAK, so we can step
> over loop_max, but i think it's a rare case and does not worth adding
> here extra check for rq->nr_running overlimit.


In this case why not doing the below ? Close to your 1st version 

---
 kernel/sched/fair.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fce22b4462bb..1dae6cdf8561 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11344,6 +11344,13 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);

 more_balance:
+		/*
+		 * If busiest rq is small, nr_running < SCHED_NR_MIGRATE_BREAK
+		 * and all tasks are not movable, detach_tasks() should not
+		 * iterate more than tasks available in rq.
+		 */
+		env.loop_break = min(env.loop_break, busiest->nr_running);
+
 		rq_lock_irqsave(busiest, &rf);
 		update_rq_clock(busiest);

--
2.34.1


> 
> Fixes: b0defa7ae03e ("sched/fair: Make sure to try to detach at least
> one movable task")
> 
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  kernel/sched/fair.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 533547e3c90a..920fb16e6e2f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11277,7 +11277,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  		.dst_rq		= this_rq,
>  		.dst_grpmask    = group_balance_mask(sd->groups),
>  		.idle		= idle,
> -		.loop_break	= SCHED_NR_MIGRATE_BREAK,
>  		.cpus		= cpus,
>  		.fbq_type	= all,
>  		.tasks		= LIST_HEAD_INIT(env.tasks),
> @@ -11324,6 +11323,14 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  		 */
>  		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
>  
> +more_balance_reset_break:
> +		/*
> +		 * If busiest rq is small, nr_running < SCHED_NR_MIGRATE_BREAK
> +		 * and all tasks are not movable, detach_tasks() should not
> +		 * iterate more than tasks available in rq.
> +		 */
> +		env.loop_break = min(SCHED_NR_MIGRATE_BREAK, busiest->nr_running);
> +
>  more_balance:
>  		rq_lock_irqsave(busiest, &rf);
>  		update_rq_clock(busiest);
> @@ -11386,13 +11393,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  			env.dst_cpu	 = env.new_dst_cpu;
>  			env.flags	&= ~LBF_DST_PINNED;
>  			env.loop	 = 0;
> -			env.loop_break	 = SCHED_NR_MIGRATE_BREAK;
>  
>  			/*
>  			 * Go back to "more_balance" rather than "redo" since we
>  			 * need to continue with same src_cpu.
>  			 */
> -			goto more_balance;
> +			goto more_balance_reset_break;
>  		}
>  
>  		/*
> @@ -11418,7 +11424,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  			 */
>  			if (!cpumask_subset(cpus, env.dst_grpmask)) {
>  				env.loop = 0;
> -				env.loop_break = SCHED_NR_MIGRATE_BREAK;
>  				goto redo;
>  			}
>  			goto out_all_pinned;
> -- 
> 2.39.3
> 

