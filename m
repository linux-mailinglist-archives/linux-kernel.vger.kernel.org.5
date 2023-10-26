Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744DA7D7A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjJZBa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJZBa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBD69D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:30:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63172C433CC;
        Thu, 26 Oct 2023 01:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698283826;
        bh=Mxqoy7VbEPVqYJWHfQcfM/NiT0fr4Rx4jffMyiPPZ4c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jmkwHlu4OHVwd32KGJ9qJIL90u7ALF2LdBrm71ouPTkR/iqlTJ17udfHMonli8vxe
         D+bGEqVSN9a+CtFqUv/8V4FTAFlM17Xa9ZII0LbZgRxPfq2ACb6OmAt7PKFir4ibcc
         scM1tvOWrnwpPSgjcd+ZV6d7aJarxOOTYMM3+lg73V2MFU1cE09fU2vakO5Dbu5LL6
         7HBvNZkJEeKOcF0/gBToo8zOBsdgumzk9eAz5vVHN5nFvjmfK1wAYFeEvDaawkJUy+
         1lV4gmA3zrpUTuj2+TbUlInNRRkMZ+1ZfOrXcURrw6Dw3DTL5MBhgwxbD/eA3UPMlm
         vfnlq1vvN+cHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48835E4CC0F;
        Thu, 26 Oct 2023 01:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net-next 0/3] ipv6: avoid atomic fragment on GSO output
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169828382629.14693.2027988602080029983.git-patchwork-notify@kernel.org>
Date:   Thu, 26 Oct 2023 01:30:26 +0000
References: <cover.1698156966.git.yan@cloudflare.com>
In-Reply-To: <cover.1698156966.git.yan@cloudflare.com>
To:     Yan Zhai <yan@cloudflare.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ayal@nvidia.com, tariqt@nvidia.com, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, fw@strlen.de,
        willemdebruijn.kernel@gmail.com, alexander.duyck@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Oct 2023 07:26:28 -0700 you wrote:
> When the ipv6 stack output a GSO packet, if its gso_size is larger than
> dst MTU, then all segments would be fragmented. However, it is possible
> for a GSO packet to have a trailing segment with smaller actual size
> than both gso_size as well as the MTU, which leads to an "atomic
> fragment". Atomic fragments are considered harmful in RFC-8021. An
> Existing report from APNIC also shows that atomic fragments are more
> likely to be dropped even it is equivalent to a no-op [1].
> 
> [...]

Here is the summary with links:
  - [v5,net-next,1/3] ipv6: drop feature RTAX_FEATURE_ALLFRAG
    https://git.kernel.org/netdev/net-next/c/e57a34478586
  - [v5,net-next,2/3] ipv6: refactor ip6_finish_output for GSO handling
    https://git.kernel.org/netdev/net-next/c/1f7ec1b3721d
  - [v5,net-next,3/3] ipv6: avoid atomic fragment on GSO packets
    https://git.kernel.org/netdev/net-next/c/03d6c848bfb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


