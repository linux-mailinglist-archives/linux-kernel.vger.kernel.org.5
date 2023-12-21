Return-Path: <linux-kernel+bounces-9069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E45581BFD2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18B72884B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC02776DA1;
	Thu, 21 Dec 2023 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3UMJUT4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE96280F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d41a32effso17195e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703192539; x=1703797339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mWkghfYP9nF3cpCu7P/2tNGjkl1FoH8YSgSyUvHGBU=;
        b=v3UMJUT4NV2Cxq2L8UFTKk46RDY6IkvP35YTp973/XcJUwPgURtqmTR+AouImRRpdX
         4leQlIZXjhrwDEQ5k/SwTKdP6FMswaoX4GFBxlvo+fg2fH51hrBAbo4huhheB/yRm7rY
         EDjwuCzh1sN7AN7iN3uXSI647YMNg+dyhiSHrLKbiZ5AkgSK7RkdRax1PacKu96CqkXN
         1uW0QboRcfJuxijry6LShKyi77HMJDmv6ojsgtmp7SheVTv7t8ypAYG/lconP5sFXXDt
         l0lM9AXVpnvPnuF/V0qQYCPXhBY4ywuhV058dDqmFswPRqPoVj8+7O+VTJU45uPi1rLH
         ga7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703192539; x=1703797339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mWkghfYP9nF3cpCu7P/2tNGjkl1FoH8YSgSyUvHGBU=;
        b=d87THAj9ej6xKyuWGdk2omF9zpsP8+6T3oY9hL/yeGSI93XfX42Wo6GkOA6oKJfpGc
         wyhI72rgmNpNsmOEyfD6mIexPq5zr+msjwn17Cr98P3P5PkrnENdXgeCRsRcZMsi305o
         +q+FskIXTSVRTbxmjBnuH9FMyqgoAPhRNxLLNgU1qoJQIKljD77gSZnTqTroowUfsGEo
         GVFkqMNXOX61Dp4hHQEQfItJPvC2qG0zdWFmwfZ9WpAufFnLgI8jJC6p/a2Du5BcJiWR
         nxQatZRctJVHbsUBXERr9NKDtgcIxroQihogA/UXcEWQQ9R8ssOwynseXIjVm8+p33Wh
         7IJw==
X-Gm-Message-State: AOJu0Yx3snBj7pvqSGo7A0P0APphfWfsYCHSj7qsAdJQPAoIbSNxWIGR
	ztxUjNM4qQwi2b4T6NopgVI6UW/j3YmU702QZ/tW+Od1/ZM=
X-Google-Smtp-Source: AGHT+IEamLnHK1nCMkhRU6zkFIg/tDNo1uNY0ethjZdqP+m6Kghot15huFnwwXOhKr3PCY5CiYGUyFPN85qtwqgumOY=
X-Received: by 2002:a05:600c:63c3:b0:40d:1bcf:1abf with SMTP id
 dx3-20020a05600c63c300b0040d1bcf1abfmr25376wmb.6.1703192538700; Thu, 21 Dec
 2023 13:02:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-13-jstultz@google.com>
 <de0ac26f-1fde-4472-8570-7d0bf730176a@arm.com>
In-Reply-To: <de0ac26f-1fde-4472-8570-7d0bf730176a@arm.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 21 Dec 2023 13:02:05 -0800
Message-ID: <CANDhNCqULO0fEf-SgG6yvW104145eDPsAcxCLBxXZ1FUCodtfg@mail.gmail.com>
Subject: Re: [PATCH v7 12/23] sched: Fix proxy/current (push,pull)ability
To: Metin Kaya <metin.kaya@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Valentin Schneider <valentin.schneider@arm.com>, Joel Fernandes <joelaf@google.com>, 
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

On Thu, Dec 21, 2023 at 7:03=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
> On 20/12/2023 12:18 am, John Stultz wrote:
> > +static inline void proxy_tag_curr(struct rq *rq, struct task_struct *n=
ext)
> > +{
> > +     if (sched_proxy_exec()) {
>
> Should we immediately return in !sched_proxy_exec() case to save one
> level of indentation?

Sure.

> > +             /*
> > +              * pick_next_task() calls set_next_task() on the selected=
 task
> > +              * at some point, which ensures it is not push/pullable.
> > +              * However, the selected task *and* the ,mutex owner form=
 an
>
> Super-nit: , before mutex should be dropped.
>
> > +              * atomic pair wrt push/pull.
> > +              *
> > +              * Make sure owner is not pushable. Unfortunately we can =
only
> > +              * deal with that by means of a dequeue/enqueue cycle. :-=
/
> > +              */
> > +             dequeue_task(rq, next, DEQUEUE_NOCLOCK | DEQUEUE_SAVE);
> > +             enqueue_task(rq, next, ENQUEUE_NOCLOCK | ENQUEUE_RESTORE)=
;
> > +     }
> > +}
> > +
> >   /*
> >    * __schedule() is the main scheduler function.
> >    *
> > @@ -6796,6 +6813,10 @@ static void __sched notrace __schedule(unsigned =
int sched_mode)
> >                * changes to task_struct made by pick_next_task().
> >                */
> >               RCU_INIT_POINTER(rq->curr, next);
> > +
> > +             if (!task_current_selected(rq, next))
> > +                     proxy_tag_curr(rq, next);
> > +
> >               /*
> >                * The membarrier system call requires each architecture
> >                * to have a full memory barrier after updating
> > @@ -6820,6 +6841,10 @@ static void __sched notrace __schedule(unsigned =
int sched_mode)
> >               /* Also unlocks the rq: */
> >               rq =3D context_switch(rq, prev, next, &rf);
> >       } else {
> > +             /* In case next was already curr but just got blocked_don=
or*/
>
> Super-nit: please keep a space before */.

Fixed up.

Thanks for continuing to provide so much detailed feedback!
-john

