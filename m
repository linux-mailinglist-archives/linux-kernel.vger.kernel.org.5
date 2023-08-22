Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1395784CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjHVWlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjHVWlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:41:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7F3CDD;
        Tue, 22 Aug 2023 15:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5FC66331C;
        Tue, 22 Aug 2023 22:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D76C433CD;
        Tue, 22 Aug 2023 22:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692744092;
        bh=j18p9nRczmc7jkTANS/QW/bBrviEnu5HmJXmu3kshTY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PJaBiV/tywlUkjoY8D1PZlbI3DnskUjUDu0cGmf3xBU5nrpuOHargSXwdUNkcqPOl
         gQtcGcMBeMlFF0K8uHCTIAfeMbboqmfNTsjsvpFwk9ndkjIPnbexhktwyNrnipJWFT
         /S701ptCkT9kmjqIK5RWqpnLUlgEDaaoYF1KVsQ4MHAQPK7DLVRTEETP2Xz4FFsefN
         qYAqbx1yOzgtOKS51IObaNXG+sbfwMEdd2Fd2y+0soVZ2z2LwGaX79iMOmo+d21pEz
         CIkaLosqOVjNdUx62/Pf6rp0p7dLU88i8azlGZRfp0ATRR1udkWxPHzGVK9ZS+cE0h
         +3oYItfNwcfRA==
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-317716a4622so4457906f8f.1;
        Tue, 22 Aug 2023 15:41:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YyuXfyDsKVg0fIXH1VwW7NzprsWM4W/G3FixJ1j9Yr/otQQQjMt
        hi4hTzDHo8ioERTHvQHAr/m5dOeAlc+mmVW6Lg==
X-Google-Smtp-Source: AGHT+IFuaSgpBPM6BkfK+psopXbYzSKQ/OSb6CO/+dRRKedlE2iEfXboaY8/ToZFGc5Vqfi33qhLL69/S6kipJeRmjo=
X-Received: by 2002:a2e:8612:0:b0:2bc:b54b:c03f with SMTP id
 a18-20020a2e8612000000b002bcb54bc03fmr6798329lji.5.1692744069129; Tue, 22 Aug
 2023 15:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230714174421.4054194-1-robh@kernel.org>
In-Reply-To: <20230714174421.4054194-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Aug 2023 17:40:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL_CvroupJEFwrjt8WOq=4WBxvE3sOTMnY8hEuBAMG=1g@mail.gmail.com>
Message-ID: <CAL_JsqL_CvroupJEFwrjt8WOq=4WBxvE3sOTMnY8hEuBAMG=1g@mail.gmail.com>
Subject: Re: [PATCH] crypto: Explicitly include correct DT includes
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neal Liu <neal_liu@aspeedtech.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Declan Murphy <declan.murphy@intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michal Simek <michal.simek@amd.com>,
        Harsha <harsha.harsha@amd.com>
Cc:     devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:44=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
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
> ---
>  drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c   | 1 -
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c   | 1 -
>  drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c   | 1 -
>  drivers/crypto/amlogic/amlogic-gxl-core.c           | 1 -
>  drivers/crypto/aspeed/aspeed-acry.c                 | 3 ---
>  drivers/crypto/atmel-aes.c                          | 6 ++----
>  drivers/crypto/atmel-ecc.c                          | 2 +-
>  drivers/crypto/atmel-sha.c                          | 6 ++----
>  drivers/crypto/atmel-tdes.c                         | 6 ++----
>  drivers/crypto/bcm/cipher.c                         | 3 +--
>  drivers/crypto/caam/ctrl.c                          | 1 +
>  drivers/crypto/caam/jr.c                            | 1 +
>  drivers/crypto/caam/qi.c                            | 1 +
>  drivers/crypto/ccree/cc_driver.c                    | 1 -
>  drivers/crypto/exynos-rng.c                         | 2 +-
>  drivers/crypto/gemini/sl3516-ce-core.c              | 1 -
>  drivers/crypto/img-hash.c                           | 4 ++--
>  drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c | 3 ++-
>  drivers/crypto/n2_core.c                            | 2 +-
>  drivers/crypto/omap-aes.c                           | 1 -
>  drivers/crypto/omap-des.c                           | 2 --
>  drivers/crypto/omap-sham.c                          | 1 -
>  drivers/crypto/rockchip/rk3288_crypto.c             | 1 -
>  drivers/crypto/s5p-sss.c                            | 1 -
>  drivers/crypto/sa2ul.c                              | 3 ++-
>  drivers/crypto/sahara.c                             | 1 -
>  drivers/crypto/starfive/jh7110-cryp.c               | 2 +-
>  drivers/crypto/starfive/jh7110-hash.c               | 1 -
>  drivers/crypto/stm32/stm32-cryp.c                   | 2 +-
>  drivers/crypto/stm32/stm32-hash.c                   | 2 +-
>  drivers/crypto/talitos.c                            | 4 ++--
>  drivers/crypto/xilinx/zynqmp-aes-gcm.c              | 2 +-
>  drivers/crypto/xilinx/zynqmp-sha.c                  | 1 -
>  33 files changed, 25 insertions(+), 45 deletions(-)

