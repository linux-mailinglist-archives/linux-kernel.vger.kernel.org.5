Return-Path: <linux-kernel+bounces-27390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF0782EF2B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EE0285B68
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A5A1BC37;
	Tue, 16 Jan 2024 12:49:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF88A1BC2C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPisU-0000UH-3Y; Tue, 16 Jan 2024 13:49:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPisS-000FGv-Kl; Tue, 16 Jan 2024 13:49:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPisS-000swY-1n;
	Tue, 16 Jan 2024 13:49:12 +0100
Date: Tue, 16 Jan 2024 13:49:12 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Young <sean@mess.org>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com, 
	devicetree@vger.kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org
Subject: Re: [PATCH 2/2] pwm: Add driver for AXI PWM generator
Message-ID: <7cycugkqw3sew7qvr3ltntg7newzqbccl3xy5je5jgnrg7d6e5@nex2hngeqtlu>
References: <20240115201222.1423626-1-tgamblin@baylibre.com>
 <20240115201222.1423626-3-tgamblin@baylibre.com>
 <gbessnmierg5gvdguhwauoe2mxr3krwcfk2afhazrqvz45md64@itbchezepncg>
 <ZaY-FjeRV2qPL0wz@gofer.mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5xakas4or6b5zuxp"
Content-Disposition: inline
In-Reply-To: <ZaY-FjeRV2qPL0wz@gofer.mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--5xakas4or6b5zuxp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jan 16, 2024 at 08:28:06AM +0000, Sean Young wrote:
> On Mon, Jan 15, 2024 at 10:18:04PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jan 15, 2024 at 03:12:21PM -0500, Trevor Gamblin wrote:
> > > +	pwm->chip.dev =3D &pdev->dev;
> > > +	pwm->chip.ops =3D &axi_pwmgen_pwm_ops;
>=20
> In that case pwm->chip.atomic =3D true; can be set too (although this sho=
uld
> be tested with CONFIG_DEBUG_ATOMIC_SLEEP and CONFIG_PWM_DEBUG).

Oh indeed. Good catch.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5xakas4or6b5zuxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWme0cACgkQj4D7WH0S
/k6SnAf8CN6fVPc3MOsjuIIC1oV5YbMRilw8XY4Piy87ZlBBm4FF2GHVvg+47LWU
KZmp3xOFO1q4VD85xsAvSllfUoZt3myvZcZKEWpclkcXXzm4rsqMDtOzBM4OyZ8e
vpyXAKeLff+bIW8ZYjuxIstclzcdjl7JZRftKpCCPLhN45jK/TFK3ObKBPggDgIs
IRIc32QVsFzU9JU7CmexkZUu9EbyBFEz4ku/2HYeyLGzv2VIrlBMXMeEMhl/LnHV
bdKNmZ4+CPeflwBdX7nhCk4GbHX/6gfd5UrohBBHwFu0zou/0wYicYa1eLE7al3n
G67tpOVkF+o4IRrL3B0X4QPvUBZ1Mg==
=9/Ze
-----END PGP SIGNATURE-----

--5xakas4or6b5zuxp--

