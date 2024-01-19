Return-Path: <linux-kernel+bounces-30689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D7832311
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C11028445A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F44A137E;
	Fri, 19 Jan 2024 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxtRkBlk"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B41362
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628602; cv=none; b=KQTFJixKTOVIfjci7l7WIkq8R8v5tSVZ0uJVkRCzFhkX/genVe9lsHZNW3pKd1oM0V9cErxj+GRO/DB0HtzdlcVoge5Dbjxq01J0uRQRHncxbCC0rOXktMHpIBPZrmPuvXL79SlICIJaE/Irh4nvCylZunZnT/pzk8mM23s0Yhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628602; c=relaxed/simple;
	bh=sEdCMRDHx8TWPG1oAi+hdVIcRvmKKy2SnyQb7Jp6AYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qy73xA6RQo4SyiTI/51Ubk6kwdG1p4jSw3ZyeIzJM/sQM37GHWTycNitA3QghU2//juCvg+P1l3OhZY5B9HIjYhAvLQ/qP36UCECUXO5XZFLBIHZTwfdvJufkgUOvEBuBdax9mN6+BmVsQgAvZIYKeVFfP08TrIDRfurmOKywRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxtRkBlk; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-555e07761acso267266a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705628599; x=1706233399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Uj9bxMJboKddkDeF9s1beNT2b+6oUXT7D7uJLWJvtg=;
        b=OxtRkBlkyRSYGN9liIGzGhIsAB4uLOuLMDAaCJCutq8W01cT6tB7VeSphsGzY7goqo
         RYvohCcW3zIgtIqpO6/nZMUJp4oyUHqoLvb7V/Aalc4a7XO6OtX9au2Le1zkJCKv3Ye6
         L2wwcj3TOfE56Ql0tKfDaSZYGDG5EMCSQMTZTrRlq7OmjPo2xtPYQEErB7WO7mgc5FM6
         b/JgzfdSF7k3O2CSSexuBh/ApONiGNcnWy+VWGDX/3zx82yITe3XJzp723j05B/DIn9V
         UzJVYbhGsY2nsiTuJrQMYaUPNIGce3HoDyCpu+6XixuKUQfgy7HRstcNiOaO7oilhVmJ
         BNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705628599; x=1706233399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Uj9bxMJboKddkDeF9s1beNT2b+6oUXT7D7uJLWJvtg=;
        b=trdtKAewIbkK8YR3/TZ9FTeABocQ8q0ufejlSTO1a17zj6EIQVky3w1mawdRSDyhbw
         +eesFS3M1sBxza6RirU2vg02IIcAiYJCd/9Lrufmfx+NysIU6kxaCfkbkhLmhY+lxPg3
         K/c9WhSHgqsxsXkRu9jLacTC43xQUgRmALs6vjvqd7m2qa8/862VY2CS7M5e+/krUZwb
         koP6jTlHyY9VhyK7V0dqIpwfGuDKIKAN2l3Nnv2KN460kKKufuhbaZqbZocBI8Kc4UlC
         mYe75PWCo2IA4ay7Awj+rFs0vnY+LuDgYoCU5jEWqyo5hKVyMpIrsS+mLznj0djqknuJ
         XLBg==
X-Gm-Message-State: AOJu0YxmdWB0sJstC9z9eqrsvG9TywV43Lh9MpjPRBNBHAUmXbBx5E/e
	Hba00dS3oUass7n4P1vVpNxPs3kgaMuaOFYgUjVTCJ/175iiJWmuKloiBAPfr11Q+M+eCPjpFxG
	rQmar53jlddKB6OP+/r8NC+HnKuo=
X-Google-Smtp-Source: AGHT+IEJ1mUUmSNh1sqI1jfAL4Du2cur2X+seSx1zn2ZZlOgvSUUTBkcIOLxF0e4Y/6Fn1AS8ht2/Hi+HrvnCBX+Kvg=
X-Received: by 2002:a05:6402:34c4:b0:55a:4dfa:baa6 with SMTP id
 w4-20020a05640234c400b0055a4dfabaa6mr310534edc.62.1705628599081; Thu, 18 Jan
 2024 17:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com> <20240117031212.1104034-5-nunes.erico@gmail.com>
