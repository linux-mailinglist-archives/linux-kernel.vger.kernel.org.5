Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D986D7A5E91
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjISJuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjISJu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:50:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525D7F0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA440C433C9;
        Tue, 19 Sep 2023 09:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695117022;
        bh=KqFckHRW1wemRtJKOBzu5za3YKLNJkw8oPNLBCYuEZE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GLEGCyd2BmZYiL3qzQ/quWB8FUs0WW7m8DUEccQsns7zXAnisBCnRZKEPQ0WkXer5
         SEVjkFX951BHnn/3QXR/X6aW9wdlPty9DuveRai0DP0Sx6O6+B+4KIxrMSXdkf2cfe
         wOH6qGFEtniT4Kb/+poONSfvWbcUZwjB9aSSqNIk+KE7ZepQCbH4LuFIqRb44bbtZX
         UI2eJRPk0MRpWYM5O91R7rW3sPPVfediaTlA3vsnu9k4PzCam25ceEmPsnrGuNUjP8
         rYBml52xy9OgErAPkGpid4SZCmxsriRYxekcLA+wTOSYeGqEiTIezk722Qf4gGuPRR
         z4+9UsTFhMKhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C01E1E11F41;
        Tue, 19 Sep 2023 09:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeon_ep: restructured interrupt handlers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169511702277.19851.5148115335209264246.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Sep 2023 09:50:22 +0000
References: <20230918065621.2165449-1-srasheed@marvell.com>
In-Reply-To: <20230918065621.2165449-1-srasheed@marvell.com>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
        vimleshk@marvell.com, vburru@marvell.com, sedara@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 17 Sep 2023 23:56:21 -0700 you wrote:
> Separated queue specific interrupts to register to individual msix-vectors
> instead of using a single generic interrupt handler on a single
> msix-vector.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
>  .../marvell/octeon_ep/octep_cn9k_pf.c         | 158 ++++++++++----
>  .../ethernet/marvell/octeon_ep/octep_main.c   | 197 +++++++++++++++++-
>  .../ethernet/marvell/octeon_ep/octep_main.h   |  13 +-
>  3 files changed, 323 insertions(+), 45 deletions(-)

Here is the summary with links:
  - [net-next] octeon_ep: restructured interrupt handlers
    https://git.kernel.org/netdev/net-next/c/0b8ef824eede

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


