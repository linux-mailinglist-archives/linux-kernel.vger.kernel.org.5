Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5747EB911
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjKNV7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKNV7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:59:19 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52692D5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:59:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r31R5-0008Aw-S1; Tue, 14 Nov 2023 22:59:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r31R4-009589-R4; Tue, 14 Nov 2023 22:59:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r31R4-001Yck-HA; Tue, 14 Nov 2023 22:59:06 +0100
Date:   Tue, 14 Nov 2023 22:59:06 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mubin Sayyed <mubin.sayyed@amd.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org, tglx@linutronix.de,
        daniel.lezcano@linaro.org, michal.simek@amd.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, git@amd.com,
        mubin10@gmail.com
Subject: Re: [LINUX PATCH v2 3/3] pwm: pwm-cadence: Add support for TTC PWM
Message-ID: <20231114215906.2q45o4w4epr6rpk5@pengutronix.de>
References: <20231114124748.581850-1-mubin.sayyed@amd.com>
 <20231114124748.581850-4-mubin.sayyed@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5uq3abaun4y5esps"
Content-Disposition: inline
In-Reply-To: <20231114124748.581850-4-mubin.sayyed@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5uq3abaun4y5esps
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Nov 14, 2023 at 06:17:48PM +0530, Mubin Sayyed wrote:
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 8ebcddf91f7b..7fd493f06496 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -152,6 +152,17 @@ config PWM_BRCMSTB
>  	  To compile this driver as a module, choose M Here: the module
>  	  will be called pwm-brcmstb.c.
> =20
> +config PWM_CADENCE
> +        tristate "Cadence PWM support"
> +        depends on OF
> +        depends on COMMON_CLK

An additional dependency on a SoC || COMPILE_TEST would be good to spare
users on (say) mips and x86 the question for PWM_CADENCE during
oldconfig.

> +        help
> +          Generic PWM framework driver for cadence TTC IP found on
> +          Xilinx Zynq/ZynqMP/Versal SOCs. Each TTC device has 3 PWM
> +          channels. Output of 0th PWM channel of each TTC device can
> +          be routed to MIO or EMIO, and output of 1st and 2nd PWM
> +          channels can be routed only to EMIO.
> +
>  config PWM_CLK
>  	tristate "Clock based PWM support"
>  	depends on HAVE_CLK || COMPILE_TEST
> [...]
> diff --git a/drivers/pwm/pwm-cadence.c b/drivers/pwm/pwm-cadence.c
> new file mode 100644
> index 000000000000..12aaa004bf7f
> --- /dev/null
> +++ b/drivers/pwm/pwm-cadence.c
> @@ -0,0 +1,370 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver to configure cadence TTC timer as PWM
> + * generator
> + *
> + * Limitations:
> + * - When PWM is stopped, timer counter gets stopped immediately. This
> + *   doesn't allow the current PWM period to complete and stops abruptly.
> + * - Disabled PWM emits inactive level.
> + * - When user requests a change in  any parameter of PWM (period/duty c=
ycle/polarity)

s/  / /

