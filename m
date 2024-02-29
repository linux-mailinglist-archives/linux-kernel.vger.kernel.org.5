Return-Path: <linux-kernel+bounces-87321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA3A86D2B5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5F2B2460A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A88C134439;
	Thu, 29 Feb 2024 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYhS6MBl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3738132C1E;
	Thu, 29 Feb 2024 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233055; cv=none; b=mmT9bP93sZJfJdVuJg7yyc0JHOAa61BNZgAqEhV04+VpvO6RfO6Id6txEzTsBqTAcNcyrGLFIILk6L4UmZVR9dvqjQEz7UNoiTIHSK4jPcTxABKR63l9Sv0p1eVbEWBxG58esHvjWWve7KN1mwol75NATRX/0QltX8+sPscp5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233055; c=relaxed/simple;
	bh=SIV/OcKpLYJPRNLN8GBaovmuIE7JeHREf2m1wVfKbXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhYvDKykoTdb/Q/e8WjAMOaAF3I0n2V8UV86A5pRh7hGRitxZ6byBfJGatROomv2XexlUEh9LDgNPY3uvN1MqbfifEaH4I9KzoPIVuj5TbFfCnKBYNcRnGaAJymL+ahMnGjucYzuN/Jrnwmn65XZQX1KuNnoMkwbodk1s2ArX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYhS6MBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFEAC433F1;
	Thu, 29 Feb 2024 18:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709233055;
	bh=SIV/OcKpLYJPRNLN8GBaovmuIE7JeHREf2m1wVfKbXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYhS6MBlpsnhmkO4XWsaOJSoYx/Xk1Q8er3w7XNweqd6L9IB9SaeG5ZN9onxFrcL2
	 I+j6XEA6BXZy6hVm6gcqY5gGyoaRpXQVj0LG/GLVZVYnKAK5aBnC6NohkdG0Z8B8Hx
	 fWdb265uz4rdZhqHsPALNaCOIGIc49/+GaCqVOUIpVTVqytRDgiLLK/Zf3amu92X21
	 M0n1xyO1f6cS7rPjKkIZGk9Nd0eqWS/9nY8Tl3CWr9W3N53ggMC0sVFFvomeLCpHIe
	 xNCQPJIlrWtJS3x32MtjNo/d55mHeoDoRPTMksZkCKewcljnzhiFpH1/BF7q/c8pnV
	 ShLKoDhmDhdUg==
Date: Thu, 29 Feb 2024 18:57:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <20240229-rundown-isotope-954ba9ea4c57@spud>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
 <20240227-asrc_8qxp-v2-3-521bcc7eb1c0@nxp.com>
 <20240229-husband-penalty-8c1ab0f57f55@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f27rDTztjgMlItsA"
Content-Disposition: inline
In-Reply-To: <20240229-husband-penalty-8c1ab0f57f55@spud>


--f27rDTztjgMlItsA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 06:55:58PM +0000, Conor Dooley wrote:
> On Tue, Feb 27, 2024 at 03:54:11PM -0500, Frank Li wrote:
> > Some sai only connect one direction. So allow only "rx" or "tx" for
> > dma-names.
>=20
> Which sai? Can you restrict this per compatible please, so that someone
> cannot add 2 dmas for ones where only the tx is supported.
>=20
> |  dmas:
> |    minItems: 1
> |    items:
> |      - description: DMA controller phandle and request line for RX
> |      - description: DMA controller phandle and request line for TX
>=20
> The binding already allows only one, but it documents that the first dma
> is always the RX dma, and that doesn't change with this patch..

I said "doesn't change" - but I don't think you can change this
trivially, as something could rely on the first dma being the rx one.
You'd have to check that there is nothing using these using indices
rather than names before making any changes here.

>=20
> Cheers,
> Conor.
>=20
> >=20
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Doc=
umentation/devicetree/bindings/sound/fsl,sai.yaml
> > index 2456d958adeef..0302752d58a2b 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > @@ -86,10 +86,14 @@ properties:
> >        - description: DMA controller phandle and request line for TX
> > =20
> >    dma-names:
> > -    minItems: 1
> > -    items:
> > -      - const: rx
> > -      - const: tx
> > +    oneOf:
> > +      - items:
> > +          - const: rx
> > +          - const: tx
> > +      - items:
> > +          - enum:
> > +              - rx
> > +              - tx
> > =20
> >    interrupts:
> >      items:
> >=20
> > --=20
> > 2.34.1
> >=20



--f27rDTztjgMlItsA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeDTmQAKCRB4tDGHoIJi
0rgHAQCYl6mE2L/hnElG11u6Vr/sR7gSJ+0qK71eDfW4f9aY6AEAs9EtjaVRKU6X
4jUmpJiEOCgLYSSuInAcG40zvdKpfgg=
=UzFD
-----END PGP SIGNATURE-----

--f27rDTztjgMlItsA--

