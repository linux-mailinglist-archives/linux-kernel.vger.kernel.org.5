Return-Path: <linux-kernel+bounces-70828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC6C859CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECB9282AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37F120B0F;
	Mon, 19 Feb 2024 07:27:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879B08F5A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327674; cv=none; b=eaFamawozRSYM3h8bijYXYHRAV7GdG6IBVa2DNC6u4pAVLdtyRfxszmalZFFJiFpsDE6tN0r1+chRJtLd0daLrU0vCSoLKBMyw5cHsaEyiIY6AwC7iC2rKwc0TMoK1XRuj3IxYca5YghIQ4F+wSfszbZAW9GL+KTF4cc7OKDPrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327674; c=relaxed/simple;
	bh=LpYe01TsbmJNiqg3EgJ1Xuy8jlq/JFizuY2pktlKi0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fjzq8OmUqYtyPtJnO2zlsirlItlhziio/Bexa1c/pE+BNgQ6hqL3AEHBv3aYhSIxfXdx9Etk/t7XY6Xx7CxkK3DOZMA2EgQPelkQvF9iMPAHjmWpc7PQPxdt1dVB3dE6d6oG0oU4/J4yioYNWHstnACyVG7fEjLHAEpCu9m6FpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rby40-0007jN-LF; Mon, 19 Feb 2024 08:27:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rby3z-001bCq-ES; Mon, 19 Feb 2024 08:27:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rby3z-007b4b-1A;
	Mon, 19 Feb 2024 08:27:43 +0100
Date: Mon, 19 Feb 2024 08:27:43 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thorsten Scherer <T.Scherer@eckelmann.de>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com, 
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, lakshmi.sowjanya.d@intel.com, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] pwm: dwc: drop redundant error check
Message-ID: <4cl5y62fv4jezk7i3cacv5ukzwyp66uflp3upg4czy4dp7g43v@cfbm2seewpst>
References: <20240219033835.11369-1-raag.jadav@intel.com>
 <20240219033835.11369-3-raag.jadav@intel.com>
 <m57yqdldszy3s44p5rdxd6kwii5tqzqa44aaevpe7bep2yyeuo@wls3ad3gcl7y>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dn262ebptnesc56h"
Content-Disposition: inline
In-Reply-To: <m57yqdldszy3s44p5rdxd6kwii5tqzqa44aaevpe7bep2yyeuo@wls3ad3gcl7y>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--dn262ebptnesc56h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Feb 19, 2024 at 08:11:00AM +0100, Thorsten Scherer wrote:
> On Mon, Feb 19, 2024 at 09:08:33AM +0530, Raag Jadav wrote:
> > pcim_iomap_table() fails only if pcim_iomap_regions() fails. No need to
> > check for failure if the latter is already successful.
> >=20
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > ---
> >  drivers/pwm/pwm-dwc.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> > index c0e586688e57..7dbb72c80ef5 100644
> > --- a/drivers/pwm/pwm-dwc.c
> > +++ b/drivers/pwm/pwm-dwc.c
> > @@ -51,11 +51,8 @@ static int dwc_pwm_probe(struct pci_dev *pci, const =
struct pci_device_id *id)
> >  		return ret;
> >  	}
> > =20
> > +	/* No need to check for failure, pcim_iomap_regions() does it for us.=
 */
>=20
> IMHO this comment could be omitted.

I like the comment (and even asked for it). Is it really only me who
doesn't know that after pcim_iomap_regions() calling pcim_iomap_table()
is unproblematic?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dn262ebptnesc56h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXTAucACgkQj4D7WH0S
/k5rlAf8DcLuxE9fQ2TvQDm+mkZsExqPNtSysZ3trhKvVvPblwBvXtmSVDOL4JoH
VqwwkkjcXzhb/DfvJBcYt+wbDynVbnPUFyFVYZ6EYFmuhdUZunZjfeZfaM60Dd7E
E4RvZnQEZ0KlJzVfGfvfk6J12z7GLCL7bD9dfBdFjwKMaWyE4Z+iXOrSCexGaIpf
T1TqdYf72gc0MG7FZxTrptZThQcsqwyYNjvHtbfdrTfGYYaCiJ4BQ++Nwvx8/vds
OLCTsGJL14o5A03hOsPQ5C1Vb4OCK58y9VdI3Cdx28eNeCOznFVa8MZefcQslfO2
l55tQ2v2SPgVIgy3YMuFEukSh8NvvA==
=S4CL
-----END PGP SIGNATURE-----

--dn262ebptnesc56h--

