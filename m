Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9891F80D449
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjLKRlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjLKRlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:41:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A215AC8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:41:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B642C433CA;
        Mon, 11 Dec 2023 17:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702316515;
        bh=8vM15B5r9GNLZ5/wggwUsDIktWh+Yq5/KSnQ542rzvk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UWFa33Wd4t2HkTUGAkTpn+A6NzBeeFc4fe9rcDJoCyhhQRNVUM/eSa+M2fkK8Yqu7
         DIBP1GZc5DTx6AOfluEFI/vtXyutWzwp3kymkpvN5GSA2/OfvxcSN3UVll+gFpunK+
         FNNkqI6239iRikxnHd6wFmPmUljKgFzoP1+xDDkvAt0O0JhdH1mkOHft6hlkecxmhS
         AFsoFRhkNhoEFkgxtHP/6ieTW0hXv2oBVClt/Z/025aCrBBLARIz69tKtRjjMiZ9RF
         72ChJGfP2B04IErZzCK7Z9kvnBv0VUzW4D7H/RtVowNXmNjWDAUbL56+Tf/8aVfVTw
         E5ewHTum5mSHw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50d176eb382so4027666e87.2;
        Mon, 11 Dec 2023 09:41:55 -0800 (PST)
X-Gm-Message-State: AOJu0YzsBJDXwyJI9R1sKyzXt6mUswbrdfOEROGhufhLWBnnzz6jtdJJ
        DsMGYIVVdv4Fvgd4HfIOS++IdkR6Cr1LUbmYsA==
X-Google-Smtp-Source: AGHT+IGxQnoA+/JEx+duCxFB5wBYjC/Jw3X65IDZroxZABhYROnfRkji/JxBD23zzR7v3xP1TnCWppY+JbqUshsuMGk=
X-Received: by 2002:ac2:52ab:0:b0:50b:e109:bed1 with SMTP id
 r11-20020ac252ab000000b0050be109bed1mr2055001lfm.112.1702316513477; Mon, 11
 Dec 2023 09:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20231208094209.1910934-1-william.qiu@starfivetech.com> <20231208094209.1910934-3-william.qiu@starfivetech.com>
In-Reply-To: <20231208094209.1910934-3-william.qiu@starfivetech.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Dec 2023 11:41:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK8fsAocOu3OBdz1kzNiApf1J0Uc0spn8gfdJaVnomFHQ@mail.gmail.com>
Message-ID: <CAL_JsqK8fsAocOu3OBdz1kzNiApf1J0Uc0spn8gfdJaVnomFHQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] pwm: opencores: Add PWM driver support
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 3:42=E2=80=AFAM William Qiu <william.qiu@starfivetec=
h.com> wrote:
>
> Add driver for OpenCores PWM Controller. And add compatibility code
> which based on StarFive SoC.
>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  MAINTAINERS              |   7 ++
>  drivers/pwm/Kconfig      |  12 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-ocores.c | 229 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 249 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ocores.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 788be9ab5b73..7a11a22da09e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16204,6 +16204,13 @@ F:     Documentation/i2c/busses/i2c-ocores.rst
>  F:     drivers/i2c/busses/i2c-ocores.c
>  F:     include/linux/platform_data/i2c-ocores.h
>
> +OPENCORES PWM DRIVER
> +M:     William Qiu <william.qiu@starfivetech.com>
> +M:     Hal Feng <hal.feng@starfivetech.com>
> +S:     Supported
> +F:     Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> +F:     drivers/pwm/pwm-ocores.c
> +
>  OPENRISC ARCHITECTURE
>  M:     Jonas Bonn <jonas@southpole.se>
>  M:     Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..d87e1bb350ba 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -444,6 +444,18 @@ config PWM_NTXEC
>           controller found in certain e-book readers designed by the orig=
inal
>           design manufacturer Netronix.
>
> +config PWM_OCORES
> +       tristate "OpenCores PWM support"
> +       depends on HAS_IOMEM && OF
> +       depends on COMMON_CLK && RESET_CONTROLLER
> +       depends on ARCH_STARFIVE || COMPILE_TEST
> +       help
> +         If you say yes to this option, support will be included for the
> +         OpenCores PWM. For details see https://opencores.org/projects/p=
tc.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called pwm-ocores.
> +
>  config PWM_OMAP_DMTIMER
>         tristate "OMAP Dual-Mode Timer PWM support"
>         depends on OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c5ec9e168ee7..517c4f643058 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)      +=3D pwm-microchi=
p-core.o
>  obj-$(CONFIG_PWM_MTK_DISP)     +=3D pwm-mtk-disp.o
>  obj-$(CONFIG_PWM_MXS)          +=3D pwm-mxs.o
>  obj-$(CONFIG_PWM_NTXEC)                +=3D pwm-ntxec.o
> +obj-$(CONFIG_PWM_OCORES)       +=3D pwm-ocores.o
>  obj-$(CONFIG_PWM_OMAP_DMTIMER) +=3D pwm-omap-dmtimer.o
>  obj-$(CONFIG_PWM_PCA9685)      +=3D pwm-pca9685.o
>  obj-$(CONFIG_PWM_PXA)          +=3D pwm-pxa.o
> diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
> new file mode 100644
> index 000000000000..996ca3805901
> --- /dev/null
> +++ b/drivers/pwm/pwm-ocores.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * OpenCores PWM Driver
> + *
> + * https://opencores.org/projects/ptc
> + *
> + * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
> + *
> + * Limitations:
> + * - The hardware only do inverted polarity.
> + * - The hardware minimum period / duty_cycle is (1 / pwm_apb clock freq=
uency) ns.
> + * - The hardware maximum period / duty_cycle is (U32_MAX / pwm_apb cloc=
k frequency) ns.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

You probably don't need this header and the implicit includes it makes
are dropped now in linux-next. Please check what you actually need and
make them explicit.

Rob
