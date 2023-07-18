Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC4D757C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjGRNB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjGRNBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:01:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B901BCC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D342561574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FC1BC433CB;
        Tue, 18 Jul 2023 13:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689685221;
        bh=YhcgHtzLlmVi3GHSDNyC9x/8/VLUnN1Gq6tIeq0PHBs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MKoIfJbOBdKaOVRbdMtzyRcxQs97Cy+/X0x1omDzZpeDXMAwb1JK7UXlBGGyMfSOT
         clb1DfI1kou11LW4pBk9Kz4BRyP9/ofv18XWqqY5Z9z7NYZuRZd/UH/f3uWbt7ajMu
         pULbfLB5gt4fC0kSgmXS8byaWz0DQl0cERiEOwuLsc/lB8VADgTSSrsWNOJrTecLFf
         xUHUC0SC8lx2RlSSoE29dZ6iykfBggDfnZDSNlTrELiRqEJpx90BJkdtaOxSwf5ADX
         8E+8daF79dmnReDp0N31XWsQR+2Ao0sUDkZU2MCqcvglezaYYlBAFeYPYqxVvXTSpM
         SxNSFBKE3khCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C4CFC64458;
        Tue, 18 Jul 2023 13:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-pf: Dont allocate BPIDs for LBK interfaces
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168968522117.17545.5835247146378375722.git-patchwork-notify@kernel.org>
Date:   Tue, 18 Jul 2023 13:00:21 +0000
References: <20230716093741.28063-1-gakula@marvell.com>
In-Reply-To: <20230716093741.28063-1-gakula@marvell.com>
To:     Geetha sowjanya <gakula@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 16 Jul 2023 15:07:41 +0530 you wrote:
> Current driver enables backpressure for LBK interfaces.
> But these interfaces do not support this feature.
> Hence, this patch fixes the issue by skipping the
> backpressure configuration for these interfaces.
> 
> Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool").
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Dont allocate BPIDs for LBK interfaces
    https://git.kernel.org/netdev/net/c/8fcd7c7b3a38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


