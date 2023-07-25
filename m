Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315CF760D02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjGYIae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjGYIaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:30:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4DAE57
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:30:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B19E61511
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00B06C433C9;
        Tue, 25 Jul 2023 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690273828;
        bh=JFrJ4nSKyL1Po2pXxouc7d+HenWHpFKgiTP5aMROtZs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TGiFXIG2tRRnLiXiHCILxnYg0DGWYmQy04/lLbL3KtGUwumtau6KTm05su23LIAxm
         hULgAiSCdFjUvSKmHvoJeh6e5FvcwSSbxvY/7Mmy4/4GBwBhnaJu18cqH1y/3Pr0Ad
         klPnCSMhoxWZtq9SOkMCgQ2YI2E7epD/GofYjiVXg96QPbPrpgyS1GJh77mDAQFkpL
         zpkr1SqRUDqtEa1q9ALH6uxX/G35Ub6tJlS9S4dHFHRjB2eFL30GR9wXx6jzlkFn+D
         g9UuBvfPRa4CRMkTgY00Q1vtZULJgQiY3BAGd/MvWqVWU4QGy0Ei0QGC5C6f/DdzvV
         NN2znfgc6iX6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D65F1C73FE2;
        Tue, 25 Jul 2023 08:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH V4] octeontx2-af: Fix hash extraction enable configuration
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169027382787.932.8358430107229778836.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Jul 2023 08:30:27 +0000
References: <20230721061222.2632521-1-sumang@marvell.com>
In-Reply-To: <20230721061222.2632521-1-sumang@marvell.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com
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
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 21 Jul 2023 11:42:22 +0530 you wrote:
> As of today, hash extraction support is enabled for all the silicons.
> Because of which we are facing initialization issues when the silicon
> does not support hash extraction. During creation of the hardware
> parsing table for IPv6 address, we need to consider if hash extraction
> is enabled then extract only 32 bit, otherwise 128 bit needs to be
> extracted. This patch fixes the issue and configures the hardware parser
> based on the availability of the feature.
> 
> [...]

Here is the summary with links:
  - [net,V4] octeontx2-af: Fix hash extraction enable configuration
    https://git.kernel.org/netdev/net/c/4e62c99d71e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


