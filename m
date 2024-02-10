Return-Path: <linux-kernel+bounces-60494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F39958505AE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46B8281356
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088885CDEE;
	Sat, 10 Feb 2024 17:20:10 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500005CDD8
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585609; cv=none; b=fw9O+YVEUmsBQ76/K7iekhoyRp/g0DpieerQc3CF9grStzYVwmQz1LfL2lOvsQyGPdMLZ7N2c7DYyc1FptwH3jIJw4WI+0TV0fHkeKPO+6MYC9lT0VoDyhV4ybEAKjs2BdlAE/vakmPf7CN71zqJkWYbprySGkCq1Gu0603BtL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585609; c=relaxed/simple;
	bh=thHZbms70+r1Plin277E28ipagQgIRlFpWToc/CSe14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deZOKoe/IX0raVtiOd4whQ1/M/Fbp4jclHV4XxSMRn8VEBw3Oe9XreFLP7kl2yRKWy/VlWxzdGDGrib37BNxv+sZpxJP9FQxt0/N/vRQI420f4epLg/QoomC0PxZaN5ERyHj3q9NafuQzHre52LYfsOmccB6BykgeRXE05I3urg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYr19-0003R7-0y; Sat, 10 Feb 2024 18:19:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYr17-005ibu-V6; Sat, 10 Feb 2024 18:19:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYr17-002FPS-2p;
	Sat, 10 Feb 2024 18:19:53 +0100
Date: Sat, 10 Feb 2024 18:19:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com, 
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] pwm: dwc: Add 16 channel support for Intel
 Elkhart Lake
Message-ID: <42pjh4zpbsyfdi6njcwhpoyllmqr6vv7u5h2lfakrje4dzitfj@3bsynlfj5mjj>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-3-raag.jadav@intel.com>
 <ZcUNe09gDtkztmbk@smile.fi.intel.com>
 <ZcZ6kUkf-GktlU4p@black.fi.intel.com>
 <ZcZ__nnOz1QA7uUZ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7wrw5534ju6dbfhh"
Content-Disposition: inline
In-Reply-To: <ZcZ__nnOz1QA7uUZ@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--7wrw5534ju6dbfhh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Feb 09, 2024 at 09:41:50PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 09, 2024 at 09:18:41PM +0200, Raag Jadav wrote:
> > On Thu, Feb 08, 2024 at 07:20:59PM +0200, Andy Shevchenko wrote:
> > > On Thu, Feb 08, 2024 at 12:35:26PM +0530, Raag Jadav wrote:
> > > > Intel Elkhart Lake PSE includes two instances of PWM as a single PCI
> > > > function with 8 channels each. Add support for the remaining channe=
ls.
> > >=20
> > > Side Q: Have you used --histogram diff algo when prepared the series?
> > > If no, it's better to start using it.
> >=20
> > I used it for a few weeks, but I think I've grown a bit too comfortable
> > with patience.
> >=20
> > I'll use histogram for pinctrl stuff if you insist :)
>=20
> It's recommended by Torvalds:
> https://lore.kernel.org/linux-gpio/CAHk-=3DwiVNOFP1dzKdCqXvoery5p8QoBB5TH=
iJUMbZ1TxJb7FhQ@mail.gmail.com/

BTW, the magic to use it by default is:

	git config --global diff.algorithm histogram

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7wrw5534ju6dbfhh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXHsDgACgkQj4D7WH0S
/k7o5ggAuZAAcD9U3AFoaxdfFfcjxJhpQeZsp94PbGD54FrscKmHbUW7FW1Xa8cW
AD/a8f3huc9jkcrTKPCcTy+S3j3PmDhtvbTuIYnfqPeRxt013vtn8Z/gQg2qoCqB
WWpOENycPaPsB+KaW9ho2ysg4nu2WwWB9Eoz+NIJz4B/On8IiJMO6/uvt5dKDtFE
CKt/1FqIviC0bnfWQVgqfniKhIZS0kSGEymCiJbZoEGoFdUxTMV69uDwCXOs9Zt+
Vv6Sd3VomCSfFwQVcJaATkC1K4mj3Ls8Pkkb5aqqlkP54g2kF4Qr6DkBjJAob7Go
k4/AVWOEytofWkSbooZJ2rp0kHWmng==
=k0XE
-----END PGP SIGNATURE-----

--7wrw5534ju6dbfhh--

