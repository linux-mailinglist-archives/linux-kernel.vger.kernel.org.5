Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD177BB489
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjJFJuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjJFJua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:50:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29684AD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:50:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4712C433CA;
        Fri,  6 Oct 2023 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696585828;
        bh=mNdE47cVR0cIm8x+mu7MjDgzyED6ympkgUgeB0iaGbQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DjIy7aAJSevjkK+a55ElHoUtPshXK0V5+gi+lsj1Da54fzbOPcloEZ4iQgRyTLaVs
         LsWx4CMv9PwJqlyZLY1NikS2vqwJm+KxYxehRiB9kF7CzdS//b0WSImWSpupIdBsWB
         odBUI4WS5I4tdDkeP64FB6tMGxJdDTTyol20JS+tOV0wg0gmLcQ+ftcME2eA3dvmVv
         kQkhYg2spRCLtQIHUna9DFM4ui4lw6kbpqvc0SAiX3C1a3H6xE8pnJivj5g6McEfR8
         L4ueUEzAgzl0qa76+Y2pHQxEgRSjOqRsGynCg6oe/Fd7Ndv/+LGOW9H+Nzc+kYaTzX
         oYRx6a4HLiXDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 966F8E632D2;
        Fri,  6 Oct 2023 09:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netlink: Annotate struct netlink_policy_dump_state with
 __counted_by
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169658582861.14501.9894166775052495116.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 09:50:28 +0000
References: <20231003232102.work.430-kees@kernel.org>
In-Reply-To: <20231003232102.work.430-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, johannes.berg@intel.com, netdev@vger.kernel.org,
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

On Tue,  3 Oct 2023 16:21:02 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct netlink_policy_dump_state.
> 
> [...]

Here is the summary with links:
  - netlink: Annotate struct netlink_policy_dump_state with __counted_by
    https://git.kernel.org/netdev/net-next/c/eaede99c3aeb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


