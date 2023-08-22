Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787A2784CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjHVWjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjHVWjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:39:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567B3CEC;
        Tue, 22 Aug 2023 15:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D76D0641CD;
        Tue, 22 Aug 2023 22:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C7CC433CB;
        Tue, 22 Aug 2023 22:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692743982;
        bh=CZFmwYUtV9SMtahTpYBt42jtzaSy6GGw/CbrKYzHKlo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bcZmaaVcQdtn/FKC78HUE09ulwiiWH8oDgA/vu+YTq+OSK/6o6HZ+K5VBfjgPqFy6
         ThPQRE7OOxXiTLcuU3+vJg0UtRCsyasblvYmWSwUqw1tclLZ5YLm8WOEQ6aTMtT0CZ
         FsY5I7uITrAXGDO+iAyzd45c8nwLu2eqTH/WucSo5oznJyk/OFWqcoa3TyF+DqnWmf
         UJG7vmoivPhsIgo6rEA4r23lbk2RIKrxXn74+Gz/F5AyP4l8YNKKisvbrtUZzwa2zY
         pu3rJ9ZKlKhcI9STO1u3gjju1ckZ0L5xqwVKvuQNxJm5zVqIeSwZyua9LjkMYhZ8SZ
         mtDS4caQfa1Yg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b9a2033978so77850781fa.0;
        Tue, 22 Aug 2023 15:39:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YzytcSMWFe5NSrecVGpW6w4DqMAZL2hjqcXikoWdyvGwfR1CAP5
        gixe/znzG0gvT3BseVc0zg21byp/QUBGDRVDrw==
X-Google-Smtp-Source: AGHT+IFdzdumhqguxAy1uaCpYr5SwhOBwkYrmDKcqzRgaHzAhY/zR9+y+s4AFjWOtuvUMl/KgrRNt6BxR0EUirFwiEo=
X-Received: by 2002:a2e:3a09:0:b0:2bc:b54b:c024 with SMTP id
 h9-20020a2e3a09000000b002bcb54bc024mr6089895lja.29.1692743980259; Tue, 22 Aug
 2023 15:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230714174702.4059100-1-robh@kernel.org>
In-Reply-To: <20230714174702.4059100-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Aug 2023 17:39:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLkxm_A6+AP4iSzsu4snsYfDNoZ_PNF6nzdVY-_nBEU8Q@mail.gmail.com>
Message-ID: <CAL_JsqLkxm_A6+AP4iSzsu4snsYfDNoZ_PNF6nzdVY-_nBEU8Q@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Explicitly include correct DT includes
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:47=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
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
>  drivers/mailbox/arm_mhu.c            | 1 +
>  drivers/mailbox/arm_mhu_db.c         | 1 -
>  drivers/mailbox/hi3660-mailbox.c     | 1 +
>  drivers/mailbox/hi6220-mailbox.c     | 1 +
>  drivers/mailbox/imx-mailbox.c        | 3 ++-
>  drivers/mailbox/mailbox-mpfs.c       | 1 +
>  drivers/mailbox/mailbox.c            | 1 +
>  drivers/mailbox/mtk-adsp-mailbox.c   | 3 ++-
>  drivers/mailbox/mtk-cmdq-mailbox.c   | 2 +-
>  drivers/mailbox/omap-mailbox.c       | 2 +-
>  drivers/mailbox/platform_mhu.c       | 1 +
>  drivers/mailbox/rockchip-mailbox.c   | 2 +-
>  drivers/mailbox/sprd-mailbox.c       | 2 +-
>  drivers/mailbox/stm32-ipcc.c         | 1 +
>  drivers/mailbox/tegra-hsp.c          | 1 -
>  drivers/mailbox/zynqmp-ipi-mailbox.c | 2 --
>  16 files changed, 15 insertions(+), 10 deletions(-)

Ping!

