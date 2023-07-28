Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9980A767770
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 23:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjG1VKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 17:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjG1VKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D1C449C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 14:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 924C26220A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 21:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAE2EC433C9;
        Fri, 28 Jul 2023 21:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690578622;
        bh=WvnojnhByd5MPjscaGN7NHKXbrcQE2TCxRtsyx4JNR0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZZk/LApQug7PbtqOE8zuYyu6A+5a9/WhinnCPxMy3fSekbFKYaTXU2+1EKsetn1S+
         O6bVIqvdTjxKiepcrr/a5ZW90yH26W8nZdeogTzRf0UEHB6C/rwIzRRYBFt1GuSJN3
         xr4PZcGp++BNSLqaN8XwpSG/2rGWdNOdLKZ4egV/zhUjwTTOmFqr4sspSFLi07rcBF
         W2uEaWEj41hMY/rbjw8qlTk5gb80b/EofZxLKzCPRqmk81M4SZG7sYcEJWz2sGMTrq
         LA5wwAoGeXa/RMzPNouolJU6L5nj+u2LF1aaFgeUDHOjCBgJHAO5OyGbr+jXLXiygc
         fyk8aXcV8ubtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD103C64459;
        Fri, 28 Jul 2023 21:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-af: Initialize 'cntr_val' to fix
 uninitialized symbol error
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169057862183.4237.8725721177562844360.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Jul 2023 21:10:21 +0000
References: <20230727163101.2793453-1-sumang@marvell.com>
In-Reply-To: <20230727163101.2793453-1-sumang@marvell.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com, dan.carpenter@linaro.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jul 2023 22:01:01 +0530 you wrote:
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c:860
> otx2_tc_update_mcam_table_del_req()
> error: uninitialized symbol 'cntr_val'.
> 
> Fixes: ec87f05402f5 ("octeontx2-af: Install TC filter rules in hardware based on priority")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: Initialize 'cntr_val' to fix uninitialized symbol error
    https://git.kernel.org/netdev/net-next/c/222a6c42e9ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


