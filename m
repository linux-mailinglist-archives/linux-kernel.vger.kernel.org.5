Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68B980BC94
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 19:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjLJSuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 13:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjLJSuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 13:50:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EBADF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 10:50:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45CEDC433CA;
        Sun, 10 Dec 2023 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702234223;
        bh=a1wA9coOsT/SBm8i1cThGo7S6qPTNMtxqJh6eFfgyFg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bTJZ1eUmcLWi/SF5zHGsMPMTNhTjoifDA2WmgHrz1PAPesd/Z9IWK8iHmhcKjt2Hg
         WRImtJMeUmPvV6bJfqq+Ac1jcvhTjoSy6y9eI5K+ic1hadSAW6JWuyEBVb+uy0nojF
         ba6O2Z3zKZmN76cTlzmg/xUCI6s9vrc0x3+TnoFP6zQe2zPAkwlAXAuzPG8wlwZgLD
         qtoEKKkCIMiz4U24b6qbHlKdP87f0e2JDHSLlV4GwCxXEsP3zesvoVfkFYOJcirMEI
         TBmXP/t7gqfk1HyPJQipH8spsKkyVha3Syl1vr6/2JCNHqDrK/zaNh6Ew4JkfgdF1+
         +aKHwAVOmEa5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F0DCC595D2;
        Sun, 10 Dec 2023 18:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] octeontx2-af: fix a use-after-free in
 rvu_nix_register_reporters
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170223422318.23610.16553324017708743625.git-patchwork-notify@kernel.org>
Date:   Sun, 10 Dec 2023 18:50:23 +0000
References: <20231207094917.3338582-1-alexious@zju.edu.cn>
In-Reply-To: <20231207094917.3338582-1-alexious@zju.edu.cn>
To:     Zhipeng Lu <alexious@zju.edu.cn>
Cc:     sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, george.cherian@marvell.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Thu,  7 Dec 2023 17:49:16 +0800 you wrote:
> The rvu_dl will be freed in rvu_nix_health_reporters_destroy(rvu_dl)
> after the create_workqueue fails, and after that free, the rvu_dl will
> be translate back through the following call chain:
> 
> rvu_nix_health_reporters_destroy
>   |-> rvu_nix_health_reporters_create
>        |-> rvu_health_reporters_create
>              |-> rvu_register_dl (label err_dl_health)
> 
> [...]

Here is the summary with links:
  - octeontx2-af: fix a use-after-free in rvu_nix_register_reporters
    https://git.kernel.org/netdev/net/c/28a7cb045ab7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


