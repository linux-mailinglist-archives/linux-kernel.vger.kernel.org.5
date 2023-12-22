Return-Path: <linux-kernel+bounces-9622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F6D81C89A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEAD1C220A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC56156D0;
	Fri, 22 Dec 2023 10:56:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E79B14A86
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGdCj-0005fg-LG; Fri, 22 Dec 2023 11:56:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGdCi-000jdA-4V; Fri, 22 Dec 2023 11:56:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGdCi-001cvs-UV; Fri, 22 Dec 2023 11:56:32 +0100
Date: Fri, 22 Dec 2023 11:56:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Young <sean@mess.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: bcm2835: Duplicate call to clk_rate_exclusive_put
 in error path
Message-ID: <jtcp45zfijjc5kfikph4wuhnkqrnm5ncs6hte3romefm33k3q4@7gyzfb42eglg>
References: <20231222104651.167821-1-sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ymvhpr45gntygozu"
Content-Disposition: inline
In-Reply-To: <20231222104651.167821-1-sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ymvhpr45gntygozu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

thanks for the quick fix. I'd do s/Duplicate/Deduplicate/ in the
Subject (+ maybe s/clk_rate_exclusive_put/clk_rate_exclusive_put()/)

Apart from that:

Fixes: fcc760729359 ("pwm: bcm2835: Allow PWM driver to be used in atomic c=
ontext")
Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ymvhpr45gntygozu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWFa18ACgkQj4D7WH0S
/k7Xbgf/a1YUNux/6jBZFIIhabIw0fHf+Lk++m/rjPAVFXCfWWkZS+V9C+JZDUNu
Nd7N8cJAxGdqzGyDpga6r3bah1a/27ecveoW3bYMPE1GhvlM4SZ6D7qRVq8iuTyP
s4knMtScW2mwkwblJJxfWKuGky3VjksZlRlA0lnz+VInkP1YYkwnaFVMxkwBp/0v
8Q/wjyjMZ9+rKa5CmIYAWEu8m/3kFJrI0G5yh7Y7UESQMY3Bl0Xk0mQhdt9+I/T7
UIjZM2cxCkS4Yrmbt9OzEaFHw1ed/TNZVy3PO30SFynuOBp7f2Lf0ha6LndmxT9z
svsD5o137K4hxbG2pL/2s2/mJt53iA==
=DdMv
-----END PGP SIGNATURE-----

--ymvhpr45gntygozu--

