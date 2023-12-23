Return-Path: <linux-kernel+bounces-10391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2FB81D3C3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 12:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7A21C21B27
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8390BD262;
	Sat, 23 Dec 2023 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="CvsPqXcx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BDDCA48;
	Sat, 23 Dec 2023 11:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id DCC4C28B50B;
	Sat, 23 Dec 2023 11:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703330915;
	bh=tyq/SFLVFCfVcWDSy5Zz18uYm50FbtZ+D4ug29R/3hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CvsPqXcxb3B72bINV6ivnWd8tmJe0UYBCKVmSCtdv5Brqygcg7ery77N/yJPgiP/8
	 gvpXSUcSK2wzhn1UNFTTFODwiEc5KoHfgTogKRN0TrOkpoDhM48ERhW+nPWq2ApALE
	 q7OAPc8eenqaPo5BqDmCvbcq0ywxnI0MuChrdmpc=
Date: Sat, 23 Dec 2023 13:28:33 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: pressure: honeywell,mprls0025pa
Message-ID: <ZYbEYagM8qBf_cGB@sunspire>
References: <20231219130230.32584-1-petre.rodan@subdimension.ro>
 <20231219130230.32584-2-petre.rodan@subdimension.ro>
 <20231220151645.16ada807@jic23-huawei>
 <ZYMjhfAbWfw9vUdd@sunspire>
 <20231221110417.0bd5b002@jic23-huawei>
 <20231222-thread-secret-d8b49c896249@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4DK7OCvB3rAHTaK+"
Content-Disposition: inline
In-Reply-To: <20231222-thread-secret-d8b49c896249@spud>


--4DK7OCvB3rAHTaK+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello Conor,

On Fri, Dec 22, 2023 at 03:27:36PM +0000, Conor Dooley wrote:
> > >   - (honeywell,pmin-pascal && honeywell,pmax-pascal) || honeywell,pre=
ssure-triplet
> > Yes, it would end up something like that.  There are exclusive or examp=
les in tree.

> > oneOf:
> >   - required:
> >       - honeywell,pmin-pascal
> >       - honeywell,pmax-pascal
> >   - required:
> >       - honeywell,pressure-triplet
> >=20
> > but you will want to try all the cases to make sure that works (my abil=
ity to
> > figure these ones out is tricky).
> >=20
> > + you ideally want to exclude them all being set which is fiddlier.
> >=20
> > Some similar examples but they are based on a value in the property. I'=
m not
> > sure how you check for it just being defined.
> >=20
> > Something along lines of.
> >=20
> > allOf:
> >   - if:
> >       properties:
> >         honeywell,pressure-triplet
> >     then:
> >       properties:
> >         honeywell,pmin-pascal: false
> >         honeywell,pmax-pascal: false
> >=20
> > Might work?  I always end up trawling the kernel to find a similar exam=
ple for cases but
> > can't find anything closer right now.
>=20
> I hate to admit it, but I'm not great at expressing these in the minimum
> forms either, but I think you're missing a "required" from here, in place
> of the "properties":
> allOf:
>   - if:
>       required:
>         - honeywell,pressure-triplet
>     then:
>       properties:
>         honeywell,pmin-pascal: false
>         honeywell,pmax-pascal: false

thank you both for the above ruleset, it works like magic.

I spent hours trying to figure out the proper syntax but never got it right.

Merry Christmas!
peter

--4DK7OCvB3rAHTaK+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWGxGEACgkQzyaZmYRO
fzCbHhAA5ATXnLeJ2weA1puuj2nWSIT+NzkW7qN+YA8ah40jN0fhZ0RYu9YZHw4I
UiByARIqEs9WeXoGIztFpZUxQRyuH8yxnGzlmPIcN09HCHzIFGrvHiFdtCDgNTSb
koU9ri20O9Mi42GYBLLmTToE7HcW/nuJhf4S4UxmszR7YsNMtUIxpX6a48xz+9Go
++MnlvXi/1P4Xqv69QZmPPYLHakFSYoBWW0A6i9s1JlUa7Nhw3w1EU1Llaw9KxwD
xsrr2Q5obxn4vs0dAmJRD9pZQb7NOkTjXTJSfFLMMi0+nvxsZYNlgvBq+EhWNkqe
gKnzYMkKlsKKnwDL+6lCC+UCkastZQAYeSDbYQJ2TszU7+ibs5uNEhNjb1wey3RE
fJXQD/umNCD1phl85vNTF+KGW21zuGeI++DmPmkgXb03EkKZFcTVo0P6C086UzFv
X+SOSdJkwI+3HpdUWiqhCs7yj6Fbfn3SaY6D1DGok2jhtAEqvPQmfz19ynzz9cR4
uVLtrEftuL87U2+xz7efp4ilq5K//wpOCgZxn/Kkzb5ApOpiALcobVw4KTCIQ0q8
+GpGNXSQBGaDezMaEnC07u4/LcaFRuDue5uEgfJz5vnb7k6aukB5ii4eH0pjDh0E
/rtmJWzKiZiVE84E2p5QZjjSp3AmV6lzn8+DcA5qySn0d0fBPa0=
=gFxs
-----END PGP SIGNATURE-----

--4DK7OCvB3rAHTaK+--

