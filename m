Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AB47FB67F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343965AbjK1KAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343931AbjK1KAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:00:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97C21A5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:00:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C361C433C9;
        Tue, 28 Nov 2023 10:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701165624;
        bh=NsbL4HYOozvRUMI4yuxv4Ey5+n2/HiIxbM5udGAy0G4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kIj3796dvOVWLt/qfCo2ZnjGWRISk9idwyOE9Ko9gnepEsxIFsE/AgqRKBQtoEwrX
         aHm2oeBeM1P+xfLgIe6QMOVV7q2AsTK8mT31mcNKeeKJ4EqeeBw2hUD8s9MWFPB+z3
         dT9AA51ajuiLWEUUpFlgDRHlWav/x6pzeHfo9S+vpRnCA6ERJkkB9aOno8S+2Fxj4c
         uDWcp5WcU3u5RZae/jUIxCzRoRxvv22hIajrxJGRjxdLSCFK0cikJ6Vp3hCXhg1A2V
         xg7HHo+YiOVMCxZOslrUdJ3mIO9y8Zu4hFywOlxfAgR0ETgoKjkSPf7J5LtWaOyWhB
         2mkb3TJNXUVLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F196C39562;
        Tue, 28 Nov 2023 10:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: Fix possible buffer overflow
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170116562425.31333.11843125198692560702.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Nov 2023 10:00:24 +0000
References: <20231124210802.109763-1-elena.salomatkina.cmc@gmail.com>
In-Reply-To: <20231124210802.109763-1-elena.salomatkina.cmc@gmail.com>
To:     Elena Salomatkina <elena.salomatkina.cmc@gmail.com>
Cc:     sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        horms@kernel.org
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

On Sat, 25 Nov 2023 00:08:02 +0300 you wrote:
> A loop in rvu_mbox_handler_nix_bandprof_free() contains
> a break if (idx == MAX_BANDPROF_PER_PFFUNC),
> but if idx may reach MAX_BANDPROF_PER_PFFUNC
> buffer '(*req->prof_idx)[layer]' overflow happens before that check.
> 
> The patch moves the break to the
> beginning of the loop.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix possible buffer overflow
    https://git.kernel.org/netdev/net/c/ad31c629ca3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


