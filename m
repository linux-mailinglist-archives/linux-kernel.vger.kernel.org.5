Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3230F7B9EF5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjJEOQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjJEOOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:14:12 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE167A257
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 02:17:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoKTr-0004yM-Uh; Thu, 05 Oct 2023 11:17:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoKTp-00BEVG-Mk; Thu, 05 Oct 2023 11:17:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoKTp-009Nwv-Ca; Thu, 05 Oct 2023 11:17:13 +0200
Date:   Thu, 5 Oct 2023 11:17:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 1/2] pwm: make it possible to apply pwm changes in atomic
 context
Message-ID: <20231005091713.jgx5h2ss4oybdxq7@pengutronix.de>
References: <cover.1696156485.git.sean@mess.org>
 <1bd5241d584ceb4d6b731c4dc3203fb9686ee1d1.1696156485.git.sean@mess.org>
 <20231004095920.ne7yrrthow6tnuvg@pengutronix.de>
 <ZR50KCVNzhlLooLW@gofer.mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x5d57cuv6lgyekgb"
Content-Disposition: inline
In-Reply-To: <ZR50KCVNzhlLooLW@gofer.mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x5d57cuv6lgyekgb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Thu, Oct 05, 2023 at 09:30:32AM +0100, Sean Young wrote:
> On Wed, Oct 04, 2023 at 11:59:20AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Sun, Oct 01, 2023 at 11:40:29AM +0100, Sean Young wrote:
> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > index dc66e3405bf5..d9679ae5b2be 100644
> > > --- a/drivers/pwm/core.c
> > > +++ b/drivers/pwm/core.c
> > > @@ -505,7 +505,7 @@ int pwm_apply_state(struct pwm_device *pwm, const=
 struct pwm_state *state)
> > >  	 * is a bad idea. So make it explicit that calling this function mi=
ght
> > >  	 * sleep.
> > >  	 */
> > > -	might_sleep();
> > > +	might_sleep_if(pwm_can_sleep(pwm));
> > > =20
> > >  	if (!pwm || !state || !state->period ||
> > >  	    state->duty_cycle > state->period)
> >=20
> > I'd like to have a mechanism to catch drivers that missed to set
> > .can_sleep. The best idea I currently have for that is to disable
> > preemption if IS_ENABLED(CONFIG_PWM_DEBUG) && !pwm_can_sleep(pwm) while
> > .apply() is running.
>=20
> If we have pwm_apply_state_atomic(), then CONFIG_DEBUG_ATOMIC_SLEEP will
> catch them, but only in that code path of course.
>=20
> How about using non_block_start() and non_block_end() if can_sleep is
> not set?

TIL, looks like it was created for that task.

> > > diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
> > > index b7c6045c5d08..b8b9392844e9 100644
> > > --- a/drivers/pwm/pwm-fsl-ftm.c
> > > +++ b/drivers/pwm/pwm-fsl-ftm.c
> > > @@ -405,6 +405,7 @@ static int fsl_pwm_probe(struct platform_device *=
pdev)
> > > =20
> > >  	fpc->soc =3D of_device_get_match_data(&pdev->dev);
> > >  	fpc->chip.dev =3D &pdev->dev;
> > > +	fpc->chip.can_sleep =3D true;
> >=20
> > Also I wonder if the distinction between atomic and sleeping
> > pwm_state_apply() should be more explicit. For GPIOs you have a sleeping
> > variant gpiod_set_value_cansleep() that allows to immediately determine
> > the intended context in the caller. This would allow that programming
> > a PWM stays a preemption point (if possible/desired) even if the
> > underlying hardware/driver is atomic. To not have to touch all consumer
> > drivers, maybe the pair for pwm should better be
> >=20
> > 	pwm_apply_state()
> > 	pwm_apply_state_atomic()
>=20
> Do we need pwm_config_atomic(), pwm_enable_atomic(), and pwm_disable_atom=
ic()
> too? These are just convenience functions, so we can probably do without =
them.

I'd like to get rid of these, so for now I'd keep them as is.

> > instead of a "cansleep" suffix for the sleeping variant? Or maybe it's
> > better to accept touching all consumer drivers to get semantics similar
> > to gpio? I couldn't decide quickly what I really like better here, so
> > that's your chance to comment and influence the outcome :-)
>=20
> If you expect to have more parameters for pwm_apply_state() then a flags
> argument makes sense.

Actually I don't want more parameters -- at least for this use case. I
could imagine another parameter for something like apply-immediately vs.
complete-current-period, but that's another topic.

> TBH I like the pwm_apply_state_atomic() option.

ok.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--x5d57cuv6lgyekgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUefxgACgkQj4D7WH0S
/k7aWAf+OxUfKBgEw3SVXriToMTyS73Uv7QeEY7QBZpX1vw08Ec0hP5Cww0L95e+
ppjZ4O7YXmKcbOwHiakO3lKrm4KgzdpGqt+GV4zaBiubE8Wk6OyNN+P0bMe4jS2l
uCOtDw9qDw8fSDGZsXTZTfGkdAUcGBnPR2gXJEF7avXghW4EWKmspE7+tS6d07Sl
ItOiLn/AyScHsTWq4irGhaTe0K+eaM/GO3blwSu38ar3Pt3JCu5PEOxcRextT+cq
f6eAObmnxL2JrR4M8szNwMEdm/1iRf0xUcAcpYs3biYbhq074kiN1X+NJ0dCtvCH
2P1yNSi9esnY8j6X9ZGw1FLJA3kj1A==
=bWrr
-----END PGP SIGNATURE-----

--x5d57cuv6lgyekgb--
