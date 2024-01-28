Return-Path: <linux-kernel+bounces-41838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA5A83F856
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE43282978
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846562E859;
	Sun, 28 Jan 2024 16:58:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B272E834
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706461132; cv=none; b=TmR+81WP9OqP/LzseML8ZdrEbMBhvReXDpNW4xoFRCsCjQRvzozWOEuAWniDM70+V4HF3o6GPjtii4ZrCFvEuBdVu1eXCmA4LI239gxX9BUaGWCxoaQgrF2ssZbbcilOxvKWQ+OqOX1bDMB0bM0ZsXXXK1KSCwnjG8xTbnLDEYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706461132; c=relaxed/simple;
	bh=tS1E/qQYkSQDoMFRMaQZJxtUcksskFokiqe+iIG/bSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spOG8EHVAhUzRc4sgjiq9mDUN9fJyph8X283RRGKjxEmEOww0VN2+W60E0F1Pbdx6EerFdAUBU9CZb8XDqEzMhIm2g3FYeVgYIeikCidVDIyFAgRCsCggcoimywTAR2jtC1pHcnUk1mmNbbE/I2s7T5x79LzgvS2N6azNNVA6Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rU8UR-0003As-S0; Sun, 28 Jan 2024 17:58:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rU8UQ-002z9m-RT; Sun, 28 Jan 2024 17:58:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rU8UQ-00AHAA-2U;
	Sun, 28 Jan 2024 17:58:38 +0100
Date: Sun, 28 Jan 2024 17:58:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com, 
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] pwm: dwc: simplify error handling
Message-ID: <r6vulwv76x7ydkmszlwlswjve7y2pmasz77wkqub73qopd5src@y3ta72owtw5b>
References: <20240122030238.29437-1-raag.jadav@intel.com>
 <20240122030238.29437-3-raag.jadav@intel.com>
 <ZbZpMO9b7L-DNIcb@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4vfzke46slaro6ed"
Content-Disposition: inline
In-Reply-To: <ZbZpMO9b7L-DNIcb@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--4vfzke46slaro6ed
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Jan 28, 2024 at 04:48:16PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 22, 2024 at 08:32:37AM +0530, Raag Jadav wrote:
> > Simplify error handling in ->probe() function using dev_err_probe() hel=
per.
>=20
> ...
>=20
> >  	ret =3D pcim_iomap_regions(pci, BIT(0), pci_name(pci));
> > -	if (ret) {
> > -		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to iomap PCI BAR (%pe)\n", ER=
R_PTR(ret));
> > =20
> >  	base =3D pcim_iomap_table(pci)[0];
>=20
> > -	if (!base) {
> > -		dev_err(dev, "Base address missing\n");
> > -		return -ENOMEM;
> > -	}
> > +	if (!base)
> > +		return dev_err_probe(dev, -ENOMEM, "Base address missing\n");
>=20
> This check is bogus. Just remove it completely.

This would be a separate patch though. IMHO mechanically converting to
dev_err_probe() is fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4vfzke46slaro6ed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmW2h7gACgkQj4D7WH0S
/k7MpggAoa8e8OxiEWhR+vVyUOs0kgmdMkXRNj2a6v+Rorm2yFeWHT1q6R/snxrN
fLGDycNB+K9ApjaSUvs3moSkWQ0z2ZTkWHQozQjABA61pYSLy5ZR9sZmm0pjuZyX
b/mQ0nyhb+HLQQOg2y1AaRS/0PR4GuytagNjjYULCQEYN81fZvEnJ/VKKZGMgGGq
qrLRjp8WnOR/wiKM8bwUuHtYrjUCIwtd3WlH2a/88qOjiuGjSd3fT7Jnkyb5PUXk
VunvmyyirBt0FM1QVdkGzECfsnpkgFSXLThZ3/va10AKd6VRBNugGnHJ5oWUkPkY
FRCBzUaZIH6nZvk1hMyJA416f/ppLg==
=QQyq
-----END PGP SIGNATURE-----

--4vfzke46slaro6ed--

