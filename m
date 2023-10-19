Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCB57CFBA7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345809AbjJSNu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345498AbjJSNu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:50:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF43A124;
        Thu, 19 Oct 2023 06:50:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49C7AC433CA;
        Thu, 19 Oct 2023 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697723424;
        bh=KGkjy3SWE/bKA0U7i+Yr3cNTc5UcUvO6Rcal+ZDSr/c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Fkn9QIdXC75u7o2BeSQnw8oriqaVsbkdmn8v7q3Y4UoyL+L4MJZ6h9ik/lLagxydE
         DiwqkqGxNnBtwxyWLLVyiJQXVHd4QfSCRXI47MpLNXPHoB3UeMqiBqVYOCVgwVxpuz
         WGVUQeHGqcB31bycdXPE+CMA2FBzGfJVQCcYtQy1Mw+XRXhVFzDmvemnA03138jiaX
         QRTCN/gxN/c9idAg16/UIMcJsg98IMHOjg3hZ1pBKVuKkgMb6hcxP+4shcAWE0G4tv
         WHlcF8N2+AfteiNJsG2Qabz7gH0V/Ge5Ytg+YR2AF6mqMRIBmoaNbdKTdVpPzoJveJ
         8FBb2rjRTJuwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C8F1C595CE;
        Thu, 19 Oct 2023 13:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v4 0/4] net: stmmac: improve tx timer logic
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169772342417.4360.7732259077441281905.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Oct 2023 13:50:24 +0000
References: <20231018123550.27110-1-ansuelsmth@gmail.com>
In-Reply-To: <20231018123550.27110-1-ansuelsmth@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     rajur@chelsio.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        pkshih@realtek.com, kvalo@kernel.org, horms@kernel.org,
        daniel@iogearbox.net, jiri@resnulli.us, liuhangbin@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
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
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Oct 2023 14:35:46 +0200 you wrote:
> This series comes with the intention of restoring original performance
> of stmmac on some router/device that used the stmmac driver to handle
> gigabit traffic.
> 
> More info are present in patch 3. This cover letter is to show results
> and improvements of the following change.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] net: introduce napi_is_scheduled helper
    https://git.kernel.org/netdev/net-next/c/7f3eb2174512
  - [net-next,v4,2/4] net: stmmac: improve TX timer arm logic
    https://git.kernel.org/netdev/net-next/c/2d1a42cf7f77
  - [net-next,v4,3/4] net: stmmac: move TX timer arm after DMA enable
    https://git.kernel.org/netdev/net-next/c/a594166387fe
  - [net-next,v4,4/4] net: stmmac: increase TX coalesce timer to 5ms
    https://git.kernel.org/netdev/net-next/c/039550960a22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


