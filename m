Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FE9768074
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 18:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjG2QAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 12:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjG2QAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 12:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8170A30F4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 09:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E06DB60C79
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 16:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 347EDC433C9;
        Sat, 29 Jul 2023 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690646421;
        bh=L1NQaBN+VyMNym9qDiXL5U+SwrPEVXH+Ivar4V5k/QQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XWJcQzEJCmJeqQ2Z8O15bz9ACHFZ/Xy6p+VMhJCqs6QjtPQLH1sBAtktuqGFUTJDD
         8mZNEh4QWoNlnvHEvXniKZLQ6U2KTUVurCEBhYtscXJpUozcUY0rVrWOCN5F/JGCLg
         1X5i+GI7M/nieXNdBYDPVIGl+oWP7TsJxbqBOE/1qO9GHqCgJiuxvEXhdrPr8XoilJ
         vCH74Lrzos/Mx2ALTmw6WDoTvd+ig+/NlYIPN3HNCiE0LENBSLxCYWW+oxjSBicSmL
         q8nZ28ZbLQVSr7cz+2z4bghIJxqzSR1EinOwf/tl3LttGY0Au2NJC/PYZZXWVnwTRa
         COy09ZwRHfVLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13C45E21EC9;
        Sat, 29 Jul 2023 16:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] team: Remove NULL check before dev_{put, hold}
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169064642107.17949.4854420257500712245.git-patchwork-notify@kernel.org>
Date:   Sat, 29 Jul 2023 16:00:21 +0000
References: <20230727005741.114069-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230727005741.114069-1-yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, abaci@linux.alibaba.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 27 Jul 2023 08:57:41 +0800 you wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL,
> so there is no need to check before using dev_{put, hold},
> remove it to silence the warning:
> 
> ./drivers/net/team/team.c:2325:3-10: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5991
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - [net-next] team: Remove NULL check before dev_{put, hold}
    https://git.kernel.org/netdev/net-next/c/64a37272fa5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


