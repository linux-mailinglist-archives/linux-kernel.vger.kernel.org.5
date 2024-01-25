Return-Path: <linux-kernel+bounces-39054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D43DF83CA4C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB652964DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E53B131E45;
	Thu, 25 Jan 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZ/jIlB6"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1048745C6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205059; cv=none; b=H81Tbg4z9aV0apBB5jHpPqFHdDysaZZKN2XXlh7AYWW7LF86YrPzynMsr5ffp5xP1tZpArf6Jx4mJ3qanCUVMm1NIMzkKehhv/u8LxdnkEWWywYy4UuUTL8RK2bRB3JjFkM6gcFy9EGs2aAXmbp4uq1JklesGNkIg6XhKDLAnos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205059; c=relaxed/simple;
	bh=1a3djzn55o0abdOiXCF9lMFEutrQcKQdsoBJMKOR6t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7AP82IMN0MJcIO6/q+D3LwuQUDQf0cU0QSnMVSosIFkPeFFMVQacilkqMRdOQWFDUzb5Wy3c1zutBfOfOq0mo3qWqtjRAF6jCEYM8bA1UFd3FV8B7FFIAABuI6H7O6ngXtlMIHhT8QAlRokpInim7a1xQqODw7vW0/cgaNCWyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QZ/jIlB6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ddc1b30458so1754395b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706205057; x=1706809857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GTyiAxP1QXCLMjkb5pwNhnS8PsC4Jr8fZaD0Ip1sTfc=;
        b=QZ/jIlB6mVQgPmY0u79oxFVoB4uTBcip9bKiwdJyAQ7bJqplL+hg6Rrt54MEwV9Pm3
         w++nCRyvHNXkOhnBYLR0Q+4QWnbfc+gCgZqBL6OXejsEgurBAIm31k2htJgzSQZaDDMf
         SutdyAWw9wWe+8JylJuFjJyKtP++YRdPTuOmtq58DZo0ueQ2yqCFhe/U9cI8c4fR3/E5
         QCEN3bTc4cenOyhZ1gwUquV+DMBkdxAO74Gwz5rItLA/u3i1glSg0gxnOroHv+nZQezA
         7+mGT68KYZ7rFyAtSZRX4XSzi3ldiA/YctgEIiM4xSZB8+ZkluZrSezg55mdYDougT3X
         //IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706205057; x=1706809857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTyiAxP1QXCLMjkb5pwNhnS8PsC4Jr8fZaD0Ip1sTfc=;
        b=wNqpFz8YjAdmYlkSGLS/lTpVhAOr+a5dp9f9IESbpeXf2G8vvcDHKcz8KEmxWdgErM
         H2OGvs+GVI6EtLrjsLsvTjAzdgSFDSOxIo2GVSsI1RK8Cqeg7brl0WK8nCbKW0F36N64
         bP9VkKXYqUASrsJ3KdHFagwr7GN3YO28YUX6NX17W9Zi7rZCHHKuJe6xjOrLc6/rT6u1
         hiiCfzY2uh63eYAludn7/OoIMagDwS/Ihi5z2ytWwp7ay0uRy414TBO1/eIMy7J745HE
         9P4oGiQMzIvR8Cq0lCCipi7Rzi/yruOBRaQQsZR6hozRWb3OpMsJ9Se4d0cfDBw8B5rU
         23hw==
X-Gm-Message-State: AOJu0Yxh3KFVKevDTpom9dK3gL8rUpEnFqHGREs+JQSa/zJlaX9cG8BZ
	Y3wzv/Dda/GytanOLwx5QZJY8yCu8Iz1scc/R8F18pQ6YrLRJniSX5ZnxUIa9V9wUzMZ11yMzz8
	HXMP5QTqUjeX945f4Tz8RYQNS7VOSmgNOn5C7eIW+Vc5XIyp9
