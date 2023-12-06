Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535CC8066E5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376868AbjLFGAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376768AbjLFGAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:00:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F88518F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:00:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ACA6C433C8;
        Wed,  6 Dec 2023 06:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701842426;
        bh=9oMotMl6cBHvoh0aoy720TZQixKh8EXqycLlXSSUncY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=o57D61M+8H3t7mO0oXDMsezyaXwHMXWvqmcy1uZJQ91ALwvnPccv7o6D0+mF6kMGz
         WvnjbigdDaNhuWNVzkgrcZ1gWaqxxADmg3OX/AaABMothOQ8X3scRBszkt1KGCmgtR
         zHyJidZw5PGzagicwDO4eD798ZnaWOiLgsdndj6M/tKnVj7oaQLVecDBL3Dh4Pw++g
         a0rPbLFBirHwy5xo542hYPRkYMGsWUkuVt3nXqmVFn9XS8msCTri/kYETIfQQAXBw/
         vzaHL2lXF/zvlNAPLraaWN57AQ6wjToHAr5eCKndZEBSxk5L9gQvkpcV6RtFQVFFUi
         xYGiUT5Oa+4Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E55FC395DC;
        Wed,  6 Dec 2023 06:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next] packet: add a generic drop reason for receive
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170184242618.7312.12769597881622263947.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Dec 2023 06:00:26 +0000
References: <ZW4piNbx3IenYnuw@debian.debian>
In-Reply-To: <ZW4piNbx3IenYnuw@debian.debian>
To:     Yan Zhai <yan@cloudflare.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, jesper@cloudflare.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 4 Dec 2023 11:33:28 -0800 you wrote:
> Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches
> from consume_skb to kfree_skb to improve error handling. However, this
> could bring a lot of noises when we monitor real packet drops in
> kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones
> can be freed, not actual packets.
> 
> Adding a generic drop reason to allow distinguish these "clone drops".
> 
> [...]

Here is the summary with links:
  - [v4,net-next] packet: add a generic drop reason for receive
    https://git.kernel.org/netdev/net-next/c/2f57dd94bdef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


