Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBDA7A48C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241355AbjIRLvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjIRLub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:50:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B53E3;
        Mon, 18 Sep 2023 04:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B14C7C433C7;
        Mon, 18 Sep 2023 11:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695037824;
        bh=lLmkRmQrVDMuWLiRnc6WZi6wkS4qkGabF5MldHO9ynE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XMsUM/6PTgmQgGOOp+k7DuQuDMgisWtNdzkwmPbc9znYTejBeA+hsBwQw3bKOTREQ
         gw/88uAwnjD/eBg5/DaeyqOfGKRvuutbX4nMRIL3elp/RoyhlzIPMeRFx+BTfIVpEA
         lGC7Y/mu+YyXSR3UY7IJF2t3xHwj26jtDMSa2kNablJvBh402XtE76bGbdXeYxTvky
         WcSEacr2gCfOqDXYr6jwORaRCG2EFYBzeqyvdsgPUVWpYbJ7YDaxEEWDGgo88Xtpc0
         xT2b6SQzQyW5I0JAzykFpg8Ml9NRGr2tfwZkXFgUgZQpXdgf6wuy7SqgKWd7eQg0Po
         KWftbkmHd8jCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 909DFE11F41;
        Mon, 18 Sep 2023 11:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mptcp: fix stalled connections
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169503782458.2272.14155670573882201410.git-patchwork-notify@kernel.org>
Date:   Mon, 18 Sep 2023 11:50:24 +0000
References: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-0-05d1a8b851a8@tessares.net>
In-Reply-To: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-0-05d1a8b851a8@tessares.net>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        dcaratti@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 16 Sep 2023 12:52:44 +0200 you wrote:
> Daire reported a few issues with MPTCP where some connections were
> stalled in different states. Paolo did a great job fixing them.
> 
> Patch 1 fixes bogus receive window shrinkage with multiple subflows. Due
> to a race condition and unlucky circumstances, that may lead to
> TCP-level window shrinkage, and the connection being stalled on the
> sender end.
> 
> [...]

Here is the summary with links:
  - [net,1/5] mptcp: fix bogus receive window shrinkage with multiple subflows
    https://git.kernel.org/netdev/net/c/6bec041147a2
  - [net,2/5] mptcp: move __mptcp_error_report in protocol.c
    https://git.kernel.org/netdev/net/c/d5fbeff1ab81
  - [net,3/5] mptcp: process pending subflow error on close
    https://git.kernel.org/netdev/net/c/9f1a98813b4b
  - [net,4/5] mptcp: rename timer related helper to less confusing names
    https://git.kernel.org/netdev/net/c/f6909dc1c1f4
  - [net,5/5] mptcp: fix dangling connection hang-up
    https://git.kernel.org/netdev/net/c/27e5ccc2d5a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


