Return-Path: <linux-kernel+bounces-73283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAAD85C075
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E365B22926
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7151E762EF;
	Tue, 20 Feb 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="rczyVpvC"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7473161
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444759; cv=none; b=Bz0W6/g0bS/+2z/EX6U/bSuYZR1tXLWae0CIJHmU/HklFfyOVk1kQ6FasxkqfSONvOtFZSmAM+l2CtZIgkhdkcVP7IdXe9UDPkkvEP8ulIY9zihQ3wTPHdEM6slv7LmynLgRsClSRdXAyQjwTRqwjNG9jzAWKJBdPa2HakkX4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444759; c=relaxed/simple;
	bh=pIXtL7ZgBdx13wZpgw4+F65MivWC4nROzSFx5PqAvSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+0OriIVoId88DiUT4VCnbqXr36IzmHpMeG9IsyPjJ2KG4vP3qZQ/Ih0xI1AGOa6oqfopqDOG3xfPdT3z421GTJdWo0p1HA+n0nzkpoGrQtvSLwKv5cC1BtRRr0qQIRvzCC/I1l/+PtCzI4jznF3BZ/M9Z/6b/gM1w0zgE5wFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=rczyVpvC; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d208d0b282so75406301fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708444756; x=1709049556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wdvYmqhmDTEtftJwbYbaSS7gyIZQgECqB1shnsI9ajM=;
        b=rczyVpvCEvnAsyIbyIz3dLXDkkjue4mJcL9RMxQxXwyDhowYvdFEJDTs5Z4m6aGZaq
         tDJ9TMajBrNAl48m/RtLL+uSf6BpGyCIjROUfzrm9eTm1VYpYR58z7fOPqyunHDkikt9
         ZJiRfSGav+I8PNqLOWI84n3tdDAkWA2QKcjl8S/YQ8hJ5YY4pLsjVTxW7p20eF1dbZDg
         V9WlTQ4yzmp9A4wRBd7NY9OBPitNZMpthci+/h5AC9/cFke/A+7LIXxIU9wgB5TjdyEQ
         KUeH0V/okoZbteg+FQIfyUrNx+YxaS1t69jNGZmSmREk1hwCSeFJNagCgolcHcqMzieS
         Tz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708444756; x=1709049556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdvYmqhmDTEtftJwbYbaSS7gyIZQgECqB1shnsI9ajM=;
        b=WzbyMuWXmegGMOFcssOar0zFV5lmZ7Y8tyeI93TLm9FJdvfpN/3ibOffU8rweAwh+H
         AkJXyeOI5wXJ7hWV84u4PkRiRpomUOn/zKET4PjWF6h9r+Rr6tUZK1FzmV0PGBq36Lul
         dHEk/3WesUWpmpcChSSR5rcNhKpfrfNhSQKblBOaPcUUhe7Zl/lTYR2g3Ec5ZmnBLKQ6
         Mh/L5pmA9tAtaUJL8ZRRxw6oOV5evnxRM2KqkVlQnAUMGZrayiOoeuMFT3vAb43FjbmZ
         UKWIgivSBnhPRjzb2LvYx6ykOMeQjM1GOJRCGrX6TqqBOWhOvbdqkJp9Cqljmw6po2yL
         JI1w==
X-Forwarded-Encrypted: i=1; AJvYcCVv6BLSPlQapZS6WqjSth11CcGSZVSFVxeLAbhfOMH9oks7DKBy/aHNJ1cHkpMgACV7CD/xpYSJXTAC7/3Sbxw0ZIemN7zFTMtIkcG8
X-Gm-Message-State: AOJu0Yy9bcqXCkIGJmKF1JlLs9FXS4h6wM6pG1bU/Jf/t8P6tnYjSyhg
	5bSpYSPJfqCnF/Rb3hJRwLHejGHSz6WS9Q5bvF1r+eLLLX8XTxBBTIahvsghqCg=
