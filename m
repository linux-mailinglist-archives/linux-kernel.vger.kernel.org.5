Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FCE80D40D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344778AbjLKRgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344781AbjLKRgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:36:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AA9E9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:36:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B601C43397;
        Mon, 11 Dec 2023 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702316215;
        bh=jnf9dg13SzBYTXr+GBpBiKbCKE+W4egIWCJCCgVUAwg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=loMjJRWMoMUGhMgm+YrnxZIpLCV3bDvtka0s23uKcX4z16ASC0s+UuYVJHGeBIYIB
         N27ZdO+4F8Lawqz9kb2Luwv9DyGq9QaTgPhpxI9eRVt5CsaJ/8hXk/1FrinkdTkG2l
         6DkZXddgjOC/nFXYY5q29djDfkZBGH+J+BAfsiySfpReSSCj43HJsZ98xx7K7bowh9
         XTlgW15lmK6opKpi3nU9cVIARat90LwpmncgYWKqsZuE8dv7mkglGhaEryRg2Soeal
         I1BlECQqH9HuKD3JA8HOwUOv2Bv48o7Cu4IgQR9V5VwfHj28+3s95m0s9ceGCoV8ju
         oWcQ6PJw8bn4w==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50be3611794so5575609e87.0;
        Mon, 11 Dec 2023 09:36:55 -0800 (PST)
X-Gm-Message-State: AOJu0YzzOzvob9fUgTBTHuY2N5lt+aYjf8lB+d3p76MnrLK6nXxdsepD
        k8DQhRcTK/6iwXYaGWMtYBpHGjs4GZ/6J5WSPA==
X-Google-Smtp-Source: AGHT+IHTBVeYuUBoGJIP6ycY2EOkZoObSSDfVZqLhoI3Lxe7oVt2ihkbRec/l/L5HGnrywwvadEcHP4hGnXcj/srfPU=
X-Received: by 2002:a05:6512:68a:b0:50d:15be:f07e with SMTP id
 t10-20020a056512068a00b0050d15bef07emr2866329lfe.74.1702316213414; Mon, 11
 Dec 2023 09:36:53 -0800 (PST)
MIME-Version: 1.0
References: <097e82b0d66570763d64be1715517d8b032fcf95.1702158423.git.daniel@makrotopia.org>
 <879b5bbcb165aa3f059a41218142b27e5f64597f.1702158423.git.daniel@makrotopia.org>
In-Reply-To: <879b5bbcb165aa3f059a41218142b27e5f64597f.1702158423.git.daniel@makrotopia.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Dec 2023 11:36:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJVY3-UneaoUNt6aGa2kU_3EVAwxJfY_mYZPyp=L=Bjtw@mail.gmail.com>
Message-ID: <CAL_JsqJVY3-UneaoUNt6aGa2kU_3EVAwxJfY_mYZPyp=L=Bjtw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] clk: mediatek: add drivers for MT7988 SoC
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Jianhui Zhao <zhaojh329@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
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

On Sat, Dec 9, 2023 at 3:56=E2=80=AFPM Daniel Golle <daniel@makrotopia.org>=
 wrote:
>
> From: Sam Shih <sam.shih@mediatek.com>
>
> Add APMIXED, ETH, INFRACFG and TOPCKGEN clock drivers which are
> typical MediaTek designs.
>
> Also add driver for XFIPLL clock generating the 156.25MHz clock for
> the XFI SerDes. It needs an undocumented software workaround and has
> an unknown internal design.
>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v4:
>  * make use of existing GATE_MTK_FLAGS macro
>  * reformat to max. 100 columns
>  * cosmetics
>
> v3: use git --from ...
> v2: no changes
>
>
>  drivers/clk/mediatek/Kconfig               |   9 +
>  drivers/clk/mediatek/Makefile              |   5 +
>  drivers/clk/mediatek/clk-mt7988-apmixed.c  | 102 +++++++
>  drivers/clk/mediatek/clk-mt7988-eth.c      | 133 +++++++++
>  drivers/clk/mediatek/clk-mt7988-infracfg.c | 274 +++++++++++++++++
>  drivers/clk/mediatek/clk-mt7988-topckgen.c | 325 +++++++++++++++++++++
>  drivers/clk/mediatek/clk-mt7988-xfipll.c   |  78 +++++
>  7 files changed, 926 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt7988-apmixed.c
>  create mode 100644 drivers/clk/mediatek/clk-mt7988-eth.c
>  create mode 100644 drivers/clk/mediatek/clk-mt7988-infracfg.c
>  create mode 100644 drivers/clk/mediatek/clk-mt7988-topckgen.c
>  create mode 100644 drivers/clk/mediatek/clk-mt7988-xfipll.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 48b42d11111cd..70a005e7e1b18 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -423,6 +423,15 @@ config COMMON_CLK_MT7986_ETHSYS
>           This driver adds support for clocks for Ethernet and SGMII
>           required on MediaTek MT7986 SoC.
>
> +config COMMON_CLK_MT7988
> +       tristate "Clock driver for MediaTek MT7988"
> +       depends on ARCH_MEDIATEK || COMPILE_TEST
> +       select COMMON_CLK_MEDIATEK
> +       default ARCH_MEDIATEK
> +       help
> +         This driver supports MediaTek MT7988 basic clocks and clocks
> +         required for various periperals found on this SoC.
> +
>  config COMMON_CLK_MT8135
>         tristate "Clock driver for MediaTek MT8135"
>         depends on (ARCH_MEDIATEK && ARM) || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefil=
e
> index dbeaa5b41177d..eeccfa039896f 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -62,6 +62,11 @@ obj-$(CONFIG_COMMON_CLK_MT7986) +=3D clk-mt7986-apmixe=
d.o
>  obj-$(CONFIG_COMMON_CLK_MT7986) +=3D clk-mt7986-topckgen.o
>  obj-$(CONFIG_COMMON_CLK_MT7986) +=3D clk-mt7986-infracfg.o
>  obj-$(CONFIG_COMMON_CLK_MT7986_ETHSYS) +=3D clk-mt7986-eth.o
> +obj-$(CONFIG_COMMON_CLK_MT7988) +=3D clk-mt7988-apmixed.o
> +obj-$(CONFIG_COMMON_CLK_MT7988) +=3D clk-mt7988-topckgen.o
> +obj-$(CONFIG_COMMON_CLK_MT7988) +=3D clk-mt7988-infracfg.o
> +obj-$(CONFIG_COMMON_CLK_MT7988) +=3D clk-mt7988-eth.o
> +obj-$(CONFIG_COMMON_CLK_MT7988) +=3D clk-mt7988-xfipll.o
>  obj-$(CONFIG_COMMON_CLK_MT8135) +=3D clk-mt8135-apmixedsys.o clk-mt8135.=
o
>  obj-$(CONFIG_COMMON_CLK_MT8167) +=3D clk-mt8167-apmixedsys.o clk-mt8167.=
o
>  obj-$(CONFIG_COMMON_CLK_MT8167_AUDSYS) +=3D clk-mt8167-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt7988-apmixed.c b/drivers/clk/medi=
atek/clk-mt7988-apmixed.c
> new file mode 100644
> index 0000000000000..02eb6354b01a8
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt7988-apmixed.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Sam Shih <sam.shih@mediatek.com>
> + * Author: Xiufeng Li <Xiufeng.Li@mediatek.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>

> +#include <linux/of_address.h>
> +#include <linux/of_device.h>

You probably don't need these 2 headers and the implicit includes
of_device.h makes are dropped now in linux-next. Please check what you
actually need and make them explicit.

Rob
