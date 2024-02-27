Return-Path: <linux-kernel+bounces-83340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779AA869398
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98891C21650
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49F4145FF7;
	Tue, 27 Feb 2024 13:45:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC5B13EFE4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041520; cv=none; b=Thets2FF3UhvYlbehICEfEZTl+tB5X8l7Tu+HdgnY8/c1Kiesbi+X4sW6AWy9UmtA8ckg9P9x/xyU4EXcvxASD3fKpAx86ZXRw0FdRvIfqedx/bPH2ClQOlTyL9jzfO7blMG7BmfrJwqZNIzf82v4P0JibPzccYhAd6Pqd8hnfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041520; c=relaxed/simple;
	bh=PIwYmxG2bDPFx++cGth9sKMgFxaV4tPHXAtj57WGleE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB3kB6shX0Ld7WaGZAsa5Xd8wxoEleWJ475C32T4sMVtMzI3dQF9ZCz+6FoNMviWmd9NCVfQxTlSha9ZUlHX9wUqFThOK1DPybIDKRLtxUMm/e9JFkq27xeGDJI/ju+jr9Ydqe7rAULSz4ufnazLzsN87VO5IBN5fDPsfUL6Y2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rexlc-0005Mc-Hg; Tue, 27 Feb 2024 14:45:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rexlZ-003D8k-Q8; Tue, 27 Feb 2024 14:45:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rexlZ-00CTvu-2I;
	Tue, 27 Feb 2024 14:45:05 +0100
Date: Tue, 27 Feb 2024 14:45:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, kernel test robot <lkp@intel.com>, 
	Stephen Warren <swarren@wwwdotorg.org>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, kernel@pengutronix.de, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/3] spi: ppc4xx: Fix fallout from rename in struct
 spi_bitbang
Message-ID: <6nqpvqodqhk5vwwqgdez2lwsdlh4xrzfstkaf7o2mjz46ub2xf@zjacuzux5jdm>
References: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
 <20240210164006.208149-7-u.kleine-koenig@pengutronix.de>
 <y2my7hxrpnwg72ols6a5w7n6zqz2yaxtswq4zlv6xpguiyaunm@tguc7ua3ypa5>
 <76fcc5ec-0180-4f75-aaac-5ae74f2f687a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iqcog6wdvmi5qjne"
Content-Disposition: inline
In-Reply-To: <76fcc5ec-0180-4f75-aaac-5ae74f2f687a@sirena.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--iqcog6wdvmi5qjne
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Feb 27, 2024 at 12:50:15PM +0000, Mark Brown wrote:
> On Tue, Feb 27, 2024 at 08:23:06AM +0100, Uwe Kleine-K=F6nig wrote:
>=20
> > Assuming we don't want to have this problem in v6.8, I suggest to revert
> > de4af897ddf2 and reapply it on top of your next branch.
>=20
> BTW the issue here is that you sent this without comment in the middle
> of a series of fixes the other two of which *do* apply to mainline,
> ideally it would have just been sent separately since it needs to go
> separately but if you *are* going to send a single series like this
> things that are -next only should go after any fixes that are for
> mainline.

I expected that adding Fixes lines is enough documentation but I agree
that in retrospect it would have been a good idea to mention the
expected target branch for each patch. I'm willing to take half of the
blame you assigned me as in retrospect double checking the Fixes lines
or doing a compile test of the ppc4xx driver would also have been a good
idea for you as maintainer applying the patches. Sorry for my
contribution to this problem. I only looked at next when I sent the
patches and wasn't aware of the trip wire that git applies patch 2 just
fine to mainline though it's not right to put it there.

I ordered patch 3 at the end because I didn't consider this an urgent
fix as it only addresses a W=3D1 warning that we lived with for over 10
years since v3.11-rc1.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--iqcog6wdvmi5qjne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXd52AACgkQj4D7WH0S
/k451Qf/a7kLmcIlWsKBRYXJmSPkhYsGW8ps8c3C6Lrn7GxLAP6GVOPWYMQYF0Aq
kCZ9MlEV0X1P21+7Jv/mTAOxGF8toa95j9rzaq/iB9aGyriH6CeMwYW9ABbXbRkK
0w8M5s9onPdansOiLZ3kP7H1Y9JshIgXW9i6qrtFJULeDfourl41rJDYsLZdp6KP
lkae1J18STzFvi4mH2lAbMxYtxX38pv+jZBk722zBmN0EsIkZwv4cQxSzrEwmwos
DuAgFcjjw84iLhRBHW3T6n1FEYbisrdVnUdFuXY/0WUIcO8hvtoW+Qaqghzwe4X2
Rol1c3SjKcGcxr82TKUe814ScDZoFA==
=pDHU
-----END PGP SIGNATURE-----

--iqcog6wdvmi5qjne--

