Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB227D0E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377060AbjJTLZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377057AbjJTLZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:25:53 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE8A91
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:25:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtndR-0001Bn-9w; Fri, 20 Oct 2023 13:25:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtndM-0030sC-8R; Fri, 20 Oct 2023 13:25:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtndL-002U6o-TM; Fri, 20 Oct 2023 13:25:39 +0200
Date:   Fri, 20 Oct 2023 13:25:39 +0200
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
Message-ID: <20231020112539.gctx5uj2rrhryulo@pengutronix.de>
References: <20231020103741.557735-1-william.qiu@starfivetech.com>
 <20231020103741.557735-3-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cz4qfrvhjfgpon2x"
Content-Disposition: inline
In-Reply-To: <20231020103741.557735-3-william.qiu@starfivetech.com>
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


--cz4qfrvhjfgpon2x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Oct 20, 2023 at 06:37:39PM +0800, William Qiu wrote:
> Add Pulse Width Modulation driver support for OpenCores.
>=20
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  MAINTAINERS              |   7 ++
>  drivers/pwm/Kconfig      |  11 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-ocores.c | 211 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 230 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ocores.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c4cce45a09d..321af8fa7aad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16003,6 +16003,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
>  F:	drivers/i2c/busses/i2c-ocores.c
>  F:	include/linux/platform_data/i2c-ocores.h
>=20
> +OPENCORES PWM DRIVER
> +M:	William Qiu <william.qiu@starfivetech.com>
> +M:	Hal Feng <hal.feng@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.yaml
> +F:	drivers/pwm/pwm-ocores.c
> +
>  OPENRISC ARCHITECTURE
>  M:	Jonas Bonn <jonas@southpole.se>
>  M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 8ebcddf91f7b..cbfbf227d957 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -434,6 +434,17 @@ config PWM_NTXEC
>  	  controller found in certain e-book readers designed by the original
>  	  design manufacturer Netronix.
>=20
> +config PWM_OCORES
> +	tristate "Opencores PWM support"
> +	depends on HAS_IOMEM && OF
> +	depends on COMMON_CLK && RESET_CONTROLLER

Would it make sense to add something like:

	depends on ARCH_SOMETHING || COMPILE_TEST

here?

> +	help
> +	  If you say yes to this option, support will be included for the
> +	  OpenCores PWM. For details see https://opencores.org/projects/ptc.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-ocores.
> +
>  config PWM_OMAP_DMTIMER
>  	tristate "OMAP Dual-Mode Timer PWM support"
>  	depends on OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c822389c2a24..542b98202153 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)	+=3D pwm-microchip-cor=
e.o
>  obj-$(CONFIG_PWM_MTK_DISP)	+=3D pwm-mtk-disp.o
>  obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
>  obj-$(CONFIG_PWM_NTXEC)		+=3D pwm-ntxec.o
> +obj-$(CONFIG_PWM_OCORES)	+=3D pwm-ocores.o
>  obj-$(CONFIG_PWM_OMAP_DMTIMER)	+=3D pwm-omap-dmtimer.o
>  obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
>  obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
> diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
> new file mode 100644
> index 000000000000..7a510de4e063
> --- /dev/null
> +++ b/drivers/pwm/pwm-ocores.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * OpenCores PWM Driver
> + *
> + * https://opencores.org/projects/ptc
> + *
> + * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
> + */

Please add a section here describing the hardware limitations. Please
stick to the format used e.g. in drivers/pwm/pwm-sl28cpld.c to make this
easy to grep for. It should mention for example that the hardware can
only do inverted polarity.

> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +#define REG_OCPWM_CNTR(base)	((base))
> +#define REG_OCPWM_HRC(base)	((base) + 0x4)
> +#define REG_OCPWM_LRC(base)	((base) + 0x8)
> +#define REG_OCPWM_CTRL(base)	((base) + 0xC)

This is unusual, I would skip base here and do the addition explicitly
in some static inline helpers like:

	static inline ocores_writel(struct ocores_pwm_device *, unsigned int offse=
t, u32 val);

> +/* OCPWM_CTRL register bits*/
> +#define OCPWM_EN      BIT(0)
> +#define OCPWM_ECLK    BIT(1)
> +#define OCPWM_NEC     BIT(2)
> +#define OCPWM_OE      BIT(3)
> +#define OCPWM_SIGNLE  BIT(4)
> +#define OCPWM_INTE    BIT(5)
> +#define OCPWM_INT     BIT(6)
> +#define OCPWM_CNTRRST BIT(7)
> +#define OCPWM_CAPTE   BIT(8)

