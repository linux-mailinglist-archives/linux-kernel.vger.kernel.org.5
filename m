Return-Path: <linux-kernel+bounces-17305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19870824B26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B268D285D26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB3D2D02B;
	Thu,  4 Jan 2024 22:46:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3652CCD6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLWTt-0003LX-RS; Thu, 04 Jan 2024 23:46:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLWTs-000SXg-6R; Thu, 04 Jan 2024 23:46:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLWTs-003ePm-0J;
	Thu, 04 Jan 2024 23:46:28 +0100
Date: Thu, 4 Jan 2024 23:46:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: William Qiu <william.qiu@starfivetech.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hal Feng <hal.feng@starfivetech.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v10 3/4] riscv: dts: starfive: jh7100: Add PWM node and
 pins configuration
Message-ID: <xd2ryic6mr6d6cbljjbhmr56mfpchfzkmc3lnznhmoiwyzip2a@6bhbho267e7c>
References: <20231222094548.54103-1-william.qiu@starfivetech.com>
 <20231222094548.54103-4-william.qiu@starfivetech.com>
 <CAJM55Z9tyrR7emEBrY0+Fnc_LUFQHkqYHLQ4ptL=XQMy52qtVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t6vmolgghsdowiew"
Content-Disposition: inline
In-Reply-To: <CAJM55Z9tyrR7emEBrY0+Fnc_LUFQHkqYHLQ4ptL=XQMy52qtVw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--t6vmolgghsdowiew
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Emil,

On Sun, Dec 24, 2023 at 02:49:34AM -0800, Emil Renner Berthing wrote:
> William Qiu wrote:
> > Add OpenCores PWM controller node and add PWM pins configuration
> > on VisionFive 1 board.
> >
> > Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>=20
> Sorry, I thought I already sent my review. This looks good.
>=20
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Is this also an implicit Ack to take this patch via the pwm tree once
the earlier patches are ready? Or do you want to take it via your tree?
(Maybe already now together with the binding? If so, you can assume my
Reviewed-by to be an implicit Ack for that.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--t6vmolgghsdowiew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWXNUMACgkQj4D7WH0S
/k5yJwf8DhWKIA7w5Efn+CTxdLq+56oqG3ETi+SoNHAw6aIw5EMpC/VJwzn87CjW
rFbc+3JtR/MZvQtlQeEaKu8+IuYRUW0iOFQ2FjVJXI2219g9PsTgMdx9fQmlZFqp
iFg3DTWerqhqGu258walJUgojVdC6plX2sjlVWvf9UIIaYv9yR4IYMffeFWw0MM/
dThWdIdYfx4BtxMJWxkiw3QQr7s1tpJ55weroLPO5CAMqXrjiC6YGmcelTF8mRCJ
6pFloQ1MTC6kT5gERkxBlnO1V+WocrNXPamPFavh5UtGL0PmsZqQzUT49MWwb2si
sXuOgYjeLG8VgEj8X0+2I+x7k90eDg==
=xoqr
-----END PGP SIGNATURE-----

--t6vmolgghsdowiew--

