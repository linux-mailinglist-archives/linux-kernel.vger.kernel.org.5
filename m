Return-Path: <linux-kernel+bounces-126821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9075893D0F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE22281449
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1914447772;
	Mon,  1 Apr 2024 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b="MZPZjlME"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B1C129
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986496; cv=none; b=DdJobUjXBFwJgMc59P5YZ1x1TDKrOfTgP1Y+Zv5/AQp/UBlftInX+jfCJSzHK6+C8FZofLoz58yNyUl4Oy42VV91YxPBE2y3vGYLaO6rxNlVJ+KC1fkjwJUKKV/n0JyDmY6/edm/C6KGXv7ggO+7Y+S/hz1imcYD+PhYBy19mnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986496; c=relaxed/simple;
	bh=azF8/hcxUG6K6KkLyV3FFvditYCt/oYDNlgBkyM+Hy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itEaHpFl9pbVTbgfzq5r9jKFlr+XCNM4SvMrmcCxSb5No+XKuQIav/r3bHgWIhc1am9gm+rmwjxE2XM9rquI3PVinV+NoR1zno89gXGuGpoKSW19O180TZMwtcvRc8tP20sP10zE3cKpmBuj8SrI51ArR5tXLxCkp0KIgAzmqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro; spf=pass smtp.mailfrom=shruggie.ro; dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b=MZPZjlME; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shruggie.ro
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-515a68d45faso4426355e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20230601.gappssmtp.com; s=20230601; t=1711986490; x=1712591290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNqPY3C+PB/j6jc6GCu0Lbs6WvyaGz158UgpoNY0qSc=;
        b=MZPZjlMEhaWRaN1d36G1afs84pUfCFXvuIIjEOM/mrtzWH4I1hYuHMIT8uv51HplnP
         /a8L1998+AlNlINVvEsQq5SWhxarxf1axuqxi47Jk3FP2hg5rvHaR3ZvHS0KcL/Mzlfe
         PpG/wI0j67mvAmDOdGu6n8AbvBJXNl3awEkFhceGKip8l0SnplAKloG7d7MUkK2pvKA0
         /RZRY/Ne+YW0Zx+Xnlcj0rl43mHHF8TiTAfdPbvjr6LEi0ah66lRAQci8jcPEebqJdC2
         +aubIRdWZywZqMWkVjibhSlUdKQfXOmiOHgKSiQe8i3uC6ZHVI/4UzpH8V9FD00kAjVW
         bC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711986490; x=1712591290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNqPY3C+PB/j6jc6GCu0Lbs6WvyaGz158UgpoNY0qSc=;
        b=mzbvKFgdfnZUm8zZny8REkfLIukIHfIvPX8Q2hynj7vfqHX6/YXXvd5WlvB+sJDu5Y
         JJFKhwu1odT7newltmAyypOhVqvqJQy2BnyaIE02lala7RI9iIcggMzWiLHN8hpr6OcB
         RYLxmUBYOSxV4nfoBESG5zYaBrPtIHOOOAOag954g5MCfSyO1sf2ecAXwpmRzkcvnI8O
         79uLBwM1pGZPwLkV3J0j/ltcrBI43Gd2/+g+HzoivYaACjpr5qnMOjqdlXkYX3VlEUin
         BAICLp16zi0L8jvwKIxzXjb8hF89roHZY4e+cfQ1yy9kn4CA0YRyPBSgk+/iBL4Xzs6X
         CIVA==
X-Gm-Message-State: AOJu0Yz6k9sDkAnUC+LuSda9+W9V88P1C0/8S7Ul/eQG9Pc48qlAsbOv
	bv2J8DGZtShkLgMgyMaFscfZWEMbvUhngbeNNIjr/pDc/8Li5Tr2M1ASsPn+o1rz7PDfAhmb/LS
	Gwm73YYepymZUVnV0CkA8cb3I+mSbgtKl6at+uDG3sZSWitvoXVk=
X-Google-Smtp-Source: AGHT+IGrPiD5FR9NCbVTwvcDqzjazkA26HxRNtjYPpeDH3k/wOU0p4DwQPxL961uT/JIczE+OZznK+FfrfPeEtP6bJA=
X-Received: by 2002:a05:6512:20da:b0:516:a69:c54a with SMTP id
 u26-20020a05651220da00b005160a69c54amr4084940lfr.65.1711986490178; Mon, 01
 Apr 2024 08:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230516122202.954313-1-alex@shruggie.ro> <CAH3L5QoBqSOBHhoxSrYw6U34gqTPEhi_RB_Cve-YmBzYj3LXAQ@mail.gmail.com>
