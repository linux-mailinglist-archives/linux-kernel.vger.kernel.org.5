Return-Path: <linux-kernel+bounces-17324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B3E824BCB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925A61C21807
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1922D056;
	Thu,  4 Jan 2024 23:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v8kCqHxh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A872D022
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d41a32effso25295e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 15:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704410740; x=1705015540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKspF8f2RI96ywEB6O2sST0m/RmdE7EiswHI9TbxcxQ=;
        b=v8kCqHxhxCuOKzKlMXhyeLSBTMhF/Vko39nj0BQOw3z63prxsvfSGccPiUe72ngFx/
         Ky83KEkMQg2efdrZLRCCbVCOK1TZMzhXzxaU836JI9XFSvvmq5AJMcLVEHevYAr+Z0gS
         2MuJkxZdH1Qph48aZOKD0uZKcMQoOh77GOu6/lBnUKjukIPui94gyCGMmgEpjMlfujg4
         m9GdJ4OoCg7+3AciigiS5VzMMdTElUf2U8Y7xinxHSIhZZWX+M6Np8d2xeyNqF1QIvKp
         3ZuYDYQieTa0knzoyMynaO2CEp6zm6Uo3J5nIt5STuRnOyVV0PPy9Ml00GDCxs1DP7J8
         KYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704410740; x=1705015540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKspF8f2RI96ywEB6O2sST0m/RmdE7EiswHI9TbxcxQ=;
        b=C44L5W1TvGNdR8/m4NbpSMaT1j9LY58Ddtd2Ps72iOndlwBfNlTGFV4XgZRT1fsFNb
         s4arCOLVdxKgsgbAAD/UgMmk8hhJpLhTzRhBq1IfvPmlP0butO19wOw4FD+8/cwG3vfp
         pzz4QTXgK9Zc1+xI74SozAPUsfDdk9MLAdSqEE+Ayd/LAQcEtUlTFJRAr6RGKUnKUFU5
         ULImUpk+wfo5oyERmRDbaMD9sgh9w6mZ9x21UnppffOSPRQvDCXtswm01e9yPWPKjDS0
         c/HUzOgiSqml8sGmWRrRNsmhY94jYbPxiu64BrRZRbcmf7urmMParoxB97L3rhKjJJ5D
         1ujQ==
X-Gm-Message-State: AOJu0Yy6zLABt4xUk4H5AQvDs0D0mDLjytNpvTTAkfB12vLyqf866xbj
	VrCsryn5N5dcpmWlZj8fhG2gbBgf2NKdZjzLLvTy7mWVa1Y=
X-Google-Smtp-Source: AGHT+IET5W3226yl3Kq6gLERifrkLJ+7QayNKinSMTnV1X3nQRE7iZFx+DatMZfZ+/ZAiDy01RwP/bcFy8U1In1kJbk=
X-Received: by 2002:a05:600c:3b8b:b0:40e:34e1:ce34 with SMTP id
 n11-20020a05600c3b8b00b0040e34e1ce34mr69203wms.0.1704410739607; Thu, 04 Jan
 2024 15:25:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-17-jstultz@google.com>
 <64660905-affd-4f23-b971-1dc9698c312e@arm.com>
In-Reply-To: <64660905-affd-4f23-b971-1dc9698c312e@arm.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 4 Jan 2024 15:25:27 -0800
Message-ID: <CANDhNCokDDQAMkZve5===CC2fw2Rdhjx+RAuQ2auE=+jaPdQmw@mail.gmail.com>
Subject: Re: [PATCH v7 16/23] sched: Add deactivated (sleeping) owner handling
 to find_proxy_task()
To: Metin Kaya <metin.kaya@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 12:33=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wr=
ote:
> On 20/12/2023 12:18 am, John Stultz wrote:
> > @@ -3936,13 +4063,19 @@ void sched_ttwu_pending(void *arg)
> >       update_rq_clock(rq);
> >
> >       llist_for_each_entry_safe(p, t, llist, wake_entry.llist) {
> > +             int wake_flags;
> >               if (WARN_ON_ONCE(p->on_cpu))
> >                       smp_cond_load_acquire(&p->on_cpu, !VAL);
> >
> >               if (WARN_ON_ONCE(task_cpu(p) !=3D cpu_of(rq)))
> >                       set_task_cpu(p, cpu_of(rq));
> >
> > -             ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRA=
TED : 0, &rf);
> > +             wake_flags =3D p->sched_remote_wakeup ? WF_MIGRATED : 0;
> > +             ttwu_do_activate(rq, p, wake_flags, &rf);
> > +             rq_unlock(rq, &rf);
> > +             activate_blocked_entities(rq, p, wake_flags);
>
> I'm unsure if it's a big deal, but IRQs are disabled here and
> activate_blocked_entities() disables them again.

Yeah. activate_blocked_entities() is also called from try_to_wakeup()
where we don't have irqs disabled, so we still need to make sure irqs
are off there.
But activate_blocked_entities does irqsave/restore so it should safely
put us back to the proper state. We could rq_unlock_irqrestore() in
the above, but it seems silly to enable irqs here just to disable them
shortly after.

But let me know if it seems I didn't quite get your concern here.


> > @@ -6663,19 +6797,6 @@ proxy_resched_idle(struct rq *rq, struct task_st=
ruct *next)
> >       return rq->idle;
> >   }
> >
> > -static bool proxy_deactivate(struct rq *rq, struct task_struct *next)
> > -{
> > -     unsigned long state =3D READ_ONCE(next->__state);
> > -
> > -     /* Don't deactivate if the state has been changed to TASK_RUNNING=
 */
> > -     if (state =3D=3D TASK_RUNNING)
> > -             return false;
> > -     if (!try_to_deactivate_task(rq, next, state, true))
>
> Now we can drop the last argument (deactivate_cond) of
> try_to_deactivate_task() since it can be determined via
> !task_is_blocked(p) I think. IOW:

True.  I'll add that into the "Drop proxy_deactivate" patch in my
fine-grained series.

Thanks again for the feedback!
-john

