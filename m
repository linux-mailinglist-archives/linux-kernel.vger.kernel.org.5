Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FE07F7711
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345434AbjKXPAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjKXPAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:00:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F4993
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:00:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D66F2C433D9;
        Fri, 24 Nov 2023 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700838026;
        bh=V+EF64XIiJz+6JrAd40V/n3zZjFbI/vKNPVT3Fd3Axs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q4B6+MjjQHGeFjASnhbIJcIKaiU+I8nNbvlGNzY5KrHcVvfk9kmERv9MmLXB/gfts
         4I5aj6qbZ6bgY0O55v9KDI1S34/Yd0iBUWp2l1wI9H0CjdthwQWxOwqdRrdwVo75YJ
         KNAdNThg8e7vQyDMq+X81tOKSgdC6jrM2KcDzQp+nThVhqcuwIYtQVThsB5/ezSrGE
         Enq2dwePO8n0GL81uZvwgCSHgYRacKfMwJHs0W1iTpr/tkFiDHO4dSOX5ZDZwlRD78
         +I7MANT6AJaPw7b5edCVxwVqdMUlwvmD0HbmzugmU79PdjAI1mKgZnbGmZZb91f2ZI
         sCxYI4d+4UB3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8219E00087;
        Fri, 24 Nov 2023 15:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mptcp: fix uninit-value in mptcp_incoming_options
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170083802675.22904.16498084605139747713.git-patchwork-notify@kernel.org>
Date:   Fri, 24 Nov 2023 15:00:26 +0000
References: <tencent_B0E02F1D6C009450E8D6EC06CC6C7B5E6C0A@qq.com>
In-Reply-To: <tencent_B0E02F1D6C009450E8D6EC06CC6C7B5E6C0A@qq.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, martineau@kernel.org,
        matthieu.baerts@tessares.net, matttbe@kernel.org,
        mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
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
by David S. Miller <davem@davemloft.net>:

On Thu, 23 Nov 2023 09:23:39 +0800 you wrote:
> Added initialization use_ack to mptcp_parse_option().
> 
> Reported-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/mptcp/options.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - mptcp: fix uninit-value in mptcp_incoming_options
    https://git.kernel.org/netdev/net/c/237ff253f2d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


