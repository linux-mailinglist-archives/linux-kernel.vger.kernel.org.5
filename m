Return-Path: <linux-kernel+bounces-17455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C618824D80
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CA6284A8A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554246A1;
	Fri,  5 Jan 2024 03:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIWKHwj3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E4440E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 03:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d3102d5d6so30585e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 19:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704426168; x=1705030968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evY0bxwNE7Ez1nP2kXiW7lsAJLgfxlGO2JEqzZzC4RM=;
        b=tIWKHwj3YPrQ2Tqqk36XdKMzONXvnZ/lRrsLRiQjsXJBbwg0UBxqXOAs9cJK8YjDv/
         I5dk/YlBiPvmYW0QYKW2QXaqj+a/Fe/XFbbH0ynAYBrY9PrKBgFMRjSm8VjC2JizCDIb
         ZNLUiAXCJ2vlbCIaKzToZHP75N5jdY7ltcrktNJzE8jJHklFA0zygnkI9R9xY4g5spsz
         FJc1HHLqNYW1QgGFLCvbjLOoeQan9+d8nWMKNQYOv1FvXLk3EMrjGM0Gj9BosYxXHAFL
         NCxoheK1+tQuThMceuRVeCPocRZOjaz2NRzL4igRAiGhFEcM7hpGiKaLQK96KreOS9qK
         SLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704426168; x=1705030968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evY0bxwNE7Ez1nP2kXiW7lsAJLgfxlGO2JEqzZzC4RM=;
        b=q8lH02QB5z4nfPd5evehV5fNAz4FFxpe4hKcOT8GQJDLuh859wOiq2Y1c6DbE7/+Xa
         WANd3LqTp+JCZ5KE24G+h0u2M8wqUo7pTpgN1Z9ZT98XWBLdyQNdAWNzr8PQnkf5Gt8D
         jVlKe6upGojGfJ/RHfvOic1vhiF1/bIa3sngb5RtuhwWLvcI+EmzosHTN8tGa/al5GOL
         GUbLQMFAWghrJ09uK092E02KsjxwSqrakNEHKtZVLz8xMsBM1iMOWZ/PmAbjciKcdaZA
         e4wMH/vJm20qo8xLqrCr0u/V+LJqIsTx0NxHgE61WBo41luqdVk9Of8uy8UEI9UDG8BQ
         5+3Q==
X-Gm-Message-State: AOJu0YxHxSBzrNrAFgcVMW231aGYmmltklxlZvAEVF9LiVji32LbaIUV
	tT/TI6ap0i0oOOies8p0thZYkvHGYxdF2xDVLgvCRYY3pYM=
X-Google-Smtp-Source: AGHT+IHNn4DJrbgfHl7woJK+opjfG8BibCib3fT3VMMrDiRz6oQs/BwVMjwGgHrk4x/yLOlkvYYzHmWJhYJONCmn2qo=
X-Received: by 2002:a05:600c:3c99:b0:40e:3540:54b8 with SMTP id
 bg25-20020a05600c3c9900b0040e354054b8mr49897wmb.3.1704426167820; Thu, 04 Jan
 2024 19:42:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-24-jstultz@google.com>
 <8001a9bc-3f87-403c-a091-215c56c9ebf0@arm.com>
In-Reply-To: <8001a9bc-3f87-403c-a091-215c56c9ebf0@arm.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 4 Jan 2024 19:42:34 -0800
Message-ID: <CANDhNCpqjiUi4iKKKXH8PLtUKe2JTJdt8W=7CQ6VJi409+RaEw@mail.gmail.com>
Subject: Re: [PATCH v7 23/23] sched: Fix rt/dl load balancing via chain level balance
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

