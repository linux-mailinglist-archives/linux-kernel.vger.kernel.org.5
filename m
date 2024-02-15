Return-Path: <linux-kernel+bounces-66775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ABD85622D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892CDB33E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0733266B2D;
	Thu, 15 Feb 2024 11:22:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8412AAD6
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996144; cv=none; b=XAJsZoOgw3Wqq65Cud6g0RRTnV5shx+JAls5a76NuENCBRktNjrcRHdddi2qKSpWFtdIftn/rngYqoF9ZSgJ3bI/scvj37fl/f2u8FbuyFwuaC2oaFFRHd5SN4iHPxAMY//mGGFd7uHdX6HWB+GbpwSovo5qQaigVUy6uIi8U/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996144; c=relaxed/simple;
	bh=5RKXK0hIlzu262wvQm75qMwY5I/ynr7mQARLW1k95SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwcRC993wggkKDaWP1zt0Ak9J/GgOk4m1gtGlXRY5nZjGskyLr4LC9Jj2524L2cJK04DKIao7QMC8Y63KG3JlbmwEoagt4bVn2csY/br/HbFvjzkb5qU1+3s8Onhw8zyOJkRb/4qLf577Fjb4VzMJWquoyJwN7Yb8gkLzMVnwWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raZoe-0005Tg-M0; Thu, 15 Feb 2024 12:22:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raZod-000sCX-KM; Thu, 15 Feb 2024 12:22:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raZod-005Jhr-1m;
	Thu, 15 Feb 2024 12:22:07 +0100
Date: Thu, 15 Feb 2024 12:22:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com, 
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] pwm: dwc: use pm_sleep_ptr() macro
Message-ID: <axs5jwmdhy2jvwd4fockqrvfovt63dhda7j6ycnfiniuti3pla@nec4frzkz7sy>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-6-raag.jadav@intel.com>
 <ZcUN7NHCSEXnezV5@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bjchzwokfu3guau4"
Content-Disposition: inline
In-Reply-To: <ZcUN7NHCSEXnezV5@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--bjchzwokfu3guau4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 07:22:52PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 08, 2024 at 12:35:29PM +0530, Raag Jadav wrote:
> > Since we don't have runtime PM handles here, we should be using
> > pm_sleep_ptr() macro, so that the compiler can discard it in case
> > CONFIG_PM_SLEEP=3Dn.
>=20
> > Fixes: 30b5b066fa83 ("pwm: dwc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM fun=
ctions")
>=20
> Fixes always should go first in the series.

No need to resend for that, I'll pick patches 3-5 in the order I
consider sensible. Git seems to handle that just fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bjchzwokfu3guau4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXN89kACgkQj4D7WH0S
/k4chAf/c5Or+e8igwG0Ph+pa0zzEdy04Bu0S5b2eHJ6f611RvIBFNN79rshlLG2
UKFy9VI4DnfNl8lbVWuF7wAm5Fny2+SCxpG9HJcWof4+Z7LsG/uKij6tPKkk/hUR
bvQy9Z9K9GUesHmhayKzluQWiZOTBVchKOZUqiybkFROt3L9O5QxQqF+Twh7fhg2
qgPYyrCAoqam8I1/hf6QuXPWFdmw4Dn9a8d3C7nMP59IYuHPoClKznMYLc07VX69
Pi4sDA7aiPJS5rvwV3UU8yFHwlajiBhV+jUCpjXdO2p+LA9xE0IuTuYTaAWuSIhI
pYFo1f/Wxv9ZVGxu0TMAefMD6+Q/ZA==
=BeX8
-----END PGP SIGNATURE-----

--bjchzwokfu3guau4--

