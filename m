Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1BD7E8C5E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 20:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjKKTwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 14:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjKKTwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 14:52:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA3E385F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 11:51:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 043A8C433CB;
        Sat, 11 Nov 2023 19:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699732318;
        bh=kMgwL6cTB03XK32KetgmN3BkF483jEjd+jRzvnJeMmE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dc3w/pDkeygruWNLWcZ3r6ddONQVkasoj4IVP2cvBKKYgRf2XvlS7Fr5/HqpY51jj
         l8X2sUc9Sm8sAB5U6x3nOzy1A8K8W2wvmbBYpRSBM3AKWUzJDpSjLHHNOapJr8cMs5
         13glumUVEUFEBvcoaIr9Na+3IOVIYCBSk3J7352P1/rxebI3QsvVG3zXPePxlCy1UH
         WMmyclBxsLAdSY7+RmcTskirvndDQ4dYrv9xoXmFnxRQHQE0O4KuWJCimjfHDB/iW1
         geiA+r+9Pp3UbXGcVViay3XeA0Np02wJfRfEv9auaEDLZtRKW6cIjJfyWwiMhzgptU
         XTZF9wxPAv06Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE315E00083;
        Sat, 11 Nov 2023 19:51:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: ti: icssg-prueth: Add missing icss_iep_put to
 error path
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169973231790.11806.9879405241139030767.git-patchwork-notify@kernel.org>
Date:   Sat, 11 Nov 2023 19:51:57 +0000
References: <7a4e5c5b-e397-479b-b1cb-4b50da248f21@siemens.com>
In-Reply-To: <7a4e5c5b-e397-479b-b1cb-4b50da248f21@siemens.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, danishanwar@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, diogo.ivo@siemens.com, nm@ti.com,
        baocheng.su@siemens.com, wojciech.drewek@intel.com,
        rogerq@kernel.org
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

On Fri, 10 Nov 2023 17:13:02 +0100 you wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Analogously to prueth_remove, just also taking care for NULL'ing the
> iep pointers.
> 
> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Fixes: 443a2367ba3c ("net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> 
> [...]

Here is the summary with links:
  - [net,v4] net: ti: icssg-prueth: Add missing icss_iep_put to error path
    https://git.kernel.org/netdev/net/c/e409d7346648

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


