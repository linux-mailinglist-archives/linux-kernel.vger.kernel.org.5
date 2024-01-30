Return-Path: <linux-kernel+bounces-43678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 916A8841793
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E0B2843A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC06208AF;
	Tue, 30 Jan 2024 00:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="anqXGWUU"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC71E497
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575002; cv=none; b=VoXn0Ustmw4ILNsSPx/qs4lY1KckuPEkuv3SowX/jdwTSqMzosxKHHsTid2r8kXuPklLP1nV3MePxWEz0R7lRB+wcxc9PPMt9knNWGdlb2scsEg4/bs6hDvPuo4Fku2roAiQU9rBmKACv98L/JQ0S6+96U4NlhyU2Y4nEd8oH70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575002; c=relaxed/simple;
	bh=TqR2eUglEQwdjXW91rVEcJp8ImbPKiEAgBGAh46CadI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mB/XYZ538eLtXxXt3A8rGD7P3GIj1uhXHrpE4hyIs4VKnv/2QmOZuTsEcFoKVBf8lC239TaTgD1YqFfGFQgt4SY+3uAVv8rHJT08iK888nWWdBucLEgPUp9WjofBnGCPE79z7sOJB6V939CMTpTXlm+MyDt9Ax07EoNnLSJEDvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=anqXGWUU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33aef64f702so790130f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706574998; x=1707179798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bqKM6STmm52HJ2nwWL/mUa9wVvNf8Up7PtiKbmg/qtQ=;
        b=anqXGWUUeLiRCQzPE7pl3Adlb0q9Bg3sXa+FVL4SKsj/7s1FJLAW4R8IrAmUCaVx7c
         BpxwFhQwaE5rgw8Jw63BNrYi+B3tCaukASUS4NJCNDrX+PBY1fxBDNITamRaoywZ8aOI
         B6axdZ4EjtROeQM7/YpDlgj43ePMxHfM41XiidtxdzdLm0RktCZpn7ahXdFejpMkpoka
         JYnsT57KK3NkvGzTxO5I+TREkM0t1miGwphtVOCcUCPEjP4yGsz24n/pNVHkV379s9eB
         6vnYteOugHyiuHSV5VWLZBiCPdWR4xnNtvpgrjf6TgSup0ngfIuI44PdXII17ZyaX68P
         mD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706574998; x=1707179798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqKM6STmm52HJ2nwWL/mUa9wVvNf8Up7PtiKbmg/qtQ=;
        b=jRDeCPCUz4b4Wn1yzU/f4+ht0VK0oD6RyJS9PJqMoBoe72M042njViw66Sk08qYKcf
         48t6eqA8KE/biVha3Bm197gd670YtYy72dMTtWU/Tjwta7LIpG4CxocD/97YBXZ0sg1K
         AL3fmmKynjTP8xQTRoj6rs7XaWm6RKBVfazOx0v6YKSQWkWwBh7RXHNISM8eyjfVYaIl
         LO63z0OxbSiWdyUaMbGE6oWlSoceCg4xT87Ae7RQTkLkBZ4XilvanqhMawqIIf6iMjnA
         w/0HZhq/A25OxnkZU+ymUI7Wbxj6oQx5W9T+UnS+T8gqp1dAax0cvlkBDbZw9VMXzQbM
         Tr/Q==
X-Gm-Message-State: AOJu0YyX1YdBC1RkOLCs+1X/tFDsIgHv7c/YkEq6rA+qPBvKnvvgi9ya
	Y/CU50Vqu7l8kHoDz8Kdz2VnpWZSew0iaBOSL3nMjmWvuYuuvwnCcZKOnXum/iE=
X-Google-Smtp-Source: AGHT+IHFRGkHKlZdVXlzOHtFexmDPQmMqF+AK8Fq0HHOoKcjqOrnWynGemLhYlr7ZVzURH6Al81GBw==
X-Received: by 2002:a05:6000:930:b0:337:c872:7153 with SMTP id cx16-20020a056000093000b00337c8727153mr5001577wrb.46.1706574997649;
        Mon, 29 Jan 2024 16:36:37 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id d5-20020adffbc5000000b0033aedaea1b2sm3763339wrs.30.2024.01.29.16.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:36:37 -0800 (PST)
