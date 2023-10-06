Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B224F7BB019
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 03:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjJFBkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 21:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjJFBk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 21:40:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99C1E7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 18:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 451A8C43391;
        Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696556426;
        bh=gqyrDN2+dTZupXeCUnU9mVObbWUJ6MuZQ0yvTbbWN1g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PkSCdCCSfYON8+xP7t8vbyzAu/msl77TOxUy2VyBRWtnH+rq5MmSlaPF4AjqaFan5
         /bywZ4gFU0vgG3m9W5bwRHeZUBKJakMK6y1c89VYup75XaGNjCMXOYO3qlLWDV6uO5
         lTut7jfV31ztuiB8pFwX/WaqsUOkOU8Yr/lS+437D3aUuWvzSfT4+lLYwHcH1TzV0N
         f50kS8Q1RKyUIQPe0CVsSkzKA2U+nWcJ/tbx/eoWjexefWPPRrU3wQKz92gCuOoswb
         l0H6PuMOvrdCDHPYCXK2iX6ph1sLS0VmcLQgdokiAbB678NgyXunWuWtU5MaB/xopI
         B+sEmX2pAvGSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 272D2E11F51;
        Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nexthop: Annotate struct nh_notifier_res_table_info with
 __counted_by
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169655642615.20160.16106927648180643616.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 01:40:26 +0000
References: <20231003231818.work.883-kees@kernel.org>
In-Reply-To: <20231003231818.work.883-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, netdev@vger.kernel.org,
        llvm@lists.linux.dev, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Tue,  3 Oct 2023 16:18:18 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct
> nh_notifier_res_table_info.
> 
> [...]

Here is the summary with links:
  - nexthop: Annotate struct nh_notifier_res_table_info with __counted_by
    https://git.kernel.org/netdev/net-next/c/3e584e32b19d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


