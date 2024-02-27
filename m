Return-Path: <linux-kernel+bounces-84157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBFF86A337
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101A61F26D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E98255C3B;
	Tue, 27 Feb 2024 23:03:44 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE154673
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075023; cv=none; b=E6bvYIGOQVs/Mhol0YdVDHKHuy7tZYtHYUn+LPQZOXqGiKGmjtE+0Dv/uDaxJufMfMw+twtPaeZH+m8hv5whYr2G0aanMImYnqi+v7dVR+CFE9NBzxmtG0vBf2tJUeOGylRA6qzkaU9Eef8trbQaRlnx6cN4JUbcnUc8NYb2ydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075023; c=relaxed/simple;
	bh=fEiZgSHvNuV5y5GWdUEH7fQIpdPbeRE8BcxiPZEW5So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFViZRhlPUT7x1962WE4x+RARq4cYz0sJnBmKX1G3nTfeg6ROqQpW1FNiC8Smv/5map7xYbDxX2iOjic0wwMmWwoEK2M1BD45/s4rE7tQX+2L0DVfjVpSI6dZoCG4pJ/G2W49i3ZuOgyMvavkFOY52E0E1FZbYXjP1aHNKl6EIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29a61872f4eso3625320a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:03:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709075021; x=1709679821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKFCM2tq1VNW7j6D5VilZZgnxKqEe53fwqXWBCUqD/8=;
        b=QymV9a71Ev8CQ2jRrVckxZoItINy8SvYtjPMVkdhgX7rKBsNlSQKj2SMuWOlGim7qD
         2CYsd871KZV0CCKyTW3u3CIfjqPDehlSi2XIVNAiP/PsG15Z6fjMxD/DLb5d6lK8cwE0
         iIdkE/TWzuN4ycnntVMn9bg4CRDlXVeVu4cnTOyu6ITc5raUV5SCZWemX30jkqUS1bDg
         ZYMqa6h7EPQ44IoQQthv/Vduu4kx1lV/58a79vjYeJY9CXZIRAgVQoXFCH3IykHIcVGu
         uyid5UwawspDsKjccSfpqsFaAMb5/oNWD4pN7ksr3i905xjdATPr2cGpj8j2NAuxMHNU
         tJGg==
X-Forwarded-Encrypted: i=1; AJvYcCUEmHkmBI51TrTOF7gcSgeet0nFx/ABI0UPP/L2hNERkFkmM2SczimLkfUvSIhaSIM/0OyTzOyvmW35/w+U6Afwm6b4VZLd/n+0OWBk
X-Gm-Message-State: AOJu0YwlVN7INqDYkIIDCA3vlsYJDsKsrdkt9EduM6X8gCKXf+81lH7A
	zEk39A/qdmeX7JpM2iivrC5b4ZUs0b8sV6mFDOpkIV7HxahE2ZdO2N69volGKPbJ+a5DkncmGc5
	4zTBXrp9+r6WnnO90escu9kpytSc=
X-Google-Smtp-Source: AGHT+IFaUQhUebFhjP6GREdUnQ3uGrJu7R8q1/EDC/D5JRmy9D0Zopfvpn41yoH9PC/tjk4okcq8bjYOvPEJGiMSfXA=
X-Received: by 2002:a17:90a:c587:b0:299:5d8a:434b with SMTP id
 l7-20020a17090ac58700b002995d8a434bmr9919876pjt.40.1709075021522; Tue, 27 Feb
 2024 15:03:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108215322.2845536-1-namhyung@kernel.org> <CAM9d7chyJun57UV-6qRzgTzDEmUu5Z0mStgjRbrg2dcjUkMQzw@mail.gmail.com>
In-Reply-To: <CAM9d7chyJun57UV-6qRzgTzDEmUu5Z0mStgjRbrg2dcjUkMQzw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 27 Feb 2024 15:02:57 -0800
Message-ID: <CAM9d7cjQv=RiOkW5=7vXUSwQn5v1XQNiJyL9egGy2VgmKWO69Q@mail.gmail.com>
Subject: Re: [PATCH] locking/percpu-rwsem: Trigger contention tracepoints only
 if contended
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Nov 20, 2023 at 12:28=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Ping!
>
> On Wed, Nov 8, 2023 at 1:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > It mistakenly fires lock contention tracepoints always in the writer pa=
th.
> > It should be conditional on the try lock result.

Can anybody take a look at this?  This makes a large noise
in the lock contention result.

Thanks,
Namhyung

> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  kernel/locking/percpu-rwsem.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwse=
m.c
> > index 185bd1c906b0..6083883c4fe0 100644
> > --- a/kernel/locking/percpu-rwsem.c
> > +++ b/kernel/locking/percpu-rwsem.c
> > @@ -223,9 +223,10 @@ static bool readers_active_check(struct percpu_rw_=
semaphore *sem)
> >
> >  void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
> >  {
> > +       bool contended =3D false;
> > +
> >         might_sleep();
> >         rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
> > -       trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
> >
> >         /* Notify readers to take the slow path. */
> >         rcu_sync_enter(&sem->rss);
> > @@ -234,8 +235,11 @@ void __sched percpu_down_write(struct percpu_rw_se=
maphore *sem)
> >          * Try set sem->block; this provides writer-writer exclusion.
> >          * Having sem->block set makes new readers block.
> >          */
> > -       if (!__percpu_down_write_trylock(sem))
> > +       if (!__percpu_down_write_trylock(sem)) {
> > +               trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE)=
;
> >                 percpu_rwsem_wait(sem, /* .reader =3D */ false);
> > +               contended =3D true;
> > +       }
> >
> >         /* smp_mb() implied by __percpu_down_write_trylock() on success=
 -- D matches A */
> >
> > @@ -247,7 +251,8 @@ void __sched percpu_down_write(struct percpu_rw_sem=
aphore *sem)
> >
> >         /* Wait for all active readers to complete. */
> >         rcuwait_wait_event(&sem->writer, readers_active_check(sem), TAS=
K_UNINTERRUPTIBLE);
> > -       trace_contention_end(sem, 0);
> > +       if (contended)
> > +               trace_contention_end(sem, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(percpu_down_write);
> >
> > --
> > 2.42.0.869.gea05f2083d-goog
> >

