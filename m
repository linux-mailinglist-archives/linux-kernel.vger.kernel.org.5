Return-Path: <linux-kernel+bounces-12773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0F381F9EA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90729B238C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2992EF9CD;
	Thu, 28 Dec 2023 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="YFzJOf8I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BCCF9C1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d560818b8so35502855e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 08:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1703780494; x=1704385294; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+gTBczjz6Eq5plgRjAoLyqF7xwyEX6B2BD6x+zo4UNk=;
        b=YFzJOf8IuoYIdzySXywPa28gPm9jdE6WnQrOd02Lt8fGXrnGMMho9Ic4SZUcgXx8/K
         yZfyxY6jxvF65sW8VXJo6AGDugHSYTDam0xgnti9v+OlmbV5y3fd1kLn0si82lH8Y520
         Xn0S3M8EAPoyVIA9ySyxJnCIwRTaBaVORGChzCRcEjWz+0qAWUPAGb8EN3JNQtdrY487
         T4bP6EK2E/pRh2bCxxcOJMiSQHjfhaU0QpFfVyxsEK5Y7UL93t7LJvvAkUgF05VNehfG
         sfwaHJId466R0h2sqveLx4WZ4ECIh9VNy5Kdt6ed7RZBpbvyV/JPW7UqA//mn/3YMjn4
         TgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703780494; x=1704385294;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gTBczjz6Eq5plgRjAoLyqF7xwyEX6B2BD6x+zo4UNk=;
        b=U5N3oP8PwBtHlIERIbm8g96Uzpw9Wvofl/zQUZCF/yjeNo771ufOnfIF+gJJedcOoE
         /dAj8lMITnblC2/+TbfOsvS2rGbQPm0HA6ax6FTPRNeglQ0LyK1Ke6h5491N2Fb2oxtS
         I1khAv19zfkg4fN/oxTcTIYbPc2vLIAWk7+b6gqIAsTZUIzOuhxl6pYMvSnaBN00QDVa
         79K2NqwAjtP6kIupud9Jd/e0tpuSK1JBnvhR2jgRqs4DmKsFv18cbiHCQGyLHw+Y0wVa
         q78TJeqxhQb7nc5rhg3ceG4YqETEC9BxkbnhgOnuCdKzMXAO53imnJzzJJaBKSe2d6tj
         kQCA==
X-Gm-Message-State: AOJu0YzWp3+XdGXw1skYCq0gYGIgd8lW4pK32tuAu0Ii/h92FqIUlbet
	Eb2+Ks1V0O9mdjfRcSs6QbO2XSs1nbciug==
X-Google-Smtp-Source: AGHT+IG3kuB79iPZVoBAUpJpPkcTZ7WH3rs0mJQOdTlEqMKtTdD5EmK0eWWaCm5oQjs9xbTLPOqiag==
X-Received: by 2002:a05:600c:3411:b0:40c:7103:d9c6 with SMTP id y17-20020a05600c341100b0040c7103d9c6mr5855519wmp.183.1703780494349;
        Thu, 28 Dec 2023 08:21:34 -0800 (PST)
Received: from airbuntu (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c471000b0040c4886f254sm35707904wmo.13.2023.12.28.08.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 08:21:33 -0800 (PST)
Date: Thu, 28 Dec 2023 16:21:32 +0000
From: Qais Yousef <qyousef@layalina.io>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
	Mike Galbraith <efault@gmx.de>,
	Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [PATCH v6 01/20] sched: Unify runtime accounting across classes
Message-ID: <20231228162132.mauucgalrcatvwxn@airbuntu>
References: <20231106193524.866104-1-jstultz@google.com>
 <20231106193524.866104-2-jstultz@google.com>
 <20231217161927.vewygmvxvddhxs65@airbuntu>
 <CANDhNCraerdXXpxZ4nDB=aaNmmMnH+2M2yQ=NkFAWECOX6T5CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCraerdXXpxZ4nDB=aaNmmMnH+2M2yQ=NkFAWECOX6T5CA@mail.gmail.com>

On 12/18/23 12:23, John Stultz wrote:
> On Sun, Dec 17, 2023 at 8:19 AM Qais Yousef <qyousef@layalina.io> wrote:
> > On 11/06/23 19:34, John Stultz wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > >
> > > All classes use sched_entity::exec_start to track runtime and have
> > > copies of the exact same code around to compute runtime.
> > >
> > > Collapse all that.
> > >
> ...
> > Looks like this actually got merged into tip via the deadline server work :-)
> 
> Oh! That's great to see! The patch has been floating around for a while.
> 
> > Though not sure if I caught a bug here
> >
> > > diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> > > index 85590599b4d6..7595494ceb6d 100644
> > > --- a/kernel/sched/stop_task.c
> > > +++ b/kernel/sched/stop_task.c
> > > @@ -70,18 +70,7 @@ static void yield_task_stop(struct rq *rq)
> > >
> > >  static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
> > >  {
> > > -     struct task_struct *curr = rq->curr;
> > > -     u64 now, delta_exec;
> > > -
> > > -     now = rq_clock_task(rq);
> > > -     delta_exec = now - curr->se.exec_start;
> > > -     if (unlikely((s64)delta_exec < 0))
> > > -             delta_exec = 0;
> >
> > If negative instead of returning for stopper task; we set delta_exec to 0
> >
> > > -
> > > -     schedstat_set(curr->stats.exec_max,
> > > -                   max(curr->stats.exec_max, delta_exec));
> > > -
> > > -     update_current_exec_runtime(curr, now, delta_exec);
> >
> > And curry on to do time accounting
> >
> > > +     update_curr_common(rq);
> >
> > But the new function will return early without doing accounting. Wouldn't this
> > re-introrduce 8f6189684eb4 ("sched: Fix migration thread runtime bogosity")?
> 
> Hrm. So first, good eye for catching this!
> Looking through the code, much of the accounting logic we end up
> skipping doesn't have much effect when delta_exec = 0, so it seems
> mostly harmless to return early without the accounting.
> 
> Though, there is one side-effect that does get skipped, which is the
> removed update_current_exec_runtime() unconditionally sets:
>   curr->se.exec_start = now;
> 
> Which basically resets the accounting window.
> 
> From the commit, It's unclear how intentional this side-effect is for
> the edge case where the interval is negative.
> 
> I can't say I've really wrapped my head around the cases where the
> se.exec_start would get ahead of the rq_clock_task(), so it's not
> clear in which cases we would want to reset the accounting window vs
> wait for the rq_clock_task() to catch up.  But as this is getting
> called from put_prev_task_stop(), it seems we're closing the
> accounting window here anyway, and later set_next_task_stop() would be
> called (which sets se.exec_start, resetting the accounting) to start
> the accounting window again.
> 
> So you are right that there is a practical change in behavior, but I
> don't think I see it having an effect.

Yes, agreed. I couldn't reproduce any problem and I can't see a terrible side
effect of returning early as well compared to continuing to do the accounting.


Cheers

--
Qais Yousef

