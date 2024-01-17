Return-Path: <linux-kernel+bounces-29316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5AA830CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0867F1F23E57
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF6622F0D;
	Wed, 17 Jan 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6hWjJTj"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37822EE1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516113; cv=none; b=A999pXZ5+71rvR1Inv6p9MACP7xI9rFumV+NreW8GbIeKgZ6DJdShvVEVOzvsWCLqcArtAiVSmvx+rM2o3o/D6E0Z3w6Rzji09oTH+D6IZVos0tFVhlYw9cSJS9akrPEhp3g7uVJ2qLCDkcxZ9GdRLh/IhUR4pMK8HDYEhSUEi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516113; c=relaxed/simple;
	bh=RXmKq/V46HjlwJmswiDSHgratWSeX1EAcKd7ceIrA6s=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=BuNdNop/7VmLqKPJAVQzei+Il13yX0aslSKfZp/5hYXY0c073oemnihIL5irXV6n7rve4zP9aWaQmQEW7JkEtsbni0Q43A0aTe4plAFvZxJwCeyA07jt2ph7BI2IiYats9wTcUzdrL9p8iYD5HKvIIywKTZMyuTWjyGYMmelz0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6hWjJTj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e60d74b81so3185955e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705516109; x=1706120909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YTIWppZOBmL1H/qdXTnDsoCpEw1sXU7s7kj9GmEfng=;
        b=a6hWjJTjgHlf2L7Di3rO6M4U+kASHcSkR/4/Zf7w2xfj02wsdNz5QD4P6AxKeEq6G7
         0LJGwpD6hlQ4/+2gisARGtvdp55PZaQdVdNqUnusJilVLUIYWFmaN3RsVRfkO58J34yO
         vl4pQH4ORURkE3cjk3+5eocLQFwJbLB95RDA6JpbIbtxQbH/XiV2ZmqfyuXtWomemNvK
         tbgTwktdhgKI8mnsS6a2nYg0j8HY/C8nihfnWCpCynXfNmtcz6UNOfLkDpTVFvwHeCZ0
         QXAdP1HWlPulyK2b41SSQNhZBQq/fzqb4PIbB91LZzwy66AgO4nyDaKvAqcjnY8nkYsd
         fOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705516109; x=1706120909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YTIWppZOBmL1H/qdXTnDsoCpEw1sXU7s7kj9GmEfng=;
        b=Mnr85IA7qE/+ZN5m0wVDSjJCKgtlPLaXp+w4btw3fxhWKGPH9WN9D6R8YryfjFAu+E
         gBF+pLxNNGX7Xhn+ugYYdBnIBiU/ffY+Mq7IFWGzFsYivzRzGfcDg4SxpWmiTv5EVbZO
         KZf79KdgKMhJqZWt4SF9E0Fp/tvfk4Cj6UZmyfvrPnactpHVPb9n1N+iLoSvXLhOldo3
         Al/W4SqbBnnO2kz2vVdiyNPm5Jtg1YXVgDY1dsHvbFRdcS0Y8OU2XWPQc62/MeJFL6d9
         KaQdjM4X2hFjnErfZcgjcgiAytE95yAHtz/vDjgPm1HKSknpV2kLwN8YnpUigj5xLBSz
         +ETg==
X-Gm-Message-State: AOJu0YyfKddYhf9POuouf70+jWHTTJdYtHbhrMiUFSppTuKuC40X99F0
	FBY+hIP0Hwz14+AhaxYnDSsjs95b8LAkHb/B3W4=
X-Google-Smtp-Source: AGHT+IEBNi5qG09aWKVIGebEpdYQKcvYy1/Zs4NTddYCXN5LBWTykzC2D8B21MvTXNKkVrx5cxbkWxUUYO/cZli+noE=
X-Received: by 2002:a05:600c:3ca3:b0:40e:89e8:107a with SMTP id
 bg35-20020a05600c3ca300b0040e89e8107amr184597wmb.3.1705516109458; Wed, 17 Jan
 2024 10:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com> <20240117031212.1104034-6-nunes.erico@gmail.com>
In-Reply-To: <20240117031212.1104034-6-nunes.erico@gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Wed, 17 Jan 2024 10:28:02 -0800
Message-ID: <CA+E=qVe_5fDsW+_KobwP5+Xg0Tac3Eh3dtVsmM1VSEmiQeH_cQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] drm/lima: remove guilty drm_sched context handling
To: Erico Nunes <nunes.erico@gmail.com>
Cc: Qiang Yu <yuq825@gmail.com>, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 7:12=E2=80=AFPM Erico Nunes <nunes.erico@gmail.com>=
 wrote:
