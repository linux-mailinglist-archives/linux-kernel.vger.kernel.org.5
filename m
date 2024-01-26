Return-Path: <linux-kernel+bounces-39527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEA183D259
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8BC290B09
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EB910FF;
	Fri, 26 Jan 2024 02:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="eU4HWPIS"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF51864
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706234868; cv=none; b=UliFOVbEQ/VH4INqhszjKpiiCWArV1gEuswVbch7Sx6YFhlwioN87AjED+xFz+Vo6WVprTVSTE8hZya7NxQ2ngA2xn+MfySBNvjLMHUtOsskXVR5wK9oLFqU+gaf2yPin4LCzEljiumiFZBnWsMRfqBZrzUBt/mOJfvfDi08vU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706234868; c=relaxed/simple;
	bh=RvWIssO7vIhhMuzPS+/QPRWKpWFJACtN54ADk5nG6oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUDgR3PZcalhTHmWDNRrhJMZ8dG6Rl7GL4pV8cAuizLfcSyPTeORQfPS5SAjm46vNP3C3y8eUIWe/dvOy17oEE5arc4rMSz7PELpatDBy1IO9c0WkAk/a/klaPsKtf7vhxHQkYOrfI8CrN7tDH7mJE9i3gVG0k600OuClRKe6M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=eU4HWPIS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e800461baso88143875e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706234865; x=1706839665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X9ABcwaj9pRxLGfFLM2Qo2JU9NVkyveoFBP4wyc2NU0=;
        b=eU4HWPISLGa50++bdPIl8xKZW5+dETbLu5/HwO273hyGHYgGQeK0Q9pzmzbPJ2JZOT
         k5sQV63rfgpnZYfDSsxxs9TqI1XfD6xi2YN5MxETzD/E6x/xvA1BA6q9CwqaojtjUTIC
         pRqRtpP3FvUgysEsL+La82iW8RZKmmq0llh8ddxjEhOl4dmoJq33nwIzL9M9dSsL/QqK
         zeRmvWUZuLPmbxDDm0PbEK5dLXHx2Fgcy9i+atbd8brEDGW4vOeoduw8uq5M1lqGz8jc
         2KvfL/dApmy2nAgJThbov5TTGrVPp9J/gi6bisoX5trSgdxhXCWJ7pzcQ7e+RcX6F22A
         GXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706234865; x=1706839665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9ABcwaj9pRxLGfFLM2Qo2JU9NVkyveoFBP4wyc2NU0=;
        b=p3QDDw461HIim85+NJ7Z6L/jiD1xMpIgflGDJj+hK63YUjjiySkZxuXem2Ap2kcGN6
         TFsETdmddGw0sxDp/1CUlC6G5rZ78Mwsfrk92f+BtBNBTdc9JWQfu0OS9Twmg4/3y67l
         C4m20HkzdVDimYnsT8xVY65JMV5VsMLt1SWzV1q2GeRS0FPIiFNp+mQUrHk0giupmy/V
         cGVwJA9WqKQvaoDnD8FvqoZM5T385kSrjuoT+AYXvmC468KCDwumQisfjMhb4mzKt0d6
         2WnZ9pHz4psJt0cHxQXm/z4NZx81TYjX1Pl7gwGsiPUwmGGSbU9Y4+jN+5qvxyoOQ44D
         yozw==
X-Gm-Message-State: AOJu0YzPnK4MXgSk08XpbMlB3ACughwrhqDhf9/f88hRAec1F1Rf/6+v
	rb2KH81tPQBGBMcJxtxLDj2m6CTXI2+mfqnkZtSJh12KVS0NmJ8Q6TDK5WUHxpE=
X-Google-Smtp-Source: AGHT+IG8F5HRKcetIDcDdLRqf11DbwHNS6RKUSuzHlKxC2loN6glzc7UdFZG7rlktC7EBqlclV/PkA==
X-Received: by 2002:a05:600c:5006:b0:40e:cd03:1d5 with SMTP id n6-20020a05600c500600b0040ecd0301d5mr200683wmr.113.1706234865183;
        Thu, 25 Jan 2024 18:07:45 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id o37-20020a05600c512500b0040d5c58c41dsm416252wms.24.2024.01.25.18.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 18:07:44 -0800 (PST)