X-Google-Smtp-Source: AGHT+IG5fM+0aRzZN0pKmc7Nfftd2PurAivebP8eDRavugwa+0wu21jU1OtM2gHnuWM2UClEYcLrKIuNt8kNHivMMjw=
X-Received: by 2002:a05:6a00:22c6:b0:6dc:c49e:a7b6 with SMTP id
 f6-20020a056a0022c600b006dcc49ea7b6mr66892pfj.65.1706205057107; Thu, 25 Jan
 2024 09:50:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105222014.1025040-1-qyousef@layalina.io> <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBTbudKM3Lxv0dQ4EXchLW9G8LszArzp6phzhND4O7XSw@mail.gmail.com> <20240124223842.zjsolwhp26w7vowu@airbuntu>
In-Reply-To: <20240124223842.zjsolwhp26w7vowu@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 25 Jan 2024 18:50:46 +0100
Message-ID: <CAKfTPtAHQ9vJK_GZdpDC3GzHYWnzLc9USFNW9LSONcWVxybwrA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 23:38, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/23/24 18:22, Vincent Guittot wrote:
>
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index bcea3d55d95d..0830ceb7ca07 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -5065,17 +5065,61 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
> > >
> > >  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> > >  {
> > > +       unsigned long uclamp_min, uclamp_max;
> > > +       unsigned long util, cpu_cap;
> > > +       int cpu = cpu_of(rq);
> > > +
> > >         if (!sched_asym_cpucap_active())
> > >                 return;
> > >
> > > -       if (!p || p->nr_cpus_allowed == 1) {
> > > -               rq->misfit_task_load = 0;
> > > -               return;
> > > -       }
> > > +       if (!p || p->nr_cpus_allowed == 1)
> > > +               goto out;
> > >
> > > -       if (task_fits_cpu(p, cpu_of(rq))) {
> > > -               rq->misfit_task_load = 0;
> > > -               return;
> > > +       cpu_cap = arch_scale_cpu_capacity(cpu);
> > > +
> > > +       /* If we can't fit the biggest CPU, that's the best we can ever get. */
> > > +       if (cpu_cap == SCHED_CAPACITY_SCALE)
> > > +               goto out;
> > > +
> > > +       uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> > > +       uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> > > +       util = task_util_est(p);
> > > +
> > > +       if (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0)
> > > +               goto out;
> > > +
> > > +       /*
> > > +        * If the task affinity is not set to default, make sure it is not
> > > +        * restricted to a subset where no CPU can ever fit it. Triggering
> > > +        * misfit in this case is pointless as it has no where better to move
> > > +        * to. And it can lead to balance_interval to grow too high as we'll
> > > +        * continuously fail to move it anywhere.
> > > +        */
> > > +       if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {
> > > +               unsigned long clamped_util = clamp(util, uclamp_min, uclamp_max);
> > > +               bool has_fitting_cpu = false;
> > > +               struct asym_cap_data *entry;
> > > +
> > > +               rcu_read_lock();
> > > +               list_for_each_entry_rcu(entry, &asym_cap_list, link) {
> >
> > Do we really want to potentially do this loop at every pick_next task ?
>
> The common case should return quickly as the biggest CPU should be present
> in every task by default. And after sorting the biggest CPU will be the first
> entry and we should return after one check.
>
> Could we move the update to another less expensive location instead?

TBH, I don't know. I would need time to think about this...
May be when we set the new affinity of the task

>
> We could try to do better tracking for CPUs that has their affinity changed,
> but I am not keen on sprinkling more complexity else where to deal with this.
>
> We could keep the status quouo and just prevent the misfit load balancing from
> increment nr_failed similar to newidle_balance too. I think this should have

One main advantage is that we put the complexity out of the fast path

> a similar effect. Not ideal but if this is considered too expensive still
> I can't think of other options that don't look ugly to me FWIW.
>
>
> Thanks
>
> --
> Qais Yousef

