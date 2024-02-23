Return-Path: <linux-kernel+bounces-77993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D77860DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC5E1C217FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D040D5C61F;
	Fri, 23 Feb 2024 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dxvqT30F"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDF542ABC
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679947; cv=none; b=LSZxMchOr0h9DIQabpsV7BkrPDddHB5bXWt/i2nKBWvbMhjB/pHkrqonGYqgINrsMF2y6vnfj5xmq5eoFhpghAG5lMWAmZWqor/BLlU+mvAgvYTsSbSsxVA8k8NAjjLqzOOBkW3hS2hiteHsT31d2DyDeDPkoJtfimK7D4e2TxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679947; c=relaxed/simple;
	bh=tfVZnouqxcH4+vHT8E66+75iK2BwFsQTw791FF9I4Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOCeI/fzfYp3hossDuTinE0yRATSGy5k0+bFl4hZ12QyTjHjJUw18HZ/ta9ZuA8a+hsLNXMoMXcRNoh37Kspz2zN9cAxoEBP0LMrRMei0ZGWqbUpTOAMw99Dbd5+2BnyvQLoQoVa4t8GEh/sL166Jtim1ISX/nIfaNR20eWSuW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dxvqT30F; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF3CF40003;
	Fri, 23 Feb 2024 09:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708679936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4gG2DNJQ1sxB4LTvdXFLaVAG1FVlnYdKq/NERCDiFaw=;
	b=dxvqT30FkF1AEQwwbZp9iFl6iVBI1iuZ5T3QAuYocxhIb6yAMgZGLQ6cyLgJZIBGs/UNW9
	RhBIDu2U0OM1WILz2pqmn/HeZ7JWWEu0vQ3Dj69AEtVpH1ja7VYBV74JewhwR7c0StLlMS
	sfZTk2S17OEolI40LMKkhX6yxcvMpGqvPOsJnaNadvEB8koCFRL6fWnLdSWe8hZPCWOye9
	fFdagj/DuBIu1WNXochOxnBXl/8qYl350SsfiFBj/ZUx6hJIKWPNp47RGjGtg+VYPfiFDG
	pt1FveOSYb8B/LxfaKd2W2IimazIKfGJwgx0cjjVQoHQV6T2PkPuLFsc5F0LWw==
Date: Fri, 23 Feb 2024 10:18:52 +0100
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
Message-ID: <20240223101852.005da3ad@xps-13>
In-Reply-To: <20240223034758.13753-13-william.zhang@broadcom.com>
References: <20240223034758.13753-1-william.zhang@broadcom.com>
	<20240223034758.13753-13-william.zhang@broadcom.com>
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

william.zhang@broadcom.com wrote on Thu, 22 Feb 2024 19:47:57 -0800:

> BCMBCA broadband SoC based board design does not specify ecc setting in
> dts but rather use the SoC NAND strap info to obtain the ecc strength
> and spare area size setting. Add brcm,nand-ecc-use-strap dts propety for
> this purpose and update driver to support this option. However these two
> options can not be used at the same time.
>=20
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>
>=20

FYI I did not receive patches 7, 8, 9, which makes the series numbering
very odd.

