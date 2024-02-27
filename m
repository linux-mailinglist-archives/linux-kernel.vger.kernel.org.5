Return-Path: <linux-kernel+bounces-82844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABB7868A79
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE84281BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E631156768;
	Tue, 27 Feb 2024 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZxtxggaW"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C8954F96;
	Tue, 27 Feb 2024 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021290; cv=none; b=Dw8z/sH/UFzCYfLOzl7THWNQTo37GQxHVb0z5GdA06BG5/WRTizRFyORufObyUkk/5c2cCTV0bHN0V1pkF2rkDz6dNX2jp85AaR7QLzQxlV3d/bnfcNn9oKjh3vHjKe8pBYj5I7Fp4fOTmKBbNTa7rI1Htq3abtPI7hV1sDv/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021290; c=relaxed/simple;
	bh=PtGQ5goxDMxof1agQAKAmcbBfhYu//IL5yynJzGYrkk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5aUEZaJG2N7GyWPvTE5JwhcpNSPjhZoXeJci4UPwVMkCN46FhFmjuSk8LwZLaDByvO1gKJ7/4c4x1itbL5lgdQ/iOReyPn6GBacoBAjhHP3FdXT2OFs5/R13rqV7iLJmWIRgKSFbrhYtDLz97YoWc8R/ZxigLDhmKMSU+vnBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZxtxggaW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709021287; x=1740557287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PtGQ5goxDMxof1agQAKAmcbBfhYu//IL5yynJzGYrkk=;
  b=ZxtxggaWVeP6OE7vRGNzobZUh6wCGiMgFkrOEB2DufTEnAv5Z7H287Bx
   NZ8H7XE/M5xASHTC7iKiJLaRCgJr0V5fCROBrWkSrYUiAxNC2WatH2amq
   gbN6q1c6cBWFXT6xGXCX6yH3qZVmiXG8ibYoZT2VUNnLLRc+Kk8fVTyTu
   bJM3tIxqldWsoz5tTTBn71uaqhcZeLHjZyq9M7oAU+4GJJlILsLU+SFGn
   mGECeRHS5/9FAJtXW3VMprYc0gniP767OxM4KydF8Aq22mrK+LrXEy28p
   9I9u5IHkkX92uxk4//w/LNqMV24pqtHzOBTW7Pe0Yq2umGGYgNPiw+bTx
   g==;
X-CSE-ConnectionGUID: 0gWJqGn3RPCuMO9uL5SkUQ==
X-CSE-MsgGUID: BzrlcXhkTAK8tf8Bn43wyw==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; 
   d="asc'?scan'208";a="17406316"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 01:08:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 01:07:48 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 01:07:45 -0700
Date: Tue, 27 Feb 2024 08:07:02 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>, Conor Dooley
	<conor@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Roger Quadros <rogerq@kernel.org>, Peter Chen <peter.chen@kernel.org>, Pawel
 Laszczak <pawell@cadence.com>, Nishanth Menon <nm@ti.com>, Tero Kristo
	<kristo@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>, Kevin
 Hilman <khilman@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
	<linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: usb: ti,j721e-usb: drop useless
 compatible list
Message-ID: <20240227-radiated-fame-57a2e685f1b0@wendy>
References: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
 <20240223-j7200-usb-suspend-v3-1-b41c9893a130@bootlin.com>
 <20240223-clarity-variably-206b01b7276a@spud>
 <CZEXXXQDZZWB.1M5CTZAFVO4YP@bootlin.com>
 <20240226-portable-rockslide-e501667a0d9a@wendy>
 <CZF33W51MC4M.3GUBZFQXT39DB@bootlin.com>
 <37ab0886-0cd1-4188-9177-8b7ef0ad9eca@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+JNVmkXccn+hyfZl"
Content-Disposition: inline
In-Reply-To: <37ab0886-0cd1-4188-9177-8b7ef0ad9eca@ti.com>

