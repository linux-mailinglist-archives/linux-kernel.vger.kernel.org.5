Return-Path: <linux-kernel+bounces-15239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E438228EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F5628526D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263761803B;
	Wed,  3 Jan 2024 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="astjWKfo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A7D18032
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a277339dcf4so429318466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 23:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704266470; x=1704871270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ijtvTm0rr6yr3LvubL/j9J3IlEW4Tl6q4Rn3S5tr7M=;
        b=astjWKfos8cScVZpOJSqCGW6VTeh5lLNGH4cNwKOIeM1CN4c7WUHLCqd7wIOKy+Cf2
         f2jS3uHvEn+8c9cEis4sdyNc1Py7Xy113MTOoCM9evSpfurgKIZskbSYN3/E9oz0KKfd
         bvtNbAZUETfW6/blP8kqlbTfR46i7FH/wc+5TMzozkBUqJdQOaha93nskjR9yVEOWhg9
         IIzXv1XNfa1mWuZoF4LUDeVstjTL4VHvgQBqLGbLbfJ2Lc0IBzEai/y5AeBViX1LI6Y2
         Kp+Sk8DJ+8Y8F25QYxhB7T12KtSosRnp4GyFwpFDqc6RzbWmzgQl3vtQ1aflicL5+tsJ
         fXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704266470; x=1704871270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ijtvTm0rr6yr3LvubL/j9J3IlEW4Tl6q4Rn3S5tr7M=;
        b=OdJDoLc6IL9r8KPCwU/aSzSVHb9WPJ+OPcxe9cXOxiUahgWGwUU2yKlOx7zc/mEEnd
         p2QC3Yvl+Y4b0PKs7W2jJWBH6fqK9d/qHqlz0UUwilTiC5g21t7cK+TIbCcYvKWMrnSo
         uxthJBUjj3CmhJbRLdsvN4BxFkxb5rzAgrwpOv/KIVVhhCNpzk5yKaqw3hqEhyX+76YU
         W4JPGNa6AKwtSVOE9VGuMMHYoZFfnFP9dZ+OUAf+2646rztwfmL1StRh9vmeVwGjbGfe
         M6EPXQXCyY53Y82pONOvK6tyVlwrcv1UQZpF2pF8ELpOPZ+XFAligwatynl3bh/wx1Md
         LLYg==
X-Gm-Message-State: AOJu0YzdnOaJeFoWW6BO5w7RBsisjKPSYuwIcwcDZnDnbGj2UW1s/UTG
	92X9wNXpC6AduBX+/CLK1+XKDDYWOJlnCtn1rCo=
X-Google-Smtp-Source: AGHT+IHOoWHYu0SeRfmXkWRlZ8L2yrAWrweELwAf9YVuIKdFtnsyWuk2mjoeBxAv48TIps6U714KxCCYIQ1aB9aEnx8=
X-Received: by 2002:a17:906:74cc:b0:a28:61f7:bbdb with SMTP id
 z12-20020a17090674cc00b00a2861f7bbdbmr718639ejl.71.1704266470053; Tue, 02 Jan
 2024 23:21:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102073351.1527503-1-alexs@kernel.org> <xhsmhplykjawj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhplykjawj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Alex Shi <seakeel@gmail.com>
Date: Wed, 3 Jan 2024 15:20:33 +0800
Message-ID: <CAJy-Am=ZCjLFMaDnb7H89tZNVdvbGmEPHGMEUZh-gCQd1bNLXA@mail.gmail.com>
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

Right, I will fix it by adding idle time into sleep. will send the 2nd
version patch.

Thanks
Alex

