Return-Path: <linux-kernel+bounces-148712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8375D8A8681
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1C01C21169
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01484144D0E;
	Wed, 17 Apr 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVc3xXoN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2452B144D02
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365017; cv=none; b=CzODskiuOh1NKKYHCI4/AAKFrWRAOIw+F+NI/DUhtaLtHEP2NuN5MyEcAJZ/vk0eyH+LD31XsF5VCRTjOm2/B+iI2TLU3pwnFgkPP6NWurVBaQMDO1z+Iym78sg2OyYgy6QZFvY8eLylJ/EAd3m/c1oembq7sUT4IseH605yniU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365017; c=relaxed/simple;
	bh=dG6QbvSGBr85d4qsnF99BtQTXrMCUcA4EMBTDxvnqJI=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=TsJnMAeYMRdns1zy9fjZ8G7+Z9W6nFxQzzgVLrIyZFGPZ8weAXvNb9KkOmOq6klaQsbEeCO+Mmu7lLGr8VBed3CCbUY1dRcjkEr6eGy9DbzQH+pHj+Cwo+7KYnTf8A/Dv6ouc9onOcwMs9c8eTUwB4FS9IlKP5dLrDhK3E8cUvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVc3xXoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C02C2BD11;
	Wed, 17 Apr 2024 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713365016;
	bh=dG6QbvSGBr85d4qsnF99BtQTXrMCUcA4EMBTDxvnqJI=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=eVc3xXoN3WjMjWVkYPeIrzjR9x3rGzjp05VaN6nD74mTSzRjTaCpPmSz0PvNu6lpg
	 sRWTlO0Qalf/HxgqdDGNEMuTmdpH9Etr4DIKk08Vt8McjFmV5dO/Oi9WtyJvQe54QE
	 CvOBqR/eDdSelVMdyAXeP/RWQAiXsXQduLepmsCzBXXjEpKvATgNSHgYYaEWbVxI5J
	 59OB6R+R2MKy3ZsXBH92ccIPOkFawmrBOM0QjwhAKMpMD4cyrZb4IfNBPyHgJcHd4Y
	 iJzXYNq2FgCDq2Erzz4G6vmDY+KtvSTHrslDxBRksqTW8YzPh4UL4yW+1mf3+CP0y3
	 GpuHu9LDhvS5A==
Content-Type: multipart/signed;
 boundary=b827ff6a1d6e7c0f215599c0781d4f0d62eb4fdb77172072f70a52582924;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 17 Apr 2024 16:43:15 +0200
Message-Id: <D0MH78KYG87L.ETRH24X6MK6X@kernel.org>
To: "Pratyush Yadav" <pratyush@kernel.org>
Subject: Re: [PATCH v1 3/6] mtd: spi-nor: get rid of SPI_NOR_NO_FR
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240412134405.381832-1-mwalle@kernel.org>
 <20240412134405.381832-4-mwalle@kernel.org> <mafs0sezk6rcr.fsf@kernel.org>
In-Reply-To: <mafs0sezk6rcr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--b827ff6a1d6e7c0f215599c0781d4f0d62eb4fdb77172072f70a52582924
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Apr 17, 2024 at 3:39 PM CEST, Pratyush Yadav wrote:
> On Fri, Apr 12 2024, Michael Walle wrote:
>
> > The evervision FRAM devices are the only user of the NO_FR flag. Drop
> > the global flag and instead use a manufacturer fixup for the evervision
> > flashes to drop the fast read support.
> >
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > ---
> > Please note, that the fast read opcode will still be set in
> > spi_nor_init_default_params(), but the selection of the read opcodes
> > just depends on the mask.
>
> Since that is the case now, might as well drop the
>
>     if (params->hwcaps.mask & SNOR_HWCAPS_READ_FAST)
>
> in spi_nor_init_default_params().

I want to address that in another patch where I'll do that for all
the opcodes. Just doing it for the fast read looks odd.

> > That is also something I want to fix soon: the opcodes can always
> > be set and the drivers/SFDP will only set the mask. Opcodes then can be
> > switched between 3b and 4b ones if necessary.
> > ---
> >  drivers/mtd/spi-nor/core.c     | 12 +++++-------
> >  drivers/mtd/spi-nor/core.h     |  2 --
> >  drivers/mtd/spi-nor/everspin.c | 19 +++++++++++++++----
> >  3 files changed, 20 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index fb76e0522665..65e6531ada0a 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -2952,14 +2952,12 @@ static void spi_nor_init_default_params(struct =
spi_nor *nor)
> >  	params->page_size =3D info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;
> >  	params->n_banks =3D info->n_banks ?: SPI_NOR_DEFAULT_N_BANKS;
> > =20
> > -	if (!(info->flags & SPI_NOR_NO_FR)) {
> > -		/* Default to Fast Read for DT and non-DT platform devices. */
> > -		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_FAST;
> > +	/* Default to Fast Read for DT and non-DT platform devices. */
> > +	params->hwcaps.mask |=3D SNOR_HWCAPS_READ_FAST;
> > =20
> > -		/* Mask out Fast Read if not requested at DT instantiation. */
> > -		if (np && !of_property_read_bool(np, "m25p,fast-read"))
> > -			params->hwcaps.mask &=3D ~SNOR_HWCAPS_READ_FAST;
> > -	}
> > +	/* Mask out Fast Read if not requested at DT instantiation. */
> > +	if (np && !of_property_read_bool(np, "m25p,fast-read"))
> > +		params->hwcaps.mask &=3D ~SNOR_HWCAPS_READ_FAST;
>
> Nit: move this above where SNOR_CMD_READ_FAST is set up.
>
> Also, I think this is a bit clearer:
>
> 	/* Default to Fast Read for non-DT and enable it if requested by DT. */
> 	if (!np || of_property_read_bool(np, "m25p,fast-read"))
> 		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_FAST;

