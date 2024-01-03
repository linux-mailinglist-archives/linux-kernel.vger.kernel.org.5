Return-Path: <linux-kernel+bounces-15516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E619F822D08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11681F2424A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FD019440;
	Wed,  3 Jan 2024 12:28:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804619442
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rL0MF-0005Mi-3Y; Wed, 03 Jan 2024 13:28:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rL0ME-00074u-0N; Wed, 03 Jan 2024 13:28:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rL0MD-003LfH-2x;
	Wed, 03 Jan 2024 13:28:25 +0100
Date: Wed, 3 Jan 2024 13:28:25 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Sean Young <sean@mess.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: bcm2835: Remove duplicate call to
 clk_rate_exclusive_put()
Message-ID: <sbcslehlbdhjggyb4thughrzuzjrbc3knbh3ulfhhi6mcrvayd@rbheyjouom6d>
References: <20231222131312.174491-1-sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j2t4mrma5c4f7diw"
Content-Disposition: inline
In-Reply-To: <20231222131312.174491-1-sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--j2t4mrma5c4f7diw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Dec 22, 2023 at 01:13:11PM +0000, Sean Young wrote:
> devm_add_action_or_reset() already calls the action in the error case.
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Closes: https://lore.kernel.org/linux-pwm/fuku3b5ur6y4k4refd3vmeoenzjo6mw=
e3b3gtel34rhhhtvnsa@w4uktgbqsc3w/
> Fixes: fcc760729359 ("pwm: bcm2835: Allow PWM driver to be used in atomic=
 context")
> Signed-off-by: Sean Young <sean@mess.org>
> Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-bcm2835.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
> index 307c0bd5f885..283cf27f25ba 100644
> --- a/drivers/pwm/pwm-bcm2835.c
> +++ b/drivers/pwm/pwm-bcm2835.c
> @@ -160,10 +160,8 @@ static int bcm2835_pwm_probe(struct platform_device =
*pdev)
> =20
>  	ret =3D devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclusive_pu=
t,
>  				       pc->clk);
> -	if (ret) {
> -		clk_rate_exclusive_put(pc->clk);
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	pc->rate =3D clk_get_rate(pc->clk);
>  	if (!pc->rate)

this patch should be added to your for-next branch and then your PR for
the next merge window.

Also "pwm: linux/pwm.h: fix Excess kernel-doc description warning"
(Message-Id: 20231223050621.13994-1-rdunlap@infradead.org) should be
added IMHO.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--j2t4mrma5c4f7diw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWVUugACgkQj4D7WH0S
/k4FPgf+KciZuFT4wJCWNSuCGXQuJYPIGrhYmOixhFTfChRratxydUme6qGd0hRC
Pvvyw9As/U4FF5tv/3CWxuFC/ZiXe75ZgekP/Hn3NF2e0mQFSVTZtL5MZtNLC3X0
gGnWSV3k33UrNvxBp6x7ib176BVTXeQ13n+w5AHdMHXy8thKsc5sIHCPfKqm0Scu
otgt5pUJsVwnIVVP8eEDB4XjLD9SDZGaJB8zjpDPLh5CuKYdRmJcvi1Z/Cs1AtSt
NNIRcHUZxrrfDj/RWXtmwS+T8yRS4+/LEUOWnQjwnxapskk0M90JZhiUfrNuQIk6
7r6iI9Nd7GkkUyxIsO0FIeSV0gED4A==
=9tQB
-----END PGP SIGNATURE-----

--j2t4mrma5c4f7diw--

