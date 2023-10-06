Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1557BB48A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjJFJuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJFJub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:50:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF51D6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:50:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7903C433CB;
        Fri,  6 Oct 2023 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696585828;
        bh=a2ENf7MUDBFrK1E4vnGaCFh7KLJbS+N/a85HAgbx1j0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rN2JonUTGn3aA/Tlln/U2jm/BQlVEjkuXw5TipzdjgF0zdbl69HeRxjaPkQYd7lTi
         j+cg+IRtCLyYlSR1D4YqqbL/ASRjWZVRK32oeVnFgdT94LAMii8q9otDkEmCEVwr/t
         ZvRgP4aNuNhYPYjnGV3JGyWAXThOZ0znK2XOuFsNfovIW4cwlJ9tDGRi8aKAcI2H+A
         JE9xRwr0gUAq3lKmaxGH0REgkY0GRL0ujSaHiTwWaWTPztZ6sdAc12New5jYi32v8a
         QOPu/4Wx6ehvbWnURVmjsrMsVnkZaRH8POaA9dxDYf2V/nHvVRk1cDOkdz++Jz39yY
         tHmhX1Pzq6mBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4A49E22AE4;
        Fri,  6 Oct 2023 09:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nexthop: Annotate struct nh_notifier_grp_info with
 __counted_by
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169658582866.14501.11680494229277915986.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 09:50:28 +0000
References: <20231003232146.work.248-kees@kernel.org>
In-Reply-To: <20231003232146.work.248-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, netdev@vger.kernel.org,
        llvm@lists.linux.dev, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Tue,  3 Oct 2023 16:21:47 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nh_notifier_grp_info.
> 
> [...]

Here is the summary with links:
  - nexthop: Annotate struct nh_notifier_grp_info with __counted_by
    https://git.kernel.org/netdev/net-next/c/cf9ecad97725

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


