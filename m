Return-Path: <linux-kernel+bounces-52229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31E38495B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3171B281D5F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCC611709;
	Mon,  5 Feb 2024 08:52:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C9125BD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123151; cv=none; b=RVWR6P9mHfJqLJyXFzFpURNRfIzPwaX2q1FhueGr51rx3F8oXVi56YXuH3cZeH4TsqrLyDj88kM6gHJpY05XdxDLNCywh5K8XHGLuqzxvk8D69dkFbHicKauW5ukSBw5n9nMXiC9/IEkaCTJ86W/s1Luc8Eg5alKIqeBRpPH1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123151; c=relaxed/simple;
	bh=z6Epayz1tOcpz+3gfltgUKvNaXWy8D661ASGS9zd1ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPC9+SZzhZo0HTCj/fEsNHdTOlwc2cO3zxF417oF/W9dbpDWR6z6/rVYpkw5kwx4o9J5Ey/eusHosHoFtaJiPXklP/aaq7AuOjmIcWIdUaDvjJyaeGVQ04WCKNPxLefVBxNR8eEdKTXLugx04FCDx5FJFk6nCndrszk+RIco8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rWui1-0006XC-2E; Mon, 05 Feb 2024 09:52:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rWuhy-004b03-Ir; Mon, 05 Feb 2024 09:52:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rWuhy-00FJOK-1Y;
	Mon, 05 Feb 2024 09:52:06 +0100
Date: Mon, 5 Feb 2024 09:52:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: nikita.shubin@maquefel.me
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"Wu, Aaron" <Aaron.Wu@analog.com>, Olof Johansson <olof@lixom.net>, Lee Jones <lee@kernel.org>, 
	Ralf Baechle <ralf@linux-mips.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7 01/39] ARM: ep93xx: Add terminator to
 gpiod_lookup_table
Message-ID: <way2lxzhgnjjq4dnjucivo3aj2egnmtikgvtijbh65rkqnctta@ubtgdncaequj>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
 <20240118-ep93xx-v7-1-d953846ae771@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ovf72isauvchnuy"
Content-Disposition: inline
In-Reply-To: <20240118-ep93xx-v7-1-d953846ae771@maquefel.me>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--7ovf72isauvchnuy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:20:44AM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Without the terminator, if a con_id is passed to gpio_find() that
> does not exist in the lookup table the function will not stop looping
> correctly, and eventually cause an oops.
>=20
> Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
> Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

I don't know how's the state of the series and when it's expected to go
in. Given this is a fix preventing a possible oops, I wonder if this one
should be taken already now?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7ovf72isauvchnuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXAobUACgkQj4D7WH0S
/k6YKgf/RUb6y3qz+P2M7qmL+0qiW0Y6MYeoiydzAnyQlCyum3uAMBOQGMEI2cNv
tB1ZcAv4Aic8cOVKu7+BR/c5dbcGQho/KMZ/MxMh3PS4cjQRFcqhT5sKExuXvOMD
3QyrcaWv5F6dK9kmStjVHTatl/xmGa8zu0cxTknaE3viSQdQ4DBYnZmUMkq2P/s4
hnsoRGDq2ZvH0uvrT9ZwCPb4HDhW4KLKoqxc4HyrkxEyxglwiZv+6mn0AO3Ak25k
+8Qjr6ANFGKufCUTA24WrWlfDTQZvaAtYYOa/XdBzrIzSYrdSmU03xoFc7l6pdSl
0sJgFjwcD8/XG9dbkwwAqz5z8YVmYg==
=Xity
-----END PGP SIGNATURE-----

--7ovf72isauvchnuy--

