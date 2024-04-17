Return-Path: <linux-kernel+bounces-148733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E8A8A86BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B21528735B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E407F1422CA;
	Wed, 17 Apr 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqea5TbB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296031411CA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365566; cv=none; b=g1zEZquf/2eJeW8GwMvfS4VkkmfPwd9PH0nU7d/5I09QRDwFskCIbv/9jjVxWycTOlWGDuhRF2TZWw16HsBkBd2bAj8wrGNy5vTeqw6GjtAMrlhDM8wZiI+Er69UPrQkTPWbUYj8rv49gugFa1fp04O9z2rlH3oNqJKVqCJor3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365566; c=relaxed/simple;
	bh=1HgaS+nDZFRHl/RIdVOdvy6E21/5+MqUrX5IPEQaVJ8=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=lHp9iiJQvYkurr/sDNtLHbxl50zj/Nes/1T9D4XxoBfRD0LJli3ISdLz6V+g5r6mvoyJwtgAkogkWwvWuR85Gn/EDbxtnEMXrRY4Fjv/5Pila0AoPgZYkGGG16EyjI/bIeefwC91LLsqu6LjMazX2GJi5ifnLLsZ81hzvCGujvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqea5TbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F89C072AA;
	Wed, 17 Apr 2024 14:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713365566;
	bh=1HgaS+nDZFRHl/RIdVOdvy6E21/5+MqUrX5IPEQaVJ8=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
	b=oqea5TbBb5nNM25HaRBloDKRmLJmRPyMGQpkY01KHNsWgfF09RTGH0uApUt07Yd7y
	 Ksh5u1LKo085w9zJVJI376QMlCzKFTe2ua2fdMzKfpeUSQVO/bbtZ3G8xiZGRRzR8h
	 K3V3CuosWh4bTPKNYP9BTr/IkA2peCvrX2aBcPJmzUYvHMa++X1F2cRS1BD/p2v121
	 mAK0OO07GNlT1nNkrxVyTDZcHwGk+Tc+Jj6tivM6gGEMhmmI+1rBq5ljXPRqhHPDJP
	 yPJb4gWmObyYHB1g8SAElyW9JlyXcj7vWSTNrP/eVf6rbCOsK/jVI0xX4X0yM3kJOd
	 pBA4WWkVa5Ruw==
Content-Type: multipart/signed;
 boundary=708fc41844f140b3d840031632678d0e44008df68536d14dad2e9ff8531b;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 17 Apr 2024 16:52:42 +0200
Message-Id: <D0MHEH8OOS44.2PPBZ3LFU4QG3@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Pratyush Yadav" <pratyush@kernel.org>
Subject: Re: [RFC PATCH v1 6/6] mtd: spi-nor: introduce support for
 displaying deprecation message
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>
X-Mailer: aerc 0.16.0
References: <20240412134405.381832-1-mwalle@kernel.org>
 <20240412134405.381832-7-mwalle@kernel.org> <mafs0jzkw6oq1.fsf@kernel.org>
In-Reply-To: <mafs0jzkw6oq1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--708fc41844f140b3d840031632678d0e44008df68536d14dad2e9ff8531b
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Apr 17, 2024 at 4:36 PM CEST, Pratyush Yadav wrote:
> On Fri, Apr 12 2024, Michael Walle wrote:
>
> > SPI-NOR will automatically detect the attached flash device most of the
> > time. We cannot easily find out if boards are using a given flash.
> > Therefore, introduce a (temporary) flag to display a message on boot if
>
> Why temporary? There will always be a need to deprecate one flash or
> another. Might as well keep the flag around.

Mh, yes I agree. That also means that this flag will not have any
users (most) of the time (hopefully ;) ).

> Also, this patch/series does not add any users of the deprecated flag.
> If you have some flashes in mind, it would be good to add them to the
> patch/series.

This is just an RFC to see if whether you Tudor agree with me :) But
I was about to add it to the evervision/cypress FRAMs.

