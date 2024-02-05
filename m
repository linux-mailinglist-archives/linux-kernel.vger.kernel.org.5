Return-Path: <linux-kernel+bounces-52712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0243A849BB7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C441C223B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6551CD0C;
	Mon,  5 Feb 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RvR2Io/m"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FA51CD05;
	Mon,  5 Feb 2024 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139607; cv=none; b=gSKQQzUmXktLQSwsu9IJAso0W/BWqUetxQCKjSCLII2C1lIcMr0+ZgP0hf6XEHbHAev2YsGEGw/f/zqKV3Oj7vGgmQk5eDW++y7nTAmcnBEuDbNLDM+FZYZakfS4lpNAMBw0Bb8teBLh6QznnVHbSwCCpf6NLd+O2Da1Ey7ATlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139607; c=relaxed/simple;
	bh=oWPwmRLnCaYF8YZEOMfP6FByoUIRBfdx2gAukBKsmAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAm/nZhuye2UL8G7PhCKM3aKDWsOjPniB0LYfmiWzaiA4gZfd/8vxZayh1mBKZMzVOszwN/tOqfkrsTrsra27pHin6/gjCqJ6CoSSH7IBEE8YTwOJZoAoHiIrCaoioMDqWwftG12xx7iipsUIdd9G+t2va73BPCRWfa3dDhrUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RvR2Io/m; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8ED9BFF811;
	Mon,  5 Feb 2024 13:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707139601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mJeoLvrMZja6m+m7EbjiMgme3HRnrMEAgds1gESvyI=;
	b=RvR2Io/mFkUOlAI951aA+ed3sDSo1QIzzLxgeg0nB/mmNg96VV9t7LmbyH4flPNVGPrQrl
	3yAOAfohYN73qbkQVkSIlvkX5rv7EHi/Ncn49HOyoHRmJlaI/ozEK/XXngzEMDgTal7tzv
	xKNua8XrpGFgv2/cPgjguRAUmp+tAEcSZTaBd9b5dWh5cHdLOEdm+wm1KtXMEKcJvhSKX9
	TYkAf+D2gHR6opO2wQRE3jSSSktakW48XTIG8d/w5oKiT/nhbjWuA9o0tG59OtVcvnM1Su
	nyP8KpAYL2bKeNsfrlpZxOwricqsAtPWAtO/ujLgEb8B6SIdICgYrebKM+3TCg==
Date: Mon, 5 Feb 2024 14:26:39 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: William Zhang <william.zhang@broadcom.com>, Linux MTD List
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
Message-ID: <20240205142639.5d7c70f0@xps-13>
In-Reply-To: <20240203-expenses-tarmac-c564bc7ae34f@spud>
References: <20240203002834.171462-1-william.zhang@broadcom.com>
	<20240203002834.171462-4-william.zhang@broadcom.com>
	<20240203-expenses-tarmac-c564bc7ae34f@spud>
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

Hi,

conor@kernel.org wrote on Sat, 3 Feb 2024 14:49:50 +0000:

> On Fri, Feb 02, 2024 at 04:28:24PM -0800, William Zhang wrote:
> > Add brcm,nand-ecc-use-strap to get ecc and spare area size settings from
> > board boot strap for broadband board designs because they do not specify
> > ecc setting in dts but rather using the strap setting.
> >=20
> > Signed-off-by: William Zhang <william.zhang@broadcom.com>
> >=20
> > ---
> >=20
> > Changes in v4:
> > - Move ecc strap property to this separate patch and remove some
> > non-binding related text from the description
> >=20
> > Changes in v3: None
> > Changes in v2: None
> >=20
> >  Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b=
/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> > index d0168d55c73e..2599d902ec3a 100644
> > --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> > @@ -147,6 +147,14 @@ patternProperties:
> >            layout.
> >          $ref: /schemas/types.yaml#/definitions/uint32
> > =20
> > +      brcm,nand-ecc-use-strap:
> > +        description:
> > +          This flag indicates the ecc strength and spare area size sho=
uld
> > +          be retrieved from the SoC NAND boot strap setting instead of
> > +          nand-ecc-strength and brcm,nand-oob-sector-size or auto dete=
ction. =20
>=20
> I'm still on the fence about this being overly prescriptive about the
> operating systems behaviour. I think it would be good to say why the
> strap values are better than those explicitly provided in DT rather than
> just saying "these strap values should be used".

I don't know if there is a point is saying why they would be better, as
they are not. It is a -questionable- design choice. However I would
just get rid of any mention to other properties. Just say one should
expect the strap value to be read and applied by the system when this
property is present.

> > +          This is commonly used by the BCMBCA SoC board design.
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +
> >      unevaluatedProperties: false
> > =20
> >  allOf:
> > --=20
> > 2.37.3
> >  =20


Thanks,
Miqu=C3=A8l

