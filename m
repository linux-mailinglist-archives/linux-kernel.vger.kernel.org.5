Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F147D2BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjJWHue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjJWHu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:50:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1334D7F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:50:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42650C433C9;
        Mon, 23 Oct 2023 07:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698047424;
        bh=dHi+keDEb+GtKsSiQKQEa36ciu9EEvDxbZpAlC4iFQI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EweMUBYusow8uVHPK8cbs7pIJBrObqBxRiMxAfOHGEVa963x/y3alApJc7zXr6Yfo
         ZgG9ei8V7gVPnJeFhnQSz9DKa9Rd84Ca/Amr2PY9Dk/BLyzc6k953hxANTZvbf8MMW
         BfueLEyrNjyAftIcawFrAnag47EP1u4dekmMfZUaNmLg3N9FkK7O5gtonQcbZ+Ktn7
         yE4TKAHCbyInf7Wz3rzufrjEHltIVv8F7JVYzNV23zZ7uPQYwDmjkCpZu4Z83s8etJ
         vZMcNljffx1gLwl5+u1jk9cFMmcDwukoYM9oeBtjht85i6L+fTZUoEQH27XX6Zzbwt
         xlWu9nBnP1zqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29641C41620;
        Mon, 23 Oct 2023 07:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: consolidate IPv6 route lookup for UDP
 tunnels
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169804742416.31388.8610752301166615591.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Oct 2023 07:50:24 +0000
References: <20231020115529.3344878-1-b.galvani@gmail.com>
In-Reply-To: <20231020115529.3344878-1-b.galvani@gmail.com>
To:     Beniamino Galvani <b.galvani@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
        gnault@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Oct 2023 13:55:24 +0200 you wrote:
> At the moment different UDP tunnels rely on different functions for
> IPv6 route lookup, and those functions all implement the same
> logic.
> 
> Extend the generic lookup function so that it is suitable for all UDP
> tunnel implementations, and then adapt bareudp, geneve and vxlan to
> use it.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] ipv6: rename and move ip6_dst_lookup_tunnel()
    https://git.kernel.org/netdev/net-next/c/fc47e86dbfb7
  - [net-next,2/5] ipv6: remove "proto" argument from udp_tunnel6_dst_lookup()
    https://git.kernel.org/netdev/net-next/c/7e937dcf96d0
  - [net-next,3/5] ipv6: add new arguments to udp_tunnel6_dst_lookup()
    https://git.kernel.org/netdev/net-next/c/946fcfdbc5b9
  - [net-next,4/5] geneve: use generic function for tunnel IPv6 route lookup
    https://git.kernel.org/netdev/net-next/c/69d72587c17b
  - [net-next,5/5] vxlan: use generic function for tunnel IPv6 route lookup
    https://git.kernel.org/netdev/net-next/c/2aceb896ee18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


