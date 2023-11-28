Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B847FB952
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344534AbjK1LUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344558AbjK1LUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:20:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1426CD5D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:20:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A266CC433C7;
        Tue, 28 Nov 2023 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701170425;
        bh=Bbx88lqFMGatwFHlD0kQVkdO9pmX8bC2BeBmnxyMEmQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GgSy7foS9Mx9VL3KJuEL7r1pvft1WAsNxazpPgZpFChIpm9hPTAzcPa6LzjZoxH2F
         ilp72qD9tIpKuThy+Sxs0AjoV31d17lTKwX+cp2+sOcuZ3A33qKmp/YnsAUSA197VY
         nd6xnCxiqUf43dbgNDPC/uEgng3RdA2yJBQoReaPxh6Txp7yZlfVWGDqznF0NHO5S2
         1UAUl5Yx2nHd5TkcOlqcoe1v48hv2u2Fo2vUMF3JJnGflpwEH6VEA9KJyIgwQYmnPH
         KXd71HVLA133Uwpu4kSjGTgqZKZkQGP1uz+2wdzqj/InV4J1hDli0zH4cv22FNp7qk
         BSSVLGbRs9YmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88933DFAA83;
        Tue, 28 Nov 2023 11:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: Restore TC ingress police rules when
 interface is up
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170117042555.17319.6348597047572958500.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Nov 2023 11:20:25 +0000
References: <1700930217-5707-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1700930217-5707-1-git-send-email-sbhatta@marvell.com>
To:     Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, gakula@marvell.com,
        hkelam@marvell.com
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

On Sat, 25 Nov 2023 22:06:57 +0530 you wrote:
> TC ingress policer rules depends on interface receive queue
> contexts since the bandwidth profiles are attached to RQ
> contexts. When an interface is brought down all the queue
> contexts are freed. This in turn frees bandwidth profiles in
> hardware causing ingress police rules non-functional after
> the interface is brought up. Fix this by applying all the ingress
> police rules config to hardware in otx2_open. Also allow
> adding ingress rules only when interface is running
> since no contexts exist for the interface when it is down.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Restore TC ingress police rules when interface is up
    https://git.kernel.org/netdev/net/c/fd7f98b2e12a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


