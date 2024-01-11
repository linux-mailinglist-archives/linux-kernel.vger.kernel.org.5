Return-Path: <linux-kernel+bounces-23893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE49B82B350
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7D71C2304E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C49751C44;
	Thu, 11 Jan 2024 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tnne66hi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912C51C2E;
	Thu, 11 Jan 2024 16:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691C7C433C7;
	Thu, 11 Jan 2024 16:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704991747;
	bh=JdwruGDOEdzB2LuGJA/Hcp7a/rN5jmDIR9zUt6kA1eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tnne66himYCZMvtSrB5AQ5bZMV/aVEiGgmUqR3NHgzpaXygBCvM9ZpYjVZVZKmAkb
	 uBOlalwvgw71CoeqPJI18yaT+y2ob9cnqFzzqAsEufaOOkqQ6qC7zIEbN52jZPjc5v
	 eviEQeREKmpJeqlUuFSBEGJFHBX4e79zmgl4pdyN0km1nmzvBlCVsU6mRrop63ekmE
	 kSvfwghGpauqe3OgP+LqqafBnMOBFPrhR3Mq7IWoYtRP7+/xlbLGP9vgOcoH/Bg8HL
	 Fgr3JpEwE+WJZl46LPFQqv98llIsvSokeBRR6FOaL14JAPKVvg8zpWMn00GSD0poVy
	 ta31W013FFrjg==
Date: Thu, 11 Jan 2024 16:49:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: interrupt-controller: fsl, irqsteer:
 Add power-domains
Message-ID: <20240111-dullness-blooper-37644405c825@spud>
References: <20240110094338.472304-1-alexander.stein@ew.tq-group.com>
 <20240110-ignore-womanhood-a7ee7caa71f1@spud>
 <9230083.CDJkKcVGEf@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wWaS4J8enbsL6FHr"
Content-Disposition: inline
In-Reply-To: <9230083.CDJkKcVGEf@steina-w>


--wWaS4J8enbsL6FHr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 09:59:54AM +0100, Alexander Stein wrote:
> Hi Conor,
>=20
> Am Mittwoch, 10. Januar 2024, 17:09:07 CET schrieb Conor Dooley:
> > On Wed, Jan 10, 2024 at 10:43:38AM +0100, Alexander Stein wrote:
> > > Some SoC like i.MX8QXP use a power-domain for this IP add it to the
> > > supported proerties. Fixes the dtbs_check warning:
> > > freescale/imx8qxp-tqma8xqp-mba8xx.dtb: irqsteer@56000000: 'power-doma=
ins'
> > >=20
> > >  does not match any of the regexes: 'pinctrl-[0-9]+'
> > >=20
> > > from schema $id:
> > > http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yaml#
> > >=20
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > >=20
> > > Notes:
> > >     Please note that both the board dts and the DT node for irqsteer =
being
> > >     used, are still work-in-progress.
> >=20
> > The binding doesn't even support the imx8qxp's irqsteer yet, I think
> > this should be added alongside support for that SoC. Am I missing
> > something?
>=20
> I'm not sure if any additional SoC support is actually needed. 'fsl,imx-
> irqsteer' is available and that's what I use in my WiP. Also imx8mp also =
just=20
> uses the generic compatible. Only imx8mq uses 'fsl,imx8m-irqsteer'.

Why doesn't it used "imx8mq-irqsteer"? Should it not have its own
soc-specific compatible?

Cheers,
Conor.

> AFAICS the bindings support the different amount of IRQs already.
>=20
> Best regards,
> Alexander
>=20
> >=20
> > >  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml | 3 +=
++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer=
=2Eyam
> > > l
> > > b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer=
=2Eyam
> > > l index 20ad4ad82ad64..cb4fcd23627f6 100644
> > > ---
> > > a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer=
=2Eyam
> > > l +++
> > > b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer=
=2Eyam
> > > l>=20
> > > @@ -42,6 +42,9 @@ properties:
> > >    clock-names:
> > >      const: ipg
> > >=20
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > >=20
> > >    interrupt-controller: true
> > >   =20
> > >    "#interrupt-cells":
>=20
>=20
> --=20
> TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht M=FCnchen, HRB 105018
> Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
>=20
>=20

--wWaS4J8enbsL6FHr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaAb/wAKCRB4tDGHoIJi
0mFtAQCQQn8CGov6Wc2IEhbZM1R3caFBQt9b2jc9NHRpZlKjYgEAiL5ehZjTcg10
R3lSZNCwyavk+9pMR/M/cs742X7hAwY=
=jPFd
-----END PGP SIGNATURE-----

--wWaS4J8enbsL6FHr--

