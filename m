Return-Path: <linux-kernel+bounces-86554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D0986C6F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC9428450E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034E66BB4F;
	Thu, 29 Feb 2024 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QU0VLTe5"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3926A8D7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202685; cv=none; b=WKSKlto+ZpUbYmhNzVKw+Kl/pWnWiiuBJOmK8TUzJ3aGZjGaTl1TIR0kYDnJSKZ8cwf7AoqGhupbSIX9qokBZW2jbHQR1arLB6YuTxG+vI83N+pKx+UQ/74/+1Xeo3pt2AFsbXf8Fk2ZP3BAG1mTIz7DQ9Kt1cu7amCE3rTYcZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202685; c=relaxed/simple;
	bh=X9genLYk5vEwjtUt1AvHjc3bwNpSYBG4qQ/naf2npqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FV8P8xXm37FDEwweCuBaC2z16N6j75tTGQccI2MZH8iBU4Axgt/N7rCEXi5CV0tXrfZcY1TFb2t9hzhd1JZaBOPb+4td4hBP5zWvOylFqtUA60CaAP9duZBcRotuLl3AHcS+/e4HajtpCGnwbUpsDT+tpf2z1Wd2icrn8rtx/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QU0VLTe5; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12CF7E0008;
	Thu, 29 Feb 2024 10:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709202681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xB/mH2t7HucMvUeJIJZB7RytH2L7kmSd4lRMo452s7Q=;
	b=QU0VLTe5qBP5PiMq57AosE7CFqBFOBXnPt5TwOODUBfDS3l8/e/Tj4B7hh+x34uzlZmPPw
	pKfLh3ILuGLD4Lfvgm84/9sbL/BkupVZes47Yz598J+Pug6lLYjHqbN3Vy0vJeWZ9h2WmB
	1WLaySXulLngWCHOW64VKR8LS2bLJn91gPYZhsuPF4NIiPjYORzX18ZyDzuIVE1SFZfbIv
	wTD8UtHmvCK8K4T8UusSmytLGagbr5oezKNJHjbYaICQlSIeQIB2fjcoKjYj9KveHPYxVl
	slKXGYK+StUOcpqaoN9pENEGE6UFLjHJILKrmEcwrylplnI8G8ozEEfK30DXWw==
Date: Thu, 29 Feb 2024 11:31:19 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: William Zhang <william.zhang@broadcom.com>
Cc: Linux MTD List <linux-mtd@lists.infradead.org>, Linux ARM List
 <linux-arm-kernel@lists.infradead.org>, Broadcom Kernel List
 <bcm-kernel-feedback-list@broadcom.com>, f.fainelli@gmail.com,
 kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com, David Regan
 <dregan@broadcom.com>, linux-kernel@vger.kernel.org, Vignesh Raghavendra
 <vigneshr@ti.com>, Brian Norris <computersforpeace@gmail.com>, Richard
 Weinberger <richard@nod.at>
Subject: Re: [PATCH v6 12/13] mtd: rawnand: brcmnand: Add support for
 getting ecc setting from strap
Message-ID: <20240229113119.30f7cee6@xps-13>
In-Reply-To: <be75db7d-a698-43ab-b29e-dea3a0f60ba2@broadcom.com>
References: <20240223034758.13753-1-william.zhang@broadcom.com>
	<20240223034758.13753-13-william.zhang@broadcom.com>
	<20240223101852.005da3ad@xps-13>
	<db1c1e68-40e2-4c6c-afb2-2fb591883a46@broadcom.com>
	<20240226093632.089d594c@xps-13>
	<be75db7d-a698-43ab-b29e-dea3a0f60ba2@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

william.zhang@broadcom.com wrote on Mon, 26 Feb 2024 12:05:18 -0800:

> On 2/26/24 00:36, Miquel Raynal wrote:
> > Hi William,
> >=20
> > william.zhang@broadcom.com wrote on Fri, 23 Feb 2024 09:25:09 -0800:
> >  =20
> >> Hi Miquel,
> >>
> >> On 2/23/24 01:18, Miquel Raynal wrote: =20
> >>> Hi William,
> >>>
> >>> william.zhang@broadcom.com wrote on Thu, 22 Feb 2024 19:47:57 -0800: =
=20
> >>>    >>>> BCMBCA broadband SoC based board design does not specify ecc =
setting in =20
> >>>> dts but rather use the SoC NAND strap info to obtain the ecc strength
> >>>> and spare area size setting. Add brcm,nand-ecc-use-strap dts propety=
 for
> >>>> this purpose and update driver to support this option. However these=
 two
> >>>> options can not be used at the same time.
> >>>>
> >>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> >>>> Reviewed-by: David Regan <dregan@broadcom.com> =20
> >>>>   >>> =20
> >>> FYI I did not receive patches 7, 8, 9, which makes the series numberi=
ng
> >>> very odd. =20
> >>>    >> I was using the get maintainer script mainly and it sends to th=
e linux MTD list.  I will add your email directly next time. =20
> >=20
> > Yes, I prefer to be in Cc of the whole series, please.
> >  =20
> Sure.  And thanks for applying other patches.  Do you want me to just sen=
d a new single patch for the update?

Yes just the missing patch.

> >>>>    >> +static int brcmnand_get_sector_size_1k(struct brcmnand_host *=
host) =20
> >>>> +{
> >>>> +	struct brcmnand_controller *ctrl =3D host->ctrl;
> >>>> +	int sector_size_bit =3D brcmnand_sector_1k_shift(ctrl);
> >>>> +	u16 acc_control_offs =3D brcmnand_cs_offset(ctrl, host->cs,
> >>>> +						  BRCMNAND_CS_ACC_CONTROL);
> >>>> +	u32 acc_control;
> >>>> +
> >>>> +	if (sector_size_bit < 0)
> >>>> +		return 0;
> >>>> +
> >>>> +	acc_control =3D nand_readreg(ctrl, acc_control_offs);
> >>>> +
> >>>> +	return (acc_control & BIT(sector_size_bit)) >> sector_size_bit; =20
> >>>
> >>> FIELD_PREP, FIELD_GET, *please*. =20
> >> You probably missed my reply to your comments on the same patch in v5.=
 Here is the link for the post in case it lost in your email:
> >> https://lore.kernel.org/lkml/c145b90c-e9f0-4d82-94cc-baf7bfda5954@gmai=
l.com/T/#m1d911d2f119f3bd345c575a81b60bc2bd8c461eb =20
> >=20
> > I didn't miss it, but the reason does not sound legitimate to me.
> > Please work on it, it will be so much cleaner.
> >  =20
> I understand FIELD_PREP/GET is the preferred way of linux accessing the r=
egister fields but it requires a constant MASK value and does not apply to =
our case as we have different versions of the register and have different m=
ask.  There is way to workaround it. i.e defining the multiple constants di=
rectly and using these macros with if/else based on reg version. But it is =
not clean and since we already have helper functions that handle and return=
 different shift/mask value, I see this is a perfect way for our situation =
and can adapt to future reg version change easily and cleanly.
>=20
> >> The mask is not constant here and cause build errors. =20

Which errors?

+       acc_control =3D nand_readreg(ctrl, acc_control_offs);
+       return FIELD_GET(BIT(sector_size_bit), acc_control);

Does not return any error here.

Thanks,
Miqu=C3=A8l

