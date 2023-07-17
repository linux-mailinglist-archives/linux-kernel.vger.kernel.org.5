Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCA0755F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGQJUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjGQJUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C95510DF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD1CA60FD6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3261AC433C7;
        Mon, 17 Jul 2023 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689585622;
        bh=Voa/CSNqktkN5jIfp0OuJb79V2cagau1IrqZEU2/c6E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bMXLX9AauZcIQsd1rGLfEyN8HlJkSrqwf7M5vMRTLmz2jrSaMcZ2xvumWrC+cQVY5
         ez/uhDRS7+wAC93nFfUdM8bgONbNsyT8fmesidXOrryn1pT2OTyNy8KR2tEqWpoWMW
         6UKJDxc5lGuu4I5hj5GleC2BKRcehrtElhO5lbb1bjFT1aueWTC0eqo5CPzqr5ovfx
         YQoWTx275TbFDFxouASA9yG/LqAu88YQmzhhCOiDCPjWcAFdpjgMhWQLgXCyZO+mR8
         OPYJsgLCDYYetZ+rJJw/a8UPMJZtDDjOTVvoCgSgpWChiBUJKxM2KhFBXVpPTXqMQx
         hhfgDsPmCzSZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2077DE29F32;
        Mon, 17 Jul 2023 09:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/6] net: phy: at803x: support qca8081 1G version chip
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168958562212.29409.8301837233101770893.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Jul 2023 09:20:22 +0000
References: <20230716084924.9714-1-quic_luoj@quicinc.com>
In-Reply-To: <20230716084924.9714-1-quic_luoj@quicinc.com>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 16 Jul 2023 16:49:18 +0800 you wrote:
> This patch series add supporting qca8081 1G version chip, the 1G version
> chip can be identified by the register mmd7.0x901d bit0.
> 
> In addition, qca8081 does not support 1000BaseX mode and the sgmii fifo
> reset is added on the link changed, which assert the fifo on the link
> down, deassert the fifo on the link up.
> 
> [...]

Here is the summary with links:
  - [v3,1/6] net: phy: at803x: support qca8081 genphy_c45_pma_read_abilities
    https://git.kernel.org/netdev/net-next/c/8b8bc13d89a7
  - [v3,2/6] net: phy: at803x: merge qca8081 slave seed function
    https://git.kernel.org/netdev/net-next/c/f3db55ae860a
  - [v3,3/6] net: phy: at803x: enable qca8081 slave seed conditionally
    https://git.kernel.org/netdev/net-next/c/7cc320955800
  - [v3,4/6] net: phy: at803x: support qca8081 1G chip type
    https://git.kernel.org/netdev/net-next/c/fea7cfb83d1a
  - [v3,5/6] net: phy: at803x: remove qca8081 1G fast retrain and slave seed config
    https://git.kernel.org/netdev/net-next/c/df9401ff3e6e
  - [v3,6/6] net: phy: at803x: add qca8081 fifo reset on the link changed
    https://git.kernel.org/netdev/net-next/c/723970affdd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


