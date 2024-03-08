Return-Path: <linux-kernel+bounces-96869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265B0876269
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D6B1F23C50
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F5A55780;
	Fri,  8 Mar 2024 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4IwoUao"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32F654FB2;
	Fri,  8 Mar 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894891; cv=none; b=fTgzjbvUwjXww9A8eXi2LaAMoZlmieaG3H66OYUcwS7l6fgP9ls0eyE7wqjbs/5eQSP19yRO6ikCEDfxBpjc3HApqJxBnx7FzCsVosSx7fSB7JIBDUboDGYMDvXcXBNIKExNLpmOPuM+lseFFMGgV6y3oO06vm/HdMJgnr2hdj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894891; c=relaxed/simple;
	bh=Oh9+83stTEAWMxwiZmN2wXsRzxzcIcyaMy4cNtT2Vm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV4SOzK8GMOSebRTOQUdAzVkwJ4g25q5rxwR2lOlvgTh+XIsu/WhCRXTYQPk0IMSOOX+lTmmd1Lrdk8+AxyaDADRkh3twhFF35+u9HVUzDCXuPB2Gg53MpcGyrseGFqb6S9NLKhJMy/8pkFTwY9bnZ2xBLHAGtF2Slu8LdJUohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4IwoUao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ED0C433F1;
	Fri,  8 Mar 2024 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709894890;
	bh=Oh9+83stTEAWMxwiZmN2wXsRzxzcIcyaMy4cNtT2Vm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4IwoUaoLjXJA6CTTrAUzh3glAZf2bLgRzsNjadq5egUbe/oPJfLUvSw4aDjzcOf1
	 T/BYyopXyLoJJ9YgO1cOizZIQEvvJkCesQCowbsIh2/xm1/+Uiv6hVZlo4PH1kv7KP
	 39TzmqqlkZ74cVfA/WF/xVWlpKCsEA6G39JW5DC5hAEh9u+vfhRFAS6zeM1iRIZRZI
	 uNKl9faqpCsGunQY1rItPtmXX+rkJ0ZfwC+nWq3WVp99OV+8Qu51vAIA3hbWdTMsdC
	 ConXosMVMCxWdA1EB89rFIFskhlsJ+rEl9Vkwp+79S9DR4kHdm6UIWOZK8tXznxYwn
	 wd6iKGVE2nMhQ==
Date: Fri, 8 Mar 2024 11:48:07 +0100
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?B?SsOpcsOpbWll?= Dautheribes <jeremie.dautheribes@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Yen-Mei Goh <yen-mei.goh@keysight.com>
Subject: Re: [PATCH v2 3/3] drm/panel: simple: add CMT430B19N00 LCD panel
 support
Message-ID: <20240308-shiny-meaty-duck-446e8d@houat>
References: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>
 <20240304160454.96977-4-jeremie.dautheribes@bootlin.com>
 <20240304-inquisitive-kickass-pronghorn-c641ff@houat>
 <ee36a60d-5b65-4eb8-ac41-e4b6be1cf81f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vglunjsivqojxdbh"
Content-Disposition: inline
In-Reply-To: <ee36a60d-5b65-4eb8-ac41-e4b6be1cf81f@bootlin.com>


--vglunjsivqojxdbh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 10:46:55AM +0100, J=E9r=E9mie Dautheribes wrote:
> Hi Maxime,
>=20
> On 04/03/2024 17:25, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Mon, Mar 04, 2024 at 05:04:54PM +0100, J=E9r=E9mie Dautheribes wrote:
> > > Add support for Crystal Clear Technology CMT430B19N00 4.3" 480x272
> > > TFT-LCD panel.
> > >=20
> > > Signed-off-by: J=E9r=E9mie Dautheribes <jeremie.dautheribes@bootlin.c=
om>
> > > ---
> > >   drivers/gpu/drm/panel/panel-simple.c | 29 +++++++++++++++++++++++++=
+++
> > >   1 file changed, 29 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/p=
anel/panel-simple.c
> > > index 20e3df1c59d4..b940220f56e2 100644
> > > --- a/drivers/gpu/drm/panel/panel-simple.c
> > > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > > @@ -1457,6 +1457,32 @@ static const struct panel_desc boe_hv070wsa =
=3D {
> > >   	.connector_type =3D DRM_MODE_CONNECTOR_LVDS,
> > >   };
> > > +static const struct drm_display_mode cct_cmt430b19n00_mode =3D {
> > > +	.clock =3D 9000,
> > > +	.hdisplay =3D 480,
> > > +	.hsync_start =3D 480 + 43,
> > > +	.hsync_end =3D 480 + 43 + 8,
> > > +	.htotal =3D 480 + 43 + 8 + 4,
> > > +	.vdisplay =3D 272,
> > > +	.vsync_start =3D 272 + 12,
> > > +	.vsync_end =3D 272 + 12 + 8,
> > > +	.vtotal =3D 272 + 12 + 8 + 4,
> > > +	.flags =3D DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> > > +};
> >=20
> > Your pixel clock doesn't really match the rest of the timings:
> >=20
> > (480 + 43 + 8 + 4) * (272 + 12 + 8 + 4) * 60 =3D 9501600
> >=20
> > So a ~6% deviation.
> >=20
> > What does the datasheet say?
>=20
> Indeed it does not exactly match but the datasheet indicates that the
> typical clock frequency is 9MHz and when this frequency is used, the
> typical values of the other parameters are those we have defined in
> the drm_display_mode structure.

It seems weird to me that all the typical timings end up in a
non-typical configuration, but I've seen my fair share of weird
datasheet, so.. yeah.

I guess the best thing to do if you have access to the min/typ/max
timings is to actually use the display_timings structure here and define
all of them.

It at least gives us the opportunity to fix it later on.

> I don't see any information about the accepted deviation either.

It's not only about the panel itself. 6% gives your roughly 56fps when
you meant 60. This can then trip up some applications too. Like if
you're playing a 60fps application, it will either play too fast or
you'll get stutter, depending on how the video playback has been
implemented exactly.

Maxime

--vglunjsivqojxdbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZers5wAKCRDj7w1vZxhR
xRi0APwMTxCozvo10NB+M+y2Z3QMtuMjP1GtOoTo/nC52Lx3AgD/dLgDGRrAJ+ex
3iIbCnd/WsMDVaQyTwOqnJ8OeOQ5ygc=
=2WQs
-----END PGP SIGNATURE-----

--vglunjsivqojxdbh--

