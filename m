Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1009812E37
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443909AbjLNLKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443944AbjLNLKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:10:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA129113
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:10:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C2AFC433C9;
        Thu, 14 Dec 2023 11:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702552225;
        bh=xwq0ikO0DH4IjRaxfWn3ELJXTbtrWoZcQar3Cp9coY4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=r7iKIUNYJL2tt8CpKsqUnySzPVGJvGxjxP68NsPV/cpO8VBRIdi8XmoWkjr7vQjI+
         itYWFGeyBhW+C8DetPiCsgp84810L/bev5rfLIxP/xpDn6CG+OK0v/mVvrIzie1Iw+
         6Kjr/tejTbTQvRPWj7Nnf9Zc5k11UuHdC0FEcXswEfjdA3GHQifqyBA2NuCT2A9+CX
         VGUv3N5aYiNDDOhR5cVtkqCKyGBLH4eNwJFkccc8OuUSh1AOYBmAhAUi5E98dXPP+q
         0uBkckcSO8gOIz1LmjA+xSJpkdMjBxqb4R0A+EEYNzXx4urQT6P5gBiBiPWsZfNG0k
         ilK/DgPLeLvXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30E03DD4EFD;
        Thu, 14 Dec 2023 11:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: Handle disabled MDIO busses from
 devicetree
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170255222519.10804.11119972355205402863.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Dec 2023 11:10:25 +0000
References: <20231212-b4-stmmac-handle-mdio-enodev-v2-1-600171acf79f@redhat.com>
In-Reply-To: <20231212-b4-stmmac-handle-mdio-enodev-v2-1-600171acf79f@redhat.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        peppe.cavallaro@st.com, andrew@lunn.ch, fancer.lancer@gmail.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Dec 2023 16:18:33 -0600 you wrote:
> Many hardware configurations have the MDIO bus disabled, and are instead
> using some other MDIO bus to talk to the MAC's phy.
> 
> of_mdiobus_register() returns -ENODEV in this case. Let's handle it
> gracefully instead of failing to probe the MAC.
> 
> Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: Handle disabled MDIO busses from devicetree
    https://git.kernel.org/netdev/net/c/e23c0d21ce92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


