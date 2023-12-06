Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D87806A91
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjLFJUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjLFJUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:20:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A22D4F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:20:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A462C433CA;
        Wed,  6 Dec 2023 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701854423;
        bh=gzlkjQfmWVccL59AU12EX6SfF/xftROkPP8PH4cN+PI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HNzRf8zyr/bAruseOy/c2Y+QmKrrhtvd6EeOl8sBcU8AhMrnry3t7mBlAATr62dt3
         PejvIbnrTO4iGflCijrPcwMJitNJQznVjNmaU23IJ4TMJ/ZBBTXc6agRf2gKIODyIN
         rjfiDN+srUGKOlid+4vfsEBl8mU/EaHl4MBodUa0QVfm+hOsVInSVanBY2JJZvDP4E
         dFUy2XeKH0jix5cRImZch1OrgdaGlulxU4k+FdCVg87ns02Mmo5BBBEv/SpTB6365c
         F2bH45ZxwiYrXKmFULnpuqyFpviyy/Ull/y63kM3OpeqyeVgOUNS9RXWojg2zX3ZOM
         UaM1zQByhxj6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E562AC395DC;
        Wed,  6 Dec 2023 09:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170185442293.26512.8602654945960747871.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Dec 2023 09:20:22 +0000
References: <20231202161441.221135-1-syoshida@redhat.com>
In-Reply-To: <20231202161441.221135-1-syoshida@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  3 Dec 2023 01:14:41 +0900 you wrote:
> In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() returns
> true. For example, applications can use PF_PACKET to create a malformed
> packet with no IP header. This type of packet causes a problem such as
> uninit-value access.
> 
> This patch ensures that skb_pull() can pull the required size by checking
> the skb with pskb_network_may_pull() before skb_pull().
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()
    https://git.kernel.org/netdev/net/c/80d875cfc9d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


