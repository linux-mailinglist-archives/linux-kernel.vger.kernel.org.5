Return-Path: <linux-kernel+bounces-7147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7A981A233
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182F8B25CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D2B45C1D;
	Wed, 20 Dec 2023 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0i+rLEm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B3645C1E;
	Wed, 20 Dec 2023 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so58561875e9.0;
        Wed, 20 Dec 2023 07:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703085533; x=1703690333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQznE3T4sDko9wo85ONtxZv9jJ6ZRKGfTKvps55TZXU=;
        b=b0i+rLEmUbcCrFEGW/GS8SpV/HPkGA8aqgAFZab6Toll+ZWcyuj+nD1bbcK84n9qKu
         UF1WYCwa2qoFkx41iF+9N60fJ4fL5ulHaazgEwYKU19U8i/122dlsoTM+fUBfVsWTbwc
         W3fUXvJnAIVZ4TVZ1vwXF8yoc6m7bsyfpEB3BO6qjytfqP28qw2vBKC0ZUdPH1LpxgAu
         9gmGT1/mTqJHLkx7iSJllyDzQR3Wp1waN0NoX8aHrslpFjyPb/nHaOQMVvxM83k9OqVi
         ZJ6Dn+S5rWSn2HETbr16dtd4f3eiuIGIoBADWKwxTQ51ZfTu9+cZuLiNyFDmGpnployS
         kFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703085533; x=1703690333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQznE3T4sDko9wo85ONtxZv9jJ6ZRKGfTKvps55TZXU=;
        b=sUDSDY48s0gjRus4LBRpR6rf84sZ+Jmbq7IdgyP1tp/raM79yNHWU5Y5xjNde7pruR
         Epc/1ev5woj9WQ+OWLq740vsMMzMHsev245HOLEo6yhSpax5ihVxv6aVbZLbCl2LUfdL
         5sTcmSTnaSWd1Ys5aEFlH9GdQO9kps17F7hZUnXEks8Lgi2FBpVJhoFmGePZTdEl1viu
         Yf5qgEW9kSWTej+1poXVxSAny6vDh589tj7gSixM7i3EiQuh5G5HlN3NsJRR0ARx9prz
         pfMpyIXG9c3NF1vPdQYeVbEabce17BHeIbo4xqRIL8T5zjTJEIRZelXqHmPIxhJOeLJ2
         Gc7w==
X-Gm-Message-State: AOJu0YwS8GVISg6ZuU0jYxLu4yxKhDfOPkI6/CrX9fSX8/DIAr3T4sPL
	hGfNFxCCGluuuLV4g0uPfsE=
X-Google-Smtp-Source: AGHT+IHpTRb9ZsNlOdTaOnmxWls02DlZ24RU1byhkjNqQfZJBGR9fk7exiKPi9UZ9wdarAw/oWoKfA==
X-Received: by 2002:a05:600c:c10:b0:40d:33cb:b577 with SMTP id fm16-20020a05600c0c1000b0040d33cbb577mr716095wmb.3.1703085532684;
        Wed, 20 Dec 2023 07:18:52 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id j35-20020a05600c1c2300b0040b3515cdf8sm3593917wms.7.2023.12.20.07.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:18:52 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Frank Oltmanns <frank@oltmanns.dev>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject:
 Re: [PATCH 5/5] drm/panel: st7703: Drive XBD599 panel at higher clock rate
Date: Wed, 20 Dec 2023 16:18:49 +0100
Message-ID: <1845418.atdPhlSkOF@jernej-laptop>
In-Reply-To: <87edfh9ud8.fsf@oltmanns.dev>
References:
 <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
 <10386431.nUPlyArG6x@jernej-laptop> <87edfh9ud8.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne sreda, 20. december 2023 ob 08:14:27 CET je Frank Oltmanns napisal(a):
