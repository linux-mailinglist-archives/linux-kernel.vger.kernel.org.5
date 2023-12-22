Return-Path: <linux-kernel+bounces-9593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7C981C820
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422231F2414F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4F1125BE;
	Fri, 22 Dec 2023 10:27:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8935011718
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGckX-0008A3-Ce; Fri, 22 Dec 2023 11:27:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGckV-000jXS-3D; Fri, 22 Dec 2023 11:27:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGckV-001cdB-T5; Fri, 22 Dec 2023 11:27:23 +0100
Date: Fri, 22 Dec 2023 11:27:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-pwm@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Thierry Reding <thierry.reding@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [RFC PATCH v1] regulator: pwm-regulator: Fix continuous
 get_voltage for disabled PWM
Message-ID: <eyfec4jzcw3japf77jzj3p6w7gytbmogr2ff3g2677nn6qivpe@57huhelwllhd>
References: <20231221211222.1380658-1-martin.blumenstingl@googlemail.com>
 <tek6c6symqgm6x6ujh4m67q32en24pzrkjbchffir7qljo4gor@7qpu4zmgyzpq>
 <CAFBinCAxh0xU2mDRX3t42j6oJ534p9RPUV+dYoRe0oacTw_7iA@mail.gmail.com>
 <2f2bc3xvemk2x3sno65so6vglmpavjtyeiqzy6yyzwvx5hqtmi@tsfx2hr7rmqp>
 <CAFBinCCLorBkGmpeUiep6gT7N__2641ec+f=hJyUgVEv1x6EdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ofg2g3grsnoftz76"
Content-Disposition: inline
In-Reply-To: <CAFBinCCLorBkGmpeUiep6gT7N__2641ec+f=hJyUgVEv1x6EdA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ofg2g3grsnoftz76
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 11:12:30AM +0100, Martin Blumenstingl wrote:
> Hello Uwe,
>=20
> On Fri, Dec 22, 2023 at 8:10=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> [...]
> > Also the calculation is wrong: If a relative duty-cyle in the interval
> > [91%; 0%] maps lineary to [860 mV; 1140 mV] you get 1100 mV at
> >
> >              1100 mV - 860 mV
> >         91 + ---------------- * (0 - 91) =3D 13
> >              1140 mV - 860 mV
> >
> > (If the calculations in the driver used signed multiplication and
> > division, all the checks for max_uV_duty < min_uV_duty could just go
> > away.)
> >
> > So you want
> >
> > +               pwm-dutycycle-range =3D <13 0>;
> Thank you!
>=20
> > (if this restriction is really necessary).
> I could not find a way around this.
> Without this change pwm_regulator_set_voltage() is called with req_min
> 860mV and req_max 1140mV.
> pwm_regulator_set_voltage() will then pick the lowest possible
> voltage, which then results in 860mV (exactly what I get without any
> patches).
>=20
> To be able to keep the original minimum voltage in .dts would be to
> work on what Mark suggested where he said:
> "I'd expect a change in the init_state() function, possibly one that
> programs the PWM to reflect the actual hardware state"
>=20
> [...]
> > > -     if (pstate.enabled)
> > > -             voltage =3D pwm_get_relative_duty_cycle(&pstate, duty_u=
nit);
> > > -     else if (max_uV_duty < min_uV_duty)
> > > -             voltage =3D max_uV_duty;
> > > -     else
> > > -             voltage =3D min_uV_duty;
> > > +     voltage =3D pwm_get_relative_duty_cycle(&pstate, duty_unit);
> >
> > I'd add here:
> >
> >         if (voltage < min(max_uV_duty, min_uV_duty) ||
> >             voltage > max(max_uV_duty, min_uV_duty))
> >                 return -ENOTRECOVERABLE;
> I can do that - although I think it should be a separate change.

That can go in together with the

	if (pstate.enabled)
		return -ENOTRECOVERABLE;

Otherwise +1 to not mix that with the machine specfic stuff.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ofg2g3grsnoftz76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWFZIoACgkQj4D7WH0S
/k7wLQgAgB0mlw3wy3ju4Du6LWIxSgraCzeRpxj6i4nzctEXRDsG7vLq9hKVW9Uf
GAFpXYSwxcG3rUS9CMj3YY7NPeo7ZZ1U6EvHNyQOk/DEbWKIw/Y1eZi2QGaWjUqa
T0x1En4EaSUKC4ZdDGy+5DgGsC0rlfMyE7YQHkurbuAjb5fvCbfL9XTW/GqnRUuJ
Ptd+EyNbQfpzwyKA99G9WEy3eWM5ou5n0mTXGRtSpYlEPa7evYWF8+U65dcd/o9Y
d7mETR2MMvUfIJmbxp1Ob/zj+tjI0Jes6ahX2Jc9ev9BTjmFchcMB4MTE5xY3MRn
+T9SqS89y1Ku9rTXDCpbDx0uZKAwvA==
=bR5z
-----END PGP SIGNATURE-----

--ofg2g3grsnoftz76--

