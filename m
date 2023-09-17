Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9F87A3546
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 13:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjIQLBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 07:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbjIQLAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 07:00:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0540131
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 04:00:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E9B4C433CA;
        Sun, 17 Sep 2023 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694948427;
        bh=HfgC7d0FtOAdp+ZuPQmgKrOhrTPbwfYccJFb28cgpAc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qX8NbPx0u2dZioS4UIcY8/Rr6tVG+8VLMiIWEER8AF//hrtpeZZelFhOQRoyHuMWq
         K1U1K8k2Jlq1nssaglZPgLp19yDNeIc3cyBE0c6GG0/npKzJmK58NE+b+bgbNLuE4R
         7r3kptVPAnrjnwu/+AvA+kakPGMAQFai29ch3K3Xeph8+0uS+uzY6r/A2mpbZkp6nS
         NlzcS8OkXbMP68zzsfaNlfZ44Iz7ZY6LJ3mjRbT4HMssq3n9fD3Uh5PB05uvUCvcSv
         Rdf7hW/cpeVXGKL6ZDz8+tqU85kTeOJGs5pJkzpqM/VwFe7Wi4Y2px36VBFAUUQg0y
         SIgJeVIydtVkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64C2FE26880;
        Sun, 17 Sep 2023 11:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: microchip: lan743x: add fixed phy unregister
 support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169494842740.21621.7514600997922629086.git-patchwork-notify@kernel.org>
Date:   Sun, 17 Sep 2023 11:00:27 +0000
References: <20230914061737.3147-1-Pavithra.Sathyanarayanan@microchip.com>
In-Reply-To: <20230914061737.3147-1-Pavithra.Sathyanarayanan@microchip.com>
To:     Pavithra Sathyanarayanan <Pavithra.Sathyanarayanan@microchip.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Sep 2023 11:47:37 +0530 you wrote:
> When operating in fixed phy mode and if there is repeated open/close
> phy test cases, everytime the fixed phy is registered as a new phy
> which leads to overrun after 32 iterations. It is solved by adding
> fixed_phy_unregister() in the phy_close path.
> 
> In phy_close path, netdev->phydev cannot be used directly in
> fixed_phy_unregister() due to two reasons,
>     - netdev->phydev is set to NULL in phy_disconnect()
>     - fixed_phy_unregister() can be called only after phy_disconnect()
> So saving the netdev->phydev in local variable 'phydev' and
> passing it to phy_disconnect().
> 
> [...]

Here is the summary with links:
  - [net-next,v1] net: microchip: lan743x: add fixed phy unregister support
    https://git.kernel.org/netdev/net-next/c/1e73cfe85952

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


