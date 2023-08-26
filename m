Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E1B78933A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 04:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjHZCAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 22:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjHZCA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 22:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98007210D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 19:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30F1160A70
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84270C433C9;
        Sat, 26 Aug 2023 02:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693015224;
        bh=o46KMsO7FRfqG3p9aZ9Qw3NkDJKP2vC1xQ/IfNu91wA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D+GX/LgkwGg52Y0cNAg/CeelDAKG/yiVi98LJsMNeRMRGhddEUiIRhXQ9wmzvIxcl
         EEp6oD//nhfUxX65Lb1eygCbWPTHPKkLiWORuTUdoXAcUgJAMEZ0zyXKRJZhKPs7YC
         xWYumbKXfLMGrSsAZLno7teLCV0lzsxvH5T3nejpseIJWVfRD6WQCyRteRDaJPw6lY
         GAeOhxVVrGTtHCJFR8a4v+Jyno90TGUbRlw4RbOi89BVCKHHLS3VwUBDQ3lXvxARVS
         uvqd+Oz33odWxapuEUTEjn6yqCJwNMah1pcHfgpr8p/2LzHs2dsqN5Eeuz1ZxBVMwN
         M4fY5ZuVbNIpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A5F2C595C5;
        Sat, 26 Aug 2023 02:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH V4 0/3] Fix PFC related issues
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169301522443.10076.12242857731455904416.git-patchwork-notify@kernel.org>
Date:   Sat, 26 Aug 2023 02:00:24 +0000
References: <20230824081032.436432-1-sumang@marvell.com>
In-Reply-To: <20230824081032.436432-1-sumang@marvell.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horms@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Aug 2023 13:40:29 +0530 you wrote:
> This patchset fixes multiple PFC related issues related to Octeon.
> 
> Patch #1: octeontx2-pf: Fix PFC TX scheduler free
> 
> Patch #2: octeontx2-af: CN10KB: fix PFC configuration
> 
> Patch #3: octeonxt2-pf: Fix backpressure config for multiple PFC
> priorities to work simultaneously
> 
> [...]

Here is the summary with links:
  - [net,V4,1/3] octeontx2-pf: Fix PFC TX scheduler free
    https://git.kernel.org/netdev/net/c/a9ac2e187795
  - [net,V4,2/3] octeontx2-af: CN10KB: fix PFC configuration
    https://git.kernel.org/netdev/net/c/47bcc9c1cf6a
  - [net,V4,3/3] cteonxt2-pf: Fix backpressure config for multiple PFC priorities to work simultaneously
    https://git.kernel.org/netdev/net/c/597d0ec0e4ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


