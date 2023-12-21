Return-Path: <linux-kernel+bounces-9010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5359981BF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0968D1F2417A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40B7745E1;
	Thu, 21 Dec 2023 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxzU3tai"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB95745C9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d3b2c8517so9625e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703187984; x=1703792784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3ZUs8q0OT85w/gjivGdk3ICEoFIzqIVcdgY0GdySpc=;
        b=VxzU3taijU/VzGE9kUjHijO3EnUa+taaE4XlyRn47ZwCJk7SvU3D2NhYQYeWeAkLPY
         CeKzBewHZDV6t6q4LjOUUa4hGIBna+5S4R7SvChLPE6sUz/X2xbYcVLvCnP9sgyv+0Nl
         S+YS1fOYrTZtIMY15sDH2mYB+XuEHjNL721q6ulMnUvB7rEB68Y1iJYtH9Fpy9B1F5cv
         DwARpNaQdTVrdqUWL8tCRlh8wGCPBnjrAc1NWIg0KCvoT4BV68M6xOmcwTcsxiZRV8oR
         I18TXWDHBj+Oyu67z6eok+rZLjGJCVbnJwYizDbvlJl6xSDRJLzTTTEdFrl1Hgsvl31M
         56JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703187984; x=1703792784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3ZUs8q0OT85w/gjivGdk3ICEoFIzqIVcdgY0GdySpc=;
        b=vf5oEQbNmcRDlbpD2Ak5VSbDXozCTVgTuBSzbiT5EjZnZgbYzruOAkre7drUi+6vyf
         oVY/PooBlRX0paABOtRtpbl1ohTs76W4FhxhqXB8/Pipq/lRvqUlPS9yEetsT5+y7Eum
         J4pdL0749J6Ek+tkMMG7XqKaznnWQGfXA0mByiSQiI4ApFLV+byvv8nUiM0MQ4iNl1XY
         zV8ZB4txzIG64yOW9jfTCnuC6inxhOoNDiaFtkCQm2oPHQTHVjMZ3jsPpKtq3QJuQJmB
         saguR5BMGjsRceQqhsrjAQbCPJiP/uW6+xN1ii+PR0W+UMpnDVZhChyycY8mmzBl/k6n
         f/bg==
X-Gm-Message-State: AOJu0YyqrFcbRdEJv9+xH4OZ/ioXR03/Yj6mvfFxZVzL07C+n5OExBFF
	1vFU7QNjJADEJMVagR+M7BaAOOFKam9G+Y2BQk9E2sr/6Ak=
X-Google-Smtp-Source: AGHT+IG9ykIAmiwe+eNHQxnl9zNgR3Z7hqN4637lEvph4nj48cEGDct1mU6Vs+njELWGv7GLCWUk8MnwHbXx8unAqD0=
X-Received: by 2002:a05:600c:6a88:b0:40d:3ab7:86e0 with SMTP id
 jl8-20020a05600c6a8800b0040d3ab786e0mr10173wmb.3.1703187983895; Thu, 21 Dec
 2023 11:46:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-15-jstultz@google.com>
 <534c73b2-c28c-4e2a-9e6b-a5002c72afe8@arm.com>
In-Reply-To: <534c73b2-c28c-4e2a-9e6b-a5002c72afe8@arm.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 21 Dec 2023 11:46:10 -0800
Message-ID: <CANDhNCp+FLdu2M+pi_E_LzFZnvqo8PLX2vk50jvp-CnMgS=7SQ@mail.gmail.com>
Subject: Re: [PATCH v7 14/23] sched: Handle blocked-waiter migration (and
 return migration)
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

On Thu, Dec 21, 2023 at 8:13=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
> On 20/12/2023 12:18 am, John Stultz wrote:
> > Because tasks may get migrated to where they cannot run,
> > this patch also modifies the scheduling classes to avoid
> > sched class migrations on mutex blocked tasks, leaving
> > proxy() to do the migrations and return migrations.
>
> s/proxy/find_proxy_task/

Thanks, fixed.

> > +     if (p->blocked_on && p->blocked_on_state =3D=3D BO_WAKING) {
> > +             raw_spin_lock(&p->blocked_lock);
> > +             if (!is_cpu_allowed(p, cpu_of(rq))) {
> > +                     if (task_current_selected(rq, p)) {
> > +                             put_prev_task(rq, p);
> > +                             rq_set_selected(rq, rq->idle);
> > +                     }
> > +                     deactivate_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_NO=
CLOCK);
> > +                     resched_curr(rq);
> > +                     raw_spin_unlock(&p->blocked_lock);
> > +                     return true;
> > +             }
> > +             resched_curr(rq);
> > +             raw_spin_unlock(&p->blocked_lock);
>
> Do we need to hold blocked_lock while checking allowed CPUs? Would
> moving raw_spin_lock(&p->blocked_lock); inside if (!is_cpu_allowed())
> block be silly? i.e.,:

That's an interesting idea. I'll take a shot at reworking it. Thanks!

> Nit: what about this
> -#ifdef CONFIG_SMP
>   static inline bool proxy_needs_return(struct rq *rq, struct
> task_struct *p)
>   {
> +       if (!IS_ENABLED(CONFIG_SMP))
> +               return false;
> +

It would be nice, but the trouble is is_cpu_allowed() isn't defined
for !CONFIG_SMP, so that won't build.


> > + * Note: The owner can disappear, but simply migrate to @target_cpu
> > + * and leave that CPU to sort things out.
> > + */
> > +static struct task_struct *
>
> proxy_migrate_task() always returns NULL. Is return type really needed?

Good point. Reworked to clean that up.

> > +proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
> > +                struct task_struct *p, int target_cpu)
> > +{
> > +     struct rq *target_rq;
> > +     int wake_cpu;
> > +
>
> Having a "if (!IS_ENABLED(CONFIG_SMP))" check here would help in
> dropping #else part. i.e.,

Sadly same problem as before, as wake_cpu isn't defined when !CONFIG_SMP :(

thanks again for the detailed review!
-john

