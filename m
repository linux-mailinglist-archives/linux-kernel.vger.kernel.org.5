Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7FA7B3706
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjI2Pkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjI2Pkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:40:39 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6755B4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:40:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmFbS-0000kz-B6; Fri, 29 Sep 2023 17:40:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmFbP-009qYi-Gq; Fri, 29 Sep 2023 17:40:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmFbP-0060Vc-6f; Fri, 29 Sep 2023 17:40:27 +0200
Date:   Fri, 29 Sep 2023 17:40:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-riscv@lists.infradead.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: Re: [PATCH 2/2] pwm: add T-HEAD PWM driver
Message-ID: <20230929154027.lq77saenadxgry5x@pengutronix.de>
References: <20230928170254.413-1-jszhang@kernel.org>
 <20230928170254.413-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7i7o422tklvgxyiz"
Content-Disposition: inline
In-Reply-To: <20230928170254.413-3-jszhang@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7i7o422tklvgxyiz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Sep 29, 2023 at 01:02:54AM +0800, Jisheng Zhang wrote:
> T-HEAD SoCs such as the TH1520 contain a PWM controller used
> among other things to control the LCD backlight, fan and so on.
> Add driver for it.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  MAINTAINERS             |   1 +
>  drivers/pwm/Kconfig     |  11 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-thead.c | 289 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 302 insertions(+)
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
> index 000000000000..8339f5617b6f
> --- /dev/null
> +++ b/drivers/pwm/pwm-thead.c
> @@ -0,0 +1,289 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * T-HEAD PWM driver
> + *
> + * Copyright (C) 2021 Alibaba Group Holding Limited.

If you have a public link to a reference manual, please mention this
here. Also please add a section that describes hardware (and software)
limitations sticking to the format in other drivers. The idea is that

	sed -rn '/Limitations:/,/\*\/?$/p'

tells you about (at least) about the following properties:

 - Can the PWM be updated atomically?
 - Does it complete the current running period before switching to the
   new configuration?
 - How does the output behave when disabled?

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
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +
> +#define MAX_PWM_NUM	6
> +
> +#define LIGHT_PWM_CHN_BASE(n)		((n) * 0x20)
> +#define LIGHT_PWM_CTRL(n)		(LIGHT_PWM_CHN_BASE(n) + 0x00)
> +#define LIGHT_PWM_RPT(n)		(LIGHT_PWM_CHN_BASE(n) + 0x04)
> +#define LIGHT_PWM_PER(n)		(LIGHT_PWM_CHN_BASE(n) + 0x08)
> +#define LIGHT_PWM_FP(n)			(LIGHT_PWM_CHN_BASE(n) + 0x0c)
> +#define LIGHT_PWM_STATUS(n)		(LIGHT_PWM_CHN_BASE(n) + 0x10)
> +
> +/* bit definition PWM_CTRL */
> +#define PWM_START				BIT(0)
> +#define PWM_SOFT_RST				BIT(1)
> +#define PWM_CFG_UPDATE				BIT(2)
> +#define PWM_INT_EN				BIT(3)
> +#define PWM_ONE_SHOT_MODE			BIT(4)
> +#define PWM_CONTINUOUS_MODE			BIT(5)
> +#define PWM_EVT_RISING_TRIG_UNDER_ONE_SHOT	BIT(6)
> +#define PWM_EVT_FALLING_TRIG_UNDER_ONE_SHOT	BIT(7)
> +#define PWM_FPOUT				BIT(8)
> +#define PWM_INFACTOUT				BIT(9)

Emil already criticised the naming here (Thanks btw for the review!). I
also want you to use a consistent prefix, but I wonder about "LIGHT_", I
would have expected "THEAD_" matching the driver name?!

> +struct thead_pwm_chip {
> +	struct clk *clk;
> +	void __iomem *mmio_base;
> +	struct pwm_chip chip;
> +};
> +
> +#define to_thead_pwm_chip(chip)		container_of(chip, struct thead_pwm_chi=
p, chip)

This is wrong. Try:

	struct pwm_chip *mychip;
	struct thead_pwm_chip *pc =3D to_thead_pwm_chip(mychip);

