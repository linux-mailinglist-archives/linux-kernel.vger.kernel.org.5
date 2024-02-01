Return-Path: <linux-kernel+bounces-48936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AA784635D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DB51F23664
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2801E3FE35;
	Thu,  1 Feb 2024 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="pNNruIwb"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B77F3D566
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826274; cv=none; b=QorT73fv2LhfNV2Na4gHtRck8/kKb04GqQNp0ok8ERLUqbABAQabWYI4TmIv/G3L6186hCORUvgdd8+SFXUO6R7LTWn/U3hRVxk96ZwZ/8kgZNwTrWtetMikcqashUyLf86K5TUY1JEOcXhdYcZv3ukpIlp1xXXDXzSnJW0Kuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826274; c=relaxed/simple;
	bh=UURPcYWCnKWjxOkLscKm8E7K8bDh888NWkqf1x9AD48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWECM+0tQ1UBr6xva4TLtPYNl8qLGKjdKIW9VQjfi5UXE0FSGIKML4bVa5HfizKZNvtyI8diprA94QUJ2wRsTj2FsqrqiMbO/0LYg997VVpA34JJxRMc1kJnK//9bu8lVb7o8/Zu4nT31k59noolhYblhgRP0p4DzKuVRYKA/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=pNNruIwb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3394ca0c874so1017839f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 14:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706826270; x=1707431070; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gQAt5aS7KRMgfogzTOOYd/eJy6smlcItxc00TEhas+w=;
        b=pNNruIwbzfbSsDcpzHdmUpDf2N8FSX0G+iL8XwryMxCwVMsher8zkgCaO0T4GaoUY4
         fCUAs2363PTu1hQWeOGqdp/IOfndhfg3lOfkVk0+klXzw0GCFu3I4ciUR2piiDdz1riQ
         ytMz/L54OdQYZPlWroxQuKcnNAGvkOB0C1eUQzNQheBv1DSrqE28gKOLL6HxbQt2VImU
         fqurIE9UId00kHAOlhva0H2+iWQ34Iw6qT+AV5B/0ZUXFMNf9uq6dlFoPBNiKUneEL+X
         Ns3pykp/Cqu0sT1KYtpzZWGibqUlB2S/UHKapIVlf4srRcqP++L6Jhk2qmcmgkIeCJnq
         AlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826270; x=1707431070;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQAt5aS7KRMgfogzTOOYd/eJy6smlcItxc00TEhas+w=;
        b=XEIenouHvWb0tjTujjZ9E8bO9FCBPw3CcafvQXgHZ7M76X5KYpYrs8FqySHCQxwXM4
         jte9ZPLL5aWLAsLW2syW/OyAxKEJdjQyjPvyWxZI8zy/3I74p5pfeFFUrwC5QbBhQRXY
         Zf/ftsswgyq5cRhRzadJMJTXJreerLuVzSt/kto6yO3dKFOUosU2AJ2QeleC1k9gM/hQ
         lQaEC/8kaUaDpXUQxgEKKL3IVmPajW1UXEdKkx/MWsEBjDrX+AcxbezMmZOjz3w0BIG3
         Y9Tuze5t0CjWFffQAjxA4g+WTWnH63SJDc3Mxe8ajtpFOgR2POhVwVCGB4oZa5xgHJfv
         +V3w==
X-Gm-Message-State: AOJu0YwohaGPEv01/Hb98hNpRlUt8gI2EtxC8LQYEYQ7PM6J0T/Z3BLw
	W5g++B2S7KgXcctwEw1qw1F9BIRcfuvMxX7bHz4BKe94oHjV2PvxlqjJq8bG8c4=
