Return-Path: <linux-kernel+bounces-39144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F39283CB72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49CF1C23910
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062571350CA;
	Thu, 25 Jan 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBnpZQtb"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54DB77F02
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208277; cv=none; b=i7okOkGZBsOe6ZqOSlJ8gqSXZOFeb7ZlkQBuerq300q+wzCTWMiZPsarI1uXu4lKu2tErU7M4kw9Y8XBfcBDMeJMPnlvygiSRqkijb11C25hoLTX72fx7r/Wg74Y0/LEWNknZksL0FdM4qn/6Gtb3Zaz2o3d8jnoVWzRv9fvdPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208277; c=relaxed/simple;
	bh=/G7sXsTe7ri1HNrBLPbiY22GWstuhTL74efu7BfGoUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjXa6fVXkq/Z9fmaRl4zTM6jHpVfD2BuiXZQsgLrcQn5wESzLmKDRMIZnK9O67+OviXI0jylzJHqDEDgibj9GEj8rE2nVGMAJ6mVjfJRdya5ymO4+rZ7wj8WOZs4gPe6ybp+L3eFdgrGJ6KeWu5J07QIqaxkAc4QbfMRE+8fOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBnpZQtb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ddc268ce2bso6799b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706208275; x=1706813075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81jWFTTTYAtqoCJJ13OsSFtUzfIkGNBcYQalGJf/MDM=;
        b=KBnpZQtbaY9Lss20rp9zxeRxW6uacDU4+B/ym0QGCZTF8ek2WiDRZ890PL5Lk9XZ8m
         2sPpLDaYgJZpyngIH9V0EwOg6Iht+QhpgVDYo/vjDzTehLFXZz9Br7GTJT3leq4n8BHo
         5tiAh07aJ3FtOr9NlhzBjuG8bU33vLJWummoEjz7sJX0bz1AvMWqK85OUIhdx5ctyW1v
         ZiYyZwtXqzrx4zjOuWkDeWBsZ7yns3afkVHlcr6rD13MZRvftjIVCnuIoDjKyZBey93N
         8euhmqOOctjaETNMc5gGSDDuI9uBXxhFHeCUc5FKPDDqTbcoe2C3IFZA4k0A1M7qyidw
         26jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706208275; x=1706813075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81jWFTTTYAtqoCJJ13OsSFtUzfIkGNBcYQalGJf/MDM=;
        b=Ch310RcWbYaJWBO/B215STvmt75KnP+IJh13rwi7ApI99G7LEKjIwLhAVTIPHABJZM
         3TkwHxB2EPtEMK+nlEdSWwRXm4m53kU+zu5A4Ka3f5Q6aoam2z1rDaFurCS0FUnzRZzf
         /3gJ7ZLMUsE5ey6R2+EToXn4HaqiS0uy780gd/69g4EvDt64tZe5JZl2DqT7fuOrx2Li
         Rh/Awnq2bmPUA1A95mFb0QWkJwMk+L4maAkWxrX5C3ZxXwJjsp5/nfWI48Zc6U92IM35
         VP5eaZdSi9bxiE56nUyxyzF5vpfPH433mO8+rZXJbE0ZBYUGxHO7WC88K9LnQCnyr1ZU
         3iqw==
X-Gm-Message-State: AOJu0YwpWuj14FVNwMp0Fut6+JM1ZdMKI3Bi9/qKLl9Al+IBDkn6Q1NX
	9IxIlEe/yzIvHnhrxKhemBh7S/kjKoieFRqSYT+dxv4rI6SASJBQjTbuV4ciJgsiBhSZnREYQzI
	LnTH6g2Vy75mutDHbyEJ32O3uEak=
X-Google-Smtp-Source: AGHT+IHMq8SnoE+FUdLwYAp07S1sZ1ZXNpW9iId/mZ5vizI584+m8d6ebM2DNj1atCj1i7xNKCmRa7+VvUSlymliGxA=
X-Received: by 2002:a05:6a00:1ac6:b0:6db:de7c:53fe with SMTP id
 f6-20020a056a001ac600b006dbde7c53femr1190523pfv.62.1706208274952; Thu, 25 Jan
 2024 10:44:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212033259.189718-1-aford173@gmail.com> <20231212033259.189718-2-aford173@gmail.com>
In-Reply-To: <20231212033259.189718-2-aford173@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 25 Jan 2024 12:44:23 -0600
Message-ID: <CAHCN7xKKMzOtVaEXzgTgsO4yZF0JZ6=o+TFJOeTCza0fMGss2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: samsung-dsim: Fix porch calcalcuation rounding
To: dri-devel@lists.freedesktop.org
Cc: aford@beaconembedded.com, Frieder Schrempf <frieder.schrempf@kontron.de>, 
	Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Michael Tretter <m.tretter@pengutronix.de>, Marco Felsch <m.felsch@pengutronix.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 9:33=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> When using video sync pulses, the HFP, HBP, and HSA are divided between
> the available lanes if there is more than one lane.  For certain
> timings and lane configurations, the HFP may not be evenly divisible.
> If the HFP is rounded down, it ends up being too small which can cause
> some monitors to not sync properly. In these instances, adjust htotal
> and hsync to round the HFP up, and recalculate the htotal.
>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL i.=
MX8MM with HDMI monitor
> Signed-off-by: Adam Ford <aford173@gmail.com>

Gentle nudge on this one.  Basically this fixes an issue with the 8MP,
but it's still unknown why it doesn't work on 8MM or 8MN, but Frieder
confirmed there are no regressions on 8MM or 8MN.

adam


>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index 239d253a7d71..f5795da1d8bb 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1628,6 +1628,27 @@ static int samsung_dsim_atomic_check(struct drm_br=
idge *bridge,
>                 adjusted_mode->flags |=3D (DRM_MODE_FLAG_PHSYNC | DRM_MOD=
E_FLAG_PVSYNC);
>         }
>
> +       /*
> +        * When using video sync pulses, the HFP, HBP, and HSA are divide=
d between
> +        * the available lanes if there is more than one lane.  For certa=
in
> +        * timings and lane configurations, the HFP may not be evenly div=
isible.
> +        * If the HFP is rounded down, it ends up being too small which c=
an cause
> +        * some monitors to not sync properly. In these instances, adjust=
 htotal
> +        * and hsync to round the HFP up, and recalculate the htotal. Thr=
ough trial
> +        * and error, it appears that the HBP and HSA do not appearto nee=
d the same
> +        * correction that HFP does.
> +        */
> +       if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE && dsi->lane=
s > 1) {
> +               int hfp =3D adjusted_mode->hsync_start - adjusted_mode->h=
display;
> +               int remainder =3D hfp % dsi->lanes;
> +
> +               if (remainder) {
> +                       adjusted_mode->hsync_start +=3D remainder;
> +                       adjusted_mode->hsync_end   +=3D remainder;
> +                       adjusted_mode->htotal      +=3D remainder;
> +               }
> +       }
> +
>         return 0;
>  }
>
> --
> 2.40.1
>

