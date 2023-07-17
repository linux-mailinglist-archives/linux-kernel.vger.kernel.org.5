Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EEC756AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGQRq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjGQRq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:46:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA70189;
        Mon, 17 Jul 2023 10:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F146611A5;
        Mon, 17 Jul 2023 17:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCE7C433CB;
        Mon, 17 Jul 2023 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616014;
        bh=aTPuf0Zd8OpbwoKQZ65jJYeSg9DTodI+njCE2/27PY8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fBMcwhUNcM0V4autvJVgcKQnhFbO7brLAEesnhEzKxTvyYBZsqjwc+cojOZv8v9UC
         C1fFtr+snZnoCQBuIjCC+uqbL1txzClbWIi6/Eqa6m+4RGip54iRnMoz47f6udL2oG
         QgKwwUVcwaxROldmVq5NNT3ndThlYFno/GItwYo30sXRqpZ3vtfi8rmQeHUZPSZsw8
         nBomaa0tVX346pR41e0rqob0iI2Yo27n4Om1YAlYa9235UCWZuLT6xOi/p3K5HKm5U
         yiAaqVLPCkUZKmnHgR84LUxhUnkrP+Q15V/RcRNk1rR8kEkcW0/GgWyopYhnj8btQ/
         HW5N4J95bcJrg==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-992b27e1c55so627045266b.2;
        Mon, 17 Jul 2023 10:46:54 -0700 (PDT)
X-Gm-Message-State: ABy/qLYHsdcjkilx0BN7/t1n4Ml1FGgPfUozaQr7DJMRdOQG1eYr+Xez
        pIFJhaGijYNxuSNKXyBT+K794cSdGc3vqW3RdQ==
X-Google-Smtp-Source: APBJJlEaii1O/P4FM3AIiFrxrm+c2/2j2dMof6/ew372YwZ9YuuOJ20F60zHYXA1FfdAlxaKv4uhiryEoY4fwMAMSwI=
X-Received: by 2002:a2e:7a1a:0:b0:2b5:bc27:d6eb with SMTP id
 v26-20020a2e7a1a000000b002b5bc27d6ebmr8861286ljc.8.1689615991907; Mon, 17 Jul
 2023 10:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230714174745.4060260-1-robh@kernel.org>
In-Reply-To: <20230714174745.4060260-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 17 Jul 2023 11:46:19 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+H5jcTfuAdE=XvcWP+Td3xn9hdq1QA3HKouPJDaedwYg@mail.gmail.com>
Message-ID: <CAL_Jsq+H5jcTfuAdE=XvcWP+Td3xn9hdq1QA3HKouPJDaedwYg@mail.gmail.com>
Subject: Re: [PATCH] mmc: Explicitly include correct DT includes
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Robert Richter <rric@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-actions@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 11:48=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
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
>  drivers/mmc/host/atmel-mci.c                  | 1 -
>  drivers/mmc/host/cavium-octeon.c              | 2 ++
>  drivers/mmc/host/cavium-thunderx.c            | 1 +
>  drivers/mmc/host/davinci_mmc.c                | 1 -
>  drivers/mmc/host/meson-gx-mmc.c               | 2 +-
>  drivers/mmc/host/mtk-sd.c                     | 4 +---
>  drivers/mmc/host/mxcmmc.c                     | 1 -
>  drivers/mmc/host/mxs-mmc.c                    | 1 -
>  drivers/mmc/host/owl-mmc.c                    | 3 ++-
>  drivers/mmc/host/pxamci.c                     | 1 -
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 ++-
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 3 ++-
>  drivers/mmc/host/sdhci-bcm-kona.c             | 1 -
>  drivers/mmc/host/sdhci-cadence.c              | 2 +-
>  drivers/mmc/host/sdhci-esdhc-imx.c            | 2 +-
>  drivers/mmc/host/sdhci-iproc.c                | 2 +-
>  drivers/mmc/host/sdhci-msm.c                  | 2 +-
>  drivers/mmc/host/sdhci-of-arasan.c            | 3 ++-

Not visible in the diff, but there's a double include of of.h. v2 coming.

>  drivers/mmc/host/sdhci-of-at91.c              | 2 +-
>  drivers/mmc/host/sdhci-of-dwcmshc.c           | 2 +-
>  drivers/mmc/host/sdhci-of-sparx5.c            | 2 +-
>  drivers/mmc/host/sdhci-omap.c                 | 1 -
>  drivers/mmc/host/sdhci-pxav2.c                | 1 -
>  drivers/mmc/host/sdhci-s3c.c                  | 1 -
>  drivers/mmc/host/sdhci-sprd.c                 | 1 -
>  drivers/mmc/host/sdhci-tegra.c                | 1 -
>  drivers/mmc/host/sh_mmcif.c                   | 1 -
>  drivers/mmc/host/uniphier-sd.c                | 1 -
>  drivers/mmc/host/wmt-sdmmc.c                  | 1 -
>  29 files changed, 20 insertions(+), 29 deletions(-)
