Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031E379A2A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 06:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjIKEtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 00:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjIKEtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 00:49:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B00F1B8;
        Sun, 10 Sep 2023 21:49:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 593E7C43395;
        Mon, 11 Sep 2023 04:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694407740;
        bh=4lLgVJb3LOG8DBSrlEzmuFBXuW0+M3lIby4bathQEJQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=C6/eNd9fiXyxGRt5Q8ahEQOhSgCzOfaDjiTl1H8jdUB7+nyLMvI8Z8jnvHGjBdQ49
         pDudL3FXplQYq7jTK8HLgIy9ITXlxnbVaDIU/4PMDDSn6qJkGjrWtox5bdK/GK3F5p
         C4G4DS2Wf1CiQbnf16oHi2/OLxkMc9s/eBeQrSQGCwpUsCE1in9Is3GDGfvYRWlM/7
         2tlXMXWIRD3zJvcrlFXk8QeGnir5Z0kGUyv09GiSS8f+5ARo1lX8qkv1qJbHYp6gz6
         YuEAVFmOzlKTCXnu+2B+mWUy9DGN2PXOf9rTw2PXn8k2N7iypmSeDiYERSZBfuV9XL
         EZljecptFgb1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D213E21EC1;
        Mon, 11 Sep 2023 04:49:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] pwm: Explicitly include correct DT includes
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169440774024.22573.12945048122079663648.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Sep 2023 04:49:00 +0000
References: <20230714174852.4062251-1-robh@kernel.org>
In-Reply-To: <20230714174852.4062251-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, bleung@chromium.org,
        groeck@chromium.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        paul@crapouillou.net, vz@mleia.com, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, conor.dooley@microchip.com,
        daire.mcnamara@microchip.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, michael@walle.cc, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        hammerh0314@gmail.com, jonathanh@nvidia.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Thierry Reding <thierry.reding@gmail.com>:

On Fri, 14 Jul 2023 11:48:50 -0600 you wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Here is the summary with links:
  - pwm: Explicitly include correct DT includes
    https://git.kernel.org/chrome-platform/c/0a41b0c5d97a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


