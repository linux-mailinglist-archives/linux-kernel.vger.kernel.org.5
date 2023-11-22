Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEAE7F4484
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343668AbjKVLAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjKVLA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:00:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE0619E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:00:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4713FC433CC;
        Wed, 22 Nov 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700650824;
        bh=JwVuGcTmcYQlehqkotnDdbNmcVl+I34uPSQBTDYYs50=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZyvBS9R7eanca9Q6HLRtgVZv6n0phhRtjhUFg4VoDOZRR73Px+fqunAHVW2ZE/gWt
         Dc3wHMP9VN8k0RYCUk+hCmOs++6XH8BebIiz+E9V8X4UhBtj2kczKRtSqOvV68HNgo
         D24zU2vZlJmz3t/+pd9YRX2HF0LDb1R8lK+IItf1icMUD9zUPZNHepyejU6tI17Pe7
         +rUsvzo7EiPqfGGZRfWbo1i37TRFmhTLjyA0XpUZ/5FWj5gAH6BE47HfeN77p+L8ju
         2uTQTT8ZkeVRdLVnd5Gk2LRykB2nhVsGDi63UmEYV/UintxUUbeDmo7PDsFNjXD5sS
         7LRsGxSObFQnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30E9DC3959E;
        Wed, 22 Nov 2023 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: hsr: Add support for MC filtering at the
 slave device
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170065082419.4259.7747506565091490593.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Nov 2023 11:00:24 +0000
References: <20231121053753.32738-1-r-gunasekaran@ti.com>
In-Reply-To: <20231121053753.32738-1-r-gunasekaran@ti.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, wojciech.drewek@intel.com,
        bigeasy@linutronix.de, horms@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, srk@ti.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 21 Nov 2023 11:07:53 +0530 you wrote:
> From: Murali Karicheri <m-karicheri2@ti.com>
> 
> When MC (multicast) list is updated by the networking layer due to a
> user command and as well as when allmulti flag is set, it needs to be
> passed to the enslaved Ethernet devices. This patch allows this
> to happen by implementing ndo_change_rx_flags() and ndo_set_rx_mode()
> API calls that in turns pass it to the slave devices using
> existing API calls.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: hsr: Add support for MC filtering at the slave device
    https://git.kernel.org/netdev/net-next/c/36b20fcdd966

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


