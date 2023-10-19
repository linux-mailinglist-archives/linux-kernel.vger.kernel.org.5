Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293A97CF295
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344924AbjJSIaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbjJSIaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:30:02 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2AB121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:29:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtOPX-0000km-Ux; Thu, 19 Oct 2023 10:29:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtOPV-002kV4-OO; Thu, 19 Oct 2023 10:29:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtOPV-001Qqd-CG; Thu, 19 Oct 2023 10:29:41 +0200
Date:   Thu, 19 Oct 2023 10:29:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thierry.reding@gmail.com, ndesaulniers@google.com, trix@redhat.com,
        baruch@tkos.co.il, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-pwm@vger.kernel.org, nathan@kernel.org
Subject: Re: [PATCH V15 1/4] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <20231019082941.xxdurxxuol27mzre@pengutronix.de>
References: <20231005160550.2423075-1-quic_devipriy@quicinc.com>
 <20231005160550.2423075-2-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tiozvo3ljdnwmd56"
Content-Disposition: inline
In-Reply-To: <20231005160550.2423075-2-quic_devipriy@quicinc.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tiozvo3ljdnwmd56
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 09:35:47PM +0530, Devi Priya wrote:
> diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
> new file mode 100644
> index 000000000000..5dbe46bb56d6
> --- /dev/null
> +++ b/drivers/pwm/pwm-ipq.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reserv=
ed.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/math64.h>
> +#include <linux/of_device.h>
> +#include <linux/bitfield.h>
> +#include <linux/units.h>
> +
> +/* The frequency range supported is 1 Hz to clock rate */
> +#define IPQ_PWM_MAX_PERIOD_NS	((u64)NSEC_PER_SEC)
> +
> +/*
> + * The max value specified for each field is based on the number of bits
> + * in the pwm control register for that field
> + */
> +#define IPQ_PWM_MAX_DIV		0xFFFF
> +
> +/*
> + * Two 32-bit registers for each PWM: REG0, and REG1.
> + * Base offset for PWM #i is at 8 * #i.
> + */
> +#define IPQ_PWM_REG0			0
> +#define IPQ_PWM_REG0_PWM_DIV		GENMASK(15, 0)
> +#define IPQ_PWM_REG0_HI_DURATION	GENMASK(31, 16)
> +
> +#define IPQ_PWM_REG1			4
> +#define IPQ_PWM_REG1_PRE_DIV		GENMASK(15, 0)
> +/*
> + * Enable bit is set to enable output toggling in pwm device.
> + * Update bit is set to reflect the changed divider and high duration
> + * values in register.
> + */
> +#define IPQ_PWM_REG1_UPDATE		BIT(30)
> +#define IPQ_PWM_REG1_ENABLE		BIT(31)
> +
> +struct ipq_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *mem;
> +};
> +
> +static struct ipq_pwm_chip *ipq_pwm_from_chip(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct ipq_pwm_chip, chip);
> +}
> +
> +static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned in=
t reg)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D ipq_pwm_from_chip(pwm->chip);
> +	unsigned int off =3D 8 * pwm->hwpwm + reg;
> +
> +	return readl(ipq_chip->mem + off);
> +}
> +
> +static void ipq_pwm_reg_write(struct pwm_device *pwm, unsigned int reg,
> +			      unsigned int val)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D ipq_pwm_from_chip(pwm->chip);
> +	unsigned int off =3D 8 * pwm->hwpwm + reg;
> +
> +	writel(val, ipq_chip->mem + off);
> +}
> +
> +static void config_div_and_duty(struct pwm_device *pwm, unsigned int pre=
_div,
> +				unsigned int pwm_div, unsigned long rate, u64 duty_ns,
> +				bool enable)
> +{
> +	unsigned long hi_dur;
> +	unsigned long val =3D 0;
> +
> +	/*
> +	 * high duration =3D pwm duty * (pwm div + 1)
> +	 * pwm duty =3D duty_ns / period_ns
> +	 */
> +	hi_dur =3D div64_u64(duty_ns * rate, (pre_div + 1) * NSEC_PER_SEC);
> +
> +	val =3D FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
> +		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG0, val);
> +
> +	val =3D FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
> +
> +	/* PWM enable toggle needs a separate write to REG1 */
> +	val |=3D IPQ_PWM_REG1_UPDATE;
> +	if (enable)
> +		val |=3D IPQ_PWM_REG1_ENABLE;
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
> +}
> +
> +static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D ipq_pwm_from_chip(chip);
> +	unsigned int pre_div, pwm_div, best_pre_div, best_pwm_div;
> +	unsigned long rate =3D clk_get_rate(ipq_chip->clk);
> +	u64 period_ns, duty_ns, period_rate;
> +	u64 min_diff;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (state->period < DIV64_U64_ROUND_UP(NSEC_PER_SEC, rate))
> +		return -ERANGE;
> +
> +	period_ns =3D min(state->period, IPQ_PWM_MAX_PERIOD_NS);
> +	duty_ns =3D min(state->duty_cycle, period_ns);
> +
> +	/*
> +	 * period_ns is 1G or less. As long as rate is less than 16 GHz,
> +	 * period_rate does not overflow. Make that explicit.
> +	 */
> +	if ((unsigned long long)rate > 16ULL * GIGA)
> +		return -EINVAL;
> +	period_rate =3D period_ns * rate;
> +	best_pre_div =3D IPQ_PWM_MAX_DIV;
> +	best_pwm_div =3D IPQ_PWM_MAX_DIV;
> +	/*
> +	 * We don't need to consider pre_div values smaller than
> +	 *
> +	 *                              period_rate
> +	 *  pre_div_min :=3D ------------------------------------
> +	 *                 NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1)
> +	 *
> +	 * because pre_div =3D pre_div_min results in a better
> +	 * approximation.
> +	 */
> +	pre_div =3D div64_u64(period_rate,
> +			    (u64)NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1));

