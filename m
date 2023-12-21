Return-Path: <linux-kernel+bounces-8880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF1881BD9E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A141F25AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D36062811;
	Thu, 21 Dec 2023 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TL3TVCBu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33343BA2F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d41a32effso2085e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703181185; x=1703785985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGJxOOvEqxsVQC6VhA5d1D39OpY+NWeBZWu2r5+YFiU=;
        b=TL3TVCBuJu04cLFvn4DR6oVXP4RWTxlH8j2H8P453QgT2/GMSCs6GkOqyFS6rDysnm
         ib1BcdB7fDsMb/z1F6iiovsr2jv8b/83326Lua/AEOuDAsxCcdmVCQ2aTjgHs8/GEpRp
         PzlBC79yEKi5u7p4sujHoy+Gd/LtqoaVgDW2ZefvBWNtFsparEtJyJ2nIYbeGV9klnzW
         eSz3bZVLIP1usPle/LyfzAFFaTWZSVAFwl3++VfGnNw+hF8qDhGNT/aW1v7OCidliluY
         Ca6heradamQG06xnUTky6pMGKLMramzsC3CsGB8OLz9pJT34yiZz0weWoTOdiySFUVlI
         l+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703181185; x=1703785985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGJxOOvEqxsVQC6VhA5d1D39OpY+NWeBZWu2r5+YFiU=;
        b=XLZN9E1l0DM4kyed5gqPBzW91kqRG9bWoMzEmH4USvleQD9xUmjC4uTtIDur1nTXw4
         nVR4/LBjoEPVtg0h8J3BdS6/UBcQEqq1ChV/2JDfSQtBVv70CLv5OWGACTPwioRYveIg
         F0gjkgDVVIRQgMKbHyHtlHlroE3lWlD0IWDV6rbwsf7FR8CoV8yhyA04nyiLgSeNGdFT
         1FPmW3n5Lqdogwd7Qvq8CXAYLbBf3upj/Xhxo/xVJuv9RQI9s0QDafi7FdqpvF4gyhOf
         8BEL0WDPcnXWSj/KQKMM8ToY9RNy9g+bu+3PV1Ah4qTw2CuKcLKtKaMqH5tPQ9ydkl4B
         OTxw==
X-Gm-Message-State: AOJu0Yzopxrmhq7vwesxjLS/gVQrSRd4EdP/CYkgJBMOQpuXf/aE/hPc
	1vYy52lnpA8Eu4Hod2ZzKghOwKL/0jUyLWzqr//W9rZW3rg=
X-Google-Smtp-Source: AGHT+IHimUqDXhGdGLvwEwI7ls19nRWkrwvr/YKVAUJ7osC06zOOPKhKmusnr/CpENW5LVrhPZcH9Pv+OAs2his0BqM=
X-Received: by 2002:a7b:c3c1:0:b0:40d:400c:1b26 with SMTP id
 t1-20020a7bc3c1000000b0040d400c1b26mr107780wmj.7.1703181185195; Thu, 21 Dec
 2023 09:53:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-6-jstultz@google.com>
 <35af7d68-7a98-4b72-8186-814482f9f98f@arm.com>
In-Reply-To: <35af7d68-7a98-4b72-8186-814482f9f98f@arm.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 21 Dec 2023 09:52:52 -0800
Message-ID: <CANDhNCqyJUAYjbuKVwEUcEjPZFUyiCQoToRYZK7g0ODzW3wCVg@mail.gmail.com>
Subject: Re: [PATCH v7 05/23] locking/mutex: Rework task_struct::blocked_on
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
	"Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 2:13=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
> On 20/12/2023 12:18 am, John Stultz wrote:
> > +static inline struct mutex *get_task_blocked_on(struct task_struct *p)
> > +{
> > +     lockdep_assert_held(&p->blocked_lock);
> > +
> > +     return p->blocked_on;
> > +}
> > +
> > +static inline struct mutex *get_task_blocked_on_once(struct task_struc=
t *p)
> > +{
> > +     return READ_ONCE(p->blocked_on);
> > +}
>
> These functions make me think we should use [get, set]_task_blocked_on()
> for accessing blocked_on & blocked_on_state fields, but there are some
> references in this patch which we directly access aforementioned fields.
> Is this OK?

Yeah. In the reworks I've probably added some subtle uses that should
be switched to the accessors or better commented.


 > @@ -4341,6 +4342,11 @@ int try_to_wake_up(struct task_struct *p,
unsigned int state, int wake_flags)
> >
> >               ttwu_queue(p, cpu, wake_flags);
> >       }
> > +     /* XXX can we do something better here for !CONFIG_SCHED_PROXY_EX=
EC case */
>
> blocked_on* fields are now used even in !CONFIG_SCHED_PROXY_EXEC case.
> I'm unsure if we can get rid of lock & unlock lines or entire hunk, but
> would this be too ugly? I wish we could convert blocked_on_state to an
> atomic variable.

Well, atomics have their own costs, but it's something I'll think
about. In the comment above, the idea I'm pondering is that in the
!PROXY_EXEC case the blocked_on_state doesn't provide much utility, so
maybe there's a way to opt out of that portion (while keeping the
blocked_on for debug checking).  Even in the PROXY_EXEC case, we might
be able to move this check to proxy_needs_return(), but I need to
think the logic out to make sure we'd always hit that path when we
need to make the transition.

I've also wondered if the blocked_on_state might be able to be merged
into the task->__state, but the rules there are more subtle so for my
sanity I've kept it separate here for now.

thanks
-john

