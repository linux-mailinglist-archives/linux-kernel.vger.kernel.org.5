Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E405175E17B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGWKuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGWKuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A4DE5A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 03:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0777F60C77
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 10:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6042AC433CA;
        Sun, 23 Jul 2023 10:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690109421;
        bh=drRpyC3r/p0fAndM5+ETZCPHEdellUZ5vHv+1tdmYZw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ermzWyoWjTPnoUOmt4FivlRI9poKXT7wH9w3U8mWugpB+1s2NtEeD+m3ObxPfWN0+
         3to1U0KID0F5A7XC6yiz9gGH3WgYTrBn3xV82Cu6QG8ugt2Kfc2w5/8NWvzV2uY2zS
         rbJ4F72Tc4zcEdriL8uQ6Vc9CQ1rSHB+HbyhNnN24YOrJ/jlWGVsTu/POJ5vpg6ibL
         LkfDLVTqLH+F3GdGwFB8GI7/ZRJV9/y3ntx7WCYr8sCHabA8VdAI0czozYQfQDmEGE
         st4bjqL2C3HzzlN6YUNNcYkpEyolaipSF9iiqPyM+8VAV2OzINp8AYkuxCR/a3rtBl
         nhl+jlkFs3ISw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E910C595C1;
        Sun, 23 Jul 2023 10:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: dsa: remove deprecated strncpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169010942124.21900.11686032822364375294.git-patchwork-notify@kernel.org>
Date:   Sun, 23 Jul 2023 10:50:21 +0000
References: <20230718-net-dsa-strncpy-v2-1-3210463a08be@google.com>
In-Reply-To: <20230718-net-dsa-strncpy-v2-1-3210463a08be@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        ndesaulniers@google.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 18 Jul 2023 22:56:38 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Even call sites utilizing length-bounded destination buffers should
> switch over to using `strtomem` or `strtomem_pad`. In this case,
> however, the compiler is unable to determine the size of the `data`
> buffer which renders `strtomem` unusable. Due to this, `strscpy`
> should be used.
> 
> [...]

Here is the summary with links:
  - [v2] net: dsa: remove deprecated strncpy
    https://git.kernel.org/netdev/net-next/c/5c9f7b04aadf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


