Return-Path: <linux-kernel+bounces-48680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF03845FB2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C247028707C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94BF12FB28;
	Thu,  1 Feb 2024 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7872NvY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EC312FB05;
	Thu,  1 Feb 2024 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811491; cv=none; b=GUrPckvOdahOyNv3WGiByLslQojZG4t55Ji5SMS9FoHF1n1H+hbSNdBOw6FdUXQ0oxVt8hU3PqdfKE9VtRuLPZNkxEyG9vEeFKpxt1imv/3LBPAaRK9IZ/1TIYknwvhEDk8JRzXhIlh6aWLjBt/pCl8hpdhyMl4jJMvsc2HZpdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811491; c=relaxed/simple;
	bh=z6WKuU1HFI/4wMnCCTZC8GXV1OCBNqKCE/QSX/bD25s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn+9ypBVCHuhMNaXzQ4rDxMORnwANCWrH+yO4dkw0C9ogxrRy1tBAloSlFy23r/32tjcX3JUvo19QnpjKxXKFw9DsZ/4FZBohMWmRwKbGXJdSV17vENK1CZ7G9+aW052f5TdOH7XtMjRkTXeKIRUy/OOIZKW9ywC2LHi5KWxEU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7872NvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F372BC433C7;
	Thu,  1 Feb 2024 18:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706811490;
	bh=z6WKuU1HFI/4wMnCCTZC8GXV1OCBNqKCE/QSX/bD25s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7872NvYaajmupe/mwjNS5jZxcZxKpSbZJlZ/OQobph41jOrTusBjPsuCZO3LzHDd
	 pCv2eDP7sYXlAkiUlcMpIwNgqtVg23CkyD5kFrq95GDUcBBGlzyY5UQZVHboA3hRNe
	 8wQwK9xfhHnGFFsQ1xScPvnTmvGro8Jj9PnAltk0tyoiIEYOJ+1WHk5Y+ydsRvbmb7
	 EMxsQAJPVC/P2Z1Hkhh1gL5zfifd2wSBZj7fD3QFu0EH8Aneb7gSFmh7TvOS5t96kb
	 1wJeF7+9Fdys0HhVQolTtJtn7kcblyYV3an02muu4PVcOLDk4eVwNAF3tSeZsKgh6f
	 FWGpxd84fwufA==
Date: Thu, 1 Feb 2024 18:18:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: nm@ti.com, vigneshr@ti.com, afd@ti.com, kristo@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, srk@ti.com, r-gunasekaran@ti.com, b-liu@ti.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: usb/ti,am62-usb.yaml: Add PHY2
 register space
Message-ID: <20240201-violet-chalice-51a73f113e7b@spud>
References: <20240201120332.4811-1-rogerq@kernel.org>
 <20240201120332.4811-5-rogerq@kernel.org>
 <20240201-viewpoint-upload-fb714f650ff5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8eQ0qgWYbjjWzvr3"
Content-Disposition: inline
In-Reply-To: <20240201-viewpoint-upload-fb714f650ff5@spud>


--8eQ0qgWYbjjWzvr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 06:15:20PM +0000, Conor Dooley wrote:
> On Thu, Feb 01, 2024 at 02:03:31PM +0200, Roger Quadros wrote:
> > So far this was not required but due to the newly identified
> > Errata i2409 [1] we need to poke this register space.
> >=20
> > [1] https://www.ti.com/lit/er/sprz487d/sprz487d.pdf
> >=20
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Actually, where is the user for this that actually pokes the register
space?
You're adding another register region, so I went to check how you were
handling that in drivers, but there's no driver patch.


>=20
> > ---
> >=20
> > Notes:
> >     Changelog:
> >    =20
> >     v3 - new patch
> >=20
> >  Documentation/devicetree/bindings/usb/ti,am62-usb.yaml | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/D=
ocumentation/devicetree/bindings/usb/ti,am62-usb.yaml
> > index fec5651f5602..c02d9d467d9c 100644
> > --- a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> > +++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> > @@ -14,7 +14,9 @@ properties:
> >      const: ti,am62-usb
> > =20
> >    reg:
> > -    maxItems: 1
> > +    items:
> > +      - description: USB CFG register space
> > +      - description: USB PHY2 register space
> > =20
> >    ranges: true
> > =20
> > @@ -82,7 +84,8 @@ examples:
> > =20
> >        usbss1: usb@f910000 {
> >          compatible =3D "ti,am62-usb";
> > -        reg =3D <0x00 0x0f910000 0x00 0x800>;
> > +        reg =3D <0x00 0x0f910000 0x00 0x800>,
> > +              <0x00 0x0f918000 0x00 0x400>;
>=20
> Why the double zeros btw?
>=20
> Cheers,
> Conor.
>=20
> >          clocks =3D <&k3_clks 162 3>;
> >          clock-names =3D "ref";
> >          ti,syscon-phy-pll-refclk =3D <&wkup_conf 0x4018>;
> > --=20
> > 2.34.1
> >=20



--8eQ0qgWYbjjWzvr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbvgXQAKCRB4tDGHoIJi
0sdAAP9CwtjgDQiVIVOeUV887o2JKyoIPBrTD8GYnJlNJha6DwD9GbpvvnGm33n9
XM3cVekUSO7RnwTFzob/dvmPCq/PrQM=
=Qazv
-----END PGP SIGNATURE-----

--8eQ0qgWYbjjWzvr3--

