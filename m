Return-Path: <linux-kernel+bounces-67392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CAD856AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451FA1C213D4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF90E13667C;
	Thu, 15 Feb 2024 17:20:44 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497F413665F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017644; cv=none; b=nwKlBwH1yBE0p5EDB3by1uI7w4uuT6JiA4Gy38fDYR7+ZKlWXx08GfLVHiWhwKmi3gPXgUI6dTjaAcKTkJKQoq25ipqfqEy33+axrHOu/wUHJl0jIqn+vSvMLohMqZLqSau1jNJ3jllKCVqlknWl7aXbkjf1MgeLoV69p0jVx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017644; c=relaxed/simple;
	bh=DhCOBaollMnNcyIsBNcsmF0ZLgDsp0XSt2/+v5C7ZBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POlXXgg74bJm46VB4tFL2XBDscgBD6mMAB2ZzE39oeUR1rn9oM+1b0ePQC/NTeD2/86a8imVvNOTBD0Eu34UzQIhvPsAKYqkc49aRvfbxa5BNCphC/bh2RKoZqjwxFm6IBB0DBJY8DNVTRqLPbo+BuqxelbRQhPoDhR1KkEl2ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rafPE-00023i-Ge; Thu, 15 Feb 2024 18:20:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rafPD-000vTS-Ev; Thu, 15 Feb 2024 18:20:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rafPD-005VOO-1D;
	Thu, 15 Feb 2024 18:20:15 +0100
Date: Thu, 15 Feb 2024 18:20:15 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com, 
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] pwm: dwc: drop redundant error check
Message-ID: <likebxfhlcg6equjhxnf7cimsgac4qvoge3bf65qyir6apwq4n@iotwg6zjjr6c>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-2-raag.jadav@intel.com>
 <qrwcje4t2pbbxilnlfz2q7njodcp6vl54uaypdbvjgvwhgvc5g@4eq5wvumpjjx>
 <ZcUJoSMhgC7lhY-H@smile.fi.intel.com>
 <cv6w4n2ptcdehn5n3mipuyfrtemm4rldhiyppazk4uqdn2xx7e@hxg4kldaacxk>
 <Zcz-csPY5x29DP7v@smile.fi.intel.com>
 <sd2ugzjrmrdvcyxotoyg53qp3i7ta4yko225ln3gk4fmik7iof@a7mab6o2kkvz>
 <Zc4TTLetiGhJlx8d@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nzhwffwfhtbddob5"
Content-Disposition: inline
In-Reply-To: <Zc4TTLetiGhJlx8d@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--nzhwffwfhtbddob5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Thu, Feb 15, 2024 at 03:36:12PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 15, 2024 at 10:22:57AM +0100, Uwe Kleine-K=F6nig wrote:
> > If a driver author knows it while writing the code, it's obvious. But if
> > the driver author looks again in 2 years or someone else (e.g. me with
> > the PWM maintainer hat on and with little pci experience) that knowledge
> > might be faded.
>=20
> This is widely used pattern. Anybody who works with Git should know how
> to use `git grep` tool. If in doubts, always can ask in the mailing lists.

IMHO you're assuming to much. If someone sees this pattern and quickly
looks at the implementation of pcim_iomap_table() they might (as I did)
conclude that this call should be error checked. If they send a patch in
say 2 years I think I won't remember this discussion/patch and happily
accept this patch. And I probably won't get enough doubts to start
grepping around.

> I still consider it redundant.
>=20
> P.S. That's what you call "bikeshedding" (done by yourself here)?

I can understand that you consider that bikeshedding given that for you
it's obvious that the second function cannot fail. For me it's not and I
take this as a hint that it's not obvious for everyone.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nzhwffwfhtbddob5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXOR84ACgkQj4D7WH0S
/k7egQgAomdmzTMreh6wBaC9N99w6iyzXtHVBFeEUMU42kCw/Wyp1/JUwDkbzoQN
YT86ZJQ/4y1lECvtsogD3H10f/OCuJgizYgyFdf3oKTVvl5CvkiPjjHFnwXmgwP6
m2K2F9v49C/oQ0ZB5wFAdJOcbwhIf2NJczBaAuuhH+qt14aknkmRogP2TfBFHljM
IsktlhR4/S/lFypmxf6fcKQp5VHSL4naDyMQt2AfC3uvZeEiSKL0VapFhIIe912L
atvbzMhxUnutQRP0mvc9uDc6zVI+8JUQD7pn3iWd938dkQ/kDQwV6x1rsFDi59PT
zcn5n804FbnTzDB9YYgeGqevKnCrIA==
=VoYV
-----END PGP SIGNATURE-----

--nzhwffwfhtbddob5--

