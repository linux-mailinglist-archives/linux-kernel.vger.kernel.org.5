Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E6A7542E7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbjGNSyt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 14:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjGNSyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:54:47 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F3C358C;
        Fri, 14 Jul 2023 11:54:45 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-98e2865e2f2so59416366b.0;
        Fri, 14 Jul 2023 11:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360884; x=1689965684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9Q+l2wgz1odf30ahJjWbv4V4PSTmin8e6j6JZq03ec=;
        b=SKg7evfguDwyDhIvgwwhQbP76mMPnK1cqne7g4nOcSl3qV4Z8mmOnfEyaDtg6aKBL1
         BLQCX2ts+NoZj59S8IaxW2JpBVXTObjVxTpq8X207+qqrivCRcFhQ2lnioKsPKxmoYIk
         kHry3BgCJsS3+brn4TGRRKW143/wuVV4UphbZDqfK7IVIxMgeJcghumjHPIIrnKdtLSl
         UhyCasp2l4A4v/buBI3LdyWX/HjfhWa4wQipPvQtKgJ1hzzBY8XncOYCMiHPlVTg1oe9
         N9BwSJUmk21qJMsVkWg1ZlxEIWET0zeg96OjygIUUW6K7CkABc0me01732T78KhJ00K3
         xNvw==
X-Gm-Message-State: ABy/qLaIBc5ii5+S+zBS5IfHQr1yzW7kdHRKqIbUCDZ/rk4eUlyb4Yah
        qgNqp4fehZQcFnRicjPzifCAB8z5hL9HndcY/rU=
X-Google-Smtp-Source: APBJJlGhaOM79BfPa2VO7mCVX5b0FIZOwxwzZu/FbMxOsMzMxZRHoIVKOP+u0TuNNIMmvmEFgweRKWR164C4QCOMVmY=
X-Received: by 2002:a17:906:64cb:b0:993:d54b:3e42 with SMTP id
 p11-20020a17090664cb00b00993d54b3e42mr40714ejn.5.1689360883937; Fri, 14 Jul
 2023 11:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230714175008.4064592-1-robh@kernel.org>
In-Reply-To: <20230714175008.4064592-1-robh@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jul 2023 20:54:32 +0200
Message-ID: <CAJZ5v0i-OByOSjpxrj5d9S9QHRySK-MEUo+bK_J_4ihsCBmnSg@mail.gmail.com>
Subject: Re: [PATCH] thermal: Explicitly include correct DT includes
To:     Rob Herring <robh@kernel.org>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 7:51 PM Rob Herring <robh@kernel.org> wrote:
>
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

or please let me know if you want me to pick this up.

Thanks!

