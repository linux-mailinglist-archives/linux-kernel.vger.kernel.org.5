Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8107C7F73A6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345162AbjKXMUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjKXMUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:20:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C354D69
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:20:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09DFBC433C9;
        Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700828430;
        bh=sqn3Touu0jsrcT7nYxkOWCi4EFEBcq1dlGMiTuHM0MI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KjIMYwj6Nus/H4k8UViJDpEIZjcsB2t/MDuYKhdnAVeO9iDWACMJlI+uWN/0QhQVS
         SucHQGuKLO/i6j5refduAZzzP44GQW4ZaSLRn4XSZlEu31fC8poH3+pwjypvZAHHGf
         NaL/EapBv9pm3n/x3qN2Bn61fFtFXkFRVFvcl29ejquVuEx/FU0mrqq73aNmgMgTVE
         Hznlz6KpDGzjYkcu6MRCZ7U2dxBAA9qNkbHEXfzTxetamW8QT4xfz6vT4qyKP+DQ5q
         N55pNoIUS8HKF1vMvvNul4H30dqtRte6p/x4Xsw9+bk/ljzNVMBQdqTcw3Lca57rzl
         dKxXf15WTynwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6B6DC395FD;
        Fri, 24 Nov 2023 12:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-pf: TC flower offload support for ICMP
 type and code
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170082842994.28500.8914162610982777738.git-patchwork-notify@kernel.org>
Date:   Fri, 24 Nov 2023 12:20:29 +0000
References: <20231122114142.11243-1-gakula@marvell.com>
In-Reply-To: <20231122114142.11243-1-gakula@marvell.com>
To:     Geethasowjanya Akula <gakula@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 22 Nov 2023 17:11:42 +0530 you wrote:
> Adds tc offload support for matching on ICMP type and code.
> 
> Example usage:
> To enable adding tc ingress rules
>         tc qdisc add dev eth0 ingress
> 
> TC rule drop the ICMP echo reply:
>         tc filter add dev eth0 protocol ip parent ffff: \
>         flower ip_proto icmp type 8 code 0 skip_sw action drop
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: TC flower offload support for ICMP type and code
    https://git.kernel.org/netdev/net-next/c/a8d4879d5f1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


