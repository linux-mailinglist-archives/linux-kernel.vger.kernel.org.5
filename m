Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9877DF1A3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344874AbjKBLu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344733AbjKBLu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:50:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81523133
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2AC1C433CA;
        Thu,  2 Nov 2023 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698925822;
        bh=Pf1c1Zob157wCaR6+3UGacUZgEjfHNk4/blaFlwOIY8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g61e9KKxYXnPaOy4HQNQiHKLCkleVBQ9jeHTzMv4fNQV50tCVr+tD+u/NbOcnLOEB
         qFb8OEy1wdVuPxTLftK2XY+ZKJLoIxtHvIhq68bQxkElI7uDgoKqo7v8E57F9H31K5
         TF2UmU+yJQURjUiGUhOgQfC/xcNNHyc7Q0Kc29cmz5jQBNowZkDQh2hyL2x/gsUtW1
         BoRIIVpiGAv91UuvtmQYmxOQU9QtbI1GNFiIg6og3m6nzPSLtvYq2moCnRjU0NlCOH
         1dW2F9HIJebzbGVPg9DS5p7BqaNGa/z6uGYMlazafc2ZDcwPL2zyOaa/JsfwJ1+ow6
         cUo92UmTLRyyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5E88C4316B;
        Thu,  2 Nov 2023 11:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: page_pool: add missing free_percpu when
 page_pool_init fail
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169892582274.28990.7721054439007529390.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Nov 2023 11:50:22 +0000
References: <20231030091256.2915394-1-shaojijie@huawei.com>
In-Reply-To: <20231030091256.2915394-1-shaojijie@huawei.com>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     hawk@kernel.org, ilias.apalodimas@linaro.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jdamato@fastly.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, linyunsheng@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 30 Oct 2023 17:12:56 +0800 you wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> When ptr_ring_init() returns failure in page_pool_init(), free_percpu()
> is not called to free pool->recycle_stats, which may cause memory
> leak.
> 
> Fixes: ad6fa1e1ab1b ("page_pool: Add recycle stats")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net] net: page_pool: add missing free_percpu when page_pool_init fail
    https://git.kernel.org/netdev/net/c/8ffbd1669ed1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


