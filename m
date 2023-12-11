Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D4580C603
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbjLKKKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjLKKKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:10:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFEFD5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:10:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A75D4C433C9;
        Mon, 11 Dec 2023 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702289423;
        bh=25mXoOKe5YalTwcXvBl99nBaqvQHsxcaUzjVVE/yeuU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fTvz/BYDTgmZ9jp8/k3fD7Th9vc2p2jkWHouz6/UlWepwRNbpFWJqqZq81KiWkhzf
         7mVlSHZlGeDH7m9sRZHBzSgaFSwS/syAEOWPvH5EB3EsnsOAjo/cs3n6KhT85yYeWo
         GrU3h8//SmNHLfX1MLSafKdCkotjO6FrPWFMNoZfWhWBvPqx/1dwqfivWqpvUmgwSX
         vBjDIxX3+qo35HX6R+0WRxGWcL1AaGhyrJ5V+Vha+cf4e7kJ11FV4IHk6QnbVxySOA
         U+wDJe2GRM3rhoeZnYfUiHEaXWtkJlvLB61UGg2KhWYu/KCBAktJ6Ro1UroD6fOyns
         nPb6Hh35wK9SQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D6F0DFC906;
        Mon, 11 Dec 2023 10:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] octeon_ep: explicitly test for firmware ready value
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170228942357.26769.14270472436980157327.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Dec 2023 10:10:23 +0000
References: <20231208055646.2602363-1-srasheed@marvell.com>
In-Reply-To: <20231208055646.2602363-1-srasheed@marvell.com>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, egallen@redhat.com,
        mschmidt@redhat.com, pabeni@redhat.com, horms@kernel.org,
        kuba@kernel.org, davem@davemloft.net, wizhao@redhat.com,
        konguyen@redhat.com, vburru@marvell.com, sedara@marvell.com,
        edumazet@google.com, aayarekar@marvell.com, sburla@marvell.com
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

On Thu, 7 Dec 2023 21:56:46 -0800 you wrote:
> The firmware ready value is 1, and get firmware ready status
> function should explicitly test for that value. The firmware
> ready value read will be 2 after driver load, and on unbind
> till firmware rewrites the firmware ready back to 0, the value
> seen by driver will be 2, which should be regarded as not ready.
> 
> Fixes: 10c073e40469 ("octeon_ep: defer probe if firmware not ready")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] octeon_ep: explicitly test for firmware ready value
    https://git.kernel.org/netdev/net/c/284f71762241

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


