Return-Path: <linux-kernel+bounces-65710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BFA8550AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5742B27BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17456126F39;
	Wed, 14 Feb 2024 17:46:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78508662C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932766; cv=none; b=JlKBqloQB2WyMFPriCQzks3dIIRUsbJqycaqH7HpzwR3/KTtbFHEKjWNzKd6PQ5afzJM8SDPc0OLiJOxzPCb8pgllMKGf3EMinfkBdDwNRzmFp2/K09KMDIz93dtq1hK29EuJwbjft/+S5gjpRUTtCAhr5CTDtdqTFXlveiPbXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932766; c=relaxed/simple;
	bh=sI5Swyne6817j98cVC6PUtEHxqQJW9HXZohQNNTszDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfPIm0lGrwGRXJoGxb7KUwv4nD4GHeAH1j/LEptwSFKap9gmiIV0koYiYuA5AyagNIk282cs3Az/D+edwHmY758BQNWOrchgPeyakesFVLh13TeRnC2VUU0f97qZzZzGB/Ly67UpOVTc3ktp91dspqfDH9yFn9VEflZgj+btC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raJKP-0007ib-KX; Wed, 14 Feb 2024 18:45:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raJKO-000jXN-Ha; Wed, 14 Feb 2024 18:45:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raJKO-004sB0-1T;
	Wed, 14 Feb 2024 18:45:48 +0100
Date: Wed, 14 Feb 2024 18:45:48 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com, 
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] pwm: dwc: drop redundant error check
Message-ID: <cv6w4n2ptcdehn5n3mipuyfrtemm4rldhiyppazk4uqdn2xx7e@hxg4kldaacxk>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-2-raag.jadav@intel.com>
 <qrwcje4t2pbbxilnlfz2q7njodcp6vl54uaypdbvjgvwhgvc5g@4eq5wvumpjjx>
 <ZcUJoSMhgC7lhY-H@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xw3rpekb24aqhuyq"
Content-Disposition: inline
In-Reply-To: <ZcUJoSMhgC7lhY-H@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--xw3rpekb24aqhuyq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Thu, Feb 08, 2024 at 07:04:33PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 08, 2024 at 08:46:44AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Thu, Feb 08, 2024 at 12:35:25PM +0530, Raag Jadav wrote:
> > > pcim_iomap_table() fails only if pcim_iomap_regions() fails. No need =
to
> > > check for failure if the latter is already successful.
> >=20
> > Is this really true? pcim_iomap_table() calls devres_alloc_node() which
> > might fail if the allocation fails. (Yes, I know
> > https://lwn.net/Articles/627419/, but the rule is still to check for
> > errors, right?)
>=20
> We do not add a dead code to the kernel, right?
>=20
> > What am I missing?
>=20
> Mysterious ways of the twisted PCI devres code.
> Read the above commit message again :-)
>=20
> For your convenience I can elaborate. pcim_iomap_table() calls _first_
> devres_find() which _will_ succeed if the pcim_iomap_regions() previously
> succeeded. Does it help to understand how it designed?

I assume you're saying that after pcim_iomap_regions() succeeded it's
already known that pcim_iomap_table() succeeds (because the former
already called the latter).

I'm still concerned here. I agree that error checking might be skipped
if it's clear that no error can happen (the device cannot disappear
between these two calls, can it?), but for me as an uninitiated pci code
reader, I wonder about

	dwc->base =3D pcim_iomap_table(pci)[0];

without error checking. (OTOH, if pcim_iomap_table() returned NULL, the
"[0]" part is already problematic.)

I'd like to have a code comment here saying that pcim_iomap_table()
won't return NULL.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xw3rpekb24aqhuyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXM/EsACgkQj4D7WH0S
/k78egf/dDn9nn4BLih6G055QGhLbqDuDxNiv8SEOCeMKpkcP2uehRRw7OMYry/Y
dLo438AkmXBbING2wUOJp9LTKmVfbAGqF92dc03Bf7lSwujnBFbMQtmfWCHxbIq9
nVswyqoHhpC/regHzygPz0mud93LnMq62fvyhPQjy/21K39zKdqFEAClMlGM3EHY
Fa6Zmfz772eJUik2/YKlIvodH+hozuJKgTFCjU8AHbIMY7pf24EiDgpizNlXcb0i
n8nH2qSyr2iGcUSa/s9OHRa6wC6aZXLRP/FKwTn75v0Dyn9Qfs30FNke089e9v+T
EbAfarE9oFybsMXsxXLq58cYceVeMw==
=099/
-----END PGP SIGNATURE-----

--xw3rpekb24aqhuyq--