> + *   while PWM is in enabled state:
> + *	- PWM is stopped abruptly.
> + *	- Requested parameter is changed.
> + *	- Fresh PWM cycle is started.
> + *
> + * Copyright (C) 2023, Advanced Micro Devices, Inc.
> + */
> +
> [...]
> +static int ttc_pwm_apply(struct pwm_chip *chip,
> +			 struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct ttc_pwm_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> +	u64 duty_cycles, period_cycles;
> +	struct pwm_state cstate;
> +	unsigned long rate;
> +	bool flag =3D false;
> +	u32 div =3D 0;
> +
> +	cstate =3D pwm->state;

You only use cstate.enabled, so there is no need to copy the whole
struct to the stack.

> +	if (state->polarity !=3D cstate.polarity) {
> +		if (cstate.enabled)
> +			ttc_pwm_disable(priv, pwm);

If you set cstate.enabled =3D false here you can save another call to
ttc_pwm_disable() below.

> +		ttc_pwm_set_polarity(priv, pwm, state->polarity);
> +	}
> +
> +	rate =3D priv->rate;
> +
> +	/* Prevent overflow by limiting to the maximum possible period */
> +	period_cycles =3D min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
> +	period_cycles =3D mul_u64_u64_div_u64(period_cycles, rate, NSEC_PER_SEC=
);
> +
> +	if (period_cycles > priv->max) {
> +		/*
> +		 * Prescale frequency to fit requested period cycles within limit.
> +		 * Prescalar divides input clock by 2^(prescale_value + 1). Maximum
> +		 * supported prescalar value is 15.
> +		 */
> +		div =3D mul_u64_u64_div_u64(state->period, rate, (NSEC_PER_SEC * priv-=
>max));
> +		div =3D order_base_2(div);
> +		if (div)
> +			div -=3D 1;
> +
> +		if (div > 15)
> +			return -ERANGE;
> +
> +		rate =3D DIV_ROUND_CLOSEST(rate, BIT(div + 1));
> +		period_cycles =3D mul_u64_u64_div_u64(state->period, rate,
> +						    NSEC_PER_SEC);

=2Eapply() is supposed to yield the biggest possible period that isn't
bigger than the requested period.

I didn't do the complete maths, but I suspect this to be wrong for
several reasons:

 - div gets big if state->period is big. So div > 15 shouldn't result in
   -ERANGE but setting in a possible big period.
 - if (div) div -=3D 1; smells like you configure a too big period if
   div=3D0 was calculated. (Then you should return -ERANGE)
 - ROUND_CLOSEST is nearly always wrong in .apply()

If you test your driver with CONFIG_PWM_DEBUG enabled and then something
like:

	echo 0 > /sys/class/pwm/pwmchip0/export
	cd /sys/class/pwm/pwmchip0/pwm0
	echo 0 > duty_cycle
	seq 10000 500000 | while read p; do
		echo p > period
	done
	seq 500000 10000 -1 | while read p; do
		echo p > period
	done

should help you to get this right. (Pick a reasonable range for period
and test in 1ns steps.)

> +		flag =3D true;
> +	}
> +
> [...]
>
> +static int ttc_pwm_get_state(struct pwm_chip *chip,
> +			     struct pwm_device *pwm,
> +			     struct pwm_state *state)
> +{
> +	struct ttc_pwm_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> +	u32 value, pres_en, pres =3D 1;
> +	unsigned long rate;
> +	u64 tmp;
> +
> +	value =3D ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CNT_CNTRL);
> +
> +	if (value & TTC_CNTR_CTRL_WAVE_POL)
> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +	else
> +		state->polarity =3D PWM_POLARITY_INVERSED;
> +
> +	if (value & TTC_CNTR_CTRL_DIS)
> +		state->enabled =3D false;
> +	else
> +		state->enabled =3D true;
> +
> +	rate =3D priv->rate;
> +
> +	pres_en =3D  ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CLK_CNTRL);

s/  / /

> +	pres_en	&=3D TTC_CLK_CNTRL_PS_EN;
> +
> +	if (pres_en) {
> +		pres =3D ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CLK_CNTRL) & TTC_CLK_C=
NTRL_PSV;
> +		pres >>=3D TTC_CNTR_CTRL_PRESCALE_SHIFT;

Consider using FIELD_GET

> +		/* If prescale is enabled, the count rate is divided by 2^(pres + 1) */
> +		pres =3D BIT(pres + 1);
> +	}
> +
> [...]
> +
> +static const struct pwm_ops ttc_pwm_ops =3D {
> +	.apply =3D ttc_pwm_apply,
> +	.get_state =3D ttc_pwm_get_state,
> +	.owner =3D THIS_MODULE,

Assigning .owner isn't needed any more since
384461abcab6602abc06c2dfb8fb99beeeaa12b0.

> +};
> [...]
> +static void ttc_pwm_remove(struct platform_device *pdev)
> +{
> +	struct ttc_pwm_priv *priv =3D platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(&priv->chip);
> +	clk_rate_exclusive_put(priv->clk);

Hmm, if there was a devm_clk_rate_exclusive_get, you could get rid of
the remove callback.

> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5uq3abaun4y5esps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVT7akACgkQj4D7WH0S
/k71QAf9Fo7K3GCRMzSul17kU+4Cca6yfX0tGTouD0BGzWBLlzOGshLYauFhJfkd
3kNOHM66Wpe9FzpNNJwFwq5fU3z/5e/q8rS5AIHT752gAXnS0hh74agS9TzzAbP4
7ojcqmppFXkHEFLMweNh2jIEEgF0su8l7IINdIiGV4aq4MLcWlxp2pj2JY3Kcvey
KwZBZxUe3CjS0DEESRSAM0TKFPV9Ulb2yoD+H3m+gtQ3d3WlUE5FwQwDk44kajbt
lgjYhhjgV/ZZIghC7HB/x499GHRGPx61vr1mP9WzKLqEiMv8RkC0qmGe197r9qVw
LGQZ8e7R9cCDYj4P50G/p6sPudtVMg==
=RkVd
-----END PGP SIGNATURE-----

--5uq3abaun4y5esps--