=2E (Of course you shouldn't name a pwm_chip "mychip", "chip" is fine.
Still this is too ugly.) I suggest a static inline here, ideally one
that has a name starting with "thead_pwm_". thead_pwm_from_chip() comes
to mind.
=09
> +static int thead_pwm_clk_prepare_enable(struct thead_pwm_chip *pc)
> +{
> +	return clk_prepare_enable(pc->clk);
> +}
> +
> +static void thead_pwm_clk_disable_unprepare(struct thead_pwm_chip *pc)
> +{
> +	clk_disable_unprepare(pc->clk);
> +}

I agree to Emil here that these wrappers are too thin. (Also you might
get rid of them completely, see below.)

> +static int thead_pwm_enable(struct pwm_chip *chip, struct pwm_device *pw=
m)
> +{
> +	struct thead_pwm_chip *pc =3D to_thead_pwm_chip(chip);
> +	u32 value;
> +	int ret;
> +
> +	ret =3D pm_runtime_get_sync(chip->dev);

This function is typically called directly after thead_pwm_config()
which ended with calling pm_runtime_put_sync(). If you put the logic of
=2Eapply() in a single function (or move runtime pm handling in there) you
can prevent some put/get ping-pong.

> +	if (ret < 0) {
> +		dev_err(chip->dev, "failed to clock on the pwm device(%d)\n", ret);

Please use %pe for better readable error messages.

> +		return ret;
> +	}
> +
> +	value =3D readl(pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
> +	value |=3D PWM_START;
> +	writel(value, pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
> +
> +	return 0;
> +}
> +
> +static void thead_pwm_disable(struct pwm_chip *chip, struct pwm_device *=
pwm)
> +{
> +	struct thead_pwm_chip *pc =3D to_thead_pwm_chip(chip);
> +	u32 value;
> +
> +	value =3D readl(pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
> +	value &=3D ~PWM_START;
> +	writel(value, pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
> +
> +	pm_runtime_put_sync(chip->dev);
> +}
> +
> +static int thead_pwm_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    int duty_ns, int period_ns)
> +{
> +	struct thead_pwm_chip *pc =3D to_thead_pwm_chip(chip);
> +	unsigned long rate =3D clk_get_rate(pc->clk);
> +	unsigned long duty_cycle, period_cycle;
> +	u32 pwm_cfg =3D PWM_INFACTOUT | PWM_FPOUT | PWM_CONTINUOUS_MODE | PWM_I=
NT_EN;
> +	int ret;
> +
> +	if (duty_ns > period_ns) {
> +		dev_err(chip->dev, "invalid pwm configure\n");
> +		return -EINVAL;

You can assume that won't happen (once you fixed the implicit type cast
in the call to thead_pwm_config pointed out below).

> +	}
> +
> +	ret =3D pm_runtime_get_sync(chip->dev);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "failed to clock on the pwm device(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	writel(pwm_cfg, pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
> +
> +	period_cycle =3D period_ns * rate;

This might overflow. Please use mul_u64_u64_div_u64 here together with
making sure that rate <=3D NSEC_PER_SEC.

> +	do_div(period_cycle, NSEC_PER_SEC);
> +	writel(period_cycle, pc->mmio_base + LIGHT_PWM_PER(pwm->hwpwm));
> +	duty_cycle =3D duty_ns * rate;
> +	do_div(duty_cycle, NSEC_PER_SEC);
> +	writel(duty_cycle, pc->mmio_base + LIGHT_PWM_FP(pwm->hwpwm));
> +
> +	pwm_cfg =3D readl(pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
> +	pwm_cfg |=3D PWM_CFG_UPDATE;
> +	writel(pwm_cfg, pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));

I assume this means period and duty_cycle are updated atomically (i.e.
at no time the hardware is configured to emit a wave that has the new
period but the old duty_cycle)?

Is this needed even if the PWM is currently off and you write PWM_START
a moment later? Can writing PWM_CFG_UPDATE and PWM_START be done in a
single step?

> +	pm_runtime_put_sync(chip->dev);
> +
> +	return 0;
> +}
> +
> +static int thead_pwm_set_polarity(struct pwm_chip *chip,
> +				  struct pwm_device *pwm,
> +				  enum pwm_polarity polarity)
> +{
> +	struct thead_pwm_chip *pc =3D to_thead_pwm_chip(chip);
> +	u32 value =3D readl(pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
> +	int ret;
> +
> +	ret =3D pm_runtime_get_sync(chip->dev);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "failed to clock on the pwm device(%d)\n", ret);

Please don't make .apply() emit an error message.

> +		return ret;
> +	}
> +
> +	if (polarity =3D=3D PWM_POLARITY_NORMAL)
> +		value |=3D PWM_FPOUT;
> +	else
> +		value &=3D ~PWM_FPOUT;
> +
> +	writel(value, pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));

Oh, no PWM_CFG_UPDATE here? So writing the polarity takes effect
immediately? If so, please note this is the Limitations section I
asked for above.

> +	pm_runtime_put_sync(chip->dev);
> +
> +	return 0;
> +}
> +
> +static int thead_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	int err;
> +	bool enabled =3D pwm->state.enabled;
> +
> +	if (state->polarity !=3D pwm->state.polarity)
> +		thead_pwm_set_polarity(chip, pwm, state->polarity);
> +
> +	if (!state->enabled) {
> +		if (enabled)
> +			thead_pwm_disable(chip, pwm);
> +		return 0;
> +	}
> +
> +	err =3D thead_pwm_config(chip, pwm, state->duty_cycle, state->period);

