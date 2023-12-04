Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A098041D8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjLDWuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjLDWuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:50:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143009A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:50:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B8B4C433C8;
        Mon,  4 Dec 2023 22:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701730225;
        bh=jjdIloF0FAy8I2tM+gJ9RK5E26bL6+O+vP/7/q92QQs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nDi41n4qsmMo19g/WnwfkLpGcV745+7vAOl/3u0oZg53Q0B/KB+9tNNuUENJI0Q73
         YW29lr43tOe251tznOpXrwzvYZuJ58FOpYXMzbEv+i6PcBCFjqX7lNPdZ4/Xf8+YFc
         FKQ6iagPmlShwiouhD27BjDVnOXOWh49bo6uwir+V872+W5OSn0Swwo/8GHzKmT63c
         QRTJB/5uS+QfYc02hWJ2fM6wmEmKTM95qJEfVaz6fO5mIkcm8IRDr18InRkvCCl/vR
         ZUaAT3Hh286+UdmyNAQS72k6NnfOrGaWv1baBtwHMFSZVV3xI+SdutCQ2Pw+mLhLxR
         l22MllZUDU04w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B08FDD4EEF;
        Mon,  4 Dec 2023 22:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] net: phy: micrel: additional clock handling
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170173022543.15217.5866312608760743633.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Dec 2023 22:50:25 +0000
References: <20231201150131.326766-1-heiko@sntech.de>
In-Reply-To: <20231201150131.326766-1-heiko@sntech.de>
To:     =?utf-8?q?Heiko_St=C3=BCbner_=3Cheiko=40sntech=2Ede=3E?=@ci.codeaurora.org
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, quentin.schulz@theobroma-systems.com
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

On Fri,  1 Dec 2023 16:01:29 +0100 you wrote:
> Some Micrel phys define a specific rmii-ref clock (added in 2014) while
> the generic phy binding specifies an unnamed clock for ethernet phys.
> 
> This allows Micrel phys to use both, so as to keep the phys not using
> the named rmii-ref clock to conform to the generic binding while allowing
> them to enable a supplying clock, when the phy is not supplied by a
> dedicated oscillator.
> 
> [...]

Here is the summary with links:
  - [1/2] net: phy: micrel: use devm_clk_get_optional_enabled for the rmii-ref clock
    https://git.kernel.org/netdev/net-next/c/985329462723
  - [2/2] net: phy: micrel: allow usage of generic ethernet-phy clock
    https://git.kernel.org/netdev/net-next/c/99ac4cbcc2a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


