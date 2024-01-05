Return-Path: <linux-kernel+bounces-17445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 538C7824D57
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1091B2363D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6631046A1;
	Fri,  5 Jan 2024 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQkq4o03"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA08440E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 03:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d41a32effso32635e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 19:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704424369; x=1705029169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EndxmtN5mdLxKFkfSjxzwXON5YmPyFpXjpvB27e2PO4=;
        b=VQkq4o03ZLO76tMbvTo5aAkiv9DogLYtJRdy6C3mFdamOSWnn00BKvLuAmI4LPYprz
         37YK4j18sH2Y5H3ZFSDBSSRq9Gcuv4P9UQQnVM/cFv8fVyJt0M2O476d9fFV6Ko9CSTS
         pSNjOaKtsN+Jb78WfYN9nIy7WTaLdJttjmsYgBBvJMtYNxrUy7I+q6oyj0MaEdtLE5TR
         TrQHvg8N/sFM4r5LjzVzTvnIxQJwgnaxz04HWTWpkRBkfH3lyhYRqF8WDXI2LYiADC4Z
         TGHT8hXulcn34ZdgUW6/MJycALRVhhy1oG2T/dw/V8vol4glO5QuKVY9N8b1NA8HGWe8
         iJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704424369; x=1705029169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EndxmtN5mdLxKFkfSjxzwXON5YmPyFpXjpvB27e2PO4=;
        b=jfgZbiTsh0MGxsJ1k/LJDQJmdeEjRzJuQ7oP4xDZgMbs+WJ7McSinhfnfCxER0//0Y
         QhLO2bPL7Oi+0Q7oDqFY0qZhnyezysAzXF/L5a5QmbLaRKL0M5fvwPN6bLcsb4DaSTpX
         YNnGcfvL2JpecKvuWO8NmFN70Rk3pZPAhmmF2k9UNqOokG/5+7bfq4tTOjodMLgnrhwA
         85S6iLsX42TCRP9BpvHMvG7/XDRbTU3/u/xoZ2eodOhnCTMxF23g4uABBYqB6QYGCq2u
         pLF6v8O7Spb62U/IPanV5cGCUFcEPEBE4+OQENI0SwDAiX7DYcZlujf/Nk7xs7chlipG
         a9Mg==
X-Gm-Message-State: AOJu0Yw10tONi1CxpA/XdlQA1GLSCJULEuCFwPWJY3LAOkyh9qYajjQs
	Cx7qSGgWpI+5UCc8JwnUupZvcqCwkCbS1KjnXJb0eavSsDw=
X-Google-Smtp-Source: AGHT+IFCiGNsgaO5T5VeB+YIf0Lap4ZPMdYkekSR5KAKAIJ4EM46egEm20NGRj+Kh5vuZMjGh0xPrU0r8ZvCyjP056A=
X-Received: by 2002:a05:600c:3208:b0:40e:35d0:1fef with SMTP id
 r8-20020a05600c320800b0040e35d01fefmr48468wmp.1.1704424369326; Thu, 04 Jan
 2024 19:12:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-22-jstultz@google.com>
 <4a137164-0a4a-4f7e-806e-ef532fa86ece@arm.com>
In-Reply-To: <4a137164-0a4a-4f7e-806e-ef532fa86ece@arm.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 4 Jan 2024 19:12:36 -0800
Message-ID: <CANDhNCq4kOCbMn9Pj2jtQUHofzG8qX6u8DFNc-hqas=tBxPWDw@mail.gmail.com>
Subject: Re: [PATCH v7 21/23] sched: Add find_exec_ctx helper
To: Metin Kaya <metin.kaya@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 3:57=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
> On 20/12/2023 12:18 am, John Stultz wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 0c212dcd4b7a..77a79d5f829a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3896,6 +3896,48 @@ static void activate_blocked_entities(struct rq =
*target_rq,
> >       }
> >       raw_spin_unlock_irqrestore(&owner->blocked_lock, flags);
> >   }
> > +
> > +static inline bool task_queued_on_rq(struct rq *rq, struct task_struct=
 *task)
> > +{
> > +     if (!task_on_rq_queued(task))
> > +             return false;
> > +     smp_rmb();
> > +     if (task_rq(task) !=3D rq)
> > +             return false;
> > +     smp_rmb();
> > +     if (!task_on_rq_queued(task))
> > +             return false;
>
> * Super-nit: we may want to have empty lines between `if` blocks and
> before/after `smp_rmb()` calls.

Done.

> * I did not understand why we call `task_on_rq_queued(task)` twice.
> Should we have an explanatory comment before the function definition?

Yeah. I'll put a better comment on my todo there.

> > diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
> > index 15e947a3ded7..53be78afdd07 100644
> > --- a/kernel/sched/cpupri.c
> > +++ b/kernel/sched/cpupri.c
> > @@ -96,12 +96,17 @@ static inline int __cpupri_find(struct cpupri *cp, =
struct task_struct *p,
> >       if (skip)
> >               return 0;
> >
> > -     if (cpumask_any_and(&p->cpus_mask, vec->mask) >=3D nr_cpu_ids)
> > +     if ((p && cpumask_any_and(&p->cpus_mask, vec->mask) >=3D nr_cpu_i=
ds) ||
> > +         (!p && cpumask_any(vec->mask) >=3D nr_cpu_ids))
> >               return 0;
> >
> >       if (lowest_mask) {
> > -             cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
> > -             cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
> > +             if (p) {
> > +                     cpumask_and(lowest_mask, &p->cpus_mask, vec->mask=
);
> > +                     cpumask_and(lowest_mask, lowest_mask, cpu_active_=
mask);
> > +             } else {
> > +                     cpumask_copy(lowest_mask, vec->mask);
> > +             }
>
> I think changes in `cpupri.c` should be part of previous (`sched: Push
> execution and scheduler context split into deadline and rt paths`)
> patch. Because they don't seem to be related with find_exec_ctx()?

So, it's here only because find_exec_ctx() can return null, so we have
to have the null p checks.

I'll think a bit if we can avoid it here.

> > @@ -2169,12 +2175,17 @@ static int find_later_rq(struct task_struct *sc=
hed_ctx, struct task_struct *exec
> >   /* Locks the rq it finds */
> >   static struct rq *find_lock_later_rq(struct task_struct *task, struct=
 rq *rq)
> >   {
> > +     struct task_struct *exec_ctx;
> >       struct rq *later_rq =3D NULL;
> >       int tries;
> >       int cpu;
> >
> >       for (tries =3D 0; tries < DL_MAX_TRIES; tries++) {
> > -             cpu =3D find_later_rq(task, task);
> > +             exec_ctx =3D find_exec_ctx(rq, task);
> > +             if (!exec_ctx)
> > +                     break;
> > +
> > +             cpu =3D find_later_rq(task, exec_ctx);
> >
>
> Super-nit: this empty line should be removed to keep logically connected
> lines closer.

Done.


> > +#ifdef CONFIG_SCHED_PROXY_EXEC
> > +struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p=
);
> > +#else /* !CONFIG_SCHED_PROXY_EXEC */
> > +static inline
> > +struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p=
)
> > +{
> > +     return p;
> > +}
> > +#endif /* CONFIG_SCHED_PROXY_EXEC */
> >   #endif
>
> Nit: `#ifdef CONFIG_SMP` block becomes bigger after this hunk. We should
> append `/* CONFIG_SMP */` to this line, IMHO.
>

Done.

Thanks for the feedback!
-john

