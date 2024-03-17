Return-Path: <linux-kernel+bounces-105341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A09587DC78
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8421F2194D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34953DF4D;
	Sun, 17 Mar 2024 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+jYC5G4"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30D95234;
	Sun, 17 Mar 2024 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710659593; cv=none; b=g8AwS0hUtqgp8TvVBam5wS6xnVQKCaZpkIOreFsZmS9j5sU4y+jMFqrPOHKT4YYf5Rl5osm0EBA/QIc8kBSD9j1A9llgmeNKW3nGgJWOVHHV0JwmdtAQQVOxbfiMkFEBJlWvrRicopciZ+9cvfm08ilEZgLaw9P/A7sttHmSOus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710659593; c=relaxed/simple;
	bh=nHGub343EKXrxDA4sGu+1lpwmusI64CdNewnanHPn5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXvyVARbGquTFYwJuLbZXpbW5uTBlw+XYlVJdm8YqNmrFzgkcqIaSP2CndOXtwxiUOsdWasfSfkjru5gHs+7dKMU2rvmsGflefOzf9QntFrhIg5/qNCA8gr/+EEwOFw1vUN2V4Iahv6gJuubXAHe3u2AncKwie/RcNRa5plmuh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+jYC5G4; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a47cecb98bso1103888eaf.0;
        Sun, 17 Mar 2024 00:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710659590; x=1711264390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/h2r3lyttB5aNEAdgsHuDUKKUKsiECec7RCX40GrShc=;
        b=U+jYC5G4apmLcTPI+1yL/EU6Hzv0lFejwse+gcJ4qKzjKv3paaDXEk0ZL51bXUkCzr
         zoPJKIP6iU8E3VKGg0Ic6aT22OXs51f8htQqE1ghlHTttzMDbt3+pXqAwNwj71HWbC41
         wL5x1Kdq2rfx1mbTm8Xdn1+THn6Dy1ffgbJ/mPAGcn91VjOYyMulQN9fu/urY0/lz4FN
         cL8MLedHcETqCJfC556erm4kGarfWXo+xENpF2Cd5NmsCDxnMdPRUa269ZCgYPgjKzXR
         KAqrCIS9D8XwlSeyU6Um2z15ULBQ1AGDmhaH0EZ8wQu6SI02msMoMML7F8uny3nnqAW7
         lmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710659590; x=1711264390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/h2r3lyttB5aNEAdgsHuDUKKUKsiECec7RCX40GrShc=;
        b=ngqa54Di54cEotNFcSBql0faKG+gVhD5WASn1D0klYNx95qb7bHUnOMORdqmNhHPmt
         2ET/1NuIQOuMk1yT3NxXmpPpslChBoZSWocAldawwJkMJfEBV3c7FXxbaBqsJApu41Pf
         t48l4zxR9XpwvV1ihDiM4xBqzSZQwoNiNeZ1TKc8xlHfATzkrzaN7gMzerEMylGcudJf
         YndTqrFBn8Bauq5AQx5ZNmx499nBQLdXSYv4f4uFEB5fowWCmxwqAhvelMwbB/Snuy/V
         yXObTp+DLkdHfHkNCjgiQCUc+ZapJfsG7IBle2m9TIjpJzdi36CTHoTXvJwzDKkP05Bi
         fhiw==
X-Forwarded-Encrypted: i=1; AJvYcCU7/dqPWQ1vL/JTK6lg+JGbwZNo3Zwq0tedf1xFIMR67X4ZYDIVPdnC1TR3bIb0X3LdnbXkZJX0gkL6tqBbV0lCohKAkWTlwSXiFj4zz3zUKUgLTCclOeAeNZj8pjeymxsS
X-Gm-Message-State: AOJu0YzC0z3sD7AHJvbvvxfI6dB7AFYVOPesPz/yxA0m4diHRF/S9HJh
	qGuW0m3+Kbsa+D/371KDGh0U1Lc2lAub8Magbg2eT5TKxc7OO4M1PQO3WrvOpVYHqyqKwWEQl91
	AeclZUVsPdnvpjWChkrKCh4fS15Q=
X-Google-Smtp-Source: AGHT+IGl4BUBz38EZjOQgDmZj5Y2Q5LvcNKE69fsGO9Skn15fpUBRiY1/lktn/GQXooRfR0R14VZbs6TPNeNPh1H+Qg=
X-Received: by 2002:a05:6358:5924:b0:17e:e33e:27ab with SMTP id
 g36-20020a056358592400b0017ee33e27abmr972103rwf.4.1710659590596; Sun, 17 Mar
 2024 00:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311035502.7112-1-qiang.zhang1211@gmail.com> <49c73303-fdda-4912-b26a-75f2235b3a62@paulmck-laptop>
In-Reply-To: <49c73303-fdda-4912-b26a-75f2235b3a62@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Sun, 17 Mar 2024 15:12:59 +0800
Message-ID: <CALm+0cWeYcp4jKV2H=g5MOHOg6WJ7se0S1g6BhZrwPACiFWYDA@mail.gmail.com>
Subject: Re: [PATCH] rcu-tasks: Avoid rtp_irq_work triggering when the
 rcu-tasks GP is ongoing
