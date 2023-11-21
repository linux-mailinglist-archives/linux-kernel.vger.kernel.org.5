Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318E27F235F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjKUCAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjKUCA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:00:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8379C3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:00:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 575ECC433C9;
        Tue, 21 Nov 2023 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700532025;
        bh=bmnu7rZL78TcXp+dlQU9LKtmJm149s70Jq6+OiDF0nI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CxaAsi5juaQkib6IE5gMbNX5bN/n5Gd+wlEli9sqWni7EPK/f/7FXg5ef4iZo7YiF
         FsO0m8370nsh1FFxLDGV6/hnJSqr/4bQySUs+xiFxQbXRiapcKu1rtI+xdLtV73+yL
         y/84IPcGJX8QZrOcdHpvUBaD52DUYACBi1t+uPXbwJMpaBGXOkyJRShmbirbPacs4I
         hTFDFD1N3SzD/HRVo6ENnmif2sHfrfVbE6de2CplNpgpgxkNO38DGg2bRLgcfMcfNm
         +6J0gOcy2S2jA5Ri2iwFYdIkb4N7Xmx1mUgp7+0laFPJV+7CBa9iwEqNm+88ZlvrYY
         RkcITKnFqSVhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 399EDEAA957;
        Tue, 21 Nov 2023 02:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/3] net: axienet: Introduce dmaengine
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170053202523.14605.14081014495866819607.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Nov 2023 02:00:25 +0000
References: <1700074613-1977070-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1700074613-1977070-1-git-send-email-radhey.shyam.pandey@amd.com>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, linux@armlinux.org.uk,
        anirudha.sarangi@amd.com, harini.katakam@amd.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Nov 2023 00:26:50 +0530 you wrote:
> The axiethernet driver can use the dmaengine framework to communicate
> with the xilinx DMAengine driver(AXIDMA, MCDMA). The inspiration behind
> this dmaengine adoption is to reuse the in-kernel xilinx dma engine
> driver[1] and remove redundant dma programming sequence[2] from the
> ethernet driver. This simplifies the ethernet driver and also makes
> it generic to be hooked to any complaint dma IP i.e AXIDMA, MCDMA
> without any modification.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/3] dt-bindings: net: xlnx,axi-ethernet: Introduce DMA support
    https://git.kernel.org/netdev/net-next/c/5e63c5ef7a99
  - [net-next,v9,2/3] net: axienet: Preparatory changes for dmaengine support
    https://git.kernel.org/netdev/net-next/c/6b1b40f704fc
  - [net-next,v9,3/3] net: axienet: Introduce dmaengine support
    https://git.kernel.org/netdev/net-next/c/6a91b846af85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


