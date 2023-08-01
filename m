Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E7B76AA24
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjHAHkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjHAHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4261726
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58B86614B2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7B3FC433C9;
        Tue,  1 Aug 2023 07:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690875620;
        bh=yhoYUQN89C9hlJXvlCdA6QYNBshanRV5aOwNFd+hzVQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mmqppk8jyyJWHPeYMngwXWoSDVp8Idgrk011pXwWaVg22ePfxLE3JFj8++h5R+e1V
         4TNbpcvYyRJw8tpq3Pq1HNb/ntGlcHwM20vkAuaVwxnH1RPX/bCF8IbEws/zAbHk8e
         +w8KrZ2+Rjt9dljI/J1VKP/tVkMWgeeUj668O6P4Xj5NMCo1B/MsAuDuxYwlEeyLzR
         2OPAhRlRtxi+twAFUOAQqqwA0s008qvuoDDu7lEDBak+xsJxHA8sfSkT25WNRl54g/
         eXVDfgpSH42TCEwQTK3Kin5k5WkPFlLu4eH9yWXT8KwBYbVWjolEhMzTtQYxePLnzY
         DPE31FaQM0/NA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9793BC43168;
        Tue,  1 Aug 2023 07:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bpf: sockmap: Remove preempt_disable in
 sock_map_sk_acquire
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169087562061.30595.15880034182820578061.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Aug 2023 07:40:20 +0000
References: <20230728064411.305576-1-tglozar@redhat.com>
In-Reply-To: <20230728064411.305576-1-tglozar@redhat.com>
To:     None <tglozar@redhat.com>
Cc:     linux-kernel@vger.kernel.org, john.fastabend@gmail.com,
        jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 28 Jul 2023 08:44:11 +0200 you wrote:
> From: Tomas Glozar <tglozar@redhat.com>
> 
> Disabling preemption in sock_map_sk_acquire conflicts with GFP_ATOMIC
> allocation later in sk_psock_init_link on PREEMPT_RT kernels, since
> GFP_ATOMIC might sleep on RT (see bpf: Make BPF and PREEMPT_RT co-exist
> patchset notes for details).
> 
> [...]

Here is the summary with links:
  - [net] bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire
    https://git.kernel.org/netdev/net/c/13d2618b48f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


