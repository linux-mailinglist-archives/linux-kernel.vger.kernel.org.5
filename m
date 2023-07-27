Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6C1764512
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjG0EuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjG0EuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E2D272B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EC2961CDF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0FA1C433CD;
        Thu, 27 Jul 2023 04:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690433419;
        bh=oAlhpdqllpUNhhfbt/X1AhwYd7wBST0uOT3weX9MniI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Gx7VVZnKdw2ilCi1HKaXlthvQk991ZJmhMwD2KqbOmUTRwDWwfYSiaxaBXPP6/iK3
         k0LgKQZBErVAH4ihFp2UQYSj8w4Mm3pHtfN3OiAzx9bXIhKCNUmR1e3Qsrd+YPnn37
         uYn4foaqqryd08xi9c9r3fBPt44qskW8mB8slQMoqze0JHqAVUEKjo19ouvdDAtLic
         zqpJlvlgwoQ6d2rvRNgrVrvdXM7+TKsG1pWm2XyaMxmIirAwmF1ZTlqhH/kf4rfn8l
         LtEfNYw889QV/QNWLCWV4Kh9QJeCI4yUfoM4usoGGn1XYma/vnSCQpoVbQMqJlhStj
         nh2Ht7p5UcUsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9ED28C691F0;
        Thu, 27 Jul 2023 04:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bcmasp: BCMASP should depend on ARCH_BRCMSTB
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169043341964.19452.12546568587180628010.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Jul 2023 04:50:19 +0000
References: <1e8b998aa8dcc6e38323e295ee2430b48245cc79.1690299794.git.geert+renesas@glider.be>
In-Reply-To: <1e8b998aa8dcc6e38323e295ee2430b48245cc79.1690299794.git.geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, florian.fainelli@broadcom.com,
        justin.chen@broadcom.com, simon.horman@corigine.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 17:46:37 +0200 you wrote:
> The Broadcom ASP 2.0 Ethernet controller is only present on Broadcom STB
> SoCs.  Hence add a dependency on ARCH_BRCMSTB, to prevent asking the
> user about this driver when configuring a kernel without Broadcom
> ARM-based set-top box chipset support.
> 
> Fixes: 490cb412007de593 ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> [...]

Here is the summary with links:
  - [net] bcmasp: BCMASP should depend on ARCH_BRCMSTB
    https://git.kernel.org/netdev/net-next/c/73365fe44aa5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


