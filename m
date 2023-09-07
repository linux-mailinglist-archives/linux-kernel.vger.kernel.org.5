Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B5D797E01
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241097AbjIGVgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjIGVgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:36:46 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B42B4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:36:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qeMg1-0006SJ-I4; Thu, 07 Sep 2023 23:36:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qeMg0-004jr3-P6; Thu, 07 Sep 2023 23:36:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qeMg0-00HHlU-4M; Thu, 07 Sep 2023 23:36:36 +0200
Date:   Thu, 7 Sep 2023 23:36:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v9 5/6] pwm: dwc: round rate divisions up
Message-ID: <20230907213635.6ba43chppu556vda@pengutronix.de>
References: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
 <20230907161242.67190-6-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zjadyif7tjva2din"
Content-Disposition: inline
In-Reply-To: <20230907161242.67190-6-ben.dooks@codethink.co.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zjadyif7tjva2din
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[again dropped William Salmon and Jude Onyenegecha from Cc:]

On Thu, Sep 07, 2023 at 05:12:41PM +0100, Ben Dooks wrote:
> As suggested, round up the counter variables to ensure we
> always produce a longer period calculation.
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/pwm/pwm-dwc-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
> index 3b856685029d..6358e3345210 100644
> --- a/drivers/pwm/pwm-dwc-core.c
> +++ b/drivers/pwm/pwm-dwc-core.c
> @@ -50,13 +50,13 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *=
dwc,
>  	 * 2^32 periods.
>  	 */
>  	tmp =3D state->duty_cycle * dwc->clk_rate;
> -	tmp =3D DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
> +	tmp =3D DIV_ROUND_UP_ULL(tmp, NSEC_PER_SEC);
>  	if (tmp < 1 || tmp > (1ULL << 32))
>  		return -ERANGE;
>  	low =3D tmp - 1;
> =20
>  	tmp =3D (state->period - state->duty_cycle) * dwc->clk_rate;
> -	tmp =3D DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
> +	tmp =3D DIV_ROUND_UP_ULL(tmp, NSEC_PER_SEC);
>  	if (tmp < 1 || tmp > (1ULL << 32))
>  		return -ERANGE;
>  	high =3D tmp - 1;

Ah, I asked for that in the reply I just sent out to patch #4. Maybe move
this before the change from #4?! I think .get_state needs to be adapted
accoringly (to round up).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zjadyif7tjva2din
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT6QmMACgkQj4D7WH0S
/k7E7QgAhxtTekFoISHtJ7riG1jyCNJbZSIpgwUdr+xwVyFN1iLPIQEpctjB8T3W
sRIM+GGYfGMC8KrSSNBdHYAdeqhYqHidjPfVrn2M9GJwooOj2UXSIiAdknexI21E
lgieYthN6RlvXEygpjuEjACclj2ZtoGc5pDHM0Cmhou0jwTgbRWmnhnsu3VIbVsE
pdpXph0ETF02/Blb6XXs9xFnwmCZGhYzrqlALr7oO5mSDN/lmfG15rwZIcHavA7g
FbKhENNfNPoyj2MwasYr3rQ9so8SbWrIDMa/E+wxcs96NYHvF0WBaSkqG5Pld+Mq
RqLQXB7At45ygSziqGLYOnNH0ZS/ug==
=ylew
-----END PGP SIGNATURE-----

--zjadyif7tjva2din--