On Fri, Dec 22, 2023 at 6:51=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
> On 20/12/2023 12:18 am, John Stultz wrote:
> > +     /*
> > +      * Chain leads off the rq, we're free to push it anywhere.
> > +      *
> > +      * One wrinkle with relying on find_exec_ctx is that when the cha=
in
> > +      * leads to a task currently migrating to rq, we see the chain as
> > +      * pushable & push everything prior to the migrating task. Even i=
f
> > +      * we checked explicitly for this case, we could still race with =
a
> > +      * migration after the check.
> > +      * This shouldn't permanently produce a bad state though, as prox=
y()
>
>                                                         find_proxy_task()

Fixed.

> > +#ifdef CONFIG_SCHED_PROXY_EXEC
> >   static inline bool dl_revalidate_rq_state(struct task_struct *task, s=
truct rq *rq,
> > -                                       struct rq *later)
> > +                                       struct rq *later, bool *retry)
> > +{
> > +     if (!dl_task(task) || is_migration_disabled(task))
> > +             return false;
> > +
> > +     if (rq !=3D this_rq()) {
> > +             struct task_struct *next_task =3D pick_next_pushable_dl_t=
ask(rq);
> > +
> > +             if (next_task =3D=3D task) {
>
> Nit: We can `return false;` if next_task !=3D task and save one level of
> indentation.

Ah, good point. Fixed.

> > +                     struct task_struct *exec_ctx;
> > +
> > +                     exec_ctx =3D find_exec_ctx(rq, next_task);
> > +                     *retry =3D (exec_ctx && !cpumask_test_cpu(later->=
cpu,
> > +                                                            &exec_ctx-=
>cpus_mask));
> > +             } else {
> > +                     return false;
> > +             }
> > +     } else {
> > +             int pushable =3D task_is_pushable(rq, task, later->cpu);
> > +
> > +             *retry =3D pushable =3D=3D -1;
> > +             if (!pushable)
> > +                     return false;
>
> `return pushable;` can replace above 2 lines.
> The same for rt_revalidate_rq_state().

Hrm. It does save lines, but I fret (in my estimation) it makes the
code a touch more complex to read. I might hold off on this for the
moment unless someone else pushes for it.

> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index fabb19891e95..d5ce95dc5c09 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
...
> > +#ifdef CONFIG_SCHED_PROXY_EXEC
> > +static inline bool rt_revalidate_rq_state(struct task_struct *task, st=
ruct rq *rq,
> > +                                       struct rq *lowest, bool *retry)
>
> This function can be consolidated with dl_revalidate_rq_state() as you
> noted in the previous patch, although rt_revalidate_rq_state() has few
> comments.

Yeah. I need to stare at it a bit to try to figure out what might be
the best name to use for the common chunk.
I'd also like to figure a better way to do the retry stuff, as it feels mes=
sy.

> > +{
> > +     /*
> > +      * Releasing the rq lock means we need to re-check pushability.
> > +      * Some scenarios:
> > +      * 1) If a migration from another CPU sent a task/chain to rq
> > +      *    that made task newly unpushable by completing a chain
> > +      *    from task to rq->curr, then we need to bail out and push so=
mething
> > +      *    else.
> > +      * 2) If our chain led off this CPU or to a dequeued task, the la=
st waiter
> > +      *    on this CPU might have acquired the lock and woken (or even=
 migrated
> > +      *    & run, handed off the lock it held, etc...). This can inval=
idate the
> > +      *    result of find_lowest_rq() if our chain previously ended in=
 a blocked
> > +      *    task whose affinity we could ignore, but now ends in an unb=
locked
> > +      *    task that can't run on lowest_rq.
> > +      * 3) Race described at https://lore.kernel.org/all/1523536384-26=
781-2-git-send-email-huawei.libin@huawei.com/
> > +      *
> > +      * Notes on these:
> > +      * - Scenario #2 is properly handled by rerunning find_lowest_rq
> > +      * - Scenario #1 requires that we fail
> > +      * - Scenario #3 can AFAICT only occur when rq is not this_rq(). =
And the
> > +      *   suggested fix is not universally correct now that push_cpu_s=
top() can
> > +      *   call this function.
> > +      */
> > +     if (!rt_task(task) || is_migration_disabled(task)) {
> > +             return false;
> > +     } else if (rq !=3D this_rq()) {
>
> Nit: `else` can be dropped as in dl_revalidate_rq_state().

Ack. Done.

Thanks again for all the feedback!
-john

