Return-Path: <linux-kernel+bounces-79497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC07986234A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97EA284AC2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1284810A35;
	Sat, 24 Feb 2024 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvNw15f0"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA19D52F
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708758920; cv=none; b=Qvid77Og/G3k0Y21RM1vDJuUXTvMdluRIsODBd1JOkV1jnXin6BbXRDOUsy7dqqlwzlY+WONZdyiSKs/l7mcEPsraIWsUWPfGsCkSBGHwnPxvokDq85WZUZphLqtJ5kuhfwq0dGlao/18Zl7D4mu76Hkoh1UHqqFsrvNBnQZk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708758920; c=relaxed/simple;
	bh=0HAot224t49qJekPYxrS9uVB+eTCHcXufJIXNedY8jg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFzrO9nqH5MTLRY6dNs4c9x/uM9DHzhn8r/7tBquJvPU23tDNaVPySNDSczcMMnp3lhDqw/7y3Ad8DPEPQBb81JnxG2D656MOrJ0+QgHsQmrueZ1vaoNwtZeW2v1gxxSnQVgYHSG6ANyXfvUdvzQ6LhLW8SJEKBeL7X+O8mLTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvNw15f0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3e8c1e4aa7so148807466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708758917; x=1709363717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/l3rdHHadZ15R5gzk5CAjldRNRZfc44ldL/qVb2ZY4=;
        b=QvNw15f0fh9yL1sQ1qojMMQah4nht1Om+nDBLEFEosOlCof9MJT50aNP0lGI1EbEsK
         N2MNs/4KEbCqVvRNb+toayU3W4RFImulYUPTrRdldkMVZcH38ctUZdPbSfDy/rU2clQ+
         H59YNTtHekq9YDzUzm4MmM7nUdlUsdAje7ZdSnGezRyVOY89DqAT3ksv3gUaNP2fW/kW
         2jUVsK4L1F8w667ZQuSeJL96lmIlcCDkPKfUar4kQUkEq8M3bxQXREaPBcjYqjwnt1+5
         NwMGXnhQN+Xd9OpG0GZzjS9gzYoFLnyCHnk8hnTEZUB/eaDK48dBRRpGhQB8px+U9jC1
         V7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708758917; x=1709363717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/l3rdHHadZ15R5gzk5CAjldRNRZfc44ldL/qVb2ZY4=;
        b=vSkxFUPXp+2ZFg+w5JdIBTSFZcUK9wrtqrKp5d1jXRWuJ1XLh9Y140GKHJXyvLTmK+
         KJ98Pwe5pDxN9oePVMufzMnlgKdwMryjw8ccCVchyYZATf3+5P9qH4dFDZzuBkt/gp7q
         jGmpQ3+l98KcvDWVR1iVNe1TStw5ncKrse7lBJemqvZLw7gBX9IjLwu3q2QB4FV3g+X6
         250v7AwIgx1WldChbSWkUh12W4HS+08zjXySmX5x0G6FSUscDAvqCr2Nix9yUPDOtPnc
         su3YFzxu4mNDt5uWV0YBqUaYzNExRyRJVd0lO70GZv3KKYoPlaUxxCQmm8Wwa1K88wVf
         GJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCX8gBK50iLCVXAAYUjdYw/h/sGBQ3PMgUMea/BC21TC8w/8a1ICF7LDJiCfKS6TWdrPWAWYJ2y3emcg0Iz6BLiHMBG7c7XnzQvEe3Zt
X-Gm-Message-State: AOJu0YzrF+LUsVyX7g+NrvGiD5CuLPMh4fmGjocLhMclz9ORa3XoiPRr
	RXJIFG70V861GM7YfFTKAjKcsB125HdjSL+4Ytw1mK0kxkynz/Jg
X-Google-Smtp-Source: AGHT+IEchw50Yy6f2MPM1hIEjVE7JLq6sTy83bT2bvXfzjJTJuftRJidWkflr7PgJW7pu0uhxM1szg==
X-Received: by 2002:a17:906:5910:b0:a3f:583c:b00c with SMTP id h16-20020a170906591000b00a3f583cb00cmr1144362ejq.43.1708758916491;
        Fri, 23 Feb 2024 23:15:16 -0800 (PST)
Received: from archlinux.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id jx20-20020a170906ca5400b00a3d777aa8fesm322779ejb.69.2024.02.23.23.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 23:15:15 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: =?utf-8?B?T25kxZllag==?= Jirman <megi@xff.cz>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Samuel Holland <samuel@sholland.org>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 3/3] drm/sun4i: Fix layer zpos change/atomic modesetting
Date: Sat, 24 Feb 2024 08:10:05 +0100
Message-ID: <6018948.lOV4Wx5bFT@archlinux>
In-Reply-To: <5h7jcwsdlpe7w2xylbhlw2asfww3znqlmlnszwvvosz5ssokkq@dxhn4v4sy4nq>
References:
 <20240216190430.1374132-1-megi@xff.cz> <2448947.jE0xQCEvom@jernej-laptop>
 <5h7jcwsdlpe7w2xylbhlw2asfww3znqlmlnszwvvosz5ssokkq@dxhn4v4sy4nq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Saturday, February 24, 2024 3:20:43 AM CET Ond=C5=99ej Jirman wrote:
