Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EAB7B819A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbjJDOB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242752AbjJDOB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:01:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB370C6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:01:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo2RV-0007IT-QQ; Wed, 04 Oct 2023 16:01:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo2RU-00B2s9-VL; Wed, 04 Oct 2023 16:01:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo2RU-0090ZQ-Lc; Wed, 04 Oct 2023 16:01:36 +0200
Date:   Wed, 4 Oct 2023 16:01:30 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/2] pwm: add T-HEAD PWM driver
Message-ID: <20231004140130.ljsfpn4axmsmszwm@pengutronix.de>
References: <20231004092731.1362-1-jszhang@kernel.org>
 <20231004092731.1362-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xfwfxxt6t7o62knb"
Content-Disposition: inline
In-Reply-To: <20231004092731.1362-3-jszhang@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xfwfxxt6t7o62knb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 05:27:31PM +0800, Jisheng Zhang wrote:
> T-HEAD SoCs such as the TH1520 contain a PWM controller used
> to control the LCD backlight, fan and so on. Add driver for it.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  MAINTAINERS             |   1 +
>  drivers/pwm/Kconfig     |  11 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-thead.c | 274 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 287 insertions(+)
>  create mode 100644 drivers/pwm/pwm-thead.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d55e40060c46..86cf0926dbfc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18482,6 +18482,7 @@ L:	linux-riscv@lists.infradead.org
>  S:	Maintained
>  F:	arch/riscv/boot/dts/thead/
>  F:	drivers/usb/dwc3/dwc3-thead.c
> +F:	drivers/pwm/pwm-thead.c
> =20
>  RNBD BLOCK DRIVERS
>  M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 8ebcddf91f7b..428fa365a19a 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -637,6 +637,17 @@ config PWM_TEGRA
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-tegra.
> =20
> +config PWM_THEAD
> +	tristate "T-HEAD PWM support"
> +	depends on ARCH_THEAD || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Generic PWM framework driver for the PWFM controller found on THEAD
> +	  SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-thead.
> +
>  config PWM_TIECAP
>  	tristate "ECAP PWM support"
>  	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARC=
H_K3 || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c822389c2a24..4c317e6316e8 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
>  obj-$(CONFIG_PWM_SUNPLUS)	+=3D pwm-sunplus.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
> +obj-$(CONFIG_PWM_THEAD)		+=3D pwm-thead.o
>  obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
>  obj-$(CONFIG_PWM_TIEHRPWM)	+=3D pwm-tiehrpwm.o
>  obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
> diff --git a/drivers/pwm/pwm-thead.c b/drivers/pwm/pwm-thead.c
> new file mode 100644
> index 000000000000..ba1e3a4f1027
> --- /dev/null
> +++ b/drivers/pwm/pwm-thead.c
> @@ -0,0 +1,274 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * T-HEAD PWM driver
> + *
> + * Copyright (C) 2021 Alibaba Group Holding Limited.
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + *
> + * Limitations:
> + * - The THEAD_PWM_START bit is only effective when 0 -> 1, which is use=
d to
> + *   start the channel, 1 -> 0 doesn't change anything. so 0 % duty cycl=
e is
> + *   used to "disable" the channel.
> + * - The PWM_CFG_UPDATE atomically updates and only updates period and d=
uty.
> + * - To update period and duty, PWM_CFG_UPDATE needs to go through 0 -> =
1 step,
> + *   I.E if PWM_CFG_UPDATE is already 1, it's necessary to clear it to 0
> + *   beforehand.
> + * - Polarity can only be changed if never started before.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

Looking at 0a41b0c5d97a3758ad102cec469aaa79c7d406b7 I think you want
linux/mod_devicetable.h here instead of of_device.h.

> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +
> +#define THEAD_PWM_MAX_NUM		6
> +#define THEAD_PWM_MAX_PERIOD		GENMASK(31, 0)
> +#define THEAD_PWM_MAX_DUTY		GENMASK(31, 0)
> +
> +#define THEAD_PWM_CHN_BASE(n)		((n) * 0x20)
> +#define THEAD_PWM_CTRL(n)		(THEAD_PWM_CHN_BASE(n) + 0x00)
> +#define THEAD_PWM_RPT(n)		(THEAD_PWM_CHN_BASE(n) + 0x04)
> +#define THEAD_PWM_PER(n)		(THEAD_PWM_CHN_BASE(n) + 0x08)
> +#define THEAD_PWM_FP(n)			(THEAD_PWM_CHN_BASE(n) + 0x0c)
> +#define THEAD_PWM_STATUS(n)		(THEAD_PWM_CHN_BASE(n) + 0x10)
> +
> +/* bit definition PWM_CTRL */
> +#define THEAD_PWM_START			BIT(0)

This is a bit in THEAD_PWM_CTRL(n), so I'd propose THEAD_PWM_CTRL_START
as a name.

