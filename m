Return-Path: <linux-kernel+bounces-93463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 091F9873032
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0FFB25A29
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B60D5CDF6;
	Wed,  6 Mar 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XgLGesxX"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FC5C8F2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712467; cv=none; b=eU0R8e31IMdewEwH9yw2FuNrA/+nsjlCmD/Agqr/FUqWjjHesPh9hlXPgK5dYh5B2ajCiXv6HRiBzSYB8FvdHp+ORhRWRdsP961I5HOrRvQPt1e3Eu3pE1NLpfmV/uyUYvKxiO7iHX4+yTPhlFuVFT8KRj199SQyOjVYgkjX58I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712467; c=relaxed/simple;
	bh=WUyXjfCKxdHQcvCv8rGh0pPCuiwJdw+dA3UIxJEkWak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CE5jRLukeYrPFhxv2L+EZdrJOvbH7D1uZnOSZ4tM8gLJjOASUxjbwrIhENB8vPFd0tYVJanoEACt/iZjaGW7AGwWyuPG5oPBsbG66Z91lfWAEbJOrojLyve+ZW1jAy+XW5fVKkG4j8y62xxaXuZM8U2q4pbu9Za0ooEPGjbXY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XgLGesxX; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88B001BF203;
	Wed,  6 Mar 2024 08:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709712461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHg4bTL7dYbp26FFw88j9BBPy3JhM3fqgWkSx+1pe5o=;
	b=XgLGesxX3iEkgWQwgjoFYI5SQrXBJs3gHGST3ALKmV/1WPlkTnr7TUGZO/oZea4pE+cx8y
	1fHoDu7fakET5VJWOAi56ayCmTPLtJtxfSBc4izoyN5Hdx1t1Ixxs+7oYdArmgKiiq/npB
	IbZndQ4LWhkQ9QNjFexWBrRgO6BzgIVaQc/DjQ6QH6zyMDMQXKeOGAm50oC8mnNXaFXk3s
	9W+fAwqdjEOt4x7i8Q6zSgksTqBJ1JfH3m/9uRhc/amCi/pGaLrCijwqX9jPb6kpRSZMLv
	yAflGzj2/k6/rJC6RCe5Y0BYihinJ6VIl1h31v71Oz0FlrBysL2KVp+J9IYN3w==
Date: Wed, 6 Mar 2024 09:07:39 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: KR Kim <kr.kim@skyhighmemory.com>
Cc: richard@nod.at, vigneshr@ti.com, mmkurbanov@salutedevices.com,
 ddrokosov@sberdevices.ru, gch981213@gmail.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 moh.sardi@skyhighmemory.com, changsub.shim@skyhighmemory.com
Subject: Re: [PATCH 2/2] SPI Nand Patch code for SkyHigh Momory
Message-ID: <20240306090739.31911391@xps-13>
In-Reply-To: <20240306041532.16985-1-kr.kim@skyhighmemory.com>
References: <20240306041532.16985-1-kr.kim@skyhighmemory.com>
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

Hello,

The subject tag is wrong (v2), the prefix is wrong, you are missing
the commit message, there is no Signed-off-by, and you sent a diff with
your v1 rather than a full patch.

You should probably try sending these using --dry-run and
--suppress-cc=3Dall while you are working on your series :)

Thanks,
Miqu=C3=A8l

kr.kim@skyhighmemory.com wrote on Wed,  6 Mar 2024 13:15:32 +0900:

