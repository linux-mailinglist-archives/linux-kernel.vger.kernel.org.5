Return-Path: <linux-kernel+bounces-133177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 900E5899FFF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 244A2B2231D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC1116F28C;
	Fri,  5 Apr 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceKEAO9U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93E516EBEF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328093; cv=none; b=Nx++qFaPdp6GCvbsWs2lC2/L5VoMnusELQ6XTW+DMcKX7rv38LxaQSavT3RXMpujOfYQr0UaobTK1LHrZk3jnefaF2E42MBqKQWWFRUBfpya9fWvem96ZwiSIPCoL3PUtFCdHVeWjb7498hLd8KEl7j9LfMMlSMOEeSKDoo24Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328093; c=relaxed/simple;
	bh=Btz/Hmez86EgZIrlgPrZQhuTuSmdGF/ahACcmo7T4Mg=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=HDzqi1bYyTI60m2MK3IVT/LIhEy0G6K7eFQn6ckxmuQszaG2E4bic/d7gVgkNgzWMbsj5QlkL3N5n+bnVNcOVbc9Gw6NlXf1kKR7M4YZhtaVd7Gw6oHdVXqqSuiK+RxH/XlRN2zQr5TfWHhQq0w63F/8L9ozOKUvD/yduWHWvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceKEAO9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0203CC433F1;
	Fri,  5 Apr 2024 14:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712328093;
	bh=Btz/Hmez86EgZIrlgPrZQhuTuSmdGF/ahACcmo7T4Mg=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=ceKEAO9UgifeYaKFh885NRTA4DS7/FeFKKR9QT7dkK3CHRKwAa217pcHGGBK1wM5B
	 PWe4e1byFUEtobZUDsRGGIZ7eyXWhFGJuvEh3aFxafYxb/A8JrKqq5vWt49qQ1plw7
	 l6SNs8m/5FcsN4oVBqULt8Z1F2+/v4gDk83WsOFH4Q27thtKChR5qSiCMdZvorsy4x
	 AND6dENTJMwSssXppAlY1MIp6VKYAwYz6fX0Nbgrk2soTM9T2hDW+EzZpvZZvomjh4
	 6EShp2Nk6PmavmEDN0f7ey5HV9Zankjufonefl/0S7JnmInABpjRIVKuwKblw97YZK
	 7rbEPHrqJhpZQ==
Content-Type: multipart/signed;
 boundary=acb6ba1a78e0ad4c2fe8ee2d551c5ffa69006074ac6e66ab85279d8ddadb;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 05 Apr 2024 16:41:29 +0200
Message-Id: <D0C9NCOMI27O.2VW2U3FNFTSPK@kernel.org>
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Flavio Suligoi" <f.suligoi@asem.it>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>
Subject: Re: [PATCH 1/1] mtd: spi-nor: everspin: add em004lxb entry
X-Mailer: aerc 0.16.0
References: <20240405100104.480779-1-f.suligoi@asem.it>
 <20240405100104.480779-2-f.suligoi@asem.it>
In-Reply-To: <20240405100104.480779-2-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--acb6ba1a78e0ad4c2fe8ee2d551c5ffa69006074ac6e66ab85279d8ddadb
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Flavio,

On Fri Apr 5, 2024 at 12:01 PM CEST, Flavio Suligoi wrote:
> Add the Everspin EM0004LXB 4Mb (512KB) Industrial STT-MRAM Persistent
> Memory.
> This device is JEDEC compatible (JESD251 and JESD251-1), but it is not
> able to provide SFDP information.

Did you try the at25 driver if it will fit your usecase? Judging
from your last response, it sounds like it will do.

>
> Link: https://www.everspin.com/file/158244/download
>
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  drivers/mtd/spi-nor/everspin.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/everspin.c b/drivers/mtd/spi-nor/everspi=
n.c
> index 5f321e24ae7d..4741930ce9a8 100644
> --- a/drivers/mtd/spi-nor/everspin.c
> +++ b/drivers/mtd/spi-nor/everspin.c
> @@ -31,6 +31,14 @@ static const struct flash_info everspin_nor_parts[] =
=3D {
>  		.size =3D SZ_512K,
>  		.sector_size =3D SZ_512K,
>  		.flags =3D SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> +	}, {
> +		.id =3D SNOR_ID(0x6b, 0xbb, 0x13),
> +		.name =3D "em004lxb",
> +		.size =3D SZ_512K,
> +		.sector_size =3D SZ_512K,
> +		.flags =3D SPI_NOR_NO_ERASE | SPI_NOR_NO_FR | SPI_NOR_HAS_LOCK |

Will it also work without SPI_NOR_NO_ERASE? Also, the flash supports
fast read, so drop NO_FR. Also, please have a look at [1] for the
testing requirements.

Thanks.
-michael

> +			 SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6,
> +		.no_sfdp_flags =3D SPI_NOR_SKIP_SFDP,
>  	}
>  };
> =20

[1] https://docs.kernel.org/driver-api/mtd/spi-nor.html

--acb6ba1a78e0ad4c2fe8ee2d551c5ffa69006074ac6e66ab85279d8ddadb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZhANmRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hh6wF/W6ehEKW1KipXS15k6n/JOHz5SNhKHN3B
vpilSYvkfW+/ZLMZBgGjNTKnOFlePmnOAYCVhLAxPiDYQ1p8FHwGOLNFEjYLw/Lu
GRDEhq8JnOuyKnFJMv9UO0OaGygMib3W9Xg=
=bbaR
-----END PGP SIGNATURE-----

--acb6ba1a78e0ad4c2fe8ee2d551c5ffa69006074ac6e66ab85279d8ddadb--

