Return-Path: <linux-kernel+bounces-39311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C083CE9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C24D2B26BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5215813A26B;
	Thu, 25 Jan 2024 21:28:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763E61386DF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218109; cv=none; b=nyYO8/nGVExMhku2PSoORtsms+BrhwdNfh3Khit/D/2ywFPxYBLnoMviSd2w5Lo88bsbqr+Xtdctsxf7v1ExTN+W6ourVOepp6Y7ekl3CSvfu09YCfcXLpu76pucEvluZXXrkpwVPNRnuEdY5VUn8hD0Q2WzTTePG/aGStfDjVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218109; c=relaxed/simple;
	bh=Aq9BEwj5Ou4QsJAljREwqkwq4jjfU8buVLcEkODYpac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz2QHlBcdo6wB8IVOzymyure9OkT3Hdm5yTRSslBxzrG7nE8NvwarQ0uROl31/s6k7ENSpboGjrLF5VK4UAGxHwGk1BMgzgdwIKLFHqQtKl2zYUlj6NzaoB2iNsDHE8Yb5oLc+bijJx/qXfzGAzb++QYa6p5q6xPdDBndH8obf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT7Gn-0003Mo-SR; Thu, 25 Jan 2024 22:28:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT7Gm-002N4M-Ou; Thu, 25 Jan 2024 22:28:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT7Gm-0089pQ-28;
	Thu, 25 Jan 2024 22:28:20 +0100
Date: Thu, 25 Jan 2024 22:28:20 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Francesco Dolcini <francesco@dolcini.it>, pratikmanvar09@gmail.com, 
	linux-pwm@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	pratik.manvar@ifm.com, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, 
	xiaoning.wang@nxp.com, linux-imx@nxp.com, kernel@pengutronix.de, 
	oe-kbuild-all@lists.linux.dev, festevam@gmail.com, linux-arm-kernel@lists.infradead.org, 
	jun.li@nxp.com
Subject: Re: [PATCH v3] pwm: imx27: workaround of the pwm output bug
Message-ID: <w34gpyikqc6oz5zjoan3ws4ckw5dlzjytddfw4df26dyflx3uk@itw6b34z5luv>
References: <20240103103421.GA3758@francesco-nb>
 <20240103110200.1018-1-pratikmanvar09@gmail.com>
 <20240103122005.GA3347@francesco-nb>
 <71426744-7223-448c-bd5b-ff786c5f8e65@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aqzalxdjxdebfp4u"
Content-Disposition: inline
In-Reply-To: <71426744-7223-448c-bd5b-ff786c5f8e65@gmx.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--aqzalxdjxdebfp4u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Stefan,

On Wed, Jan 24, 2024 at 12:48:21PM +0100, Stefan Wahren wrote:
> Am 03.01.24 um 13:20 schrieb Francesco Dolcini:
> > Hello Pratik,
> >=20
> > On Wed, Jan 03, 2024 at 04:32:00PM +0530, pratikmanvar09@gmail.com wrot=
e:
> > > From: Clark Wang <xiaoning.wang@nxp.com>
> > >=20
> > > This fixes the pwm output bug when decrease the duty cycle.
> > > This is a limited workaround for the PWM IP issue TKT0577206.
> > >=20
> > > Root cause:
> > > When the SAR FIFO is empty, the new write value will be directly appl=
ied
> > > to SAR even the current period is not over.
> > > If the new SAR value is less than the old one, and the counter is
> > > greater than the new SAR value, the current period will not filp the
> > > level. This will result in a pulse with a duty cycle of 100%.
> > >=20
> > > Workaround:
> > > Add an old value SAR write before updating the new duty cycle to SAR.
> > > This will keep the new value is always in a not empty fifo, and can be
> > > wait to update after a period finished.
> > >=20
> > > Limitation:
> > > This workaround can only solve this issue when the PWM period is long=
er
> > > than 2us(or <500KHz).
> > >=20
> > > Reviewed-by: Jun Li <jun.li@nxp.com>
> > > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > > Link: https://github.com/nxp-imx/linux-imx/commit/16181cc4eee61d87cba=
ba0e5a479990507816317
> > > Tested-by: Pratik Manvar <pratik.manvar@ifm.com>
> > > Signed-off-by: Pratik Manvar <pratik.manvar@ifm.com>
> > A very similar patch was already send in 2021 [1], did it had review
> > comments not addressed? Please have a look.
> >=20
> > In general please refrain from sending a new patch version every other
> > day, while every Linux kernel subsystem has different rules and a
> > difference pace of development, in this specific case sending a v3 just
> > adding your signed-off-by without allowing a little bit of time to wait
> > for more feedback is just not sane.
> >=20
> > [1] https://lore.kernel.org/all/?q=3Ddfn%3Adrivers%2Fpwm%2Fpwm-imx27.c+=
AND+b%3A%22Clark+Wang%22
> thank you, this is very helpful. Unfortunately i don't have the
> knowledge and resources to continue this work.
>=20
> @Uwe It seems that you were able to reproduce this issue. Is it possible
> to trigger this via sysfs and some kind of script?

When I read through the linked thread I was surprised to read that I
could reproduce it. My best guess is that I did that using a long period
and an LED connected to the PWM's output to make the effect easily visible.
Something like: Configure for

	.duty_cycle =3D 1s, .period =3D 5s

and change that to

	.duty_cycle =3D 0s, .period =3D 5s

(e.g. using sysfs) when the output got high.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--aqzalxdjxdebfp4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWy0nMACgkQj4D7WH0S
/k568QgAl9kR2hZ1RP9qsAlpFKv1pbgAqj8Cm2Q2SnZ6jmVmw6pEQHAiJ+kjKr7u
XtaA2sUd05WCawm4997HKGx7KRoJAdjzyiLB6MIsvWGjP2IV8rVNMXejmXPRZ92h
VyRGn1U6OeExVQnm+MkVCpDzQEZlHuMVzBUojTvzxip69IylIZ23QmUOWFJfYVFT
LcA/fNE0MjoYqYdqw9Me87u8fuN5wHyGTIGGKjRdKWP0YV/6NeJKM1fRuYMqXXEw
7+FFg7NwQ7mh5PyloJ1Phjh0ZsTiwbBIJHD35Sdogj6tIrGoNv9DQpG7cHUo8jSI
/GzzhiotZlzTOU7JfVKxg2nEnwYPJA==
=Tkun
-----END PGP SIGNATURE-----

--aqzalxdjxdebfp4u--

