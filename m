Return-Path: <linux-kernel+bounces-94501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ABE8740B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3EF1F225EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087D414039E;
	Wed,  6 Mar 2024 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEETAeIJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4080913F00A;
	Wed,  6 Mar 2024 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754340; cv=none; b=P2C4CjvkAC/piWvIemx2Qb5qnybROSUIn4+rdrTwwzvG1hhTHux6o1flsKmixJqHcnX1pfoq5PQ8wrw+aAn2zrTKk4tcmYsBK78Cdo5dA9Uv1XxjQyDEfHpt1xutmG9AGQOipBv7veyggCrqjBjIv30dPQzgeVGCEiKWH3m51yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754340; c=relaxed/simple;
	bh=5G1J0BhLc6CdOxwigI/ctXSY559sZ3EGEXyuCpYSgf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAPKo8INt50ZGKglurPjWLo6ZfOP8pd4wszfalPDpOG1Wnraz48Dbz4qFIpj5AIhcENaJ83BW1Hxm5o9GhsXaoJZOjtdChAxMVRIK7cs5oih3633kPAlJvzgm2rYuRL79bGTj/bhx0CX6ZjPkdluTn6JZCkWRycaZ4DgIY5LFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEETAeIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CC3C433C7;
	Wed,  6 Mar 2024 19:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709754340;
	bh=5G1J0BhLc6CdOxwigI/ctXSY559sZ3EGEXyuCpYSgf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEETAeIJJSkUQUzPDySpQ9hhYT2x0WxKI6ArF+euMpwJjwUqo2ESLn0WA22TE5j7K
	 R36pHhm1XakM0l0MMl8oJg+XQV/ZMguoi4lKGDzUDb3GGj3HVakhMYnTO3NC6iGvGr
	 5Uua+soh+cdMV1VIPtwOX1TIf6lXef/7TWhr8/6D9qmif+9JMIEbZ2eZ5m+AprvbOc
	 vCaQjDrZ8L+ZelJA9gr/DIso2OwLiSH1SoPWKvBWeX7FIqhM7uOaVUm2UxjAPQEDqq
	 h7PxMikDG1u9yjzzjHrkOGmf47FsEmNCbxf3ItXW7YBIG87bp1fgOqUgFVzQBlFcBp
	 rcG8N5FNlw1vw==
Date: Wed, 6 Mar 2024 19:45:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
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
Subject: Re: [PATCH v4 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <20240306-petticoat-womb-a61cad7d788d@spud>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
 <20240305-asrc_8qxp-v4-3-c61b98046591@nxp.com>
 <20240306-pebble-grope-88fdaa95a87c@spud>
 <ZejDQddMp17RD6Yk@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="trxU1T+09Y67XLwE"
Content-Disposition: inline
In-Reply-To: <ZejDQddMp17RD6Yk@lizhi-Precision-Tower-5810>


--trxU1T+09Y67XLwE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 02:25:53PM -0500, Frank Li wrote:
> On Wed, Mar 06, 2024 at 06:45:13PM +0000, Conor Dooley wrote:
> > On Tue, Mar 05, 2024 at 12:33:04PM -0500, Frank Li wrote:
> > > Some sai only connect one direction dma (rx/tx) in SOC. For example:
> > > imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "=
tx"
> > > for dma-names.
> > >=20
> > > Remove description under dmas because no user use index to get dma ch=
annel.
> > > All user use 'dma-names' to get correct dma channel. dma-names alread=
y in
> > > 'required' list.
> >=20
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 13 ++++++----=
---
> > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/D=
ocumentation/devicetree/bindings/sound/fsl,sai.yaml
> > > index 2456d958adeef..6f551c68d33db 100644
> > > --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > @@ -81,15 +81,14 @@ properties:
> > > =20
> > >    dmas:
> > >      minItems: 1
> > > -    items:
> > > -      - description: DMA controller phandle and request line for RX
> > > -      - description: DMA controller phandle and request line for TX
> > > +    maxItems: 2
> > > =20
> > >    dma-names:
> > > -    minItems: 1
> > > -    items:
> > > -      - const: rx
> > > -      - const: tx
> > > +    oneOf:
> > > +      - items:
> > > +          - const: rx
> > > +          - const: tx
> > > +      - enum: [ rx, tx ]
> >=20
> > I'm not entirely sure if this was Rob's suggestion, I got the impression
> > he was suggesting that in the two items case we'd not care about the
> > order. But while I think this is different to that suggestion it's also
> > not wrong.
>=20
> I log this at cover-letter. b4 can't support write change log at every
> patch yet. Rob's suggest was not work. dt-binding check complain too long
> if there are two dma-names =3D "rx", "tx".=20

Yeh, that is what happens if you just have
dma-names:
  enum: [ rx, tx ]
since that only allows one entry. Take a look at st,stm32-uart.yaml
instead, for example.

--trxU1T+09Y67XLwE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZejH3gAKCRB4tDGHoIJi
0o5ZAQC0bEJLk2rMmNg1h6oK0puBl8tnJqZX4qRtU8t6hz4KlAEAmuy73tHPP4vO
iIc7yezGXRzST2Kg4QHm/imuO9iUSAs=
=u4Ht
-----END PGP SIGNATURE-----

--trxU1T+09Y67XLwE--

