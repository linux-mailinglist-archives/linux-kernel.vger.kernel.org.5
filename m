Return-Path: <linux-kernel+bounces-21447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B2828F33
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41BA2B2591B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44863E497;
	Tue,  9 Jan 2024 21:50:10 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052F13E464
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJz3-0001vm-5L; Tue, 09 Jan 2024 22:50:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJz2-001Z3k-Mt; Tue, 09 Jan 2024 22:50:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJz2-0066TS-1z;
	Tue, 09 Jan 2024 22:50:04 +0100
Date: Tue, 9 Jan 2024 22:50:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 4/7] Input: amimouse - convert to platform
 remove callback returning void
Message-ID: <qkb22czelncqf43vr2kuz6i6npuq4juyr3ggl3jkdbp6t2uzfs@ftbna3qj6qhq>
References: <20231226002649.7290-1-sashal@kernel.org>
 <20231226002649.7290-4-sashal@kernel.org>
 <ZZ0xt75z/qSf5f8V@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z4dqfcfoobhdzq6r"
Content-Disposition: inline
In-Reply-To: <ZZ0xt75z/qSf5f8V@duo.ucw.cz>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--z4dqfcfoobhdzq6r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 12:44:55PM +0100, Pavel Machek wrote:
> Hi!
>=20
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > [ Upstream commit 42b8ff47720258d1f6a4412e780a480c139773a0 ]
> >=20
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is ignored (apart
> > from emitting a warning) and this typically results in resource leaks.
> >=20
> > To improve here there is a quest to make the remove callback return
> > void. In the first step of this quest all drivers are converted to
> > .remove_new(), which already returns void. Eventually after all drivers
> > are converted, .remove_new() will be renamed to .remove().
> >=20
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
>=20
> We don't really need this for -stable.

Agreed! These patches shouldn't get backported to stable. Even if they
are a dependency (which isn't the case for this patch AFAICT),
backporting of later patches isn't hard even when dropping these
patches.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--z4dqfcfoobhdzq6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWdv4sACgkQj4D7WH0S
/k7Ikgf9Ff56k8gPg9Rqm0wNd4bcxm3xlWSN6sjrtlYtZ7hUFMbbo9GjjHFzwMS8
HxZm3aP5BMJx4BwkCGd01taCgJmANyrw6ZWZ9Um66my+592guOUVdEerXalMm9Yx
bI6UjPrHNcEm9LhVdBhuEM7vXI3pvIESsfgJX/gMpUCgCkFfqSJKRwsvfavZ5pnS
5SKkJ8LXgj9oMO7Kvehpyq71T6mLk7bhlz608Ns2euCY/plYxm8YYVtD0Y47wlhs
N7LIUDpK42CgAbCpP1pI9gfkAdxR2IwX7x5cPT05lHj2UV+J9ofwo+hxvWPwlkzq
ROZCoWdY52UhGFL4jRiZpnJ3VOnDjw==
=FCqt
-----END PGP SIGNATURE-----

--z4dqfcfoobhdzq6r--

