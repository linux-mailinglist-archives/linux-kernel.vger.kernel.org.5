Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69E07DF130
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347433AbjKBLae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjKBLac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:30:32 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B38111
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:30:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qyVtz-0005lO-6l; Thu, 02 Nov 2023 12:30:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qyVtw-0063ea-Mn; Thu, 02 Nov 2023 12:30:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qyVtw-00BVjO-DL; Thu, 02 Nov 2023 12:30:16 +0100
Date:   Thu, 2 Nov 2023 12:30:16 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v6 2/4] pwm: opencores: Add PWM driver support
Message-ID: <20231102113016.jgsh7jru6vjv4vsp@pengutronix.de>
References: <20231020103741.557735-1-william.qiu@starfivetech.com>
 <20231020103741.557735-3-william.qiu@starfivetech.com>
 <20231020112539.gctx5uj2rrhryulo@pengutronix.de>
 <7d64ea1d-b573-4a69-ba0c-4cbfab638c5e@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ltmjasklp4ngpzku"
Content-Disposition: inline
In-Reply-To: <7d64ea1d-b573-4a69-ba0c-4cbfab638c5e@starfivetech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ltmjasklp4ngpzku
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello William,

On Wed, Nov 01, 2023 at 10:22:44AM +0800, William Qiu wrote:
>=20
>=20
> On 2023/10/20 19:25, Uwe Kleine-K=C3=B6nig wrote:
> >> +	void __iomem *base =3D pwm->data->get_ch_base ?
> >> +			     pwm->data->get_ch_base(pwm->regs, dev->hwpwm) : pwm->regs;
> >> +	u32 period_data, duty_data, ctrl_data;
> >> +
> >> +	period_data =3D readl(REG_OCPWM_LRC(base));
> >> +	duty_data =3D readl(REG_OCPWM_HRC(base));
> >> +	ctrl_data =3D readl(REG_OCPWM_CTRL(base));
> >> +
> >> +	state->period =3D DIV_ROUND_CLOSEST_ULL((u64)period_data * NSEC_PER_=
SEC, pwm->clk_rate);
> >> +	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL((u64)duty_data * NSEC_PE=
R_SEC, pwm->clk_rate);
> >=20
> > Please test your driver with PWM_DEBUG enabled. The rounding is wrong
> > here.
>=20
> The conclusion after checking is: when the period or duty_cycle value set
> by the user is not divisible (1000000000/49.5M), there will be an error.
> This error is due to hardware accuracy. So why is rounding is wrong?
> rockchip also has a similar implementation drivers/pwm/ pwm-rockchip.c

I fail to follow. Where is an error?

The general policy (for new drivers at least) is to implement the
biggest period possible not bigger than the requested period. That means
that .apply must round down and to make .apply =E2=88=98 .get_state idempot=
ent
=2Eget_state must round up to match.

Assuming a clkrate of 49500000 Hz the actual period for REG_OCPWM_LRC =3D
400 is 8080.808ns and for REG_OCPWM_LRC =3D 401 is 8101.010.

So with REG_OCPWM_LRC =3D 401 .get_state should report state.period =3D 8102
[ns] because if you call .apply with .period =3D 8101 [ns] you're supposed
to use REG_OCPWM_LRC =3D 400.

Rounding using DIV_ROUND_CLOSEST doesn't give consistent behaviour in
some cases. Consider a PWM that can implement the following periods (and
none in between):

	20.1 ns
	20.4 ns
	21.7 ns

With round-to-nearest a request to configure 21 ns will yield 20.4 ns.
If you call .get_state there the driver will return 20 ns. However
configuring 20 ns results in a period of 20.1 ns.

With rounding as requested above you get a consistent behaviour. After
=2Eapply_state(period=3D21) .get_state() returns period=3D21.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ltmjasklp4ngpzku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVDiEcACgkQj4D7WH0S
/k5P5Qf/czkHt1isZ7/ZX5Q+xUYicANztUd5HO2YB1j1TaGv02Q8gE7OomO6Nk/8
NYYx0uxugJPlJlUQ5omGaZzFBE0neKAIfZXuKL7OfIOIIL+dusgvYnY2TRGJWIBQ
o8z9IyZKGh46aUnC2ZToUYJAYqYAxpr3TkUkPl8xVgSlPvgM8uwWAAxyuJWWR/Pk
+rm6Kl2Hb3nZ1tnH1OpV2W8kisHQjtyBR0TWtpjioDSpO7IEp1wlg6ayVPcQQTJe
kHkf/l/RUEVqo7D3nzmg17qT8vzzPGjk2kgm42A9ce6jUAcemq0MOIQtLfS7vWjJ
vM/+J3PQqV+D4wuWImRyKwZ5chY6Pg==
=rI74
-----END PGP SIGNATURE-----

--ltmjasklp4ngpzku--
