Return-Path: <linux-kernel+bounces-9988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F1581CE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10FDDB21973
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F6628E1C;
	Fri, 22 Dec 2023 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAjK9W1/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C9A28DDA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33686649b72so1959542f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703267696; x=1703872496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oj0ljpZLwr9kojU6Bm2y0A367iD4r4CItsptTMa/Oic=;
        b=IAjK9W1/R3E2nOC/NDIbNxTnu2fr8DnZ98+2uz9LmUhe8lpUxbE51146m/zI+FtW1U
         akISO4Kw6hoc1aWFyHRMowlwZ0748akqosMRBl/qaUMtcRG6EZZ1l8LC21uh3ybpa1tJ
         TWkZGEC2e3pymvvPXj9y82NPE36rRMb0oUDA0sRD8UlBsgWOoQcGhfXbeoe3Gs4kOrPo
         2uXD498la0Z+wLx6SRNls3as+r+/VGuCqKT24NZG7HVsvFwa6gtOKEphz7D4HH/C4esn
         kHKruQ+dEd9zNt+m7FP5oDtu9znM5ixktLWDTYE+VkSK6POiJYKDa1KtO+XfhE7Y3zk+
         4nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703267696; x=1703872496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oj0ljpZLwr9kojU6Bm2y0A367iD4r4CItsptTMa/Oic=;
        b=Mj1aBCHm/5PWJefKx3mFnqkuXr2rBeXlrrK45aUd9XDRLNCoqwbniI+smIiL4A8RaJ
         mNt5YMEpnZ78/2WvNa0dg2oJSx3mKIxvlWCPr+ZwzqWWVzQ7Yi79giH+vLqphIZqHc3w
         amnO9jt1ssko0CtKHx07YCdN4EaqejvtE/xs+qe4NWuT2gZTTE1IdX1RYzI4bJXWbn/Y
         TQbn60gVLdg0CXM+ha+FpHtBEB7OIn6Pl+3LTZyBfkRrMKeJhVjeq4mvk1M81A5+Hdqn
         iBwSnK4tl8khJFpTiSB/w0gRBjgscXFAdNUTDRPRopVlPiSoGfwshZWIMB+dAoRfB4+s
         EevA==
X-Gm-Message-State: AOJu0Ywzs35YyctRm0coNE5S5tS3wouh/6+IXqhPoV4l9L2iEyxsloEj
	6lo7HNPb1N8awT6LOLUTmcg=
X-Google-Smtp-Source: AGHT+IE6/WJXh8sGkbCJYkrbDuO3jlBRsiAC2Kk2c4CASZhaBVu6YzVdo/PYMaOpVujDGHZzrmeYcg==
X-Received: by 2002:adf:f78f:0:b0:336:6e22:672c with SMTP id q15-20020adff78f000000b003366e22672cmr1029458wrp.88.1703267695558;
        Fri, 22 Dec 2023 09:54:55 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id d17-20020adfe2d1000000b0033673ddd81csm4801113wrj.112.2023.12.22.09.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:54:55 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>, Lee Jones <lee@kernel.org>
Cc: fuyao <fuyao1697@cyg.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>,
 maijianzhang <maijianzhang@allwinnertech.com>
Subject:
 Re: [PATCH RESEND] iio: adc: sun4i-gpadc-iio: adaptation interrupt number
Date: Fri, 22 Dec 2023 18:54:53 +0100
Message-ID: <4953611.0VBMTVartN@jernej-laptop>
In-Reply-To: <20231221152553.GM10102@google.com>
References:
 <YxmR5SPPY18O7LaG@google.com>
 <20231220115412.65bbc8c7@donnerap.manchester.arm.com>
 <20231221152553.GM10102@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne =C4=8Detrtek, 21. december 2023 ob 16:25:53 CET je Lee Jones napisal(a):
> On Wed, 20 Dec 2023, Andre Przywara wrote:
>=20
> > On Wed, 20 Dec 2023 15:23:17 +0800
> > fuyao <fuyao1697@cyg.com> wrote:
> >=20
> > Hi,
> >=20
> > > __platform_get_irq_byname determinies whether the interrupt
> > > number is 0 and returns EINVAL.
> >=20
> > can you please say what this fixes, exactly? Is something not working at
> > the moment? Can you please provide parts of the error message?
> >=20
> > And maybe expand the explanation a bit more? For instance mention that =
the
> > identifiers are used as IRQ resource numbers, where 0 is treated specia=
lly.
> >=20
> > Cheers,
> > Andre
> >=20
> > >=20
> > > Signed-off-by: fuyao <fuyao1697@cyg.com>
>=20
> You have to use your full real name as well.

Isn't that enough after
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dd4563201f33a022fc0353033d9dfeb1606a88330 ?

Best regards,
Jernej

>=20
> > > Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > ---
> > >  include/linux/mfd/sun4i-gpadc.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4=
i-gpadc.h
> > > index ea0ccf33a459..021f820f9d52 100644
> > > --- a/include/linux/mfd/sun4i-gpadc.h
> > > +++ b/include/linux/mfd/sun4i-gpadc.h
> > > @@ -81,8 +81,8 @@
> > >  #define SUN4I_GPADC_TEMP_DATA				0x20
> > >  #define SUN4I_GPADC_DATA				0x24
> > > =20
> > > -#define SUN4I_GPADC_IRQ_FIFO_DATA			0
> > > -#define SUN4I_GPADC_IRQ_TEMP_DATA			1
> > > +#define SUN4I_GPADC_IRQ_FIFO_DATA			1
> > > +#define SUN4I_GPADC_IRQ_TEMP_DATA			2
> > > =20
> > >  /* 10s delay before suspending the IP */
> > >  #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
> >=20
>=20
>=20





