Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DFA755CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjGQHZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGQHZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:25:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0959F1AE;
        Mon, 17 Jul 2023 00:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689578700; x=1721114700;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7oDVZ9jBgPSkk6CKozwTf/y6QtY1k3odHGa8v29rxyM=;
  b=DaWe62aDUuTe2vnpl4NMXFApmaNze/aDs7OLmd4ieObxrF6Q7PZbmdKe
   kLfhMPzss3uw44wIDhZwEHSlwtaoOWCenz1tGZ5utYVE+K049DYBOII4p
   zLcvGIw2PJBB+B5bZ7NETCobg4FT+Xc04qRqbdjxDahogUzjbZOrC8jmh
   RjelFd55Z7Hhh5STCohQ3QVAdxp26gQE74mpJHFdA3LlLouAQxL0Qmmsz
   peKvT1V8gZySU7djKWX36XK73t1N/Jq7fJwyOijcOoxZKFnnqKhjwby8/
   yzQzph0+bcbI98MI6XHECnngCo7Bss/drClKFQrwF8d8wUcdbkx0TLcRp
   A==;
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="224984545"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2023 00:24:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Jul 2023 00:24:45 -0700
Received: from den-dk-m31857.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 17 Jul 2023 00:24:40 -0700
Message-ID: <8f9bb0f73dcff472e019f100b81363a896389124.camel@microchip.com>
Subject: Re: [PATCH] reset: Explicitly include correct DT includes
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@amd.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
Date:   Mon, 17 Jul 2023 09:24:39 +0200
In-Reply-To: <20230714174939.4063667-1-robh@kernel.org>
References: <20230714174939.4063667-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 2023-07-14 at 11:49 -0600, Rob Herring wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> =C2=A0drivers/reset/hisilicon/hi6220_reset.c | 1 -
> =C2=A0drivers/reset/hisilicon/reset-hi3660.c | 2 +-
> =C2=A0drivers/reset/reset-imx7.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/reset/reset-intel-gw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/reset/reset-k210.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
> =C2=A0drivers/reset/reset-meson-audio-arb.c=C2=A0 | 3 ++-
> =C2=A0drivers/reset/reset-meson.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
> =C2=A0drivers/reset/reset-microchip-sparx5.c | 3 ++-
> =C2=A0drivers/reset/reset-mpfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0drivers/reset/reset-qcom-aoss.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 2 +-
> =C2=A0drivers/reset/reset-qcom-pdc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/reset/reset-simple.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 1 -
> =C2=A0drivers/reset/reset-uniphier-glue.c=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/reset/reset-uniphier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 -
> =C2=A0drivers/reset/reset-zynqmp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 1 -
> =C2=A015 files changed, 11 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/reset/hisilicon/hi6220_reset.c
> b/drivers/reset/hisilicon/hi6220_reset.c
> index 5ca145b64e63..8d1fce18ded7 100644
> --- a/drivers/reset/hisilicon/hi6220_reset.c
> +++ b/drivers/reset/hisilicon/hi6220_reset.c
> @@ -13,7 +13,6 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/bitops.h>
> =C2=A0#include <linux/of.h>
> -#include <linux/of_device.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/mfd/syscon.h>
> =C2=A0#include <linux/reset-controller.h>
> diff --git a/drivers/reset/hisilicon/reset-hi3660.c
> b/drivers/reset/hisilicon/reset-hi3660.c
> index 965f5ceba7d8..087f28e326ee 100644
> --- a/drivers/reset/hisilicon/reset-hi3660.c
> +++ b/drivers/reset/hisilicon/reset-hi3660.c
> @@ -6,7 +6,7 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/mfd/syscon.h>
> =C2=A0#include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/reset-controller.h>
> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> index d2408725eb2c..dd01fe11c5cb 100644
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@ -9,7 +9,7 @@
>=20
> =C2=A0#include <linux/mfd/syscon.h>
> =C2=A0#include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/reset-controller.h>
> =C2=A0#include <linux/regmap.h>
> diff --git a/drivers/reset/reset-intel-gw.c b/drivers/reset/reset-intel-g=
w.c
> index effc177db80a..a5a01388ae7f 100644
> --- a/drivers/reset/reset-intel-gw.c
> +++ b/drivers/reset/reset-intel-gw.c
> @@ -6,7 +6,7 @@
>=20
> =C2=A0#include <linux/bitfield.h>
> =C2=A0#include <linux/init.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/reboot.h>
> =C2=A0#include <linux/regmap.h>
> diff --git a/drivers/reset/reset-k210.c b/drivers/reset/reset-k210.c
> index 1b6e03522b40..b62a2fd44e4e 100644
> --- a/drivers/reset/reset-k210.c
> +++ b/drivers/reset/reset-k210.c
> @@ -3,7 +3,6 @@
> =C2=A0 * Copyright (c) 2020 Western Digital Corporation or its affiliates=
.
> =C2=A0 */
> =C2=A0#include <linux/of.h>
> -#include <linux/of_device.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/reset-controller.h>
> =C2=A0#include <linux/delay.h>
> diff --git a/drivers/reset/reset-meson-audio-arb.c b/drivers/reset/reset-
> meson-audio-arb.c
> index 6a3f6a6a3bbf..7e46dbc04998 100644
> --- a/drivers/reset/reset-meson-audio-arb.c
> +++ b/drivers/reset/reset-meson-audio-arb.c
> @@ -5,7 +5,8 @@
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/io.h>
> =C2=A0#include <linux/module.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> =C2=A0#include <linux/reset-controller.h>
> =C2=A0#include <linux/spinlock.h>
>=20
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 13878ca2779d..89ac99789a3c 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -14,7 +14,6 @@
> =C2=A0#include <linux/reset-controller.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/types.h>
> -#include <linux/of_device.h>
>=20
> =C2=A0#define BITS_PER_REG=C2=A0=C2=A0 32
>=20
> diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset=
-
> microchip-sparx5.c
> index ead25942061d..636e85c388b0 100644
> --- a/drivers/reset/reset-microchip-sparx5.c
> +++ b/drivers/reset/reset-microchip-sparx5.c
> @@ -7,9 +7,10 @@
> =C2=A0 * https://github.com/microchip-ung/sparx-5_reginfo
> =C2=A0 */
> =C2=A0#include <linux/mfd/syscon.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/platform_device.h>
> +#include <linux/property.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/reset-controller.h>
>=20
> diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
> index e71ab73092ab..7f3fb2d472f4 100644
> --- a/drivers/reset/reset-mpfs.c
> +++ b/drivers/reset/reset-mpfs.c
> @@ -9,6 +9,7 @@
> =C2=A0#include <linux/auxiliary_bus.h>
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/module.h>
> +#include <linux/of.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/reset-controller.h>
> =C2=A0#include <dt-bindings/clock/microchip,mpfs-clock.h>
> diff --git a/drivers/reset/reset-qcom-aoss.c b/drivers/reset/reset-qcom-a=
oss.c
> index 9333b923dda0..f52e90e36194 100644
> --- a/drivers/reset/reset-qcom-aoss.c
> +++ b/drivers/reset/reset-qcom-aoss.c
> @@ -8,7 +8,7 @@
> =C2=A0#include <linux/reset-controller.h>
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/io.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> =C2=A0#include <dt-bindings/reset/qcom,sdm845-aoss.h>
>=20
> =C2=A0struct qcom_aoss_reset_map {
> diff --git a/drivers/reset/reset-qcom-pdc.c b/drivers/reset/reset-qcom-pd=
c.c
> index f22bb49a4ac8..a3aae3f902e6 100644
> --- a/drivers/reset/reset-qcom-pdc.c
> +++ b/drivers/reset/reset-qcom-pdc.c
> @@ -4,7 +4,7 @@
> =C2=A0 */
>=20
> =C2=A0#include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/reset-controller.h>
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> index 361a68314265..7ea5adbf2097 100644
> --- a/drivers/reset/reset-simple.c
> +++ b/drivers/reset/reset-simple.c
> @@ -16,7 +16,6 @@
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/io.h>
> =C2=A0#include <linux/of.h>
> -#include <linux/of_device.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/reset-controller.h>
> =C2=A0#include <linux/reset/reset-simple.h>
> diff --git a/drivers/reset/reset-uniphier-glue.c b/drivers/reset/reset-
> uniphier-glue.c
> index 15abac9fc72c..38aa953855aa 100644
> --- a/drivers/reset/reset-uniphier-glue.c
> +++ b/drivers/reset/reset-uniphier-glue.c
> @@ -6,7 +6,7 @@
>=20
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/reset.h>
> =C2=A0#include <linux/reset/reset-simple.h>
> diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphie=
r.c
> index ff7580f38056..79c43c204d46 100644
> --- a/drivers/reset/reset-uniphier.c
> +++ b/drivers/reset/reset-uniphier.c
> @@ -7,7 +7,6 @@
> =C2=A0#include <linux/mfd/syscon.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/of.h>
> -#include <linux/of_device.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/reset-controller.h>
> diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
> index 59dc0ff9af9e..f0f64ad3472b 100644
> --- a/drivers/reset/reset-zynqmp.c
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -9,7 +9,6 @@
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/reset-controller.h>
> =C2=A0#include <linux/firmware/xlnx-zynqmp.h>
> -#include <linux/of_device.h>
>=20
> =C2=A0#define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_STA=
RT)
> =C2=A0#define ZYNQMP_RESET_ID ZYNQMP_PM_RESET_START
> --
> 2.40.1
>=20

Acked-by: Steen Hegelund <Steen.Hegelund@microchip.com>

BR
Steen
