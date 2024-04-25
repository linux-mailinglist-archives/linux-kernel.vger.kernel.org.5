Return-Path: <linux-kernel+bounces-158450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86B38B2050
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9151B22261
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6781112A17B;
	Thu, 25 Apr 2024 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay3+2S6S"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93DD83CCD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044759; cv=none; b=U5zoRCBwA8yXM/w2Gmgj0YszRhm1VRIH9hEqVkWuvk//lRAmqD4opC2QGog7cPUL9hjkORdGMv90z7Kna2d8dl7/JjghU47wBNtByTKqlBTQmiDDWvAIW0C1/WJPwSAOUdxQXQfM+XzZH08mzNRboLx+BsD261dy/VqFHeP96bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044759; c=relaxed/simple;
	bh=zdsSqpe4Axcd6130ovyN7qM/3tKwuTVRh3eYm+1qfZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZfvJz3q9xyxZpi+0WOAxbxCcE2Kate/jCCyGOuqVdsf0/gAphyzpsuPK5EOBpzpiTBc0pexu/uFISExqlOYcKXQBJ3TIue+C9XWRcBUGaaqL4HeLwjrDGsugDy1bNyFlRrzP6gM4SJWCBFcJllSM4oGSkbEdQgly5/IJV/gTlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ay3+2S6S; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e3ca546d40so6740495ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 04:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714044756; x=1714649556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ffuFzFDT/hhmG/R8PcprPn2rgAavZDqODrquN+sri9E=;
        b=ay3+2S6SpEW1bM0pgjcRHdVvc27tJL7qEMz+usUiEB3rLCfMUCQyZAirejLH4A2XrC
         pMx92egTFNLWY4sX86MI9ZOtzInTpjx/QJIUZHygSmTNVb91ed+PrO0T9A3uPFglUEPM
         svkdgnwJte2m2eHporinZ+y5ZW9bgPvBaAGpmoTo/pN5stpqYuApIYFMPCcNS6b5VTL+
         wLnsrrokDxU8xE9QB22Z9EV20F1OkSzYhRvQdY2sj/aHMdEZ2XnVks3kKCTocxWusdob
         FIwF4XhJzW85QH1455U9/meT6Fl92ZYcQChdMz6k+USEn1jnPkJzF34Zhij8XoMa8/ur
         eiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714044756; x=1714649556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffuFzFDT/hhmG/R8PcprPn2rgAavZDqODrquN+sri9E=;
        b=vE9Y9QcrlruM3wEHEp8wEvOz0eV0tF5r3BWiFLb2cVCGDmtROleGWdOW9nOCtk33qX
         xHRuqLHTrigkPQADp/W0OUzh0iBvTHdngLzAOwKgbdMPM7e7dkvw+qsqZnzvMgipjH6P
         KkWEKyYiCguBrUUk+jdoC2D9oUCQ7V48K67FMpP43dhJkhJf3IElYxHWO9np47LDjiM7
         iJf0dzpxrRqbYAnB7abrngcXJIqElHIkZKI95tL88YKONLGbW2ZhheaqInBaTBPqTjsq
         67stA7L1fnAt+SheWoMSCf/ulvPn4FWCsHTEPXDb7OhFMq0C/ELdUOrz6oosx0dI3tLP
         TqyQ==
X-Gm-Message-State: AOJu0YwnOI+QtDKfnjJYy9YwGcOXOd+9PsS8nU+JoGIY1Z6ni98UKzxP
	e45UI3JtxRs7RhA9PaU/7gUBE5Dm8rfw7kwSUdCnUgrx3c3gJVdiA8GvnVEdT3K6unH5ssvpygh
	hmTF1dBmSYNNQ3NIJGpSAOUxa5r+pQWiz
X-Google-Smtp-Source: AGHT+IFAoonKY+Ldbjb5uRtArPVjR8I2eZU4gdaiybP+CEgjB+Lv8nAczp2WQLanPJwYBun3KbKBIsySsFAIfcS6O8U=
X-Received: by 2002:a17:902:8690:b0:1e2:7dc7:477 with SMTP id
 g16-20020a170902869000b001e27dc70477mr5255109plo.57.1714044755686; Thu, 25
 Apr 2024 04:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
In-Reply-To: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Thu, 25 Apr 2024 13:32:23 +0200
Message-ID: <CAH9NwWdzeF0=USW_bckDhPSUrgTfnFuAq44m1OhEmTL4JnBzLg@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Hi Tomeu,

