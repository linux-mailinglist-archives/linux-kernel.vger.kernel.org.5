Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252147BB57C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjJFKkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjJFKkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:40:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0D9F4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:40:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ECCDC43391;
        Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696588824;
        bh=KzIZOnElrqYjlyNCRhXZ/6dGkAdW/0c9GqOyBEpsNSY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MV/KwomlYP3ethv7qRyi1HhKSpMRJQaqjQIimlbvulYa2t67ba9M1V8xuxMDFEQK+
         EUGMCd3/3Crxija3JP/m6nR38DDF4vlcJQPIGm+8wuZb6SsbERYTKjo/DLa0brCfEa
         xVPPzkd51dBirKbzrjrLZw66w2FQSrDUCwi3k7WOqZh+R5aLcvjI8Tbd9IZlU6MTTK
         vpf3a4Rnasccgdlhb9HqiJcNArs10qxyCSnD/ZJqcct0BvAmkiCnrHzjvES95Do088
         5NrycW+SLm5h6E4eI9F9Ouj7EnYkDG+BS1yxkf/S4ixWFRmVCNxAOtZILbJH7/2RfF
         2Dct7quwMbVSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69844C595CB;
        Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] flow_offload: Annotate struct flow_action_entry with
 __counted_by
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169658882442.10984.13385053977600897940.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 10:40:24 +0000
References: <20231003231833.work.027-kees@kernel.org>
In-Reply-To: <20231003231833.work.027-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, gustavoars@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
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

On Tue,  3 Oct 2023 16:18:33 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct flow_action_entry.
> 
> [...]

Here is the summary with links:
  - flow_offload: Annotate struct flow_action_entry with __counted_by
    https://git.kernel.org/netdev/net-next/c/99474727d5d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


