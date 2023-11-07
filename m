Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09C77E4B9A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjKGWU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKGWU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:20:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D16101
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:20:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D131C433C8;
        Tue,  7 Nov 2023 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699395625;
        bh=u5ZRGxzcwj01x84zTuvGZgszUEpJS89vsjD7KAezq/0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tSykE0H1u85coMDP5Xdy7J+bUXexqNZl9lXvjN4C3ejZPCKZyufiIkyYyBUp6Yba9
         7cnAkDmNNS0shN5P/W9v9Y58NxjNlUqwZFJ9iwmpcLSyaooyVv6uYrnxBON+TK+H2r
         8WI63hGGbFe5J1hMZWqOUNh7F01rzu85LLu1sg3T2t/g/o144LVx5bBSia4TVKNkSa
         YpBMF6FTZIi0Jb2MjAxFe0TefPkjxefF3KB4XVinSLrEKJVnUBFsx2pkkspVlH5Uo3
         0vCOUcn1TXUAy+hTPEpsvNiWM2Edga3lhwc7ySqsPUjhQRidKLP/4Yzv48EQONhvS3
         TFYR29OVTa5pA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E71C0E00083;
        Tue,  7 Nov 2023 22:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] tg3: Fix the TX ring stall
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169939562494.24931.8185977865842706438.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Nov 2023 22:20:24 +0000
References: <20231105185828.287004-1-alexey.pakhunov@spacex.com>
In-Reply-To: <20231105185828.287004-1-alexey.pakhunov@spacex.com>
To:     Alex Pakhunov <alexey.pakhunov@spacex.com>
Cc:     mchan@broadcom.com, vincent.wong2@spacex.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        siva.kallam@broadcom.com, prashant@broadcom.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 5 Nov 2023 10:58:28 -0800 you wrote:
> From: Alex Pakhunov <alexey.pakhunov@spacex.com>
> 
> The TX ring maintained by the tg3 driver can end up in the state, when it
> has packets queued for sending but the NIC hardware is not informed, so no
> progress is made. This leads to a multi-second interruption in network
> traffic followed by dev_watchdog() firing and resetting the queue.
> 
> [...]

Here is the summary with links:
  - [v3] tg3: Fix the TX ring stall
    https://git.kernel.org/netdev/net/c/c542b39b607d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