To: paulmck@kernel.org
Cc: frederic@kernel.org, joel@joelfernandes.org, neeraj.upadhyay@kernel.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Mon, Mar 11, 2024 at 11:55:02AM +0800, Zqiang wrote:
> > This commit generate rcu_task_gp_in_progress() to check whether
> > the rcu-tasks GP is ongoing, if is ongoing, avoid trigger
> > rtp_irq_work to wakeup rcu tasks kthreads in call_rcu_tasks_generic().
> >
> > The test results are as follows:
> >
> > echo call_rcu_tasks_iw_wakeup > /sys/kernel/debug/tracing/set_ftrace_filter
> > echo 1 > /sys/kernel/debug/tracing/function_profile_enabled
> > insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
> > sleep 600
> > rmmod rcutorture.ko
> > echo 0 > /sys/kernel/debug/tracing/function_profile_enabled
> > echo > /sys/kernel/debug/tracing/set_ftrace_filter
> >
> > head /sys/kernel/debug/tracing/trace_stat/function*
> >
> > original: 56376  apply patch: 33521
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>
> Note that rcu_seq_current() does not provide ordering.  So are you
> sure that this change is safe on weakly ordered systems such as ARM?

The  rcu_seq_current() provide implicit address-dependency barriers, or
did I miss something?

>
> For example, consider the following sequence of events:
>
> o       The call_rcu_tasks_generic() function picks up the grace-period
>         sequence number, which shows that there is a grace period in
>         progress.

The rcu-callback has been enqueued to list before we pick up the
gp seq number.

>
> o       The grace period ends, and sees no reason to start a new grace
>         period.

the gp ends, the rcu_tasks_need_gpcb() will be invoked to check
whether to start a new gp.   find pending callback, the new gp
will start  or did I miss something?

Thanks
Zqiang


>
> o       The call_rcu_tasks_generic() function sees no reason to wake
>         up the grace-period kthread.  There are no more calls to
>         call_rcu_tasks*(), so the callback is never invoked.
>
> Or is there something that prevents this sequence of events from
> ever happening on weakly ordered systems?
>
>                                                         Thanx, Paul
>
> > ---
> >
> > original:
> > ==> /sys/kernel/debug/tracing/trace_stat/function0 <==
> >   Function                               Hit    Time            Avg             s^2
> >   --------                               ---    ----            ---             ---
> >   call_rcu_tasks_iw_wakeup             13217    19292.52 us     1.459 us        8.834 us
> >
> > ==> /sys/kernel/debug/tracing/trace_stat/function1 <==
> >   Function                               Hit    Time            Avg             s^2
> >   --------                               ---    ----            ---             ---
> >   call_rcu_tasks_iw_wakeup             15146    22377.01 us     1.477 us        22.873 us
> >
> > ==> /sys/kernel/debug/tracing/trace_stat/function2 <==
> >   Function                               Hit    Time            Avg             s^2
> >   --------                               ---    ----            ---             ---
> >   call_rcu_tasks_iw_wakeup             12561    18125.76 us     1.443 us        6.372 us
> >
> > ==> /sys/kernel/debug/tracing/trace_stat/function3 <==
> >   Function                               Hit    Time            Avg             s^2
> >   --------                               ---    ----            ---             ---
> >   call_rcu_tasks_iw_wakeup             15452    21770.57 us     1.408 us        6.710 us
> >
> > apply patch:
> > ==> /sys/kernel/debug/tracing/trace_stat/function0 <==
> >   Function                               Hit    Time            Avg             s^2
> >   --------                               ---    ----            ---             ---
> >   call_rcu_tasks_iw_wakeup              8334    15121.13 us     1.814 us        4.457 us
> >
> > ==> /sys/kernel/debug/tracing/trace_stat/function1 <==
> >   Function                               Hit    Time            Avg             s^2
> >   --------                               ---    ----            ---             ---
> >   call_rcu_tasks_iw_wakeup              8355    15760.51 us     1.886 us        14.775 us
> >
> > ==> /sys/kernel/debug/tracing/trace_stat/function2 <==
> >   Function                               Hit    Time            Avg             s^2
> >   --------                               ---    ----            ---             ---
> >   call_rcu_tasks_iw_wakeup              7219    14194.27 us     1.966 us        42.440 us
> >
> > ==> /sys/kernel/debug/tracing/trace_stat/function3 <==
> >   Function                               Hit    Time            Avg             s^2
> >   --------                               ---    ----            ---             ---
> >   call_rcu_tasks_iw_wakeup              9613    19850.04 us     2.064 us        91.023 us
> >
> >  kernel/rcu/tasks.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 147b5945d67a..36c7e1d441d0 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -317,6 +317,11 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
> >       rcuwait_wake_up(&rtp->cbs_wait);
> >  }
> >
> > +static int rcu_task_gp_in_progress(struct rcu_tasks *rtp)
> > +{
> > +     return rcu_seq_state(rcu_seq_current(&rtp->tasks_gp_seq));
> > +}
> > +
> >  // Enqueue a callback for the specified flavor of Tasks RCU.
> >  static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
> >                                  struct rcu_tasks *rtp)
> > @@ -375,7 +380,8 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
> >       }
> >       rcu_read_unlock();
> >       /* We can't create the thread unless interrupts are enabled. */
> > -     if (needwake && READ_ONCE(rtp->kthread_ptr))
> > +     if (needwake && READ_ONCE(rtp->kthread_ptr) &&
> > +                     !rcu_task_gp_in_progress(rtp))
> >               irq_work_queue(&rtpcp->rtp_irq_work);
> >  }
> >
> > --
> > 2.17.1
> >

