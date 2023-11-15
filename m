Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADF87EBC99
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 05:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjKOEUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 23:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbjKOEU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 23:20:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D81D9;
        Tue, 14 Nov 2023 20:20:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B384C433C9;
        Wed, 15 Nov 2023 04:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700022024;
        bh=PlKEtWmd15CNYGGTl7+gaJVldxfItHtqkbBfnLkwDr8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nlNe+6br2hBhMsvxlJ0TKBCUjShxd7Ej6tQHty8s6knL/tdLzTKn7YspdkcDQeiZX
         FNgHeB7gALUYms1cJMqfWPSKqWcMd7FYQwv4OWL+uTgo2SaCEFBum5/fzGJ2bVZVuo
         exvcdBxK1zMfOH84h4n1Rv2XRlMLfof1qeurKl3G5aEHSDcorfbkvHPiG7EAD/YrvY
         bYvlAy9GsmtZojYqlWT9+4sajzQOQYgBOJsjA1FVT2KC2XQa4QT5ajyyezvJmSTEqe
         HTb2KAp9/Vh9AjhL7MHpyWPjEJ6zh9XHAAq106AR0BvJ9SO8Y7QYs0HtjOPVy4cDeD
         jJVvQfaEp0BjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E323BEA7DA0;
        Wed, 15 Nov 2023 04:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mptcp: misc. fixes for v6.7
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170002202392.25123.5567569112552838973.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Nov 2023 04:20:23 +0000
References: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-0-7b9cd6a7b7f4@kernel.org>
In-Reply-To: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-0-7b9cd6a7b7f4@kernel.org>
To:     Matthieu Baerts <matttbe@kernel.org>
Cc:     mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexanderduyck@fb.com, geliang.tang@suse.com, psonparo@redhat.com,
        shuah@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        cpaasch@apple.com, stable@vger.kernel.org,
        syzbot+9dfbaedb6e6baca57a32@syzkaller.appspotmail.com,
        xmu@redhat.com
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

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Nov 2023 00:16:12 +0100 you wrote:
> Here are a few fixes related to MPTCP:
> 
> - Patch 1 limits GSO max size to ~64K when MPTCP is being used due to a
>   spec limit. 'gso_max_size' can exceed the max value supported by MPTCP
>   since v5.19.
> 
> - Patch 2 fixes a possible NULL pointer dereference on close that can
>   happen since v6.7-rc1.
> 
> [...]

Here is the summary with links:
  - [net,1/5] mptcp: deal with large GSO size
    https://git.kernel.org/netdev/net/c/9fce92f050f4
  - [net,2/5] mptcp: fix possible NULL pointer dereference on close
    https://git.kernel.org/netdev/net/c/d109a7767273
  - [net,3/5] mptcp: add validity check for sending RM_ADDR
    https://git.kernel.org/netdev/net/c/8df220b29282
  - [net,4/5] mptcp: fix setsockopt(IP_TOS) subflow locking
    https://git.kernel.org/netdev/net/c/7679d34f97b7
  - [net,5/5] selftests: mptcp: fix fastclose with csum failure
    https://git.kernel.org/netdev/net/c/7cefbe5e1dac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


