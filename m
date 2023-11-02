Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3A07DEC8B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjKBFve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKBFva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:51:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA5E127
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 22:51:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89DB6C433C9;
        Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698904287;
        bh=otk3JHaNJ+D+HB8hAd06wvZT1Zwr/Vn4DRdmpJcovI0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=musrrxnqeONh5ZBBqyt0WvqL78DnEfhrWm6jtAd80LNA8IcAdCHWMzX3+tgFhaisG
         f17Dzz+SF03vW8haOhP8ONoexrv9yCHC7RrrLBfAQeW2AuopO6liwJ2j4B2uMhoy0q
         me8F/XjwZEAQL2f1OdyO4lEiolv+CAvJSb7m61qCLbsUlP56PCTKrk6ik2/3VVtBX9
         VWAp51GL8++UerjpWlOUms8w3x068ieNzKWYUzfzCkUahQOnM+QKH4jaMWR2h+PJgt
         jRTWZ/OCl9+5d5ld1JtrQCesN/Z8xSGF8o0YkHLRgfsHqyDA9JoJyGA5hMHxAlHKzC
         p/M+5qwyYEvhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D415EAB08B;
        Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rxrpc: Fix two connection reaping bugs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169890428744.30377.644414047950616687.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Nov 2023 05:51:27 +0000
References: <783911.1698364174@warthog.procyon.org.uk>
In-Reply-To: <783911.1698364174@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, marc.dionne@auristor.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Oct 2023 00:49:34 +0100 you wrote:
> Fix two connection reaping bugs:
> 
>  (1) rxrpc_connection_expiry is in units of seconds, so
>      rxrpc_disconnect_call() needs to multiply it by HZ when adding it to
>      jiffies.
> 
>  (2) rxrpc_client_conn_reap_timeout() should set RXRPC_CLIENT_REAP_TIMER if
>      local->kill_all_client_conns is clear, not if it is set (in which case
>      we don't need the timer).  Without this, old client connections don't
>      get cleaned up until the local endpoint is cleaned up.
> 
> [...]

Here is the summary with links:
  - [net] rxrpc: Fix two connection reaping bugs
    https://git.kernel.org/netdev/net/c/61e4a8660002

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