>
> If we expose a render node for NPUs without rendering capabilities, the
> userspace stack will offer it to compositors and applications for
> rendering, which of course won't work.
>
> Userspace is probably right in not questioning whether a render node
> might not be capable of supporting rendering, so change it in the kernel
> instead by exposing a /dev/accel node.
>
> Before we bring the device up we don't know whether it is capable of
> rendering or not (depends on the features of its blocks), so first try
> to probe a rendering node, and if we find out that there is no rendering
> hardware, abort and retry with an accel node.
>

I really love this idea of moving away from a render node. What needs to be done
on the userspace side?

> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> Cc: Oded Gabbay <ogabbay@kernel.org>

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 46 ++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 6500f3999c5f..8e7dd23115f4 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -11,6 +11,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/uaccess.h>
>
> +#include <drm/drm_accel.h>
>  #include <drm/drm_debugfs.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
> @@ -488,10 +489,10 @@ static const struct drm_ioctl_desc etnaviv_ioctls[] = {
>         ETNA_IOCTL(PM_QUERY_SIG, pm_query_sig, DRM_RENDER_ALLOW),
>  };
>
> -DEFINE_DRM_GEM_FOPS(fops);
> +DEFINE_DRM_GEM_FOPS(render_fops);
> +DEFINE_DRM_ACCEL_FOPS(accel_fops);
>
> -static const struct drm_driver etnaviv_drm_driver = {
> -       .driver_features    = DRIVER_GEM | DRIVER_RENDER,
> +static struct drm_driver etnaviv_drm_driver = {
>         .open               = etnaviv_open,
>         .postclose           = etnaviv_postclose,
>         .gem_prime_import_sg_table = etnaviv_gem_prime_import_sg_table,
> @@ -500,7 +501,6 @@ static const struct drm_driver etnaviv_drm_driver = {
>  #endif
>         .ioctls             = etnaviv_ioctls,
>         .num_ioctls         = DRM_ETNAVIV_NUM_IOCTLS,
> -       .fops               = &fops,
>         .name               = "etnaviv",
>         .desc               = "etnaviv DRM",
>         .date               = "20151214",
> @@ -508,15 +508,20 @@ static const struct drm_driver etnaviv_drm_driver = {
>         .minor              = 4,
>  };
>
> -/*
> - * Platform driver:
> - */
> -static int etnaviv_bind(struct device *dev)
> +static int etnaviv_bind_with_type(struct device *dev, u32 type)
>  {
>         struct etnaviv_drm_private *priv;
>         struct drm_device *drm;
> +       bool is_compute_only = true;
>         int ret;
>
> +       etnaviv_drm_driver.driver_features = DRIVER_GEM | type;
> +
> +       if (type == DRIVER_RENDER)
> +               etnaviv_drm_driver.fops = &render_fops;
> +       else
> +               etnaviv_drm_driver.fops = &accel_fops;
> +
>         drm = drm_dev_alloc(&etnaviv_drm_driver, dev);
>         if (IS_ERR(drm))
>                 return PTR_ERR(drm);
> @@ -553,6 +558,18 @@ static int etnaviv_bind(struct device *dev)
>
>         load_gpu(drm);
>
> +       for (unsigned int i = 0; i < ETNA_MAX_PIPES; i++) {
> +               struct etnaviv_gpu *g = priv->gpu[i];
> +
> +               if (g && (g->identity.minor_features8 & chipMinorFeatures8_COMPUTE_ONLY) == 0)
> +                       is_compute_only = false;
> +       }
> +
> +       if (type == DRIVER_RENDER && is_compute_only) {
> +               ret = -EINVAL;
> +               goto out_unbind;
> +       }
> +
>         ret = drm_dev_register(drm, 0);
>         if (ret)
>                 goto out_unbind;
> @@ -571,6 +588,19 @@ static int etnaviv_bind(struct device *dev)
>         return ret;
>  }
>
> +/*
> + * Platform driver:
> + */
> +static int etnaviv_bind(struct device *dev)
> +{
> +       int ret = etnaviv_bind_with_type(dev, DRIVER_RENDER);
> +
> +       if (ret == -EINVAL)
> +               return etnaviv_bind_with_type(dev, DRIVER_COMPUTE_ACCEL);
> +
> +       return ret;
> +}
> +
>  static void etnaviv_unbind(struct device *dev)
>  {
>         struct drm_device *drm = dev_get_drvdata(dev);
> --
> 2.44.0
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

