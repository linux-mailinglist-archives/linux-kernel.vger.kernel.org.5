Return-Path: <linux-kernel+bounces-37761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C615983B4DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A45A28A3A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDB6135A6D;
	Wed, 24 Jan 2024 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="fcGVCah8"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851DF134750
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135927; cv=none; b=rg9mlSA2P2PG1JClXy3sjQ4ZnRdYnCqbFgleIe/ZYQWJhDve+LlWycUNxBrwd87H1JPCq1qYaslGzm4YvMuFjNI6JJ6Dkc17Fp0L2mJN46Y5H9E5cpCLoVviO031paa1FqpKfBZ/LUICH2+fqOSzVfxPQDswbuFJQ5rr2gI3gHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135927; c=relaxed/simple;
	bh=xjeJlV55+kPHUU5TbYsfmkt4Ye/0S6xdDaU/VwH/rko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8MVg8rs47SzgyNwoQ3HjFwLeHB797QKG62Mu1FVWsy/UP7ZC0YFu4LBhm/jctgh4qIWDBB0hr+ryMul/zieCZqT61GQHJJUoSp3HIr47LXgybXL01FbYyGLOVU0lv2M9xneAAav1bfc33cjkptB5D6nMRpsaBHM85NPxPFWQsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=fcGVCah8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40ece18638fso2238285e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706135923; x=1706740723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lzjx1bk00QTl7T0INBKVmgz2bdGhTs7haxC4/89GTjA=;
        b=fcGVCah8otFYwboL/xYWVgVAD3xGVP2UQLD1kMZGhZjwyWsooH167JuTJljIYUecCI
         IEGsBGahqZmaU38gGaAMeAMlz0drhBdfRRDuCqjDhXrox6H5lMEAW+YIwOBP/Ti92WZo
         TjPaUGV+cd/odHjhG4DcKa/+R+FTMTuUecmI7xDEYunTI+36qag1NqIZ4HJ56yaQMNUN
         2F+ooK8HP9S+TNLLQXeuCIowzGHHt34dogJ0s9xu5sYTfksSr3nvXX6uncf+kAYOn3bA
         mELF9oCkuG9+vIRWa/djswaKTxQwYjsaX3qcXswdq1pvo/k8y8SXtu6Vba6xP5xFb+Am
         gFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706135923; x=1706740723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lzjx1bk00QTl7T0INBKVmgz2bdGhTs7haxC4/89GTjA=;
        b=HJ943VywOOFQhz3sFtda3+0ZWV08+IZAZL7EKgU300pXkMJG04z+yUMKb3mnsdmwt1
         KyQAS2dQiYmJhPS7LPbjttPKDKnzblIqH5BSQKgZu/kHv8RzHPSWvUdoQTL/MyiAcBse
         FTIyoz7cncv5dytsKhk9zj4CLIicGgOtjWKeRKJnUv8RWgkh2lXW6PlQeS0s/AERBiVJ
         qbu7iVEWPMH52gBSgGpMpx27WRauk6wLwYkM0UNjfocfe18a3/nvyh2ZD2OWP1TeC2kc
         goy3toRm47cP9w8jLkOs4S6OBR+LTAy8C22DTZCPY1D4T6aZ0IIPO7iiS7cBMCgpJw73
         2+vQ==
X-Gm-Message-State: AOJu0Yyktu65K4425TYsvCoJrRJwMt56QuL51oPZ2lhE4j+VhBa6x6qO
	v/PvPX20cGmj5bJbN9m/ZODPKj1LV+kx6ddGKISGkgnW6upb/0ZcBtabcV2eUxY=
X-Google-Smtp-Source: AGHT+IHlcl13KTHwkOTr9igfdgcOupv0gL0ONh9LvtU3R327wDiNXFqp6hH77jC4GxwRmzmkYe9bAQ==
X-Received: by 2002:a05:600c:1c98:b0:40e:50ac:d24e with SMTP id k24-20020a05600c1c9800b0040e50acd24emr2162428wms.13.1706135923674;
        Wed, 24 Jan 2024 14:38:43 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c155000b0040ebf5956absm449116wmg.29.2024.01.24.14.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:38:43 -0800 (PST)
Date: Wed, 24 Jan 2024 22:38:42 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240124223842.zjsolwhp26w7vowu@airbuntu>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBTbudKM3Lxv0dQ4EXchLW9G8LszArzp6phzhND4O7XSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBTbudKM3Lxv0dQ4EXchLW9G8LszArzp6phzhND4O7XSw@mail.gmail.com>

On 01/23/24 18:22, Vincent Guittot wrote:

> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index bcea3d55d95d..0830ceb7ca07 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5065,17 +5065,61 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
> >
> >  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> >  {
> > +       unsigned long uclamp_min, uclamp_max;
> > +       unsigned long util, cpu_cap;
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
> > +       cpu_cap = arch_scale_cpu_capacity(cpu);
> > +
> > +       /* If we can't fit the biggest CPU, that's the best we can ever get. */
> > +       if (cpu_cap == SCHED_CAPACITY_SCALE)
> > +               goto out;
> > +
> > +       uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> > +       uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> > +       util = task_util_est(p);
> > +
> > +       if (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0)
> > +               goto out;
> > +
> > +       /*
> > +        * If the task affinity is not set to default, make sure it is not
> > +        * restricted to a subset where no CPU can ever fit it. Triggering
> > +        * misfit in this case is pointless as it has no where better to move
> > +        * to. And it can lead to balance_interval to grow too high as we'll
> > +        * continuously fail to move it anywhere.
> > +        */
> > +       if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {
> > +               unsigned long clamped_util = clamp(util, uclamp_min, uclamp_max);
> > +               bool has_fitting_cpu = false;
> > +               struct asym_cap_data *entry;
> > +
> > +               rcu_read_lock();
> > +               list_for_each_entry_rcu(entry, &asym_cap_list, link) {
> 
> Do we really want to potentially do this loop at every pick_next task ?

The common case should return quickly as the biggest CPU should be present
in every task by default. And after sorting the biggest CPU will be the first
entry and we should return after one check.

Could we move the update to another less expensive location instead?

We could try to do better tracking for CPUs that has their affinity changed,
but I am not keen on sprinkling more complexity else where to deal with this.

We could keep the status quouo and just prevent the misfit load balancing from
increment nr_failed similar to newidle_balance too. I think this should have
a similar effect. Not ideal but if this is considered too expensive still
I can't think of other options that don't look ugly to me FWIW.


Thanks

--
Qais Yousef

