Return-Path: <linux-kernel+bounces-65712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4188550B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3AA1F2181D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916BC126F39;
	Wed, 14 Feb 2024 17:48:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFBB84A3E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932892; cv=none; b=CFcqc9fR06uK3LqSOr91LIlKGxtmYPN+F6iFq06ENPMZuNzWtuRsPOFC+NFNk7qjvdSmDFgxU1ECCLiVlX1dGhG8FKl1a06JnV22w8KMS7iq3MIWKaJh4zFzay82Yg2PHiv/h3qRqZnC7bkSRLody2aQkxTCJkPxVw6TNTPZkNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932892; c=relaxed/simple;
	bh=gbq9OzeNqFQNnrHsEb/+a49suHjbLpJ9oN3beT8rY+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KssDrmwQQfl50ZFK5L7MAn32XVAawEpofzJELSoXM5dELvPK3ZxNkcuplm6f9+bohHltC6I/vCFcaEY8Zy0cWJe7rRv/y5du9wHjAMZxjbQTYe+6nU70wjvEWQOZepbfYIXSyiO5dhuTWysMBOqJ2AJ78Fo4XWOsX++PYZ51AJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raJMX-0007oS-O2; Wed, 14 Feb 2024 18:48:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raJMW-000jXW-JA; Wed, 14 Feb 2024 18:48:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raJMW-004sDM-1f;
	Wed, 14 Feb 2024 18:48:00 +0100
Date: Wed, 14 Feb 2024 18:48:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Raag Jadav <raag.jadav@intel.com>
Cc: jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, lakshmi.sowjanya.d@intel.com, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] pwm: dwc: drop redundant error check
Message-ID: <en2sbqjmqvo5ka5l5wz4qgqmiv3ivjy7zsjtwc3cgi7nlcgkv7@kuammu3tbjez>
References: <20240212130247.9985-1-raag.jadav@intel.com>
 <20240212130247.9985-3-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fyfi2hhyykxly2x4"
Content-Disposition: inline
In-Reply-To: <20240212130247.9985-3-raag.jadav@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--fyfi2hhyykxly2x4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Feb 12, 2024 at 06:32:44PM +0530, Raag Jadav wrote:
> pcim_iomap_table() fails only if pcim_iomap_regions() fails. No need to
> check for failure if the latter is already successful.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/pwm-dwc.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> index a4a057ae03ea..b9e18dbf7493 100644
> --- a/drivers/pwm/pwm-dwc.c
> +++ b/drivers/pwm/pwm-dwc.c
> @@ -50,10 +50,6 @@ static int dwc_pwm_probe(struct pci_dev *pci, const st=
ruct pci_device_id *id)
>  	}
> =20
>  	dwc->base =3D pcim_iomap_table(pci)[0];
> -	if (!dwc->base) {
> -		dev_err(dev, "Base address missing\n");
> -		return -ENOMEM;
> -	}

As just written in reply to v2, I'd like to have a comment here saying
that pcim_iomap_table() won't fail after pcim_iomap_table() to prevent
someone sending a patch that undoes this change with the reasoning that
pcim_iomap_table()'s return value should be checked.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fyfi2hhyykxly2x4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXM/M8ACgkQj4D7WH0S
/k5eVwgAo8+fgjlPKlOVwdu4zufeEVTAJWo/ckkPRL12W2oWFVezhopw9ddhT6KI
A879ca/VmSc6GJjtLxClCi4cKtuCnKJ0cslZJt4uXIWXcPxSiuoQijspBLjHl2wo
I2V1dA7M23LXHsuhq+Goz9K2f6rAuLZ6oxHPARpNKBAZUcTdUp2Sz1rJ46lN9GBe
vnFwKTc0wgWn06bPkTKl7XUTwYLyoddbTxw5MIHLy0FsSwzq556tycMCm4bsLYwd
IAK2e78vsVgrK+q9QyfrivhiWxwVA47N5L3SG+8u1dYlBo2fXTv7/SQ9kTowykey
OS+oV7Zr8h+1BCBht5BT2FByeIhhqw==
=NEiF
-----END PGP SIGNATURE-----

--fyfi2hhyykxly2x4--