> I like the idea in general. Do you think we should also print a rough
> date for the deprecation as well?

Might make sense, any suggestions?

> > support for a given flash device is scheduled to be removed in the
> > future.
> >
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > ---
> >  drivers/mtd/spi-nor/core.c | 12 ++++++++++++
> >  drivers/mtd/spi-nor/core.h |  1 +
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 58d310427d35..a294eef2e34a 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -3312,6 +3312,7 @@ static const struct flash_info *spi_nor_get_flash=
_info(struct spi_nor *nor,
> >  						       const char *name)
> >  {
> >  	const struct flash_info *jinfo =3D NULL, *info =3D NULL;
> > +	const char *deprecated =3D NULL;
> > =20
> >  	if (name)
> >  		info =3D spi_nor_match_name(nor, name);
> > @@ -3326,6 +3327,17 @@ static const struct flash_info *spi_nor_get_flas=
h_info(struct spi_nor *nor,
> >  			return jinfo;
> >  	}
> > =20
> > +	if (info && (info->flags & SPI_NOR_DEPRECATED))
> > +		deprecated =3D info->name;
> > +	else if (jinfo && (jinfo->flags & SPI_NOR_DEPRECATED))
> > +		deprecated =3D jinfo->name;
> > +
> > +	if (deprecated)
> > +		pr_warn("Your board or device tree is using a SPI NOR flash (%s) wit=
h\n"
> > +			"deprecated driver support. It will be removed in future kernel\n"
>
> Nit: "removed in a future kernel version"
>
> > +			"version. If you feel this shouldn't be the case, please contact\n"
> > +			"us at linux-mtd@lists.infradead.org\n", deprecated);
> > +
>
> Hmm, this isn't so nice. I'd suggest doing something like:
>
> 	/*
>          * If caller has specified name of flash model that can normally =
be
>          * ...
>          */
> 	info =3D jinfo ?: info;
>
> 	if (info->flags & SPI_NOR_DEPRECATED)
>         	pr_warn(...);

Actually, I had that, *but* I was thinking we might only check the
detected flash and not the one specified in the device tree. But
thinking about that again, I guess it makes sense because:
 - that's the actually used flash driver
 - having jinfo !=3D info will print that other warning, thus this
   case is hopefully very unlikely.

>
> 	return info;
>
> >  	/*
> >  	 * If caller has specified name of flash model that can normally be
> >  	 * detected using JEDEC, let's verify it.
> > diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> > index 8552e31b1b07..0317d8e253f4 100644
> > --- a/drivers/mtd/spi-nor/core.h
> > +++ b/drivers/mtd/spi-nor/core.h
> > @@ -524,6 +524,7 @@ struct flash_info {
> >  #define SPI_NOR_NO_ERASE		BIT(6)
> >  #define SPI_NOR_QUAD_PP			BIT(8)
> >  #define SPI_NOR_RWW			BIT(9)
> > +#define SPI_NOR_DEPRECATED		BIT(15)
>
> If you do agree with my suggestion of making it permanent, would it make
> more sense to make it BIT(10) instead. Or BIT(9) once you move up the
> others because we no longer have BIT(7).

Or just BIT(7) and avoid any code churn :)

-michael

>
> > =20
> >  	u8 no_sfdp_flags;
> >  #define SPI_NOR_SKIP_SFDP		BIT(0)


--708fc41844f140b3d840031632678d0e44008df68536d14dad2e9ff8531b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZh/iOhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jTJwF+MfXaY0rJxf8esRAeR/YyzqP24TH0YPAh
rK75nCQk3ECO68GvG9Pk9Cj8/1uETtabAX97iBpwzQ1wB70yIGZin+I20ATWcX1W
hLecMdn8ML3b9cyRUNpKYaAxe2fUQLjZPZA=
=237x
-----END PGP SIGNATURE-----

--708fc41844f140b3d840031632678d0e44008df68536d14dad2e9ff8531b--

