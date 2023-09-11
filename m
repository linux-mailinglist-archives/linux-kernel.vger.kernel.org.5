Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7379A28F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 06:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjIKEtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 00:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjIKEtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 00:49:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9920118;
        Sun, 10 Sep 2023 21:49:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E1D7C433C8;
        Mon, 11 Sep 2023 04:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694407740;
        bh=jRbGX37pKE/flPAVK4KmRTNNYn+YjmtCaP+B5V/gVX0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hRTK/O7zd2EVcyRIHv/i0CAjz9UpjidahDXSIXk4ACb38jZ+6K0Q30pzOqZOLqypY
         C75nnrtT8Yv6GiMTvD61pKvkFLRfhtUBVWtZcBLARUs5c+zflqjKF2vVtznLpozQoM
         GCNDa18FhndrrkuE6m/0q7HCv7yOAC6mlWVm+BRnredL6UXg7U1td5nMObALXI8tDQ
         4sZzvZ12uCsLziIZXf9AsxgF8FMszCNitekMmUlSZhzGlOAtLbZ6bAuUGQovA8xlPE
         s6xIC6qIfoHYkDG9jnYDNje1UTc0fpBvjr9tsdVWGYlC4/aJBTcr3g4fKbEVro77gN
         eo2XoPvZ0aheA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 122E7E1F67E;
        Mon, 11 Sep 2023 04:49:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mfd: Explicitly include correct DT includes
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169440774007.22573.6670993122914766002.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Sep 2023 04:49:00 +0000
References: <20230714174731.4059811-1-robh@kernel.org>
In-Reply-To: <20230714174731.4059811-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linus.walleij@linaro.org, lee@kernel.org,
        thor.thayer@linux.intel.com, mani@kernel.org,
        cristian.ciocaltea@gmail.com, bleung@chromium.org,
        groeck@chromium.org, support.opensource@diasemi.com,
        ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
        cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        tony@atomide.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mazziesaccount@gmail.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, fabrice.gasnier@foss.st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-actions@lists.infradead.org, chrome-platform@lists.linux.dev,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-mtd@lists.infradead.org
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
by Lee Jones <lee@kernel.org>:

On Fri, 14 Jul 2023 11:47:27 -0600 you wrote:
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
  - mfd: Explicitly include correct DT includes
    https://git.kernel.org/chrome-platform/c/dc0c386e09a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


