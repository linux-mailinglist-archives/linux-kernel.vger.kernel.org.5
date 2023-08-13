Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF76677A633
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 13:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjHMLaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 07:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjHMLaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 07:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF63E10C1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 04:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18C90622F8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 11:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B5B7C433CC;
        Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691926222;
        bh=c8lR1VkckMUblxvfn52yXRWq2YtEfvbINH9lexG/jtM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TlFs6RIr1YH7Kt7j8EpYAwhRvfYfpiqX4Ae28Swle+ZWzvqeOs/8ZoSzgwFgk0XBE
         wd6CSOdk5tgpAgxnSqMtP7lfw7K1oAAldToW7+7YxZdgmF45T8zbaAgTjxGHg8KPbY
         7Hf8g6WDhVwoidXVFrgwNblnbotUoANz8rdRsH+vPBPBV4l+6zfJNxvR7hjLUS5A5n
         FcLyZ/7sPCF9a+Gq2zgrzRLWQU3QzJG6GVzr62fC09CKbmctwGrthMnmW6JEBoNunl
         x87YuA8pWstRBinhqf8vPMiQEvHaKuussp0YjLlt5z53V8pwkiGzC6D1HDzsv4VsEZ
         tH9PKDwSz+9MA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EC3DC595D0;
        Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/4] net: tcp: support probing OOM
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169192622231.28684.15945374352153132817.git-patchwork-notify@kernel.org>
Date:   Sun, 13 Aug 2023 11:30:22 +0000
References: <20230811025530.3510703-1-imagedong@tencent.com>
In-Reply-To: <20230811025530.3510703-1-imagedong@tencent.com>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        flyingpeng@tencent.com, imagedong@tencent.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 10:55:26 +0800 you wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> In this series, we make some small changes to make the tcp retransmission
> become zero-window probes if the receiver drops the skb because of memory
> pressure.
> 
> In the 1st patch, we reply a zero-window ACK if the skb is dropped
> because out of memory, instead of dropping the skb silently.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] net: tcp: send zero-window ACK when no memory
    https://git.kernel.org/netdev/net-next/c/e2142825c120
  - [net-next,v4,2/4] net: tcp: allow zero-window ACK update the window
    https://git.kernel.org/netdev/net-next/c/800a666141de
  - [net-next,v4,3/4] net: tcp: fix unexcepted socket die when snd_wnd is 0
    https://git.kernel.org/netdev/net-next/c/e89688e3e978
  - [net-next,v4,4/4] net: tcp: refactor the dbg message in tcp_retransmit_timer()
    https://git.kernel.org/netdev/net-next/c/031c44b7527a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


