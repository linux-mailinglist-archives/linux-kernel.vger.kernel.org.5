Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4C1800AC6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378815AbjLAMUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378787AbjLAMUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:20:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F6B10D7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:20:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECD69C433CA;
        Fri,  1 Dec 2023 12:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701433224;
        bh=r5+SzKU9zczSRoMsLc2KT920PUqyCU5KZGvs9wZ04Tk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tgtB34HNWEu4yrvcSUzDhNwu5XN9cSY4NLKuY5A8dZ7sh5647TPmbFX05LyO/9JgM
         a8XTzTgVioej19Z/BemV5alT0gLcv7DpXXtxvlaHsBazju7ZNTkZVn5PwHN2aS3PiR
         4sC7ARSO5nfC3sYWA0sP5lAG6USLAF29jrRI4+geC7tWKqhB/mvH5VP+VmT3oYVQLo
         jHZXugUhwSY3g7ct//QJzrhRb493Z/wFpfV5XqVegaFdricVB4kywRpJJmLazIBHje
         RVFrpUNxODpxWSMDy/ijM1RG+B0aWo1kzUmGv5dXVO9PstPttYoTNSuH2e1E6C6gvY
         j7haFk0biq96Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4DA1C59A4C;
        Fri,  1 Dec 2023 12:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] octeontx2-af: Check return value of nix_get_nixlf
 before using nixlf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170143322386.17347.11199094399378598033.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Dec 2023 12:20:23 +0000
References: <1701236508-22930-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1701236508-22930-1-git-send-email-sbhatta@marvell.com>
To:     Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, gakula@marvell.com,
        hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
        naveenm@marvell.com
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

On Wed, 29 Nov 2023 11:11:48 +0530 you wrote:
> If a NIXLF is not attached to a PF/VF device then
> nix_get_nixlf function fails and returns proper error
> code. But npc_get_default_entry_action does not check it
> and uses garbage value in subsequent calls. Fix this
> by cheking the return value of nix_get_nixlf.
> 
> Fixes: 967db3529eca ("octeontx2-af: add support for multicast/promisc packet replication feature")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> [...]

Here is the summary with links:
  - [v3,net] octeontx2-af: Check return value of nix_get_nixlf before using nixlf
    https://git.kernel.org/netdev/net/c/830139e7b691

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


