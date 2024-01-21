Return-Path: <linux-kernel+bounces-31957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F443835446
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 04:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29B21F21F78
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 03:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8246C3611B;
	Sun, 21 Jan 2024 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta4oaK+d"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A82AE8F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 03:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705806294; cv=none; b=KFGvI+/RAlJ+VG5WgLg6yEH2TCHOjIOYQyE+EYKYCwDhlGyiaufay/e+tAu8Skq2uTabB2a8B3KdHStnk3X/fRYAeIMt51e/qACnGnLGJG2gaOVixxBDie7UjQY3ak4ypS286cRG2XJSn5BM27WuYEx3zDeJs+1U/Zb1GbgCGJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705806294; c=relaxed/simple;
	bh=vomMp40zGwEWXYmwIXZy+I2UyrExHpCxRhL+2O4FDSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/2uXZ4vtKrM2s2bDMJMbm/nG+aS5WcT1RYYEFbDQFV08asetKfjcDde8aaumnfltzD6vExKYU4u04iOAb5d0O6HjikxvjIpvnBYA8SKESMJI0Imjd2QMMNAa9zaYmR98OW8whyV0F2X3QIiX8uci6fjAO2QASlUpF52GFOL0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ta4oaK+d; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so23064095e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 19:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705806291; x=1706411091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8c7Bt3byd9RTRdaOa3TR1Whczb8x0dQJ8VIo3/hb8M=;
        b=Ta4oaK+dIINXa2Y/Sa3pKhwVV5Y+vn07xLVH61mWfYRKWmylNB5eX62FIPH6YhnHlJ
         LAhzXXvMjT5vLEkO4fiaI22GpmsKiGU6ArO+ZrO9XjMbQRv2yIO1gblA9CmgGfCVjnC4
         3td1O6j5kMDQoHa4wkUasbYjnNbCHF37z/6CY7/LIfmWotT+W3m9IeUXbImt+weZfitk
         YXq9okao3I78c83N+V7JavDsbypsTI9HWh6oXMz8V5iVrw7jHzTYqGKYUqMNoMCIkyoL
         7v2XNA52rqGiyU5fqoN428R53o5tMOVS2fP0npURoQilVTz6kHj+PwS24AcBOQ945TtC
         ay5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705806291; x=1706411091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8c7Bt3byd9RTRdaOa3TR1Whczb8x0dQJ8VIo3/hb8M=;
        b=TZYYReFtU7WpGok7oQLADVmoK0eHGQyZwPD5T0xkPXbJkLnq0NOpKQ+RPE79rL4FSz
         ptwishfzbBxZCty15bqo6fMpjERqPKXHK2SMrGlNOwf27FFM+Y8dJNr7Xn6qMwl7D1TR
         qOUCFuLSGdmbSPheKcU5EBfmWP5Ab1Hig4s29C3kETb+0HHpxXF2U5kK+3TKXE8lytpz
         hSA0YpOfPczuIG1YDUlIBoz7TL5BigoZ/VDcjftxCkIhra1+on6VSLzbx2v3IFtiDLZm
         NzV0xAFSb/iempma2qkv6TGTJqvubOnmNrrwKhz/obgUN6YrM5rY/JhwIpob3V5MuWZr
         thdQ==
X-Gm-Message-State: AOJu0Yy5l/qP0G3reao4MqO0Leq6LN3kSZtAJY5RlYHNgAw/orf5p7JR
	lXhWYhqUt/TLWEj4hSwMZSyVw6pGnP70gbopUxTGa6w0yuSvKmzRM0aCqYxdADfIfBv/G8G5EGV
	rOvCzJKVpo4mwkebeJOTWDWTI5NI=
X-Google-Smtp-Source: AGHT+IGF6PbGDBCI59WdnM2lX1xWzGACoC59QUKYUf/NiCcUc7xtWgtcQqS0L0ZFODfR59NAxkkeynLlfp9wSytyiY0=
X-Received: by 2002:a05:600c:4513:b0:40d:5575:a197 with SMTP id
 t19-20020a05600c451300b0040d5575a197mr1147431wmo.12.1705806290932; Sat, 20
 Jan 2024 19:04:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
 <20240117031212.1104034-5-nunes.erico@gmail.com> <CAKGbVbv-4e7w8_8AGvFd358j-QcG8KJ1zdUZ3kit9odSCatZ5w@mail.gmail.com>
