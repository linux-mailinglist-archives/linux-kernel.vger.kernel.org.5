Return-Path: <linux-kernel+bounces-22379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0C5829CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC8F285372
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDDD4BA84;
	Wed, 10 Jan 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xz1tkqRl"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20B48CCE;
	Wed, 10 Jan 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so49697731fa.0;
        Wed, 10 Jan 2024 06:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704898506; x=1705503306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OgyR+ukWv0ZDFT7MD1S3e5qHTjIQxas4XOabhlAMc4=;
        b=Xz1tkqRl0b3sFvvn1W1mOfJxhECpXK8wNH8ix+7RjLxjf3V5TjVjuYwjzQEyVgNPk5
         2Ndf77AcgtF+cdzLf9k4IgqDPpFaXLLDS91tceQGBJnVgRTTpnB3iXjISpvxaz199XYM
         TcqkEwD8Dfg03wbQZLf2IZHe/JPgeocJ/LlxGyB/ZuTDNBtN6MHppwwhwG7XuB7co6he
         BRsSyZLNifDes11e+9eeSyg2UvTFLG695yFc1qY0JanwrUyDkHG37edEYVGBvRnxUzYz
         7pyLmtJup+1zCvczCBuRloC7AT5WJzV6/n82JrBsO5BhoViN60ED2H2hL51Gnll7eQdx
         sC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898506; x=1705503306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OgyR+ukWv0ZDFT7MD1S3e5qHTjIQxas4XOabhlAMc4=;
        b=LrJppwqBwJIhnrMhV+PA5+vpbPevs03tqCHtdwpZzcaq5daKZy8Nk48nJnAyESqzuv
         qD2ceAEmZlGKP/N3ehRz8IVGyiCO7LAS5mPfrngG8knNqU1KJdBOMhrH9IU5byGohKbJ
         ox0pDgY+EHSP4N/ALWZIzreSv6aNkH8kbdjrfVT8D06a8WonpjjqxtOpWEZZ/Jw7xTN6
         JYWgwkoX8DE3h+ZHYo6skghBmYyWPr7qLM4Neu6zNgDPuXcJiF3jXyPo7heCAY62F44I
         MplcOyaPW/TQAL6xmzmb4rBDQ4jpxBrfx+jrHdrFeUcb57YfRbC9sqgEIoZA5q0tI+Fs
         yq5w==
X-Gm-Message-State: AOJu0YxDRjvie4xRYXhyqnKrwo5mKOFyvb7Ha8b13CpzNlfobm/kZALL
	lE0XwJ9IZ5HF+MzdLU0/lB6VSXcXLC2JdLtlA9jaJkUj
X-Google-Smtp-Source: AGHT+IH5zqO057mcocJ4I+GZxwLsrDWD8i7g35DwdFAwR9pfBQNmh3d7p+YMnEe0KuudH+4klSpSupj07kho3Jh0HfQ=
X-Received: by 2002:a2e:9dd8:0:b0:2cd:16fe:da17 with SMTP id
 x24-20020a2e9dd8000000b002cd16feda17mr609164ljj.71.1704898505430; Wed, 10 Jan
 2024 06:55:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109182218.193804-1-robdclark@gmail.com> <ZZ52YNc-TkeG7PZO@phenom.ffwll.local>
In-Reply-To: <ZZ52YNc-TkeG7PZO@phenom.ffwll.local>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 10 Jan 2024 06:54:53 -0800
Message-ID: <CAF6AEGusfKGou-=4y4CDd99x6TgJ1ZhAmnKwQJs1k6s8Bu07SQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/msm/gpu: Push gpu lock down past runpm"
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	Rob Clark <robdclark@chromium.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 2:50=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> wro=
te:
>
> On Tue, Jan 09, 2024 at 10:22:17AM -0800, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > This reverts commit abe2023b4cea192ab266b351fd38dc9dbd846df0.
> >
> > Changing the locking order means that scheduler/msm_job_run() can race
> > with the recovery kthread worker, with the result that the GPU gets an
> > extra runpm get when we are trying to power it off.  Leaving the GPU in
> > an unrecovered state.
>
> The recovery kthread is supposed to stop all the relevant schedulers,
> which should remove any possible race conditions. So unless there's more
> going on, or you have your own recovery kthread (don't, reuse the one fro=
m
> the scheduler with your own work items, that's why you can provide that)
> this looks like an incomplete/incorrect explanation ... ?
>
> Slightly confused

msm still uses it's own recovery, which pre-dates the scheduler
conversion.  At one point (a yr or two back?) I started looking at
integrating recovery w/ scheduler.. at the time I think you talked me
out of it, but I don't remember the reason

BR,
-R

> -Sima
>
> >
> > I'll need to come up with a different scheme for appeasing lockdep.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/msm_gpu.c        | 11 +++++------
> >  drivers/gpu/drm/msm/msm_ringbuffer.c |  7 +++++--
> >  2 files changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gp=
u.c
> > index 095390774f22..655002b21b0d 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.c
> > +++ b/drivers/gpu/drm/msm/msm_gpu.c
> > @@ -751,12 +751,14 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct m=
sm_gem_submit *submit)
> >       struct msm_ringbuffer *ring =3D submit->ring;
> >       unsigned long flags;
> >
> > -     pm_runtime_get_sync(&gpu->pdev->dev);
> > +     WARN_ON(!mutex_is_locked(&gpu->lock));
> >
> > -     mutex_lock(&gpu->lock);
> > +     pm_runtime_get_sync(&gpu->pdev->dev);
> >
> >       msm_gpu_hw_init(gpu);
> >
> > +     submit->seqno =3D submit->hw_fence->seqno;
> > +
> >       update_sw_cntrs(gpu);
> >
> >       /*
> > @@ -781,11 +783,8 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct ms=
m_gem_submit *submit)
> >       gpu->funcs->submit(gpu, submit);
> >       gpu->cur_ctx_seqno =3D submit->queue->ctx->seqno;
> >
> > -     hangcheck_timer_reset(gpu);
> > -
> > -     mutex_unlock(&gpu->lock);
> > -
> >       pm_runtime_put(&gpu->pdev->dev);
> > +     hangcheck_timer_reset(gpu);
> >  }
> >
> >  /*
> > diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm=
/msm_ringbuffer.c
> > index e0ed27739449..548f5266a7d3 100644
> > --- a/drivers/gpu/drm/msm/msm_ringbuffer.c
> > +++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
> > @@ -21,8 +21,6 @@ static struct dma_fence *msm_job_run(struct drm_sched=
_job *job)
> >
> >       msm_fence_init(submit->hw_fence, fctx);
> >
> > -     submit->seqno =3D submit->hw_fence->seqno;
> > -
> >       mutex_lock(&priv->lru.lock);
> >
> >       for (i =3D 0; i < submit->nr_bos; i++) {
> > @@ -35,8 +33,13 @@ static struct dma_fence *msm_job_run(struct drm_sche=
d_job *job)
> >
> >       mutex_unlock(&priv->lru.lock);
> >
> > +     /* TODO move submit path over to using a per-ring lock.. */
> > +     mutex_lock(&gpu->lock);
> > +
> >       msm_gpu_submit(gpu, submit);
> >
> > +     mutex_unlock(&gpu->lock);
> > +
> >       return dma_fence_get(submit->hw_fence);
> >  }
> >
> > --
> > 2.43.0
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

