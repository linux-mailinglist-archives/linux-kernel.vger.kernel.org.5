Return-Path: <linux-kernel+bounces-38250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2C283BD17
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACFE290E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0CA1BC50;
	Thu, 25 Jan 2024 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VQ86jc4j"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193FB1BC35;
	Thu, 25 Jan 2024 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174467; cv=none; b=hTNO4ol+myBHH2CF0aqL2ibEE9uEHNWYoUA9h7uU9hQQgDDwJmqaw8/D1oygl0Qf0vxzB+H6KjnTBtIex1ofhwSj/bLqLlbAs+jV+GYMdkm6tn8nMCctqiDsWvcClN/kQjViIC5zE1Ef/PM06b9Xjb2IezJv5Q5Kj+Xv3mJDIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174467; c=relaxed/simple;
	bh=vqNkEAabo6aICt8fsmv4NUb7Td0W6lltgyPnkptXJFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBQ8Z7/xkCr3S+Ve14GoSqd4FmcKFeNLdM7EA9RvEuKJ3Ri6R6lPB/lb0GZDyD1a40hlt47elr7TzHNdsk/l3u3gz5FMB9RCpq4ZjyOJmj5MJpTXPTPHyHe5tAQKDbEXvipRSorRcAIQ1MAHpcqRZTMZyzQrXjOl7KlHb9aVe7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VQ86jc4j; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA3881BF219;
	Thu, 25 Jan 2024 09:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706174461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eKjAu14meoD0UWLGa1Hctnp45OsMD9+KH2IhUcbWrL4=;
	b=VQ86jc4jMi7kZpSX93HTuIEk4dHcoUQO2jYVvHJKrFbWKkXwZunjal+i7HO2/oynf2bGKQ
	CYDTSSZAWfKlxhC0kyB9aI8HFAj//uey3jcaKSEEz/1HaS2w6h2ETfSokmazYkVCoJN4pd
	9QXJE49MHmPyiPllw9VhmA2BRY5LEvfRdNWiuXqt33gGxfFbwv7BZcjNxLofLpQbSeSc+6
	tD9beY3Sn/veWmIUV2Ys8WpFFrOjXXy1++Q9ki3bL0dINJ1K0ewx2Ag+0RXhMRaZ875MXs
	+YHWh7+uEfOy3+IwWuICh8XKLw/5yed/TAzlzTOX+PxM1i1sqZwE8qGfLKzE+g==
Date: Thu, 25 Jan 2024 10:20:58 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: William Zhang <william.zhang@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, David Regan
 <dregan@broadcom.com>, dregan@mail.com, richard@nod.at, vigneshr@ti.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 computersforpeace@gmail.com, kdasu.kdev@gmail.com,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, joel.peshkin@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 anand.gore@broadcom.com, kursad.oney@broadcom.com, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andre.przywara@arm.com,
 baruch@tkos.co.il, linux-arm-kernel@lists.infradead.org,
 dan.carpenter@linaro.org
Subject: Re: [PATCH v3 02/10] ARM: dts: broadcom: bcmbca: Add NAND
 controller node
Message-ID: <20240125102058.5ae46d8a@xps-13>
In-Reply-To: <722d6bdf-9a43-436d-a9e2-4c21e1deb8c3@broadcom.com>
References: <20240124030458.98408-1-dregan@broadcom.com>
	<20240124030458.98408-3-dregan@broadcom.com>
	<20240124183008.04a1bcb0@xps-13>
	<2c10a764-f74f-45b2-8bba-77c40468f4b5@broadcom.com>
	<85c97d00-a973-46c6-974c-3dfa587ae873@broadcom.com>
	<722d6bdf-9a43-436d-a9e2-4c21e1deb8c3@broadcom.com>
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

> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nand_controller: nand-co=
ntroller@1800 {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
#address-cells =3D <1>;
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
#size-cells =3D <0>;
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
compatible =3D "brcm,nand-bcm63138", >>>> "brcm,brcmnand-v7.1", "brcm,brcmn=
and";
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
reg =3D <0x1800 0x600>, <0x2000 0x10>;
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
reg-names =3D "nand", "nand-int-base";
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
brcm,nand-use-wp =3D <0>;
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
status =3D "disabled";
> >>>> +
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
nandcs: nand@0 {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "brcm,nandcs";
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 nand-on-flash-bbt;
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 brcm,nand-ecc-use-strap; =20
> >>>
> >>> Describing the NAND chip in a SoC DTSI does not look relevant to me.
> >>> Even more if you add something like this nand-ecc-use-strap setting
> >>> which is very board dependent.
> >>> =20
> >> I am not sure if I understand you comments correctly but are you >> su=
ggesting to put this whole nand controller node into each board dts? >> We =
have other ip block nodes like SPI, uart in this same soc dtsi file >> too.=
=C2=A0 For all the bcmbca soc dtsi I am updating here(and its board >> desi=
gn), we always use the strap to for ecc setting.=C2=A0 So I thought it >> s=
hould be okay to put brcm,nand-ecc-use-strap in the default dtsi >> file. F=
or any board that uses the raw nand nand-ecc property, the >> board dts can=
 do so and override the brcm,nand-ecc-use-strap setting. =20
> >=20
> > I read Miquel's comment as meaning that the nandcs aka the NAND > chip/=
flash part description should be in the board .dts file, while the > contro=
ller itself can remain in the .dtsi file with its status =3D > "disabled" p=
roperty.
> >=20
> > Are there customer boards, that is non reference boards that might chos=
e > a different chip select number and/or not use the strap settings? =20
> In BCMBCA SoC, there is only one cs and customer design also have to use =
strap for the bootrom to boot up properly.  They can override it with dts i=
n linux but I don't think any customer would do that.
>=20
> Maybe the nand-on-flash-bbt could be possible item that customer may have=
 to set it differently if they don't follow our reference software design.
>=20
> I will move the nand-on-flash-bbt to the board dts but I would like to ke=
ep the other default nandcs settings in SoC.dsti if that is not too out of =
the conventional rule and Miquel is okay with it.

I think there is a global misunderstanding regarding the use of the
nand-ecc-* properties. These are not the default. The default is the OS
choice and depends on the NAND capabilities. The OS will always try to
match the closest ECC settings offered by the engine, based on the NAND
chip requirements which are discoverable. If you want to maximize your
strength, it is also possible to tell the OS with a dedicated (generic)
property. And only if you want something different, you may use these
properties, but they should be the exception rather than the rule.

Overriding this with a strap is a bad hardware design on commercial
products IMO. I am totally fine with the idea of a strap to choose
the ECC configuration for development boards/evaluation kits, but once
you've decided which setting you want you cannot change it for the
lifetime of your project (or with a lot of difficulties) so I don't see
the point of such a strap. So really, I don't like the idea of defining
by default a variable which asks for an override of the defaults, even
though many of your customers might want to use that.

So, anything that is design dependent (the chip CS, ECC
configuration, etc) should go into the board DTS, and what is SoC
related hardware (like the definition of the NAND controller) should
stay in the DTSI, as properly clarified by Florian.

Thanks,
Miqu=C3=A8l

