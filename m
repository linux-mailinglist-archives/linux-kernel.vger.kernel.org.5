Return-Path: <linux-kernel+bounces-159524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E258B2FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C8AB21F86
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946A513A3E3;
	Fri, 26 Apr 2024 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="fz3ggYx6"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31D91849
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714109788; cv=none; b=jse8Gz2cGzIJCbxDYJVP2A2gcyhxzSdK0mudHnt//dHsn4uBj0HBbmbDO/DNzj0ZDmzS8aPN9fSRwOpIqI1y2GqjlFkSkffUGuaMucYyGYU+3t8dEazgmLPQSTqRSMGgYk5CVPyu2Et/sWRHUHRlu/DewrU+Pb/1iXngnpLlfxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714109788; c=relaxed/simple;
	bh=Jst70ATySv9w8j//MdnX7Lf4+8NFrjBh0WiYwLnsNK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQp9zoV5Llkosjt/crquuItzkaRfnURsrtpXuvGd9KX6PvuWZxrylsGfBYQmuMMG98Uowe9IXmFSe1wxj+AFU1x6vO9d3Lcl2yB/chCKgeN38vc89xNLCPlGBuy+/TjNCHewYXm347wEjj3rU4Iz6iCp4ZArhFCY0ATjsdLR5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=fz3ggYx6; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61b6200fcb5so18722897b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1714109782; x=1714714582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fun5634FSrpPfbO99ypFnP0OQqLiNPobqGLz/86CEto=;
        b=fz3ggYx6MzVG+UTUmGYxidjLX/+xi+fTdc5mYuG22JEDFJDCq1aH+E33HVtVxmaNlt
         TqBDYQG0MAYLoP2HAG/xtaxIw+/0EP7DtDKTCNuLlzgH12qrZhZ2T3aSO1WxHI1iWLqj
         P2BgL7tjp9ZPStzrCqIXEqtO6w2gMZWLo5IPb63cXtKwS0Pq98rNq3VX2KacvsD3tHAg
         F5wzgkN3m9NZXp+DeUFgU1OidcKf2P8S8z4sdbF6K2lXhgnzL3hrY9qZ2MPRwCSpGGPs
         pKZARrY2uTXvV/sigNc+plwCE7Bf7qLCLG7Ng0JX9lBtJKU8Zny3lT69CNK6lxerh16R
         +Rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714109782; x=1714714582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fun5634FSrpPfbO99ypFnP0OQqLiNPobqGLz/86CEto=;
        b=nAH9+NBnTwXYGRs0J2tWj/afjCBeiAwcTuXQtkbQPRjrXRVZa4vu3cwlcEthfo488C
         BsHbCVbq+NKMfVLbUfdtEzmfffTsedDL0/2nq98uXTaLhd9OVjMeJFMNSHcLEdBIsmjb
         pMvONb8Z2IvEwaMVoDmBaQOs9RHEEHi0TmWgwz97vjgVHCpmPZCCrUKPmvT+buoa0BQT
         5Srnyte1SRrb8VPGio20ZIsPE6sUHTy3qiGDokuZtNeu/fhoFPEfRiu5/1qXs9Gn7J9d
         AVyj3bugzSy96L92a/8JM/3tqQ9VHc/0o/hzN5Dk0/csoeZcIFn00ipiB3Bb6lYujMeB
         yhMg==
X-Gm-Message-State: AOJu0Yw3FENvjgazuMJAptg7tWvzjwVAoqdx6ZBHpHemabBom8XV5r5B
	E+AAAohPIt10mphmhKqxkImdGCWGV8SunSni0XMEc79G1PNenfLTc+JSplpdDFZsoci/UNE0dZe
	XVLgqeg==
X-Google-Smtp-Source: AGHT+IGTvYDQjyYm1BYNEh7UbSJyn/ULbuMm10h9OzEnCWtfTZ1xAvqqxzY4rBcBKzPuom65VvOI4w==
X-Received: by 2002:a05:690c:3813:b0:60a:3ef4:29b4 with SMTP id jx19-20020a05690c381300b0060a3ef429b4mr2253858ywb.38.1714109781828;
        Thu, 25 Apr 2024 22:36:21 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id o186-20020a0dfec3000000b0061b8e9593d4sm1092984ywf.3.2024.04.25.22.36.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 22:36:21 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de477949644so1938508276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:36:21 -0700 (PDT)
X-Received: by 2002:a25:b31c:0:b0:de4:6c97:2156 with SMTP id
 l28-20020a25b31c000000b00de46c972156mr2009606ybj.39.1714109780639; Thu, 25
 Apr 2024 22:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net> <CAH9NwWdzeF0=USW_bckDhPSUrgTfnFuAq44m1OhEmTL4JnBzLg@mail.gmail.com>
In-Reply-To: <CAH9NwWdzeF0=USW_bckDhPSUrgTfnFuAq44m1OhEmTL4JnBzLg@mail.gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 26 Apr 2024 07:36:09 +0200
X-Gmail-Original-Message-ID: <CAAObsKBjytOtVrDL5TKWqrBO3OuhQtRVk5Mn3MA801xyRczo+w@mail.gmail.com>
Message-ID: <CAAObsKBjytOtVrDL5TKWqrBO3OuhQtRVk5Mn3MA801xyRczo+w@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 1:32=E2=80=AFPM Christian Gmeiner
<christian.gmeiner@gmail.com> wrote:
>
> Hi Tomeu,
>
> >
> > If we expose a render node for NPUs without rendering capabilities, the
> > userspace stack will offer it to compositors and applications for
> > rendering, which of course won't work.
> >
> > Userspace is probably right in not questioning whether a render node
> > might not be capable of supporting rendering, so change it in the kerne=
l
> > instead by exposing a /dev/accel node.
> >
> > Before we bring the device up we don't know whether it is capable of
> > rendering or not (depends on the features of its blocks), so first try
> > to probe a rendering node, and if we find out that there is no renderin=
g
> > hardware, abort and retry with an accel node.
> >
>
> I really love this idea of moving away from a render node. What needs to =
be done
> on the userspace side?

