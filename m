Return-Path: <linux-kernel+bounces-122703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAA888FBC3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3791C2C564
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906E05FB9A;
	Thu, 28 Mar 2024 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Xup2Ivl2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1822618E1E;
	Thu, 28 Mar 2024 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618673; cv=none; b=gZ8pUm3uoF+vB5JuWwrye9DUncXOy3h5+/uJyhvTbtc/eejL8bjL/PC3r/0F9tFv/jWBACfnNXQDKTmkRzTJJKddEM3VphIbQ0DKhkM/Y+0vaKACMQ9AwFgIk7VrtAyhzl5LQOlusSn17+5M9MGFZJG+ScTrb864SUX/1ytL+M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618673; c=relaxed/simple;
	bh=je05IT2ra3zgp+R3TY8tIA0/mN+MpWGD8AqLDSxjOnw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYE92DxsybxbFMsvjFI2aR/jceVurNIRgUWIEqyy3p31wiil2NSWgHreErCFNJOlhCEiC+KcVjXs2uuHitAApZ4epLacHhPnYOnTgHkJfEDVlO+6ErDkvzVlGSaxSLXmfcf9toDyPmxlZpUnPuPnEC5/ICGYapTyNF35pe/RV3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Xup2Ivl2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711618671; x=1743154671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=je05IT2ra3zgp+R3TY8tIA0/mN+MpWGD8AqLDSxjOnw=;
  b=Xup2Ivl2AAl1lj6vaBUEiRETmkWjQljPpZVPBUNnMRuAQoFPAIq7/Z8C
   72C8Unu27JlgA2GM+yU1PvyFVOyYDsXDE1Ja9WL5c9drUWV9mPZY1kI1B
   va+iXXnGyaVTHaQ5I45zMJGbckiFMTmDJvXtzJ3bniFKSLnRg/xZdiHZB
   7WQ7SmtYSzoDEaJZ5eC7CaNLZN4iDP9ElRGoIouA3rnLdH+CBBNjLHKlN
   kosMeoHtyYeLwK2SZ88sl1cpmAidzK786JUMfj3ENAfnZj8MbNn/e1E32
   r1QqB0bRiqzVEGHVu9rSobZdHrqT/r7jnpXuCBGy3TjYwp89YYg2syUEp
   A==;
X-CSE-ConnectionGUID: DX6dgQOrQEKgaromDnuM8w==
X-CSE-MsgGUID: oruQuroDSA+lampJ4MlvIw==
X-IronPort-AV: E=Sophos;i="6.07,161,1708412400"; 
   d="asc'?scan'208";a="18510167"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2024 02:37:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 02:37:47 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 02:37:45 -0700
Date: Thu, 28 Mar 2024 09:36:57 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Keguang Zhang <keguang.zhang@gmail.com>
CC: Conor Dooley <conor@kernel.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: Add Loongson-1 NAND Controller
Message-ID: <20240328-tinfoil-skillet-b1c1629b97ee@wendy>
References: <20240327-loongson1-nand-v6-0-7f9311cef020@gmail.com>
 <20240327-loongson1-nand-v6-1-7f9311cef020@gmail.com>
 <20240327-bonehead-handlebar-1ca8dab95179@spud>
 <CAJhJPsX7Ds-UdFpTpLgFMW+rTGAgAYSKAieAMn12Z8RjNn-A8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8CphlZzrFnQFHqWt"
Content-Disposition: inline
In-Reply-To: <CAJhJPsX7Ds-UdFpTpLgFMW+rTGAgAYSKAieAMn12Z8RjNn-A8A@mail.gmail.com>

--8CphlZzrFnQFHqWt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 04:54:59PM +0800, Keguang Zhang wrote:
> On Thu, Mar 28, 2024 at 12:23=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Wed, Mar 27, 2024 at 06:43:59PM +0800, Keguang Zhang via B4 Relay wr=
ote:
> > > From: Keguang Zhang <keguang.zhang@gmail.com>
> > >
> > > Add devicetree binding document for Loongson-1 NAND Controller.
> > >
> > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > ---
> > > Changes in v6:
> > > - A newly added patch
> > > ---
> > >  .../devicetree/bindings/mtd/loongson,ls1x-nfc.yaml | 66 ++++++++++++=
++++++++++
> > >  1 file changed, 66 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mtd/loongson,ls1x-nfc.=
yaml b/Documentation/devicetree/bindings/mtd/loongson,ls1x-nfc.yaml
> > > new file mode 100644
> > > index 000000000000..2494c7b3b506
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mtd/loongson,ls1x-nfc.yaml
> > > @@ -0,0 +1,66 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mtd/loongson,ls1x-nfc.yaml#
> >
> > Please make the filename match the compatible.
> >
> Got it. I'll rename it to loongson,ls1-nfc.yaml and change the
> compatible as follows.
>   compatible:
>    items:
>      - enum:
>          - loongson,ls1a-nfc
>          - loongson,ls1b-nfc
>          - loongson,ls1c-nfc
>      - const: loongson,ls1-nfc

No, please do not do this. Just call the file "ls1b-nfc".

Thanks,
Conor.

--8CphlZzrFnQFHqWt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgU6OQAKCRB4tDGHoIJi
0qpNAQDPGcLdo896VBifrNbIBoMmtgOKSlc0RzqTLluuo9ii3wD+J5nVH5Pj+smz
YxsCrN3q+VxFGdQPTqKzmuxNdvT8owU=
=1nfV
-----END PGP SIGNATURE-----

--8CphlZzrFnQFHqWt--

