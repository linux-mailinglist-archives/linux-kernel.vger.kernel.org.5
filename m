Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D177BF118
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441945AbjJJCub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441879AbjJJCu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:50:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4347CA4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:50:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97F6EC43391;
        Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696906225;
        bh=RWfYfisSlrkC3q8bAo6ZXhtYCjJgOwu0iOjtsmTdS/s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rIv4pLhWWKx7g+2URb+EL2iSSJCXxA+wWgL0JIVVGuX2OMWT/zXUvKqhzzFqy5P90
         CXGb5VmS/iN++hCFmYG0tPzjn36z6Dn8HPGg/YkW0XX+cx1ngiwIJu8eQwJOu4LAsh
         PzmQfRMHhkd5woxjUD1NiI9O3S8KOUt7uyreukqWa/RIMheIoizXEhMdukR08q3528
         hquIOzCk8EXcU5HKtAEtYyrgzrmxYXdRDS+FM03Op1HXT38JbVN3vwZYPf7Clo+t0/
         Fc9xe5i9b43iickzw83boVQJkfjqKwJosOfIozzRQwIuVnkr1pnrqRrq1pWyEI10Nb
         N6T3msFnMcsIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B27AE11F48;
        Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bcm63xx_enet: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169690622543.548.4787561962344231209.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Oct 2023 02:50:25 +0000
References: <20231005-strncpy-drivers-net-ethernet-broadcom-bcm63xx_enet-c-v1-1-6823b3c3c443@google.com>
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-broadcom-bcm63xx_enet-c-v1-1-6823b3c3c443@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
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

On Thu, 05 Oct 2023 20:51:40 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is strscpy() [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> [...]

Here is the summary with links:
  - bcm63xx_enet: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/0aba524728f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


