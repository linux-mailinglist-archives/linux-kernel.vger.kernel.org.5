Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C2F781564
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbjHRWUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241595AbjHRWUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:20:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97DA4213
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:20:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 594D161508
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 22:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9E55C433CB;
        Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692397227;
        bh=0siwSpzPAecerRDCRzE041XpLAcbPWf3qT5C89Iq5Os=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FQ0gnryK+NBlLZjHIioObpULhKTiIrEUG0fvJM/ua1qq+lIefYqsFI2rrboghWr5w
         K88yGLSf/GYtpU6/7eUOPaOAveXdfFdPDx5krBrc3qja0dIZ3rbXCZBOQrmwWRoSJl
         2Wjl3+g8oaqYO0yhUXbRj1Nl5w/13Rih/VV/tCyAv/zXaUQhpR2B2ndePstKgetqqp
         +hYJtwyBprmlDnxLPrg6vfrJwTHzsNFkCHMavUxCNJ4l65RyQilM1RCae2oVsaWs7d
         rM0h/M4DhSK/nZW3rpxlO5JWDo9Hy14Xz+uKV05qzLTn5yA3XPailxx/SERjE7/p3P
         U1bxU1YPjwXEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D847E26D32;
        Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fec: use napi_consume_skb() in
 fec_enet_tx_queue()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169239722757.24641.1884586305107929173.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Aug 2023 22:20:27 +0000
References: <20230816090242.463822-1-wei.fang@nxp.com>
In-Reply-To: <20230816090242.463822-1-wei.fang@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.duyck@gmail.com,
        xiaoning.wang@nxp.com, shenwei.wang@nxp.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Aug 2023 17:02:42 +0800 you wrote:
> Now that the "budget" is passed into fec_enet_tx_queue(), one
> optimization we can do is to use napi_consume_skb() to instead
> of dev_kfree_skb_any().
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Suggested-by: Alexander H Duyck <alexander.duyck@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: fec: use napi_consume_skb() in fec_enet_tx_queue()
    https://git.kernel.org/netdev/net-next/c/91a10efc89dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


