Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D46805BD3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbjLEOuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345682AbjLEOuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:50:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BC8D44
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:50:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8307C433C9;
        Tue,  5 Dec 2023 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701787824;
        bh=VVDxm6oONgHLGn7mC1aQKyK5BXNMwRgtPv7JaM0VSz0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AoullTc7wYmOj+z89p8n0TSMtTON/N0kpU2uWqpHCt1yfKp5bmDC2eMfmxm4+6/7s
         t2FLdJB8OA0QXpOtDyE8uIZ8W5JCm0lYu5vpV7zEnPU5v+adVpyhiN93HgEfqELZpX
         XaXrRv8dTRskCF4fcrF/f5yFIUoB4OCrE6PmZXQb8ZYyYeQnom3/wNP8cOCy/wVRGO
         ioiCGdz3PVxp1OIKcddv5bTb6uT794nauXoNnR26ZHKeDKvhKOAdQ1fQX86RaoToMF
         fRhz901CRC5ONq0jVvyPyH0lZpRkzm3C6SyPkN0gXE/xanDbHx1OGPNs9G+CgfsMkq
         i07Jq/WZyoQoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B6B5C43170;
        Tue,  5 Dec 2023 14:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] octeontx2-af: fix a use-after-free in
 rvu_npa_register_reporters
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170178782463.5866.15530520826379861519.git-patchwork-notify@kernel.org>
Date:   Tue, 05 Dec 2023 14:50:24 +0000
References: <20231202095902.3264863-1-alexious@zju.edu.cn>
In-Reply-To: <20231202095902.3264863-1-alexious@zju.edu.cn>
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
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  2 Dec 2023 17:59:02 +0800 you wrote:
> The rvu_dl will be freed in rvu_npa_health_reporters_destroy(rvu_dl)
> after the create_workqueue fails, and after that free, the rvu_dl will
> be translate back through rvu_npa_health_reporters_create,
> rvu_health_reporters_create, and rvu_register_dl. Finally it goes to the
> err_dl_health label, being freed again in
> rvu_health_reporters_destroy(rvu) by rvu_npa_health_reporters_destroy.
> In the second calls of rvu_npa_health_reporters_destroy, however,
> it uses rvu_dl->rvu_npa_health_reporter, which is already freed at
> the end of rvu_npa_health_reporters_destroy in the first call.
> 
> [...]

Here is the summary with links:
  - octeontx2-af: fix a use-after-free in rvu_npa_register_reporters
    https://git.kernel.org/netdev/net/c/3c91c909f13f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


