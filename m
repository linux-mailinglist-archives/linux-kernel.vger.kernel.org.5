Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DC77EEB48
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 04:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345651AbjKQDA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 22:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQDA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 22:00:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ABC1AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 19:00:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2638C433C9;
        Fri, 17 Nov 2023 03:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700190023;
        bh=GMFEh6GoMGIDGmPKoeCx161zAh4UulGGvZfaLHv+L2c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=symgOHiCuBfaQKZEuP9DlVtGX8ULTJHV7hJLB+29BIl1+SRgEZor0W9xhD4CkgfwP
         E+L3/AQCSH8jLo3hOvzpD6QxWthw/96qC9l1KHTcwdAYJ0ipC6BUT6kqMrxtIoWntJ
         kmHzqWbanoXrIcHl8uICiyn7T3/cDcBqgU8S6lrSzaU3R6bdwklYZExyWyraMpprhh
         lLrJP3et7wU67qKE2VT8tdlBfvIf7u9fNDVcVfVOiy2jwJcaHcu7YxjgePalwBHeM4
         pi852Hl6g6ujrJd6AOmD0Mmn/8Nf4RMuuye8mHy+D/JfurrdBOaV+USgV/cJUhvluS
         YqqNKKQU9b70A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83D9EE1F65A;
        Fri, 17 Nov 2023 03:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] rxrpc: ACK handling fixes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170019002353.1895.8952802465707802348.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Nov 2023 03:00:23 +0000
References: <20231116131259.103513-1-dhowells@redhat.com>
In-Reply-To: <20231116131259.103513-1-dhowells@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, marc.dionne@auristor.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 16 Nov 2023 13:12:57 +0000 you wrote:
> Here are a couple of patches to fix ACK handling in AF_RXRPC:
> 
>  (1) Allow RTT determination to use an ACK of any type as the response from
>      which to calculate RTT, provided ack.serial matches the serial number
>      of the outgoing packet.
> 
>  (2) Defer the response to a PING ACK packet (or any ACK with the
>      REQUEST_ACK flag set) until after we've parsed the packet so that we
>      carry up to date information if the Tx or Rx rings are advanced.
> 
> [...]

Here is the summary with links:
  - [net,1/2] rxrpc: Fix RTT determination to use any ACK as a source
    https://git.kernel.org/netdev/net/c/3798680f2fbb
  - [net,2/2] rxrpc: Defer the response to a PING ACK until we've parsed it
    https://git.kernel.org/netdev/net/c/1a01319feef7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


