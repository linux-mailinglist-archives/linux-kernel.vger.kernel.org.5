Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2742F80B0E6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574840AbjLIAU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLIAUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:20:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D329B171F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:20:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F891C433CC;
        Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702081229;
        bh=9QTbyhHxnjxUS8mDK0v9LhPk8RQqv5D9wzPUvOZy6Wg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=k+n/QDnMAD+I2D+JxxnVM36kQSOjv9EwZi/WCLoQDrG3rQ4APJ2hn1FlO6jbgZvgo
         agNN46+fzBXk38N+PKTtRFm4XXQC90bMTYKIyqnejev7gOc7CGrPnbhnSfz8XnKCc3
         JFEknYp8rEI6aXGGRlSy+S1IdlRBi9UbohNNfe4swf77CDaNDoouhK40RBnyoFa2ii
         Th14siC1hrLqgXvICKda/aW3j677s7YTXvVEZ8MWzu7ro7ba6SAgKQK7PUiEXq9Ek8
         DRuqd2uTZvADyGMIvYyKHs/ofN+jf5jzDEESpv0KRQaaDrZywC2nGUOsLCZn30trZU
         tcIKGFDMKGScw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F6DCC595D0;
        Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] octeon_ep: initialise control mbox tasks before using
 APIs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170208122925.21357.2124967308969408526.git-patchwork-notify@kernel.org>
Date:   Sat, 09 Dec 2023 00:20:29 +0000
References: <20231206135228.2591659-1-srasheed@marvell.com>
In-Reply-To: <20231206135228.2591659-1-srasheed@marvell.com>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, egallen@redhat.com,
        mschmidt@redhat.com, pabeni@redhat.com, horms@kernel.org,
        kuba@kernel.org, davem@davemloft.net, wizhao@redhat.com,
        konguyen@redhat.com, vburru@marvell.com, sedara@marvell.com,
        edumazet@google.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 6 Dec 2023 05:52:27 -0800 you wrote:
> Initialise various workqueue tasks and queue interrupt poll task
> before the first invocation of any control net APIs. Since
> octep_ctrl_net_get_info was called before the control net receive
> work task was initialised or even the interrupt poll task was
> queued, the function call wasn't returning actual firmware
> info queried from Octeon.
> 
> [...]

Here is the summary with links:
  - [net,v3] octeon_ep: initialise control mbox tasks before using APIs
    https://git.kernel.org/netdev/net/c/a1664b991ac1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


