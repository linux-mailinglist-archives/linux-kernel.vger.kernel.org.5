Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E9E7A36A7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 18:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbjIQQuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjIQQu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 12:50:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E646F11D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 09:50:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 878ECC433C8;
        Sun, 17 Sep 2023 16:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694969424;
        bh=75bPTpm9wsWhjLLscRsZmKkJmuZeVrTEofm/5LUVa2g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mVZNe/ZneTCYdDvVZIdtwikaEPKu+9iz6rhIwinqo/LoWIkmLRQRdNYH1J9IRzkVp
         ZVA/QCoZs0wQnaJ720Zxc03r0xF6fJWiAqvEwmhSQGwUzRuPhT730htqxtOH7Ykzrj
         g58LLdmTPsxrr2f2ujZA+sdIprQ0f5PtCNe1sBT2N6OLmgF6tFub6rpGqm45SKiXFP
         qsgf2p8rn4lozEdyCXFTikTJzEVynS2SBQr0XIIFxuXb3iWXo1klfubWgqFCfnUeaR
         L6TjDwE1rf1gByJBuEA6PHuRIpdD7QnTLgItXIMD2DLE79UPX8+FaJ9/Owxz5RQkXx
         aBxzkTPAab7nA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71BD0E26880;
        Sun, 17 Sep 2023 16:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] vsock/test: add recv_buf()/send_buf() utility
 functions and some improvements
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169496942446.18728.7629668615433862698.git-patchwork-notify@kernel.org>
Date:   Sun, 17 Sep 2023 16:50:24 +0000
References: <20230915121452.87192-1-sgarzare@redhat.com>
In-Reply-To: <20230915121452.87192-1-sgarzare@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        avkrasnov@salutedevices.com,
        virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
        bobby.eshleman@bytedance.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Sep 2023 14:14:47 +0200 you wrote:
> We recently found that some tests were failing [1].
> 
> The problem was that we were not waiting for all the bytes correctly,
> so we had a partial read. I had initially suggested using MSG_WAITALL,
> but this could have timeout problems.
> 
> Since we already had send_byte() and recv_byte() that handled the timeout,
> but also the expected return value, I moved that code to two new functions
> that we can now use to send/receive generic buffers.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] vsock/test: add recv_buf() utility function
    (no matching commit)
  - [net-next,2/5] vsock/test: use recv_buf() in vsock_test.c
    https://git.kernel.org/netdev/net-next/c/a0bcb8357716
  - [net-next,3/5] vsock/test: add send_buf() utility function
    (no matching commit)
  - [net-next,4/5] vsock/test: use send_buf() in vsock_test.c
    https://git.kernel.org/netdev/net-next/c/2a8548a9bb4c
  - [net-next,5/5] vsock/test: track bytes in MSG_PEEK test for SOCK_SEQPACKET
    https://git.kernel.org/netdev/net-next/c/bc7bea452d32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


