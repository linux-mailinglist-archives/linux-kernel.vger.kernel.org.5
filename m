Return-Path: <linux-kernel+bounces-72751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A3085B851
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4062B227F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A662657AE;
	Tue, 20 Feb 2024 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I6T8Fm/7"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB05651BC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422807; cv=none; b=IOv9tK6a36a1icdx0VJQXGw0gOskoPXmcVAjK+pG9bw+RzX4RfYWll7ZaIFUZASLOhiFKm+UQJC6ASHs2/rxnFYgPlj9gOxQNUldQD7zbwajNdWpgvQnrRM/m6U9LFC4oNbwTHQ85FHHi/mQrd08JexiHitXwaanKwjnwIddOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422807; c=relaxed/simple;
	bh=tf6J8yreFA2kU6lgOdYaEkPuNfkRJDwXDVrcwZxoDcs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+1TFx58dE0GBOxQua99+DHk8UvB08yckBld/LYPayIer2zFe1jhA9D+wuNKrVaz96ED4ZBqtkMbK8LxTr9IzSifXWOkUTy2Qq/dQcbHSjdvHqB9gxEKuz313865Vv9Q8TJhnnH4mA64pxXIG4TFnlYxOAX6oBcwYyOnMS1KOjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I6T8Fm/7; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B9F81C0009;
	Tue, 20 Feb 2024 09:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708422796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSdHFa3arkRH7EqPLCC3LYRFNsMZzoRHpNScPv/MSXA=;
	b=I6T8Fm/7/rqeok3R1j6SrMr8pTjanZgbB/g44wr2tAmV2NGxNJy0K7MbQna0gZUWFZCyLJ
	qU60Z4qMmwfe4G4AUPinZEterEvt3q8JLLScpTDgrvIOeSJrxn5nOn85rrgQ81ypYuu6EE
	rGTLHuT3PSWdX8ljKkwn6ltgrgol/mlbr5XexZguT4C9AcjGtImOYL/TsNbnOjYtNBGfiz
	FEJbY8o7asRMSQ8OWW3xUrWeK97K6LRY4a6r1f7gAeX0WBFn0VEEdFAnJULNtcjwKzs5u9
	j0whHTBfGhABgX+P4bTnfCWKT6QwUAozhEG+B0nw1UbK08Mk7sCfSKBI92MV6A==
Date: Tue, 20 Feb 2024 10:53:13 +0100
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
Subject: Re: [PATCH v5 09/12] mtd: rawnand: brcmnand: Add support for
 getting ecc setting from strap
Message-ID: <20240220105313.5e3c600d@xps-13>
In-Reply-To: <20240207202257.271784-10-william.zhang@broadcom.com>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
	<20240207202257.271784-10-william.zhang@broadcom.com>
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

william.zhang@broadcom.com wrote on Wed,  7 Feb 2024 12:22:54 -0800:

> BCMBCA broadband SoC based board design does not specify ecc setting in
> dts but rather use the SoC NAND strap info to obtain the ecc strength
> and spare area size setting. Add brcm,nand-ecc-use-strap dts propety for
> this purpose and update driver to support this option.
>=20
> The generic nand ecc settings still take precedence over this flag. For
> example, if nand-ecc-strength is set in the dts, the driver ignores the
> strap setting and falls back to original behavior. This makes sure that
> the existing BCMBCA board dts still works the old way even the strap
> flag is set in the BCMBCA chip dtsi.
>=20
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>
>=20
> ---
>=20
> Changes in v5: None
> Changes in v4:
> - Update the comments for ecc setting selection
>=20
> Changes in v3: None
> Changes in v2:
> - Minor cosmetic fixes
>=20
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 83 ++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index 73fdf7ce21aa..efeee9e80213 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -1038,6 +1038,19 @@ static inline int brcmnand_sector_1k_shift(struct =
brcmnand_controller *ctrl)
>  		return -1;
>  }
> =20
> +static int brcmnand_get_sector_size_1k(struct brcmnand_host *host)
> +{
> +	struct brcmnand_controller *ctrl =3D host->ctrl;
> +	int shift =3D brcmnand_sector_1k_shift(ctrl);
> +	u16 acc_control_offs =3D brcmnand_cs_offset(ctrl, host->cs,
> +						  BRCMNAND_CS_ACC_CONTROL);
> +
> +	if (shift < 0)
> +		return 0;
> +
> +	return (nand_readreg(ctrl, acc_control_offs) >> shift) & 0x1;

What is this & 0x1 ? If you return a yes/no value, please make this
function return a bool. Also, please use intermediate steps to clarify
what you do.

sector_1k_bit =3D ...;
acc =3D nand_readreg();
return acc & BIT(sector_1k_bit);

Or something like that.

> +}
> +
>  static void brcmnand_set_sector_size_1k(struct brcmnand_host *host, int =
val)
>  {
>  	struct brcmnand_controller *ctrl =3D host->ctrl;
> @@ -1055,6 +1068,38 @@ static void brcmnand_set_sector_size_1k(struct brc=
mnand_host *host, int val)
>  	nand_writereg(ctrl, acc_control_offs, tmp);
>  }
> =20
> +static int brcmnand_get_spare_size(struct brcmnand_host *host)
> +{
> +	struct brcmnand_controller *ctrl =3D host->ctrl;
> +	u16 acc_control_offs =3D brcmnand_cs_offset(ctrl, host->cs,
> +						  BRCMNAND_CS_ACC_CONTROL);
> +	u32 acc =3D nand_readreg(ctrl, acc_control_offs);
> +
> +	return (acc & brcmnand_spare_area_mask(ctrl));
> +}
> +
> +static int brcmnand_get_ecc_strength(struct brcmnand_host *host)

					_from_strap