> On Thu, Feb 22, 2024 at 09:02:53PM +0100, Jernej =C5=A0krabec wrote:
> > Dne sreda, 21. februar 2024 ob 14:45:20 CET je Maxime Ripard napisal(a):
> > > Hi,
> > >=20
> > > On Fri, Feb 16, 2024 at 08:04:26PM +0100, Ond=C5=99ej Jirman wrote:
> > > > From: Ondrej Jirman <megi@xff.cz>
> > > >=20
> > > > Identical configurations of planes can lead to different (and wrong)
> > > > layer -> pipe routing at HW level, depending on the order of atomic
> > > > plane changes.
> > > >=20
> > > > For example:
> > > >=20
> > > > - Layer 1 is configured to zpos 0 and thus uses pipe 0. No other la=
yer
> > > >   is enabled. This is a typical situation at boot.
> > > >=20
> > > > - When a compositor takes over and layer 3 is enabled,
> > > >   sun8i_ui_layer_enable() will get called with old_zpos=3D0 zpos=3D=
1, which
> > > >   will lead to incorrect disabling of pipe 0 and enabling of pipe 1.
> > > >=20
> > > > What happens is that sun8i_ui_layer_enable() function may disable
> > > > blender pipes even if it is no longer assigned to its layer.
> > > >=20
> > > > To correct this, move the routing setup out of individual plane's
> > > > atomic_update into crtc's atomic_update, where it can be calculated
> > > > and updated all at once.
> > > >=20
> > > > Remove the atomic_disable callback because it is no longer needed.
> > > >=20
> > > > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > >=20
> > > I don't have enough knowledge about the mixers code to comment on your
> > > patch, so I'll let Jernej review it. However, this feels to me like t=
he
> > > pipe assignment is typically the sort of things that should be dealt
> > > with device-wide, and in atomic_check.
> >=20
> > In DE2 and DE3.0, you cannot move planes between mixers (crtcs), becaus=
e each
> > one is hardwired to specific mixer. Movable planes are the feature of D=
E3.3
> > and one of the pain points for upstreaming the code. Anyway, this commi=
t only
> > addresses current issue of enabling and disabling planes and handling z=
pos.
> >=20
> > In atomic check you can only precalculate final register values, but I =
don't
> > see any benefit doing that. I think that this code elegantly solves cur=
rent
> > issue of enabling or disabling wrong plane in certain situations, so:
> >=20
> > Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> >=20
> > Note, if there is new revision, please rewrite blender regmap_update_bi=
ts()
> > to regmap_write(). Since there is HW issue with reads, I would like to
> > get rid of regmap_update_bits() calls eventually.
>=20
> I've looked into it and I can probably rewrite these quite readily:
>=20
> +	regmap_update_bits(mixer->engine.regs,
> +			   SUN8I_MIXER_BLEND_ROUTE(bld_base),
> +			   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(0) |
> +			   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(1) |
> +			   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(2) |
> +			   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(3),
> +			   route);
>=20
> The mask here covers all implemented bits in the register.
>=20
> +	regmap_update_bits(mixer->engine.regs,
> +			   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
> +			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(0) |
> +			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(1) |
> +			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(2) |
> +			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(3),
> +			   pipe_en);
> +
>=20
> The mask here doesn't cover BLD_FILL_COLOR_CTL.Px_FCEN bits that implemen=
t solid
> color filling. But those can be 0 anyway except for pipe0 which is hardco=
ded by
> the driver to 1, I think:
>=20
> 631         /*
> 632          * Set fill color of bottom plane to black. Generally not nee=
ded
> 633          * except when VI plane is at bottom (zpos =3D 0) and enabled.
> 634          */
> 635         regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL(b=
ase),
> 636                      SUN8I_MIXER_BLEND_PIPE_CTL_FC_EN(0));

Correct on all counts. That's what I've meant.

>=20
> I will not be able to get rid of regmap_update_bits in sun8i_layer_enable
> because that register there has other important things in it like framebu=
ffer
> pixel format, etc.

Yeah, this rework would certainly be more involved, so it's out of the scop=
e of
this series.

Best regards,
Jernej

>=20
> kind regards,
> 	o.
>=20
> > Best regards,
> > Jernej
> >=20
> > >=20
> > > If I'm talking non-sense, it would be great to mention at least why t=
hat
> > > can't be an option in the commit log.
> > >=20
> > > Maxime
> > >=20
> >=20
> >=20
> >=20
> >=20
>=20





