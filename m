Return-Path: <linux-kernel+bounces-96043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C70875678
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 276C2B21080
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A2D135A66;
	Thu,  7 Mar 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbbV86UP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6091EF13;
	Thu,  7 Mar 2024 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837794; cv=none; b=qEcXcta0hokXijMAl1n0OdY7cKCge/6RGDtSF3KoEn+loW2PGeOhaqG2Jva3JDMuiSETm/c+nXelqIJuaxhkBJuOYWVgkhxPNOeSkWw12IbWrKqH3YQwKW5RlJ/qoEO0CrVnHZGU9jpHG/LII1nFQG/L/wRT5AJFnnVqHpb3GPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837794; c=relaxed/simple;
	bh=UV0sY6h4DN51/nvSU5fsXkmxOfhwJjNehBRV4+DLeao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oj5xgdqVOpuVyWySFGt5QC3q87/4Bpw3G+3lIkzPva54343d9vzVyHqpg0pnK/7GXvCM/LN5ToKgX78D6+o8RGCT1QszzsRGClw/1ZXzrJwsRZqeEscSfBo8Qy1BblsVmcyfXiLg3iBwwLyYChiviW9y9xD1ueFLqFfbPy3fvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbbV86UP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EDAC433C7;
	Thu,  7 Mar 2024 18:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709837793;
	bh=UV0sY6h4DN51/nvSU5fsXkmxOfhwJjNehBRV4+DLeao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbbV86UP6pH8ipawLp8zXWN0pywWlB75UXWU9TDaDlEa+1dOwSKN/TpdNaBdEiTMg
	 9Aey8CwYWmk+QGK5RXwfVM8ujORjBVhr0nMTerKnAOVedKY/CCikIplfVF6hhQJ4ob
	 xPUSeFFcwAZFfVQCQwT/nLDn5cnwK3TCDQF+I7J6ZJm1428odTpnDCibn6xw+jtEVN
	 pPZFHAZ1JFfOylLbNONip02c7KTCFEdaZnqPhp3FBCwsfnYFKcAg723X/7x7FcHfCU
	 j/gLbBa3e5ZADLyWKkky1i1BsrhclxrJQjAZCAwDhZ7P0aAqIZQV5GQReJQodgdayi
	 iY9V1jzbgn/0g==
Date: Thu, 7 Mar 2024 18:56:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <20240307-agnostic-dyslexia-6f1da244ec58@spud>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
 <20240305-asrc_8qxp-v4-3-c61b98046591@nxp.com>
 <20240306-pebble-grope-88fdaa95a87c@spud>
 <ZejDQddMp17RD6Yk@lizhi-Precision-Tower-5810>
 <20240306205524.GB587561-robh@kernel.org>
 <Zejdz0BKwSlsio9S@lizhi-Precision-Tower-5810>
 <CAL_JsqJw5W7a9Pz9gRPuP717onHdSwRvwGJ=v+QDSe+4ORvTaA@mail.gmail.com>
 <ZekgPg2nsLIQpvY/@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PgOaAGG3OrEgcB2K"
Content-Disposition: inline
In-Reply-To: <ZekgPg2nsLIQpvY/@lizhi-Precision-Tower-5810>


