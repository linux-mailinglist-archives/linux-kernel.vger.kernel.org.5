Return-Path: <linux-kernel+bounces-21857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9C1829551
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43711286407
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB7538DC8;
	Wed, 10 Jan 2024 08:41:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1E033CFD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNU9r-0002o7-Cf; Wed, 10 Jan 2024 09:41:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNU9q-001f73-MA; Wed, 10 Jan 2024 09:41:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNU9q-006NVE-1u;
	Wed, 10 Jan 2024 09:41:54 +0100
Date: Wed, 10 Jan 2024 09:41:54 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] intel_th: Convert to platform remove callback
 returning void
Message-ID: <i3oybmf3axeyk5rcef5kgfdb4cucd63h24gup6idn62nq3vvav@4mfzwzyamq27>
References: <20231107202818.4005791-1-u.kleine-koenig@pengutronix.de>
 <20231107202818.4005791-8-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="udfj5iy5oa67vvel"
Content-Disposition: inline
In-Reply-To: <20231107202818.4005791-8-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--udfj5iy5oa67vvel
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Nov 07, 2023 at 09:28:26PM +0100, Uwe Kleine-K=F6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I didn't get any feedback to this patch and it didn't make it into next
up to now.

Is this still on someone's radar?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--udfj5iy5oa67vvel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWeWFEACgkQj4D7WH0S
/k7UWgf/RLMfq+wxJ+Cwqxm4qXNH66VIuLfGOSBYDNSfDJpyT2Wf9H7bemLV4LcN
CvsLLgTdjsBNFXZulOfPQ6PQB5y/pInYMkCBdIMHCehuo4t/ukAbngWwmhPgdEsY
HG2RvnS5P+AWmqJpM+VU3yrtq0em0uC4eO1GZEjO/QpNi52k5f9uqlNw8GB9QIdM
icVuI1ou184sbALt5o1BwexrNQuLbqdeGhjBicUtECV7HMKhpWIq+D3ghjNX6UoN
k0uEFfH4pr+TogOqLobsnFY09Ymx9FELzBX0jR+BZGOBx6eO0/v7Zu7O8UVrkxzl
nlDWQAH4Mb+o9LjvsIt8lrz1gWokkg==
=qTc0
-----END PGP SIGNATURE-----

--udfj5iy5oa67vvel--