I like register bit fields being named with the register as prefix, so I
suggest:

	#define	REG_OCPWM_CTRL_EN	BIT(0)
	...

> +
> +struct ocores_pwm_device {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	const struct ocores_pwm_data *data;
> +	void __iomem *regs;
> +	u32 clk_rate; /* PWM APB clock frequency */
> +};
> +
> +struct ocores_pwm_data {
> +	void __iomem *(*get_ch_base)(void __iomem *base, unsigned int channel);

It might be worth to mark this with the function attribute const.

> +};
> +
> +static inline struct ocores_pwm_device *
> +chip_to_ocores(struct pwm_chip *chip)

These two lines can go in a single one.

> +

please drop this empty line.

> +{
> +	return container_of(chip, struct ocores_pwm_device, chip);
> +}
> +
> +void __iomem *starfive_jh71x0_get_ch_base(void __iomem *base,
> +					  unsigned int channel)
> +{
> +	return base + (channel > 3 ? channel % 4 * 0x10 + (1 << 15) : channel *=
 0x10);

Maybe make this:

	unsigned int offset =3D
		(channel > 3 ? 1 << 15 : 0) +
		(channel & 3) * 0x10
	...

or even:

	unsigned int offset =3D (channel & 4) << 13 + (channel & 3) * 0x10;

The former is easier to read, the latter might be compiled to faster
code.

Alternatively: Is it easier/sensible to model the jh71x0 hardware as two
PWM chips with 4 lines each?

> +}
> +
> +static int ocores_pwm_get_state(struct pwm_chip *chip,
> +				struct pwm_device *dev,
> +				struct pwm_state *state)
> +{
> +	struct ocores_pwm_device *pwm =3D chip_to_ocores(chip);

Please use "pwm" for variables of type struct pwm_device and pick
something different for ocores_pwm_device variables. I suggest something
like "ddata" or "opd".

> +	void __iomem *base =3D pwm->data->get_ch_base ?
> +			     pwm->data->get_ch_base(pwm->regs, dev->hwpwm) : pwm->regs;
> +	u32 period_data, duty_data, ctrl_data;
> +
> +	period_data =3D readl(REG_OCPWM_LRC(base));
> +	duty_data =3D readl(REG_OCPWM_HRC(base));
> +	ctrl_data =3D readl(REG_OCPWM_CTRL(base));
> +
> +	state->period =3D DIV_ROUND_CLOSEST_ULL((u64)period_data * NSEC_PER_SEC=
, pwm->clk_rate);
> +	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL((u64)duty_data * NSEC_PER_S=
EC, pwm->clk_rate);

Please test your driver with PWM_DEBUG enabled. The rounding is wrong
here.

> +	state->polarity =3D PWM_POLARITY_INVERSED;
> +	state->enabled =3D (ctrl_data & OCPWM_EN) ? true : false;
> +
> +	return 0;
> +}
> +
> +static int ocores_pwm_apply(struct pwm_chip *chip,
> +			    struct pwm_device *dev,
> +			    const struct pwm_state *state)
> +{
> +	struct ocores_pwm_device *pwm =3D chip_to_ocores(chip);
> +	void __iomem *base =3D pwm->data->get_ch_base ?
> +			     pwm->data->get_ch_base(pwm->regs, dev->hwpwm) : pwm->regs;
> +	u32 period_data, duty_data, ctrl_data =3D 0;
> +
> +	if (state->polarity !=3D PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	period_data =3D DIV_ROUND_CLOSEST_ULL(state->period * pwm->clk_rate,

this multiplication might overflow. And also wrong rounding. I didn't
check, but maybe DIV_ROUND_CLOSEST_ULL might return a value > U32_MAX?

> +					    NSEC_PER_SEC);
> +	duty_data =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle * pwm->clk_rate,
> +					  NSEC_PER_SEC);
> +
> +	writel(period_data, REG_OCPWM_LRC(base));
> +	writel(duty_data, REG_OCPWM_HRC(base));
> +	writel(0,  REG_OCPWM_CNTR(base));

s/  / /

I assume this is "glitchy", i.e. after updating the REG_OCPWM_LRC and
before updating REG_OCPWM_HRC the signal emitted might be a mixture
between old and new state? This should be mentioned in the Limitations
section I mentioned above. Also mention that the currently running
period is not completed and how the output behave if the hardware is
disabled.

> +
> +	ctrl_data =3D readl(REG_OCPWM_CTRL(base));
> +	if (state->enabled)
> +		writel(ctrl_data | OCPWM_EN | OCPWM_OE, REG_OCPWM_CTRL(base));
> +	else
> +		writel(ctrl_data & ~(OCPWM_EN | OCPWM_OE), REG_OCPWM_CTRL(base));
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops ocores_pwm_ops =3D {
> +	.get_state	=3D ocores_pwm_get_state,
> +	.apply		=3D ocores_pwm_apply,
> +	.owner		=3D THIS_MODULE,

The assignment to .owner should be dropped. (See commit
384461abcab6602abc06c2dfb8fb99beeeaa12b0)

> +};
> +
> +static const struct ocores_pwm_data jh71x0_pwm_data =3D {
> +	.get_ch_base =3D starfive_jh71x0_get_ch_base,
> +};
> +
> +static const struct of_device_id ocores_pwm_of_match[] =3D {
> +	{ .compatible =3D "opencores,pwm-ocores" },
> +	{ .compatible =3D "starfive,jh71x0-pwm", .data =3D &jh71x0_pwm_data},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ocores_pwm_of_match);
> +
> +static int ocores_pwm_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *id;
> +	struct device *dev =3D &pdev->dev;
> +	struct ocores_pwm_device *pwm;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	id =3D of_match_device(ocores_pwm_of_match, dev);
> +	if (!id)
> +		return -EINVAL;
> +
> +	pwm =3D devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	pwm->data =3D id->data;
> +	chip =3D &pwm->chip;
> +	chip->dev =3D dev;
> +	chip->ops =3D &ocores_pwm_ops;
> +	chip->npwm =3D 8;
> +	chip->of_pwm_n_cells =3D 3;
> +
> +	pwm->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pwm->regs))
> +		return dev_err_probe(dev, PTR_ERR(pwm->regs),
> +				     "Unable to map IO resources\n");
> +
> +	pwm->clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
> +				     "Unable to get pwm's clock\n");
> +
> +	pwm->rst =3D devm_reset_control_get_optional_exclusive(dev, NULL);
> +	reset_control_deassert(pwm->rst);
> +
> +	pwm->clk_rate =3D clk_get_rate(pwm->clk);
> +	if (pwm->clk_rate <=3D 0) {
> +		dev_warn(dev, "Failed to get APB clock rate\n");
> +		return -EINVAL;

dev_err_probe() here, too? Missing call to reset_control_assert().

> +	}
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret < 0) {
> +		dev_err(dev, "Cannot register PTC: %d\n", ret);

dev_err_probe()

> +		clk_disable_unprepare(pwm->clk);

This is wrong, devm_clk_get_enabled() cares for that.

> +		reset_control_assert(pwm->rst);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	return 0;

If you call platform_set_drvdata() earlier you can just return ret here
and drop the return in the error path above.

> +}
> +
> +static int ocores_pwm_remove(struct platform_device *dev)
> +{
> +	struct ocores_pwm_device *pwm =3D platform_get_drvdata(dev);
> +
> +	reset_control_assert(pwm->rst);
> +	clk_disable_unprepare(pwm->clk);

Wrong in the same way as the call in .probe()'s error path.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver ocores_pwm_driver =3D {
> +	.probe =3D ocores_pwm_probe,
> +	.remove =3D ocores_pwm_remove,

Please use .remove_new

> +	.driver =3D {
> +		.name =3D "ocores-pwm",
> +		.of_match_table =3D ocores_pwm_of_match,
> +	},
> +};
> +module_platform_driver(ocores_pwm_driver);
> +
> +MODULE_AUTHOR("Jieqin Chen");

Jieqin Chen !=3D William Qiu ?

> +MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
> +MODULE_DESCRIPTION("OpenCores PWM PTC driver");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cz4qfrvhjfgpon2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUyY7IACgkQj4D7WH0S
/k5iYQf/XPI8jg0Yioe9vRiMsV63QKHwO2rqSB1+I7g0tRVqfP/mIVhLdwZ4YPew
RQo4dn0sfLO258eCXClGcEZaiIKgxcaO8gxZscrt5W3K4Ir8d/7mRE/fkyvNgS0T
LyZsbE5hYCa9t6GS1D7qWkmxS69v8uAhEjSXJbuI1OCv3A7Xu2SJbfkS3lUr1I80
qE58kx4yUwVjrr2r5Ar5FCRzoxdtcPFi3mNu30BOwu6tsCV8C4mRnDpCTWWt6u3P
LeXxcDb62aM0EahuLRruDvCTYET7ekXJ3MnTjPKGNMmcE5HtETZB9PLFUT5yImn8
zjWX9yH/Oy/vciK9K37CmMmSlZMJlA==
=bGrp
-----END PGP SIGNATURE-----

--cz4qfrvhjfgpon2x--
