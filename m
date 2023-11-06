Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891947E1CDE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjKFJAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjKFJA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:00:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB97ACC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 01:00:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A769C433BC;
        Mon,  6 Nov 2023 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699261225;
        bh=92BTUWwZg5i5Xw2EeJokaShyqsQMhNOyHnMbHhiVpEU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VAClbO+fFtISv3ZmwuIJK0OiIdXeEYxNj1Hl+ouPIjzofSfCtW9LJztYxezbi17R9
         Z89rZpjS1N8eM8wAIdwjlksvAUMSkLbfEVMTXRskr66QXOAnaXP+ql7SQ7+t5O71wn
         W8p3mynfWINADZbD9WBBWWNTNmRcSPgHDYPX2w7W+sdgT7m/r95XfNfoxHG/5Hs5LD
         PAMVrXME5jwbctyN9u/WKFpSoE+9YAym2wTNssB4riDx2TxR/atoxNHkX4h5x6P6uV
         gQBJl08a71ITNslOQ1eJZONtjNQzcmTU+NFON4rsS82w4ySQzKeKcyQgFFd4awXS8l
         6B2d0IW+jgVrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D90CE00097;
        Mon,  6 Nov 2023 09:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-pf: Free pending and dropped SQEs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169926122544.1218.5315983018632672939.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Nov 2023 09:00:25 +0000
References: <20231031112345.25291-1-gakula@marvell.com>
In-Reply-To: <20231031112345.25291-1-gakula@marvell.com>
To:     Geetha sowjanya <gakula@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com, edumazet@google.com, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, sgoutham@marvell.com,
        sbhatta@marvell.com, hkelam@marvell.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 31 Oct 2023 16:53:45 +0530 you wrote:
> On interface down, the pending SQEs in the NIX get dropped
> or drained out during SMQ flush. But skb's pointed by these
> SQEs never get free or updated to the stack as respective CQE
> never get added.
> This patch fixes the issue by freeing all valid skb's in SQ SG list.
> 
> Fixes: b1bc8457e9d0 ("octeontx2-pf: Cleanup all receive buffers in SG descriptor")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Free pending and dropped SQEs
    https://git.kernel.org/netdev/net/c/3423ca23e08b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