> ---
>  drivers/thermal/amlogic_thermal.c           | 2 --
>  drivers/thermal/broadcom/bcm2711_thermal.c  | 2 +-
>  drivers/thermal/broadcom/brcmstb_thermal.c  | 2 +-
>  drivers/thermal/hisi_thermal.c              | 2 +-
>  drivers/thermal/imx8mm_thermal.c            | 1 -
>  drivers/thermal/imx_sc_thermal.c            | 1 -
>  drivers/thermal/imx_thermal.c               | 2 +-
>  drivers/thermal/k3_bandgap.c                | 2 +-
>  drivers/thermal/k3_j72xx_bandgap.c          | 2 +-
>  drivers/thermal/mediatek/auxadc_thermal.c   | 1 -
>  drivers/thermal/mediatek/lvts_thermal.c     | 2 +-
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c    | 1 -
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 1 -
>  drivers/thermal/rcar_gen3_thermal.c         | 2 +-
>  drivers/thermal/rcar_thermal.c              | 2 +-
>  drivers/thermal/rzg2l_thermal.c             | 2 +-
>  drivers/thermal/samsung/exynos_tmu.c        | 2 +-
>  drivers/thermal/sprd_thermal.c              | 2 +-
>  drivers/thermal/st/stm_thermal.c            | 2 --
>  drivers/thermal/sun8i_thermal.c             | 2 +-
>  drivers/thermal/tegra/tegra30-tsensor.c     | 2 +-
>  drivers/thermal/thermal_of.c                | 3 +--
>  drivers/thermal/uniphier_thermal.c          | 1 -
>  23 files changed, 15 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index 756b218880a7..81ebbf6de0de 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -22,8 +22,6 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/thermal.h>
> diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
> index c243a76a3471..03ac2d02e9d4 100644
> --- a/drivers/thermal/broadcom/bcm2711_thermal.c
> +++ b/drivers/thermal/broadcom/bcm2711_thermal.c
> @@ -15,8 +15,8 @@
>  #include <linux/kernel.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <linux/of_device.h>
>  #include <linux/regmap.h>
>  #include <linux/thermal.h>
>
> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> index 72d1dbe60b8f..0b73abdaa792 100644
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -17,8 +17,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <linux/of_device.h>
>  #include <linux/thermal.h>
>
>  #define AVS_TMON_STATUS                        0x00
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index 3f09ef8be41a..fb54ed4bf6f0 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -13,9 +13,9 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> -#include <linux/of_device.h>
>  #include <linux/thermal.h>
>
>  #define HI6220_TEMP0_LAG                       (0x0)
> diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
> index d4b40869c7d7..e89b11b3f2b9 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -12,7 +12,6 @@
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/thermal.h>
> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> index 8d6b4ef23746..7224f8d21db9 100644
> --- a/drivers/thermal/imx_sc_thermal.c
> +++ b/drivers/thermal/imx_sc_thermal.c
> @@ -8,7 +8,6 @@
>  #include <linux/firmware/imx/sci.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/thermal.h>
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index a94ec0a0c9dd..826358cbe810 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -11,7 +11,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/thermal.h>
>  #include <linux/nvmem-consumer.h>
> diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
> index 1c3e590157ec..68f59b3735d3 100644
> --- a/drivers/thermal/k3_bandgap.c
> +++ b/drivers/thermal/k3_bandgap.c
> @@ -11,7 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/thermal.h>
>  #include <linux/types.h>
> diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
> index 5be1f09eeb2c..a5a0fc9b9356 100644
> --- a/drivers/thermal/k3_j72xx_bandgap.c
> +++ b/drivers/thermal/k3_j72xx_bandgap.c
> @@ -10,10 +10,10 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/err.h>
>  #include <linux/types.h>
> -#include <linux/of_platform.h>
>  #include <linux/io.h>
>  #include <linux/thermal.h>
>  #include <linux/of.h>
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
> index f59d36de20a0..c537aed71017 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -15,7 +15,6 @@
>  #include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index b693fac2d677..054c965ae5e1 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -13,7 +13,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/nvmem-consumer.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/thermal.h>
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index 5ddc39b2be32..756ac6842ff9 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -14,7 +14,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/thermal.h>
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index 0e8ebfcd84c5..78c5cfe6a0c0 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -10,7 +10,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/thermal.h>
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 9029d01e029b..bd2fb8c2e968 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -11,7 +11,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/thermal.h>
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index b8571f7090aa..293f8dd9fe0a 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -11,7 +11,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reboot.h>
> diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
> index b56981f85306..6b2bf3426f52 100644
> --- a/drivers/thermal/rzg2l_thermal.c
> +++ b/drivers/thermal/rzg2l_thermal.c
> @@ -9,8 +9,8 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/math.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 45e5c840d130..58f4d8f7a3fd 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -15,7 +15,7 @@
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
> index 2fb90fdad76e..e27c4bdc8912 100644
> --- a/drivers/thermal/sprd_thermal.c
> +++ b/drivers/thermal/sprd_thermal.c
> @@ -6,7 +6,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/thermal.h>
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index 903fcf1763f1..142a7e5d12f4 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -14,8 +14,6 @@
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/thermal.h>
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index 195f3c5d0b38..cca16d632d9f 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -14,7 +14,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
> index c243e9d76d3c..d911fa60f100 100644
> --- a/drivers/thermal/tegra/tegra30-tsensor.c
> +++ b/drivers/thermal/tegra/tegra30-tsensor.c
> @@ -18,7 +18,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/math.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/reset.h>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 6fb14e521197..c36c7d235cba 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -10,8 +10,7 @@
>
>  #include <linux/err.h>
>  #include <linux/export.h>
> -#include <linux/of_device.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/thermal.h>
>  #include <linux/types.h>
> diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
> index aef6119cc004..6f32ab61d174 100644
> --- a/drivers/thermal/uniphier_thermal.c
> +++ b/drivers/thermal/uniphier_thermal.c
> @@ -12,7 +12,6 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/thermal.h>
> --
> 2.40.1
>
