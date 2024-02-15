Return-Path: <linux-kernel+bounces-66523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72BD855E29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 007A6B30908
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984F11B959;
	Thu, 15 Feb 2024 09:23:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA891B950
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988996; cv=none; b=NM03kpDoBBLpKZMwR9I2huBzUw/OgQjVojXvnaMcFU68hP4lbTgNGgtajhLgV4DoD00zcStfn4K+7cPhlXP/fiEyY7bPjzS442HfSkGkvpgrFZ4O3n09qv5iOOOSTGZ12KEL6DiGIv3DREJbMZ6conJAxynKt6LV8AJ8BJ/WIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988996; c=relaxed/simple;
	bh=jE1rZpY3SjNM/hr3FU2idYQaRSA7hffibi3C0fZZNdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G10In9od4pBtniUp1QxRCICvLFTNIyn8WH9eYrWIFp+36uIojdOs7TB6wSL5sBOJacVXoGkEjoDhwz/aNUTkTXuvI3MWe3L5Jne5qB5mbSqK9EQQnGS4N39fyzmIe7SL/2DuYjlgBRl1NqNgIEcdXzo5xYq+MUXaiO8UAuv3C0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raXxK-0001b0-QJ; Thu, 15 Feb 2024 10:22:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raXxJ-000r6J-Bz; Thu, 15 Feb 2024 10:22:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raXxJ-005Gfg-0v;
	Thu, 15 Feb 2024 10:22:57 +0100
Date: Thu, 15 Feb 2024 10:22:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com, 
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] pwm: dwc: drop redundant error check
Message-ID: <sd2ugzjrmrdvcyxotoyg53qp3i7ta4yko225ln3gk4fmik7iof@a7mab6o2kkvz>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-2-raag.jadav@intel.com>
 <qrwcje4t2pbbxilnlfz2q7njodcp6vl54uaypdbvjgvwhgvc5g@4eq5wvumpjjx>
 <ZcUJoSMhgC7lhY-H@smile.fi.intel.com>
 <cv6w4n2ptcdehn5n3mipuyfrtemm4rldhiyppazk4uqdn2xx7e@hxg4kldaacxk>
 <Zcz-csPY5x29DP7v@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="52elieucqt6bggmp"
Content-Disposition: inline
In-Reply-To: <Zcz-csPY5x29DP7v@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--52elieucqt6bggmp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 07:54:58PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 14, 2024 at 06:45:48PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Thu, Feb 08, 2024 at 07:04:33PM +0200, Andy Shevchenko wrote:
> > > On Thu, Feb 08, 2024 at 08:46:44AM +0100, Uwe Kleine-K=F6nig wrote:
> > > > On Thu, Feb 08, 2024 at 12:35:25PM +0530, Raag Jadav wrote:
> > > > > pcim_iomap_table() fails only if pcim_iomap_regions() fails. No n=
eed to
> > > > > check for failure if the latter is already successful.
> > > >=20
> > > > Is this really true? pcim_iomap_table() calls devres_alloc_node() w=
hich
> > > > might fail if the allocation fails. (Yes, I know
> > > > https://lwn.net/Articles/627419/, but the rule is still to check for
> > > > errors, right?)
> > >=20
> > > We do not add a dead code to the kernel, right?
> > >=20
> > > > What am I missing?
> > >=20
> > > Mysterious ways of the twisted PCI devres code.
> > > Read the above commit message again :-)
> > >=20
> > > For your convenience I can elaborate. pcim_iomap_table() calls _first_
> > > devres_find() which _will_ succeed if the pcim_iomap_regions() previo=
usly
> > > succeeded. Does it help to understand how it designed?
> >=20
> > I assume you're saying that after pcim_iomap_regions() succeeded it's
> > already known that pcim_iomap_table() succeeds (because the former
> > already called the latter).
> >=20
> > I'm still concerned here. I agree that error checking might be skipped
> > if it's clear that no error can happen (the device cannot disappear
> > between these two calls, can it?),=20
>=20
> It depends. If you call it in some asynchronous callbacks which may be run
> after PCI device disappears, then indeed, it's problematic. But you proba=
bly
> will have much bigger issue at that point already.
>=20
> In ->probe() it's guaranteed to work as I suggested (assuming properly wo=
rking
> hardware).

Assuming properly working hardware allows to drop many error checks :-)

> > but for me as an uninitiated pci code
> > reader, I wonder about
> >=20
> > 	dwc->base =3D pcim_iomap_table(pci)[0];
> >=20
> > without error checking. (OTOH, if pcim_iomap_table() returned NULL, the
> > "[0]" part is already problematic.)
>=20
> Seems it's your problem, many drivers use the way I suggested.
>=20
> > I'd like to have a code comment here saying that pcim_iomap_table()
> > won't return NULL.
>=20
> Why? It's redundant. If you use it, you should know this API.
> So, the bottom line, does this API needs better documentation?

If a driver author knows it while writing the code, it's obvious. But if
the driver author looks again in 2 years or someone else (e.g. me with
the PWM maintainer hat on and with little pci experience) that knowledge
might be faded.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--52elieucqt6bggmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXN1/AACgkQj4D7WH0S
/k5JrQf/Qt6r2gqZjxMeq4PGvF1ZTCfwDFGvIsSfsXifo93hI+YxWNxiNGkXqwol
MPOMR2g6xorzUL0Jz/fJZjnD/KqhBfM8DcSDNTuXi5wdZshZrto0WKcTP8YwrSBH
AQGVKClLGe1YXgo0Gzuc1IXACRNJrMjp3rEZsqUy4xANrvEXfMH1KYWzIC7k0P0b
2Grc2iLKinIuyfv59cWZixH/wf1Fl0SdJWsrhQ8ltf1tar1zO988tbFC3Yy3/sst
+OLKIq/6iAc1iCc9wpzSCVC0kxaEgru2pgrX/BeW1tO9bDu5uBRv6jvqq51dLid6
vTlKdejBqqBizFNTA4dsp29thDlICw==
=fVEU
-----END PGP SIGNATURE-----

--52elieucqt6bggmp--