X-Google-Smtp-Source: AGHT+IFSLebeu500ZkMyPuWH9Ms2751BnoZSlJumVXP2Uecl5YGc/dghjCM6NPi+L3Yue1at7dhsyA==
X-Received: by 2002:a2e:b70f:0:b0:2d2:4487:55c6 with SMTP id j15-20020a2eb70f000000b002d2448755c6mr2295470ljo.21.1708444755532;
        Tue, 20 Feb 2024 07:59:15 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c229500b0041228b2e179sm14916080wmf.39.2024.02.20.07.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:59:15 -0800 (PST)
Date: Tue, 20 Feb 2024 15:59:13 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v5 2/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240220155913.n7uxb3e56kuhcxs2@airbuntu>
References: <20240205021123.2225933-1-qyousef@layalina.io>
 <20240205021123.2225933-3-qyousef@layalina.io>
 <CAKfTPtAsij+_=n9JCxHw==j3-wC9rYZHEJyVmyBJsx_-Udhzgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAsij+_=n9JCxHw==j3-wC9rYZHEJyVmyBJsx_-Udhzgw@mail.gmail.com>

On 02/12/24 18:27, Vincent Guittot wrote:

> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index b803030c3a03..8b8035f5c8f6 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5092,24 +5092,36 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
> >
> >  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> >  {
> > +       unsigned long cpu_cap;
> > +       int cpu = cpu_of(rq);
> > +
> >         if (!sched_asym_cpucap_active())
> >                 return;
> >
> > -       if (!p || p->nr_cpus_allowed == 1) {
> > -               rq->misfit_task_load = 0;
> > -               return;
> > -       }
> > +       if (!p || p->nr_cpus_allowed == 1)
> > +               goto out;
> >
> > -       if (task_fits_cpu(p, cpu_of(rq))) {
> > -               rq->misfit_task_load = 0;
> > -               return;
> > -       }
> > +       cpu_cap = arch_scale_cpu_capacity(cpu);
> > +
> > +       /* If we can't fit the biggest CPU, that's the best we can ever get. */
> > +       if (cpu_cap == rq->rd->max_cpu_capacity)
> 
> Isn't the condition above also covered by the condition below and
> becomes now useless ?

Yes, you're right. If it is allowed to run on rd->max_cpu_capacity then the
below check will cover it. If it is not allowed, then it won't be there on the
first place.

I'll drop it.

> > -/*
> > - * Check whether a rq has a misfit task and if it looks like we can actually
> > - * help that task: we can migrate the task to a CPU of higher capacity, or
> > - * the task's current CPU is heavily pressured.
> > - */
> > -static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
> > +/* Check if the rq has a misfit task */
> > +static inline bool check_misfit_status(struct rq *rq, struct sched_domain *sd)
> >  {
> > -       return rq->misfit_task_load &&
> > -               (arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
> > -                check_cpu_capacity(rq, sd));
> > +       if (!rq->misfit_task_load)
> > +               return false;
> 
> I think that only the above is enough ...
> 
> > +
> > +       /* Can we migrate to a CPU with higher capacity? */
> > +       if (arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity)
> 
> because rq->misfit_task_load is set to 0 if
> arch_scale_cpu_capacity(rq->cpu) == rq->rd->max_cpu_capacity
> 
> That would also mean that we don't need to keep and set
> rd->max_cpu_capacity anymore as we remove the 2 uses of it

+1

I'll drop max_cpu_capacity as a new patch on top

> 
> > +               return true;
> > +
> > +       /* Is the task's CPU being heavily pressured? */
> > +       return check_cpu_capacity(rq, sd);
> 
> and this one has already been tested in nohz_balancer_kick() before
> calling check_misfit_status()

Yes, removed.

I realized that I wanted to also add a new patch to not double balance_interval
for misfit failures. I think you indicated that seems the right thing to do?


Thanks

--
Qais Yousef

