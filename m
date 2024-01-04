Return-Path: <linux-kernel+bounces-17297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B39824B10
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70DA281C97
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7EB2CCD9;
	Thu,  4 Jan 2024 22:41:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F72C864
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLWOR-0001yE-9T; Thu, 04 Jan 2024 23:40:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLWOO-000SX9-Bn; Thu, 04 Jan 2024 23:40:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLWOO-003eP0-0q;
	Thu, 04 Jan 2024 23:40:48 +0100
Date: Thu, 4 Jan 2024 23:40:48 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: William Qiu <william.qiu@starfivetech.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hal Feng <hal.feng@starfivetech.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v10 2/4] pwm: opencores: Add PWM driver support
Message-ID: <mtqzl3hdfivkty2gdwabfxpshz276fjke477eql3nua4west63@u53ruikv5hz2>
References: <20231222094548.54103-1-william.qiu@starfivetech.com>
 <20231222094548.54103-3-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e6p2envurvrpju5r"
Content-Disposition: inline
In-Reply-To: <20231222094548.54103-3-william.qiu@starfivetech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--e6p2envurvrpju5r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again,

On Fri, Dec 22, 2023 at 05:45:46PM +0800, William Qiu wrote:
> +static const struct ocores_pwm_data jh7100_pwm_data =3D {
> +	.get_ch_base =3D starfive_jh71x0_get_ch_base,
> +};
> +
> +static const struct ocores_pwm_data jh7110_pwm_data =3D {
> +	.get_ch_base =3D starfive_jh71x0_get_ch_base,
> +};
> +
> +static const struct of_device_id ocores_pwm_of_match[] =3D {
> +	{ .compatible =3D "opencores,pwm-v1" },
> +	{ .compatible =3D "starfive,jh7100-pwm", .data =3D &jh7100_pwm_data},
> +	{ .compatible =3D "starfive,jh7110-pwm", .data =3D &jh7110_pwm_data},
> +	{ /* sentinel */ }

Looking at the binding

	compatible =3D "opencores,pwm-v1";

isn't a valid configuration. If that is indeed the case and you always
have either starfive,jh7100-pwm or starfive,jh7110-pwm, you can drop the
logic to only use starfive_jh71x0_get_ch_base conditionally.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--e6p2envurvrpju5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWXM+8ACgkQj4D7WH0S
/k5eqwf7BKGgncVgVmHDNmQfHHTNNfkRf4UToW1IVJgCDbsLtDvbBFJbN5tzdhb+
cL/gFmPxhwJBZ2rRDGTa0/5EBBkCfwVdIQ8jj1wqJEyx0bQuvxUKdNIVCjYtmvFJ
B0dSDdrYqvSQK3v5gHEYGfi1TOXWJ0P9LdIZxiIRAyF8eDfPVAHnvM3JhPxnkoX9
d0jC11XgWfuS/7PWg17j45Kr25+6WQD0gXxHTR+jFH3srzZPsgTjzoN1pUrMUUvU
9zfN8xZtRy9EZOQCDV5s9eP3PdaTJc3hNkkD4MzdD9ObrxGbfvqvzMtAOG2aEmMm
BtgpzOX0+0zOrVcwSvAO5Tp7FW3mJg==
=hIsf
-----END PGP SIGNATURE-----

--e6p2envurvrpju5r--

