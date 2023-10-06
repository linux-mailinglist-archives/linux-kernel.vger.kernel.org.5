Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FD37BB4A5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjJFKAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjJFKA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:00:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E95B9F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:00:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE053C433C9;
        Fri,  6 Oct 2023 10:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696586426;
        bh=Lv3Klna2FTPeB1l0WLzXoU1kCYsAsFAU4Irfc+zJ3yc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BRhmwgmYih5xopqLETDSS3Keu9xlfYM+GQ6LakR7JP8Pf6pSbjZ+i+Ewazp6IEsDp
         rtOI6u8U1efgdBJ6AsiaqtdIZwwTWqP8lMId4oWHGLLL9AJ8O6W49/SfxAMYJZmetI
         Jf27Fl43QL7+q0lHyaRmzvdq+kkFOX4MtjpqoYNGd1/ba9wVJjSVcWXuL60G6v9bWJ
         9PW19QMJ192/xt/a10jgkyQuZnJqzOJvHVdEMfmELL8MSs6qZgTKS8zkq6208sn+tk
         A6jEfMSqywh3dMUMSE5gXFra5z5fnIhB/lHMHTAt6r8IJ3WVxYQp7dgzrZfKpCf0PP
         9uFsaIhg7XQ3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EBBFC595CB;
        Fri,  6 Oct 2023 10:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nexthop: Annotate struct nh_group with __counted_by
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169658642664.19666.16771125566763338647.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 10:00:26 +0000
References: <20231004014445.work.587-kees@kernel.org>
In-Reply-To: <20231004014445.work.587-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        gustavoars@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  3 Oct 2023 18:44:49 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nh_group.
> 
> [...]

Here is the summary with links:
  - nexthop: Annotate struct nh_group with __counted_by
    https://git.kernel.org/netdev/net-next/c/2a92fccdaca8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


