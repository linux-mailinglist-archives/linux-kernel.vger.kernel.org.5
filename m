Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1927F6A10
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjKXBUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXBUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:20:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3014AD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:20:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C84BC433C9;
        Fri, 24 Nov 2023 01:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700788825;
        bh=3YNY0FGhwNjgZ9y5kYvFwAoFLUnt1fRQkW73Q8rJClU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H4eFvgwinzR4zM2mSTDkPbUdOzYjp/0A89HaFP6rfxsHPCr3Ie/Ky+sJodg+PxOwW
         MgtKfLEsw/+rsUzqhSuEh1gRSoJk3YXERVyjqV5oMzqR4rl4+l5PmZY/tMngpAE/xs
         1ppOYUMuR+PfAuNtJiGV9X8OGAFptl6M5tA/McRKZZHNerCesnkGBfTt9Adv6wKyfr
         OSn2IZd21xLx/Bp6UyYh8jSICd2pg1pbkN92K7YZyBGxrVhpb0kUjfhD5Mil+o2MG2
         1fJC4LUDk0xxWQkyKYdiCH5F8ei8BIZ+O13OpRl/PZbtOIKud4u0MEVg8qGvM4q/nT
         osAGvFWqaglzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13193C595D0;
        Fri, 24 Nov 2023 01:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v2] net: phy: correctly check soft_reset ret ONLY if
 defined for PHY
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170078882507.20317.14960769186656222790.git-patchwork-notify@kernel.org>
Date:   Fri, 24 Nov 2023 01:20:25 +0000
References: <20231121135332.1455-1-ansuelsmth@gmail.com>
In-Reply-To: <20231121135332.1455-1-ansuelsmth@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, larysa.zaremba@intel.com
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

On Tue, 21 Nov 2023 14:53:32 +0100 you wrote:
> Introduced by commit 6e2d85ec0559 ("net: phy: Stop with excessive soft
> reset").
> 
> soft_reset call for phy_init_hw had multiple revision across the years
> and the implementation goes back to 2014. Originally was a simple call
> to write the generic PHY reset BIT, it was then moved to a dedicated
> function. It was then added the option for PHY driver to define their
> own special way to reset the PHY. Till this change, checking for ret was
> correct as it was always filled by either the generic reset or the
> custom implementation. This changed tho with commit 6e2d85ec0559 ("net:
> phy: Stop with excessive soft reset"), as the generic reset call to PHY
> was dropped but the ret check was never made entirely optional and
> dependent whether soft_reset was defined for the PHY driver or not.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: correctly check soft_reset ret ONLY if defined for PHY
    https://git.kernel.org/netdev/net-next/c/aadbd27f9674

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


