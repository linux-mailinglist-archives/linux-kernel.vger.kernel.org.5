Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5D2766889
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjG1JOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbjG1JMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D593A97;
        Fri, 28 Jul 2023 02:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8B1762088;
        Fri, 28 Jul 2023 09:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF74C433C7;
        Fri, 28 Jul 2023 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535437;
        bh=jsukJ3h2ilmz083UcYGengZNcUIJYlLHWk6g/LKxW1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jq54e2P2vabTsv0/ZkCTu/TtAKcPA/986KlVzpTtjaLAFsettUVGxIIEhV012qHmY
         XjZnDjmAeW2ab1ZsUURkM7jE4L/524t63e/2b+AR7jZDEQXiyB3jMa2BRjo+JEpwRs
         l3QdUPJ8w/4urXWddV+VETsCyali7ZkVGVcRJ/K6g+RVz5T9C+bf9WioC+uygEDa9I
         Rh3AvZFW0PdulmDiZySwu0Xy2XsI/jHB3Xyi77hPM/dAwa7KUnEsd9+KEupPqjueWP
         u1x3RpBtfjI/oksjIHjYF89qn/jUU3ZW18drI+6RQKSDrQ5SYoMzV9cMfadNlCraZU
         lW9h48LazI1/g==
Date:   Fri, 28 Jul 2023 10:10:24 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-actions@lists.infradead.org, chrome-platform@lists.linux.dev,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mfd: Explicitly include correct DT includes
Message-ID: <20230728091024.GE8175@google.com>
References: <20230714174731.4059811-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230714174731.4059811-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023, Rob Herring wrote:

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
>  drivers/mfd/ab8500-core.c           | 1 -
>  drivers/mfd/acer-ec-a500.c          | 2 +-
>  drivers/mfd/act8945a.c              | 2 +-
>  drivers/mfd/altera-sysmgr.c         | 3 +--
>  drivers/mfd/arizona-core.c          | 1 -
>  drivers/mfd/atc260x-core.c          | 1 -
>  drivers/mfd/bcm590xx.c              | 1 -
>  drivers/mfd/cros_ec_dev.c           | 2 +-
>  drivers/mfd/da9052-i2c.c            | 5 +----
>  drivers/mfd/da9055-i2c.c            | 1 -
>  drivers/mfd/da9062-core.c           | 2 +-
>  drivers/mfd/hi655x-pmic.c           | 4 ++--
>  drivers/mfd/iqs62x.c                | 2 +-
>  drivers/mfd/lp873x.c                | 2 +-
>  drivers/mfd/madera-i2c.c            | 1 -
>  drivers/mfd/madera-spi.c            | 1 -
>  drivers/mfd/max77620.c              | 1 -
>  drivers/mfd/max77686.c              | 1 -
>  drivers/mfd/max77843.c              | 2 +-
>  drivers/mfd/max8907.c               | 1 -
>  drivers/mfd/max8925-core.c          | 1 -
>  drivers/mfd/max8997.c               | 1 -
>  drivers/mfd/max8998.c               | 1 -
>  drivers/mfd/mt6358-irq.c            | 5 ++---
>  drivers/mfd/mt6397-core.c           | 5 +++--
>  drivers/mfd/mt6397-irq.c            | 5 ++---
>  drivers/mfd/palmas.c                | 3 ++-
>  drivers/mfd/qcom-pm8008.c           | 2 +-
>  drivers/mfd/rave-sp.c               | 2 +-
>  drivers/mfd/rk8xx-core.c            | 2 +-
>  drivers/mfd/rohm-bd71828.c          | 2 +-
>  drivers/mfd/rohm-bd718x7.c          | 2 +-
>  drivers/mfd/rohm-bd9576.c           | 2 +-
>  drivers/mfd/rt5033.c                | 2 +-
>  drivers/mfd/rz-mtu3.c               | 4 +++-
>  drivers/mfd/sec-core.c              | 2 --
>  drivers/mfd/sprd-sc27xx-spi.c       | 2 +-
>  drivers/mfd/ssbi.c                  | 6 +++---
>  drivers/mfd/stm32-lptimer.c         | 1 +
>  drivers/mfd/stm32-timers.c          | 1 +
>  drivers/mfd/sun4i-gpadc.c           | 4 ++--
>  drivers/mfd/ti-lmu.c                | 1 -
>  drivers/mfd/ti_am335x_tscadc.c      | 2 +-
>  drivers/mfd/tps6507x.c              | 1 -
>  drivers/mfd/tps65090.c              | 1 -
>  drivers/mfd/tps65217.c              | 1 -
>  drivers/mfd/tps65218.c              | 1 -
>  drivers/mfd/tps6594-core.c          | 2 +-
>  drivers/mfd/twl6040.c               | 2 --
>  drivers/mfd/wm831x-core.c           | 3 +--
>  drivers/mtd/chips/cfi_cmdset_0002.c | 3 +--
>  51 files changed, 42 insertions(+), 66 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
