Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA728004A3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377725AbjLAHUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjLAHUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:20:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA5D103
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:20:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFE51C433C9;
        Fri,  1 Dec 2023 07:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701415227;
        bh=iuqi543xQfoWxFHW0+MvsQohCh1U2B0JVj7IPhBC/Yk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m93OSv/aqP5/E5pVQ8HmYAwq2ajekjvStexBFk5PL+3U6aVuUobpETjgzCmSL03Gu
         vrTLvWTSL4br9RoVmkOzjC4DFQP6+rd9UN1CmyRlTy4OZrO3Hu07L3MdMCdo2iFER1
         E0LPynHnbR4EwbmdLzfuEb27u8rFoKqmJS/K69Sm7HROW5o5BylC5gUIICYTJb9uQE
         7pvhtX0Y2VhYW+50MS01JLxnbToNFL8dmgP3ftG+d0di9q1tiFToR/KGkmNeKjEmgA
         zOVzzlG7tPD3z1pPFEIOYUYfzXW0x2POL27XLqMlX1rG4zrzwxKx2JME6h4JC98QdC
         D4DaprdYXccbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF619C4166E;
        Fri,  1 Dec 2023 07:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: mdio_device: Reset device only when
 necessary
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170141522684.3845.10488637215162933845.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Dec 2023 07:20:26 +0000
References: <20231127-net-phy-reset-once-v2-1-448e8658779e@redhat.com>
In-Reply-To: <20231127-net-phy-reset-once-v2-1-448e8658779e@redhat.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_scheluve@quicinc.com
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Nov 2023 15:41:10 -0600 you wrote:
> Currently the phy reset sequence is as shown below for a
> devicetree described mdio phy on boot:
> 
> 1. Assert the phy_device's reset as part of registering
> 2. Deassert the phy_device's reset as part of registering
> 3. Deassert the phy_device's reset as part of phy_probe
> 4. Deassert the phy_device's reset as part of phy_hw_init
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: mdio_device: Reset device only when necessary
    https://git.kernel.org/netdev/net-next/c/df16c1c51d81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


