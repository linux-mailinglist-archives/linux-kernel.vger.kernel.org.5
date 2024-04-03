Return-Path: <linux-kernel+bounces-129890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 451218971B1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D02B2A352
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A0E14900E;
	Wed,  3 Apr 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wmfr1xwT"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3BE1487D8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152453; cv=none; b=JjZcw7UtJouo6O+ZMs3rgFkieiYlgNBrMCVyNZkqn1/3N3mIHbh/9YKQXqvXo/5MP/aV15ylbxj5AWVEn9RgLesywGeXbI8YUC80fNEBKuLAW2FbcLo2KTymKOcJOezz2Rea06T74h56ZAt1eSaLGi0Xd/O3xK6DbYvHzq6iGbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152453; c=relaxed/simple;
	bh=MfqtLRNa2fpBHZnFAnh4Yo9iQ9J9XzehWsBBWF+mzm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bO6PuzfVgwugq9ugbID9RFJQ/guAUOUGrw9oDQb0gdS/9lTR6SlNyBjaTOc3DLTzN+in/nyXNQfEKVhl4paj7Yh2UF+0xxeEZDc4An198eK6aDGkIygD60ApgKfFUJa5DVarzmybbWpHmLI+RyMkmquxrCC3doU69umpz26VzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wmfr1xwT; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so4118920a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712152451; x=1712757251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EifQjE9G475mPBRIXKqbvKnaPLipvIcH7lDv2GyABro=;
        b=wmfr1xwTmzCl3NCgw0oBNL8TF0sJFMVCl9Gdowx5oF+EHjNbu52r7vkVo+1kmeQ8vV
         t0N2LngBGsGUElDDSeX3SPGpTzUmfVX6qTSYXrInvhsOAr8KsMe1R9xPXXLppjZr/biX
         azlWO0NyxWawJ3uwlG0NQYXsv1tUpPXtmR+D/31tqnY+4lLda4xmZn6s3pmORPGJiaCt
         zGaE99Z4YTPrak5bdRxrVShBoDDh/6JYmN7D24tCYXzwKCNFbz7IvTDPWMY099hCcEjQ
         RIViNMae+E42OwZIEDRr9XdYuLshhqgs1IA6BKNbWdyuWshGgDwV2oqoS9mtvBcWlx9E
         Tgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712152451; x=1712757251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EifQjE9G475mPBRIXKqbvKnaPLipvIcH7lDv2GyABro=;
        b=QYmP7l4B8l49BAtfmK9agNLwma7riiiv0B+2qxq/opYcWzCNhLIXpB9od1OSoumW0K
         HCQ37BrW1G/Fxp5B0Cqd3D4FBzujjTKlhLHiruhH1UWGueeY2aj1jVxDIOHIUv1w7W+4
         CIsSFtmylNPHZu+VgdCSBPk9vI6RBkXYyRcnvYrDu/Du1dJv8KJ0OMRKsRz5YfAZgDrW
         AQEoybUEOLzb/bWr0L+1YocSgPz9s57Oki6ZOkMPzZ2ubr009fIXBA44QH5nHfhnYDv8
         LzCQO7vdqsevz1hdXIAD7zlmdVFAZhorz9hIJ6c0MK5ZfbZzUhAAVDGWlQcoofyZ6ysM
         JRHA==
X-Forwarded-Encrypted: i=1; AJvYcCWf6rN7gKaAGe27G86BNz/mznuw2Qas2jjnEziBoSSYvXGIdq1I4Qzkq8q133WD/1+0jDou0P8Va2E4usz/QIUKps2TL27+ezdeyHf4
X-Gm-Message-State: AOJu0YyP6u1Ezcy3SN8brNm0RDye9dV4i3dVywQ2yadAr6x95F7JVMlY
	JDY5SJZgV8696AFCzSMPVEs124rCCQHlE4G5q+JsRjZd4TqpQQcPf62xEU20aL4oYCRrxnSeh0o
	WdO2wmNWBGKpD7+MOWk/uBV19Z4/jsyES2J+ghA==
X-Google-Smtp-Source: AGHT+IGefJbegoXOr6R2ZnnhCVooeBvXSjjTuX7ObdlIIF9BRwX5sJeE5bHRSzSH1mu/EPFYrSKibunaA5tlmr2Skiw=
X-Received: by 2002:a17:90a:a084:b0:2a2:6a2:8bcd with SMTP id
 r4-20020a17090aa08400b002a206a28bcdmr12130670pjp.4.1712152451380; Wed, 03 Apr
 2024 06:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403005930.1587032-1-qyousef@layalina.io> <CAKfTPtDB8D6bouxJN9q8gXqG+BQYcsrJYEodDWtOB2kQwPH53A@mail.gmail.com>
 <20240403094224.105fdef0@gandalf.local.home>
In-Reply-To: <20240403094224.105fdef0@gandalf.local.home>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 3 Apr 2024 15:54:00 +0200
Message-ID: <CAKfTPtB6v3VwQ5Uc=zrh9sskVyrh6tmDrZzAH0=s3P6cphuexQ@mail.gmail.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting prio
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	John Stultz <jstultz@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 15:40, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 3 Apr 2024 15:11:06 +0200
> Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> > On Wed, 3 Apr 2024 at 02:59, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > For fair tasks inheriting the priority (nice) without reweighting is
> > > a NOP as the task's share won't change.
> >
> > AFAICT, there is no nice priority inheritance with rt_mutex; All nice
> > tasks are sorted with the same "default prio" in the rb waiter tree.
> > This means that the rt top waiter is not the cfs with highest prio but
> > the 1st cfs waiting for the mutex.
>
> I think the issue here is that the running process doesn't update its
> weight and if there are other tasks that are not contending on this mutex,
> they can still starve the lock owner.

But I think it's on purpose because we don't boost cfs tasks  and we
never boost them. That could be a good thing to do but I think that
the current code has not been done for that and this might raise other
problem. I don't think it's an oversight

>
> IIUC (it's been ages since I looked at the code), high nice values (low
> priority) turn to at lease nice 0 when they are "boosted". It doesn't
> improve their chances of getting the lock though.
>
> >
> > >
> > > This is visible when running with PTHREAD_PRIO_INHERIT where fair tasks
> > > with low priority values are susceptible to starvation leading to PI
> > > like impact on lock contention.
> > >
> > > The logic in rt_mutex will reset these low priority fair tasks into nice
> > > 0, but without the additional reweight operation to actually update the
> > > weights, it doesn't have the desired impact of boosting them to allow
> > > them to run sooner/longer to release the lock.
> > >
> > > Apply the reweight for fair_policy() tasks to achieve the desired boost
> > > for those low nice values tasks. Note that boost here means resetting
> > > their nice to 0; as this is what the current logic does for fair tasks.
> >
> > But you can at the opposite decrease the cfs prio of a task
> > and even worse with the comment :
> > /* XXX used to be waiter->prio, not waiter->task->prio */
> >
> > we use the prio of the top cfs waiter (ie the one waiting for the
> > lock) not the default 0 so it can be anything in the range [-20:19]
> >
> > Then, a task with low prio (i.e. nice > 0) can get a prio boost even
> > if this task and the waiter are low priority tasks
>
>
> Yeah, I'm all confused to exactly how the inheritance works with
> SCHED_OTHER. I know John Stultz worked on this for a bit recently. He's
> Cc'ed. But may not be paying attention ;-)
>
> -- Steve

