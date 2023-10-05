Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716D17BA623
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbjJEQ1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242395AbjJEQXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:23:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB1C10C9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:20:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50B2CC433CA;
        Thu,  5 Oct 2023 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696522827;
        bh=21g5xz0Da1JHH17XeEyv4z7OGB8N7Nj5S+gSzpgTHOA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LXq+cjtvUMugPEboV5qjiew9XatnLE7f6uzYJBL1B3YjdJci5FVlkwxg/Lx9tudZZ
         4KIfEjN41jjrD10U4dX79BzOHjBz55HPbAYgci97wiZnD3DrmMocqPXv6fyPNl6NjK
         F8cVegL9C/UkJvg641Dwc988SqupZAe24rOEDlwqYXo76fHzlN1HqmnZcoDg0gOjBW
         cfJj2uIH6nUezZp21jRocrI+ciHe+iP8c4LVjiJDZr6mrhN4FNYPRtZy5lLkC35/FJ
         NJjPPhVsBq7rE/1J7qPhQiHYjEA8AxvAYmj986OtwBcCsjzNy+euhUDF20LlALxZ6A
         hgw1olFUhogBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 346CDE11F50;
        Thu,  5 Oct 2023 16:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: lan743x: also select PHYLIB
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169652282721.14786.14487988434819506172.git-patchwork-notify@kernel.org>
Date:   Thu, 05 Oct 2023 16:20:27 +0000
References: <20231002193544.14529-1-rdunlap@infradead.org>
In-Reply-To: <20231002193544.14529-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com,
        bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        horms@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
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

On Mon,  2 Oct 2023 12:35:44 -0700 you wrote:
> Since FIXED_PHY depends on PHYLIB, PHYLIB needs to be set to avoid
> a kconfig warning:
> 
> WARNING: unmet direct dependencies detected for FIXED_PHY
>   Depends on [n]: NETDEVICES [=y] && PHYLIB [=n]
>   Selected by [y]:
>   - LAN743X [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && PCI [=y] && PTP_1588_CLOCK_OPTIONAL [=y]
> 
> [...]

Here is the summary with links:
  - [v2] net: lan743x: also select PHYLIB
    https://git.kernel.org/netdev/net/c/566aeed6871a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