X-Google-Smtp-Source: AGHT+IEmnfQiKeiqwTDyY2LG7jK+n0B+bb4NVRDPmkr8rta8YSnLCzLDVChQOjP2xR9caPTSGO2LSg==
X-Received: by 2002:adf:a3c8:0:b0:339:feca:9428 with SMTP id m8-20020adfa3c8000000b00339feca9428mr192105wrb.40.1706826270393;
        Thu, 01 Feb 2024 14:24:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU9IlJa0d/4pgka5qp9MdpPfGIP4PIURjEz395NZr3C5nhAJcXzHHDA2Up/CRH+yhKJIg70ZSyvWGk3U2U4XfjS0dBjzUHNOd/NM3n43dZc/vqaZ7ZJJI7G9gGBvJs85uBNQkw00kZrFxpmKIZlQ2b6J1MwUiPAyfoZtuuRrWPsA4x9zykbr0KFG+1ImmV49Klxe1OQEGDQ43/eC5mKTeNwj9aFEGHVsmxYKMT80UxU9zkUCzjPKL5qRNcNCT+NeUoDftzkRI42iEHW8c1b4EdenbsaBakxnzRMEFVmbr/PtQDw+LGyPBtj6Gbvd7FMu+HdYELJislg/Qr76vNmvcy14VoG+b1CYLSRrOwH2r+jHg==
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id w4-20020adfec44000000b0033b1277e95dsm456968wrn.77.2024.02.01.14.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:24:29 -0800 (PST)
Date: Thu, 1 Feb 2024 22:24:28 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>
Subject: Re: [PATCH v2 8/8] sched/pelt: Introduce PELT multiplier
Message-ID: <20240201222428.xd2sylnz66wrczal@airbuntu>
References: <20231208002342.367117-1-qyousef@layalina.io>
 <20231208002342.367117-9-qyousef@layalina.io>
 <Zbk0DhibX0oDLk1s@vingu-book>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zbk0DhibX0oDLk1s@vingu-book>

On 01/30/24 18:38, Vincent Guittot wrote:
> Le vendredi 08 déc. 2023 à 00:23:42 (+0000), Qais Yousef a écrit :
> > From: Vincent Donnefort <vincent.donnefort@arm.com>
> > 
> > The new sched_pelt_multiplier boot param allows a user to set a clock
> > multiplier to x2 or x4 (x1 being the default). This clock multiplier
> > artificially speeds up PELT ramp up/down similarly to use a faster
> > half-life than the default 32ms.
> > 
> >   - x1: 32ms half-life
> >   - x2: 16ms half-life
> >   - x4: 8ms  half-life
> > 
> > Internally, a new clock is created: rq->clock_task_mult. It sits in the
> > clock hierarchy between rq->clock_task and rq->clock_pelt.
> > 
> > The param is set as read only and can only be changed at boot time via
> > 
> > 	kernel.sched_pelt_multiplier=[1, 2, 4]
> > 
> > PELT has a big impact on the overall system response and reactiveness to
> > change. Smaller PELT HF means it'll require less time to reach the
> > maximum performance point of the system when the system become fully
> > busy; and equally shorter time to go back to lowest performance point
> > when the system goes back to idle.
> > 
> > This faster reaction impacts both dvfs response and migration time
> > between clusters in HMP system.
> > 
> > Smaller PELT values are expected to give better performance at the cost
> > of more power. Under powered systems can particularly benefit from
> > smaller values. Powerful systems can still benefit from smaller values
> > if they want to be tuned towards perf more and power is not the major
> > concern for them.
> > 
> > This combined with respone_time_ms from schedutil should give the user
> > and sysadmin a deterministic way to control the triangular power, perf
> > and thermals for their system. The default response_time_ms will half
> > as PELT HF halves.
> > 
> > Update approximate_{util_avg, runtime}() to take into account the PELT
> > HALFLIFE multiplier.
> > 
> > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > [Converted from sysctl to boot param and updated commit message]
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >  kernel/sched/core.c  |  2 +-
> >  kernel/sched/pelt.c  | 52 ++++++++++++++++++++++++++++++++++++++++++--
> >  kernel/sched/pelt.h  | 42 +++++++++++++++++++++++++++++++----
> >  kernel/sched/sched.h |  1 +
> >  4 files changed, 90 insertions(+), 7 deletions(-)
> > 
> 
> ...
> 
> > +__read_mostly unsigned int sched_pelt_lshift;
> > +static unsigned int sched_pelt_multiplier = 1;
> > +
> > +static int set_sched_pelt_multiplier(const char *val, const struct kernel_param *kp)
> > +{
> > +	int ret;
> > +
> > +	ret = param_set_int(val, kp);
> > +	if (ret)
> > +		goto error;
> > +
> > +	switch (sched_pelt_multiplier)  {
> > +	case 1:
> > +		fallthrough;
> > +	case 2:
> > +		fallthrough;
> > +	case 4:
> > +		WRITE_ONCE(sched_pelt_lshift,
> > +			   sched_pelt_multiplier >> 1);
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		goto error;
> > +	}
> > +
> > +	return 0;
> > +
> > +error:
> > +	sched_pelt_multiplier = 1;
> > +	return ret;
> > +}
> > +
> > +static const struct kernel_param_ops sched_pelt_multiplier_ops = {
> > +	.set = set_sched_pelt_multiplier,
> > +	.get = param_get_int,
> > +};
> > +
> > +#ifdef MODULE_PARAM_PREFIX
> > +#undef MODULE_PARAM_PREFIX
> > +#endif
> > +/* XXX: should we use sched as prefix? */
> > +#define MODULE_PARAM_PREFIX "kernel."
> > +module_param_cb(sched_pelt_multiplier, &sched_pelt_multiplier_ops, &sched_pelt_multiplier, 0444);
> > +MODULE_PARM_DESC(sched_pelt_multiplier, "PELT HALFLIFE helps control the responsiveness of the system.");
> > +MODULE_PARM_DESC(sched_pelt_multiplier, "Accepted value: 1 32ms PELT HALIFE - roughly 200ms to go from 0 to max performance point (default).");
> > +MODULE_PARM_DESC(sched_pelt_multiplier, "                2 16ms PELT HALIFE - roughly 100ms to go from 0 to max performance point.");
> > +MODULE_PARM_DESC(sched_pelt_multiplier, "                4  8ms PELT HALIFE - roughly  50ms to go from 0 to max performance point.");
> > +
> >  /*
> >   * Approximate the new util_avg value assuming an entity has continued to run
> >   * for @delta us.
> 
> ...
> 
> > +
> >  static inline void
> > -update_rq_clock_pelt(struct rq *rq, s64 delta) { }
> > +update_rq_clock_task_mult(struct rq *rq, s64 delta) { }
> >  
> >  static inline void
> >  update_idle_rq_clock_pelt(struct rq *rq) { }
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index bbece0eb053a..a7c89c623250 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1029,6 +1029,7 @@ struct rq {
> >  	u64			clock;
> >  	/* Ensure that all clocks are in the same cache line */
> >  	u64			clock_task ____cacheline_aligned;
> > +	u64			clock_task_mult;
> 
> I'm not sure that we want yet another clock and this doesn't apply for irq_avg.
> 
> What about the below is simpler and I think cover all cases ?