Consider period_ns =3D 0x10000 and rate =3D NSEC_PER_SEC. Then we get
pre_div =3D 1 ...

> +	min_diff =3D period_rate;
> +
> +	for (; pre_div <=3D IPQ_PWM_MAX_DIV; pre_div++) {
> +		u64 remainder;
> +
> +		pwm_div =3D div64_u64_rem(period_rate,
> +					(u64)NSEC_PER_SEC * (pre_div + 1), &remainder);
> +		/* pwm_div is unsigned; the check below catches underflow */
> +		pwm_div--;

=2E.. pwm_div then will be 0x7fff and remainder is 0. This is wrong, isn't
it? I think you lack a -1 in the assignment of pre_div above. And/or you
need to round up the division?

Having said that the loop here is quite heavy. I'd opt for restricing
pwm_div to 0xfffe (to get a finegrained domain for HI_DURATION) and then
the appropriate value for pre_div can be computed in a single division.
While being more coarse for the domain of periods, a simple algorithm is
worth quite a lot (for reviewers of your code and also for consumers
that benefit from a small runtime of .apply()) and you get a
fine-grained domain for duty_cycle. In my experience outweighs the
increased precision for the period.

> +		/*
> +		 * Swapping values for pre_div and pwm_div produces the same
> +		 * period length. So we can skip all settings with pre_div >
> +		 * pwm_div which results in bigger constraints for selecting
> +		 * the duty_cycle than with the two values swapped.
> +		 */
> +		if (pre_div > pwm_div)
> +			break;
> +
> +		/*
> +		 * Make sure we can do 100% duty cycle where
> +		 * hi_dur =3D=3D pwm_div + 1
> +		 */
> +		if (pwm_div > IPQ_PWM_MAX_DIV - 1)
> +			continue;
> +
> +		if (remainder < min_diff) {
> +			best_pre_div =3D pre_div;
> +			best_pwm_div =3D pwm_div;
> +			min_diff =3D remainder;
> +
> +			if (min_diff =3D=3D 0) /* bingo */
> +				break;
> +		}
> +	}
> +
> +	/* config divider values for the closest possible frequency */
> +	config_div_and_duty(pwm, best_pre_div, best_pwm_div,
> +			    rate, duty_ns, state->enabled);
> +
> +	return 0;
> +}
> +
> +static int ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     struct pwm_state *state)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D ipq_pwm_from_chip(chip);
> +	unsigned long rate =3D clk_get_rate(ipq_chip->clk);
> +	unsigned int pre_div, pwm_div, hi_dur;
> +	u64 effective_div, hi_div;
> +	u32 reg0, reg1;
> +
> +	reg0 =3D ipq_pwm_reg_read(pwm, IPQ_PWM_REG0);
> +	reg1 =3D ipq_pwm_reg_read(pwm, IPQ_PWM_REG1);
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	state->enabled =3D reg1 & IPQ_PWM_REG1_ENABLE;
> +
> +	pwm_div =3D FIELD_GET(IPQ_PWM_REG0_PWM_DIV, reg0);
> +	hi_dur =3D FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
> +	pre_div =3D FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
> +
> +	/* No overflow here, both pre_div and pwm_div <=3D 0xffff */
> +	effective_div =3D (u64)(pre_div + 1) * (pwm_div + 1);

