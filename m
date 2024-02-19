Return-Path: <linux-kernel+bounces-71948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A740585ACE9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B861C23D25
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B7F537E9;
	Mon, 19 Feb 2024 20:15:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F9F535DC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373737; cv=none; b=cdeAX3vr+zf4ld5oh7z/3J40jJ5glI+zO0H55JERNHHWRPOe02BuQ2XMGtiVfBTW/P5YwxJLvaAw6Y2N4zCAgGglKBCEzhKR/UDMiP/JDElm7Y4YyTXzbJcFbDnJ25vX7KBiK2kLNjwq32zkgo5JG+5jx87SEFhy5Yn4fGX0Rsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373737; c=relaxed/simple;
	bh=Z0zoMA6BItC2WPeNFekvXIMWJ7fJdIN0623jFMu87Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c029PlbXYEgVLbnI87XA55ZQT2m2SsZp84aRoDxH9TaAo90E8lN/l46A2JM6xVswprY5JO+jAcaLMylwX/o1X8LQNrqjRfXx4i/vdAyLAyoGoRIPIkk8GpBXSPrnXAMqzzk0q94b6V6evnZSOSL9n9XocLSOu/v6/L7PeHjL+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcA31-0007Po-QD; Mon, 19 Feb 2024 21:15:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcA31-001iOx-1P; Mon, 19 Feb 2024 21:15:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcA30-0083tg-35;
	Mon, 19 Feb 2024 21:15:30 +0100
Date: Mon, 19 Feb 2024 21:15:30 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Thorsten Scherer <t.scherer@eckelmann.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] siox: constify the struct device_type usage
Message-ID: <pp757gcr2f4mw4hm73falxifiqghvwtnmvneyhqgxqlpsvw6po@hpfuqfrdwbo7>
References: <20240219-device_cleanup-siox-v1-1-eb32ca2b0113@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kgkvkqtj2ucxfnn2"
Content-Disposition: inline
In-Reply-To: <20240219-device_cleanup-siox-v1-1-eb32ca2b0113@marliere.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--kgkvkqtj2ucxfnn2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Feb 19, 2024 at 04:49:30PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> siox_device_type and siox_master_type variables to be constant structures
> as well, placing it into read-only memory which can not be modified at
> runtime.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

LGTM

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards and thanks,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kgkvkqtj2ucxfnn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXTtuEACgkQj4D7WH0S
/k4ODwf/dkIkmwjhfRXYcXVw6nnsdMbokJwpoTb9zqTbiVPOO6oGvg98UshJFWDq
lreApTIs9VCC7jq0lEUL/q5yaEURLhwkvVxYDOLcS7POOSSc4iRU+tRzC9nDcp0l
xZAuNJoLKHc0t+uJoSNhoIDTjmJC7aIPA/XIOFLdU/hXXg4DgrzTt/HXT5bq2kIn
ZJbdrJfS33jN180b2VHURHF3VD0Tuk5dwCMpJKzdiGWJrMmfzLXkhZsuqhNrbS7D
JbZB6crjoXZxnwHIxyvYZu6at/OUJGX7RJuESBQtKQ2JtaTZAepH+E2R8lI46cw8
xDBiDRcVvn2cWksZ8HIEbzFap10m6g==
=5Z/Y
-----END PGP SIGNATURE-----

--kgkvkqtj2ucxfnn2--