state->duty_cycle is an u64, but thead_pwm_config takes an int ...

> +	if (err)
> +		return err;
> +
> +	if (!enabled)
> +		return thead_pwm_enable(chip, pwm);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops thead_pwm_ops =3D {
> +	.apply =3D thead_pwm_apply,

Please implement .get_state() and test with PWM_DEBUG enabled.

> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int __maybe_unused thead_pwm_runtime_suspend(struct device *dev)
> +{
> +	struct thead_pwm_chip *pc =3D dev_get_drvdata(dev);
> +
> +	thead_pwm_clk_disable_unprepare(pc);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused thead_pwm_runtime_resume(struct device *dev)
> +{
> +	struct thead_pwm_chip *pc =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D thead_pwm_clk_prepare_enable(pc);
> +	if (ret) {
> +		dev_err(dev, "failed to enable pwm clock(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int thead_pwm_probe(struct platform_device *pdev)
> +{
> +	struct thead_pwm_chip *pc;
> +	int ret;
> +
> +	pc =3D devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> +	if (!pc)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pc);
> +
> +	pc->mmio_base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pc->mmio_base))
> +		return PTR_ERR(pc->mmio_base);
> +
> +	pc->clk =3D devm_clk_get(&pdev->dev, NULL);

devm_clk_get_enabled()

> +	if (IS_ERR(pc->clk))
> +		return PTR_ERR(pc->clk);
> +
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_noresume(&pdev->dev);
> +	ret =3D thead_pwm_clk_prepare_enable(pc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable pwm clock(%d)\n", ret);
> +		goto err_pm_disable;
> +	}
> +
> +	pc->chip.ops =3D &thead_pwm_ops;
> +	pc->chip.dev =3D &pdev->dev;
> +	pc->chip.npwm =3D MAX_PWM_NUM;
> +
> +	ret =3D pwmchip_add(&pc->chip);

devm_pwmchip_add()

> +	if (ret)
> +		goto err_clk_disable;
> +
> +	pm_runtime_put(&pdev->dev);
> +
> +	return 0;
> +
> +err_clk_disable:
> +	thead_pwm_clk_disable_unprepare(pc);
> +err_pm_disable:
> +	pm_runtime_disable(&pdev->dev);
> +	return ret;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7i7o422tklvgxyiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUW7+oACgkQj4D7WH0S
/k7ALggAhmJTiDR1A8R13CZqNrc/bNOhs+UFYYTpafxG/rk2m3s3WZYP3l4XxHLu
6kmuQ+3A0FvDTalPkd4DWm9fX2ZfUyf4Kq5+YwipiWkXGf3PATSjhx7e/fYkQmgR
GK/OC6w41uoUvNYiEqZGzartdCcXpjriSqVpSLdAoxPN308rgH6qBB9EoqweBZGE
9LGW6yZ/2a8BcJmG2AlBxHSZgK+VdjpkW/mv8AWLcyfvhEWruvQufDzBePSBy/NB
9U4dkMxSSVxDFXvpLeAj49Q8Fv6+ZkV03vv5yg6NEe/YJdb4M+bY5Q/e4WYnQdLo
vMZI4WeRrhqZm+PVAm/wZjPcmi8rUw==
=j5Sk
-----END PGP SIGNATURE-----

--7i7o422tklvgxyiz--