> ---
>=20
> Changes in v6:
> - Combine the ecc step size and ecc strength into one get function
> - Treat it as error condition if both brcm,nand-ecc-use-strap and nand
> ecc dts properties are set
> - Add intermediate steps to get the sector size bitfield
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
>  1 file changed, 77 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index ef7d340475be..e8ffc283b365 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -1038,6 +1038,22 @@ static inline int brcmnand_sector_1k_shift(struct =
brcmnand_controller *ctrl)
>  		return -1;
>  }
> =20
> +static int brcmnand_get_sector_size_1k(struct brcmnand_host *host)
> +{
> +	struct brcmnand_controller *ctrl =3D host->ctrl;
> +	int sector_size_bit =3D brcmnand_sector_1k_shift(ctrl);
> +	u16 acc_control_offs =3D brcmnand_cs_offset(ctrl, host->cs,
> +						  BRCMNAND_CS_ACC_CONTROL);
> +	u32 acc_control;
> +
> +	if (sector_size_bit < 0)
> +		return 0;
> +
> +	acc_control =3D nand_readreg(ctrl, acc_control_offs);
> +
> +	return (acc_control & BIT(sector_size_bit)) >> sector_size_bit;

FIELD_PREP, FIELD_GET, *please*.

> +}
> +
>  static void brcmnand_set_sector_size_1k(struct brcmnand_host *host, int =
val)
>  {
>  	struct brcmnand_controller *ctrl =3D host->ctrl;
> @@ -1055,6 +1071,43 @@ static void brcmnand_set_sector_size_1k(struct brc=
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
> +static void brcmnand_get_ecc_settings(struct brcmnand_host *host, struct=
 nand_chip *chip)
> +{
> +	struct brcmnand_controller *ctrl =3D host->ctrl;
> +	u16 acc_control_offs =3D brcmnand_cs_offset(ctrl, host->cs,
> +						  BRCMNAND_CS_ACC_CONTROL);
> +	int sector_size_1k =3D brcmnand_get_sector_size_1k(host);
> +	int spare_area_size, ecc_level;
> +	u32 acc;
> +
> +	spare_area_size =3D brcmnand_get_spare_size(host);
> +	acc =3D nand_readreg(ctrl, acc_control_offs);
> +	ecc_level =3D (acc & brcmnand_ecc_level_mask(ctrl)) >> ctrl->ecc_level_=
shift;

ditto

> +	if (sector_size_1k)
> +		chip->ecc.strength =3D ecc_level * 2;
> +	else if (spare_area_size =3D=3D 16 && ecc_level =3D=3D 15)
> +		chip->ecc.strength =3D 1; /* hamming */
> +	else
> +		chip->ecc.strength =3D ecc_level;
> +
> +	if (chip->ecc.size =3D=3D 0) {
> +		if (sector_size_1k < 0)

Should be <=3D 0 I guess

> +			chip->ecc.size =3D 512;
> +		else
> +			chip->ecc.size =3D 512 << sector_size_1k;

What is this? Are you expecting sector_size_1k to be 0 or 1
and thus multiply 512 by two?

Please just use:
			chip->ecc.size =3D SZ_1K;
		=09
> +	}
> +}
> +
>  /***********************************************************************
>   * CS_NAND_SELECT
>   ***********************************************************************/
> @@ -2625,19 +2678,37 @@ static int brcmnand_setup_dev(struct brcmnand_hos=
t *host)
>  		nanddev_get_memorg(&chip->base);
>  	struct brcmnand_controller *ctrl =3D host->ctrl;
>  	struct brcmnand_cfg *cfg =3D &host->hwcfg;
> -	char msg[128];
> +	struct device_node *np =3D nand_get_flash_node(chip);
>  	u32 offs, tmp, oob_sector;
> +	bool use_strap =3D false;
> +	char msg[128];
>  	int ret;
> =20
>  	memset(cfg, 0, sizeof(*cfg));
> +	use_strap =3D of_property_read_bool(np, "brcm,nand-ecc-use-strap");
> =20
> -	ret =3D of_property_read_u32(nand_get_flash_node(chip),
> -				   "brcm,nand-oob-sector-size",
> +	/*
> +	 * Either nand-ecc-xxx or brcm,nand-ecc-use-strap can be set. Error out
> +	 * if both exist.
> +	 */

Thanks for the comment but I think the error string is clear enough.

> +	if (chip->ecc.strength && use_strap) {
> +		dev_err(ctrl->dev,
> +			"nand ecc and strap ecc settings can't be set at the same time\n");

Can we change to
"ECC strap and DT ECC configuration properties are mutually exclusive"

> +		return -EINVAL;
> +	}
> +
> +	if (use_strap)
> +		brcmnand_get_ecc_settings(host, chip);
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

The rest of the series looks good to me.

Thanks,
Miqu=C3=A8l

