Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197D87CED89
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjJSBUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjJSBU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:20:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727B2114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAA4BC433B7;
        Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697678425;
        bh=ujbwjyPp7flADUazRHX5T83U0iFam3+e8fdXdyBTKio=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KYvIVcfAyngBOjo7IePqG8nfiNBMGFCiyeHcHhu7wCH0hWqkA8jBLhScXP0K50qCF
         S68wJRig72qroLZ1FCbLUqIHtIrvTvbkC7AX7oCZVcJM9hGocMbrrDH7Gj/ZmDoQz5
         lr+oXZrsd/Kbh/u5uccGhtTwiGBQWQTyuXV2avSq/yQdey8lSzTh9QNkiRsfcwdj3V
         ts8P2AW2frXSPX35vIywjuHBhbT/pa5lB5XgFbjkrz7XVhjrubbOhSmiz4tkYxHDl/
         wdrDonH2Kqdsz4haWMYpd0nx3NMY9fvzjacWPuvswfMK6lLWqaEYINNXG/tMFehfd1
         MfcdIb1ugyNgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C40F5E00083;
        Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: mdio-mux: fix C45 access returning -EIO after API
 change
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169767842479.18183.7049442961896700081.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Oct 2023 01:20:24 +0000
References: <20231017143144.3212657-1-vladimir.oltean@nxp.com>
In-Reply-To: <20231017143144.3212657-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, rmk+kernel@armlinux.org.uk,
        f.fainelli@gmail.com, michael@walle.cc,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Oct 2023 17:31:44 +0300 you wrote:
> The mii_bus API conversion to read_c45() and write_c45() did not cover
> the mdio-mux driver before read() and write() were made C22-only.
> 
> This broke arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso.
> The -EOPNOTSUPP from mdiobus_c45_read() is transformed by
> get_phy_c45_devs_in_pkg() into -EIO, is further propagated to
> of_mdiobus_register() and this makes the mdio-mux driver fail to probe
> the entire child buses, not just the PHYs that cause access errors.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: mdio-mux: fix C45 access returning -EIO after API change
    https://git.kernel.org/netdev/net/c/1f9f2143f24e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


