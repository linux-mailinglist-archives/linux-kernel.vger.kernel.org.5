Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4655877848A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjHKAaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHKAaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1251B2D4F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C9A964DD3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 001F6C433CA;
        Fri, 11 Aug 2023 00:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691713822;
        bh=VTdqDcF8RsP1Tx5iHwaXGP1sG1BJp3vTg2yHLtubAGY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=c1cvUsLVvbNOxrcxKegdBTWgRa317/WWR1Oi1n6cAFjOaCcxZsBiY53OcJg1fS7Ev
         G89XIHnIu8dqylZvu+OMJMiBDLSZ4Rt7losPpISfhl3+FG02roRQxO9UCWBiKBOi7A
         fs3ku7qcm6EWDUA4kU/beALERnma4vRJb3x/bB1oztNxINbjIXS/IiRtzJGXVj1gXY
         YF7+XOdu/pbCTHWoV6Cm7VAkb87fSc0QPrkCdzQ4itEgwZzfsyQKTF0vOQpKCba7Ie
         dStQ0fBtVtYEhiK6Q4diHYrkE9LtkSbtCIQs/yQnGO3Od3b0l4WKqlK8ZLnvDWcnkY
         m6dFswKw9/Q9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D498FC595D0;
        Fri, 11 Aug 2023 00:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net-next 0/2] update stmmac fix_mac_speed
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169171382186.19672.4297213896256628885.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Aug 2023 00:30:21 +0000
References: <20230807160716.259072-1-shenwei.wang@nxp.com>
In-Reply-To: <20230807160716.259072-1-shenwei.wang@nxp.com>
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     mkl@pengutronix.de, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, vkoul@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, bhupesh.sharma@linaro.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, simon.horman@corigine.com,
        ahalaney@redhat.com, bartosz.golaszewski@linaro.org,
        veekhee@apple.com, ruppala@nvidia.com,
        jh@henneberg-systemdesign.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, imx@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 11:07:14 -0500 you wrote:
> Changes in V5:
>   - fixed the typo in if condition reported by Russell.
>   - fixed the build errors in dwmac-sti.c reported by 'kernel test robot'.
> 
> Changes in V4:
>   - Keep the 'unsigned int' type specifier in the fix_mac_speed
>     function declarations.
>   - Move imx93_dwmac_fix_mac_speed into the SoC specific ops.
>   - Use a read back to replace the wmb() instruction.
>   - Correct the target to 'net-next'.
> 
> [...]

Here is the summary with links:
  - [v5,net-next,1/2] net: stmmac: add new mode parameter for fix_mac_speed
    https://git.kernel.org/netdev/net-next/c/1fc04a0b9733
  - [v5,net-next,2/2] net: stmmac: dwmac-imx: pause the TXC clock in fixed-link
    https://git.kernel.org/netdev/net-next/c/4fa6c976158b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