Looks better, yes. I'll change to this and if no issues come up I'll add your
signed-off-by if that's okay with you for the next version.


Thanks!

--
Qais Yousef

> 
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index f951c44f1d52..5cdd147b7abe 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -180,6 +180,7 @@ static __always_inline int
>  ___update_load_sum(u64 now, struct sched_avg *sa,
>  		  unsigned long load, unsigned long runnable, int running)
>  {
> +	int time_shift;
>  	u64 delta;
> 
>  	delta = now - sa->last_update_time;
> @@ -195,12 +196,17 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
>  	/*
>  	 * Use 1024ns as the unit of measurement since it's a reasonable
>  	 * approximation of 1us and fast to compute.
> +	 * On top of this, we can change the half-time period from the default
> +	 * 32ms to a shorter value. This is equivalent to left shifting the
> +	 * time.
> +	 * Merge both right and left shifts in one single right shift
>  	 */
> -	delta >>= 10;
> +	time_shift = 10 - sched_pelt_lshift;
> +	delta >>= time_shift;
>  	if (!delta)
>  		return 0;
> 
> -	sa->last_update_time += delta << 10;
> +	sa->last_update_time += delta << time_shift;
> 
>  	/*
>  	 * running is a subset of runnable (weight) so running can't be set if
> 
> 
> 
> >  	u64			clock_pelt;
> >  	unsigned long		lost_idle_time;
> >  	u64			clock_pelt_idle;
> > -- 
> > 2.34.1
> > 