--+JNVmkXccn+hyfZl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 09:54:30AM +0530, Vignesh Raghavendra wrote:
> On 26/02/24 20:05, Th=E9o Lebrun wrote:
> > On Mon Feb 26, 2024 at 12:56 PM CET, Conor Dooley wrote:
> >> On Mon, Feb 26, 2024 at 11:33:06AM +0100, Th=E9o Lebrun wrote:
> >>> Hello Conor,
> >>>
> >>> On Fri Feb 23, 2024 at 7:12 PM CET, Conor Dooley wrote:
> >>>> On Fri, Feb 23, 2024 at 05:05:25PM +0100, Th=E9o Lebrun wrote:
> >>>>> Compatible can be A or B, not A or B or A+B. Remove last option.
> >>>>> A=3Dti,j721e-usb and B=3Dti,am64-usb.
> >>>>>
> >>>>> Signed-off-by: Th=E9o Lebrun <theo.lebrun@bootlin.com>
> >>>>> ---
> >>>>>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 9 +++---=
---
> >>>>>  1 file changed, 3 insertions(+), 6 deletions(-)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yam=
l b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> >>>>> index 95ff9791baea..949f45eb45c2 100644
> >>>>> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> >>>>> @@ -11,12 +11,9 @@ maintainers:
> >>>>> =20
> >>>>>  properties:
> >>>>>    compatible:
> >>>>> -    oneOf:
> >>>>> -      - const: ti,j721e-usb
> >>>>> -      - const: ti,am64-usb
> >>>>> -      - items:
> >>>>> -          - const: ti,j721e-usb
> >>>>> -          - const: ti,am64-usb
> >>>>
> >>>> Correct, this makes no sense. The devices seem to be compatible thou=
gh,
> >>>> so I would expect this to actually be:
> >>>> oneOf:
> >>>>   - const: ti,j721e-usb
> >>>>   - items:
> >>>>       - const: ti,am64-usb
> >>>>       - const: ti,j721e-usb
> >>>
> >>> I need your help to grasp what that change is supposed to express? Wo=
uld
> >>> you mind turning it into english sentences?
> >>> A=3Dti,j721e-usb and B=3Dti,am64-usb. My understanding of your propos=
al is
> >>> that a device can either be compat with A or B. But B is compatible
> >>> with A so you express it as a list of items. If B is compat with A th=
en
> >>> A is compat with B. Does the order of items matter?
> >>
> >> The two devices are compatible with each other, based on an inspection=
 of
> >> the driver and the existing "A+B" setup. If this was a newly submitted
> >> binding, "B" would not get approved because "A+B" allows support witho=
ut
> >> software changes and all that jazz.
> >>
> >> Your patch says that allowing "A", "B" and "A+B" makes no sense and you
> >> suggest removing "A+B". I am agreeing that it makes no sense to allow
> >> all 3 of these situations.
> >>
> >> What I also noticed is other problems with the binding. What should ha=
ve
> >> been "A+B" is actually documented as "B+A", but that doesn't make sense
> >> when the originally supported device is "A".

This A and B stuff confused me, I should just have used the actual
compatibles. I meant
| What should have been "B+A" is actually documented as "A+B", but that
| doesn't make sense when the originally supported device is "A"

> >>
> >> Therefore my suggestion was to only allow "A" and "A+B", which is what
> >> we would (hopefully) tell you to do were you submitting the am64 suppo=
rt
> >> as a new patch today.
> >=20
> > Thank you for the in-depth explanation! It makes much more sense now,
> > especially the handling of historic stuff that ideally wouldn't have
> > been done this way but that won't be changed from now on.
> >=20
>=20
> IIRC, idea behind adding new compatible for AM64 even though register
> map is very much compatible is just being future proof as AM64 and J721e
> belong to different product groups and thus have differences wrt SoC
> level integration etc which may need SoC specific handling later on.

That is fine, I don't think anyone here is disputing a soc-specific
compatible existing for this device.

> Also, note that AM64 SoC support was added long after J721e. So ideally
> should be B+A if at all we need a fallback compatible.

Correct, I accidentally wrote "A+B", but you can see that that
conflicted with the actual example I had given above.

> I don't see any DT (now or in the past) using
>=20
> compatible =3D B,A or compatible =3D A,B
>=20
> So do we really need A+B to be supported by binding?

Given the mistake, I am going to take this as meaning should the
fallback be supported. My take is that if we are going to remove
something, it should be "ti,am64-usb" isolation that should go.
The devicetrees can be update without concerns about compatibility.

Cheers,
Conor.



--+JNVmkXccn+hyfZl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd2YIQAKCRB4tDGHoIJi
0pqQAQCXBm9gvKWGSQ2qQ4acHNjGMTaMyayfkfljweUbpW9QywD/ehe10Pr1OdhV
WFOesqEw7mNUg37j97LIT669LzLlmwM=
=VE72
-----END PGP SIGNATURE-----

--+JNVmkXccn+hyfZl--

