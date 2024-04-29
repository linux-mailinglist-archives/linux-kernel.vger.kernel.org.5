Return-Path: <linux-kernel+bounces-163074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6988B64AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3361C2109C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E821B184107;
	Mon, 29 Apr 2024 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cST7eTmy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B8412B73;
	Mon, 29 Apr 2024 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426403; cv=none; b=cTGU7h04HJCZMn3s0sc+yxKpI/KlUtD+2+68MQb5Ds9d2DeSp8q9H+aZ45G20+lCUOgMniHXVhibGKff8SwkIO6bjDc26B9t79oLTVFb5eflv0GJxMyM2wEhdFd2MsmGLM2FdLW/XH/k4nQlfb+1/obuypZC0VCo78UIaK5fhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426403; c=relaxed/simple;
	bh=vPZAau7DfYbcbdcMAfEj+TotC+iHlyn/Ut9666HLFes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+kvL2XPZxJxhFT0bfc/8I0mQVso7UJDtIF3BXdj15rAiabUMqNP4Pgt2ovQIajQ6xo6urqou4MPS9d2xzztbUEWsgL9DDefOaD+Ve64ubC054wGu1Kpq4RkOvZLAwTRYC+YDcBeVB9BwV3fsoe+gajj9OAvHG+HUHcQpnROWTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cST7eTmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2A3C4AF1A;
	Mon, 29 Apr 2024 21:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714426402;
	bh=vPZAau7DfYbcbdcMAfEj+TotC+iHlyn/Ut9666HLFes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cST7eTmyDgOVR+Nm9wzqi9tTvJVZI0fLgyFmZWNloyIR9bGPDSxjdEkBwZ3IG8v4C
	 MiEc6LghhyeC/ZngvHaazyR/X051K6EnoZLwCj+4u5gsHo8N4V+cHOQVg0Qe3T4Cqt
	 Nkbt/DVrqJueJnzn7vxVYnpnhEA3GRgRsYoaDdz7rogy6Em+Yzm/Kxl9FK2OuciPZJ
	 KJErWuLwmqoFMKUUulyc+/CjTr85ddpOCYHb1y/J8uPKKwTo3teqXXYPggxI0Qt+t4
	 /jPZHQ+TGQ6WapvSM1qcAyrgpsxywS//JXr70hwxshAvqHYB/0oEHZiqWYU/6I+sn6
	 dXkArOYB+ycVA==
Date: Mon, 29 Apr 2024 22:33:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"pthombar@cadence.com" <pthombar@cadence.com>
Subject: Re: [EXTERNAL] Re: [PATCH v3 2/5] spi: cadence: Add MRVL overlay
 bindings documentation for Cadence XSPI
Message-ID: <20240429-quickstep-hypnotic-5b8d1fbeb920@spud>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
 <20240418011353.1764672-3-wsadowski@marvell.com>
 <20240418-sacrament-cornea-fd6fd569827e@spud>
 <CO6PR18MB4098C815325699975B1BD794B01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NS8/Unwlppg/0VLi"
Content-Disposition: inline
In-Reply-To: <CO6PR18MB4098C815325699975B1BD794B01B2@CO6PR18MB4098.namprd18.prod.outlook.com>


--NS8/Unwlppg/0VLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 02:47:23PM +0000, Witold Sadowski wrote:
> > ----------------------------------------------------------------------
> > On Wed, Apr 17, 2024 at 06:13:49PM -0700, Witold Sadowski wrote:
> > > Add new bindings for v2 Marvell xSPI overlay:
> > > mrvl,xspi-nor  compatible string
> > > New compatible string to distinguish between orginal and modified xSPI
> > > block
> > >
> > > PHY configuration registers
> > > Allow to change orginal xSPI PHY configuration values. If not set, and
> > > Marvell overlay is enabled, safe defaults will be written into xSPI
> > > PHY
> > >
> > > Optional base for xfer register set
> > > Additional reg field to allocate xSPI Marvell overlay XFER block
> > >
> > > Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
> > > ---
> > >  .../devicetree/bindings/spi/cdns,xspi.yaml    | 92 +++++++++++++++++=
+-
> > >  1 file changed, 91 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > > b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > > index eb0f92468185..0e608245b136 100644
> > > --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > > @@ -20,23 +20,82 @@ allOf:
> > >
> > >  properties:
> > >    compatible:
> > > -    const: cdns,xspi-nor
> > > +    oneOf:
> > > +      - description: Vanilla Cadence xSPI controller
> > > +        items:
> > > +          - const: cdns,xspi-nor
> >=20
> > The "items: isn't required here is it? Can't you just have
> >     oneOf:
> >       - description: Vanilla Cadence xSPI controller
> >         const: cdns,xspi-nor
> >       - description: Cadence xSPI controller with v2 Marvell overlay
> >         const: mrvl,xspi-nor
> > if you don't want to use an enum?
>=20
> It works without items, but I will try also with enums.
>=20
> >=20
> > > +      - description: Cadence xSPI controller with v2 Marvell overlay
> > > +        items:
> > > +          - const: mrvl,xspi-nor
> >=20
> >=20
> > "mrvl" is deprecated, please use "marvell". You're also missing a soc-
> > specific compatible here, I doubt there's only going to be one device f=
rom
> > marvell with an xspi controller ever.
>=20
> The intention is to add overlay on top of existing IP block to gain some
> More features from it. So if there will be different SoC with same xSPI
> IP, we can simply use that property, as internal SoC structure will be th=
e same.
> On the other hand, if there will be used different IP to handle SPI opera=
tions
> It should use different driver. Also, I do not expect that new version of=
 the
> Overlay will be developed to handle different IP.

I'm struggling to understand what you mean here by "overlay". Ordinarily
I'd expect someone to meant a dt-overlay, but you're talking about IP
blocks, so this sounds like hardware modifications.
I am also a bit confused by the claim that the "internal SoC structure
will be the same". Usually different SoCs have different internal
structures, even when they re-use IP cores. If they have the same internal
structure then they're not really different SoCs, just different
packages! I think what you're saying here is that you intend using the
"mrvl,xspi-nor" compatible for multiple SoCs that all contain the same
modified versions of the Cadence IP, not different packages for the same
SoC?

Confusing wording aside, using the same generic compatible for different
SoCs is what I trying to avoid. I don't mind there being a fallback
compatible that's generic, but I want to see specific compatibles here
for the individual SoCs.

If you did actually mean that only the packaging is different between
the devices, then I don't think you need specific compatibles for each
different package, but you should have one for the SoC itself IMO.

Cheers,
Conor.

--NS8/Unwlppg/0VLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjASHgAKCRB4tDGHoIJi
0oBbAQC0NnLRyKZEwSK5e9IOCYKDjpAqEH62W74ppfZV2hNxXgEAtffEVFSZIFTk
1/X/2d+rKYdrMFt0jyi7ka5Aad0dogA=
=PTs9
-----END PGP SIGNATURE-----

--NS8/Unwlppg/0VLi--

