Return-Path: <linux-kernel+bounces-80916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA70866E09
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7C5284A53
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF6C4F883;
	Mon, 26 Feb 2024 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hZq+vByS"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A134F1EB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936605; cv=none; b=Ceeor+lxT/jpejVsZumKeejUX1BEF6oNwxqs3gZKyOmQgjMjDhRUrMYsCF3spoYN6RhfnT8yX7gTYikf6Aj/tyqS0tEmNdgsFH7Dv1nwgvcBlgfnQTUF9RaauPHF+szkXMRGyg+054EFtwpaI5tCM5TN88/B+NRwhMV4M5rWrSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936605; c=relaxed/simple;
	bh=USQSwjGxXRHG+T/iy/o6M4+VJrO08230zXWfO5g1b2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5045dHWPhGK8hRCfHXq3vGeuJZdXeGBSEmLAmHVw8wIe9uj3HKO4sFcNpSAK1eUYReqk8NFIPtiaE7X4h8vxlmehBEzjnwoYpMteym0rouxkG48IQD1uEUd5ABWNeYQpzuBN2w77W/oB/SYts9IBLp+e6PL+K0pxmfT9+zlK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hZq+vByS; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4ACA3240012;
	Mon, 26 Feb 2024 08:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708936595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ed35DgZT8up8dS5tg0t3dwfRBrSktHLqjatLU9kFk9U=;
	b=hZq+vBySzyQVPfyS1qj/uShP2HwWpY1NMrZJZ07lNgp/pxnSPTsIsvCH8uQKP9+eSyATeu
	KxlK5CuI0WpBmtI2yr3B4D5qQS2wbLMAFTP184ftX+5aaGGR77Ky7YM/ARs3Mkj0hyySwy
	z+RGAJHBK7apr0dA/poIhqhjW4ZJky3gbBrUQXaFMdPZsgWtTgFOvFMb1p16r0Z4GjRh0O
	m4nkPcQcholIjgr8RvDwtIwtCXVpC78E2y7swG8nfaN6ir52i3qS9VdQq6QjEbFtutXujq
	nJb7ZsAM3WcNkLs7vqnWidxbkciim+D6V9euXV4pa38PO1kmvK+ZFdiaTNoT4g==
Date: Mon, 26 Feb 2024 09:36:32 +0100
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
Message-ID: <20240226093632.089d594c@xps-13>
In-Reply-To: <db1c1e68-40e2-4c6c-afb2-2fb591883a46@broadcom.com>
References: <20240223034758.13753-1-william.zhang@broadcom.com>
	<20240223034758.13753-13-william.zhang@broadcom.com>
	<20240223101852.005da3ad@xps-13>
	<db1c1e68-40e2-4c6c-afb2-2fb591883a46@broadcom.com>
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

william.zhang@broadcom.com wrote on Fri, 23 Feb 2024 09:25:09 -0800:

> Hi Miquel,
>=20
> On 2/23/24 01:18, Miquel Raynal wrote:
> > Hi William,
> >=20
> > william.zhang@broadcom.com wrote on Thu, 22 Feb 2024 19:47:57 -0800:
> >  =20
> >> BCMBCA broadband SoC based board design does not specify ecc setting in
> >> dts but rather use the SoC NAND strap info to obtain the ecc strength
> >> and spare area size setting. Add brcm,nand-ecc-use-strap dts propety f=
or
> >> this purpose and update driver to support this option. However these t=
wo
> >> options can not be used at the same time.
> >>
> >> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> >> Reviewed-by: David Regan <dregan@broadcom.com>
> >> =20
> >=20
> > FYI I did not receive patches 7, 8, 9, which makes the series numbering
> > very odd.
> >  =20
> I was using the get maintainer script mainly and it sends to the linux MT=
D list.  I will add your email directly next time.

Yes, I prefer to be in Cc of the whole series, please.