> ---
>  drivers/mtd/nand/spi/Makefile  |  2 +-
>  drivers/mtd/nand/spi/skyhigh.c | 57 ++++++----------------------------
>  2 files changed, 11 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 48b429d90460..1e61ab21893a 100755
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  spinand-objs :=3D core.o alliancememory.o ato.o esmt.o foresee.o gigadev=
ice.o macronix.o
> -spinand-objs +=3D micron.o paragon.o toshiba.o winbond.o xtx.o skyhigh.o
> +spinand-objs +=3D micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) +=3D spinand.o
> diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhig=
h.c
> index 71de4fa34406..dd348849216d 100644
> --- a/drivers/mtd/nand/spi/skyhigh.c
> +++ b/drivers/mtd/nand/spi/skyhigh.c
> @@ -12,8 +12,8 @@
>  #define SPINAND_MFR_SKYHIGH		0x01
> =20
>  #define SKYHIGH_STATUS_ECC_1TO2_BITFLIPS	(1 << 4)
> -#define SKYHIGH_STATUS_ECC_3TO4_BITFLIPS	(2 << 4)
> -#define SKYHIGH_STATUS_ECC_5TO6_BITFLIPS	(3 << 4)
> +#define SKYHIGH_STATUS_ECC_3TO6_BITFLIPS	(2 << 4)
> +#define SKYHIGH_STATUS_ECC_UNCOR_ERROR  	(3 << 4)
> =20
>  #define SKYHIGH_CONFIG_PROTECT_EN	BIT(1)
> =20
> @@ -62,49 +62,15 @@ static const struct mtd_ooblayout_ops skyhigh_spinand=
_ooblayout =3D {
>  	.free =3D skyhigh_spinand_ooblayout_free,
>  };
> =20
> -#if 0
> -bool skyhigh_spinand_isbad(struct spinand_device *spinand,
> -			   const struct nand_pos *pos)
> -{
> -	u8 marker;
> -	struct nand_page_io_req req =3D {
> -		.pos =3D *pos,
> -		.ooblen =3D 1,
> -		.ooboffs =3D 0,
> -		.oobbuf.in =3D &marker,
> -		.mode =3D MTD_OPS_RAW,
> -	};
> -
> -	req.pos.page =3D 0;
> -	spinand_read_page(spinand, &req);
> -	if (marker !=3D 0xff)
> -		return true;
> -
> -#if 0
> -	req.pos.page =3D 1;
> -	spinand_read_page(spinand, &req);
> -	if (marker !=3D 0xff)
> -		return true;
> -
> -	req.pos.page =3D 63;
> -	spinand_read_page(spinand, &req);
> -	if (marker !=3D 0xff)
> -		return true;
> -#endif
> -
> -	return false;
> -}
> -#endif
> -
>  static int skyhigh_spinand_ecc_get_status(struct spinand_device *spinand,
>  				  u8 status)
>  {
>  	/* SHM
> -	00 : No bit-flip
> -	01 : 1-2 errors corrected
> -	10 : 3-6 errors corrected        =20
> -	11 : uncorrectable
> -	*/
> +	 * 00 : No bit-flip
> +	 * 01 : 1-2 errors corrected
> +	 * 10 : 3-6 errors corrected        =20
> +	 * 11 : uncorrectable
> +	 */
> =20
>  	switch (status & STATUS_ECC_MASK) {
>  	case STATUS_ECC_NO_BITFLIPS:
> @@ -113,12 +79,10 @@ static int skyhigh_spinand_ecc_get_status(struct spi=
nand_device *spinand,
>  	case SKYHIGH_STATUS_ECC_1TO2_BITFLIPS:
>  		return 2;
> =20
> -	/* change from 4 to 6 */
> -	case SKYHIGH_STATUS_ECC_3TO4_BITFLIPS:
> + 	case SKYHIGH_STATUS_ECC_3TO6_BITFLIPS:
>  		return 6;=20
> =20
> -	/* uncorrectable for '11' */
> -	case SKYHIGH_STATUS_ECC_5TO6_BITFLIPS:
> + 	case SKYHIGH_STATUS_ECC_UNCOR_ERROR:
>  		return -EBADMSG;;
> =20
>  	default:
> @@ -179,8 +143,7 @@ static int skyhigh_spinand_init(struct spinand_device=
 *spinand)
> =20
>  static const struct spinand_manufacturer_ops skyhigh_spinand_manuf_ops =
=3D {
>  	.init =3D skyhigh_spinand_init,
> -/*	.isbad =3D skyhigh_spinand_isbad,*/
> -};
> + };
> =20
>  const struct spinand_manufacturer skyhigh_spinand_manufacturer =3D {
>  	.id =3D SPINAND_MFR_SKYHIGH,


