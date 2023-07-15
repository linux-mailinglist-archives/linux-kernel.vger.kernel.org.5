Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8498754BDC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 21:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGOTwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 15:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGOTwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 15:52:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE09F1B6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 12:52:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKlJA-00044x-JJ; Sat, 15 Jul 2023 21:52:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKlJ9-00Edgc-2g; Sat, 15 Jul 2023 21:51:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKlJ7-0058U7-RP; Sat, 15 Jul 2023 21:51:57 +0200
Date:   Sat, 15 Jul 2023 21:51:56 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.dooks@codethink.co.uk,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH v8 5/5] pwm: dwc: add of/platform support
Message-ID: <20230715195156.fahd2btntvbqpd66@pengutronix.de>
References: <20230614171457.69191-1-ben.dooks@sifive.com>
 <20230614171457.69191-6-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uk3g2pfod6i5g7sl"
Content-Disposition: inline
In-Reply-To: <20230614171457.69191-6-ben.dooks@sifive.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uk3g2pfod6i5g7sl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2023 at 06:14:57PM +0100, Ben Dooks wrote:
> The dwc pwm controller can be used in non-PCI systems, so allow
> either platform or OF based probing.

A document describing the binding is needed here.

>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v8:
>  - add compile test for of-case
>  - add module namespace
>  - move later in the series
> v7:
>  - fixup kconfig from previous pcie changes
> v5:
>  - fix missing " in kconfig
>  - remove .remove method, devm already sorts this.
>  - merge pwm-number code
>  - split the of code out of the core
>  - get bus clock
> v4:
>  - moved the compile test code earlier
>  - fixed review comments
>  - used NS_PER_SEC
>  - use devm_clk_get_enabled
>  - ensure we get the bus clock
> v3:
>  - changed compatible name
> ---
>  drivers/pwm/Kconfig        | 10 +++++
>  drivers/pwm/Makefile       |  1 +
>  drivers/pwm/pwm-dwc-core.c |  6 +++
>  drivers/pwm/pwm-dwc-of.c   | 78 ++++++++++++++++++++++++++++++++++++++
>  drivers/pwm/pwm-dwc.c      |  1 +
>  drivers/pwm/pwm-dwc.h      |  1 +
>  6 files changed, 97 insertions(+)
>  create mode 100644 drivers/pwm/pwm-dwc-of.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 7c54cdcb97a0..61f5d3f30fd7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -205,6 +205,16 @@ config PWM_DWC
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-dwc.
> =20
> +config PWM_DWC_OF
> +	tristate "DesignWare PWM Controller (OF bus)"
> +	depends on HAS_IOMEM && (OF || COMPILE_TEST)
> +	select PWM_DWC_CORE
> +	help
> +	  PWM driver for Synopsys DWC PWM Controller on an OF bus.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-dwc-of.
> +
>  config PWM_EP93XX
>  	tristate "Cirrus Logic EP93xx PWM support"
>  	depends on ARCH_EP93XX || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index de3ed77e8d7c..d27dfbb850b7 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
>  obj-$(CONFIG_PWM_CROS_EC)	+=3D pwm-cros-ec.o
>  obj-$(CONFIG_PWM_DWC_CORE)	+=3D pwm-dwc-core.o
>  obj-$(CONFIG_PWM_DWC)		+=3D pwm-dwc.o
> +obj-$(CONFIG_PWM_DWC_OF)	+=3D pwm-dwc-of.o
>  obj-$(CONFIG_PWM_EP93XX)	+=3D pwm-ep93xx.o
>  obj-$(CONFIG_PWM_FSL_FTM)	+=3D pwm-fsl-ftm.o
>  obj-$(CONFIG_PWM_HIBVT)		+=3D pwm-hibvt.o
> diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
> index 0f07e26e6c30..ed102fc4b30a 100644
> --- a/drivers/pwm/pwm-dwc-core.c
> +++ b/drivers/pwm/pwm-dwc-core.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/clk.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pwm.h>
> =20
> @@ -44,6 +45,9 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dw=
c,
>  	u32 high;
>  	u32 low;
> =20
> +	if (dwc->clk)
> +		dwc->clk_rate =3D clk_get_rate(dwc->clk);
> +
>  	/*
>  	 * Calculate width of low and high period in terms of input clock
>  	 * periods and check are the result within HW limits between 1 and
> @@ -128,6 +132,8 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> =20
>  	pm_runtime_get_sync(chip->dev);
> =20
> +	if (dwc->clk)
> +		dwc->clk_rate =3D clk_get_rate(dwc->clk);
>  	clk_rate =3D dwc->clk_rate;
> =20
>  	ctrl =3D dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm->hwpwm));
> diff --git a/drivers/pwm/pwm-dwc-of.c b/drivers/pwm/pwm-dwc-of.c
> new file mode 100644
> index 000000000000..13a0b534b383
> --- /dev/null
> +++ b/drivers/pwm/pwm-dwc-of.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DesignWare PWM Controller driver OF
> + *
> + * Copyright (C) 2022 SiFive, Inc.
> + */
> +
> +#define DEFAULT_MODULE_NAMESACE dwc_pwm

