Return-Path: <linux-kernel+bounces-70939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDAC859E60
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE551F216A7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A950219FC;
	Mon, 19 Feb 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmNtypG4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F1D21363
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331736; cv=none; b=jQzjRGgiEdpPDxeNT+8hcIY51I7qvZRjCWhGxmrDf0cH9aQjZULPff1FZiUJ8WEqExoZylXhz1AgwjcnTn7ZCnayAsRxBYBcp5ZA+F0ry9mni9k3fMotOMoyEzL4wf1X3kjqpMW7kvKPSg1Wbr9NoR1zsAXR25UifVtYzjsQbkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331736; c=relaxed/simple;
	bh=RdRCgva74wgXOKhvd4pBIESMw8E3D4lI+/Xi9vwJuqM=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=EzkCf+UOBdoIh8HlfppN6J5yxVxkYLE+PZCFm0kpcPFu6bDUe+qlUVIHwqKmG+UOyNjHXjgaHt8j8s6NUyOigOA+0yJF9t3msXj7Y1lWqmwPR7wwWMls1+0DAGTzRAtvHpdOj4+ZMTuWA9Tmgr/fg0PyDT2cCn+40CtzX5jHZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmNtypG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106B7C43390;
	Mon, 19 Feb 2024 08:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708331735;
	bh=RdRCgva74wgXOKhvd4pBIESMw8E3D4lI+/Xi9vwJuqM=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=jmNtypG4aG/ru4HdxZqsyRMkapDuDrpnhy9wgGGgBVaHozFG0l5g9mQdo+HQGgqqA
	 rWrQj/RLCaMML2chQ3+4WmnlCTYqYXsJ+b4xsUrZnPF31TZAOklpIvdjoXSgvmsrRh
	 pttsq958gzz7QjDBwIQrHucmrmNQH7s4/UhEUR8gwR/LudPjPn+2eelXqegDHeTr9n
	 MFVwkynGHsH3TE+WLY6kHMCOMchtXlSYYIYXKQ0bKhNGWJscNZ4Kb5q222mmTs5ADR
	 MWZH02xjSMFmXJ1eTWbBbOz5c414v9bpkHL8Ccm3Tlf7eTTjFlDYQH7zzKesBKqzdd
	 wEksk3Ub5eLlg==
Content-Type: multipart/signed;
 boundary=b8f603d48c60b1f4f96ff961f5834ebd6fe8566e273b1df18547b9aca6e0;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 19 Feb 2024 09:35:27 +0100
Message-Id: <CZ8X218EWPC9.25TO9O5C7VXQ9@kernel.org>
Cc: "David Bauer" <mail@david-bauer.net>
From: "Michael Walle" <mwalle@kernel.org>
To: "Christian Marangi" <ansuelsmth@gmail.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] mtd: spi-nor: Add support for BoHong bh25q128as
X-Mailer: aerc 0.16.0
References: <20240217122029.3278-1-ansuelsmth@gmail.com>
In-Reply-To: <20240217122029.3278-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--b8f603d48c60b1f4f96ff961f5834ebd6fe8566e273b1df18547b9aca6e0
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Sat Feb 17, 2024 at 1:20 PM CET, Christian Marangi wrote:
> From: David Bauer <mail@david-bauer.net>
>
> Add MTD support for the BoHong bh25q128as SPI NOR chip.
> The chip has 16MB of total capacity, divided into a total of 256
> sectors, each 64KB sized. The chip also supports 4KB sectors.
> Additionally, it supports dual and quad read modes.
>
> Datasheet is public and can be found here [1].

Last time it wasn't clear if this flash will support SFDP or not.
Could you please try to dump the SFDP again, see [1].


> Functionality was verified on an Tenbay WR1800K / MTK MT7621 board.

Also per [1], you'd need to provide your test results.

> [1] https://www.e-interlink.com.tw/userUpload/files/BH25Q128AS_v1_0.pdf

Link: right above your SoB please.

> Signed-off-by: David Bauer <mail@david-bauer.net>
> [ reworked to new flash_info format ]
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/mtd/spi-nor/Makefile |  1 +
>  drivers/mtd/spi-nor/bohong.c | 24 ++++++++++++++++++++++++
>  drivers/mtd/spi-nor/core.c   |  1 +
>  drivers/mtd/spi-nor/core.h   |  1 +
>  4 files changed, 27 insertions(+)
>  create mode 100644 drivers/mtd/spi-nor/bohong.c
>
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index 5e68468b72fc..c8849cf5124f 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -2,6 +2,7 @@
> =20
>  spi-nor-objs			:=3D core.o sfdp.o swp.o otp.o sysfs.o
>  spi-nor-objs			+=3D atmel.o
> +spi-nor-objs			+=3D bohong.o
>  spi-nor-objs			+=3D eon.o
>  spi-nor-objs			+=3D esmt.o
>  spi-nor-objs			+=3D everspin.o
> diff --git a/drivers/mtd/spi-nor/bohong.c b/drivers/mtd/spi-nor/bohong.c
> new file mode 100644
> index 000000000000..26988c139262
> --- /dev/null
> +++ b/drivers/mtd/spi-nor/bohong.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2005, Intec Automation Inc.
> + * Copyright (C) 2014, Freescale Semiconductor, Inc.

Please remove, there is nothing from the old code left here.

> + */
> +
> +#include <linux/mtd/spi-nor.h>
> +
> +#include "core.h"
> +
> +static const struct flash_info bohong_parts[] =3D {
> +	{
> +		.id =3D SNOR_ID(0x68, 0x40, 0x18),
> +		.name =3D "bh25q128as",
No names anymore, please.

> +		.size =3D SZ_16M,
> +		.no_sfdp_flags =3D SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +	},
> +};
> +
> +const struct spi_nor_manufacturer spi_nor_bohong =3D {
> +	.name =3D "bohong",

This should be dropped, too. Otherwise looks good, if SFDP is not
supported.

-michael

[1] https://docs.kernel.org/driver-api/mtd/spi-nor.html

> +	.parts =3D bohong_parts,
> +	.nparts =3D ARRAY_SIZE(bohong_parts),
> +};
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 4129764fad8c..29c28ee683a1 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2037,6 +2037,7 @@ int spi_nor_sr2_bit7_quad_enable(struct spi_nor *no=
r)
> =20
>  static const struct spi_nor_manufacturer *manufacturers[] =3D {
>  	&spi_nor_atmel,
> +	&spi_nor_bohong,
>  	&spi_nor_eon,
>  	&spi_nor_esmt,
>  	&spi_nor_everspin,
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index d36c0e072954..c293568ae827 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -601,6 +601,7 @@ struct sfdp {
> =20
>  /* Manufacturer drivers. */
>  extern const struct spi_nor_manufacturer spi_nor_atmel;
> +extern const struct spi_nor_manufacturer spi_nor_bohong;
>  extern const struct spi_nor_manufacturer spi_nor_eon;
>  extern const struct spi_nor_manufacturer spi_nor_esmt;
>  extern const struct spi_nor_manufacturer spi_nor_everspin;


--b8f603d48c60b1f4f96ff961f5834ebd6fe8566e273b1df18547b9aca6e0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZdMSzxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvsAMQEA3ixSPXqAJfCop2pxfyj0kdDFERTnDLg/
Q3ExoH80lRQA/1qrCPgE85Tw+hOX5dw+TEwZ6/IOQxD5QORv8VqZ1PwM
=zQXK
-----END PGP SIGNATURE-----

--b8f603d48c60b1f4f96ff961f5834ebd6fe8566e273b1df18547b9aca6e0--

