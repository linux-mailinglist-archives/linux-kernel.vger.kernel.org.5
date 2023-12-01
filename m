Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06738800969
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378486AbjLALKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378464AbjLALKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:10:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40003193
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:10:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1172C433C7;
        Fri,  1 Dec 2023 11:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701429023;
        bh=a16OAQT2aoHFf/rpgoy1OBrQ1J6SxYIu1qUavost96Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WHpuoNkxOfpQjiIjE+8wgR5se8dvPnG7Z00xbSGSsj1DWaPITMGjvO5PSuMDgKeQh
         SPRRAe3AipZB7o5wbDV2aY94TQcYXWMFr23+3fP0S1+m+VEZczakNmpaX5HXqQGZGb
         araWvemnbh4eJURNEs11Ks1K7+hK0pfFOyaO4KVVQ8CNUuVjFvSHMtP3cmzQG0f6hk
         /leN4ZnmHAf/b/vacNWzS/DUPw1V1eSfk36BqqMmKxOSW8OBi1pvWxFblSsJVWn3Nw
         zs4h+Yv7judjY/sBbjx0O9oB7iue9o8bsSK05g0sHg8wv6RKue3yMVzxiu0Bt9qLT5
         7dSYxBrz4umHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B58EAC59A4C;
        Fri,  1 Dec 2023 11:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] octeontx2-pf: Add missing mutex lock in
 otx2_get_pauseparam
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170142902373.13641.10956556267132946776.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Dec 2023 11:10:23 +0000
References: <1701235422-22488-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1701235422-22488-1-git-send-email-sbhatta@marvell.com>
To:     Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, gakula@marvell.com,
        hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com
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

On Wed, 29 Nov 2023 10:53:42 +0530 you wrote:
> All the mailbox messages sent to AF needs to be guarded
> by mutex lock. Add the missing lock in otx2_get_pauseparam
> function.
> 
> Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> [...]

Here is the summary with links:
  - [v2,net] octeontx2-pf: Add missing mutex lock in otx2_get_pauseparam
    https://git.kernel.org/netdev/net/c/9572c949385a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


