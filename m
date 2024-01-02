Return-Path: <linux-kernel+bounces-14366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7F3821C21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E637282654
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBC8FBFC;
	Tue,  2 Jan 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Urj3Kxr4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD99CFBF6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a27db7d85c7so161160466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 05:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704200459; x=1704805259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6r0cBbzRUMyVtOb0ZzKCwag9UOU710+HMzjU5F0c9ns=;
        b=Urj3Kxr4IvR7bjlKaqhriOTBxaj9lAkzAPtG1bGAdl3G6hl/dOHtEFEqlCnU8ZIT31
         iYrAx/9/+GGGN6mqRRPMucS/mhwwp6UF9hh0p49UMjbRloh2/XB+XkdjMQZtXP44jdi7
         +pQlaxwb9ExgRhk0qYkxeOxFfqJd5V+dy8PmKF00GX0bdKVlywQx69EUNzUWY6uMPwNe
         0hlHqYrt1ytKqBt3bYkzubud8WedxUYIo3HBq3RPGjn2mejRNlBbINltY8FBtr5WXW38
         C45KOxOKSXECWnhym3NB5PkCR2ypgb70tCSUt8/+Vs7Cb6JjyCuGOj4r/KGsu1VijrPu
         nUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704200459; x=1704805259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6r0cBbzRUMyVtOb0ZzKCwag9UOU710+HMzjU5F0c9ns=;
        b=DgdPJaTj+0RQ9jgmzs+5qndPwQxBbuLlKqvnDv7FBRkm1aO8SwVqEyZEv/pXw6Kman
         ePijbmTWONptI/MIIIFs+pdpJQhiqgYr70o6LVp/8ek0a5ZnYFd/qhQWCi3gPB3DtG+B
         +fDw47uloa8oxRX9Z4JyKK9zY1MDe04jJowmSm1u2NKoKO1nX/jnOeMGlXMszdN0AZhr
         8G7iWnRevP9th3TrglOXywAbRkV9PfNc8Uqr/IJEwbqrpxjyCo0uFrOt3etHXab/werF
         /bngJ1l83c8X4qQrt8ORajitEf2PNPOCPdFz+J76m4YY84VVw7HxR7Nls7fhI1xnDGzi
         tdTg==
X-Gm-Message-State: AOJu0YwsP2YbMLlSguJ8Ng/L8P9E+m036ZInnPLs4zgDnB/7r00Kf0sq
	Xffeppy3ulf2d3gNWlD7L1V3sFCWfPkQSWpfRxY=
X-Google-Smtp-Source: AGHT+IELyPSJ3YmKkxM8fUVcYbY0Q+v2urBRFPIn+NZyHbWsBjAJdZhoRV0XzqdDtD5D8TbFbuffrITO882PR6v/PFo=
X-Received: by 2002:a17:906:5d0:b0:a23:6c9c:d4ce with SMTP id
 t16-20020a17090605d000b00a236c9cd4cemr7451190ejt.116.1704200458614; Tue, 02
 Jan 2024 05:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102073351.1527503-1-alexs@kernel.org> <xhsmhplykjawj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhplykjawj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Alex Shi <seakeel@gmail.com>
Date: Tue, 2 Jan 2024 21:00:22 +0800
Message-ID: <CAJy-Am=R=gRFqSdGjXaMqq7Yetpp-4=bLtnP-87GepN4zff5Tg@mail.gmail.com>
Subject: Re: [PATCH] sched/tracing: correct the task blocking state
To: Valentin Schneider <vschneid@redhat.com>
Cc: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org, curuwang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 6:19=E2=80=AFPM Valentin Schneider <vschneid@redhat.=
com> wrote:
>
> On 02/01/24 15:33, alexs@kernel.org wrote:
> > From: Alex Shi <alexs@kernel.org>
> >
> > commit 80ed87c8a9ca ("sched/wait: Introduce TASK_NOLOAD and TASK_IDLE")
> > stopped the idle kthreads contribution to loadavg. Also task idle shoul=
d
> > separated from blocked state too, otherwise we will get incorrect task
> > blocking state from event tracing sched:sched_stat_blocked.
> >
>
> Why is that incorrect? AFAICT we have mapped the (schedstat) 'blocked'
> meaning to TASK_UNINTERRUPTIBLE. TASK_IDLE tasks don't contribute to
> loadavg yes, but they are still in an UNINTERRUPTIBLE wait.


Hi Valentin,
Thanks a lot for the reply.

I agree with you the current usage, but if so, we account for the idle task=
 into
blocked state. And it's better to distinguish between idle and block.

>
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index b28114478b82..b6afa596f071 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1570,7 +1570,7 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, stru=
ct sched_dl_entity *dl_se,
> >                       __schedstat_set(p->stats.sleep_start,
> >                                       rq_clock(rq_of_dl_rq(dl_rq)));
> >
> > -             if (state & TASK_UNINTERRUPTIBLE)
> > +             if (is_blocked_task_state(state))
> >                       __schedstat_set(p->stats.block_start,
> >                                       rq_clock(rq_of_dl_rq(dl_rq)));
>
> This change makes it so tasks waiting in TASK_IDLE have their waiting
> ignored by schedstat (they are seen as neither INTERRUPTIBLE nor UNINTERR=
UPTIBLE).
>

Right, maybe it's time to add a new state for TASK_IDLE?

Many thanks!
Alex Shi