In-Reply-To: <CAKGbVbv-4e7w8_8AGvFd358j-QcG8KJ1zdUZ3kit9odSCatZ5w@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Sun, 21 Jan 2024 11:04:38 +0800
Message-ID: <CAKGbVbugkHADEw_EigJmrVJzc4NSaHRpvL-3HRdw6U_=5B5u7Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] drm/lima: handle spurious timeouts due to high irq latency
To: Erico Nunes <nunes.erico@gmail.com>
Cc: dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	anarsoul@gmail.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 9:43=E2=80=AFAM Qiang Yu <yuq825@gmail.com> wrote:
>
> On Wed, Jan 17, 2024 at 11:12=E2=80=AFAM Erico Nunes <nunes.erico@gmail.c=
om> wrote:
> >
> > There are several unexplained and unreproduced cases of rendering
> > timeouts with lima, for which one theory is high IRQ latency coming fro=
m
> > somewhere else in the system.
> > This kind of occurrence may cause applications to trigger unnecessary
> > resets of the GPU or even applications to hang if it hits an issue in
> > the recovery path.
> > Panfrost already does some special handling to account for such
> > "spurious timeouts", it makes sense to have this in lima too to reduce
> > the chance that it hit users.
> >
> > Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
> > ---
> >  drivers/gpu/drm/lima/lima_sched.c | 32 ++++++++++++++++++++++++++-----
> >  drivers/gpu/drm/lima/lima_sched.h |  2 ++
> >  2 files changed, 29 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/l=
ima_sched.c
> > index 66317296d831..9449b81bcd5b 100644
> > --- a/drivers/gpu/drm/lima/lima_sched.c
> > +++ b/drivers/gpu/drm/lima/lima_sched.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0 OR MIT
> >  /* Copyright 2017-2019 Qiang Yu <yuq825@gmail.com> */
> >
> > +#include <linux/hardirq.h>
> >  #include <linux/iosys-map.h>
> >  #include <linux/kthread.h>
> >  #include <linux/slab.h>
> > @@ -223,10 +224,7 @@ static struct dma_fence *lima_sched_run_job(struct=
 drm_sched_job *job)
> >
> >         task->fence =3D &fence->base;
> >
> > -       /* for caller usage of the fence, otherwise irq handler
> > -        * may consume the fence before caller use it
> > -        */
> > -       dma_fence_get(task->fence);
> > +       task->done_fence =3D dma_fence_get(task->fence);
> >
> >         pipe->current_task =3D task;
> >
> > @@ -401,9 +399,33 @@ static enum drm_gpu_sched_stat lima_sched_timedout=
_job(struct drm_sched_job *job
> >         struct lima_sched_pipe *pipe =3D to_lima_pipe(job->sched);
> >         struct lima_sched_task *task =3D to_lima_task(job);
> >         struct lima_device *ldev =3D pipe->ldev;
> > +       struct lima_ip *ip =3D pipe->processor[0];
> > +
> > +       /*
> > +        * If the GPU managed to complete this jobs fence, the timeout =
is
> > +        * spurious. Bail out.
> > +        */
> > +       if (dma_fence_is_signaled(task->done_fence)) {
> > +               DRM_WARN("%s spurious timeout\n", lima_ip_name(ip));
> > +               return DRM_GPU_SCHED_STAT_NOMINAL;
> > +       }
> > +
> You may just remove this check and left the check after sync irq.
>
After more thinking, this is only for handling spurious timeouts more
efficiently, not for totally reliable timeout handling. So this check shoul=
d
be OK.

> > +       /*
> > +        * Lima IRQ handler may take a long time to process an interrup=
t
> > +        * if there is another IRQ handler hogging the processing.
> > +        * In order to catch such cases and not report spurious Lima jo=
b
> > +        * timeouts, synchronize the IRQ handler and re-check the fence
> > +        * status.
> > +        */
> > +       synchronize_irq(ip->irq);
> This should be done after drm_sched_stop() to prevent drm scheduler
> run more jobs. And we need to disable interrupt of GP/PP for no more
> running job triggered fresh INT.
This is OK too. We just need to solve reliable timeout handling after
drm_sched_stop() in another patch.

>
> PP may have more than one IRQ, so we need to wait on all of them.
>
> > +
> > +       if (dma_fence_is_signaled(task->done_fence)) {
> > +               DRM_WARN("%s unexpectedly high interrupt latency\n", li=
ma_ip_name(ip));
> > +               return DRM_GPU_SCHED_STAT_NOMINAL;
> > +       }
> >
> >         if (!pipe->error)
> > -               DRM_ERROR("lima job timeout\n");
> > +               DRM_ERROR("%s lima job timeout\n", lima_ip_name(ip));
> >
> >         drm_sched_stop(&pipe->base, &task->base);
> >
> > diff --git a/drivers/gpu/drm/lima/lima_sched.h b/drivers/gpu/drm/lima/l=
ima_sched.h
> > index 6a11764d87b3..34050facb110 100644
> > --- a/drivers/gpu/drm/lima/lima_sched.h
> > +++ b/drivers/gpu/drm/lima/lima_sched.h
> > @@ -29,6 +29,8 @@ struct lima_sched_task {
> >         bool recoverable;
> >         struct lima_bo *heap;
> >
> > +       struct dma_fence *done_fence;
> > +
> >         /* pipe fence */
> >         struct dma_fence *fence;
> >  };
> > --
> > 2.43.0
> >