Will do.

> >  	/* (Fast) Read settings. */
> >  	params->hwcaps.mask |=3D SNOR_HWCAPS_READ;
> > diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> > index 072c69b0d06c..9aa7d6399c8a 100644
> > --- a/drivers/mtd/spi-nor/core.h
> > +++ b/drivers/mtd/spi-nor/core.h
> > @@ -479,7 +479,6 @@ struct spi_nor_id {
> >   *                            Usually these will power-up in a write-p=
rotected
> >   *                            state.
> >   *   SPI_NOR_NO_ERASE:        no erase command needed.
> > - *   SPI_NOR_NO_FR:           can't do fastread.
> >   *   SPI_NOR_QUAD_PP:         flash supports Quad Input Page Program.
> >   *   SPI_NOR_RWW:             flash supports reads while write.
> >   *
> > @@ -528,7 +527,6 @@ struct flash_info {
> >  #define SPI_NOR_BP3_SR_BIT6		BIT(4)
> >  #define SPI_NOR_SWP_IS_VOLATILE		BIT(5)
> >  #define SPI_NOR_NO_ERASE		BIT(6)
> > -#define SPI_NOR_NO_FR			BIT(7)
> >  #define SPI_NOR_QUAD_PP			BIT(8)
> >  #define SPI_NOR_RWW			BIT(9)
>
> Move the other bits up since the slot is now free.

Mhh can't decide what's better here. On one hand I'd really like to
avoid too much code churn because it's already hard enough to follow
the development using git blame. OTOH, a new flag would need to be
added in between the existing flags. Not sure.. Or we if we run out
of free spots at the end we might get rid of the free slots.

-michael

> > diff --git a/drivers/mtd/spi-nor/everspin.c b/drivers/mtd/spi-nor/evers=
pin.c
> > index 5f321e24ae7d..0720a61947e7 100644
> > --- a/drivers/mtd/spi-nor/everspin.c
> > +++ b/drivers/mtd/spi-nor/everspin.c
> > @@ -14,28 +14,39 @@ static const struct flash_info everspin_nor_parts[]=
 =3D {
> >  		.size =3D SZ_16K,
> >  		.sector_size =3D SZ_16K,
> >  		.addr_nbytes =3D 2,
> > -		.flags =3D SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> > +		.flags =3D SPI_NOR_NO_ERASE,
> >  	}, {
> >  		.name =3D "mr25h256",
> >  		.size =3D SZ_32K,
> >  		.sector_size =3D SZ_32K,
> >  		.addr_nbytes =3D 2,
> > -		.flags =3D SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> > +		.flags =3D SPI_NOR_NO_ERASE,
> >  	}, {
> >  		.name =3D "mr25h10",
> >  		.size =3D SZ_128K,
> >  		.sector_size =3D SZ_128K,
> > -		.flags =3D SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> > +		.flags =3D SPI_NOR_NO_ERASE,
> >  	}, {
> >  		.name =3D "mr25h40",
> >  		.size =3D SZ_512K,
> >  		.sector_size =3D SZ_512K,
> > -		.flags =3D SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> > +		.flags =3D SPI_NOR_NO_ERASE,
> >  	}
> >  };
> > =20
> > +static void evervision_nor_default_init(struct spi_nor *nor)
> > +{
> > +	/* Everspin FRAMs don't support the fast read opcode. */
> > +	nor->params->hwcaps.mask &=3D ~SNOR_HWCAPS_READ_FAST;
> > +}
> > +
> > +static const struct spi_nor_fixups evervision_nor_fixups =3D {
> > +	.default_init =3D evervision_nor_default_init,
> > +};
> > +
> >  const struct spi_nor_manufacturer spi_nor_everspin =3D {
> >  	.name =3D "everspin",
> >  	.parts =3D everspin_nor_parts,
> >  	.nparts =3D ARRAY_SIZE(everspin_nor_parts),
> > +	.fixups =3D &evervision_nor_fixups,
> >  };


--b827ff6a1d6e7c0f215599c0781d4f0d62eb4fdb77172072f70a52582924
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZh/gAxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jsVgGA3oMr36u2I/UnJ2cLt2sydND25+ZO+q9F
Bp7Ekmrmv3cgSPkp2AwHQCPRnpRjymPLAYDbE+G+w4jQtkeKYtO92o4lPhIW1wfV
L1hcmI3AlePxFb6EIoKtzN5ezyikhH0qtCA=
=fYjW
-----END PGP SIGNATURE-----

--b827ff6a1d6e7c0f215599c0781d4f0d62eb4fdb77172072f70a52582924--

