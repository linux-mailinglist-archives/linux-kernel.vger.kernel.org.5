Return-Path: <linux-kernel+bounces-153321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AB68ACC80
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE0C285A87
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9BB146D7D;
	Mon, 22 Apr 2024 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF1On4wJ"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23D524A0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787768; cv=none; b=E03xsOpF470MKatZbWlxh685g0+KotTjhDJCVf37YQCl0FBpWYTCI0t0TCo6ExmVEBGwTZUM9uY6Otrbpn/pBMBG+JKCpExrRb+FaPghFUlaxtzIEHjHoAf7ztMzMBAJW1E1+lgAXXWsGxNoJ3JRG9y7/NIjSDcqX6UvDFicfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787768; c=relaxed/simple;
	bh=WZRTcgqw3YTcygUtLPr4jfj6baJcqU+HSij9Lwa5pnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kN4WqnALlMNRZicgukemOebNOoama3fofJQDur7y9omAZR4tO2bN54/kmAfI/z6D5kqX8hIXrw48wU2z2ulcBUR3sSmunNvYvTf9u2+hELg6xF1HptKHZr0cePTEv4VUY5DjBYIW8BFvBLOpDft5SdZc3N44kbkRr9OyWe2en5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF1On4wJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-60275a82611so66982a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713787766; x=1714392566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSYUfPUp3aHKYRSJHW3nsNdjnok3doEHFDPHNf1mUD8=;
        b=aF1On4wJU0oLdaJJyInKwREEYMe59LFs56L7FN+ogga2YJ+vUDz2U7OjCfn/rG4rxW
         E6XeTCGGh18cl89tVPRGXFBl6rbkvcwPyJRuvGuzM0fwOjnSNPaEryM18UWtiEqBZZZE
         AirfZRj6mJnORBRTrwkoT4yVFDDrYA4rdkhnV5Jjkad4F4Pp6ubKlTuKbjRmiULsKJ6c
         bWyfTYIxw8EuHI/b/sykY6RY6Nzc/2J/CxodmolPVWqSCEYcRlpA61WErI5A8jPlBm7Z
         YpD+bJVNb0yZ02i4HB06yszhW877cNCtPR+PU0SX73axi5P3OSG3V6cj0bKj1UuX9Rg+
         gwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713787766; x=1714392566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSYUfPUp3aHKYRSJHW3nsNdjnok3doEHFDPHNf1mUD8=;
        b=MFuNrM6cOavbGU/cE+dEFxOM8sfHiAnGQrJ3W8y+NRqx4eP5p3DW2Xo+LLXVvJgZYC
         hjJXrOzUlFcTdHbGQfylCe7wyfcWFIJ81PBhJzBuh1a/SahvA/r/XaTuLpz2PcWXGn+r
         PM4Dw33Rtwvaes69VYw0ee5Zu3kn9eEDKQ4qAvUNhJPZ1YaJf1L54zgT4xHE5cQ1QTd3
         8YOk76+CQy2DZWGqyUxunxw4MNO0lZ0nPCbaFFedTQt7Zgxw2l/eruQmLLriELCB9Mdp
         0R0epWls3fW/E5vmxPIvAA4KYSUQaBfq41V8SsQ+oZHGnjsx+FdzCSRe3DP+oyXWfh6G
         Afxg==
X-Forwarded-Encrypted: i=1; AJvYcCWllIEPZpQsBqixpAwG8sAK3/5hzMQEaDEvEUmRMKyR+qN+gc3WfevfEt9xXB1RMpEavIhLe0tlRP0DQ0aC0pUkxteY4EmNo0NSmROi
X-Gm-Message-State: AOJu0YyHNPJcC9u8lhX+VegPUl5G49woCIjxGzsSqgIz3FmdN9bu2XIB
	srOlVSZt3g6Ox0G1Yq43PCIKMmkDAYDgi4HbFSHfF+xjMRrSUgDN5IcozuVZb9tqfzbaLRL5wSO
	xvzx3al3KYUgF7CPeY7b1QlhRwHI=
X-Google-Smtp-Source: AGHT+IFConWUkZnbQRk4mS4bFa6lsrcKDBb9vKgKVpJXgVDjWzDvLQf0IWRNOLuTc1NoKmLWbeSfic7yMeiQEHlbacg=
X-Received: by 2002:a17:90b:384d:b0:2ae:5bdb:1960 with SMTP id
 nl13-20020a17090b384d00b002ae5bdb1960mr550537pjb.3.1713787765992; Mon, 22 Apr
 2024 05:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240211230931.188194-1-aford173@gmail.com> <20240211230931.188194-2-aford173@gmail.com>
 <6111fe04-4ecb-428e-9a0c-dc02cadfe3e7@denx.de>
In-Reply-To: <6111fe04-4ecb-428e-9a0c-dc02cadfe3e7@denx.de>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 22 Apr 2024 07:09:13 -0500
Message-ID: <CAHCN7x+DwSSabhGYZ1dnZzwRe+BJfz2H-AXbxjUQWytrq3OMpQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] drm/bridge: samsung-dsim: Fix porch calcalcuation rounding
To: Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, aford@beaconembedded.com, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Inki Dae <inki.dae@samsung.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Marco Felsch <m.felsch@pengutronix.de>, Michael Tretter <m.tretter@pengutronix.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 9:36=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 2/12/24 12:09 AM, Adam Ford wrote:
> > When using video sync pulses, the HFP, HBP, and HSA are divided between
> > the available lanes if there is more than one lane.  For certain
> > timings and lane configurations, the HFP may not be evenly divisible.
> > If the HFP is rounded down, it ends up being too small which can cause
> > some monitors to not sync properly. In these instances, adjust htotal
> > and hsync to round the HFP up, and recalculate the htotal.
> >
> > Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL =
i.MX8MM with HDMI monitor
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V2:  No changes
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/br=
idge/samsung-dsim.c
> > index 8476650c477c..52939211fe93 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -1606,6 +1606,27 @@ static int samsung_dsim_atomic_check(struct drm_=
bridge *bridge,
> >               adjusted_mode->flags |=3D (DRM_MODE_FLAG_PHSYNC | DRM_MOD=
E_FLAG_PVSYNC);
> >       }
> >
> > +     /*
> > +      * When using video sync pulses, the HFP, HBP, and HSA are divide=
d between
> > +      * the available lanes if there is more than one lane.  For certa=
in
> > +      * timings and lane configurations, the HFP may not be evenly div=
isible.
> > +      * If the HFP is rounded down, it ends up being too small which c=
an cause
> > +      * some monitors to not sync properly. In these instances, adjust=
 htotal
> > +      * and hsync to round the HFP up, and recalculate the htotal. Thr=
ough trial
> > +      * and error, it appears that the HBP and HSA do not appearto nee=
d the same
> > +      * correction that HFP does.
> > +      */
> > +     if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE && dsi->lane=
s > 1) {
>
> Does this also apply to mode with sync events (I suspect it does), so
> the condition here should likely be if (!...burst mode) , right ?

Thanks for the review!

I was only able to test it with the DSI->ADV6535 bridge, and I'll
admit I don't know a lot about DSI interface since I don't have a copy
of the spec to read.

Are you proposing this should be:

 if (!(dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) && dsi->lanes > 1) {

I just want to make sure I understand what you're requesting.

thanks

adam

