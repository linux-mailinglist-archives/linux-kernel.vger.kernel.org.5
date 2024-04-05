Return-Path: <linux-kernel+bounces-133414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F270D89A365
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3510282116
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E52171659;
	Fri,  5 Apr 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="A9qbD+KB"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F216C854
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337419; cv=none; b=IZzpS0rmyQI+4UR18VapxkTelbPNwl2x7y7v4lNhEc1b1wknnR6J5bFt26/GpRggLEhO6nCy8azuOQ7IyI6qhEzKfnKr215PUVc7YX8RBAoj6DVnYn6b8FRPO7T/O4FQH/OczjV/JqEroL1MCnQ49P73FsozBEt3TG9ymdI8wcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337419; c=relaxed/simple;
	bh=qlAW1m2gfnivy0aAqPm7iA6UymLijrQLbY/YcBzBIis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heubjvIdP/nmRZTyLs+iNN8EylLwmb6iEGZ2fTODsF1zjOZiRTXVdjxlFBAvnJD3sKFa9vTQarWIvCu1bEEHnVL46xm1uwcfqLdnj+BRKCjUnkIVkqcj5lAhjlmEz0hO6K1M6FJLQ/OkbvhVqfpTUP3ug4Z0TB4dLv3+cN2BRgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=A9qbD+KB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4162dd23df5so10660175e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1712337416; x=1712942216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DycP0uOGcEdyRlMR9ZhT34gt9L0jqSuRD1o7RdUYWsc=;
        b=A9qbD+KBqI6lXk0WAeMrMX96JPWhRodL7BD10QFxnVxTjePIHy1VeSk/cTZ7ZGLAaS
         Fc3S+JlPp7cGNS5IprOuffY8Q4VE0BSP0n3ki1UQvC6LZa8f0JFIOxLjjvXuYqPoAoxY
         qi8Dd+qzcwpDZCscCe7c4Aa/SfwBYcHyeNwskGM966nRmNuYIVMG7tknv1zRD83ludng
         GgP1eqGCRZkel4T8qc+7HIIvCyUBH/vCSLgUF4c422vBQ2D5CPp4kmPz5OKUcCG92CvN
         4uXEARihZAxd5kLY/e21TehHZ8+JxFPToeOw5Z9TdFxmzyYcvI5OJ6hrPY8pOunsFPPM
         S+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712337416; x=1712942216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DycP0uOGcEdyRlMR9ZhT34gt9L0jqSuRD1o7RdUYWsc=;
        b=RMpBd/rkh7hbNeiIV+E372VntO5T2TAZo7v0raj7ZA8nqmIrdP1IJ7MzSm1GekSFgk
         cTxX6VhysncAI4VdxhSHj0LrznloXhlzJFh8JX+RsV2uSOkVjMxRkfdKTbOiuhy2Thp5
         etkC8NgybxJpKXtULC6iC6Y7jJR7ueaxFbbWc97rHYjd6taF97MsKm/7nr/UDT9gtf5Q
         Lfses/dWtYjbltQ6cIq2x26CN0WamwJy+FYV5zdkbSSx96l4Y1pKArIc6fA2piZ0xA8g
         5bKbuH5blv61sOTIamu1iSdm22Z7aKRPw0BxUw+MSrZ7FC70NobFm7s3uoUVmriC4LPh
         t+Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVGo7FmQV9ypsInhNSvEEgutrhtN6rYLkoIGZnyQo3IGaXXUMuHVz+75E3T/HZTN+Rb0hiuHREEkg21PYdLToWRBSVACVr+b8USGd61
X-Gm-Message-State: AOJu0Yx9UWthvUFn0tWbTeZRjLFLDK/B8CMrQA3jhtSoazo9mON/XTLG
	RdWP++PRksuWCsx8AtB4QmUAft1uTFP3q40WjaP/M4nkCSSTctlV0cGSoHSSS0o=
X-Google-Smtp-Source: AGHT+IEjMM0g4E+c4BTLnzu2uebF4vUwjGJlqCdm9ZEV2+eCXmX544hECig6xfKnkVmqM4HeendH+A==
X-Received: by 2002:a7b:ce99:0:b0:414:8c06:5c32 with SMTP id q25-20020a7bce99000000b004148c065c32mr1961197wmj.14.1712337416088;
        Fri, 05 Apr 2024 10:16:56 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id l8-20020a1c7908000000b004155387c08esm3524113wme.27.2024.04.05.10.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 10:16:55 -0700 (PDT)
Date: Fri, 5 Apr 2024 18:16:53 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting
 prio
Message-ID: <20240405171653.boxbylrdak5fopjv@airbuntu>
References: <20240403005930.1587032-1-qyousef@layalina.io>
 <CAKfTPtDB8D6bouxJN9q8gXqG+BQYcsrJYEodDWtOB2kQwPH53A@mail.gmail.com>
 <20240404220500.dmfl2krll37znbi5@airbuntu>
 <CAKfTPtDP7if0gozSrnj+E_hH5xR-vpGAM2TwN4qWXcg5BtrEtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDP7if0gozSrnj+E_hH5xR-vpGAM2TwN4qWXcg5BtrEtw@mail.gmail.com>

