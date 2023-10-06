Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEAD7BB576
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjJFKkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjJFKk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:40:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F85F7
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0ACDC4339A;
        Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696588824;
        bh=ooqbsMBFcH+zEx1BRZm017INGG3vcLFft8fYXG2wzk8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PbHlSbv5lnpdBjnUnUrnYTjnmSbDCyTxW7Aj06g+rRrBCR96bjxML4ggfSutiYFg7
         MZ72Hld0zAW69rP2YplGHBQHmyamkYpKHNJGxYBYaavxwXoH0AsxHn9ZbxtVEpH9gb
         gEoAqxMaP4/vHh2gdChtEC+T5331Pwqiu9QNp2325FOapUxkgyWWfiBhIbN7rdhBDY
         hOTxFt4MwJIxH7lAESM+ZCTU3nW3neobok6ZuKDX8XqFhAgMJuxj8hdkSMSC+6jL4F
         e1pT0pHPZGjQJ0RQT6oe8sULk/31yCnCNYkYPdMWKUJcX2IdIh7xYs/1ZMKwEzlIOY
         SMmHWm5WFC+mA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 804DFE22AE3;
        Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/packet: Annotate struct packet_fanout with __counted_by
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169658882452.10984.9516643014205253723.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 10:40:24 +0000
References: <20231003231740.work.413-kees@kernel.org>
In-Reply-To: <20231003231740.work.413-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemb@google.com, amy.saq@antgroup.com,
        netdev@vger.kernel.org, gustavoars@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        syzkaller@googlegroups.com, henry.tjf@antgroup.com,
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

On Tue,  3 Oct 2023 16:17:41 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct packet_fanout.
> 
> [...]

Here is the summary with links:
  - net/packet: Annotate struct packet_fanout with __counted_by
    https://git.kernel.org/netdev/net-next/c/b3783e5efde4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