--PgOaAGG3OrEgcB2K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 09:02:38PM -0500, Frank Li wrote:
> On Wed, Mar 06, 2024 at 04:58:22PM -0600, Rob Herring wrote:
> > On Wed, Mar 6, 2024 at 3:19=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrot=
e:
> > >
> > > On Wed, Mar 06, 2024 at 02:55:24PM -0600, Rob Herring wrote:
> > > > On Wed, Mar 06, 2024 at 02:25:53PM -0500, Frank Li wrote:
> > > > > On Wed, Mar 06, 2024 at 06:45:13PM +0000, Conor Dooley wrote:
> > > > > > On Tue, Mar 05, 2024 at 12:33:04PM -0500, Frank Li wrote:
> > > > > > > Some sai only connect one direction dma (rx/tx) in SOC. For e=
xample:
> > > > > > > imx8qxp sai5 only connect tx dma channel. So allow only one "=
rx" or "tx"
> > > > > > > for dma-names.
> > > > > > >
> > > > > > > Remove description under dmas because no user use index to ge=
t dma channel.
> > > > > > > All user use 'dma-names' to get correct dma channel. dma-name=
s already in
> > > > > > > 'required' list.
> > > > > >
> > > > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > >
> > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > ---
> > > > > > >  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 13 ++=
++++-------
> > > > > > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.=
yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > > > > > index 2456d958adeef..6f551c68d33db 100644
> > > > > > > --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > > > > > +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > > > > > @@ -81,15 +81,14 @@ properties:
> > > > > > >
> > > > > > >    dmas:
> > > > > > >      minItems: 1
> > > > > > > -    items:
> > > > > > > -      - description: DMA controller phandle and request line=
 for RX
> > > > > > > -      - description: DMA controller phandle and request line=
 for TX
> > > > > > > +    maxItems: 2
> > > > > > >
> > > > > > >    dma-names:
> > > > > > > -    minItems: 1
> > > > > > > -    items:
> > > > > > > -      - const: rx
> > > > > > > -      - const: tx
> > > > > > > +    oneOf:
> > > > > > > +      - items:
> > > > > > > +          - const: rx
> > > > > > > +          - const: tx
> > > > > > > +      - enum: [ rx, tx ]
> > > > > >
> > > > > > I'm not entirely sure if this was Rob's suggestion, I got the i=
mpression
> > > > > > he was suggesting that in the two items case we'd not care abou=
t the
> > > > > > order. But while I think this is different to that suggestion i=
t's also
> > > > > > not wrong.

> > > > > Rob's suggest was not work. dt-binding check complain too long
> > > > > if there are two dma-names =3D "rx", "tx".
> > > >
> > > > So I'm wrong or you didn't have it correct? No way to tell with your
> > > > explanation. Let me give you the exact schema:
> > > >
> > > > dma-names:
> > > >   minItems: 1
> > > >   items:
> > > >     - enum: [ rx, tx ]
> > > >     - const: tx
> > > >
> > > > This says we can have 1 or 2 entries. The first entry can be either=
 rx
> > > > or tx. The 2nd entry must be tx. That's what you want. However, '"t=
x",
> > > > "tx"' is allowed with the above, but we enforce items to be unique
> > > > elsewhere. Or I thought we did, but we relaxed '.*-names$' at some
> > > > point. I'm going to fix that now.
> > >
> > > Conor find out my problem. The below code works. I missed maxItems.
> > >
> > >   dma-names:
> > >      minItems: 1
> > >      maxItems: 2
> > >      items
> >=20
> > Missing ':'
> >=20
> > >        enum: [ rx, tx ]
> >=20
> > That is not my suggestion. This would be my 3rd choice after what I
> > proposed or what you had already. Please plug in exactly what I told
> > you and report back what doesn't work.
>=20
> It also works. look likes conor's method is a little bit easy to be
> understood.

What I suggested is different, it is more permissive than what you have
or what Rob suggested. Your original one allows
"rx", "tx" OR "rx" OR "tx"
Rob's allows the same but with a nicer syntax. What that stm binding I
mentioned allows is
"rx", "tx" OR "tx", "rx" OR "rx" OR "tx"

--PgOaAGG3OrEgcB2K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeoN3AAKCRB4tDGHoIJi
0nd3AQCWltdW9osVlgRPEJE0ihSrSm9KZdQvqgiz22Um6H8xQQEAiKTPyYqzkfIt
B4P5sXRr4dR2MsnwyKa6AX2uGt0DZQs=
=CRIZ
-----END PGP SIGNATURE-----

--PgOaAGG3OrEgcB2K--

