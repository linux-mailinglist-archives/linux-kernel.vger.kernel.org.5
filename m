Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15DA7A1F68
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbjIONAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbjIONAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:00:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD8BA8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F928C433C8;
        Fri, 15 Sep 2023 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694782825;
        bh=FysBair8IqhMXuCVUmuDEL1dzWA//+ebiJFZz7oApy8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CYzXQa9EpfLLJKGAGaOyQWfBB31cLRNpul0aaZvAurcrs1floqku/ZmbwAu4dGxG9
         uVJbMWwuUVYuxOxVo9LirF8CuB4tiFNKb+cxVEJ13MjbjhOv1zw6eOXyK+g4I06z4O
         XxgHeUA5UcJ4IL+0QYSq+QAzm5jBJ9ddLEC5oXhJy/AwGm1BPOq6ohBjMMO7Hq731F
         lLeMgpLdo2tv18YLOhOxB44qHw0UuJgvZL/CzrQqmLq4oKz398JxnBVPoep5K+Bn82
         x+pNEeU9Ac0DxRWgvl9W+6kRVsOrREaPTFfyVBUA9eVD6yN7oB/nHoF+yY0RLH+jD8
         QFc5OXnrd7xaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46C1FE22AEE;
        Fri, 15 Sep 2023 13:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] octeon_ep: fix tx dma unmap len values in SG
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169478282528.10241.426302600668968163.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Sep 2023 13:00:25 +0000
References: <20230913084156.2147106-1-srasheed@marvell.com>
In-Reply-To: <20230913084156.2147106-1-srasheed@marvell.com>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     aayarekar@marvell.com, davem@davemloft.net, edumazet@google.com,
        egallen@redhat.com, hgani@marvell.com, horms@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com,
        netdev@vger.kernel.org, pabeni@redhat.com, sburla@marvell.com,
        sedara@marvell.com, vburru@marvell.com, vimleshk@marvell.com
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
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Sep 2023 01:41:56 -0700 you wrote:
> Lengths of SG pointers are kept in the following order in
> the SG entries in hardware.
>  63      48|47     32|31     16|15       0
>  -----------------------------------------
>  |  Len 0  |  Len 1  |  Len 2  |  Len 3  |
>  -----------------------------------------
>  |                Ptr 0                  |
> 
> [...]

Here is the summary with links:
  - [net,v2] octeon_ep: fix tx dma unmap len values in SG
    https://git.kernel.org/netdev/net/c/350db8a59eb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