> +#define THEAD_PWM_SOFT_RST		BIT(1)
> +#define THEAD_PWM_CFG_UPDATE		BIT(2)
> +#define THEAD_PWM_INT_EN		BIT(3)
> +#define THEAD_PWM_MODE_MASK		GENMASK(5, 4)

I'd drop "_MASK" here (and add _CTRL).

> +#define THEAD_PWM_ONE_SHOT_MODE		FIELD_PREP(THEAD_PWM_MODE_MASK, 1)

This is unused

> +#define THEAD_PWM_CONTINUOUS_MODE	FIELD_PREP(THEAD_PWM_MODE_MASK, 2)

THEAD_PWM_CTRL_MODE_CONTINUOUS ?

> +#define THEAD_PWM_EVTRIG_MASK		GENMASK(7, 6)
> +#define THEAD_PWM_FPOUT			BIT(8)
> +#define THEAD_PWM_INFACTOUT		BIT(9)
> +
> +struct thead_pwm_chip {
> +	struct pwm_chip chip;
> +	void __iomem *mmio_base;
> +	struct clk *clk;
> +	bool ever_started;
> +};
> +
> +static inline struct thead_pwm_chip *thead_pwm_from_chip(struct pwm_chip=
 *chip)
> +{
> +	return container_of(chip, struct thead_pwm_chip, chip);
> +}
> +
> +static int thead_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct thead_pwm_chip *priv =3D thead_pwm_from_chip(chip);
> +	u64 period_cycle, duty_cycle, rate;
> +	u32 val;
> +
> +	/* if ever started, can't change the polarity */
> +	if (priv->ever_started && state->polarity !=3D pwm->state.polarity)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		if (pwm->state.enabled) {
> +			val =3D readl(priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
> +			val &=3D ~THEAD_PWM_CFG_UPDATE;
> +			writel(val, priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
> +
> +			writel(0, priv->mmio_base + THEAD_PWM_FP(pwm->hwpwm));
> +
> +			val |=3D THEAD_PWM_CFG_UPDATE;
> +			writel(val, priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
> +		}
> +		return 0;
> +	}
> +
> +	if (!pwm->state.enabled)
> +		pm_runtime_get_sync(chip->dev);

pm_runtime_get_sync() returns an int that you shouldn't ignore.

> +	val =3D readl(priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
> +	val &=3D ~THEAD_PWM_CFG_UPDATE;
> +
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		val &=3D ~THEAD_PWM_FPOUT;
> +	else
> +		val |=3D THEAD_PWM_FPOUT;

What happens here if the bootloader already touched that flag? Or the
driver is reloaded/rebound?

> +	writel(val, priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
> +
> +	rate =3D clk_get_rate(priv->clk);
> +	/*
> +	 * The following calculations might overflow if clk is bigger
> +	 * than 1 GHz. In practise it's 24MHz, so this limitation
> +	 * is only theoretic.
> +	 */
> +	if (rate > (u64)NSEC_PER_SEC)

this cast isn't needed.

> +		return -EINVAL;
> +
> +	period_cycle =3D mul_u64_u64_div_u64(rate, state->period, NSEC_PER_SEC);
> +	if (period_cycle > THEAD_PWM_MAX_PERIOD)
> +		period_cycle =3D THEAD_PWM_MAX_PERIOD;
> +	/*
> +	 * With limitation above we have period_cycle <=3D THEAD_PWM_MAX_PERIOD,
> +	 * so this cannot overflow.
> +	 */
> +	writel((u32)period_cycle, priv->mmio_base + THEAD_PWM_PER(pwm->hwpwm));

This cast can also be dropped.

> +
> +	duty_cycle =3D mul_u64_u64_div_u64(rate, state->duty_cycle, NSEC_PER_SE=
C);
> +	if (duty_cycle > THEAD_PWM_MAX_DUTY)
> +		duty_cycle =3D THEAD_PWM_MAX_DUTY;
> +	/*
> +	 * With limitation above we have duty_cycle <=3D THEAD_PWM_MAX_PERIOD,
> +	 * so this cannot overflow.
> +	 */
> +	writel((u32)duty_cycle, priv->mmio_base + THEAD_PWM_FP(pwm->hwpwm));

=2E..

> +
> +	val |=3D THEAD_PWM_CFG_UPDATE;
> +	writel(val, priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
> +
> +	if (!pwm->state.enabled) {
> +		val |=3D THEAD_PWM_START;
> +		writel(val, priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
> +		priv->ever_started =3D true;
> +	}

Further above you conditionally call pm_runtime_get_sync(), there should
be a matching pm_runtime_put().

> +
> +	return 0;
> +}
> +
> +static int thead_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       struct pwm_state *state)
> +{
> +	struct thead_pwm_chip *priv =3D thead_pwm_from_chip(chip);
> +	u64 rate =3D clk_get_rate(priv->clk);
> +	u32 val;
> +
> +	pm_runtime_get_sync(chip->dev);
> +
> +	val =3D readl(priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
> +	state->enabled =3D !!(val & THEAD_PWM_START);
> +	if (val & THEAD_PWM_FPOUT)
> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +	else
> +		state->polarity =3D PWM_POLARITY_INVERSED;
> +
> +	val =3D readl(priv->mmio_base + THEAD_PWM_PER(pwm->hwpwm));
> +	/*
> +	 * val 32 bits, multiply NSEC_PER_SEC, won't overflow.
> +	 */
> +	state->period =3D DIV64_U64_ROUND_UP((u64)val * NSEC_PER_SEC, rate);
> +
> +	val =3D readl(priv->mmio_base + THEAD_PWM_FP(pwm->hwpwm));
> +	/*
> +	 * val 32 bits, multiply NSEC_PER_SEC, won't overflow.
> +	 */
> +	state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)val * NSEC_PER_SEC, rate);
> +
> +	pm_runtime_put_sync(chip->dev);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops thead_pwm_ops =3D {
> +	.apply =3D thead_pwm_apply,
> +	.get_state =3D thead_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int __maybe_unused thead_pwm_runtime_suspend(struct device *dev)
> +{
> +	struct thead_pwm_chip *priv =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused thead_pwm_runtime_resume(struct device *dev)
> +{
> +	struct thead_pwm_chip *priv =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable pwm clock(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;

This can be simplified to:

	ret =3D clk_prepare_enable(priv->clk);
	if (ret)
		dev_err(dev, "failed to enable pwm clock(%pe)\n", ERR_PTR(ret));

	return ret;

(Note that I used %pe instead of %d which is nicer for error codes)

Having said that, I'm unsure if emitting an error message is useful.
Maybe the core emits a message anyhow?

> +}
> +
> +static int thead_pwm_probe(struct platform_device *pdev)
> +{
> +	u32 val =3D THEAD_PWM_INFACTOUT | THEAD_PWM_FPOUT | THEAD_PWM_CONTINUOU=
S_MODE;
> +	struct thead_pwm_chip *priv;
> +	int ret, i;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->mmio_base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->mmio_base))
> +		return PTR_ERR(priv->mmio_base);
> +
> +	priv->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
> +	priv->chip.ops =3D &thead_pwm_ops;
> +	priv->chip.dev =3D &pdev->dev;
> +	priv->chip.npwm =3D THEAD_PWM_MAX_NUM;
> +
> +	/* set normal polarity and other proper bits for all channels */

Please don't. You're supposed to keep the state of the hardware in
probe. Consider a bootloader that enabled the backlight of an LCD that
shows a splash screen.

> +	for (i =3D 0; i < priv->chip.npwm; i++)
> +		writel(val, priv->mmio_base + THEAD_PWM_CTRL(i));
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, &priv->chip);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_enable(&pdev->dev);

devm_pm_runtime_enable() and then drop .remove()

> +
> +	return 0;
> +}
> +
> +static void thead_pwm_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +}
> +
> +static const struct of_device_id thead_pwm_dt_ids[] =3D {
> +	{.compatible =3D "thead,th1520-pwm",},
> +	{/* sentinel */}
> +};
> +MODULE_DEVICE_TABLE(of, thead_pwm_dt_ids);
> +
> +static const struct dev_pm_ops thead_pwm_pm_ops =3D {
> +	SET_RUNTIME_PM_OPS(thead_pwm_runtime_suspend, thead_pwm_runtime_resume,=
 NULL)
> +};
> +
> +static struct platform_driver thead_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "thead-pwm",
> +		.of_match_table =3D thead_pwm_dt_ids,
> +		.pm =3D &thead_pwm_pm_ops,
> +	},
> +	.probe =3D thead_pwm_probe,
> +	.remove_new =3D thead_pwm_remove,
> +};
> +module_platform_driver(thead_pwm_driver);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xfwfxxt6t7o62knb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUdcDQACgkQj4D7WH0S
/k5UOAf+OWHM6iM8C0kqvXY/mcGbttQHxN7rRxN/DJFtQ9gzi6Fdrhi0DUJdnbSv
l1VO8m4qNGe456mJ5uU2y56z6v2tR+tsY5ERIefivH4oWvKJj2eug4XBsq5UZXtX
YQmgz4QAM/K6SIzu8zukYYCp3Ac6qTMnCNeEjORLUhU7JlYvRoho4iRNKCs5Iff+
fumkLpzW/a+uzQ0Ly6FMtGVYp8zbSQQ65nZgHlfAFcd1SQsNFe9Y/aeWbTMERcx3
xJw8oSmFCAVAn+mjRildmxVDJCiogOMVgy54+sWIC/EtU97+edzHa3Wd4rh+Nq9J
GodhuKouzkH4aX6kYcBF6QVlvxTu9Q==
=nYFn
-----END PGP SIGNATURE-----

--xfwfxxt6t7o62knb--
