Return-Path: <linux-kernel+bounces-54599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DD584B160
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD471C21F78
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FEB12D169;
	Tue,  6 Feb 2024 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZNFwC8yE"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AD912D140;
	Tue,  6 Feb 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212102; cv=none; b=f7Sjt/Uc9QdY4XKCQ27gjIgnoniFg6bk2CywLQAgIXjHxgF6/Bqg1QgayvnFEyQnvjLM1u8C484L/C3jLlydepXFUG3xp9AcqQYBGcKRoSJ9bTxLwxYQr9QBi5oWOIuMzTSeBdpuaO67myww5X/9HjbYMZ+DheCVDAAuUMH752I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212102; c=relaxed/simple;
	bh=gH6AhKH0jhJ/FMv6AwetfuernbeI6nyanvwXOjDPJn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAOmm+TvCUukvfTdCTQRsfHnVReMffwjGb1wqN8vbykXDCtRr1OidLVI1RVP+R2S2pVcVWIV/S0LSMBXpyP0/36Z+dpRaKUHYOaGhsN1WxlF9QXOp0z9LIsTcjZWzZRKcOIVoXZislckwIEFpLXWs5TegTm9qq6r4IQI0q9nlb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZNFwC8yE; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 035F920008;
	Tue,  6 Feb 2024 09:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707212098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nf+8f8FaGGKCD3vxgT3N1jG16pc7dueDBwmffjlOwGU=;
	b=ZNFwC8yET76pT3dIP/+NX2sP4bM5KjXSDOMYuppC/UidcMnpqDUrOBrGha1BLmulG2eeZw
	/JIYpGQVjlmZbsGhC1+d74lvlnRKjua1DpqyLLInUGPvC9ZA760GdX4bllKF/In8WhgPaC
	t4BbrvDdvbedKArrwCTcabUp+lApQQ0kjJ5pk2IXsdIdJaShhdLV6Eo/C4ixQwbhCWpSHV
	PQpRh8QiiVoRCVfswaIGgn15fZOgjClt3gP4QHpHndonoEUHMhOl5N6CEE8vPHuZo7U7IE
	lWBpDCMqzTYUNpNMxzVEox/6vKaOjTlrwVplGw4kg8iRTHGSv5fGxPfUIlTUmQ==
Date: Tue, 6 Feb 2024 10:34:53 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: William Zhang <william.zhang@broadcom.com>
Cc: Conor Dooley <conor@kernel.org>, Linux MTD List
 <linux-mtd@lists.infradead.org>, Linux ARM List
 <linux-arm-kernel@lists.infradead.org>, Broadcom Kernel List
 <bcm-kernel-feedback-list@broadcom.com>, f.fainelli@gmail.com,
 kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 devicetree@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Richard Weinberger <richard@nod.at>, Kamal Dasu
 <kdasu.kdev@gmail.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 03/12] dt-bindings: mtd: brcmnand: Add ecc strap
 property
Message-ID: <20240206103453.7ac23384@xps-13>
In-Reply-To: <ce15922e-4292-41d6-8c5f-2b4fbfa83d5c@broadcom.com>
References: <20240203002834.171462-1-william.zhang@broadcom.com>
	<20240203002834.171462-4-william.zhang@broadcom.com>
	<20240203-expenses-tarmac-c564bc7ae34f@spud>
	<20240205142639.5d7c70f0@xps-13>
	<ce15922e-4292-41d6-8c5f-2b4fbfa83d5c@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi William,

william.zhang@broadcom.com wrote on Mon, 5 Feb 2024 10:05:14 -0800:

> Hi Miquel,
>=20
> On 2/5/24 05:26, Miquel Raynal wrote:
> > Hi,
> >=20
> > conor@kernel.org wrote on Sat, 3 Feb 2024 14:49:50 +0000:
> >  =20
> >> On Fri, Feb 02, 2024 at 04:28:24PM -0800, William Zhang wrote: =20
> >>> Add brcm,nand-ecc-use-strap to get ecc and spare area size settings f=
rom
> >>> board boot strap for broadband board designs because they do not spec=
ify
> >>> ecc setting in dts but rather using the strap setting.
> >>>
> >>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> >>>
> >>> ---
> >>>
> >>> Changes in v4:
> >>> - Move ecc strap property to this separate patch and remove some
> >>> non-binding related text from the description
> >>>
> >>> Changes in v3: None
> >>> Changes in v2: None
> >>>
> >>>   Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 8 ++++++=
++
> >>>   1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml=
 b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> >>> index d0168d55c73e..2599d902ec3a 100644
> >>> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> >>> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> >>> @@ -147,6 +147,14 @@ patternProperties:
> >>>             layout.
> >>>           $ref: /schemas/types.yaml#/definitions/uint32 =20
> >>>   >>> +      brcm,nand-ecc-use-strap: =20
> >>> +        description:
> >>> +          This flag indicates the ecc strength and spare area size s=
hould
> >>> +          be retrieved from the SoC NAND boot strap setting instead =
of
> >>> +          nand-ecc-strength and brcm,nand-oob-sector-size or auto de=
tection. =20
> >>
> >> I'm still on the fence about this being overly prescriptive about the
> >> operating systems behaviour. I think it would be good to say why the
> >> strap values are better than those explicitly provided in DT rather th=
an
> >> just saying "these strap values should be used". =20
> >=20
> > I don't know if there is a point is saying why they would be better, as
> > they are not. It is a -questionable- design choice. However I would
> > just get rid of any mention to other properties. Just say one should
> > expect the strap value to be read and applied by the system when this
> > property is present.
> >  =20
> Agree we don't need to say which is better as it is just a design choice.=
 And it is used by all BCMBCA internal ref boards and customer designs. But=
 if we just say strap value is read and applied, it is vague and nobody wou=
ld know what is applied.  I replied this email yesterday and suggest the fo=
llowings:
>=20
> This property provides a choice for retrieving ecc strength and spare are=
a size from
 the SoC NAND boot strap setting. It is commonly used by the BCMBCA SoC boa=
rd design.

What about:

This property requires the host system to get the ECC strength and step
size from the SoC NAND boot strap setting. This is a common hardware
design on BCMBCA based boards.

I would also like to constrain this more by adding an exclusive use wrt
the nand-ecc-* properties. So either you put this property, or you put
the generic nand-ecc-* properties, or you put nothing (which, again, is
by far the best solution), but in no case you can have a mix.

>=20
> Hope this make everyone happy and we can move forward.

I was advising to avoid mentioning too specific DT properties, but
mentioning the kind of impact it has (on the choice for the ECC
strength and size) is fine.

>=20
>=20
> >>> +          This is commonly used by the BCMBCA SoC board design.
> >>> +        $ref: /schemas/types.yaml#/definitions/flag
> >>> +
> >>>       unevaluatedProperties: false =20
> >>>   >>>   allOf:
> >>> -- >>> 2.37.3 =20
> >>>    > >  =20
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l

