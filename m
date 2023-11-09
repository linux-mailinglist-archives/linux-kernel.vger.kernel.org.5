Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D037E6268
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjKICuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjKICue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:50:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED84E25BC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 18:50:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90BB1C4339A;
        Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699498231;
        bh=rypF52HZNINO8JSuFL2z3jgwZ/ipWy/ErtNiJAhuVZo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=utRq5nKDq3IoXhxsAxigIXknhBv4WKsc2hjxDOVZKfKMq0B2V2H065KYk64ecefIF
         VWm3UcV1NDkOphIMK8vc0fyf1uV317U1t+JHyDXpYbCy9n2MWpwtNBE588Q6prhQLY
         5n3OaDpz1N6gdbGGxGSU60UeYpaxFR86cQnEhwUMb+Zo3CtSAy8BsW2yH9lARe51ud
         o2bwV3HjShcPLxseeynklTtZAOBv1Y7shhr1aJK8NstGDLhy3AwyXE/CHHerntPtZ6
         YL8tfUm/NelYQGHRUfk5Mhn+LsUZtE96hSAUu+xa+e8OfFDHtxmX9hClEw+dG0UYgJ
         4QsmNUlq6w32w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E511C3274C;
        Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V9 1/2] ptp: ptp_read should not release queue
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169949823151.3016.8717702673323836042.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Nov 2023 02:50:31 +0000
References: <tencent_18747D76F1675A3C633772960237544AAA09@qq.com>
In-Reply-To: <tencent_18747D76F1675A3C633772960237544AAA09@qq.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     richardcochran@gmail.com, davem@davemloft.net,
        habetsm.xilinx@gmail.com, jeremy@jcline.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Nov 2023 16:00:40 +0800 you wrote:
> Firstly, queue is not the memory allocated in ptp_read;
> Secondly, other processes may block at ptp_read and wait for conditions to be
> met to perform read operations.
> 
> Acked-by: Richard Cochran <richardcochran@gmail.com>
> Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
> Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> [...]

Here is the summary with links:
  - [net,V9,1/2] ptp: ptp_read should not release queue
    https://git.kernel.org/netdev/net/c/b714ca2ccf6a
  - [net,V9,2/2] ptp: fix corrupted list in ptp_open
    https://git.kernel.org/netdev/net/c/1bea2c3e6df8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


