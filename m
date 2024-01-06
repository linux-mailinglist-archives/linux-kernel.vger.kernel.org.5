Return-Path: <linux-kernel+bounces-18641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F2C826061
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2804FB22B03
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AB1F9F6;
	Sat,  6 Jan 2024 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="W4KlRPNK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E144FF516;
	Sat,  6 Jan 2024 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 3D16728B53B;
	Sat,  6 Jan 2024 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1704556974;
	bh=Cm940zKVyu6a9aez1H379JbaXjqxCkC1bSHDLSDNWZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W4KlRPNK6dqWpx+TR7mH+uYK5BgMn/lM9v7TO9syhA3mH4/I+em6EbPmbfBh1oxpN
	 n3kExN2INgg1tovd2GR34YbhOiepDDUDjfr9MyyaLGRqR13DGlX+RXI6Tw/6kht68p
	 Yxyljco9lHrzC31FTwSUEHxjIS4pKhOOfdl0ktoY=
Date: Sat, 6 Jan 2024 18:02:52 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 10/10] iio: pressure: mprls0025pa add SPI driver
Message-ID: <ZZl5rBPOKwvxZAAx@sunspire>
References: <20231229092445.30180-1-petre.rodan@subdimension.ro>
 <20231229092445.30180-11-petre.rodan@subdimension.ro>
 <ZZlyDT0J4n1_YXh4@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GAFEAXN8xuUBlkzd"
Content-Disposition: inline
In-Reply-To: <ZZlyDT0J4n1_YXh4@smile.fi.intel.com>


--GAFEAXN8xuUBlkzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello Andy,

On Sat, Jan 06, 2024 at 05:30:21PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 29, 2023 at 11:24:38AM +0200, Petre Rodan wrote:
> > Add SPI component of the driver.
>=20
> > Tested with mprls0015pa0000sa in spi mode on BeagleBone Black on
> > slightly patched 6.7.0-rc6 mainline.
>=20
> > Tested with mprls0025pa in i2c mode on BeagleBone Black with togreg
> > branch on
> > git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> > (tag: iio-for-6.8a)
>=20
> I believe these paragraphs can be moved to the patch submission comments =
=66rom
> the commit message...
>=20
> > Tested-by: Andreas Klinger <ak@it-klinger.de>
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > ---
> > v2 -> v3 removed iio.h include line
>=20
> ...somewhere here.
>=20
> ...
>=20
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/stddef.h>
>=20
> Basically here we need additionally these ones:
>=20
> device.h
> errno.h
> types.h

ok, I'll add errno.h. the other two are in the shared .h file.

cheers,
peter

> (I haven't checked i2c counterpart for the similarities).
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

--=20
petre rodan

--GAFEAXN8xuUBlkzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWZeagACgkQzyaZmYRO
fzA8tA/8CuTLOuHDKpjZ86++xEJoWwzqi22ttcVBzdZIfdmAKgZNGmCzBczvJG4I
uiPlhyI7MilWFYfjWx1uPRV3nkDc2iMOxNBwM9JzAE0kryEo3azaRfox2SnmkGVn
cFfV4b3O8UY+fqNGNEFu5bLoeztSnyYokstYUd8qoI3S0L1KTvpbkAUIa+aOionv
QIYvP1tadfogwWg4yYBiLDevJsB7VjdyYfVXHKca8EP8ubQC5xH0Tf2P+AaY8Hsl
VJXR2pGwy7CscpwpQm4K9T6IS2Xtuyzvmfz7I9nEuiS2obqFm6Gpk4+WS++gnQg9
lntd93DQFTPRVQbGCpoUZZ9/T/o9oWsB3yT14jRhFyaVngbzZugDya2Pq+uTs8ZW
fwieiYeZbybYCQOw0SHCQ06qdzTsWxHxkCuNmmL9/Q7CR6nwdSSPTZpzcocWvaBW
DFoGsHp2jWEfaovjW1Np5QeDUqhwPFC2J2+ydCfxs+Cxl9G/1ujOvLELSDEay3WH
IrAgPuPkrubg3AAwc84sb2kLIDjKlQwJlQ5+i3ea4KYfuR4cGB2YLcebXlZfECAe
7rehc4EiGCpR9VMrc57N8Or4dPqasfO3BHOqyKcqWeHJz7ITyRuCAXu4If4wIFuW
Gd+s/ov/RqFXv4F89RBgtyCkQvutJx5Ph4av+IrQTzJeMbuw3FA=
=xmDc
-----END PGP SIGNATURE-----

--GAFEAXN8xuUBlkzd--

