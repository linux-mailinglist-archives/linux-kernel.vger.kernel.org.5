Return-Path: <linux-kernel+bounces-95099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D73874930
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F1E285D32
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFBC633FE;
	Thu,  7 Mar 2024 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YmkKJGCc"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4805B633EB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798488; cv=none; b=PrKkGT1kqfeU5hCKWVEVZid2hrI8mrE1V978itfow9nKVKimg5eqoxRL4TbB19RGgFaR2OPVkk7BvatETFcQHrBTAsSkX9K4Qf026OZj297Pky9KiBgjOKLRMqyBfCF0htoBlAMHkSdVWEq6+8jwkNpeUMXKRvU+fkk9v273lZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798488; c=relaxed/simple;
	bh=tzesMHAmOx75LYEi89Qmp4BCIoBVl1JU6njfPMrrGK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPmr6rRNCHs8/WPjFoDs9C/jEYMTTiI5/rbZ9x97dVbQPht6jXiMdZyBjgrH1/ERaFGKUJp6un9HF2rAPxTawwhaJUhUcTHUuR54upguTz/0UWzdv5Ib95uNt8EorphjeaEA4SI+alm+v96qVcbecDyBVrnxLAw1oGGxqxZds1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YmkKJGCc; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03C052000D;
	Thu,  7 Mar 2024 08:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709798483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6TbWwFetyeMAAeJ0I8eiqd6uybcZNGMNlu7xz629/PM=;
	b=YmkKJGCc+SB3KiAD7CF9GAFHTyhFCWgrc7r5DYBKunAhd+RKx3phBKY7l3yyxAfZX1qulg
	SbTbeyyorGrhI45PYEqRnEcrPMFwfYIEAdacS3YVS8TsQZX/bxHo9DvZbQRsgkqV5ZNMAM
	91UMWP/6Zl9CRXC6Bkm/NnX4S1VhsO/5kNaP4AMyuXHeL3JWWFuUqHpt2PtN0bZ3IWfdLe
	LEvR+OtLQNNl4N2o0ZvJEWlGGB5MOeU5Pv1x80p+LwJPH0WTaCxibJtDKdNu8nVFKRJ9le
	0XdWFDajDSl756oaaD0V/D7qYs9QBG/MwuuV0zApHzvbCoVrHsSCT7/wFol9Sg==
Date: Thu, 7 Mar 2024 09:01:15 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: KR Kim <kr.kim@skyhighmemory.com>
Cc: richard@nod.at, vigneshr@ti.com, mmkurbanov@salutedevices.com,
 ddrokosov@sberdevices.ru, gch981213@gmail.com, michael@walle.cc,
 broonie@kernel.org, mika.westerberg@linux.intel.com,
 acelan.kao@canonical.com, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, moh.sardi@skyhighmemory.com,
 changsub.shim@skyhighmemory.com
Subject: Re:
Message-ID: <20240307090115.74d36dd9@xps-13>
In-Reply-To: <20240307060729.565350-1-kr.kim@skyhighmemory.com>
References: <20240307060729.565350-1-kr.kim@skyhighmemory.com>
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

Hi,

kr.kim@skyhighmemory.com wrote on Thu,  7 Mar 2024 15:07:29 +0900:

> Feat: Add SkyHigh Memory Patch code
>=20
> Add SPI Nand Patch code of SkyHigh Memory
> - Add company dependent code with 'skyhigh.c'
> - Insert into 'core.c' so that 'always ECC on'

Patch formatting is still messed up.

