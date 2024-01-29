Return-Path: <linux-kernel+bounces-43590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDDB841603
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2B12868A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280615103E;
	Mon, 29 Jan 2024 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="a4aDW5gz"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3844F5FB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568831; cv=none; b=KMj8DA1VBtVoK3avMKkzKsmXE0/J1m6XNF/eCNpG50jVdigYCNY72X9bRfuTCSrm7B77jVZ838hIXcfjqx8C42T2ToQ5Lnbl/9V8wxPGi2Ixk+2tH65Ke5RDJhpTU5dU1YrURBdYEPSHopr5E7QcAySm6FTk22NZ0F75wUfWbmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568831; c=relaxed/simple;
	bh=MPUY3PEVwgij/jU9TQGoPMlLCy2A3dYBdHtVPRkqG7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0qCYG1k40D/4mmEpide4sjWlEK5id55w9hfBCSmwREz8rwCS70LrvoJnAZhjugP2nXeJJvdtT3CxYigjoqN30QP26VRhli8mqTzBY5ZW1P9UKdt35CA6sEIf6c5i71eAVliA9W+WnyPILa7nUrkgsez+GlqBq0lKdVIKxnsvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=a4aDW5gz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3394bec856fso2464665f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706568827; x=1707173627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wiRepJW8SQlfBHLXa2ZsZ8xoQbtLQ2mvylFBJ/mZgMA=;
        b=a4aDW5gzn/e22XrPtipVgXO56ZpEo3CgtGQnHafopVi3nRHXBB3f4TFArGB2VvGd0c
         E5jlP6Mlapzy72x5e2tT14Rdjtg2XbKVJiYyxa4ty8f2Y+aH+Dn0yQ/HhkH6woncdRIL
         JwVdd76xaYyFvGQzunYMFgslKq5sx3/M3DlQT1cQhhUSuFqOzqfTq8yueysdS0r3kbFa
         GMTO/xspydR30MOf+65JmnIf2Zp5A2mRpO5qOPFja1f7UYHLwrjJy9pc0zCUeHVNnqdf
         UwZXc5aOZiHSyC44AFYMtt25uwWGljESH2IRDPHmdDHFsg4l4kmB9lISeCR2g6NJ9W6b
         jwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706568827; x=1707173627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiRepJW8SQlfBHLXa2ZsZ8xoQbtLQ2mvylFBJ/mZgMA=;
        b=jLXKt8X8j8L/nDZDigDiS1EJIqdBvGvlhu8QOKfb09ONdTykDrPETvazvi7PzvIxh7
         CLWa8CxjHkJiNylnu6R65T5GG2rGAG15mR4Aids3DUGTD7eklXrfZTMtCoVhhAPX/wT0
         9KCFP+wX8XqaCtNq89DG4b/sqWX59mHtKIK92SgdTKEAw9+XcPlqUJxG5nIqSXIGmScX
         Mbq5IQl3MD0oKYkB61fu0xm3MXk19H1Y1Fw0HFWBkIKKec2iifMGcTPhQb232Vq6m2N+
         3ZJXFTC2Csp+wDB60DJ7aNgIF4kJnrR/Arylyuvir6h+UpN4Hg9sPHYos+cPV1EomHXk
         wvLA==
X-Gm-Message-State: AOJu0YxYegq9K01mwS1cyNkCIgE0u6JTliNCyAv62QpEr82/JqNja42b
	auX+Fb+7zlHEY0hRT3sfv4x1cSOq9B/KMOZR3/I40+bMFBt/SlbbeRlTzhmKtt8=
X-Google-Smtp-Source: AGHT+IHrT2PVGaCfISiBhIo0QfI/wsSY1VesH0apg/VvribKsULXcDLzItXfKWMWyZBniuj8e0musg==
X-Received: by 2002:adf:f601:0:b0:33a:e605:57c9 with SMTP id t1-20020adff601000000b0033ae60557c9mr5082068wrp.27.1706568826885;
        Mon, 29 Jan 2024 14:53:46 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id f15-20020a056000036f00b00337d84efaf7sm9105468wrf.74.2024.01.29.14.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:53:46 -0800 (PST)
