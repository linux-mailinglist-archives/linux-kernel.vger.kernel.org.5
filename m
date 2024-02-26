Return-Path: <linux-kernel+bounces-81314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64584867401
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8781B1C24251
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91EF5B02B;
	Mon, 26 Feb 2024 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yc8jOMi2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41761DA5F;
	Mon, 26 Feb 2024 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948638; cv=none; b=ZoQqFN7kRmuOLasQCSt17qb8TR2cLX0LpsmSqa+TcB+bZ+yM3H10JoSWnU990DqaoMfazzYrEFQABAkhU0FpWptR2OI70DfivhPfxtnov/GoVg5wA1BlVLElc8bPSp/GrY5OEvjuBW9JAqcRuzAiFGCBHPqxA1brrtrgFmDOJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948638; c=relaxed/simple;
	bh=LXxr0oCyAyi941LBQn7wpQyHhte7aRcvaiULQ0755YM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1ZByZi92Y6SsUjLOwU5CA4EVKwbK9OP3MutEUa+ekhq1sIR2RUAIPWtmydV2sNbT7Hur8EZLXXp9swsHRFVE0sGpJrIE81igy6u592nKb/dV5pOnYVEax9b91x6NOFsb3nWwyYx/62c10X7N8ljaGIo1lNKdnKqYwseOtvo6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yc8jOMi2; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708948635; x=1740484635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LXxr0oCyAyi941LBQn7wpQyHhte7aRcvaiULQ0755YM=;
  b=yc8jOMi2NAlTLGpqikrG98GznAWohFNaEJpv6zoNkRPneZdUPx6IWNwj
   QKIivt6HMczgUkKVpcYt4hgUeXWaYyH/ezFeZCszl9yB2aGLO8k08NyB1
   lbJLOftKCYH7cmMJ5ESDgT3XE+zyRwpAVMgcVOu2NB3DwLRFYerQ4aCpq
   QRI39ga7Mh3SHZvGOhd6rMvqCfAZG6xcqGlyWzi78Qs5eJ+V2sv2Um5oB
   zM3bZuqZS6McEX4RxqY4PU5mtP+jvS5DTSnWI6l741xuXO7645makrR6c
   L9Md/xOlNiDTrsPD+4ZbrsCuA2xcA8jJQB7Ax7ktQ1Pl3EvODes53/DdB
   w==;
X-CSE-ConnectionGUID: Szb1mO22RbmH0OMhJ27Cfw==
X-CSE-MsgGUID: vdi+E3YdQS6QNTLBV3VCmQ==
X-IronPort-AV: E=Sophos;i="6.06,185,1705388400"; 
   d="asc'?scan'208";a="184093811"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2024 04:57:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 04:57:02 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 26 Feb 2024 04:56:59 -0700
Date: Mon, 26 Feb 2024 11:56:16 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
CC: Conor Dooley <conor@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>, Peter Chen
	<peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
	<kristo@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>, Kevin
 Hilman <khilman@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
	<linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: usb: ti,j721e-usb: drop useless
 compatible list
Message-ID: <20240226-portable-rockslide-e501667a0d9a@wendy>
References: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
 <20240223-j7200-usb-suspend-v3-1-b41c9893a130@bootlin.com>
 <20240223-clarity-variably-206b01b7276a@spud>
 <CZEXXXQDZZWB.1M5CTZAFVO4YP@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y/81symxI7pz60lC"
Content-Disposition: inline
In-Reply-To: <CZEXXXQDZZWB.1M5CTZAFVO4YP@bootlin.com>

--y/81symxI7pz60lC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 11:33:06AM +0100, Th=E9o Lebrun wrote:
> Hello Conor,
>=20
> On Fri Feb 23, 2024 at 7:12 PM CET, Conor Dooley wrote:
> > On Fri, Feb 23, 2024 at 05:05:25PM +0100, Th=E9o Lebrun wrote:
> > > Compatible can be A or B, not A or B or A+B. Remove last option.
> > > A=3Dti,j721e-usb and B=3Dti,am64-usb.
> > >=20
> > > Signed-off-by: Th=E9o Lebrun <theo.lebrun@bootlin.com>
> > > ---
> > >  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 9 +++------
> > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml =
b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > > index 95ff9791baea..949f45eb45c2 100644
> > > --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > > @@ -11,12 +11,9 @@ maintainers:
> > > =20
> > >  properties:
> > >    compatible:
> > > -    oneOf:
> > > -      - const: ti,j721e-usb
> > > -      - const: ti,am64-usb
> > > -      - items:
> > > -          - const: ti,j721e-usb
> > > -          - const: ti,am64-usb
> >
> > Correct, this makes no sense. The devices seem to be compatible though,
> > so I would expect this to actually be:
> > oneOf:
> >   - const: ti,j721e-usb
> >   - items:
> >       - const: ti,am64-usb
> >       - const: ti,j721e-usb
>=20
> I need your help to grasp what that change is supposed to express? Would
> you mind turning it into english sentences?
> A=3Dti,j721e-usb and B=3Dti,am64-usb. My understanding of your proposal is
> that a device can either be compat with A or B. But B is compatible
> with A so you express it as a list of items. If B is compat with A then
> A is compat with B. Does the order of items matter?

The two devices are compatible with each other, based on an inspection of
the driver and the existing "A+B" setup. If this was a newly submitted
binding, "B" would not get approved because "A+B" allows support without
software changes and all that jazz.

Your patch says that allowing "A", "B" and "A+B" makes no sense and you
suggest removing "A+B". I am agreeing that it makes no sense to allow
all 3 of these situations.

What I also noticed is other problems with the binding. What should have
been "A+B" is actually documented as "B+A", but that doesn't make sense
when the originally supported device is "A".

Therefore my suggestion was to only allow "A" and "A+B", which is what
we would (hopefully) tell you to do were you submitting the am64 support
as a new patch today.

> I've not applied your proposal to check for dtbs_check but I'd guess it
> would throw warnings for the single existing upstream DTSI (as of
> v6.8-rc6) that uses "ti,am64-usb"? See:
> arch/arm64/boot/dts/ti/k3-am64-main.dtsi.

Yeah, it would but it's not as if that cannot be changed. There's no
concerns here about backwards compatibility here, right?

--y/81symxI7pz60lC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdx8YAAKCRB4tDGHoIJi
0sCAAPwLF+i1FiXIYJ+rJDn2P1nOhyEPNbA2O5VrdxWhaSS8qgEA0qc5dIt6gFNG
4p7KsxNzS7FXx8EctGxE6ZdwAUiC5Qo=
=QOfZ
-----END PGP SIGNATURE-----

--y/81symxI7pz60lC--

