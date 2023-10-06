Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAB87BB01A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 03:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjJFBka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 21:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJFBk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 21:40:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCF5E4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 18:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 369FCC433D9;
        Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696556426;
        bh=Ybo4PA+YOfwHZpwG7F/ih3tq0pio/1SFsEdxpMf6r90=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=A4gy7FOOEFBLp+72P2HX9SBrrMGxjF3zHnLKAk/YUwO1+AZVdxXjIKo/XZqzDk0kF
         jNWAkSrVA/mA1dhI5kpJpQ52pgSvCdw0cGhXTJ4fA13UpAz2tyyyvGAWCX+ycoGO3l
         0YRA9XVKq7jnsxFXf2LBx9fvOdGwOyzPdCb6xwg67ajYR39LTU5H6+gg6g/tBFIkCK
         txD7meyQqCC0PqRd0rtu0xy+KhP+TIZ9hf+eJNuq7Pw5oJoD/Y3kg1QMt7CqQnxXzW
         AFIyXsU7C5Udh8UaRanl7M6dHjglHMDMeVEZTQvvFxATkSepM69JYb7VfgvFvlXskc
         iah+SLQCq89lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A346E11F52;
        Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nfp: Annotate struct nfp_reprs with __counted_by
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169655642610.20160.13967622151608370397.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 01:40:26 +0000
References: <20231003231843.work.811-kees@kernel.org>
In-Reply-To: <20231003231843.work.811-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     horms@kernel.org, simon.horman@corigine.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        oss-drivers@corigine.com, netdev@vger.kernel.org,
        louis.peens@corigine.com, gustavoars@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
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
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Oct 2023 16:18:43 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nfp_reprs.
> 
> [...]

Here is the summary with links:
  - nfp: Annotate struct nfp_reprs with __counted_by
    https://git.kernel.org/netdev/net-next/c/4514aa9f56fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