Date: Mon, 29 Jan 2024 22:53:44 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240129225344.rx56bk22x2xjxqyt@airbuntu>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBYcVWxYOhWZjzcQUB1ebUBA-B30hvToqGBq6JnfRUZNg@mail.gmail.com>
 <20240124222959.ikwnbxkcjaxuiqp2@airbuntu>
 <CAKfTPtDxqcrf0kaBQG_zpFx-DEZTMKfyxBu_bzCuZ_UZhJwOnA@mail.gmail.com>
 <20240126014602.wdcro3ajffpna4fp@airbuntu>
 <CAKfTPtDqABnPDmt0COqyRpYSuj_WWwLrqL+Tbfa8J8b5u5eQtQ@mail.gmail.com>
 <20240128235005.txztdbdq2obyi4n6@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240128235005.txztdbdq2obyi4n6@airbuntu>

On 01/28/24 23:50, Qais Yousef wrote:
> On 01/26/24 15:08, Vincent Guittot wrote:
> 
> > > TBH I had a bit of confirmation bias that this is a problem based on the fix
> > > (0ae78eec8aa6) that we had in the past. So on verification I looked at
> > > balance_interval and this reproducer which is a not the same as the original
> > > one and it might be exposing another problem and I didn't think twice about it.
> > 
> > I checked the behavior more deeply and I confirm that I don't see
> > improvement for the use case described above. I would say that it's
> > even worse as I can see some runs where the task stays on little
> > whereas a big core has been added in the affinity. Having in mind that
> > my system is pretty idle which means that there is almost no other
> > reason to trigger an ilb than the misfit task, the change in
> > check_misfit_status() is probably the reason for never kicking an ilb
> > for such case
> 
> It seems I reproduced another problem while trying to reproduce the original
> issue, eh.
> 
> I did dig more and from what I see the issue is that the rd->overload is not
> being set correctly. Which I believe what causes the delays (see attached
> picture how rd.overloaded is 0 with some spikes). Only when CPU7
> newidle_balance() coincided with rd->overload being 1 that the migration
> happens. With the below hack I can see that rd->overload is 1 all the time
> (even after the move as we still trigger a misfit on the big CPU). With my
> patch only rd->overload is set to 1 (because of this task) only for a short
> period after we change affinity.
> 
> 	diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> 	index df348aa55d3c..86069fe527f9 100644
> 	--- a/kernel/sched/fair.c
> 	+++ b/kernel/sched/fair.c
> 	@@ -9707,8 +9707,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> 				continue;
> 			}
> 
> 	-               if (local_group)
> 	-                       continue;
> 	+               /* if (local_group) */
> 	+                       /* continue; */
> 
> 			if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
> 				/* Check for a misfit task on the cpu */
> 
> I am not sure what the right fix is, but it seems this condition is required
> for the 2nd leg of this if condition when we compare with load? I don't think
> we should skip the misfit check.

I'm still not sure I got the original intent of why we skip for local_group. We
need to set sg_status which operates at root domain to enable a cpu to
pull a misfit task.

AFAICS newidle_balance() will return without doing anything if rd->overload is
not set. So making sure we update this flag always and for both legs is
necessary IIUC

	diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
	index df348aa55d3c..bd2f402eac41 100644
	--- a/kernel/sched/fair.c
	+++ b/kernel/sched/fair.c
	@@ -9707,9 +9707,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
				continue;
			}

	-               if (local_group)
	-                       continue;
	-
			if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
				/* Check for a misfit task on the cpu */
				if (sgs->group_misfit_task_load < rq->misfit_task_load) {
	@@ -9719,8 +9716,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
			} else if ((env->idle != CPU_NOT_IDLE) &&
				   sched_reduced_capacity(rq, env->sd)) {
				/* Check for a task running on a CPU with reduced capacity */
	-                       if (sgs->group_misfit_task_load < load)
	+                       if (sgs->group_misfit_task_load < load) {
					sgs->group_misfit_task_load = load;
	+                               *sg_status |= SG_OVERLOAD;
	+                       }
			}
		}

I was wondering why we never pull at TICK/rebalance_domains() where no such
check is made. But when newidle_balance() returns early it sets
update_next_balance() to add balance_interval which is already long. So we end
up delaying things further thinking we've 'attempted' a load balance and
it wasn't necessary - but in reality we failed to see it and not allowing the
rebalance_domains() to see it either by continuing to push it forward.

