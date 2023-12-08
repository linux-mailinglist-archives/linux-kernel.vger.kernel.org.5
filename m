Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C171F80A174
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjLHKuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjLHKuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:50:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5900CE9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:50:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DADA6C433C9;
        Fri,  8 Dec 2023 10:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702032623;
        bh=LEtB9at6X+SClQxgbXPuelGVlTPDowCMmdLHvwtxK+s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XX1rcNpxNeORNo0UsY/rt4dXHIeDAolDpXIHtM8v4YHILUr210ZTqlNXhdcvs6UQb
         b0XmamUIC8Y/GRxt8OR6yU+MahN9IhcCaCHtDrqHCfE3JamL7lL0M/V4fvXw4P622l
         1CDzJhJHCRQofsTcq2eG59D4kIWeqb4a0djuiaFvueES3l55pe6QClQQMM5SEYES2I
         UEnLhE2WjE7nybhheCm9lmmAuf4D/hpOcj59Ebw7eIT8KoYvoI06eAe18zy/nz2iVs
         O7xa7C5onZLYkgiRdjArRTNJv7jWo3Rxyoij2FuUyjN6kfArdxHJz+68CIVsTwsBEK
         5lX0zDlyymsZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C46A8C04E32;
        Fri,  8 Dec 2023 10:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable preemption
 for long
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170203262380.21119.9612861289100953455.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Dec 2023 10:50:23 +0000
References: <20231206033913.1290566-1-judyhsiao@chromium.org>
In-Reply-To: <20231206033913.1290566-1-judyhsiao@chromium.org>
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
        dianders@chromium.org, haleyb.dev@gmail.com, davem@davemloft.net,
        kuba@kernel.org, joel.granados@gmail.com, ja@ssi.bg,
        leon@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Wed,  6 Dec 2023 03:38:33 +0000 you wrote:
> We are seeing cases where neigh_cleanup_and_release() is called by
> neigh_forced_gc() many times in a row with preemption turned off.
> When running on a low powered CPU at a low CPU frequency, this has
> been measured to keep preemption off for ~10 ms. That's not great on a
> system with HZ=1000 which expects tasks to be able to schedule in
> with ~1ms latency.
> 
> [...]

Here is the summary with links:
  - [v2] neighbour: Don't let neigh_forced_gc() disable preemption for long
    https://git.kernel.org/netdev/net/c/e5dc5afff62f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


