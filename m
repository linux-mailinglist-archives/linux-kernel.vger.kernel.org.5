Return-Path: <linux-kernel+bounces-17337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11991824BE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7123287033
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1332D609;
	Thu,  4 Jan 2024 23:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VoA3w1j0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBC32D605
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 23:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so5571a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 15:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704411859; x=1705016659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtawQTRvweP4ouCym+CPwK0RswtuFa45r31f6ygOtZ4=;
        b=VoA3w1j0/b+OTO+HoNLubsw8tKgjO+HzwRU8FDHxKVtOrj2j+25zgstFiP+OTOirtM
         Nsawtfw0WCu7DXY+s49aa5FPxoxay1G5+GmvuFw3IJ2b9cbxXwXfCPKgjlWmijFnFkJL
         QTu2auODJFjFqdzWiv8xeZKrQsXs24/DD4opmn4PSxT3q7jZzW4AJxHagbPNPhXoAsQl
         VsPokIgl7HfSb55QYhKCMG87XDNPlHjnKvq1bqaLHLM6iMWB8wBiFHdUnH8znW+6mavC
         somMECW9fdmYXCxfJd6cmu8hoftkP6RIkoD09wytsybreR7z1UBrDYjJtKFlVShtsfSO
         2IIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704411859; x=1705016659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtawQTRvweP4ouCym+CPwK0RswtuFa45r31f6ygOtZ4=;
        b=HkQmAOzxTjaH4zAZbF+7j1JfM01oBOk8upLQL5MrBE3gvJtXGR8p9XRc2Wux/+FcwI
         rsj+xnnIFgqrWaWgsRHTE/M09nc0aph1dFOL3nB7QFlII9YHC2x2SvJ8NcIGcBdZUZR5
         73C11/h4FX3A2TaCixiJjkUkLeXRQXae4rf9WeGgqtPxpJQc2h4Hgzfu9suVc3Jv4cIc
         XSb8/30K5/qtj1g9GyMy7Qdf/7+Wdt7Nvw5weVaTVseziNf1xW9cRNphBy32p+rZ3Khi
         HNc1aAxJkLQNSCy9hfHgVG5ya4YatOD2s5FhZjkwLwGwqpgwzYhGKpAfbxNIFC8KDrs+
         sTlA==
X-Gm-Message-State: AOJu0Yz6rIAOa9UO+Nx3XM1nXM/Y3crCb8DGftKXxSVBMX/RMYfK84dq
	za/Cgh96Tbr6QwMdMqMblwvNhMgACtqmhq/xwk77jHwANFI=
X-Google-Smtp-Source: AGHT+IGnAG0DbaZXUabp2gfXxJPgFgxECNOE/7kK3RH0kZs3MNepAeeeqTqwvhrG6bX8rT7bM9b0SDlz83A2rPadYEM=
X-Received: by 2002:a50:9341:0:b0:557:15d:b784 with SMTP id
 n1-20020a509341000000b00557015db784mr70347eda.2.1704411859245; Thu, 04 Jan
 2024 15:44:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-20-jstultz@google.com>
 <11171acd-dae7-475f-ab93-a890f0f0d273@arm.com>
In-Reply-To: <11171acd-dae7-475f-ab93-a890f0f0d273@arm.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 4 Jan 2024 15:44:05 -0800
Message-ID: <CANDhNCri7BCJimxvroJCecAAsag7Thcvv=2xY=xLVW6p3p=BgQ@mail.gmail.com>
Subject: Re: [PATCH v7 19/23] sched: Consolidate pick_*_task to
 task_is_pushable helper
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

On Fri, Dec 22, 2023 at 2:23=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
> On 20/12/2023 12:18 am, John Stultz wrote:
> > From: Connor O'Brien <connoro@google.com>
> >
> > This patch consolidates rt and deadline pick_*_task functions to
> > a task_is_pushable() helper
> >
> > This patch was broken out from a larger chain migration
> > patch originally by Connor O'Brien.
> >
> > Cc: Joel Fernandes <joelaf@google.com>
> > Cc: Qais Yousef <qyousef@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Zimuzo Ezeozue <zezeozue@google.com>
> > Cc: Youssef Esmat <youssefesmat@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Metin Kaya <Metin.Kaya@arm.com>
> > Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> > Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: kernel-team@android.com
> > Signed-off-by: Connor O'Brien <connoro@google.com>
> > [jstultz: split out from larger chain migration patch,
> >   renamed helper function]
> > Signed-off-by: John Stultz <jstultz@google.com>
> > ---
> > v7:
> > * Split from chain migration patch
> > * Renamed function
> > ---
> >   kernel/sched/deadline.c | 10 +---------
> >   kernel/sched/rt.c       | 11 +----------
> >   kernel/sched/sched.h    | 10 ++++++++++
> >   3 files changed, 12 insertions(+), 19 deletions(-)
> >
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index def1eb23318b..1f3bc50de678 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -2049,14 +2049,6 @@ static void task_fork_dl(struct task_struct *p)
> >   /* Only try algorithms three times */
> >   #define DL_MAX_TRIES 3
> >
> > -static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
> > -{
> > -     if (!task_on_cpu(rq, p) &&
> > -         cpumask_test_cpu(cpu, &p->cpus_mask))
> > -             return 1;
> > -     return 0;
> > -}
> > -
> >   /*
> >    * Return the earliest pushable rq's task, which is suitable to be ex=
ecuted
> >    * on the CPU, NULL otherwise:
> > @@ -2075,7 +2067,7 @@ static struct task_struct *pick_earliest_pushable=
_dl_task(struct rq *rq, int cpu
> >       if (next_node) {
> >               p =3D __node_2_pdl(next_node);
> >
> > -             if (pick_dl_task(rq, p, cpu))
> > +             if (task_is_pushable(rq, p, cpu) =3D=3D 1)
>
> Nit: ` =3D=3D 1` part is redundant, IMHO.

Indeed at this step is seems silly, but later task_is_pushable() can
return one of three states:
https://github.com/johnstultz-work/linux-dev/commit/1ebaf1b186f0cae8a4a2670=
8776b347fa47decef#diff-cc1a82129952a910fdc4292448c2a097a2ba538bebefcf3c0638=
1e45639ae73eR3973

I'm not a huge fan of this sort of magic tri-state return value, as
it's not very intuitive, so I need to spend some time to see if I can
find a better approach.

Thanks for pointing this out.
-john