Date: Tue, 30 Jan 2024 00:36:35 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	lukasz.luba@arm.com, rui.zhang@intel.com, mhiramat@kernel.org,
	daniel.lezcano@linaro.org, amit.kachhap@gmail.com, corbet@lwn.net,
	gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 5/5] sched/pelt: Remove shift of thermal clock
Message-ID: <20240130003635.anipjhfdfld3xcil@airbuntu>
References: <20240109164655.626085-1-vincent.guittot@linaro.org>
 <20240109164655.626085-6-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240109164655.626085-6-vincent.guittot@linaro.org>

On 01/09/24 17:46, Vincent Guittot wrote:
> The optional shift of the clock used by thermal/hw load avg has been
> introduced to handle case where the signal was not always a high frequency
> hw signal. Now that cpufreq provides a signal for firmware and
> SW pressure, we can remove this exception and always keep this PELT signal
> aligned with other signals.
> Mark sysctl_sched_migration_cost boot parameter as deprecated
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Better without it, yes.

Reviewed-by: Qais Yousef <qyousef@layalina.io>

>  .../admin-guide/kernel-parameters.txt          |  1 +
>  kernel/sched/core.c                            |  2 +-
>  kernel/sched/fair.c                            | 10 ++--------
>  kernel/sched/sched.h                           | 18 ------------------
>  4 files changed, 4 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..2ee15522b15d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5722,6 +5722,7 @@
>  			but is useful for debugging and performance tuning.
>  
>  	sched_thermal_decay_shift=
> +			[Deprecated]
>  			[KNL, SMP] Set a decay shift for scheduler thermal
>  			pressure signal. Thermal pressure signal follows the
>  			default decay period of other scheduler pelt
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a6f084bdf1c5..c68e47bfd5ae 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5670,7 +5670,7 @@ void scheduler_tick(void)
>  
>  	update_rq_clock(rq);
>  	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
> -	update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure);
> +	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
>  	curr->sched_class->task_tick(rq, curr, 0);
>  	if (sched_feat(LATENCY_WARN))
>  		resched_latency = cpu_resched_latency(rq);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f1c3d600d6d6..d5ba6cdb141c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -78,15 +78,9 @@ static unsigned int normalized_sysctl_sched_base_slice	= 750000ULL;
>  
>  const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
>  
> -int sched_hw_decay_shift;
>  static int __init setup_sched_thermal_decay_shift(char *str)
>  {
> -	int _shift = 0;
> -
> -	if (kstrtoint(str, 0, &_shift))
> -		pr_warn("Unable to set scheduler thermal pressure decay shift parameter\n");
> -
> -	sched_hw_decay_shift = clamp(_shift, 0, 10);
> +	pr_warn("Ignoring the deprecated sched_thermal_decay_shift= option\n");
>  	return 1;
>  }
>  __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
> @@ -9247,7 +9241,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>  
>  	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
>  		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> -		  update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure) |
> +		  update_hw_load_avg(now, rq, hw_pressure) |
>  		  update_irq_load_avg(rq, 0);
>  
>  	if (others_have_blocked(rq))
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 677d24202eec..6fc6718a1060 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1520,24 +1520,6 @@ static inline u64 rq_clock_task(struct rq *rq)
>  	return rq->clock_task;
>  }
>  
> -/**
> - * By default the decay is the default pelt decay period.
> - * The decay shift can change the decay period in
> - * multiples of 32.
> - *  Decay shift		Decay period(ms)
> - *	0			32
> - *	1			64
> - *	2			128
> - *	3			256
> - *	4			512
> - */
> -extern int sched_hw_decay_shift;
> -
> -static inline u64 rq_clock_hw(struct rq *rq)
> -{
> -	return rq_clock_task(rq) >> sched_hw_decay_shift;
> -}
> -
>  static inline void rq_clock_skip_update(struct rq *rq)
>  {
>  	lockdep_assert_rq_held(rq);
> -- 
> 2.34.1
> 

