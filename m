Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2137E70C5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344863AbjKIRue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbjKIRuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:50:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1681BFD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:50:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B508C433C7;
        Thu,  9 Nov 2023 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699552230;
        bh=NC2wQNcDNMRuGv9g3+/8bxt26yBhotbPBQ9TPyur8Io=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fXl1HJSTyAdNusFocUwf48YPEjKuv8vRm9YMPQIXaIoIWAoKmIy1wvVVtFS+ycZko
         z08nO6cxn9XrUQmMfVtGSx6G7oPrdzaKoJc7lbzjbzXkPN6/sDdUi09XCJFTG9hYuY
         wlXRypddOjgIhSYk+ArKvQ+SSKQPzBIPdhQR+MVjIxFn3GwuuJNWWLpiXSX+Wvaz+z
         vVIuxDRbGIPQ+Lx6oifYUKSySr/BgdnzLelrnzK5J4/piupOkogqWyf+USUyBy8p8t
         2Haryc2T7CD6pU5KchTK888SYjBsg1+JB3c63zMTbDidWpb6y2Hx9+wonpD51ULaP+
         Br1NjCEZ2Ot8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39B33C43158;
        Thu,  9 Nov 2023 17:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 02/41] rxrpc: Fix two connection reaping bugs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169955223023.20616.10876118854212671303.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Nov 2023 17:50:30 +0000
References: <20231109154004.3317227-3-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-3-dhowells@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Nov 2023 15:39:25 +0000 you wrote:
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
  - [02/41] rxrpc: Fix two connection reaping bugs
    https://git.kernel.org/bpf/bpf/c/61e4a8660002

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


