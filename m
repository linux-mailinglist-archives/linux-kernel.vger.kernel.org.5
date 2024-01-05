Return-Path: <linux-kernel+bounces-17483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57030824E12
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A7FB21C02
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE9853A2;
	Fri,  5 Jan 2024 05:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2xANKtV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6285392
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so7861a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 21:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704432015; x=1705036815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsbkFjcHd93kZLPcDQHmq9eO2vUcsoGgoefRxVn1Pxg=;
        b=p2xANKtVPI+E2phMATS7cq6ota10FCM210l6EPypVOEtA9emtg74APKwj8UfDArNNF
         I8JG7vPHRDyfbdI6v+nAd46R0+QDjYsMHFEoAbyUfKYWthsHOaR3wVJBQjZ19DVvC3Ab
         DBNY75pCyiB3mzAyWfaHDjdsYqk/ZezY1pPWc1IyEk1SJCoehZ5/v9LCTyLN/rKQMWor
         Hfs2ffhlZRX1oKuSxQiOyspi5NAnTsbVIGRJzKoM10nocY0oWq2+gup7uEpEON1nYkjC
         XTbXzE7exzSLeynlNiLNz+bL2hfycZRXFp7r+EU9qUKFwmEQ82VAhOUFucpIlqP00spJ
         Wf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704432015; x=1705036815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsbkFjcHd93kZLPcDQHmq9eO2vUcsoGgoefRxVn1Pxg=;
        b=L4/M3X3dSQL/w6dbsmohRmtM+EcxIDMBgciaiJiZyjMA8fTXrct4wmE9apprMeVrXe
         3hXyw7rHBf+oX1ptWPHo21/mprq67pvqTzWr1jRkTGhQkstZTyJe+gqRgaFvQSnVFoJ0
         16OT+WToFB2WPTJsIGn32ckK2puTLo44/9HpoaTgSAO/GEz+2kUkd2DQ8NJ0rhjq9JOd
         x6Cx6gHmAhxxGGJa629ODOKcVcussnU+gFT8cdJ+2mNukp4/JR++rt76chqOCsTSK+NW
         /MJSQ+rw2BmYQ3fOBtvGvsPesYXts9OF3JwUZQf7V+bcGIzAfeQb2uPEiidE5GQ2/ae7
         MMuw==
X-Gm-Message-State: AOJu0YxcB5Gc9yA/HXv0lB/4Zft1jmwKq/RnO19mTen8wrqIbVrSVJ3n
	1nk+uc/OsDmxH0W3agXdw7DtGSIYE555skolki2RB0GY1CXhQron5jKMxeHL
X-Google-Smtp-Source: AGHT+IGQsVXz2Qw9rvJ2hfxyn/KXQ1bk/bwDrxEzLOVB5kzxYc4L1Jw0NiKh6PNyrmsJUZjI322hhekt10ddzmH2vfM=
X-Received: by 2002:a50:8743:0:b0:553:5578:2fc9 with SMTP id
 3-20020a508743000000b0055355782fc9mr62801edv.5.1704432015363; Thu, 04 Jan
 2024 21:20:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-18-jstultz@google.com>
 <4cdaca00-dc4e-4ac0-a362-56b90ca584f0@arm.com>
In-Reply-To: <4cdaca00-dc4e-4ac0-a362-56b90ca584f0@arm.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 4 Jan 2024 21:20:02 -0800
Message-ID: <CANDhNCqgiiZSVUn7erAgQ0y3kDsRrqRq2B8qx9JLJQkd-bTP2Q@mail.gmail.com>
Subject: Re: [PATCH v7 17/23] sched: Initial sched_football test implementation
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

On Fri, Dec 22, 2023 at 1:32=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
>
> On 20/12/2023 12:18 am, John Stultz wrote:
> > Reimplementation of the sched_football test from LTP:
> > https://github.com/linux-test-project/ltp/blob/master/testcases/realtim=
e/func/sched_football/sched_football.c
> >
> > But reworked to run in the kernel and utilize mutexes
> > to illustrate proper boosting of low priority mutex
> > holders.
> >
> > TODO:
> > * Need a rt_mutex version so it can work w/o proxy-execution
> > * Need a better place to put it
>
> I think also this patch can be upstreamed regardless of other Proxy
> Execution patches, right?

Well, we would need to use rt_mutexes for the !PROXY case to validate
inheritance.
But something like it could be included before PROXY lands.

> > + *
> > + * This is done via having N offsensive players that are
>
>                                  offensive

Fixed.

> > + * medium priority, which constantly are trying to increment the
> > + * ball_pos counter.
> > + *
> > + * Blocking this, are N defensive players that are higher
> > + * priority which just spin on the cpu, preventing the medium
> > + * priroity tasks from running.
>
>        priority

Fixed.

> > +atomic_t players_ready;
> > +atomic_t ball_pos;
> > +int players_per_team;
>
> Nit: Number of players cannot be lower than 0. Should it be unsigned then=
?

Fixed.

> > +bool game_over;
> > +
> > +struct mutex *mutex_low_list;
> > +struct mutex *mutex_mid_list;
> > +
> > +static inline
> > +struct task_struct *create_fifo_thread(int (*threadfn)(void *data), vo=
id *data,
> > +                                    char *name, int prio)
> > +{
> > +     struct task_struct *kth;
> > +     struct sched_attr attr =3D {
> > +             .size           =3D sizeof(struct sched_attr),
> > +             .sched_policy   =3D SCHED_FIFO,
> > +             .sched_nice     =3D 0,
> > +             .sched_priority =3D prio,
> > +     };
> > +     int ret;
> > +
> > +     kth =3D kthread_create(threadfn, data, name);
> > +     if (IS_ERR(kth)) {
> > +             pr_warn("%s eerr, kthread_create failed\n", __func__);
>
> Extra e at eerr?

Fixed.


> > +             return kth;
> > +     }
> > +     ret =3D sched_setattr_nocheck(kth, &attr);
> > +     if (ret) {
> > +             kthread_stop(kth);
> > +             pr_warn("%s: failed to set SCHED_FIFO\n", __func__);
> > +             return ERR_PTR(ret);
> > +     }
> > +
> > +     wake_up_process(kth);
> > +     return kth;
>
> I think the result of this function is actually unused. So,
> create_fifo_thread()'s return type can be void?

It's not used, but it probably should be. At least I should be
checking for the failure cases. I'll rework to fix this.



> > +
> > +int offense_thread(void *)
>
> Does this (no param name) build fine on Android env?

Good point, I've only been testing this bit with qemu. I'll fix it up.

> > +int ref_thread(void *arg)
> > +{
> > +     struct task_struct *kth;
> > +     long game_time =3D (long)arg;
> > +     unsigned long final_pos;
> > +     long i;
> > +
> > +     pr_info("%s: started ref, game_time: %ld secs !\n", __func__,
> > +             game_time);
> > +
> > +     /* Create low  priority defensive team */
>
> Sorry: extra space after `low`.

Fixed.

> > +     mutex_low_list =3D kmalloc_array(players_per_team,  sizeof(struct=
 mutex), GFP_ATOMIC);
> > +     mutex_mid_list =3D kmalloc_array(players_per_team,  sizeof(struct=
 mutex), GFP_ATOMIC);
>
> * Extra space after `players_per_team,`.
> * Shouldn't we check result of `kmalloc_array()`?
>
> Same comments for `mutex_low_list` (previous) line.

Yep.

Thanks for all the suggestions!
-john

