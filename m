Return-Path: <linux-kernel+bounces-124456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4CE89183F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE2D2846C0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A0685298;
	Fri, 29 Mar 2024 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XRgTagDW"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728D823B7;
	Fri, 29 Mar 2024 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711713566; cv=none; b=IWbex8UJij+Gd3/SpO9wGwGKtqyKG/wCiRFy9iv9PdCfYjAMCZOejousGYugfhiJyU3ZNlyhz5fMeyNlU9qzSN66s8EnlSoJwYepQAauNDXwOuWDLNmFCkfl6kBoFWHBtbzWg6h29QU4KspG+8c7/56EgLfNDiqc8IHhrvFitJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711713566; c=relaxed/simple;
	bh=cjbAuMTMXKx++l4J+3XQzM/fFWNxtC8QIqIAOFaIwdU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGmsVLHU1SkGkLjro3W/bjweZXh274mViRQsW1mE+lbIYWy9f32nE/6wHuXSHbI4uXlLUbJB1WfkaiYJaSBDu2OP2FM3OEfc6NlXa9MS/nAJhSY71fpRbpLMdp2SB3c4HjWGUf6y1PsPnYl2M22tm5Ljzb9wQR3POakaS4V/Vg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XRgTagDW; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711713565; x=1743249565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cjbAuMTMXKx++l4J+3XQzM/fFWNxtC8QIqIAOFaIwdU=;
  b=XRgTagDW2cJN+1s+zTUPsi6qlIOzRalFJq3AEnRUC4wbvtqAozEbHHJl
   NgB0fbIpeUU3UoFFCFnQBBWkPv3oaRF/K7/SsvgkB0esXN2isbc2sSFmX
   xn53yZ04C75fim4q90nU+mAMdAWzCW+a0FGw9ZTrjUylVnjmhzQmAK0IC
   zLNoUCBxC6DeYyYdcshFMNMrmPj2wSZ7x08HrZ3n4FvMIzAN5+d7F0ebp
   SPWiPmKQKPBSM9S3xpCG8bLu71/2NXHOlQXo0r+ULAKH60PQBdaIehUTs
   K4lTwinvFzXVY+06Cil0oQtdZM7Jlv8bM8XY+FmypDDSDwx9eGPj281JO
   A==;
X-CSE-ConnectionGUID: 21KtTG0/Sp6rKoX3BlJG6Q==
X-CSE-MsgGUID: b8Ho2tThR8+ZKWy5L4u3Cw==
X-IronPort-AV: E=Sophos;i="6.07,164,1708412400"; 
   d="asc'?scan'208";a="18648063"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2024 04:59:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 04:59:14 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 04:59:11 -0700
Date: Fri, 29 Mar 2024 11:58:23 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Alexey Romanov <avromanov@salutedevices.com>
CC: Conor Dooley <conor@kernel.org>, "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>, "clabbe@baylibre.com" <clabbe@baylibre.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "khilman@baylibre.com" <khilman@baylibre.com>,
	"jbrunet@baylibre.com" <jbrunet@baylibre.com>,
	"martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v6 19/23] dt-bindings: crypto: meson: support new SoC's
Message-ID: <20240329-gore-eligible-cfdb8b14aee1@wendy>
References: <20240326153219.2915080-1-avromanov@salutedevices.com>
 <20240326153219.2915080-20-avromanov@salutedevices.com>
 <20240326-boneless-patrol-b1156a4be70b@spud>
 <20240329111601.po33wqdaaqpc54mo@cab-wsm-0029881>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cLRhY+ZqcVb5bqr0"
Content-Disposition: inline
In-Reply-To: <20240329111601.po33wqdaaqpc54mo@cab-wsm-0029881>

--cLRhY+ZqcVb5bqr0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:16:06AM +0000, Alexey Romanov wrote:
> Hello,
>=20
> On Tue, Mar 26, 2024 at 06:04:46PM +0000, Conor Dooley wrote:
> > On Tue, Mar 26, 2024 at 06:32:15PM +0300, Alexey Romanov wrote:
> > > Now crypto module available at G12A/G12B/S4/A1/SM1/AXG.
> > >=20
> > > 1. Add new compatibles:
> > >   - amlogic,g12a-crypto
> > >   - amlogic,axg-crypto
> > >   - amlogic,a1-crypto
> > >   - amlogic,s4-crypto (uses a1-crypto as fallback)
> > >=20
> > > 2. Add power-domains in schema.
> > >=20
> > > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> > > ---
> > >  .../bindings/crypto/amlogic,gxl-crypto.yaml       | 15 +++++++++++++=
--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-cry=
pto.yaml b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> > > index d3af7b4d5f39..c92edde314aa 100644
> > > --- a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> > > +++ b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> > > @@ -11,8 +11,16 @@ maintainers:
> > > =20
> > >  properties:
> > >    compatible:
> > > -    items:
> > > -      - const: amlogic,gxl-crypto
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - amlogic,s4-crypto
> > > +          - const: amlogic,a1-crypto
> > > +      - enum:
> > > +          - amlogic,gxl-crypto
> > > +          - amlogic,axg-crypto
> > > +          - amlogic,g12a-crypto
> > > +          - amlogic,a1-crypto
> > > =20
> > >    reg:
> > >      maxItems: 1
> > > @@ -21,6 +29,9 @@ properties:
> > >      items:
> > >        - description: Interrupt for flow 0
> > > =20
> > > +  power-domains:
> > > +    maxItems: 1
> >=20
> > Is power-domains valid for the devices that existed prior to your patch?
>=20
> For existed devices (GXL) power domain doesn't required.

Required or not I'm not interested in, it's whether or not the hardware
has them. The GXL does for the VPU, so it might also have one for the
the crypto. If the crypto is not in a power domain on gxl, please make
power-domains only permitted for SoCs that do have power domains.

Cheers,
Conor.

--cLRhY+ZqcVb5bqr0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgas3wAKCRB4tDGHoIJi
0lGkAQD2mwJjWTODw+WJx1/pSg/1IFxNC/iu7jcQQJv3dICZlgD7B/9l7/6G4ZJS
UhYeDA5Rd/GBnUiUiCGZFY4KwnggVgo=
=rAfb
-----END PGP SIGNATURE-----

--cLRhY+ZqcVb5bqr0--