In-Reply-To: <20240117031212.1104034-5-nunes.erico@gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Fri, 19 Jan 2024 09:43:06 +0800
Message-ID: <CAKGbVbv-4e7w8_8AGvFd358j-QcG8KJ1zdUZ3kit9odSCatZ5w@mail.gmail.com>
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

On Wed, Jan 17, 2024 at 11:12=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com=
> wrote:
>
> There are several unexplained and unreproduced cases of rendering
> timeouts with lima, for which one theory is high IRQ latency coming from
> somewhere else in the system.
> This kind of occurrence may cause applications to trigger unnecessary
> resets of the GPU or even applications to hang if it hits an issue in
> the recovery path.
> Panfrost already does some special handling to account for such
> "spurious timeouts", it makes sense to have this in lima too to reduce
> the chance that it hit users.
>
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
> ---
>  drivers/gpu/drm/lima/lima_sched.c | 32 ++++++++++++++++++++++++++-----
>  drivers/gpu/drm/lima/lima_sched.h |  2 ++
>  2 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lim=
a_sched.c
> index 66317296d831..9449b81bcd5b 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0 OR MIT
>  /* Copyright 2017-2019 Qiang Yu <yuq825@gmail.com> */
>
> +#include <linux/hardirq.h>
>  #include <linux/iosys-map.h>
>  #include <linux/kthread.h>
>  #include <linux/slab.h>
> @@ -223,10 +224,7 @@ static struct dma_fence *lima_sched_run_job(struct d=
rm_sched_job *job)
>
>         task->fence =3D &fence->base;
>
> -       /* for caller usage of the fence, otherwise irq handler
> -        * may consume the fence before caller use it
> -        */
> -       dma_fence_get(task->fence);
> +       task->done_fence =3D dma_fence_get(task->fence);
>
>         pipe->current_task =3D task;
>
> @@ -401,9 +399,33 @@ static enum drm_gpu_sched_stat lima_sched_timedout_j=
ob(struct drm_sched_job *job
>         struct lima_sched_pipe *pipe =3D to_lima_pipe(job->sched);
>         struct lima_sched_task *task =3D to_lima_task(job);
>         struct lima_device *ldev =3D pipe->ldev;
> +       struct lima_ip *ip =3D pipe->processor[0];
> +
> +       /*
> +        * If the GPU managed to complete this jobs fence, the timeout is
> +        * spurious. Bail out.
> +        */
> +       if (dma_fence_is_signaled(task->done_fence)) {
> +               DRM_WARN("%s spurious timeout\n", lima_ip_name(ip));
> +               return DRM_GPU_SCHED_STAT_NOMINAL;
> +       }
> +
You may just remove this check and left the check after sync irq.

> +       /*
> +        * Lima IRQ handler may take a long time to process an interrupt
> +        * if there is another IRQ handler hogging the processing.
> +        * In order to catch such cases and not report spurious Lima job
> +        * timeouts, synchronize the IRQ handler and re-check the fence
> +        * status.
> +        */
> +       synchronize_irq(ip->irq);
This should be done after drm_sched_stop() to prevent drm scheduler
run more jobs. And we need to disable interrupt of GP/PP for no more
running job triggered fresh INT.

PP may have more than one IRQ, so we need to wait on all of them.

> +
> +       if (dma_fence_is_signaled(task->done_fence)) {
> +               DRM_WARN("%s unexpectedly high interrupt latency\n", lima=
_ip_name(ip));
> +               return DRM_GPU_SCHED_STAT_NOMINAL;
> +       }
>
>         if (!pipe->error)
> -               DRM_ERROR("lima job timeout\n");
> +               DRM_ERROR("%s lima job timeout\n", lima_ip_name(ip));
>
>         drm_sched_stop(&pipe->base, &task->base);
>
> diff --git a/drivers/gpu/drm/lima/lima_sched.h b/drivers/gpu/drm/lima/lim=
a_sched.h
> index 6a11764d87b3..34050facb110 100644
> --- a/drivers/gpu/drm/lima/lima_sched.h
> +++ b/drivers/gpu/drm/lima/lima_sched.h
> @@ -29,6 +29,8 @@ struct lima_sched_task {
>         bool recoverable;
>         struct lima_bo *heap;
>
> +       struct dma_fence *done_fence;
> +
>         /* pipe fence */
>         struct dma_fence *fence;
>  };
> --
> 2.43.0
>

