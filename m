Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC557534CD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjGNINL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjGNIMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:12:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143824EDE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0406561C7A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C159C433CB;
        Fri, 14 Jul 2023 08:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689322221;
        bh=Jx2+15zQhjpNk6e3HbcwaX9VEt65C3lrUYRs2gzXBMI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q2FTq4WjgudshYJ4MfGx3OtginjBf0WZaoim3wGcsQGZmm33bCv2e/5AXzl5lSwW4
         3vvL+4Aw3Qv4wIPLJjBFbh/YPc3KqeA/Z4gybUeM15ty3SJAoHEbcInaQNv2wbFjqs
         GSv0uiqBHFgdGMI2x0e2SSDHaeI/o+HIs1SElXXqoycGCKkbAIcp6/0IoCD9VdX3FA
         kllJvrwUOJAVr6493tNaxucnqBpIVjEpkCJ98LcEsAfuXedPmLp0P6qCcl27OB7tAI
         wp09pqSYZbtmIksCw35J1lk5YH6qJ9dqR0fYaDZAyLZK+r2YD1ouASuGKIMa57ZPDZ
         2RY4lEnjonZIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 438FCE49BBF;
        Fri, 14 Jul 2023 08:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bna: Remove error checking for debugfs_create_dir()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168932222127.28600.2169782274077317127.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Jul 2023 08:10:21 +0000
References: <20230713095118.4807-1-machel@vivo.com>
In-Reply-To: <20230713095118.4807-1-machel@vivo.com>
To:     =?utf-8?b?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqCA8bWFjaGVsQHZpdm8uY29tPg==?=@ci.codeaurora.org
Cc:     rmody@marvell.com, skalluru@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com, rdunlap@infradead.org
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 17:51:06 +0800 you wrote:
> It is expected that most callers should _ignore_ the errors return by
> debugfs_create_dir() in bnad_debugfs_init().
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 5 -----
>  1 file changed, 5 deletions(-)

Here is the summary with links:
  - [net,v2] bna: Remove error checking for debugfs_create_dir()
    https://git.kernel.org/netdev/net/c/4ad23d2368cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


