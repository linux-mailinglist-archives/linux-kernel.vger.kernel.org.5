Return-Path: <linux-kernel+bounces-95877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C794A875465
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702161F239FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F812FF96;
	Thu,  7 Mar 2024 16:44:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70FF12FF6B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829845; cv=none; b=nDMI/PfMdn2PlDAI2Y0W/f9b0GuzIfsLbXd8brDRyrfeYFEoG+8udBb3bfZiNE4EuEdkNp1iSATj+Vqc9yPu4VZ2kPMpkUP9iTI7FqNMNEXFotN2yjABwoDvPn1Z5xnOkws3QP8/Z/3MVGpU2pFc75Wm90lsCQTWaysMjAVBhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829845; c=relaxed/simple;
	bh=QQAB0S3fJ+hrqfJ/WvLMvQROvWq80E50ppjocV13zYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcvEdY5O39fyOm8Q4fEqmHuceBsTVihd6XBMVvCuY/9E/m+W6NBPKSdLRyvb4yn46NUNTVj/5f7hjCkzIsdCu1vVHg5E66W8h2se0myQshDbG9ZUZnphFULmZekSjs9CEpk3njCogMPOiNLictF6RLPYjpZsueJq1JR5waL5UNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riGqg-0008SS-08; Thu, 07 Mar 2024 17:44:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riGqf-004yh8-0H; Thu, 07 Mar 2024 17:44:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riGqe-001Ovv-30;
	Thu, 07 Mar 2024 17:44:00 +0100
Date: Thu, 7 Mar 2024 17:44:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v1 4/5] w1: gpio: Remove duplicate NULL checks
Message-ID: <kwn22fq6e4pmaan2x4irvjbykropwvrcz7d547ydrnz3ssehxv@2tr6pvvbrlyz>
References: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
 <20240307143644.3787260-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="htvmaear7d4brykf"
Content-Disposition: inline
In-Reply-To: <20240307143644.3787260-5-andriy.shevchenko@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--htvmaear7d4brykf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 04:35:50PM +0200, Andy Shevchenko wrote:
> gpiod_set_value() is NULL-aware, no need to check that in the caller.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/w1/masters/w1-gpio.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
> index 3881f2eaed2f..8fd9fedd8c56 100644
> --- a/drivers/w1/masters/w1-gpio.c
> +++ b/drivers/w1/masters/w1-gpio.c
> @@ -117,8 +117,7 @@ static int w1_gpio_probe(struct platform_device *pdev)
>  	if (err)
>  		return dev_err_probe(dev, err, "w1_add_master device failed\n");
> =20
> -	if (ddata->pullup_gpiod)
> -		gpiod_set_value(ddata->pullup_gpiod, 1);
> +	gpiod_set_value(ddata->pullup_gpiod, 1);
> =20
>  	platform_set_drvdata(pdev, master);
> =20
> @@ -130,8 +129,7 @@ static void w1_gpio_remove(struct platform_device *pd=
ev)
>  	struct w1_bus_master *master =3D platform_get_drvdata(pdev);
>  	struct w1_gpio_ddata *ddata =3D master->data;
> =20
> -	if (ddata->pullup_gpiod)
> -		gpiod_set_value(ddata->pullup_gpiod, 0);
> +	gpiod_set_value(ddata->pullup_gpiod, 0);

This also has the advantage to not have to know that NULL is the dummy
value returned by the gpiod_get_optional() family of functions.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--htvmaear7d4brykf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXp7s8ACgkQj4D7WH0S
/k5H2Qf/Xf21WLfMVTOIbH9Ug/45AG+HXZAC5SplkjhLSl7UR1I6smE/wDeLGmOg
UMS6kvrUfU6e20aXejNnt6qUuKFGHys3dccXRpyv1cjSDeNx9zFaitLopqWcl6eZ
V18zE3rXuWBZralnT+CNFEcxGcTvrMBHHIYQRRkz1E8Ln6dY6bKVtYtFIU+npbhp
lkNJPqa0x+gHFpUhIlkbX76/xOFK9pwotmZiW3xqRTlv4DyGnbJbYjO9T3mMxPUd
M3Jm6bZJlFkIkQQVREbF42uxws7SEcsoIPucPTW/9jPJuoSnwKf5LXrD98xcQPla
cJonaj3slqhdrgX7i4KQETu4TRxmKw==
=Wy13
-----END PGP SIGNATURE-----

--htvmaear7d4brykf--