In-Reply-To: <CAH3L5QoBqSOBHhoxSrYw6U34gqTPEhi_RB_Cve-YmBzYj3LXAQ@mail.gmail.com>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Mon, 1 Apr 2024 18:47:58 +0300
Message-ID: <CAH3L5QqZ61H9Fk24R4K3vNdpmvBjnxHaxH7CRTT5Fa3tbot_hg@mail.gmail.com>
Subject: Re: [PATCH][V2] sched/rt: Print curr when RT throttling activated
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	tian.xianting@h3c.com, steffen.aschbacher@stihl.de, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 11:07=E2=80=AFPM Alexandru Ardelean <alex@shruggie.=
ro> wrote:
>
> On Tue, May 16, 2023 at 3:22=E2=80=AFPM Alexandru Ardelean <alex@shruggie=
ro> wrote:
> >
> > From: Xianting Tian <tian.xianting@h3c.com>
> >
> > We may meet the issue, that one RT thread occupied the cpu by 950ms/1s,
> > The RT thread maybe is a business thread or other unknown thread.
> >
> > Currently, it only outputs the print "sched: RT throttling activated"
> > when RT throttling happen. It is hard to know what is the RT thread,
> > For further analysis, we need add more prints.
> >
> > This patch is to print current RT task when RT throttling activated,
> > It help us to know what is the RT thread in the first time.
> >
>
> Adding Greg on this patch, since it 's been a while.
> And also: ping :)

Ping on this :)

Thanks
Alex

>
> > Tested-by: Alexandru Ardelean <alex@shruggie.ro>
> > Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> > ---
> >
> > Initial patch submission:
> >   https://lore.kernel.org/all/f3265adc26d4416dacf157f61fa60ad6@h3c.com/=
T/
> >
> > We've been having some issues of our own with some applications + some =
RT
> > configuration =3D=3D some threads endded up taking too much CPU time.
> > This patch came in quite in handy to see in logs which thread is more
> > problematic.
> >
> > We've applied this patch onto a 5.10.116 tree. It did need a bit of
> > re-applying since some context has changed since the initial version (h=
ence
> > the V2 tag).
> > Since 5.10.116 (where we used it), it applied nicely to the latest/curr=
ent
> > linux-next tree (hence the Tested-by tag).
> >
> > It would be nice to apply this to the mainline kernel and have this han=
dy.
> >
> >  kernel/sched/rt.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index 00e0e5074115..44b161e42733 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -995,7 +995,7 @@ static inline int rt_se_prio(struct sched_rt_entity=
 *rt_se)
> >         return rt_task_of(rt_se)->prio;
> >  }
> >
> > -static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
> > +static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq, struct task_=
struct *curr)
> >  {
> >         u64 runtime =3D sched_rt_runtime(rt_rq);
> >
> > @@ -1019,7 +1019,8 @@ static int sched_rt_runtime_exceeded(struct rt_rq=
 *rt_rq)
> >                  */
> >                 if (likely(rt_b->rt_runtime)) {
> >                         rt_rq->rt_throttled =3D 1;
> > -                       printk_deferred_once("sched: RT throttling acti=
vated\n");
> > +                       printk_deferred_once("sched: RT throttling acti=
vated (curr: pid %d, comm %s)\n",
> > +                                               curr->pid, curr->comm);
> >                 } else {
> >                         /*
> >                          * In case we did anyway, make it go away,
> > @@ -1074,7 +1075,7 @@ static void update_curr_rt(struct rq *rq)
> >                 if (sched_rt_runtime(rt_rq) !=3D RUNTIME_INF) {
> >                         raw_spin_lock(&rt_rq->rt_runtime_lock);
> >                         rt_rq->rt_time +=3D delta_exec;
> > -                       exceeded =3D sched_rt_runtime_exceeded(rt_rq);
> > +                       exceeded =3D sched_rt_runtime_exceeded(rt_rq, c=
urr);
> >                         if (exceeded)
> >                                 resched_curr(rq);
> >                         raw_spin_unlock(&rt_rq->rt_runtime_lock);
> > --
> > 2.40.1
> >