> commit 6061b97a830af8cb5fd0917e833e779451f9046a (HEAD -> master)
> Author: KR Kim <kr.kim@skyhighmemory.com>
> Date:   Thu Mar 7 13:24:11 2024 +0900
>=20
>     SPI Nand Patch code of SkyHigh Momory
>=20
>     Signed-off-by: KR Kim <kr.kim@skyhighmemory.com>
>=20
> From 6061b97a830af8cb5fd0917e833e779451f9046a Mon Sep 17 00:00:00 2001
> From: KR Kim <kr.kim@skyhighmemory.com>
> Date: Thu, 7 Mar 2024 13:24:11 +0900
> Subject: [PATCH] SPI Nand Patch code of SkyHigh Memory
>=20
> ---
>  drivers/mtd/nand/spi/Makefile  |   2 +-
>  drivers/mtd/nand/spi/core.c    |   7 +-
>  drivers/mtd/nand/spi/skyhigh.c | 155 +++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h    |   3 +
>  4 files changed, 165 insertions(+), 2 deletions(-)
>  mode change 100644 =3D> 100755 drivers/mtd/nand/spi/Makefile
>  mode change 100644 =3D> 100755 drivers/mtd/nand/spi/core.c
>  create mode 100644 drivers/mtd/nand/spi/skyhigh.c
>  mode change 100644 =3D> 100755 include/linux/mtd/spinand.h
>=20
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> old mode 100644
> new mode 100755
> index 19cc77288ebb..1e61ab21893a
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  spinand-objs :=3D core.o alliancememory.o ato.o esmt.o foresee.o gigadev=
ice.o macronix.o
> -spinand-objs +=3D micron.o paragon.o toshiba.o winbond.o xtx.o
> +spinand-objs +=3D micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) +=3D spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> old mode 100644
> new mode 100755
> index e0b6715e5dfe..e3f0a7544ba4
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -34,7 +34,7 @@ static int spinand_read_reg_op(struct spinand_device *s=
pinand, u8 reg, u8 *val)
>  	return 0;
>  }
> =20
> -static int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, =
u8 val)
> +int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)

Please do this in a separate commit.

>  {
>  	struct spi_mem_op op =3D SPINAND_SET_FEATURE_OP(reg,
>  						      spinand->scratchbuf);
> @@ -196,6 +196,10 @@ static int spinand_init_quad_enable(struct spinand_d=
evice *spinand)
>  static int spinand_ecc_enable(struct spinand_device *spinand,
>  			      bool enable)
>  {
> +	/* SHM : always ECC enable */
> +	if (spinand->flags & SPINAND_ON_DIE_ECC_MANDATORY)
> +		return 0;

Silently always enabling ECC is not possible. If you cannot disable the
on-die engine, then:
- you should prevent any other engine type to be used
- you should error out if a raw access is requested
- these chips are broken, IMO

> +
>  	return spinand_upd_cfg(spinand, CFG_ECC_ENABLE,
>  			       enable ? CFG_ECC_ENABLE : 0);
>  }
> @@ -945,6 +949,7 @@ static const struct spinand_manufacturer *spinand_man=
ufacturers[] =3D {
>  	&macronix_spinand_manufacturer,
>  	&micron_spinand_manufacturer,
>  	&paragon_spinand_manufacturer,
> +	&skyhigh_spinand_manufacturer,
>  	&toshiba_spinand_manufacturer,
>  	&winbond_spinand_manufacturer,
>  	&xtx_spinand_manufacturer,
> diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhig=
h.c
> new file mode 100644
> index 000000000000..92e7572094ff
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/skyhigh.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 SkyHigh Memory Limited
> + *
> + * Author: Takahiro Kuwano <takahiro.kuwano@infineon.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_SKYHIGH		0x01
> +
> +#define SKYHIGH_STATUS_ECC_1TO2_BITFLIPS	(1 << 4)
> +#define SKYHIGH_STATUS_ECC_3TO6_BITFLIPS	(2 << 4)
> +#define SKYHIGH_STATUS_ECC_UNCOR_ERROR  	(3 << 4)
> +
> +#define SKYHIGH_CONFIG_PROTECT_EN	BIT(1)
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 2, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
> +static int skyhigh_spinand_ooblayout_ecc(struct mtd_info *mtd, int secti=
on,
> +					 struct mtd_oob_region *region)
> +{
> +	if (section)
> +		return -ERANGE;
> +
> +	/* SkyHigh's ecc parity is stored in the internal hidden area and is no=
t needed for them. */

		     ECC		     an

"needed" is wrong here. Just stop after "area"


> +	region->length =3D 0;
> +	region->offset =3D mtd->oobsize;
> +
> +	return 0;
> +}
> +
> +static int skyhigh_spinand_ooblayout_free(struct mtd_info *mtd, int sect=
ion,
> +					  struct mtd_oob_region *region)
> +{
> +	if (section)
> +		return -ERANGE;
> +
> +	region->length =3D mtd->oobsize - 2;
> +	region->offset =3D 2;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops skyhigh_spinand_ooblayout =3D {
> +	.ecc =3D skyhigh_spinand_ooblayout_ecc,
> +	.free =3D skyhigh_spinand_ooblayout_free,
> +};
> +
> +static int skyhigh_spinand_ecc_get_status(struct spinand_device *spinand,
> +				  u8 status)
> +{
> +	/* SHM
> +	 * 00 : No bit-flip
> +	 * 01 : 1-2 errors corrected
> +	 * 10 : 3-6 errors corrected        =20
> +	 * 11 : uncorrectable
> +	 */

Thanks for the comment but the switch case looks rather
straightforward, it is self-sufficient in this case.

> +
> +	switch (status & STATUS_ECC_MASK) {
> +	case STATUS_ECC_NO_BITFLIPS:
> +		return 0;
> +
> +	case SKYHIGH_STATUS_ECC_1TO2_BITFLIPS:
> +		return 2;
> +
> + 	case SKYHIGH_STATUS_ECC_3TO6_BITFLIPS:
> +		return 6;=20
> +
> + 	case SKYHIGH_STATUS_ECC_UNCOR_ERROR:
> +		return -EBADMSG;;
> +
> +	default:
> +		break;

I guess you can directly call return -EINVAL here?

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct spinand_info skyhigh_spinand_table[] =3D {
> +	SPINAND_INFO("S35ML01G301",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x15),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(6, 32),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_ON_DIE_ECC_MANDATORY,
> +		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
> +		     		     skyhigh_spinand_ecc_get_status)),
> +	SPINAND_INFO("S35ML01G300",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
> +		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(6, 32),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_ON_DIE_ECC_MANDATORY,
> +		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
> +		     		     skyhigh_spinand_ecc_get_status)),
> +	SPINAND_INFO("S35ML02G300",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
> +		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
> +		     NAND_ECCREQ(6, 32),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_ON_DIE_ECC_MANDATORY,
> +		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
> +		     		     skyhigh_spinand_ecc_get_status)),
> +	SPINAND_INFO("S35ML04G300",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
> +		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 2, 1, 1),
> +		     NAND_ECCREQ(6, 32),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_ON_DIE_ECC_MANDATORY,
> +		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
> +		     		     skyhigh_spinand_ecc_get_status)),
> +};
> +
> +static int skyhigh_spinand_init(struct spinand_device *spinand)
> +{
> +	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK,
> +				    SKYHIGH_CONFIG_PROTECT_EN);

