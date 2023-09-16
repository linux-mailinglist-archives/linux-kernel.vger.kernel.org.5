Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C428D7A3047
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbjIPMnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239265AbjIPMmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:42:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEAA2D42
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 05:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37407C433C7;
        Sat, 16 Sep 2023 12:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694868025;
        bh=Fd4tUJbFTpDAZubkZ/meNJh/ivkIu+elL/akclFttKE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bSs26kuHIQD1AojR3LIImDlyvHQGR/YZXkCchaxihMuN66hFkEKA4qNvzPyAN+oGX
         bi7n6xGwk+rGAV0XTnLUtaZ9NTrlPPBmgekFzvetXzphqYcakuwLuS8fqTXVq+JZdK
         ozyKgcdk24di0JSvEPB2qCSbqCCroAZ5Z/uYBk9ZVfgtqxMKdifYQNX9UwrIVxwdNc
         +HqPG6xrRj9nFCbiTyxwJ06noBUpNiauUDkhZNV2vCtMbgx+4rv+rV3C/Rr7hlBo9P
         7ilL1OECKFwfqjJrlWE+uP0jf7Tknp3E2yUtqEIjl5fL1Kq9qBSEYTqIQEevFbMxDY
         KnXfIpb3DPWkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D355E26887;
        Sat, 16 Sep 2023 12:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] net: core: Use the bitmap API to allocate bitmaps
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169486802511.24089.3642450792901329099.git-patchwork-notify@kernel.org>
Date:   Sat, 16 Sep 2023 12:40:25 +0000
References: <20230913110957.485237-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230913110957.485237-1-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ryazanov.s.a@gmail.com, horms@kernel.org
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

On Wed, 13 Sep 2023 14:09:57 +0300 you wrote:
> Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
> It is less verbose and it improves the type checking and semantic.
> 
> While at it, add missing header inclusion (should be bitops.h,
> but with the above change it becomes bitmap.h).
> 
> Suggested-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Link: https://lore.kernel.org/r/20230911154534.4174265-1-andriy.shevchenko@linux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/1] net: core: Use the bitmap API to allocate bitmaps
    https://git.kernel.org/netdev/net/c/aabb4af9bb29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


