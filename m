Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094087D22C2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjJVKu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJVKu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:50:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63BFA7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:50:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55F2FC433C7;
        Sun, 22 Oct 2023 10:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697971824;
        bh=cxTHUztlTRf4SoaTq4+zoo3w+yejxOKTRCQtcaLQAd4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=W9BlodBSyqQyc4djoovgqxV8r2UI8/YZNCGrGkvLpEOOknDhBIpR+ZyP6m+XmCZv8
         2dzPDu3q64DVf9205dOtdddAfzkvWVc0HS1eT/iu2gygBAY2vQw9IEYS6yKPP0VZby
         mz9tJfzXcWKwpgNEu26HIENwy/CG9WzcZL51yfji+YrkQ7Y2orQP4xxx275aj715k5
         p5Vz1sDfqkBtz1y8w6TwRm+rv3Bqb2Q9hBfoUZzgkh32eHPVanpUv2L8Ib0uhGji1j
         Tgtfoe6H+g319VhgKT6AY/fo9QBlxAoDU5nz7UnQt1/bx5Bm48s0OZstWFPbSpywfg
         s4RixUPU2O96g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BB43C691E1;
        Sun, 22 Oct 2023 10:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/8] r8152: Avoid writing garbage to the adapter's
 registers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169797182424.5465.9720701078350268924.git-patchwork-notify@kernel.org>
Date:   Sun, 22 Oct 2023 10:50:24 +0000
References: <20231020210751.3415723-1-dianders@chromium.org>
In-Reply-To: <20231020210751.3415723-1-dianders@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     kuba@kernel.org, hayeswang@realtek.com, davem@davemloft.net,
        ecgh@chromium.org, laura.nao@collabora.com,
        stern@rowland.harvard.edu, horms@kernel.org,
        linux-usb@vger.kernel.org, grundler@chromium.org, bjorn@mork.no,
        edumazet@google.com, pabeni@redhat.com, pmalani@chromium.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Oct 2023 14:06:51 -0700 you wrote:
> This series is the result of a cooperative debug effort between
> Realtek and the ChromeOS team. On ChromeOS, we've noticed that Realtek
> Ethernet adapters can sometimes get so wedged that even a reboot of
> the host can't get them to enumerate again, assuming that the adapter
> was on a powered hub and din't lose power when the host rebooted. This
> is sometimes seen in the ChromeOS automated testing lab. The only way
> to recover adapters in this state is to manually power cycle them.
> 
> [...]

Here is the summary with links:
  - [v5,1/8] r8152: Increase USB control msg timeout to 5000ms as per spec
    https://git.kernel.org/netdev/net/c/a5feba71ec9c
  - [v5,2/8] r8152: Run the unload routine if we have errors during probe
    https://git.kernel.org/netdev/net/c/5dd176895269
  - [v5,3/8] r8152: Cancel hw_phy_work if we have an error in probe
    https://git.kernel.org/netdev/net/c/bb8adff9123e
  - [v5,4/8] r8152: Release firmware if we have an error in probe
    https://git.kernel.org/netdev/net/c/b8d35024d405
  - [v5,5/8] r8152: Check for unplug in rtl_phy_patch_request()
    https://git.kernel.org/netdev/net/c/dc90ba37a8c3
  - [v5,6/8] r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()
    https://git.kernel.org/netdev/net/c/bc65cc42af73
  - [v5,7/8] r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
    https://git.kernel.org/netdev/net/c/715f67f33af4
  - [v5,8/8] r8152: Block future register access if register access fails
    https://git.kernel.org/netdev/net/c/d9962b0d4202

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


