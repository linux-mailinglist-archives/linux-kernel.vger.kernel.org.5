Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A4C77D812
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbjHPCA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241134AbjHPCAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970F32111
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30EBD6474C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 888A8C433CC;
        Wed, 16 Aug 2023 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692151223;
        bh=/SivyJg8L6IR/Depj/t+YI1jAL7OVWimX+0Y3ciOitI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HoHHqUSN72uGtTeAaxsXXiAJnXHu18/C1a7kcmlmGPJvkOM1eo+FGYfN1R1Qs0dnB
         N3rvXM8HvY+vmHAOJMa2U9bFsWRWmZbQTrW0W4kz5IGNIx+l2vDEQJgqAEjNmjrCQR
         UM1bGxm+6W7ttums0RPEiqtLIwvfmWe1pjnZX3lm8Vf357FYnrKkQJODV7IdZegDr5
         PrNiM3GZqeVPTV8C4ny0u+jZVsb+feD1Thdvo+t8Qnn21GaFVIS1NvscTunEyztQz5
         ga0nvTbV2kH8AYgTgqn7R7DYNnUEe53Ub4a9pApc5DwMRLajDXUUpNXhqlbUwrTKFC
         G5S7F7hNxsKGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B29EC395C5;
        Wed, 16 Aug 2023 02:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: phy: mediatek-ge-soc: support PHY LEDs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169215122343.15326.15132582167017916301.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Aug 2023 02:00:23 +0000
References: <dc324d48c00cd7350f3a506eaa785324cae97372.1691977904.git.daniel@makrotopia.org>
In-Reply-To: <dc324d48c00cd7350f3a506eaa785324cae97372.1691977904.git.daniel@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     dqfext@gmail.com, SkyLake.Huang@mediatek.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

On Mon, 14 Aug 2023 02:58:14 +0100 you wrote:
> Implement netdev trigger and primitive bliking offloading as well as
> simple set_brigthness function for both PHY LEDs of the in-SoC PHYs
> found in MT7981 and MT7988.
> 
> For MT7988, read boottrap register and apply LED polarities accordingly
> to get uniform behavior from all LEDs on MT7988.
> This requires syscon phandle 'mediatek,pio' present in parenting MDIO bus
> which should point to the syscon holding the boottrap register.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: phy: mediatek-ge-soc: support PHY LEDs
    https://git.kernel.org/netdev/net-next/c/c66937b0f8db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


