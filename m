Return-Path: <linux-kernel+bounces-18562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC2C825F65
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5D6FB20E65
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 12:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B7E6FC9;
	Sat,  6 Jan 2024 12:09:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2E86FC3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM5Tn-00044i-Rv; Sat, 06 Jan 2024 13:08:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM5Tl-000nqO-Is; Sat, 06 Jan 2024 13:08:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM5Tl-00405a-1S;
	Sat, 06 Jan 2024 13:08:41 +0100
Date: Sat, 6 Jan 2024 13:08:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Arnd Bergmann <arnd@arndb.de>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Lubomir Rintel <lkundrak@v3.sk>, "zhang.songyi" <zhang.songyi@zte.com.cn>, soc@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC RESEND] soc: pxa: ssp: Cast to enum pxa_ssp_type
 instead of int
Message-ID: <ffwxkd53wb7kgmn5s3gbmujkzsiw3jhw5hohc6wpnxbfkcokj4@ysox2f4z7kcy>
References: <20240103210604.16877-1-duje.mihanovic@skole.hr>
 <rj7ijuyy47jrffi6sk7wikqo3rnutz2swkdrznyegalylacawz@jdncegf3elct>
 <2295d860-44cf-4816-8a1a-54274974302f@app.fastmail.com>
 <9215826.CDJkKcVGEf@radijator>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t25hjcghedybu66p"
Content-Disposition: inline
In-Reply-To: <9215826.CDJkKcVGEf@radijator>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--t25hjcghedybu66p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Duje,

On Thu, Jan 04, 2024 at 03:23:09PM +0100, Duje Mihanovi=C4=87 wrote:
> for v2 I will change the first cast to (uintptr_t) as Arnd suggested and =
drop=20
> the second cast completely as Uwe suggested.
>=20
> As a long-term solution (at least for this particular driver), the few PX=
A=20
> platforms and drivers still depending on or using this driver at first se=
em=20
> trivial to convert to pxa2xx-spi, while the navpoint driver seemingly cou=
ld be=20
> removed entirely as all boards using it have been removed. If there are n=
o=20
> objections I am willing to do this conversion.

In case you need encouragement: Sounds like a nice plan; no objections
=66rom my side.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--t25hjcghedybu66p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWZQrkACgkQj4D7WH0S
/k4zmgf/X/csmCXZWwLFGhiky+uKwTuiNGE8sP4UV2IM8S/JMyvWX0jU3ZQOBV6w
5ffuYJSltcwr+kQdsYl1ij/+8Kdff6iL9SvR3nZzkIeZZ9OhXibssspVm06H72Q1
IuXRyGDw+rkonfNLUQ/hu/DkK85f1X6jaAAONgQ2E0iALhE1Lk/4rmb9cJUp+uh/
+tbWIn0LWA6oTTxQn/r9ySWPAcwds+fB/pH7v59izw4mqYQeVSI5PEnfyqdXDuBc
LP6JGC1i6nZG985t2zGetlzis4nFEak85su5KZGLuUuOML2uxUu7TEXcWrg5ZqFa
ZlRsDkowKyz8CqruorKZm4AAHOyAPA==
=i8u6
-----END PGP SIGNATURE-----

--t25hjcghedybu66p--