On 04/05/24 14:15, Vincent Guittot wrote:
> On Fri, 5 Apr 2024 at 00:05, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 04/03/24 15:11, Vincent Guittot wrote:
> > > On Wed, 3 Apr 2024 at 02:59, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > For fair tasks inheriting the priority (nice) without reweighting is
> > > > a NOP as the task's share won't change.
> > >
> > > AFAICT, there is no nice priority inheritance with rt_mutex; All nice
> >
> > Hmm from what I see there is
> >
> > > tasks are sorted with the same "default prio" in the rb waiter tree.
> > > This means that the rt top waiter is not the cfs with highest prio but
> > > the 1st cfs waiting for the mutex.
> >
> > This is about the order on which tasks contending for the lock more than the
> > effective priority the task holding the lock should run at though, no?
> 
> No, they are ordered by priority in the rb tree so you can get the
> priority of the top waiter and apply it to the owner of the lock

I think I see what you're getting at now. There's no guarantee the top waiter
is the higher priority fair task. Yes.

> 
> >
> > >
> > > >
> > > > This is visible when running with PTHREAD_PRIO_INHERIT where fair tasks
> > > > with low priority values are susceptible to starvation leading to PI
> > > > like impact on lock contention.
> > > >
> > > > The logic in rt_mutex will reset these low priority fair tasks into nice
> > > > 0, but without the additional reweight operation to actually update the
> > > > weights, it doesn't have the desired impact of boosting them to allow
> > > > them to run sooner/longer to release the lock.
> > > >
> > > > Apply the reweight for fair_policy() tasks to achieve the desired boost
> > > > for those low nice values tasks. Note that boost here means resetting
> > > > their nice to 0; as this is what the current logic does for fair tasks.
> > >
> > > But you can at the opposite decrease the cfs prio of a task
> > > and even worse with the comment :
> > > /* XXX used to be waiter->prio, not waiter->task->prio */
> > >
> > > we use the prio of the top cfs waiter (ie the one waiting for the
> > > lock) not the default 0 so it can be anything in the range [-20:19]
> > >
> > > Then, a task with low prio (i.e. nice > 0) can get a prio boost even
> > > if this task and the waiter are low priority tasks
> >
> > I don't see this effect. The only change I am doing here
> > is that when we set the prio that we are supposed to be inheriting, instead of
> > simply changing prio, I also ensure we reweight so that we run at the inherited
> > nice value. I am not changing how the waiter logic works.
> 
> But if you look more deeply in the code, you will see that all cfs are
> sorted with the same default prio so cfs tasks are not sorted and are
> considered to be the same.

Yes I saw that. We can potentially revert 715f7f9ece46 ("locking/rtmutex:
Squash !RT tasks to DEFAULT_PRIO") ;-)

/hides

> 
> All that to say that I think the weight is not applied on purpose.
> This might work for your particular case but there are more changes to
> be done if you want to apply prio inheritance between cfs tasks.
> 
> As an example, what about the impact of cgroup on the actual weight
> and the inherited priority of a task ? If the owner and the waiter
> don't belong to the same cgroup their own prio is meaningless... task
> nice -20 in a group with a weight equal to nice 19 vs a task nice 19
> in a group with a weight equals to nice -20

That is on my mind actually. But I thought it's a separate problem. That has to
do with how we calculate the effective priority of the pi_task. And probably
the sorting order to if we agree we need to revert the above. If that is done
appropriately, I hope the current reweight approach could be used as-is. Hmm
but but as I write this I realize the compound weight will still be different.
Maybe we should inherit the weight rather than the prio, which IIUC should
already be the effective weight taking cgroup into account?

Just to put it out on the clear, you don't think the issue is wrong, but just
that we need to look further for a proper fix, right? ie: it is a problem we
should fix, but we need to nail down more details IIUC.

If that's the case it'd be good to know what else beside sorting order and
handling cgroup I need to take into account to make this more correct.

There's the obvious SCHED_IDLE case of course that needs a policy promotion,
beside weight adjustment.

> 
> 
> >
> > Here's my test app FWIW
> >
> >         https://github.com/qais-yousef/pi_test
> >
> > When I run
> >
> >         pi_test --lp-nice 0 --lp-nice 10
> >
> > the lp thread runs at 0 still
> >
> > If I do
> >
> >         pi_test --lp-nice 10 --lp-nice 5
> >
> > low priority thread runs at 5
> >
> > What combination are you worried about? I can give it a try. I use
> > sched-analyzer-pp [1] to see the division of runnable/running or you can
> > monitor them on top
> >
> >         #!/bin/bash
> >         set -eux
> >
> >         sudo sched-analyzer &
> >
> >         ./pi_test --lp-nice ${1:-10} --hp-nice ${2:-0} --affine-cpu ${3:-0} &
> >
> >         sleep 10
> >
> >         pkill -SIGKILL pi_test
> >
> >         sudo pkill -SIGINT sched-analyzer
> >
> >         sched-analyzer-pp --sched-states pi_test sched-analyzer.perfetto-trace
> >
> > Picutres of output is attached for before and after
> >
> >         pi_test --lp-nice 10 --hp-nice 0
> >
> > [1] https://github.com/qais-yousef/sched-analyzer

