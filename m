Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217D07EE961
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbjKPWkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjKPWka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:40:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4494D55
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:40:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 633FAC433C9;
        Thu, 16 Nov 2023 22:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700174426;
        bh=hhJxCwgkhNq5mTKwgfqKGY5emDpnAzXQlHkFgPmYc4o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=R4gMdz1AeYvYzouClPzwzjMPLEOwKFQMHmTQQAiHd0UPMC63KNQP1XhJHI4xWhL3m
         HgZ6aI6N7f0PpazRRax3Guk6mXAba8jCbTFoGZYRKXDhEBv5RBGUm9elIE0k+b6V6S
         YEs9261FGCTRcKqEP3mVmAs+Z1IlcUOzQBYaS2yO/i5BNRvpq3CRgokli2E8OXMTqI
         F7nCn5vjn9aMBV5/T5dvDBXBBMBRihgXNTmVOU7+HIiwpPnoi/7KEAsyznv4Pr1D/v
         x/S4wCt8k0HDdStFS825iHeU2tHQ8JnnPeGG5+VJk4W6QTZwyG4IkV94+oP14ih499
         95twpEA1TJy2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46BA1E00090;
        Thu, 16 Nov 2023 22:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests/net: synchronize udpgro tests' tx and
 rx connection
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170017442628.21715.12487651571633570474.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Nov 2023 22:40:26 +0000
References: <jvzrm33xjrhal3qro37tfpfw2w4jbh35byjlogcc776xt4fpzy@zkmfoqn5ipil>
In-Reply-To: <jvzrm33xjrhal3qro37tfpfw2w4jbh35byjlogcc776xt4fpzy@zkmfoqn5ipil>
To:     Lucas Karpinski <lkarpins@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by David S. Miller <davem@davemloft.net>:

On Tue, 14 Nov 2023 10:11:31 -0500 you wrote:
> The sockets used by udpgso_bench_tx aren't always ready when
> udpgso_bench_tx transmits packets. This issue is more prevalent in -rt
> kernels, but can occur in both. Replace the hacky sleep calls with a
> function that checks whether the ports in the namespace are ready for
> use.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests/net: synchronize udpgro tests' tx and rx connection
    https://git.kernel.org/netdev/net-next/c/3bdd9fd29cb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