missing P? I'd have put this into drivers/pwm/pwm-dwc.h.

> +
> +#include <linux/bitops.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/io.h>
> +
> +#include "pwm-dwc.h"
> +
> +static int dwc_pwm_plat_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct dwc_pwm *dwc;
> +	struct clk *bus;
> +	u32 nr_pwm;
> +
> +	dwc =3D dwc_pwm_alloc(dev);
> +	if (!dwc)
> +		return -ENOMEM;
> +
> +	if (!device_property_read_u32(dev, "snps,pwm-number", &nr_pwm)) {
> +		if (nr_pwm > DWC_TIMERS_TOTAL)
> +			dev_err(dev, "too many PWMs (%d) specified, capping at %d\n",
> +				nr_pwm, dwc->chip.npwm);
> +		else
> +			dwc->chip.npwm =3D nr_pwm;
> +	}
> +
> +	dwc->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dwc->base))
> +		return PTR_ERR(dwc->base);
> +
> +	bus =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(bus))
> +		return dev_err_probe(dev, PTR_ERR(bus),
> +				     "failed to get clock\n");
> +
> +	dwc->clk =3D devm_clk_get_enabled(dev, "timer");
> +	if (IS_ERR(dwc->clk))
> +		return dev_err_probe(dev, PTR_ERR(dwc->clk),
> +				     "failed to get timer clock\n");
> +
> +	dwc->clk_rate =3D clk_get_rate(dwc->clk);

Do you need this here? Isn't clk_rate assigned each time it's used when
clk !=3D NULL?

> +	return devm_pwmchip_add(dev, &dwc->chip);
> +}
> +
> +static const struct of_device_id dwc_pwm_dt_ids[] =3D {
> +	{ .compatible =3D "snps,dw-apb-timers-pwm2" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, dwc_pwm_dt_ids);
> +
> +static struct platform_driver dwc_pwm_plat_driver =3D {
> +	.driver =3D {
> +		.name		=3D "dwc-pwm",
> +		.of_match_table  =3D dwc_pwm_dt_ids,
> +	},
> +	.probe	=3D dwc_pwm_plat_probe,
> +};
> +
> +module_platform_driver(dwc_pwm_plat_driver);
> +
> +MODULE_ALIAS("platform:dwc-pwm-of");
> +MODULE_AUTHOR("Ben Dooks <ben.dooks@sifive.com>");

Given that this email address is (or soon will be) unavailable, maybe
better put your codethink address here?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uk3g2pfod6i5g7sl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSy+NsACgkQj4D7WH0S
/k4BVQgAgfQrkmy+1RRLl6Zk0usiTE06K0JbHbbmLLWB3uN8Cvs93wmS6zP+Fj87
rvkghgOBWnxYNK85RLDvG7ywrEsahkXJhfgJlVtqYsT4JysZCTwqUzr8Ewd7id75
mCrdJbEOfHENR7C0TvJ5Zg4sW+TDDTnNCAm4p6wvb9Wkj3+F7IUwnQ0SFqWlaGt0
2ORJsKR/bLjK3389fIhBCuU0XMrAg+7l6ypk2Q4nqrfqzFYP7+w+oQhJU1TFcli3
4Be0CErhKkiTfzWiVSatzRYWtM4ylvH7O7hwgC8FEG2PwbuzoQKjJtCKeQf1qT/p
jpfiiIGI/5LFOguflEhupNKS6DGO5g==
=22Se
-----END PGP SIGNATURE-----

--uk3g2pfod6i5g7sl--