>=20
> On 2023-12-19 at 18:04:29 +0100, Jernej =C5=A0krabec <jernej.skrabec@gmai=
l.com> wrote:
> > Dne ponedeljek, 18. december 2023 ob 14:35:23 CET je Frank Oltmanns nap=
isal(a):
> >> This panel is used in the pinephone that runs on a Allwinner A64 SOC.
> >> Acoording to it's datasheet, the SOC requires PLL-MIPI to run at more
> >> than 500 MHz.
> >>
> >> Therefore, change [hv]sync_(start|end) so that we reach a clock rate
> >> that is high enough to drive PLL-MIPI within its limits.
> >>
> >> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> >
> > I'm not too sure about this patch. I see that PLL_MIPI doesn't have set
> > minimum frequency limit in clock driver. If you add it, clock framework
> > should find rate that is high enough and divisible with target rate.
>=20
> This one is really a tough nut. Unfortunately, the PLL_MIPI clock for
> this panel has to run exactly at 6 * panel clock. Let me start by
> showing the relevant part of the clock tree (this is on the pinephone
> after applying the patches):
>     pll-video0                 393600000
>        pll-mipi                500945454
>           tcon0                500945454
>              tcon-data-clock   125236363
>=20
> To elaborate, tcon-data-clock has to run at 1/4 the DSI per-lane bit
> rate [1]. It's a fixed divisor
>=20
> The panel I'm proposing to change is defined as this:
>=20
>     static const struct st7703_panel_desc xbd599_desc =3D {
>     	.mode =3D &xbd599_mode,
>     	.lanes =3D 4,
>     	.mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE,
>     	.format =3D MIPI_DSI_FMT_RGB888,
>     	.init_sequence =3D xbd599_init_sequence,
>     };
>=20
> So, we have 24 bpp and 4 lanes. Therefore, the resulting requested
> tcon-data-clock rate is
>     crtc_clock * 1000 * (24 / 4) / 4
>=20
> tcon-data-clock therefore requests a parent rate of
>     4 * (crtc_clock * 1000 * (24 / 4) / 4)
>=20
> The initial 4 is the fixed divisor between tcon0 and tcon-data-clock.
> Since tcon0 is a ccu_mux, the rate of tcon0 equals the rate of pll-mipi.
>=20
> Since PLL-MIPI has to run at at least at 500MHz this forces us to have a
> crtc_clock >=3D 83.333 MHz. The mode I'm prorposing results in a rate of
> 83.502 MHz.

This is much better explanation why this change is needed. Still, I think
adding min and max rate to PLL_MIPI would make sense, so proper rates
are guaranteed.

Anyway, do you know where are all those old values come from? And how did
you come up with new ones? I guess you can't just simply change timings,
there are probably some HW limitations? Do you know if BSP kernel support
this panel and how this situation is solved there?

>=20
> If we only changed the constraints on the PLL_MIPI without changing the
> panel mode, we end up with a mismatch. This, in turn, would result in
> dropped frames, right?

=46rom what I read, I think frame rate would be higher than 60 fps. What
exactly would happen depends on the panel.

Best regards,
Jernej

>=20
> Best regards,
>   Frank
>=20
> [1] Source:
> https://elixir.bootlin.com/linux/v6.6.7/source/drivers/gpu/drm/sun4i/sun4=
i_tcon.c#L346
>=20
> >
> > Best regards,
> > Jernej
> >
> >> ---
> >>  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 14 +++++++-------
> >>  1 file changed, 7 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/g=
pu/drm/panel/panel-sitronix-st7703.c
> >> index b55bafd1a8be..6886fd7f765e 100644
> >> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> >> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> >> @@ -320,14 +320,14 @@ static int xbd599_init_sequence(struct st7703 *c=
tx)
> >>
> >>  static const struct drm_display_mode xbd599_mode =3D {
> >>  	.hdisplay    =3D 720,
> >> -	.hsync_start =3D 720 + 40,
> >> -	.hsync_end   =3D 720 + 40 + 40,
> >> -	.htotal	     =3D 720 + 40 + 40 + 40,
> >> +	.hsync_start =3D 720 + 65,
> >> +	.hsync_end   =3D 720 + 65 + 65,
> >> +	.htotal      =3D 720 + 65 + 65 + 65,
> >>  	.vdisplay    =3D 1440,
> >> -	.vsync_start =3D 1440 + 18,
> >> -	.vsync_end   =3D 1440 + 18 + 10,
> >> -	.vtotal	     =3D 1440 + 18 + 10 + 17,
> >> -	.clock	     =3D 69000,
> >> +	.vsync_start =3D 1440 + 30,
> >> +	.vsync_end   =3D 1440 + 30 + 22,
> >> +	.vtotal	     =3D 1440 + 30 + 22 + 29,
> >> +	.clock	     =3D (720 + 65 + 65 + 65) * (1440 + 30 + 22 + 29) * 60 / =
1000,
> >>  	.flags	     =3D DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> >>  	.width_mm    =3D 68,
> >>  	.height_mm   =3D 136,
> >>
> >>
>=20