> +{
> +	struct brcmnand_controller *ctrl =3D host->ctrl;
> +	u16 acc_control_offs =3D brcmnand_cs_offset(ctrl, host->cs,
> +						  BRCMNAND_CS_ACC_CONTROL);
> +	int sector_size_1k =3D brcmnand_get_sector_size_1k(host);
> +	int spare_area_size, ecc_level, ecc_strength;
> +	u32 acc;
> +
> +	spare_area_size =3D brcmnand_get_spare_size(host);
> +	acc =3D nand_readreg(ctrl, acc_control_offs);
> +	ecc_level =3D (acc & brcmnand_ecc_level_mask(ctrl)) >> ctrl->ecc_level_=
shift;

Please use FIELD_PREP/FIELD_GET.

> +	if (sector_size_1k)
> +		ecc_strength =3D ecc_level * 2;
> +	else if (spare_area_size =3D=3D 16 && ecc_level =3D=3D 15)
> +		ecc_strength =3D 1; /* hamming */
> +	else
> +		ecc_strength =3D ecc_level;
> +
> +	return ecc_strength;
> +}
> +
>  /***********************************************************************
>   * CS_NAND_SELECT
>   ***********************************************************************/
> @@ -2622,19 +2667,43 @@ static int brcmnand_setup_dev(struct brcmnand_hos=
t *host)
>  		nanddev_get_memorg(&chip->base);
>  	struct brcmnand_controller *ctrl =3D host->ctrl;
>  	struct brcmnand_cfg *cfg =3D &host->hwcfg;
> -	char msg[128];
> +	struct device_node *np =3D nand_get_flash_node(chip);
>  	u32 offs, tmp, oob_sector;
> -	int ret;
> +	int ret, sector_size_1k =3D 0;
> +	bool use_strap =3D false;
> +	char msg[128];
> =20
>  	memset(cfg, 0, sizeof(*cfg));
> +	use_strap =3D of_property_read_bool(np, "brcm,nand-ecc-use-strap");
> =20
> -	ret =3D of_property_read_u32(nand_get_flash_node(chip),
> -				   "brcm,nand-oob-sector-size",
> +	/*
> +	 * Set ECC size and strength based on hw configuration from strap
> +	 * if brcm,nand-ecc-use-strap is set. However if nand-ecc-strength
> +	 * is set, its value will be used and ignore the strap setting.

Please error out in this case. It's one or the other, not both.

> +	 */
> +	if (chip->ecc.strength)
> +		use_strap =3D 0;
> +
> +	if (use_strap) {
> +		chip->ecc.strength =3D brcmnand_get_ecc_strength(host);
> +		sector_size_1k =3D brcmnand_get_sector_size_1k(host);
> +		if (chip->ecc.size =3D=3D 0) {
> +			if (sector_size_1k < 0)
> +				chip->ecc.size =3D 512;
> +			else
> +				chip->ecc.size =3D 512 << sector_size_1k;
> +		}

I'd instead make a function named brcmnand_get_ecc_settings() with the
chip->ecc parameter, so you can directly fill the entries without
getting another time the sector_size_1k thing.

Strength and step size are tightly linked, it does make sense to derive
them both at the same time.

> +	}
> +
> +	ret =3D of_property_read_u32(np, "brcm,nand-oob-sector-size",
>  				   &oob_sector);
>  	if (ret) {
> -		/* Use detected size */
> -		cfg->spare_area_size =3D mtd->oobsize /
> -					(mtd->writesize >> FC_SHIFT);
> +		if (use_strap)
> +			cfg->spare_area_size =3D brcmnand_get_spare_size(host);
> +		else
> +			/* Use detected size */
> +			cfg->spare_area_size =3D mtd->oobsize /
> +						(mtd->writesize >> FC_SHIFT);
>  	} else {
>  		cfg->spare_area_size =3D oob_sector;
>  	}


Thanks,
Miqu=C3=A8l