Ping!

>
> diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c b/drivers/=
crypto/allwinner/sun4i-ss/sun4i-ss-core.c
> index 51a3a7b5b985..3bcfcfc37084 100644
> --- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
> +++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
> @@ -14,7 +14,6 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <crypto/scatterwalk.h>
>  #include <linux/scatterlist.h>
> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/=
crypto/allwinner/sun8i-ce/sun8i-ce-core.c
> index 07ea0cc82b16..258d447765eb 100644
> --- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
> +++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
> @@ -18,7 +18,6 @@
>  #include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/=
crypto/allwinner/sun8i-ss/sun8i-ss-core.c
> index 3dd844b40ff7..77bddd5ebaf0 100644
> --- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
> +++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
> @@ -19,7 +19,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/a=
mlogic/amlogic-gxl-core.c
> index 937187027ad5..c8fa4a8bfd34 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> @@ -13,7 +13,6 @@
>  #include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <crypto/internal/skcipher.h>
>  #include <linux/dma-mapping.h>
> diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/=
aspeed-acry.c
> index 470122c87fea..d16f570c40d2 100644
> --- a/drivers/crypto/aspeed/aspeed-acry.c
> +++ b/drivers/crypto/aspeed/aspeed-acry.c
> @@ -11,10 +11,7 @@
>  #include <linux/clk.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
> -#include <linux/of_address.h>
> -#include <linux/of_irq.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/interrupt.h>
>  #include <linux/count_zeros.h>
> diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
> index 143d33fbb316..21c8c2112c6a 100644
> --- a/drivers/crypto/atmel-aes.c
> +++ b/drivers/crypto/atmel-aes.c
> @@ -28,7 +28,7 @@
>  #include <linux/irq.h>
>  #include <linux/scatterlist.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/delay.h>
>  #include <linux/crypto.h>
>  #include <crypto/scatterwalk.h>
> @@ -2533,13 +2533,11 @@ static void atmel_aes_get_cap(struct atmel_aes_de=
v *dd)
>         }
>  }
>
> -#if defined(CONFIG_OF)
>  static const struct of_device_id atmel_aes_dt_ids[] =3D {
>         { .compatible =3D "atmel,at91sam9g46-aes" },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, atmel_aes_dt_ids);
> -#endif
>
>  static int atmel_aes_probe(struct platform_device *pdev)
>  {
> @@ -2687,7 +2685,7 @@ static struct platform_driver atmel_aes_driver =3D =
{
>         .remove         =3D atmel_aes_remove,
>         .driver         =3D {
>                 .name   =3D "atmel_aes",
> -               .of_match_table =3D of_match_ptr(atmel_aes_dt_ids),
> +               .of_match_table =3D atmel_aes_dt_ids,
>         },
>  };
>
> diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
> index 432beabd79e6..590ea984c622 100644
> --- a/drivers/crypto/atmel-ecc.c
> +++ b/drivers/crypto/atmel-ecc.c
> @@ -14,7 +14,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
> index 6bef634d3c86..b791be63d84b 100644
> --- a/drivers/crypto/atmel-sha.c
> +++ b/drivers/crypto/atmel-sha.c
> @@ -28,7 +28,7 @@
>  #include <linux/irq.h>
>  #include <linux/scatterlist.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/delay.h>
>  #include <linux/crypto.h>
>  #include <crypto/scatterwalk.h>
> @@ -2570,14 +2570,12 @@ static void atmel_sha_get_cap(struct atmel_sha_de=
v *dd)
>         }
>  }
>
> -#if defined(CONFIG_OF)
>  static const struct of_device_id atmel_sha_dt_ids[] =3D {
>         { .compatible =3D "atmel,at91sam9g46-sha" },
>         { /* sentinel */ }
>  };
>
>  MODULE_DEVICE_TABLE(of, atmel_sha_dt_ids);
> -#endif
>
>  static int atmel_sha_probe(struct platform_device *pdev)
>  {
> @@ -2716,7 +2714,7 @@ static struct platform_driver atmel_sha_driver =3D =
{
>         .remove         =3D atmel_sha_remove,
>         .driver         =3D {
>                 .name   =3D "atmel_sha",
> -               .of_match_table =3D of_match_ptr(atmel_sha_dt_ids),
> +               .of_match_table =3D atmel_sha_dt_ids,
>         },
>  };
>
> diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
> index c9ded8be9c39..2f152f80f61a 100644
> --- a/drivers/crypto/atmel-tdes.c
> +++ b/drivers/crypto/atmel-tdes.c
> @@ -28,7 +28,7 @@
>  #include <linux/irq.h>
>  #include <linux/scatterlist.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/delay.h>
>  #include <linux/crypto.h>
>  #include <crypto/scatterwalk.h>
> @@ -1139,13 +1139,11 @@ static void atmel_tdes_get_cap(struct atmel_tdes_=
dev *dd)
>         }
>  }
>
> -#if defined(CONFIG_OF)
>  static const struct of_device_id atmel_tdes_dt_ids[] =3D {
>         { .compatible =3D "atmel,at91sam9g46-tdes" },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, atmel_tdes_dt_ids);
> -#endif
>
>  static int atmel_tdes_probe(struct platform_device *pdev)
>  {
> @@ -1282,7 +1280,7 @@ static struct platform_driver atmel_tdes_driver =3D=
 {
>         .remove         =3D atmel_tdes_remove,
>         .driver         =3D {
>                 .name   =3D "atmel_tdes",
> -               .of_match_table =3D of_match_ptr(atmel_tdes_dt_ids),
> +               .of_match_table =3D atmel_tdes_dt_ids,
>         },
>  };
>
> diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
> index 70b911baab26..262c7dbc5e5f 100644
> --- a/drivers/crypto/bcm/cipher.c
> +++ b/drivers/crypto/bcm/cipher.c
> @@ -15,8 +15,7 @@
>  #include <linux/kthread.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/sched.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/io.h>
>  #include <linux/bitops.h>
>
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
> index ff9ddbbca377..74bcd3083881 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -9,6 +9,7 @@
>  #include <linux/device.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/platform_device.h>
>  #include <linux/sys_soc.h>
>  #include <linux/fsl/mc.h>
>
> diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
> index 96dea5304d22..73b7aa68f21c 100644
> --- a/drivers/crypto/caam/jr.c
> +++ b/drivers/crypto/caam/jr.c
> @@ -9,6 +9,7 @@
>
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
> +#include <linux/platform_device.h>
>
>  #include "compat.h"
>  #include "ctrl.h"
> diff --git a/drivers/crypto/caam/qi.c b/drivers/crypto/caam/qi.c
> index 2ad2c1035856..46a083849a8e 100644
> --- a/drivers/crypto/caam/qi.c
> +++ b/drivers/crypto/caam/qi.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
>  #include <linux/netdevice.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <soc/fsl/qman.h>
> diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_d=
river.c
> index c57f929805d5..0f0694037dd7 100644
> --- a/drivers/crypto/ccree/cc_driver.c
> +++ b/drivers/crypto/ccree/cc_driver.c
> @@ -14,7 +14,6 @@
>  #include <linux/of.h>
>  #include <linux/clk.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>
>  #include "cc_driver.h"
> diff --git a/drivers/crypto/exynos-rng.c b/drivers/crypto/exynos-rng.c
> index cbd8ca6e52ee..773c3238c603 100644
> --- a/drivers/crypto/exynos-rng.c
> +++ b/drivers/crypto/exynos-rng.c
> @@ -15,7 +15,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>
>  #include <crypto/internal/rng.h>
> diff --git a/drivers/crypto/gemini/sl3516-ce-core.c b/drivers/crypto/gemi=
ni/sl3516-ce-core.c
> index b7524b649068..e9c00d76545b 100644
> --- a/drivers/crypto/gemini/sl3516-ce-core.c
> +++ b/drivers/crypto/gemini/sl3516-ce-core.c
> @@ -16,7 +16,6 @@
>  #include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/img-hash.c b/drivers/crypto/img-hash.c
> index 359aa2b41016..45063693859c 100644
> --- a/drivers/crypto/img-hash.c
> +++ b/drivers/crypto/img-hash.c
> @@ -13,7 +13,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/scatterlist.h>
>
> @@ -1105,7 +1105,7 @@ static struct platform_driver img_hash_driver =3D {
>         .driver         =3D {
>                 .name   =3D "img-hash-accelerator",
>                 .pm     =3D &img_hash_pm_ops,
> -               .of_match_table =3D of_match_ptr(img_hash_match),
> +               .of_match_table =3D img_hash_match,
>         }
>  };
>  module_platform_driver(img_hash_driver);
> diff --git a/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c b/driver=
s/crypto/intel/keembay/keembay-ocs-hcu-core.c
> index d4bcbed1f546..226654b12779 100644
> --- a/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
> +++ b/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
> @@ -10,7 +10,8 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
>
>  #include <crypto/engine.h>
>  #include <crypto/scatterwalk.h>
> diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
> index 4f6ca229ee5e..d5a32d71a3e9 100644
> --- a/drivers/crypto/n2_core.c
> +++ b/drivers/crypto/n2_core.c
> @@ -10,7 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/cpumask.h>
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
> diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
> index 67a99c760bc4..71002a12993d 100644
> --- a/drivers/crypto/omap-aes.c
> +++ b/drivers/crypto/omap-aes.c
> @@ -24,7 +24,6 @@
>  #include <linux/dmaengine.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/of_address.h>
>  #include <linux/io.h>
>  #include <linux/crypto.h>
> diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
> index f783769ea110..82cca34017e4 100644
> --- a/drivers/crypto/omap-des.c
> +++ b/drivers/crypto/omap-des.c
> @@ -27,8 +27,6 @@
>  #include <linux/dmaengine.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
> -#include <linux/of_address.h>
>  #include <linux/io.h>
>  #include <linux/crypto.h>
>  #include <linux/interrupt.h>
> diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
> index cbeda59c6b19..4c25fc42044c 100644
> --- a/drivers/crypto/omap-sham.c
> +++ b/drivers/crypto/omap-sham.c
> @@ -28,7 +28,6 @@
>  #include <linux/dmaengine.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/delay.h>
> diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/roc=
kchip/rk3288_crypto.c
> index 9f6ba770a90a..f3a79bec76a8 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto.c
> +++ b/drivers/crypto/rockchip/rk3288_crypto.c
> @@ -14,7 +14,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk.h>
>  #include <linux/crypto.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
> index 1c4d5fb05d69..fe8cf9ba8005 100644
> --- a/drivers/crypto/s5p-sss.c
> +++ b/drivers/crypto/s5p-sss.c
> @@ -20,7 +20,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/scatterlist.h>
>
> diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
> index df5f9d675c57..6238d34f8db2 100644
> --- a/drivers/crypto/sa2ul.c
> +++ b/drivers/crypto/sa2ul.c
> @@ -15,7 +15,8 @@
>  #include <linux/dmapool.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>
> diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
> index 4c799df3e883..62d93526920f 100644
> --- a/drivers/crypto/sahara.c
> +++ b/drivers/crypto/sahara.c
> @@ -27,7 +27,6 @@
>  #include <linux/kthread.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>
> diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starf=
ive/jh7110-cryp.c
> index cc43556b6c80..0f517ea06bcb 100644
> --- a/drivers/crypto/starfive/jh7110-cryp.c
> +++ b/drivers/crypto/starfive/jh7110-cryp.c
> @@ -11,8 +11,8 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/starfive/jh7110-hash.c b/drivers/crypto/starf=
ive/jh7110-hash.c
> index 5064150b8a1c..41c9e40c6551 100644
> --- a/drivers/crypto/starfive/jh7110-hash.c
> +++ b/drivers/crypto/starfive/jh7110-hash.c
> @@ -14,7 +14,6 @@
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm=
32-cryp.c
> index 6b8d731092a4..ab12c782dec5 100644
> --- a/drivers/crypto/stm32/stm32-cryp.c
> +++ b/drivers/crypto/stm32/stm32-cryp.c
> @@ -10,7 +10,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm=
32-hash.c
> index f0df32382719..cb3ca28fb193 100644
> --- a/drivers/crypto/stm32/stm32-hash.c
> +++ b/drivers/crypto/stm32/stm32-hash.c
> @@ -15,7 +15,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
> index bb27f011cf31..4ca4fbd227bc 100644
> --- a/drivers/crypto/talitos.c
> +++ b/drivers/crypto/talitos.c
> @@ -19,9 +19,9 @@
>  #include <linux/interrupt.h>
>  #include <linux/crypto.h>
>  #include <linux/hw_random.h>
> -#include <linux/of_address.h>
> +#include <linux/of.h>
>  #include <linux/of_irq.h>
> -#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
>  #include <linux/spinlock.h>
> diff --git a/drivers/crypto/xilinx/zynqmp-aes-gcm.c b/drivers/crypto/xili=
nx/zynqmp-aes-gcm.c
> index bf1f421e05f2..6092ff0646a8 100644
> --- a/drivers/crypto/xilinx/zynqmp-aes-gcm.c
> +++ b/drivers/crypto/xilinx/zynqmp-aes-gcm.c
> @@ -12,7 +12,7 @@
>
>  #include <linux/dma-mapping.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>
>  #include <linux/firmware/xlnx-zynqmp.h>
> diff --git a/drivers/crypto/xilinx/zynqmp-sha.c b/drivers/crypto/xilinx/z=
ynqmp-sha.c
> index 43ff170ff1c2..426bf1a72ba6 100644
> --- a/drivers/crypto/xilinx/zynqmp-sha.c
> +++ b/drivers/crypto/xilinx/zynqmp-sha.c
> @@ -15,7 +15,6 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>
>  #define ZYNQMP_DMA_BIT_MASK            32U
> --
> 2.40.1
>
