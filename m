Return-Path: <linux-kernel+bounces-84284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82A786A48F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489551F23C6A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB2A290F;
	Wed, 28 Feb 2024 00:49:59 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8FD23BD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709081399; cv=none; b=FlpFOQJ/fHFZ+GvdNi1gJNCh/l2MPbGpnmXyj2hpXXDGi32D1tyLmD/k1LKPIH3F/87Xg5o8iSFvUMAtpu6zHOZp+oqKJ8lgPqctnbwG/DCH/NcfIfPF5GSJFMHBrYiHPVvbiFnuVx1H3YiReNjrSGzCAEjqAmdm+Fbsu64ygv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709081399; c=relaxed/simple;
	bh=dIBr8tyIVMUn1qvp0/S8KjT65BOAIIB1EYw9sFoLihI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wtcmo8X+uRLbuiqArwp4fqkdgX8+veI862CHAzPBq+dwbF8kB3X/ZzxLZ3V4GHJEPfA+n+QOEluHp/cn7NjIN6izdW2ADzmCSaQ8vZAzb238oYCeJfbaIgOLXX1/LH5hQbLIa6TjApnhuthIFXV9sooC+yKavvIlsdrSoXDY6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e4670921a4so2812054b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:49:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709081397; x=1709686197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04obEC+ENFXzX+FFFDRk5S/y1ymFZwYaQ9bqc+hwyH8=;
        b=eOXvlS7eD2zPvMgc+19aqRCu/3583KIfGaW5nMW5NOII4KhCvKapyY6M9lNm7FY6q8
         ErYhcapuvXoA0uWlFtSZEymV96cCMgJgUfGWVNoc4L8Sa1LO6/jgsAuYJPDPEidxLPZ5
         /RypJ6YAIhghqiUjb+uKRbJTFOTWcQhJkt5DupzdlT7myiuh8u9SEtsHcg+nxu4LEEfj
         /57AB2urNFJCqQTgcihwWRFcpr+Oj8thrpwwxXK2WN8Tw88jqgZAlPFYEwY53uw8LwRC
         eGfCB/WXk/S7OjXUv1FtaU8VHcFQMYAYoGqYOWDIGprWApos1iZizjGtI1wnJ7WBiu/m
         K+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUfZqEXYA2ynjAG/8RWE3EdOfwfJ/EKMhEQPvWpMHH019Jb+EtKxeN7wAXuR5U/XHJ8EvX2YW7XA4Zbn2Urtmgv9nNHcrdSp/OuKP0a
X-Gm-Message-State: AOJu0YyM/1ZRqx9YYyMxiHv9xFiPVHc5llCcw51CIwBh8JwT4o7jeA3g
	m2G8V7FdZuYGy9U1l/df5ayrN2u7dlcHM+fOLr8ey3HwrhJAVxBvXPVo8tnDVJlsRUwee4Azh/y
	JKfWkDGopLypVOg6y29XaDPk4u9I=
X-Google-Smtp-Source: AGHT+IE2miWAg41zHicaEmDtu9qPyIlvHS7MYa/ojzQAlGzQI6hKbxD470BGBS1f2Bi6s0mdGcHFXAYeNWxQ4ihuGSc=
X-Received: by 2002:a05:6a20:d90f:b0:199:7d51:a942 with SMTP id
 jd15-20020a056a20d90f00b001997d51a942mr4419552pzb.50.1709081396946; Tue, 27
 Feb 2024 16:49:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108215322.2845536-1-namhyung@kernel.org> <CAM9d7chyJun57UV-6qRzgTzDEmUu5Z0mStgjRbrg2dcjUkMQzw@mail.gmail.com>
 <CAM9d7cjQv=RiOkW5=7vXUSwQn5v1XQNiJyL9egGy2VgmKWO69Q@mail.gmail.com> <c29d648c-451a-42af-81d3-e1660e3af46f@redhat.com>
In-Reply-To: <c29d648c-451a-42af-81d3-e1660e3af46f@redhat.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 27 Feb 2024 16:49:45 -0800
Message-ID: <CAM9d7cip9xBfx+ZW06TO7BhKvTkQgQ=UZfrc+UOb3wOUrt8VYg@mail.gmail.com>
Subject: Re: [PATCH] locking/percpu-rwsem: Trigger contention tracepoints only
 if contended
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:19=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
>
> On 2/27/24 18:02, Namhyung Kim wrote:
> > Hello,
> >
> > On Mon, Nov 20, 2023 at 12:28=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> >> Ping!
> >>
> >> On Wed, Nov 8, 2023 at 1:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> >>> It mistakenly fires lock contention tracepoints always in the writer =
path.
> >>> It should be conditional on the try lock result.
> > Can anybody take a look at this?  This makes a large noise
> > in the lock contention result.
> >
> > Thanks,
> > Namhyung
> >
> >>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >>> ---
> >>>   kernel/locking/percpu-rwsem.c | 11 ++++++++---
> >>>   1 file changed, 8 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rw=
sem.c
> >>> index 185bd1c906b0..6083883c4fe0 100644
> >>> --- a/kernel/locking/percpu-rwsem.c
> >>> +++ b/kernel/locking/percpu-rwsem.c
> >>> @@ -223,9 +223,10 @@ static bool readers_active_check(struct percpu_r=
w_semaphore *sem)
> >>>
> >>>   void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
> >>>   {
> >>> +       bool contended =3D false;
> >>> +
> >>>          might_sleep();
> >>>          rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
> >>> -       trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
> >>>
> >>>          /* Notify readers to take the slow path. */
> >>>          rcu_sync_enter(&sem->rss);
> >>> @@ -234,8 +235,11 @@ void __sched percpu_down_write(struct percpu_rw_=
semaphore *sem)
> >>>           * Try set sem->block; this provides writer-writer exclusion=
.
> >>>           * Having sem->block set makes new readers block.
> >>>           */
> >>> -       if (!__percpu_down_write_trylock(sem))
> >>> +       if (!__percpu_down_write_trylock(sem)) {
> >>> +               trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRIT=
E);
> >>>                  percpu_rwsem_wait(sem, /* .reader =3D */ false);
> >>> +               contended =3D true;
> >>> +       }
> >>>
> >>>          /* smp_mb() implied by __percpu_down_write_trylock() on succ=
ess -- D matches A */
> >>>
> >>> @@ -247,7 +251,8 @@ void __sched percpu_down_write(struct percpu_rw_s=
emaphore *sem)
> >>>
> >>>          /* Wait for all active readers to complete. */
> >>>          rcuwait_wait_event(&sem->writer, readers_active_check(sem), =
TASK_UNINTERRUPTIBLE);
> >>> -       trace_contention_end(sem, 0);
> >>> +       if (contended)
> >>> +               trace_contention_end(sem, 0);
> >>>   }
> >>>   EXPORT_SYMBOL_GPL(percpu_down_write);
> >>>
> >>> --
> >>> 2.42.0.869.gea05f2083d-goog
>
> Yes, that makes sense. Sorry for missing this patch.
>
> Reviewed-by: Waiman Long <longman@redhat.com>

Thanks for your review.
Namhyung

