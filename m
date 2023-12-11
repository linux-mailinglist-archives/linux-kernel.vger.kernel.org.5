Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B133B80D441
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbjLKRlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344788AbjLKRlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:41:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9779B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:41:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AD7C433C8;
        Mon, 11 Dec 2023 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702316475;
        bh=PllPgC6jFjFNbe2TPwiW5goZeLtWhQUt5qmauKn2CDw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O4+aymOSCooiqVnpPvcqGFE7y27bEO0yR5ZSR8tfpjWXMlWRgFHhlQQ6FUgHD35Hx
         0PzTAUf0JQzdeG2pedQ6VdSTTOIaK7DSZPhFXxqnJg75uwohwxKczosO2HDTmDdcZR
         pFEpkx2dNqBwHZQyUIcd0HNjGUYkNL5UlR+eP0OFlMf6iFJuyKpuCSg8f8MCt5Nye9
         z6usUTF4A4V41b5iA6vyF2yhE9BRZbbOIri/1OekL9N1c8SjVwi3xAQDqEQkk0R1D2
         vgnzJByWVWTIQSNMQjmn73Uk9z2nNEUj5u3zv9qD29FFLQX0j6ShXRcCCL31zaCGku
         z/uF4QS58ZCtQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so59171111fa.3;
        Mon, 11 Dec 2023 09:41:15 -0800 (PST)
X-Gm-Message-State: AOJu0Yx/+yBkeDfN+Yt4h2kwampBjULMoMfxf3PcQUG2i5BNEUpknnvZ
        LVfXVrAYKnUH66FR1n3Vty+VTAM+3zzO+a2F+w==
X-Google-Smtp-Source: AGHT+IGkcHpYKgGzrmFoYFcv1jEtnEJ+2+7bmjc/X8fpV/QWWPMtzKwiTR2LaZ6KhgrTFSrbOGyqvUIixYbDORE+8pQ=
X-Received: by 2002:a19:e003:0:b0:507:a04c:76e8 with SMTP id
 x3-20020a19e003000000b00507a04c76e8mr1319442lfg.46.1702316473658; Mon, 11 Dec
 2023 09:41:13 -0800 (PST)
MIME-Version: 1.0
References: <20231129054339.3054202-1-james.tai@realtek.com> <20231129054339.3054202-4-james.tai@realtek.com>
In-Reply-To: <20231129054339.3054202-4-james.tai@realtek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Dec 2023 11:41:01 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+WJ2me4CoPN14pof4aMegC1F6ei6q_Nt8+RYG3bfJM4g@mail.gmail.com>
Message-ID: <CAL_Jsq+WJ2me4CoPN14pof4aMegC1F6ei6q_Nt8+RYG3bfJM4g@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] irqchip: Introduce RTD1319 support using the
 Realtek common interrupt controller driver
To:     James Tai <james.tai@realtek.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel test robot <lkp@intel.com>
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

On Tue, Nov 28, 2023 at 11:44=E2=80=AFPM James Tai <james.tai@realtek.com> =
wrote:
>
> Add support for the RTD1319 platform.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311061208.hJmxGqym-lkp@i=
ntel.com/
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Marc Zyngier <maz@kernel.org>
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: James Tai <james.tai@realtek.com>
> ---
> v2 to v3 change:
> - Unchanged
>
> v1 to v2 change:
> - Resolved kernel test robot build warnings
> - Replaced magic number with macro
> - Fixed code style issues
>
>  drivers/irqchip/Kconfig               |   6 +
>  drivers/irqchip/Makefile              |   1 +
>  drivers/irqchip/irq-realtek-rtd1319.c | 218 ++++++++++++++++++++++++++
>  3 files changed, 225 insertions(+)
>  create mode 100644 drivers/irqchip/irq-realtek-rtd1319.c
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 267c3429b48d..05856ce885fa 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -222,6 +222,12 @@ config REALTEK_DHC_INTC
>         tristate
>         select IRQ_DOMAIN
>
> +config REALTEK_RTD1319_INTC
> +       tristate "Realtek RTD1319 interrupt controller"
> +       select REALTEK_DHC_INTC
> +       help
> +         Support for Realtek RTD1319 Interrupt Controller.
> +
>  config RENESAS_INTC_IRQPIN
>         bool "Renesas INTC External IRQ Pin Support" if COMPILE_TEST
>         select IRQ_DOMAIN
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index f6774af7fde2..6a2650b0a924 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_IXP4XX_IRQ)              +=3D irq-ixp4xx.o
>  obj-$(CONFIG_JCORE_AIC)                        +=3D irq-jcore-aic.o
>  obj-$(CONFIG_RDA_INTC)                 +=3D irq-rda-intc.o
>  obj-$(CONFIG_REALTEK_DHC_INTC)         +=3D irq-realtek-intc-common.o
> +obj-$(CONFIG_REALTEK_RTD1319_INTC)     +=3D irq-realtek-rtd1319.o
>  obj-$(CONFIG_RENESAS_INTC_IRQPIN)      +=3D irq-renesas-intc-irqpin.o
>  obj-$(CONFIG_RENESAS_IRQC)             +=3D irq-renesas-irqc.o
>  obj-$(CONFIG_RENESAS_RZA1_IRQC)                +=3D irq-renesas-rza1.o
> diff --git a/drivers/irqchip/irq-realtek-rtd1319.c b/drivers/irqchip/irq-=
realtek-rtd1319.c
> new file mode 100644
> index 000000000000..23c13c218b04
> --- /dev/null
> +++ b/drivers/irqchip/irq-realtek-rtd1319.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Realtek RTD1319 interrupt controller driver
> + *
> + * Copyright (c) 2023 Realtek Semiconductor Corporation
> + */
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/irqchip.h>
> +#include <linux/of_device.h>

You probably don't need this header and the implicit includes it makes
are dropped now in linux-next. Please check what you actually need and
make them explicit.

Rob
