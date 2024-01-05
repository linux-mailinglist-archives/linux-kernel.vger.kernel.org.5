Return-Path: <linux-kernel+bounces-17345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3C5824BFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AC11F22F10
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B8E538D;
	Fri,  5 Jan 2024 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3GWR6bCA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140095243
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d3102d5d6so24145e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 16:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704412929; x=1705017729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHXMgAaiDvuCEzzjXysTUSyo+GMj9feMZFgLfjlT7GE=;
        b=3GWR6bCAq66TTVzdKEKjBYK02rGjagn5O/rHZNyILgGfZyf/GA7sQahxQIs6cfg5Ji
         FWIaNYc2vFWwDTUqkIE7gd3oHRN+fjBV5lle661cY5UTvRkdzsjr57OYQXVbBfHQswDk
         VCa3pABkKn43+2aNMh/JfWdBm0P+IBpnK9e00VNvAr1WHaofVyhexOFg+SF66Zb15bjO
         nLv0XZ9ZwrUlDi8EssT+G6c6YXz4lqpAQzbDFS89Upi6vsSyv4lF6iKibiz4zP/yDw5L
         gOKyvooA7h2WwnhEVFVzkPM/RU1Fe3x2dlp1wM92vyc0vIk2Z8w2ADCD21U1ddewU+wf
         qUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704412929; x=1705017729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHXMgAaiDvuCEzzjXysTUSyo+GMj9feMZFgLfjlT7GE=;
        b=nEMwjhXiCHgl76A9XkbcgMM4BFZqmdQoPhcqJurLOLjDqYS5IDbYaBogqbOU3dyGw2
         x7WNOFce99YVP0Yrrftc2j3UN6I9nFJ25PGNvQ3e0jneEBnBjT2XAJlc06erkDSYi7iR
         hecJ75yTOZ1c4cJ6XqafhxQ6Ylv9GV73qzfz+FOfRhT98sBrJTU4tWWtfCEObOeWWXMX
         ufaHHM8rI6TmzFxY9eOLKK7mSnP2W3MDSuzO69j5eWW+rnC8YGZySHAEm6gcajerBJ2N
         86wgEBDJtIFAiuSuHpzlnRKAapVZZbqiOaMbksUR93scwPy0hl7eMWntZxKl7Ko1F44p
         C1eg==
X-Gm-Message-State: AOJu0YyZJyEC33EHF1OD6Upz66suqt/ggbgjH1OZPI7nAkv11+yMjqXc
	ZxO88VkHgZbg4giofegZ2+jG5SbRzO76vpsXWtLGOKNgl/8=
X-Google-Smtp-Source: AGHT+IEOmqOOVuHT0+nROpxcqte5fU7rp7PWQHaROvRbfp6SGobElTdaGHCQtRNyzU0KUSwO7zyu0xU9DCGtGEjlQYI=
X-Received: by 2002:a05:600c:3546:b0:40d:8496:449b with SMTP id
 i6-20020a05600c354600b0040d8496449bmr61966wmq.4.1704412929202; Thu, 04 Jan
 2024 16:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-21-jstultz@google.com>
 <5e57c957-724a-410b-8137-88fd9bbd10d9@arm.com>
In-Reply-To: <5e57c957-724a-410b-8137-88fd9bbd10d9@arm.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 4 Jan 2024 16:01:56 -0800
Message-ID: <CANDhNCovyXRswmHA0dwNve32HUxiAQmExR+ALadzDQaATVj0nA@mail.gmail.com>
Subject: Re: [PATCH v7 20/23] sched: Push execution and scheduler context
 split into deadline and rt paths
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

On Fri, Dec 22, 2023 at 3:33=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
>
> On 20/12/2023 12:18 am, John Stultz wrote:
> > From: Connor O'Brien <connoro@google.com>
> >
> > In preparation for chain migration, push the awareness
> > of the split between execution and scheduler context
> > down into some of the rt/deadline code paths that deal
> > with load balancing.
> >
> > This patch was broken out from a larger chain migration
> > patch originally by Connor O'Brien.
> >
>
> Nit: Commit header is too long. ` paths` can be dropped.

Done.

> > @@ -2079,25 +2079,25 @@ static struct task_struct *pick_earliest_pushab=
le_dl_task(struct rq *rq, int cpu
> >
> >   static DEFINE_PER_CPU(cpumask_var_t, local_cpu_mask_dl);
> >
> > -static int find_later_rq(struct task_struct *task)
> > +static int find_later_rq(struct task_struct *sched_ctx, struct task_st=
ruct *exec_ctx)
>
> Nit: line becomes too long. Same for find_later_rq()'s signature above
> as well as find_lowest_rq() in rt.c.

While I do try to keep things under 80 where I can, it's no longer the stan=
dard:
https://lore.kernel.org/lkml/20120203100743.GA3334@elte.hu/

> >
> > -     if (task->nr_cpus_allowed =3D=3D 1)
> > +     if (exec_ctx && exec_ctx->nr_cpus_allowed =3D=3D 1)
>
> Can exec_ctx be NULL? If so, we may hit a seg. fault at
> task_rq(exec_ctx) below.

Oh, this is a bad split on my part. Only after find_exec_ctx() is
introduced can the exec_ctx be null.
I'll move that change to later in the series.

thanks
-john

