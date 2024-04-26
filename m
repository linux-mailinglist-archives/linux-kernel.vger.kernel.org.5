Return-Path: <linux-kernel+bounces-160445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7FB8B3D95
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1C91C2091B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E82F15B0FB;
	Fri, 26 Apr 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzEUC8Cf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE0E15623B;
	Fri, 26 Apr 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151190; cv=none; b=RoeFlE6g+ArXCGA5PZv9tzwkRxrNcp5H6fqwbBtOC81L2dKapde2VkR+g9ii6GypfXPaGFz6H6f69EN5MvBjRkv2F0/UQQI//hSiArPiEa2LQao7mZX7q7bDnyCnk7Mz4du2asz5nLMLG5ajVTV3OQ+CJtyYQdvotdx3EyfHvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151190; c=relaxed/simple;
	bh=PUvdK8u/2qpExymDyazsbUcMYN5noyr63G0MyAIPnt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T78JijpnXC7+9YScm+5ACGmf+q6CDfW7259fHhBXxOQqxCCpbjWNQaBqHByNuDFClM8tWrsHzHoXLR0/GCxpkaUTDmrCW7LWRX/ecTeDmBV58GL6FmfmEZnAKZTiRTj4ljvAD65mt5c7UVYxj20VHUFiNdd4alU/kRCh6R6MNsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzEUC8Cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAEDC116B1;
	Fri, 26 Apr 2024 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714151190;
	bh=PUvdK8u/2qpExymDyazsbUcMYN5noyr63G0MyAIPnt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bzEUC8CfAGruTab+Ero+oPa2C4hcsEfY5Y14Ue4PVxzfaP3qcYo430Qs8xnewvQvt
	 qivIEQPZ0zU2mAosG7clQ4wSitDZnHqfDHB6DIly77EgD/va7P8HgnzS1d5cZ1idg3
	 0i4mhil3cBDrFHnaZMtyuon85lc92QQQanngzusp2iqraWLlJhFs/FWHPlWMBwMpCE
	 YjiPxj4cW7+VZ/Fas0Wc1gfaW/tJnnG00zvuJhI91GSH5JNaTJhar4MkE9wP9J1MuQ
	 nYqPO/E6zTWFiDiX7+0n2FqKdkpf1wnaW+aXuIAwE8l1jdIlrW4G1mqeeFL218FKOR
	 v+QnG5TKIREfQ==
Date: Fri, 26 Apr 2024 18:06:25 +0100
From: Conor Dooley <conor@kernel.org>
To: cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
	dianders@chromium.org, linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	conor+dt@kernel.org, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com
Subject: Re: [PATCH v3 1/7] dt-bindings: display: panel: Add himax hx83102
 panel bindings
Message-ID: <20240426-fifteen-random-ff4a535ab40d@spud>
References: <20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com>
 <20240424023010.2099949-2-yangcong5@huaqin.corp-partner.google.com>
 <20240424-spelling-float-9b881cb80992@spud>
 <CAHwB_NLb9ENfCj-oJ2mV_DwFJ0h6TGSi1byUdd6Bri3gDsCo5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KG4VLxjx13klv+v0"
Content-Disposition: inline
In-Reply-To: <CAHwB_NLb9ENfCj-oJ2mV_DwFJ0h6TGSi1byUdd6Bri3gDsCo5Q@mail.gmail.com>


--KG4VLxjx13klv+v0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 02:03:24PM +0800, cong yang wrote:
> Conor Dooley <conor@kernel.org> =E4=BA=8E2024=E5=B9=B44=E6=9C=8825=E6=97=
=A5=E5=91=A8=E5=9B=9B 00:55=E5=86=99=E9=81=93=EF=BC=9A
> > On Wed, Apr 24, 2024 at 10:30:04AM +0800, Cong Yang wrote:

> > > +++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.y=
aml
> >
> > Filename matching a compatible please. What you've done here makes it
> > seem like there's a fallback compatible missing, given this looks like
> > the LCD panel controller and the starry compatible below is an LCD pane=
l.
>=20
> So change the filename to starry,himax83102-j02.yaml?

IDK chief, are you missing a fallback or not?

>=20
> >
> > > @@ -0,0 +1,73 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/panel/himax,hx83102.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Himax HX83102 MIPI-DSI LCD panel controller

Because the title here makes it seem like there should be.

> > > +maintainers:
> > > +  - Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > > +
> > > +allOf:
> > > +  - $ref: panel-common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +        # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
> > > +      - starry,himax83102-j02
> > > +
> > > +  reg:
> > > +    description: the virtual channel number of a DSI peripheral
> > > +
> > > +  enable-gpios:
> > > +    description: a GPIO spec for the enable pin
> > > +
> > > +  pp1800-supply:
> > > +    description: core voltage supply
> > > +
> > > +  avdd-supply:
> > > +    description: phandle of the regulator that provides positive vol=
tage
> > > +
> > > +  avee-supply:
> > > +    description: phandle of the regulator that provides negative vol=
tage
> > > +
> > > +  backlight:
> > > +    description: phandle of the backlight device attached to the pan=
el
> >
> > I'm not sure why this was given a description when port or rotation
> > was not.
>=20
> So change it to backlight: true ?

Sure? It is just a repeat of something already described in
panel-common.

--KG4VLxjx13klv+v0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZivfEQAKCRB4tDGHoIJi
0ovXAQDGJnOsSMKJRaP2aIy/+907+rwA/s57l0E2Q/EA3qWPMAD6Aj4ASUzuPYHm
GRj7CsG1KnQPHUX0R43Qysud1+OLcQ4=
=hib7
-----END PGP SIGNATURE-----

--KG4VLxjx13klv+v0--

