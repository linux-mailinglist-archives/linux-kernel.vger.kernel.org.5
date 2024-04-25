Return-Path: <linux-kernel+bounces-159139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 735FB8B29D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8525BB264FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB9A39847;
	Thu, 25 Apr 2024 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtbDT1BH"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD902B9D9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077016; cv=none; b=AEfV0uUxTPVWao8emO2/WJINT5CPYa7YT51D1yzLNdUA09+wdTH424ObFHvRy32XYcgyAXLAooOLELLxLgd7/Dy/gTFlmLCCL/vWuRaAWpzxhVkBUEGJInVJv7uAhAttzyzRTbxEy9SoV9UgZldwWuSAqDu/YKtPqq2LBEbOUWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077016; c=relaxed/simple;
	bh=gqp6wvS4UfJxlEmIog1zsBpPUNy2+DlmIhJNSWYKfew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDP4K+LIyTBUcbk7seiXMttRlO5N9FSYcR5XPDgF0CgzHcnmO8BQAlxuCQj54g89FSVfqM3AWtspi6OAUMBjwJWMiHZGcfB2RvqXdWug0bWGkxX2v8UCtIWdW4Y50l7WA+rZ/QlGO51wcyz1nPgowcHqQXCbf8+MPCWkgUwYHTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtbDT1BH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a564ca6f67so1300462a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714077015; x=1714681815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PzTk/0GTrpkXInH9ZwioMKJlS+GbN8syGyhHAUyME8=;
        b=VtbDT1BH8a/hCqINQ+xv3sdlcequomW5BAUBdAauERH5rBuzst2gGZFcR1CKSiIPn9
         Lrv2iCKQqus5qRE4p3uyqGu82pYbFS62v+brPZ9OrlcB8kjwxdiiXZD/jK66SsXuIpOh
         uQZpknYhYRjigNo4yL2m/397L87PJaMscWgqC1fJ8xGUmm4GnS0wLebBinFshBqWKzJd
         1yxYpjL0G8K3sdtoVBDss/QhHw3dk5d8yPcJ8GgBZWcmUUB2xAcd2Z6WpcGancAAYf2i
         B/qOuthh27LfJeT98s+EplM7hFezqFzQ6FLrbLYc4jC2RP0H7sL++cTdr6ojHLcRTg72
         UUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714077015; x=1714681815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PzTk/0GTrpkXInH9ZwioMKJlS+GbN8syGyhHAUyME8=;
        b=hq3yYV1K1ePmy++8tHLL6Ga4rUnHegtd1KqfjSKE5vAIyqEqWr5au0746ltM8EwLz0
         maLV/U4k91NJup+5Lj0dcQXff71JUwezebAlw3uAqcaSOmOEOusN2noIFLQHkuAYZN22
         DKuxomk72fBZil6GVEah4vlb8QsERiDger65GKduT0E3YuN/nQiAI36NgqM9FO/ufc7r
         0bFR2/i58e/MN5AuV+XgUZ/0kYsde0SVlugY08a++wm+U19AqSEM88jg2jGlkrNX5O1k
         g7ZvehgwzJcMCmOCCCTOpueQ9xvafspMcOBdORkqwExT8Sm2QhZysaCwRJjMKxbm3JHQ
         /7zw==
X-Forwarded-Encrypted: i=1; AJvYcCUbg6AU5Mt5HGttnqhDpOR5BHaX9wuSFm5ZzKfJSe4/XzgnNpUXXiFU4cuhbHVn4Qh2a8Xb7JgpBRl+6yzcWV83wQ1ykehe/S7mSlJI
X-Gm-Message-State: AOJu0YwaBtITvhWC7Wnjs/Sb6JgWxqNVvNCasbeMQEMofYKYAwrjFcT0
	6CthL2SsKV6txsdGm3BhE/XZMmFtR4D+hjYrLGb06Vzx6Q/GeJElMY4Z+QqWcCPZVLCyaIw1f5Q
	QgnAn/zrNih8nt4CrbGQw2MfPy4Q=
X-Google-Smtp-Source: AGHT+IGuNAaAcfQIDo2pmo/7gSrHvac1vDktSrMNsPTwLAjcvb2ez0/759mAyT0aMzMQCabBlxlT/NjCU+DIoIaVvWU=
X-Received: by 2002:a17:90a:c292:b0:2ae:814f:43fa with SMTP id
 f18-20020a17090ac29200b002ae814f43famr666154pjt.46.1714077014367; Thu, 25 Apr
 2024 13:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240211230931.188194-1-aford173@gmail.com> <CGME20240211230945eucas1p1863deb244ef4fdc68825ff01d082e270@eucas1p1.samsung.com>
 <20240211230931.188194-2-aford173@gmail.com> <6fcfe1bb-a1e9-4d7c-aff7-e572bcdf5d31@samsung.com>
In-Reply-To: <6fcfe1bb-a1e9-4d7c-aff7-e572bcdf5d31@samsung.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 25 Apr 2024 15:30:02 -0500
Message-ID: <CAHCN7xJRgW4Y3YML+tToPw1TgA3o158XCEUcb9p-S+nvDWgzRQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] drm/bridge: samsung-dsim: Fix porch calcalcuation rounding
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, marex@denx.de, aford@beaconembedded.com, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Inki Dae <inki.dae@samsung.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Marco Felsch <m.felsch@pengutronix.de>, Michael Tretter <m.tretter@pengutronix.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 4:19=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 12.02.2024 00:09, Adam Ford wrote:
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
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thank you very much for testing!

>
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

Frieder  &  Marek S,

Marek V is proposing we eliminate the check against the flags and do
it unconditionally.  If I send you both a different patch, would you
be willing to try them on your platforms?  I don't want to risk
breaking a board.
I used the check above from the NXP downstream kernel, so it felt
safe, but I am not as familiar with the different DSI modes, so I am
not sure what the impact would be if this read:

 if (dsi->lanes > 1) {

Does anyone else have an opinion on this?
> > +             int hfp =3D adjusted_mode->hsync_start - adjusted_mode->h=
display;
> > +             int remainder =3D hfp % dsi->lanes;
> > +
> > +             if (remainder) {
> > +                     adjusted_mode->hsync_start +=3D remainder;
> > +                     adjusted_mode->hsync_end   +=3D remainder;
> > +                     adjusted_mode->htotal      +=3D remainder;
> > +             }
> > +     }
> > +
> >       return 0;
> >   }
> >
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

