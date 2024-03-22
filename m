Return-Path: <linux-kernel+bounces-111064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B980886782
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEB41F24C33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2790312E59;
	Fri, 22 Mar 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iSD9Xgd4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B79F17541;
	Fri, 22 Mar 2024 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092700; cv=none; b=JurtapyVu4HdzMDSpfG9aFoIxPSW0Sew8jiiyK6lwW4OYsI87r3G8YaUwl3pNGMmVtE2DY45ag/QFcsiONJlSFDQMTMIWWW9H2Esy1/ZzcC98sra2TASR/anBT6HddfZqtKnOyqn9UcwtrpkU2qaOej9e3Rc4gKFpBhdmMRfJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092700; c=relaxed/simple;
	bh=1rzS6p1dJQyF/ZSOpXxB1J4g5C8EI88hO1+/BB5uU90=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huxOnTyXIE7pZNJ39qUiISa8No6DUgfV7blz7B8yshfj/9O+RMwEKH87IYuK2HOfrNX0CtLSIxuTSJOWMze6qgk0ysVbIgC2vCzqhWBgqW/RwsWsMmBBECee/tN4Fvq9oLRkhFYO/nhCWzPHqdueWYVt9B3pdWVlGPgUfd3H1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iSD9Xgd4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711092698; x=1742628698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1rzS6p1dJQyF/ZSOpXxB1J4g5C8EI88hO1+/BB5uU90=;
  b=iSD9Xgd46P+QVW9IiApFp4zOrq8EFxUXbmj5BiREyLt1x2hBTXXWvP+P
   4TT5xR4kZ4WVU13K0JYe+EMYA7PIB69EysZZlu2ugAOjEsR0qj0woy3c9
   226LVZjAchd7cS7fivM6GmowP729Av3jbzyXhd3EA5As88rW4kLrL1bP/
   2MdWo/6rngnT9rI2Ii+BQPAf705w3W/giNyCU+zOnCcmDM+wlGWwScPWm
   NJR+A8qSEpvOrvVmaq6fAjIr5VoGtZGmiP96UguZEIGqCckXJchdPlY7j
   NR5hNQAVtUXjfmyhF9qp4iq4oZoS1j5xq2gWlXbxajgurgjEaIqV5QCzf
   Q==;
X-CSE-ConnectionGUID: aRUh/ppPSjiLg30OD7E4FA==
X-CSE-MsgGUID: 8SIMjWfATaawJYZQlZMRbQ==
X-IronPort-AV: E=Sophos;i="6.07,145,1708412400"; 
   d="asc'?scan'208";a="18544964"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2024 00:31:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 00:31:29 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 22 Mar 2024 00:31:26 -0700
Date: Fri, 22 Mar 2024 07:30:39 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: <Balamanikandan.Gunasundar@microchip.com>
CC: <conor@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mtd: atmel-nand: convert txt to yaml
Message-ID: <20240322-arrest-pucker-7ff731359fa0@wendy>
References: <20240320-linux-next-nand-yaml-v1-0-2d2495363e88@microchip.com>
 <20240320-linux-next-nand-yaml-v1-1-2d2495363e88@microchip.com>
 <20240320-quicksand-attentive-14610103237b@spud>
 <3c199359-f0d8-4ec0-bf86-930b2ecfb876@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5XY8D9lenP0Sop6x"
Content-Disposition: inline
In-Reply-To: <3c199359-f0d8-4ec0-bf86-930b2ecfb876@microchip.com>

--5XY8D9lenP0Sop6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 04:27:29AM +0000, Balamanikandan.Gunasundar@microch=
ip.com wrote:
> On 20/03/24 10:05 pm, Conor Dooley wrote:
> > On Wed, Mar 20, 2024 at 11:22:07AM +0530, Balamanikandan Gunasundar wro=
te:

> >> +allOf:
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - atmel,at91rm9200-nand-controller
> >> +              - atmel,at91sam9260-nand-controller
> >> +              - atmel,at91sam9261-nand-controller
> >> +              - atmel,at91sam9g45-nand-controller
> >> +              - atmel,sama5d3-nand-controller
> >> +              - microchip,sam9x60-nand-controller
> >> +    then:
> >> +      properties:
> >> +        "#address-cells":
> >> +          const: 2
> >> +
> >> +        "#size-cells":
> >> +          const: 1
> > Why is this in an if? Isn't this all of the devices in the binding?
> >=20
>=20
> The default nand-controller.yaml defines this as const values.=20
> (#address-cell : 1 and #size-cells : 1). I am trying to override this=20
> const value.

You're not overriding anything as you don't have a ref to
nand-controller.yaml in this file, AFAICT. Why don't you?

> May be I should think about better approach ?

You should be able to apply this unconditionally for this file. I don't
see why the if would be needed?


> >> +patternProperties:
> >> +  "^nand@[a-f0-9]$":
> >> +    type: object
> >> +    $ref: nand-chip.yaml#
> >> +    description:
> >> +      NAND chip bindings. All generic properties described in
> >> +      Documentation/devicetree/bindings/mtd/{common,nand}.txt also ap=
ply to
> >> +      the NAND device node, and NAND partitions should be defined und=
er the
> >> +      NAND node as described in
> >> +      Documentation/devicetree/bindings/mtd/partition.txt.
> > These files do not exist.
> >=20
>=20
> Apologies for copying the content from the text file. I will correct this.

You don't need these comments at all I think. You have the ref to
nand-chip.yaml, so at least the first text file reference can be
removed.

> Yes. I should fix the alignment. I will send a v2 shortly

I did make other comments, so I assume you agree with everything else I
mentioned and will implement them in v2.

Thanks,
Conor.

--5XY8D9lenP0Sop6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf0zmQAKCRB4tDGHoIJi
0udtAQD10mY1UxAUiy245iE/HFMBpXrP6RsT1/Jv5xwrvG6KqQD/XUG4OLX7ZUxr
FFeupjEPcEhaLjXcg3DqAb7W/vtRCAw=
=Lnin
-----END PGP SIGNATURE-----

--5XY8D9lenP0Sop6x--