Doesn't seem that bad, here is a proof of concept:

https://gitlab.freedesktop.org/tomeu/mesa/-/tree/teflon-accel

Thanks for taking a look.

Tomeu

> > Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> > Cc: Oded Gabbay <ogabbay@kernel.org>
>
> Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>
>
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 46 ++++++++++++++++++++++-----
> >  1 file changed, 38 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/et=
naviv/etnaviv_drv.c
> > index 6500f3999c5f..8e7dd23115f4 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/uaccess.h>
> >
> > +#include <drm/drm_accel.h>
> >  #include <drm/drm_debugfs.h>
> >  #include <drm/drm_drv.h>
> >  #include <drm/drm_file.h>
> > @@ -488,10 +489,10 @@ static const struct drm_ioctl_desc etnaviv_ioctls=
[] =3D {
> >         ETNA_IOCTL(PM_QUERY_SIG, pm_query_sig, DRM_RENDER_ALLOW),
> >  };
> >
> > -DEFINE_DRM_GEM_FOPS(fops);
> > +DEFINE_DRM_GEM_FOPS(render_fops);
> > +DEFINE_DRM_ACCEL_FOPS(accel_fops);
> >
> > -static const struct drm_driver etnaviv_drm_driver =3D {
> > -       .driver_features    =3D DRIVER_GEM | DRIVER_RENDER,
> > +static struct drm_driver etnaviv_drm_driver =3D {
> >         .open               =3D etnaviv_open,
> >         .postclose           =3D etnaviv_postclose,
> >         .gem_prime_import_sg_table =3D etnaviv_gem_prime_import_sg_tabl=
e,
> > @@ -500,7 +501,6 @@ static const struct drm_driver etnaviv_drm_driver =
=3D {
> >  #endif
> >         .ioctls             =3D etnaviv_ioctls,
> >         .num_ioctls         =3D DRM_ETNAVIV_NUM_IOCTLS,
> > -       .fops               =3D &fops,
> >         .name               =3D "etnaviv",
> >         .desc               =3D "etnaviv DRM",
> >         .date               =3D "20151214",
> > @@ -508,15 +508,20 @@ static const struct drm_driver etnaviv_drm_driver=
 =3D {
> >         .minor              =3D 4,
> >  };
> >
> > -/*
> > - * Platform driver:
> > - */
> > -static int etnaviv_bind(struct device *dev)
> > +static int etnaviv_bind_with_type(struct device *dev, u32 type)
> >  {
> >         struct etnaviv_drm_private *priv;
> >         struct drm_device *drm;
> > +       bool is_compute_only =3D true;
> >         int ret;
> >
> > +       etnaviv_drm_driver.driver_features =3D DRIVER_GEM | type;
> > +
> > +       if (type =3D=3D DRIVER_RENDER)
> > +               etnaviv_drm_driver.fops =3D &render_fops;
> > +       else
> > +               etnaviv_drm_driver.fops =3D &accel_fops;
> > +
> >         drm =3D drm_dev_alloc(&etnaviv_drm_driver, dev);
> >         if (IS_ERR(drm))
> >                 return PTR_ERR(drm);
> > @@ -553,6 +558,18 @@ static int etnaviv_bind(struct device *dev)
> >
> >         load_gpu(drm);
> >
> > +       for (unsigned int i =3D 0; i < ETNA_MAX_PIPES; i++) {
> > +               struct etnaviv_gpu *g =3D priv->gpu[i];
> > +
> > +               if (g && (g->identity.minor_features8 & chipMinorFeatur=
es8_COMPUTE_ONLY) =3D=3D 0)
> > +                       is_compute_only =3D false;
> > +       }
> > +
> > +       if (type =3D=3D DRIVER_RENDER && is_compute_only) {
> > +               ret =3D -EINVAL;
> > +               goto out_unbind;
> > +       }
> > +
> >         ret =3D drm_dev_register(drm, 0);
> >         if (ret)
> >                 goto out_unbind;
> > @@ -571,6 +588,19 @@ static int etnaviv_bind(struct device *dev)
> >         return ret;
> >  }
> >
> > +/*
> > + * Platform driver:
> > + */
> > +static int etnaviv_bind(struct device *dev)
> > +{
> > +       int ret =3D etnaviv_bind_with_type(dev, DRIVER_RENDER);
> > +
> > +       if (ret =3D=3D -EINVAL)
> > +               return etnaviv_bind_with_type(dev, DRIVER_COMPUTE_ACCEL=
);
> > +
> > +       return ret;
> > +}
> > +
> >  static void etnaviv_unbind(struct device *dev)
> >  {
> >         struct drm_device *drm =3D dev_get_drvdata(dev);
> > --
> > 2.44.0
> >
>
>
> --
> greets
> --
> Christian Gmeiner, MSc
>
> https://christian-gmeiner.info/privacypolicy

