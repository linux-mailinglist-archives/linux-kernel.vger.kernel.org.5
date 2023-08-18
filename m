Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007717803D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357258AbjHRCak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357319AbjHRCac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:30:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11C23AA2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AD6065BD1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BFE3C433C7;
        Fri, 18 Aug 2023 02:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692325821;
        bh=OoorYLdGq+UJYNQzXtUNDMaA8vkMoHiJXy3TDyBghgM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SwXu+PeFodfjUv8M+OEOvtZLrED7a7H+Ap37lRnV0Lh7vOGzZ8lTEuziERcKG1c93
         NNGRU+0EW+DBhh76CgwJy9E0WomaK/jI1z8YxsCgGL3XthKZ/lAXF7CH5RZIrIZ9hT
         P6lHRxRSsvfQOEUXJmdO3o5qkva0wIRGyfpLwGkexSKecftFbboieTpz6HdyZnSo3j
         uO6iRJ2qfTWrHxK57ods76vOHQV7p45b3hth2CM4jgPQa4AxkbZrTLXM7rv9OYlu45
         2NrgxVjg69PHWsSDuqn6PWoWnbVCj5Hv7cZfx9LWYwEcksIzd1x5YCSLh/yPPUSSRG
         6bdrdNn3ISSpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DD53C395C5;
        Fri, 18 Aug 2023 02:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] netem: use a seeded PRNG for loss and
 corruption events
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169232582144.23504.11512745597363799032.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Aug 2023 02:30:21 +0000
References: <20230815092348.1449179-1-francois.michel@uclouvain.be>
In-Reply-To: <20230815092348.1449179-1-francois.michel@uclouvain.be>
To:     Francois Michel <francois.michel@uclouvain.be>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        stephen@networkplumber.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 15 Aug 2023 11:23:37 +0200 you wrote:
> From: François Michel <francois.michel@uclouvain.be>
> 
> In order to reproduce bugs or performance evaluation of
> network protocols and applications, it is useful to have
> reproducible test suites and tools. This patch adds
> a way to specify a PRNG seed through the
> TCA_NETEM_PRNG_SEED attribute for generating netem
> loss and corruption events. Initializing the qdisc
> with the same seed leads to the exact same loss
> and corruption patterns. If no seed is explicitly
> specified, the qdisc generates a random seed using
> get_random_u64().
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] netem: add prng attribute to netem_sched_data
    https://git.kernel.org/netdev/net-next/c/4072d97ddc44
  - [v2,net-next,2/3] netem: use a seeded PRNG for generating random losses
    https://git.kernel.org/netdev/net-next/c/9c87b2aeccf1
  - [v2,net-next,3/3] netem: use seeded PRNG for correlated loss events
    https://git.kernel.org/netdev/net-next/c/3cad70bc74ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