Date: Fri, 26 Jan 2024 02:07:43 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240126020743.tca257nvnlpyya2y@airbuntu>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBTbudKM3Lxv0dQ4EXchLW9G8LszArzp6phzhND4O7XSw@mail.gmail.com>
 <20240124223842.zjsolwhp26w7vowu@airbuntu>
 <CAKfTPtAHQ9vJK_GZdpDC3GzHYWnzLc9USFNW9LSONcWVxybwrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAHQ9vJK_GZdpDC3GzHYWnzLc9USFNW9LSONcWVxybwrA@mail.gmail.com>

On 01/25/24 18:50, Vincent Guittot wrote:
> On Wed, 24 Jan 2024 at 23:38, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 01/23/24 18:22, Vincent Guittot wrote:
> >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index bcea3d55d95d..0830ceb7ca07 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -5065,17 +5065,61 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
> > > >
> > > >  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> > > >  {
> > > > +       unsigned long uclamp_min, uclamp_max;
> > > > +       unsigned long util, cpu_cap;
> > > > +       int cpu = cpu_of(rq);
> > > > +
> > > >         if (!sched_asym_cpucap_active())
> > > >                 return;
> > > >
> > > > -       if (!p || p->nr_cpus_allowed == 1) {
> > > > -               rq->misfit_task_load = 0;
> > > > -               return;
> > > > -       }
> > > > +       if (!p || p->nr_cpus_allowed == 1)
> > > > +               goto out;
> > > >
> > > > -       if (task_fits_cpu(p, cpu_of(rq))) {
> > > > -               rq->misfit_task_load = 0;
> > > > -               return;
> > > > +       cpu_cap = arch_scale_cpu_capacity(cpu);
> > > > +
> > > > +       /* If we can't fit the biggest CPU, that's the best we can ever get. */
> > > > +       if (cpu_cap == SCHED_CAPACITY_SCALE)
> > > > +               goto out;
> > > > +
> > > > +       uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> > > > +       uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> > > > +       util = task_util_est(p);
> > > > +
> > > > +       if (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0)
> > > > +               goto out;
> > > > +
> > > > +       /*
> > > > +        * If the task affinity is not set to default, make sure it is not
> > > > +        * restricted to a subset where no CPU can ever fit it. Triggering
> > > > +        * misfit in this case is pointless as it has no where better to move
> > > > +        * to. And it can lead to balance_interval to grow too high as we'll
> > > > +        * continuously fail to move it anywhere.
> > > > +        */
> > > > +       if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {
> > > > +               unsigned long clamped_util = clamp(util, uclamp_min, uclamp_max);
> > > > +               bool has_fitting_cpu = false;
> > > > +               struct asym_cap_data *entry;
> > > > +
> > > > +               rcu_read_lock();
> > > > +               list_for_each_entry_rcu(entry, &asym_cap_list, link) {
> > >
> > > Do we really want to potentially do this loop at every pick_next task ?
> >
> > The common case should return quickly as the biggest CPU should be present
> > in every task by default. And after sorting the biggest CPU will be the first
> > entry and we should return after one check.
> >
> > Could we move the update to another less expensive location instead?
> 
> TBH, I don't know. I would need time to think about this...
> May be when we set the new affinity of the task

I was thinking to actually call update_misfit_status() from another less
expensive location.

We can certainly do something to help the check less expensive if we must do it
in pick_next_task(). For example set a flag if the task belongs to a single
capacity value; and store the highest capacity its affinity belongs too. But
with cpuset v1, v2 and hotplug I am wary that might get messy.

> 
> >
> > We could try to do better tracking for CPUs that has their affinity changed,
> > but I am not keen on sprinkling more complexity else where to deal with this.
> >
> > We could keep the status quouo and just prevent the misfit load balancing from
> > increment nr_failed similar to newidle_balance too. I think this should have
> 
> One main advantage is that we put the complexity out of the fast path

How about when we update_load_avg()? After all it's the util the decides if we
become misfit. So it makes sense to do the check when we update the util for
the task.

Which reminds me of another bug. We need to call update_misfit_status() when
uclamp values change too.

> 
> > a similar effect. Not ideal but if this is considered too expensive still
> > I can't think of other options that don't look ugly to me FWIW.
> >
> >
> > Thanks
> >
> > --
> > Qais Yousef

