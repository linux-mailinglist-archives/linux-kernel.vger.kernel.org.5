Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075067EBC7E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 05:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjKOEAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 23:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbjKOEAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 23:00:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D515D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 20:00:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAE95C433C8;
        Wed, 15 Nov 2023 04:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700020826;
        bh=GP9AOiP08EL+YmbPhaW830EIbWSCwj+NchiHetIHqNc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Zi6w7rTGRMWJZTES6tXCGv1w0glXXyjO4m+LuxpZTM4Xsdh3pLrp7suxTUtWiG9gt
         KGPAT69UydJ7dz1U0zChJ2Igptw2bLgkqAHa64TOckCz3+x2YWY59Jd1LRZO3WZOM1
         gX3SqygpXbHtOMk/4LC5B2a/NpTsPn6/LiEe5qH9NvyEaL4ySMmhRN5VKAQwpqddww
         f4SOuGCmwRjHb5CdWMmEXK5r9CHGorTKn8n+oLon7kfiSprXOBliSsN03Y+KLcAnG5
         mUdcYq9eTKYlIbHygwPYSDJXMCB4TVubIlOzvV3c4ohJoYfWdzeR2+rIWMxSnpkec3
         sHdEv6lorSGfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1E28E1F671;
        Wed, 15 Nov 2023 04:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/2] tg3: Move the [rt]x_dropped counters to tg3_napi
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170002082585.14036.6726245489238150125.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Nov 2023 04:00:25 +0000
References: <20231113182350.37472-1-alexey.pakhunov@spacex.com>
In-Reply-To: <20231113182350.37472-1-alexey.pakhunov@spacex.com>
To:     Alex Pakhunov <alexey.pakhunov@spacex.com>
Cc:     mchan@broadcom.com, vincent.wong2@spacex.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        siva.kallam@broadcom.com, prashant@broadcom.com
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

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Nov 2023 10:23:49 -0800 you wrote:
> From: Alex Pakhunov <alexey.pakhunov@spacex.com>
> 
> This change moves [rt]x_dropped counters to tg3_napi so that they can be
> updated by a single writer, race-free.
> 
> Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
> Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
> 
> [...]

Here is the summary with links:
  - [v4,1/2] tg3: Move the [rt]x_dropped counters to tg3_napi
    https://git.kernel.org/netdev/net/c/907d1bdb8b2c
  - [v4,2/2] tg3: Increment tx_dropped in tg3_tso_bug()
    https://git.kernel.org/netdev/net/c/17dd5efe5f36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


