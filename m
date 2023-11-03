Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B717E00B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346998AbjKCJU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346954AbjKCJU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:20:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71B91AD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 02:20:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 938D7C433C9;
        Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699003223;
        bh=/E8aN2eqf8+9+fQQLHb6DQ5BDwl4MybdpCu0nul9xiE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Qwxr5Ynqu4Y1dPkA8/LQUHD1izqztkB/TEnEYhAf3cXEyW2dtVTph0sBvSlVWbftO
         +NgiIEQXB160wlNcoqDK59ErEkaiOEJ7KQTJjMB5ea15QN/vKx103GJ1QS/9AGRpZV
         2fEU2jpmVWPDzpzkmf1fKxsczzGUHDvHkc9CIHgkhczwEdzsrGSLauQvD1F5NJgea0
         VE/0RrCAVmgl0cqZGTu3JksVoQi1kE82wjhauGMPymhj7ml7iDFuALiCi4URApmnm1
         T9g3EmUi1K2hAy9nA3OmL3mdnZa4uu5urEOGjkDlJo3y0A6LGXNP7PbQlaCIbQIfQm
         vQmLH20WokGsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7733FE00085;
        Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Fix termination state for idr_for_each_entry_ul()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169900322348.11636.17439163150143289110.git-patchwork-notify@kernel.org>
Date:   Fri, 03 Nov 2023 09:20:23 +0000
References: <169810161336.20306.1410058490199370047@noble.neil.brown.name>
In-Reply-To: <169810161336.20306.1410058490199370047@noble.neil.brown.name>
To:     NeilBrown <neilb@suse.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        chrism@mellanox.com, xiyou.wangcong@gmail.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 24 Oct 2023 09:53:33 +1100 you wrote:
> The comment for idr_for_each_entry_ul() states
> 
>   after normal termination @entry is left with the value NULL
> 
> This is not correct in the case where UINT_MAX has an entry in the idr.
> In that case @entry will be non-NULL after termination.
> No current code depends on the documentation being correct, but to
> save future code we should fix it.
> 
> [...]

Here is the summary with links:
  - Fix termination state for idr_for_each_entry_ul()
    https://git.kernel.org/netdev/net/c/e8ae8ad479e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


