Return-Path: <linux-kernel+bounces-132467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E514899535
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5AB1F23C49
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2AB22626;
	Fri,  5 Apr 2024 06:23:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A642232B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298211; cv=none; b=f6bUta605Aw8i4n9rKOd+4ZV/RQ9/x5JPsOkRJOO2dQOQkbtw83sqORRQSAtigtmAisTf5nRPvCj3syWyctYce/lLeML6N6SD1CWNUFVoYADhi2I1yBYR0UutXGG4zV+lC45rfb2ptircelgoD+/OFhinpXtK3NQwrR/qsRj9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298211; c=relaxed/simple;
	bh=oI59NsJvDA8c2DbqEq5ZynS0EqYnzPHQ7vo6EjbmAJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEoKAZI9ugOC8ZyzX3GRzCvqOHv1xVcrTsgeHauljxTmERrPS+CaxS3D7lFvaO/oewcFrvd2CHpxNkG8AzeBdybjv3w6hs6WK8q98euh4IFA+mRj0ubmEUChzTAFBK31cd+/FoTA3eN/E8BS4pG8iltBplXocBqC+6f0J5AXSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rscz1-0000do-44; Fri, 05 Apr 2024 08:23:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rscyz-00AVvc-RG; Fri, 05 Apr 2024 08:23:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rscyz-00FMxw-2S;
	Fri, 05 Apr 2024 08:23:25 +0200
Date: Fri, 5 Apr 2024 08:23:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com
Subject: Re: [RFC PATCH 0/3] pwm: add support for duty_offset
Message-ID: <fhrderkiwqzc7fw2hptz2la3aco72wlossqbrr4m42qllcpcpw@vhxflah2ex2a>
References: <20240405003025.739603-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qulilgqzezq3juot"
Content-Disposition: inline
In-Reply-To: <20240405003025.739603-1-tgamblin@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--qulilgqzezq3juot
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Trevor,

In general I really like your effort to generalize the pwm framework.
Thanks a lot!

On Thu, Apr 04, 2024 at 08:30:22PM -0400, Trevor Gamblin wrote:
> This series extends the PWM subsystem to support the duty_offset feature
> found on some PWM devices. It includes a patch to enable this feature
> for the axi-pwmgen driver, which can also serve as an example of how to
> implement it for other devices. It also contains a patch adding a new
> pwm_config_full() function mirroring the behavior of pwm_config() but

Please don't. pwm_config() is a function I want to get rid of in the
long term. Consumers that want to make use of it should use
pwm_apply_*().

> with duty_offset included, to help maintain compatibility for drivers
> that don't support the feature.
>=20
> The series was tested on actual hardware using a Zedboard. An
> oscilloscope was used to validate that the generated PWM signals matched
> the requested ones. The libpwm [1] tool was also used for testing the
> char device functionality.
>=20
> The series is marked RFC as there are some outstanding questions about
> implementation:
>=20
> 1. In drivers/pwm/core.c, __pwm_apply() was modified to check that the
> sum of state->duty_offset + state->duty_cycle does not exceed
> state->period, but in the character device section these values are
> being checked separately. Is this intentional? What is the intended
> behavior?

state->duty_offset + state->duty_cycle doesn't necessarily need to be
less or equal to state->period. Consider this waveform, where ^ marks
the start of a period.


        ___       _________       __...
           \_____/         \_____/
        ^               ^

This one has duty_offset =3D 9 and duty_cycle =3D 10 while
period =3D 16 < 10 + 9.

> 2. Should __pwm_apply() explicitly disallow PWM_POLARITY_INVERSED and
> duty_offset together?

While there is no technical need for that, a configuration with both
PWM_POLARITY_INVERSED and duty_offset > 0 is irritating. So I'd say yes,
it should be disallowed. When I created the cdev API I even considered
dropping .polarity for lowlevel drivers and convert them all to
=2Eduty_offset.

Having said that I don't like the addition of .supports_offset to
struct pwm_chip, which only signals a new incomplete evolution of the
pwm framework. Better adapt all drivers and then assume all of them
support it.

> 3. Are there other places that would need duty_offset handling which
> have been missed?

I'm happy you adapted the tracing stuff. I didn't look closely, but I
don't think something important was missed.

> Note that in addition to the other patches in this series, the changes
> to the axi-pwmgen driver rely on [2] and [3], which haven't been picked
> up yet.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qulilgqzezq3juot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYPmNwACgkQj4D7WH0S
/k50lAf+Oqu/fg4apGGLXPe+Zm3udwjikCgFyfY22MOv1Z/HIQlJktDlCXg8kSQj
d2Uo5EcA1GDtV5f7YUA4MHN9wtdFLqdi34clET+dMQzdaU+l1EXmkkhbnpHj3Ku3
50L75svXzhJdBt+Wr9r0WNPs6ngvb5LjpwuHfYUahdhEW3KsvMOMaqwQCQp7XGVF
Y0Cq9RJf3bxk0cOhl87K+ErARUG39q5+ATJh7LwI7Uwlxa8sOmuOCaCVfv7p8DA8
Wa2L7CfhqJPCDRt0Gx5WAtjcjF6REqnjBCOWkKBIgRiP8FsVJ8rDqMCdhqzSu6P/
LtGSEmpTU2JU/qULGie0qYa3m/bfoQ==
=eT6T
-----END PGP SIGNATURE-----

--qulilgqzezq3juot--