This cast is not needed.

> +	state->period =3D DIV64_U64_ROUND_UP(effective_div * NSEC_PER_SEC, rate=
);
> +
> +	hi_div =3D hi_dur * (pre_div + 1);
> +	state->duty_cycle =3D DIV64_U64_ROUND_UP(hi_div * NSEC_PER_SEC, rate);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops ipq_pwm_ops =3D {
> +	.apply =3D ipq_pwm_apply,
> +	.get_state =3D ipq_pwm_get_state,
> +	.owner =3D THIS_MODULE,

With 384461abcab6 in next
(https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.g=
it/log/?h=3Dfor-next,
currently for-next~30), the .owner line should be dropped.
=2E.ooOO(You claimed to have dropped that for v5 already in the changelog
above.  Hmm?!)

> +};
> +
> +static int ipq_pwm_probe(struct platform_device *pdev)
> +{
> +	struct ipq_pwm_chip *pwm;
> +	struct device *dev =3D &pdev->dev;
> +	int ret;
> +
> +	pwm =3D devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	pwm->mem =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pwm->mem))
> +		return dev_err_probe(dev, PTR_ERR(pwm->mem),
> +				"regs map failed");
> +
> +	pwm->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
> +				"failed to get clock");
> +
> +	ret =3D clk_prepare_enable(pwm->clk);

devm_clk_get_enabled()

> +	if (ret)
> +		return dev_err_probe(dev, ret, "clock enable failed");
> +
> +	pwm->chip.dev =3D dev;
> +	pwm->chip.ops =3D &ipq_pwm_ops;
> +	pwm->chip.npwm =3D 4;
> +
> +	ret =3D pwmchip_add(&pwm->chip);

devm_pwmchip_add()

> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "pwmchip_add() failed\n");
> +		clk_disable_unprepare(pwm->clk);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ipq_pwm_remove(struct platform_device *pdev)
> +{
> +	struct ipq_pwm_chip *pwm =3D platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(&pwm->chip);
> +	clk_disable_unprepare(pwm->clk);
> +
> +	return 0;
> +}

With the above suggestions .remove can be dropped. If there is still a
reason to keep it in the next revision, please switch to .remove_new().

> +static const struct of_device_id pwm_ipq_dt_match[] =3D {
> +	{ .compatible =3D "qcom,ipq6018-pwm", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, pwm_ipq_dt_match);
> +
> +static struct platform_driver ipq_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "ipq-pwm",
> +		.of_match_table =3D pwm_ipq_dt_match,
> +	},
> +	.probe =3D ipq_pwm_probe,
> +	.remove =3D ipq_pwm_remove,
> +};
> +
> +module_platform_driver(ipq_pwm_driver);
> +
> +MODULE_LICENSE("Dual BSD/GPL");

I don't oppose to this dual licensing, but I wonder what the motivation
is. Seeing that the copyright is assigned to the Linux Foundation, is
this related to Zephyr? (Which however uses an Apache license.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tiozvo3ljdnwmd56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUw6PQACgkQj4D7WH0S
/k5JDAf/QTyGiIqtIixGZYUoHAtCHVTTj83eKEZEFVidw8hS+/iTQoP0DVKwfGwp
NmXUiqNLVr2d7IboHGSP9UVqP87KizG3VUFZorPeNu0BIu9FuDvPkFJb0xwn1W6R
zox/f5unqyeOOwCnTx4H/sbEkZHtsd5ehRKtPH7yfY/yeEPOdgNDFNIPjzjsgLgV
5VUFuGrZIG7VT/igfqjCGIIzQo5+Gq2Bqcb+76U68Gsl76tru0mrZi6eHhRXpV/d
ddKJFctTh2Mh+6wmS/jONPeXlphJRQV4JyEqen+63gfnW7s/1qr9l8XmGRE8RT2D
dSyGGv9WiqFn6+TBbGgKB+3d/BZm2g==
=7Qfc
-----END PGP SIGNATURE-----

--tiozvo3ljdnwmd56--