> >> ---
> >>
> >> Changes in v6:
> >> - Combine the ecc step size and ecc strength into one get function
> >> - Treat it as error condition if both brcm,nand-ecc-use-strap and nand
> >> ecc dts properties are set
> >> - Add intermediate steps to get the sector size bitfield
> >>
> >> Changes in v5: None
> >> Changes in v4:
> >> - Update the comments for ecc setting selection
> >>
> >> Changes in v3: None
> >> Changes in v2:
> >> - Minor cosmetic fixes
> >>
> >>   drivers/mtd/nand/raw/brcmnand/brcmnand.c | 83 ++++++++++++++++++++++=
--
> >>   1 file changed, 77 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/na=
nd/raw/brcmnand/brcmnand.c
> >> index ef7d340475be..e8ffc283b365 100644
> >> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> >> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> >> @@ -1038,6 +1038,22 @@ static inline int brcmnand_sector_1k_shift(stru=
ct brcmnand_controller *ctrl)
> >>   		return -1;
> >>   } =20
> >>   >> +static int brcmnand_get_sector_size_1k(struct brcmnand_host *hos=
t) =20
> >> +{
> >> +	struct brcmnand_controller *ctrl =3D host->ctrl;
> >> +	int sector_size_bit =3D brcmnand_sector_1k_shift(ctrl);
> >> +	u16 acc_control_offs =3D brcmnand_cs_offset(ctrl, host->cs,
> >> +						  BRCMNAND_CS_ACC_CONTROL);
> >> +	u32 acc_control;
> >> +
> >> +	if (sector_size_bit < 0)
> >> +		return 0;
> >> +
> >> +	acc_control =3D nand_readreg(ctrl, acc_control_offs);
> >> +
> >> +	return (acc_control & BIT(sector_size_bit)) >> sector_size_bit; =20
> >=20
> > FIELD_PREP, FIELD_GET, *please*. =20
> You probably missed my reply to your comments on the same patch in v5. He=
re is the link for the post in case it lost in your email:
> https://lore.kernel.org/lkml/c145b90c-e9f0-4d82-94cc-baf7bfda5954@gmail.c=
om/T/#m1d911d2f119f3bd345c575a81b60bc2bd8c461eb

I didn't miss it, but the reason does not sound legitimate to me.
Please work on it, it will be so much cleaner.

> The mask is not constant here and cause build errors.
> >  =20
> >> +}
> >> +
> >>   static void brcmnand_set_sector_size_1k(struct brcmnand_host *host, =
int val)
> >>   {
> >>   	struct brcmnand_controller *ctrl =3D host->ctrl;
> >> @@ -1055,6 +1071,43 @@ static void brcmnand_set_sector_size_1k(struct =
brcmnand_host *host, int val)
> >>   	nand_writereg(ctrl, acc_control_offs, tmp);
> >>   } =20
> >>   >> +static int brcmnand_get_spare_size(struct brcmnand_host *host) =
=20
> >> +{
> >> +	struct brcmnand_controller *ctrl =3D host->ctrl;
> >> +	u16 acc_control_offs =3D brcmnand_cs_offset(ctrl, host->cs,
> >> +						  BRCMNAND_CS_ACC_CONTROL);
> >> +	u32 acc =3D nand_readreg(ctrl, acc_control_offs);
> >> +
> >> +	return (acc & brcmnand_spare_area_mask(ctrl));
> >> +}
> >> +
> >> +static void brcmnand_get_ecc_settings(struct brcmnand_host *host, str=
uct nand_chip *chip)
> >> +{
> >> +	struct brcmnand_controller *ctrl =3D host->ctrl;
> >> +	u16 acc_control_offs =3D brcmnand_cs_offset(ctrl, host->cs,
> >> +						  BRCMNAND_CS_ACC_CONTROL);
> >> +	int sector_size_1k =3D brcmnand_get_sector_size_1k(host);
> >> +	int spare_area_size, ecc_level;
> >> +	u32 acc;
> >> +
> >> +	spare_area_size =3D brcmnand_get_spare_size(host);
> >> +	acc =3D nand_readreg(ctrl, acc_control_offs);
> >> +	ecc_level =3D (acc & brcmnand_ecc_level_mask(ctrl)) >> ctrl->ecc_lev=
el_shift; =20
> >=20
> > ditto
> >  =20
> >> +	if (sector_size_1k)
> >> +		chip->ecc.strength =3D ecc_level * 2;
> >> +	else if (spare_area_size =3D=3D 16 && ecc_level =3D=3D 15)
> >> +		chip->ecc.strength =3D 1; /* hamming */
> >> +	else
> >> +		chip->ecc.strength =3D ecc_level;
> >> +
> >> +	if (chip->ecc.size =3D=3D 0) {
> >> +		if (sector_size_1k < 0) =20
> >=20
> > Should be <=3D 0 I guess
> >  =20
> >> +			chip->ecc.size =3D 512;
> >> +		else
> >> +			chip->ecc.size =3D 512 << sector_size_1k; =20
> >=20
> > What is this? Are you expecting sector_size_1k to be 0 or 1
> > and thus multiply 512 by two?
> >  =20
> Explained in the same post above. Sector_size_1k can be negative number f=
or error condition where we default to 512 step size. Otherwise 0 for 512 a=
nd 1 for 1K which the above shift takes care of.

The logic is unclear, unnatural. Please simplify. You have the
possibility to change all the driver, so please simplify and clarify
the logic.

> > Please just use:
> > 			chip->ecc.size =3D SZ_1K;
> > 			 =20

Thanks,
Miqu=C3=A8l

