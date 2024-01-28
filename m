Return-Path: <linux-kernel+bounces-41837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D6B83F847
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACFA1C2108A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7C528E0B;
	Sun, 28 Jan 2024 16:55:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C223745
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706460914; cv=none; b=qKPWxw6QDT0fV9oV6poh5vzFI7gqyNguKaExja4l4brld0W2s+3VGhmk+9btuuxmfw1dZfLNqdip3geJqLKXYTgdjLzfBmRpQG/6sJrWY8AkCf9kUsNcqYxXRWxmYz0EH0RwG1/8Z0bsK1UJWteIXG22rl5dmJBydsQ9q3mR6iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706460914; c=relaxed/simple;
	bh=TnCEqMjkzWgPyIi20zQerIZSNZJKpHx0FIMN+HYOeVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg18NNCR/VF7/umawEZzamhSqxXlN2n+yUzT0w2bS75o+tK90cSEIb+NsbWad60cioL0Qx7a/pTIwEPymfrblf1fErtPQHEvg+ryfpWRdRfVnUy7HgNV3earPdUzntcfQfEckkj5IwEqZvLIa149lgKgWp/32dfWpFEVR9XZVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rU8Qw-00031D-Au; Sun, 28 Jan 2024 17:55:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rU8Qv-002z9K-5g; Sun, 28 Jan 2024 17:55:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rU8Qv-00AH2z-0H;
	Sun, 28 Jan 2024 17:55:01 +0100
Date: Sun, 28 Jan 2024 17:55:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com, 
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] pwm: dwc: use to_pci_dev() helper
Message-ID: <q5mde3tak2mpqnkphue7vdez33l4bh2urjqryljzzpvz556yjw@2gmnudzle3my>
References: <20240122030238.29437-1-raag.jadav@intel.com>
 <20240122030238.29437-4-raag.jadav@intel.com>
 <ZbZo2A3qU9RIz568@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rfhsoumljfh5ev2l"
Content-Disposition: inline
In-Reply-To: <ZbZo2A3qU9RIz568@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--rfhsoumljfh5ev2l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Jan 28, 2024 at 04:46:48PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 22, 2024 at 08:32:38AM +0530, Raag Jadav wrote:
> > Use to_pci_dev() helper to get pci device reference.
>=20
> PCI
>=20
> ...
>=20
> >  static int dwc_pwm_suspend(struct device *dev)
> >  {
> > -	struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev);
> > +	struct pci_dev *pdev =3D to_pci_dev(dev);
> >  	struct dwc_pwm *dwc =3D pci_get_drvdata(pdev);
> >  	int i;
> > =20
> > @@ -120,7 +120,7 @@ static int dwc_pwm_suspend(struct device *dev)
> > =20
> >  static int dwc_pwm_resume(struct device *dev)
> >  {
> > -	struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev);
> > +	struct pci_dev *pdev =3D to_pci_dev(dev);
> >  	struct dwc_pwm *dwc =3D pci_get_drvdata(pdev);
> >  	int i;
>=20
> I don't see how pdev is being used. That said, why dev_get_drvdata() is n=
ot
> suffice?

I would even consider using dev_get_drvdata() a nice cleanup given that
pci_get_drvdata() works because dwc_pwm_alloc() called dev_set_drvdata()
(and not pci_set_drvdata()).

Not so long ago (i.e. before commit a357d1493f0c ("pwm: dwc: Move memory
allocation to own function")) the dwc driver was pci only and used
pci_set_drvdata(). Then the upside of first converting the struct device
to a struct pci_dev was not to hard code knowledge about the
implementation of pci_[gs]et_drvdata().

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rfhsoumljfh5ev2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmW2huQACgkQj4D7WH0S
/k6xAAf9FrXzNIGYd31goHKYoohHhptzWd8EBhHqM1GX6oWyeea03c7SQ3q7aOr0
xEMthrjkaLf5Pqj3xO8okMKcN2dOtFG1Jv5Fx4No6ylh9LNFU5kJwnG8s24a82dV
x12AlAfLsd2PpCKxTFgj5ZaadkB0y/Fd9z28yArE5zE2kZgVS4IQaaUZJun8NvxV
V56mrHH7jk3qAR4/alfr9nKSNkgEiL1fpjpD22gF1Fh77fn+J6wK4b22xSsqESXL
Xg5PHq1uqZwoR++ooGr05Dt5EW3fub8IjKzfSUMSSh76tWy5PL69aFJzbATWHRmM
kiyl339nCMNX/y40/FTSqT4KSLMPZQ==
=lEBB
-----END PGP SIGNATURE-----

--rfhsoumljfh5ev2l--

