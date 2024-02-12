Return-Path: <linux-kernel+bounces-61142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F511850DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346931F27D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253D32B9DF;
	Mon, 12 Feb 2024 07:15:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA12B9D9
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722102; cv=none; b=vE/rzkDS50oqyqQTa4rTI+sOeEYqikTHw4WMOK+Xu2Ca1ADpyIokcXKLVmDLXmJ1Og3K5J8T8RcOk1TYdp6KKmkPs9y0EkBuIvhnDmEoS3Jk2+lATl9x5VgkSjZpQMbDty7ZW4yWak5sBZtycZH8fY4pLorSdcpogtvSIEn56xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722102; c=relaxed/simple;
	bh=jYjodvYdPgaA2R6RTwlHo99I3LADJFhgrLfeHWg5EAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrp+dd9gygtRD0fJKjjXTJHIanQXu4FVivzic7X/A8gUelON+Cjczmuy2e0qFXtR0XLIyeSvkyU8jm0+KKtPhxDoVztrBzOBtgdgqYRdSjsBa0+BVKnRTCiKnXTso2kC1DP3Sjn03VcpH8tFI2hX0ETAdNa82FPkIwu37bjnAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZQWU-0003cF-7C; Mon, 12 Feb 2024 08:14:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZQWT-000EsZ-1a; Mon, 12 Feb 2024 08:14:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZQWS-002wvz-37;
	Mon, 12 Feb 2024 08:14:36 +0100
Date: Mon, 12 Feb 2024 08:14:36 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Raag Jadav <raag.jadav@intel.com>
Cc: jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] LPSS PWM cleanups
Message-ID: <lfenqtr2hgjfisn6x6gffme55htmt3o6cbdiroilwanm52zyvs@frlnph7kkwg7>
References: <20240212061037.4271-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7dxxvd6dgm2rpgvr"
Content-Disposition: inline
In-Reply-To: <20240212061037.4271-1-raag.jadav@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--7dxxvd6dgm2rpgvr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Feb 12, 2024 at 11:40:35AM +0530, Raag Jadav wrote:
> This series implements minor cleanups for LPSS PWM driver.
>=20
> Raag Jadav (2):
>   pwm: lpss: use devm_pm_runtime_enable() helper
>   pwm: lpss: drop redundant runtime PM handles
>=20
>  drivers/pwm/pwm-lpss-pci.c      | 22 ----------------------
>  drivers/pwm/pwm-lpss-platform.c | 10 +---------
>  2 files changed, 1 insertion(+), 31 deletions(-)

the series looks fine to me. Will give others some more time to comment
and apply later.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7dxxvd6dgm2rpgvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXJxVsACgkQj4D7WH0S
/k6Qewf8D2r0SZoTgNIPbAgqzXZmkWt05MDzsZuccY6QBwKTpI997AoIWkBIqYtT
5Q758V6bxBOV9OE092c/Xv3ZkTWS1BYQ+rM8ZPvzFlvaLFuIrAo4NrXW1UJAZFF6
9iAOJ1JpcAOwHcQgSdGS8A7Ji4h/xKwVuQXx+BMV7k6JFq7gM4v+Wdqc0JjBFO0D
hQYNPHUdvu4OQqoeMe0tsNg3P616uXxWERVEk64bJzOAxRYBsVROmPvWowhmbTaR
LC92Xoqq01FKtg7Y80HGxkd9HSDHHL906WlbJ08S8bwwd/CLA5/c0Jq1qeoXbPH8
RT5V8q0Ly7Le9sPGwVb26OkpiKX0Vg==
=Y5op
-----END PGP SIGNATURE-----

--7dxxvd6dgm2rpgvr--

