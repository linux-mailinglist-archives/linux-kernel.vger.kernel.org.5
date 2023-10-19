Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C1C7CED36
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjJSBK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJSBKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:10:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86E6112
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:10:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65A7CC433C9;
        Thu, 19 Oct 2023 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697677822;
        bh=DuRZTW1jUGcKtWP2D9yELL1QF6dKAc3J3NvjrvptXIg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YGAZ5CIxxxirAzntx+kYQFhHqr5iChT7+uyX/EpHZV3Mtdu+4eYSkPa7eTr3d+Azq
         dPGWsy2upJH6aDKRGtbUeerDaHTJCl7ju5gYPzd2VVMP6Uy0QzPgULOf/ukS4oy/5g
         IKHBZt5IPS5zX47H8E87Jkd/BrZw8wTvwEwY/9sTud40hBMPf5ZBiEygq0t1YgNdNi
         dQPTIe0mgdSyHL5faGbinpSLyapwMrTd5YS216IiC/vwKWpnNuk1G51AtYXoWhx0jC
         SA2Eqgg8Joqn6fWJzYzhFnz8QAkGCvZrQMSOB+8r8oivISVMG6LPh40S9YHKTNDbXD
         4lB/G4jHf/9zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49C5BC04E24;
        Thu, 19 Oct 2023 01:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] octeon_ep: update BQL sent bytes before ringing
 doorbell
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169767782229.12246.9567863592297090528.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Oct 2023 01:10:22 +0000
References: <20231017105030.2310966-1-srasheed@marvell.com>
In-Reply-To: <20231017105030.2310966-1-srasheed@marvell.com>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     kuba@kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
        davem@davemloft.net, edumazet@google.com, egallen@redhat.com,
        hgani@marvell.com, mschmidt@redhat.com, netdev@vger.kernel.org,
        sedara@marvell.com, vburru@marvell.com, vimleshk@marvell.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Oct 2023 03:50:30 -0700 you wrote:
> Sometimes Tx is completed immediately after doorbell is updated, which
> causes Tx completion routing to update completion bytes before the
> same packet bytes are updated in sent bytes in transmit function, hence
> hitting BUG_ON() in dql_completed(). To avoid this, update BQL
> sent bytes before ringing doorbell.
> 
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] octeon_ep: update BQL sent bytes before ringing doorbell
    https://git.kernel.org/netdev/net/c/a0ca6b9dfef0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


