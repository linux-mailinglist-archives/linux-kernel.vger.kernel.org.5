Return-Path: <linux-kernel+bounces-133540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DAB89A545
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035E72843AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D76C173352;
	Fri,  5 Apr 2024 19:56:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D989D15F40B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346967; cv=none; b=hpw06pM9xi0/G27GQOl/DD7jMu73byFLrSvmExvSDbIMOcpwpHL0JhITVh8RFQBHICNfg4bgABUlpPI7EZA+/vXfHHojmP6pbgSS9JF4/3DfUczZ13Ei1mrHr+36manfVuCPmuGw2s9LY6ranUkYni5HS/ZQOPiTgbd/77EkR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346967; c=relaxed/simple;
	bh=GxGMOTnsr5TM4J1mJTzy6oMhUIIAbjU/GGFgBEgB7oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoFkIPwlCgd4EM0J6Tuse96rVgbIDldK1jjdd1gKvGFaEGW1wYid0//W6TCMbvaj4WndUH0GwwnzKJbTXiDpnfRdXOtBi3ZeZj+5ssAICWpsXZsa6j2mnSVH95QTzea27Uc9ss5sTjp/yHAoMFumZ2FYElvyQzeMdld7/cW+V98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rspfO-00065i-6m; Fri, 05 Apr 2024 21:56:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rspfN-00Ac9s-0J; Fri, 05 Apr 2024 21:56:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rspfM-00FZ4g-2x;
	Fri, 05 Apr 2024 21:56:00 +0200
Date: Fri, 5 Apr 2024 21:55:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: David Lechner <dlechner@baylibre.com>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com
Subject: Re: [RFC PATCH 0/3] pwm: add support for duty_offset
Message-ID: <gcibnofcdvs3qwygsuvwobckoyipj2a3t72remo5ohauuvf2cb@4ae4byeom67d>
References: <20240405003025.739603-1-tgamblin@baylibre.com>
 <fhrderkiwqzc7fw2hptz2la3aco72wlossqbrr4m42qllcpcpw@vhxflah2ex2a>
 <CAMknhBFgXdH63_N738qMt6tzK_zWdB-OWvYTWitmBuQNqrN+LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wewextuk6np2tzoq"
Content-Disposition: inline
In-Reply-To: <CAMknhBFgXdH63_N738qMt6tzK_zWdB-OWvYTWitmBuQNqrN+LQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--wewextuk6np2tzoq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Fri, Apr 05, 2024 at 12:03:56PM -0500, David Lechner wrote:
> On Fri, Apr 5, 2024 at 1:23=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Thu, Apr 04, 2024 at 08:30:22PM -0400, Trevor Gamblin wrote:
>=20
> ...
>=20
> > > 2. Should __pwm_apply() explicitly disallow PWM_POLARITY_INVERSED and
> > > duty_offset together?
> >
> > While there is no technical need for that, a configuration with both
> > PWM_POLARITY_INVERSED and duty_offset > 0 is irritating. So I'd say yes,
> > it should be disallowed. When I created the cdev API I even considered
> > dropping .polarity for lowlevel drivers and convert them all to
> > .duty_offset.
> >
> > Having said that I don't like the addition of .supports_offset to
> > struct pwm_chip, which only signals a new incomplete evolution of the
> > pwm framework. Better adapt all drivers and then assume all of them
> > support it.
>=20
> But not all chips can fully support this feature. I envisioned this
> flag as something consumer drivers would check when they require a
> chip capable of providing a phase offset between two PWM output
> channels. This way, the consumer driver could fail to probe if the PWM
> chip is not up to the task.
>=20
> For example the consumer driver might require two coordinated signals lik=
e this:
>       _                   _
> PWM0 | |_________________| |_________________
>            ___                 ___
> PWM1 _____|   |_______________|   |__________
>=20
> PWM0: duty_offset =3D 0, duty_cycle =3D 1, period =3D 10
> PWM1: duty_offset =3D 2, duty_cycle =3D 2, period =3D 10
>=20
> Do we need to do additional work to support cases like this? Or should
> we just let it fail silently and let it generate incorrect signals if
> someone attempts to use an unsupported hardware configuration?

My vision here is that you can do the following:

	state.duty_offset =3D 0;
	state.duty_cycle =3D 1;
	state.period =3D 10;
	ret =3D pwm_round_state(pwm, &state);
	if (!is_good_enough(state))
		goto err;

This way pwm_apply_* could just continue to work as it does now (i.e.
implement the biggest period not bigger than requested. For that
implement the biggest duty_offset not bigger than requested and for
these values of period and duty_offset implement the biggest duty_cycle
not bigger than requested.)

This has the advantage that the lowlevel driver doesn't need to judge if
the setting it implements is good enough.

To get there, quite some work has to be invested.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wewextuk6np2tzoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYQV0IACgkQj4D7WH0S
/k4KhQgApye5alomNROsehvEvK1/wS5Lj9Ak4+5GDtGnadX04W2BVIjid7X3PUoq
T56Cfz402Db10LHyYSimqxXL6g8pr08d5E4u80BNu6hhDHbh4azaqbVZZlUsk6cq
URRSQ+lESFFLRCT/P7kUMZWYtkkTIGFtU6wKBzDC27Jz8GfaIRbI7k4lmqgCChzK
QMT3xRESfs4otfNHol3nEDJRYktq700/5QEXN1IMse8XFw5d2wurC1rrR3F2U8EK
AyZ64WBU8eITxen3DX82SXiUEPXirEVBOlOmVH5bBFcQPoqpHjS+E1fl++whZC6V
4N7T05zPmIf50NIaPdGqwym+lCAEaA==
=EDVO
-----END PGP SIGNATURE-----

--wewextuk6np2tzoq--

