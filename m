Return-Path: <linux-kernel+bounces-46806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0167C84448E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267631C268DA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11FA63A7;
	Wed, 31 Jan 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udG2ZcRD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE49F63B3;
	Wed, 31 Jan 2024 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718653; cv=none; b=QqwXEfFfRxLHDobd89CapdLxlxQWHXELAY2+9cRdz2qMF8L1pre9+FyQDuBTDU1kByNGFPHQDxea8DW65EgrQNeSCbLDGzywAzYaIiJej0/Z4PmMvebxT5aOeekJ7NJ0swpw1wIwu/jTwNX3qvFIRU31KFfTM2Ql4Yr7E9JpgEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718653; c=relaxed/simple;
	bh=jV+IW1BRHUg+D+REntsLJtRkUxqONiKUmtqDsV82itI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bskAIB6wDaTqYfqQcaRA0l8TjTgtMzYGnG3BXwoStQsYioHzQQfgYxF/Jkl2bibfGQy4eACqUd5Jtn0rWpLcQPP8pUeJVHrEyIuoErasPb1+zKYr7l4B0q8nlI14Zhl+YxKa5hYSrC34vZzI0+McXJqiFUJ/RWhVDK5G1z4Pcyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udG2ZcRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1BEC433C7;
	Wed, 31 Jan 2024 16:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706718652;
	bh=jV+IW1BRHUg+D+REntsLJtRkUxqONiKUmtqDsV82itI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udG2ZcRDmMPjbK6aF+4k7fsWHwlpGxyg8XCxDbLkppGdsq6L73vhfSAYtMyv4wK6H
	 IYkOX8GbR9Mm0ccp4sIcyKJzgdetiCpZ/Z2qrVrvhSBxihAI1IJ7T0cZIX/k+Bs2Yf
	 Avm64pVoXKnvHC6NT3YcaUAfhj6DkPmYYt4zR/D3jgBMlB9r86XcS/7T75NP86FSRy
	 tAhMSWdH528agAjz7fh/aVEVoAVzqx5x/+cU048NmS9NZSgOzWOLX3Evk2rr0S8uQs
	 4AzUMKoulmjNSNkA08hpSTv7lQGII9EXVs4w7dVCIZ1gMPxSkaO6KLlfRgDLfV8FZF
	 f0rEik7hgaleA==
Date: Wed, 31 Jan 2024 17:30:49 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Keith Zhao <keith.zhao@starfivetech.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"airlied@gmail.com" <airlied@gmail.com>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, William Qiu <william.qiu@starfivetech.com>, 
	Xingyu Wu <xingyu.wu@starfivetech.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, Shengyang Chen <shengyang.chen@starfivetech.com>, 
	Jack Zhu <jack.zhu@starfivetech.com>, Changhuang Liang <changhuang.liang@starfivetech.com>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>
Subject: Re: =?utf-8?B?5Zue5aSNOg==?= [v3 4/6] drm/vs: Add KMS crtc&plane
Message-ID: <e2spje6iew6skzrhrcgr23g4dc7l7rjoq77ki6oupqborfl22b@owmd2sdzcdaj>
References: <20231204123315.28456-1-keith.zhao@starfivetech.com>
 <20231204123315.28456-5-keith.zhao@starfivetech.com>
 <o4ica2jg2rqfx6znir6j7mkoojoqzejjuqvlwcnehanw5mvop6@a3t6vi7c55tz>
 <NTZPR01MB1050AC99C38D2136D0354F3DEE7CA@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xv7z5ay3ishmxaq2"
Content-Disposition: inline
In-Reply-To: <NTZPR01MB1050AC99C38D2136D0354F3DEE7CA@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>


--xv7z5ay3ishmxaq2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 08:57:21AM +0000, Keith Zhao wrote:
> > > +static const struct vs_dc_info dc8200_info =3D {
> > > +	.name			=3D "DC8200",
> > > +	.panel_num		=3D 2,
> > > +	.plane_num		=3D 8,
> > > +	.planes			=3D dc_hw_planes_rev0,
> > > +	.layer_num		=3D 6,
> > > +	.max_bpc		=3D 10,
> > > +	.color_formats		=3D DRM_COLOR_FORMAT_RGB444 |
> > > +				  DRM_COLOR_FORMAT_YCBCR444 |
> > > +				  DRM_COLOR_FORMAT_YCBCR422 |
> > > +				  DRM_COLOR_FORMAT_YCBCR420,
> > > +	.gamma_size		=3D GAMMA_EX_SIZE,
> > > +	.gamma_bits		=3D 12,
> > > +	.pitch_alignment	=3D 128,
> > > +	.pipe_sync		=3D false,
> > > +	.background		=3D true,
> > > +	.panel_sync		=3D true,
> > > +	.cap_dec		=3D true,
> > > +};
> >=20
> > I really think that entire thing is to workaround a suboptimal device t=
ree binding.
> > You should have two CRTCs in the device tree, you'll probe twice, and y=
ou won't
> > get to do that whole dance.
> >=20
> Hi Maxime:
> I tried to modify it according to this idea Found it too difficult In ter=
ms of hardware,=20
> the two crtc designs are too close to separate, and they are even designe=
d into the same reg with different bits representing crtc0 and crtc1.
> It seems not easy to described the 2 ctrc hardware by 2 device nodes
>=20
> The idea is to avoid a whole dance
> I don't know if I understand correctly about whole dance.
> Is it means I create 2 ctrc and 8 plane in the dc_bind?

It looks like you just sent the same mail?

Maxime

--xv7z5ay3ishmxaq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZbp1uQAKCRDj7w1vZxhR
xTVnAQCPu+rxm42307fHf03GbrgNfJK7FjrljEfpxkkKMR2KHgD/TaZnj2hQnMsv
I3q4pY+SX55x7qpgGeeIIDvyLXESOQE=
=S6wD
-----END PGP SIGNATURE-----

--xv7z5ay3ishmxaq2--

