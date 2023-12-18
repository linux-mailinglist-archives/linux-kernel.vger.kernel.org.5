Return-Path: <linux-kernel+bounces-4343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42452817BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9407F285E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8115173462;
	Mon, 18 Dec 2023 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xalb788d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3525B48784
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d20831f21so6505e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702931013; x=1703535813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9WDSgGEhc+3OFIA23kpY44vHipoeaLr8A3YsjGIOtU=;
        b=Xalb788dpUONULKigRkgmt40y6c7VCRxjJUFBr/x/BXLrvSEgFPTGp6fu5D2CLn9x5
         Xydws1lbNWMH9ms9YRK9jwP8VRq8DYYOhA3R3JHeyNnJfTdAL+UoSXtf0kmitE8tpLdX
         8KLPLRgqLsqEYM8gp0r47EnIz0i6gkiAf5R0SZvCU3GcJbI6hMOAHpu5/kzRnZ0DMEw1
         ZZWFol0PmSkgew+tHnW3mL8j1qSXgi8S2Xch5udaAHAmURQdgYmO5tgYjGGpd/zlf5/T
         HdmZDxIlBD3OEOe7SXYfd4RI1RsCgLpEyOOU1XGPFeEdOWEw73Gi2f3ASvTcaNMtgDuI
         WfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702931013; x=1703535813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9WDSgGEhc+3OFIA23kpY44vHipoeaLr8A3YsjGIOtU=;
        b=PLarCgVW3e0MsuT7kBOq2BtE2esqo9FlH/9ftzDFqhXTtcbFkLNuDGdyNvO1Kb3uMr
         +zsZCV78bzRwHLpB5++jAvg9hpZlw2Ih7jdb5LpXfFhvFOJItvG921BZ+EG5HZ0E8Hqz
         YynH2FRvnnrlRD8KBCbLM17AN1JX34ADkqX+omVrq8de1ror6uMGDsVzOqJ7vX5yR5VH
         9IKQS1zM4V5eOc//WTvSB1j0Zyg1l0qalRd4DBMYOlOsx858eClDQPCGbFIrLC1ocb4Z
         W2DxTHJjBIG6uWO0z6c2iyAvMg72CC6e8OPPsoq6emIO7NpYxhJiVwKMLGFREvlMgNNL
         ofZA==
X-Gm-Message-State: AOJu0YxJNYjCs3ULu9ORosgL+ZF1teITB2bKxkoRJRTLqOVf6hWldyzT
	lrfG3/JyILXj+ytJHyx6fpoYkgR7ILXkOJhz6ePQR/tUU/E=
X-Google-Smtp-Source: AGHT+IHaMDfxIwBAVsyuIvkHRanXIf0RATQixLxVl4vLcMt4l69+1q8hUNJvt4YqjgD9SP37EyOVmHqZzDj2dDLKtpE=
X-Received: by 2002:a05:600c:4e4d:b0:40c:329:d498 with SMTP id
 e13-20020a05600c4e4d00b0040c0329d498mr1883wmq.1.1702931013098; Mon, 18 Dec
 2023 12:23:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com> <20231106193524.866104-2-jstultz@google.com>
 <20231217161927.vewygmvxvddhxs65@airbuntu>
In-Reply-To: <20231217161927.vewygmvxvddhxs65@airbuntu>
From: John Stultz <jstultz@google.com>
Date: Mon, 18 Dec 2023 12:23:21 -0800
Message-ID: <CANDhNCraerdXXpxZ4nDB=aaNmmMnH+2M2yQ=NkFAWECOX6T5CA@mail.gmail.com>
Subject: Re: [PATCH v6 01/20] sched: Unify runtime accounting across classes
To: Qais Yousef <qyousef@layalina.io>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com, 
	Mike Galbraith <efault@gmx.de>, Daniel Bristot de Oliveira <bristot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 8:19=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
> On 11/06/23 19:34, John Stultz wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > All classes use sched_entity::exec_start to track runtime and have
> > copies of the exact same code around to compute runtime.
> >
> > Collapse all that.
> >
...
> Looks like this actually got merged into tip via the deadline server work=
 :-)

Oh! That's great to see! The patch has been floating around for a while.

> Though not sure if I caught a bug here
>
> > diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> > index 85590599b4d6..7595494ceb6d 100644
> > --- a/kernel/sched/stop_task.c
> > +++ b/kernel/sched/stop_task.c
> > @@ -70,18 +70,7 @@ static void yield_task_stop(struct rq *rq)
> >
> >  static void put_prev_task_stop(struct rq *rq, struct task_struct *prev=
)
> >  {
> > -     struct task_struct *curr =3D rq->curr;
> > -     u64 now, delta_exec;
> > -
> > -     now =3D rq_clock_task(rq);
> > -     delta_exec =3D now - curr->se.exec_start;
> > -     if (unlikely((s64)delta_exec < 0))
> > -             delta_exec =3D 0;
>
> If negative instead of returning for stopper task; we set delta_exec to 0
>
> > -
> > -     schedstat_set(curr->stats.exec_max,
> > -                   max(curr->stats.exec_max, delta_exec));
> > -
> > -     update_current_exec_runtime(curr, now, delta_exec);
>
> And curry on to do time accounting
>
> > +     update_curr_common(rq);
>
> But the new function will return early without doing accounting. Wouldn't=
 this
> re-introrduce 8f6189684eb4 ("sched: Fix migration thread runtime bogosity=
")?

Hrm. So first, good eye for catching this!
Looking through the code, much of the accounting logic we end up
skipping doesn't have much effect when delta_exec =3D 0, so it seems
mostly harmless to return early without the accounting.

Though, there is one side-effect that does get skipped, which is the
removed update_current_exec_runtime() unconditionally sets:
  curr->se.exec_start =3D now;

Which basically resets the accounting window.

From the commit, It's unclear how intentional this side-effect is for
the edge case where the interval is negative.

I can't say I've really wrapped my head around the cases where the
se.exec_start would get ahead of the rq_clock_task(), so it's not
clear in which cases we would want to reset the accounting window vs
wait for the rq_clock_task() to catch up.  But as this is getting
called from put_prev_task_stop(), it seems we're closing the
accounting window here anyway, and later set_next_task_stop() would be
called (which sets se.exec_start, resetting the accounting) to start
the accounting window again.

So you are right that there is a practical change in behavior, but I
don't think I see it having an effect.

But I've added Mike and Daniel to the CC in case I'm missing something.

thanks
-john

