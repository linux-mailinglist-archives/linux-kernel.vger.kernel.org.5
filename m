Return-Path: <linux-kernel+bounces-38747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCD283C541
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62DA7B258B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE036EB54;
	Thu, 25 Jan 2024 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U5Hu1h05"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4361B6E2C9;
	Thu, 25 Jan 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194209; cv=none; b=MuC8fZn+9BSKARWZSFeJOLYN3hTD6+It8CzOWOBEThoiPe4Cl7dKSrCrqRAFH9GOgyIszeMtyIP+xFBHVPKYKlSqDfkWKmwlEw8/l5U7KM6HXUkN1HMKH1+b0Ue13J0IBGaAMbgl4sOqWoasy0mIGW2OKZvUFHBHT33jMxfzo88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194209; c=relaxed/simple;
	bh=ACVtmX3llcZ3tfvcSAXupWV1km9UBIPngejcwrfKSZw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=F38cE/aH6we6VGVzyxxuIgTb01MDsSBM+kp1Nvsw5LudtNDwBRsopV4WBWv+Fu5RgRoF6z5CyXgGIrHRlqIvotOXgt/44sdkFs+jLrQQOfBnu5tIQCY/NvvXAm35b8s6O8M2ctXlGwDEyRWwuKckUw2gICCXQlQelEGXhIsmMxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U5Hu1h05; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2AD8FC0012;
	Thu, 25 Jan 2024 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706194197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogOpwZQkYRG5dXU2wj0R+7adxXD9kVYWvL6LdD2YosI=;
	b=U5Hu1h05YgVVy1e9XMnsulE1q6eJD310wXJhpRMNMwlLSol4EJtmHk20pcaA/6GXAy+cns
	Ih+ju0KTLmRTBmbN/+GLZTEOThbUoBnz8FPEou7lEZWxSQ2WOBWO0ZN9hW6o9HwvxQ/S+H
	lQ2hmT7xQRD+EyLadkeDKfs7XTlxpyRNFu+wdoez24nABWRm2QJxwjXncD64DBssybAfog
	pDfudljBPu+vedfEYfsVkf1lvLfDWOIx+IVdPh6CunfyLZ57xp7wkOrvufRaEMCCg1FGjt
	x/+tCF7sWN3l7+y6c0kQBANgFaVwAEPGat1sWGjelxiC5snpNzZ/+EhbM4IS3g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jan 2024 15:49:55 +0100
Message-Id: <CYNVD4U0M5OS.LQ2MAKOL0LAP@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v3 04/17] dt-bindings: soc: mobileye: add EyeQ5 OLB
 system controller
Cc: "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, <linux-mips@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
To: "Andrew Davis" <afd@ti.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, "Rob Herring" <robh@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-4-392b010b8281@bootlin.com>
 <20240124151405.GA930997-robh@kernel.org>
 <dd7e723d-3c4c-4edf-afc2-51db9a074efa@linaro.org>
 <CYNQHXOZ73YR.3QODFI2X08KC6@bootlin.com>
 <9a5f017c-530c-482b-9cbf-a07281e92589@ti.com>
In-Reply-To: <9a5f017c-530c-482b-9cbf-a07281e92589@ti.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Jan 25, 2024 at 3:33 PM CET, Andrew Davis wrote:
> On 1/25/24 5:01 AM, Th=C3=A9o Lebrun wrote:
> > Hello,
> >=20
> > On Thu Jan 25, 2024 at 8:51 AM CET, Krzysztof Kozlowski wrote:
> >> On 24/01/2024 16:14, Rob Herring wrote:
> >>>> +
> >>>> +      pinctrl-b {
> >>>> +        compatible =3D "mobileye,eyeq5-b-pinctrl";
> >>>> +        #pinctrl-cells =3D <1>;
> >>>> +      };
> >>>> +    };
> >>>
> >>> This can all be simplified to:
> >>>
> >>> system-controller@e00000 {
> >>>      compatible =3D "mobileye,eyeq5-olb", "syscon";
> >>>      reg =3D <0xe00000 0x400>;
> >>>      #reset-cells =3D <2>;
> >>>      #clock-cells =3D <1>;
> >>>      clocks =3D <&xtal>;
> >>>      clock-names =3D "ref";
> >>>
> >>>      pins { ... };
> >>> };
> >>>
> >>> There is no need for sub nodes unless you have reusable blocks or eac=
h
> >>> block has its own resources in DT.
> >>
> >> Yes, however I believe there should be resources here: each subnode
> >> should get its address space. This is a bit tied to implementation,
> >> which currently assumes "everyone can fiddle with everything" in this =
block.
> >>
> >> Theo, can you draw memory map?
> >=20
> > It would be a mess. I've counted things up. The first 147 registers are
> > used in this 0x400 block. There are 31 individual blocks, with 7
> > registers unused (holes to align next block).
> >=20
> > Functions are reset, clocks, LBIST, MBIST, DDR control, GPIO,
> > accelerator control, CPU entrypoint, PDTrace, IRQs, chip info & ID
> > stuff, control registers for PCIe / eMMC / Eth / SGMII / DMA / etc.
> >=20
> > Some will never get used from Linux, others might. Maybe a moderate
> > approach would be to create ressources for major blocks and make it
> > evolve organically, without imposing that all uses lead to a new
> > ressource creation.
> >=20
>
> That is usually how nodes are added to DT. If you modeled this
> system-controller space as a "simple-bus" instead of a "syscon"
> device, you could add nodes as you implement them. Rather than
> all at once as you have to by treating this space as one large
> blob device.

I see where you are coming from, but in our case modeling our DT node as
a simple-bus would be lying about the hardware behind. There is no such
underlying bus. Let's try to keep the devicetree an abstraction
describing the hardware.

Also, we are having conflicts because multiple such child nodes are
being added at the same time as the base node. Once this initial series
is out (meaning dt-bindings for the OLB will exist) we'll be able to
add new nodes or ressources on a whim.

Have you got an opinion on the approach described in this email?
https://lore.kernel.org/lkml/CYNRCGYA1PJ2.FYENLB4SRJWH@bootlin.com/

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