>
> Marking the context as guilty currently only makes the application which
> hits a single timeout problem to stop its rendering context entirely.
> All jobs submitted later are dropped from the guilty context.
>
> Lima runs on fairly underpowered hardware for modern standards and it is
> not entirely unreasonable that a rendering job may time out occasionally
> due to high system load or too demanding application stack. In this case
> it would be generally preferred to report the error but try to keep the
> application going.
>
> Other similar embedded GPU drivers don't make use of the guilty context
> flag. Now that there are reliability improvements to the lima timeout
> recovery handling, drop the guilty contexts to let the application keep
> running in this case.
>
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>

> ---
>  drivers/gpu/drm/lima/lima_ctx.c   | 2 +-
>  drivers/gpu/drm/lima/lima_ctx.h   | 1 -
>  drivers/gpu/drm/lima/lima_sched.c | 5 ++---
>  drivers/gpu/drm/lima/lima_sched.h | 3 +--
>  4 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_ctx.c b/drivers/gpu/drm/lima/lima_=
ctx.c
> index 8389f2d7d021..0e668fc1e0f9 100644
> --- a/drivers/gpu/drm/lima/lima_ctx.c
> +++ b/drivers/gpu/drm/lima/lima_ctx.c
> @@ -19,7 +19,7 @@ int lima_ctx_create(struct lima_device *dev, struct lim=
a_ctx_mgr *mgr, u32 *id)
>         kref_init(&ctx->refcnt);
>
>         for (i =3D 0; i < lima_pipe_num; i++) {
> -               err =3D lima_sched_context_init(dev->pipe + i, ctx->conte=
xt + i, &ctx->guilty);
> +               err =3D lima_sched_context_init(dev->pipe + i, ctx->conte=
xt + i);
>                 if (err)
>                         goto err_out0;
>         }
> diff --git a/drivers/gpu/drm/lima/lima_ctx.h b/drivers/gpu/drm/lima/lima_=
ctx.h
> index 74e2be09090f..5b1063ce968b 100644
> --- a/drivers/gpu/drm/lima/lima_ctx.h
> +++ b/drivers/gpu/drm/lima/lima_ctx.h
> @@ -13,7 +13,6 @@ struct lima_ctx {
>         struct kref refcnt;
>         struct lima_device *dev;
>         struct lima_sched_context context[lima_pipe_num];
> -       atomic_t guilty;
>
>         /* debug info */
>         char pname[TASK_COMM_LEN];
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lim=
a_sched.c
> index 9449b81bcd5b..496c79713fe8 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -154,13 +154,12 @@ void lima_sched_task_fini(struct lima_sched_task *t=
ask)
>  }
>
>  int lima_sched_context_init(struct lima_sched_pipe *pipe,
> -                           struct lima_sched_context *context,
> -                           atomic_t *guilty)
> +                           struct lima_sched_context *context)
>  {
>         struct drm_gpu_scheduler *sched =3D &pipe->base;
>
>         return drm_sched_entity_init(&context->base, DRM_SCHED_PRIORITY_N=
ORMAL,
> -                                    &sched, 1, guilty);
> +                                    &sched, 1, NULL);
>  }
>
>  void lima_sched_context_fini(struct lima_sched_pipe *pipe,
> diff --git a/drivers/gpu/drm/lima/lima_sched.h b/drivers/gpu/drm/lima/lim=
a_sched.h
> index 34050facb110..677e908b53f8 100644
> --- a/drivers/gpu/drm/lima/lima_sched.h
> +++ b/drivers/gpu/drm/lima/lima_sched.h
> @@ -93,8 +93,7 @@ int lima_sched_task_init(struct lima_sched_task *task,
>  void lima_sched_task_fini(struct lima_sched_task *task);
>
>  int lima_sched_context_init(struct lima_sched_pipe *pipe,
> -                           struct lima_sched_context *context,
> -                           atomic_t *guilty);
> +                           struct lima_sched_context *context);
>  void lima_sched_context_fini(struct lima_sched_pipe *pipe,
>                              struct lima_sched_context *context);
>  struct dma_fence *lima_sched_context_queue_task(struct lima_sched_task *=
task);
> --
> 2.43.0
>

