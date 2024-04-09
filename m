Return-Path: <linux-kernel+bounces-136934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9117789DA15
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33FE1C2262C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3472712FB31;
	Tue,  9 Apr 2024 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nk/px9Li"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1612F5BD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668966; cv=none; b=CCQEwDDweqTXixMmdDV97HgvsAO/Th+2EAd4Wx2z2snacJMGe8k1cUZI7dVTsSLpiMn/7ZEBRQm4BP2/hvijrSFh0HIABHA7/pjAnohoqZQ9Ntr0Bodoyra95Z9PKsvASXoD+v5R/LpJ6ermBrrBhW6bw1i4d/ZebH333wf6yhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668966; c=relaxed/simple;
	bh=+qRpdfn6imp+KKjieABpdtfi/x/YK+WbMGLOebjohNk=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=VmCOhrXN9sciaPwRN/ckYa+ToOY2S+w05M9wPsO4r4FR1gzj+jn8G4x0Nyphbn80zv3o+EqvAzNHZ/wNbX5YjxtfyQcPtWW498art9QmZFC5kLKn1OceWkK0ZDq7d4j/6L//EXtW/1MmvpN4W0nKJ68P1+lT1Dkzxw/VtVQJpVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nk/px9Li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB7BC43399;
	Tue,  9 Apr 2024 13:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712668965;
	bh=+qRpdfn6imp+KKjieABpdtfi/x/YK+WbMGLOebjohNk=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=Nk/px9LiDpuUrGNWp4QUd2ZRpM8tUx7ILrgAPBox1vJaVZUta8bFvsx4oHja8ZamL
	 EOQUJ99W0uoHEIaJEkZWU3wOJ/XTmIcyPU2AhW39jw10Sgtdj//YlvGU+45G/rDd2P
	 AUXBqdDmR9UlFb/N5cG0iFTWkq2YsHmYAAZ4WfwlvXplSc4KBD4UbcZgZdErQMGnPN
	 AakX3AiO6eaWlHp19uTYSVVHWaipTGQz7wNx61qtFcHGUJnIGDJgXu0mRZHc5/onke
	 CInI7908qRJdFKCVNrjg3yvvl8+JhJGLVZvF0rYKApbmoUlmiUpXHdb/7nU3iKmEom
	 7/0nHOcmkAJyA==
Content-Type: multipart/signed;
 boundary=075ae5208db4a3d47fdbb558f3a42d323bc83d22469cd68f40760735a749;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 09 Apr 2024 15:22:00 +0200
Message-Id: <D0FMGOEWQC1O.30D61WTXL4087@kernel.org>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "FLAVIO SULIGOI" <f.suligoi@asem.it>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>
Subject: Re: EXTERNAL: Re: [PATCH 1/1] mtd: spi-nor: everspin: add em004lxb
 entry
X-Mailer: aerc 0.16.0
References: <20240405100104.480779-1-f.suligoi@asem.it>
 <20240405100104.480779-2-f.suligoi@asem.it>
 <D0C9NCOMI27O.2VW2U3FNFTSPK@kernel.org>
 <PH0PR22MB3789719A62A1EE483C9FDF76F9072@PH0PR22MB3789.namprd22.prod.outlook.com>
In-Reply-To: <
 <PH0PR22MB3789719A62A1EE483C9FDF76F9072@PH0PR22MB3789.namprd22.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--075ae5208db4a3d47fdbb558f3a42d323bc83d22469cd68f40760735a749
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue Apr 9, 2024 at 2:07 PM CEST, FLAVIO SULIGOI wrote:
> > On Fri Apr 5, 2024 at 12:01 PM CEST, Flavio Suligoi wrote:
> > > Add the Everspin EM0004LXB 4Mb (512KB) Industrial STT-MRAM Persistent
> > > Memory.
> > > This device is JEDEC compatible (JESD251 and JESD251-1), but it is no=
t
> > > able to provide SFDP information.
> >=20
> > Did you try the at25 driver if it will fit your usecase? Judging from
> > your last response, it sounds like it will do.
>
> Yes, you are right, it works with at25 driver!
> Thanks!

Good news :)

> At the moment I have to use a page size of 256 bytes, using "atmel,at25".
> Since the Everspin EM0004LXB MRAM doesn't have problem with any page size
> (theoretically I could use a single page size of 512KB), can I update the
> at25.c driver with a support for the EM0004LXB MRAM, as already done for
> the Cypress fm25 F-RAM?

Feel free to propose a patch. Keep in mind that it is another ML and
maintainer. Just use get_maintainer.pl. Keep me on CC if you like.

-michael

> >=20
> > >
> > > Link: https://www.everspin.com/file/158244/download
> > >
> > > Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> > > ---
> > >  drivers/mtd/spi-nor/everspin.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/mtd/spi-nor/everspin.c
> > > b/drivers/mtd/spi-nor/everspin.c index 5f321e24ae7d..4741930ce9a8
> > > 100644
> > > --- a/drivers/mtd/spi-nor/everspin.c
> > > +++ b/drivers/mtd/spi-nor/everspin.c
> > > @@ -31,6 +31,14 @@ static const struct flash_info everspin_nor_parts[=
]
> > =3D {
> > >  		.size =3D SZ_512K,
> > >  		.sector_size =3D SZ_512K,
> > >  		.flags =3D SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> > > +	}, {
> > > +		.id =3D SNOR_ID(0x6b, 0xbb, 0x13),
> > > +		.name =3D "em004lxb",
> > > +		.size =3D SZ_512K,
> > > +		.sector_size =3D SZ_512K,
> > > +		.flags =3D SPI_NOR_NO_ERASE | SPI_NOR_NO_FR | SPI_NOR_HAS_LOCK
> > |
> >=20
> > Will it also work without SPI_NOR_NO_ERASE? Also, the flash supports
> > fast read, so drop NO_FR. Also, please have a look at [1] for the
> > testing requirements.
> >=20
> > Thanks.
> > -michael
> >=20
> > > +			 SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6,
> > > +		.no_sfdp_flags =3D SPI_NOR_SKIP_SFDP,
> > >  	}
> > >  };
> > >
> >=20
> > [1] https://docs.kernel.org/driver-api/mtd/spi-nor.html
>
> Thanks and best regards,
> Flavio


--075ae5208db4a3d47fdbb558f3a42d323bc83d22469cd68f40760735a749
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZhVA+hIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/i8/AF/fD2dzcyQr3HGVxsEAOBduorhF05MB4hO
h5jZbHCSISsiRqqlasJnnSPViXGrm4OcAYDd7cDbdX1ItpPATVlsfP8dkRWSRju1
l3e0T4hfE1nZO4iUukBEDc9TS8dL0MTgMDw=
=HQCi
-----END PGP SIGNATURE-----

--075ae5208db4a3d47fdbb558f3a42d323bc83d22469cd68f40760735a749--