Is this really relevant? Isn't there an API for the block lock
mechanism?

> +}
> +
> +static const struct spinand_manufacturer_ops skyhigh_spinand_manuf_ops =
=3D {
> +	.init =3D skyhigh_spinand_init,
> + };
> +
> +const struct spinand_manufacturer skyhigh_spinand_manufacturer =3D {
> +	.id =3D SPINAND_MFR_SKYHIGH,
> +	.name =3D "SkyHigh",
> +	.chips =3D skyhigh_spinand_table,
> +	.nchips =3D ARRAY_SIZE(skyhigh_spinand_table),
> +	.ops =3D &skyhigh_spinand_manuf_ops,
> +};
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> old mode 100644
> new mode 100755
> index badb4c1ac079..0e135076df24
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -268,6 +268,7 @@ extern const struct spinand_manufacturer gigadevice_s=
pinand_manufacturer;
>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
>  extern const struct spinand_manufacturer micron_spinand_manufacturer;
>  extern const struct spinand_manufacturer paragon_spinand_manufacturer;
> +extern const struct spinand_manufacturer skyhigh_spinand_manufacturer;
>  extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
>  extern const struct spinand_manufacturer winbond_spinand_manufacturer;
>  extern const struct spinand_manufacturer xtx_spinand_manufacturer;
> @@ -312,6 +313,7 @@ struct spinand_ecc_info {
> =20
>  #define SPINAND_HAS_QE_BIT		BIT(0)
>  #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
> +#define SPINAND_ON_DIE_ECC_MANDATORY	BIT(2)	/* SHM */

If we go this route, then "mandatory" is not relevant here, we shall
convey the fact that the on-die ECC engine cannot be disabled and as
mentioned above, there are other impacts.

> =20
>  /**
>   * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine st=
ructure
> @@ -518,5 +520,6 @@ int spinand_match_and_init(struct spinand_device *spi=
nand,
> =20
>  int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
>  int spinand_select_target(struct spinand_device *spinand, unsigned int t=
arget);
> +int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val);
> =20
>  #endif /* __LINUX_MTD_SPINAND_H */


Thanks,
Miqu=C3=A8l

