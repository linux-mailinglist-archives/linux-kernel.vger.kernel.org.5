Return-Path: <linux-kernel+bounces-110576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3608860D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1A61F23349
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199B9134433;
	Thu, 21 Mar 2024 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Phmga02j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3D313441F;
	Thu, 21 Mar 2024 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711047630; cv=none; b=gIbuVphFbQWOsX64BSDKJR1iVb5vzlcflCAyXrdMsnJjSNDp1PX+LhGvqR4P3IWJpj2uHEXlJgpEveqnPnqAiCHjG8KaX05iJB+BL82W0FuTiA/FmshKItJy4d5X00YvNWYRlxe4RI/yfG0TCpYEnZHzVr5/d8VF1LFMwgk0mqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711047630; c=relaxed/simple;
	bh=NKpYyk60LjaAd7OWbS0rM8uQY8YQPxQLQGojBHAkF/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sey1Xrjxu49RVPJWFgahsCi1YBTy/20SBeVp5BXkPgygCCAwMNc2zmAfbM+aqz188V2jJMCoh41EFUnEx6mG3iCDgO0BmyqgyaAF1pAfA3v58AslI3gurZzsxJDnnVp+DXcie340lQn7rYZE0DGviV9PtTvMrzEfzF6toWh7MKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Phmga02j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA69C433C7;
	Thu, 21 Mar 2024 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711047629;
	bh=NKpYyk60LjaAd7OWbS0rM8uQY8YQPxQLQGojBHAkF/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Phmga02jpgMaMNeJxfMTrszhuv3XUrSCJNXAAU9OGQnjAeV2F8ifR8pVFmCCWwm9v
	 nu0FzTIibnyLaB0/pPUVlisT+Fw55J881XeIGOuXAUNUyL0gZs5UR4gNaNl98g7+9Y
	 x+SXnXd6dWsNUlngYoEJyxOE4PgTS0xgVxCnrPjpTVIVYCLyljuQ9e9o4SMHh4Jfot
	 BtaL4t7a2h5BLxkjNbdFQb6bJlzeik/GLqf+QhBtxKBihaOtQvf5KSb8J3acCMh50V
	 vl4sEbvvhEKUQ7oq9gwdxwyDnRYD+GFiTklf/A2UY2OhZGPRMDMRaTlPjExsjr2A8O
	 g5dXREB1fVWvg==
Date: Thu, 21 Mar 2024 19:00:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Karel Balej <balejk@matfyz.cz>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH v4 2/5] mfd: add driver for Marvell 88PM886 PMIC
Message-ID: <bd4e96b9-1026-469b-9884-073cde1f39dc@sirena.org.uk>
References: <20240321154211.GA13211@google.com>
 <CZZK759UU6G7.MFPYOI0HBB6I@matfyz.cz>
 <20240321162045.GC13211@google.com>
 <CZZL3MNOT0QG.2WDSNX9XD2RET@matfyz.cz>
 <879296b4-5186-4170-af3f-971787d28514@sirena.org.uk>
 <CZZLDK79D5VK.2VK3X59OHIY2Z@matfyz.cz>
 <45079e37-dde9-4310-a112-7af49f35ac77@sirena.org.uk>
 <CZZLVS3T3QIS.223XHI5OZ7UBG@matfyz.cz>
 <e9c7bd38-49cd-44c2-8842-292bc0b4205f@sirena.org.uk>
 <CZZMTZBZ5S7B.2HR8A6LEY08D4@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gbeioFqnXp7Lrcpb"
Content-Disposition: inline
In-Reply-To: <CZZMTZBZ5S7B.2HR8A6LEY08D4@matfyz.cz>
X-Cookie: MIT:


--gbeioFqnXp7Lrcpb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2024 at 07:16:43PM +0100, Karel Balej wrote:
> Mark Brown, 2024-03-21T17:48:28+00:00:

> > > They do according to the downstream driver which is my only reference.
> > > In fact, there the driver defines the configs separately for each regmap
> > > but with the same values.

> > This is a downstream driver - are you sure it's got the best code
> > quality?

> No, that is why I have rewritten it and tried to improve on this. But
> like I said, it is my only reference. Is there some other way to verify
> this value (besides perhaps the datasheet)?

The maximum register is whatever the maximum register we know about for
the device is, the datasheet is generally a good reference there.

> > I'm not seeing any references to registers with numbers as high as the
> > maximum register that's there in your driver for example.

> Indeed, I have performed the same check with the same findings. But that
> doesn't necessarily mean that the maximum should be lower, no?

> Do you have some specific modifications of my code in mind regarding
> this?

I would expect that if you have two separate register maps they would
have separate configurations that describe the corresponding physical
register maps, as far as I can tell this driver is just making up a
maximum register number.

--gbeioFqnXp7Lrcpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX8g8cACgkQJNaLcl1U
h9AxBQgAgjcW+ImZ11bySq1bHwmyQL3Ncx+yP1+3gBzqnuQjU8YLtueCjwMzPOlK
DbH6rty6I5az2zxFLRGUn0iF10RlH2GsTNMKvsaO4VkkpGg6q9M7l1bI/EwPmmx3
DTYt2m4HSfa3Rxx3C4LuwyC+RXuN960pv3Vf07QREno2432fAYdoa+dpC0Uw71fO
jgvvr73JuQ+xEJmibUrfOO98Fq4wXKrS93vKNMWDoA+ANoAZX+jeQat5CA/Z3cQV
S7Xt7nhAAxLYwlYfehh6WTLGNWHhPA6g+nb4x8yd+GjinffbDRB9cQPfMuMPSR1M
W/9QuiLVtbR3MSk0SbqfseCTjlmf8w==
=houc
-----END PGP SIGNATURE-----

--gbeioFqnXp7Lrcpb--