>
> diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
> index 22243cabe056..537f7bfb7b06 100644
> --- a/drivers/mailbox/arm_mhu.c
> +++ b/drivers/mailbox/arm_mhu.c
> @@ -12,6 +12,7 @@
>  #include <linux/io.h>
>  #include <linux/mailbox_controller.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>
>  #define INTR_STAT_OFS  0x0
>  #define INTR_SET_OFS   0x8
> diff --git a/drivers/mailbox/arm_mhu_db.c b/drivers/mailbox/arm_mhu_db.c
> index aa0a4d83880f..27a510d46908 100644
> --- a/drivers/mailbox/arm_mhu_db.c
> +++ b/drivers/mailbox/arm_mhu_db.c
> @@ -15,7 +15,6 @@
>  #include <linux/mailbox_controller.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>
>  #define INTR_STAT_OFS  0x0
>  #define INTR_SET_OFS   0x8
> diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-ma=
ilbox.c
> index ab24e731a782..17c29e960fbf 100644
> --- a/drivers/mailbox/hi3660-mailbox.c
> +++ b/drivers/mailbox/hi3660-mailbox.c
> @@ -11,6 +11,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/mailbox_controller.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> diff --git a/drivers/mailbox/hi6220-mailbox.c b/drivers/mailbox/hi6220-ma=
ilbox.c
> index 1c73c63598f5..f77741ce42e7 100644
> --- a/drivers/mailbox/hi6220-mailbox.c
> +++ b/drivers/mailbox/hi6220-mailbox.c
> @@ -15,6 +15,7 @@
>  #include <linux/kfifo.h>
>  #include <linux/mailbox_controller.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.=
c
> index 20f2ec880ad6..3ef4dd8adf5d 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -14,7 +14,8 @@
>  #include <linux/kernel.h>
>  #include <linux/mailbox_controller.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/suspend.h>
>  #include <linux/slab.h>
> diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpf=
s.c
> index 162df49654fb..20ee283a04cc 100644
> --- a/drivers/mailbox/mailbox-mpfs.c
> +++ b/drivers/mailbox/mailbox-mpfs.c
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/mailbox_controller.h>
>  #include <soc/microchip/mpfs.h>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index adf36c05fa43..ebff3baf3045 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -17,6 +17,7 @@
>  #include <linux/bitops.h>
>  #include <linux/mailbox_client.h>
>  #include <linux/mailbox_controller.h>
> +#include <linux/of.h>
>
>  #include "mailbox.h"
>
> diff --git a/drivers/mailbox/mtk-adsp-mailbox.c b/drivers/mailbox/mtk-ads=
p-mailbox.c
> index 14bc0057de81..91487aa4d7da 100644
> --- a/drivers/mailbox/mtk-adsp-mailbox.c
> +++ b/drivers/mailbox/mtk-adsp-mailbox.c
> @@ -10,7 +10,8 @@
>  #include <linux/kernel.h>
>  #include <linux/mailbox_controller.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>
>  struct mtk_adsp_mbox_priv {
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index b18d47ea13a0..4d62b07c1411 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -15,7 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/mailbox_controller.h>
>  #include <linux/mailbox/mtk-cmdq-mailbox.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>
>  #define CMDQ_OP_CODE_MASK              (0xff << CMDQ_OP_CODE_SHIFT)
>  #define CMDQ_NUM_CMD(t)                        (t->cmd_buf_size / CMDQ_I=
NST_SIZE)
> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbo=
x.c
> index fa2ce3246b70..792bcaebbc9b 100644
> --- a/drivers/mailbox/omap-mailbox.c
> +++ b/drivers/mailbox/omap-mailbox.c
> @@ -16,7 +16,7 @@
>  #include <linux/kfifo.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/omap-mailbox.h>
> diff --git a/drivers/mailbox/platform_mhu.c b/drivers/mailbox/platform_mh=
u.c
> index a5922ac0b0bf..54161303a36b 100644
> --- a/drivers/mailbox/platform_mhu.c
> +++ b/drivers/mailbox/platform_mhu.c
> @@ -15,6 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/mailbox_controller.h>
> diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchi=
p-mailbox.c
> index 116286ecc5a0..10c7bee2a915 100644
> --- a/drivers/mailbox/rockchip-mailbox.c
> +++ b/drivers/mailbox/rockchip-mailbox.c
> @@ -8,8 +8,8 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/mailbox_controller.h>
> +#include <linux/of.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>
>  #define MAILBOX_A2B_INTEN              0x00
> diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbo=
x.c
> index e3c899abeed8..9ae57de77d4d 100644
> --- a/drivers/mailbox/sprd-mailbox.c
> +++ b/drivers/mailbox/sprd-mailbox.c
> @@ -11,7 +11,7 @@
>  #include <linux/io.h>
>  #include <linux/mailbox_controller.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>
> diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
> index 15d538fe2113..4ad3653f3866 100644
> --- a/drivers/mailbox/stm32-ipcc.c
> +++ b/drivers/mailbox/stm32-ipcc.c
> @@ -11,6 +11,7 @@
>  #include <linux/io.h>
>  #include <linux/mailbox_controller.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_wakeirq.h>
>
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index 7f98e7436d94..c87c2b900b64 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -8,7 +8,6 @@
>  #include <linux/io.h>
>  #include <linux/mailbox_controller.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/slab.h>
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqm=
p-ipi-mailbox.c
> index d097f45b0e5f..e4fcac97dbfa 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -16,8 +16,6 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
> -#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>
>  /* IPI agent ID any */
> --
> 2.40.1
>
