Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A1E7D22A1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjJVKa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVKaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:30:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A792C9;
        Sun, 22 Oct 2023 03:30:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 958A4C433C9;
        Sun, 22 Oct 2023 10:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697970622;
        bh=6xL+0SSS+UK7MN+C6MYW1SWdb1d9d2XhbURiRwzUbTE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FNb4P44wXSqQ+8vhVQKlhAidx27Qhq3AvYcBuxBb/mmPjVn39E9T6uTjHk0Cf/aey
         6wD6mV0LC7a0Nia4D9qYLAyTk5n/ZJrIUlKw1lRfJVLcqaIgHZl6qAOFo6kGT3cC4b
         Ng3uGlbxLi0T8zzDyd/GOWA/RQPOGXh76RiR1lfnPvTCIepQ1fT4CEKaTL+yXrBcVe
         F+qWPkvbtXQV8PQMAI5bRCXfmNRT3t9wojoAcloP0os7Xinfuphb4zhwzVrXRMaHVS
         ONdB9jQDAa5k6fy3VHJALXkhcbqRgA0zItCbeMjQ1cIpgBe2BAWKHF8vpAY3j5jsvB
         PXbmkda1fr/aA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78742C691E1;
        Sun, 22 Oct 2023 10:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ieee802154: adf7242: Fix some potential buffer
 overflow in adf7242_stats_show()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169797062249.27139.6002805362086894264.git-patchwork-notify@kernel.org>
Date:   Sun, 22 Oct 2023 10:30:22 +0000
References: <7ba06db8987298f082f83a425769fe6fa6715fe7.1697911385.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <7ba06db8987298f082f83a425769fe6fa6715fe7.1697911385.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     keescook@chromium.org, michael.hennerich@analog.com,
        alex.aring@gmail.com, stefan@datenfreihafen.org,
        miquel.raynal@bootlin.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        marcel@holtmann.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        stefan@osg.samsung.com, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Sat, 21 Oct 2023 20:03:53 +0200 you wrote:
> strncat() usage in adf7242_debugfs_init() is wrong.
> The size given to strncat() is the maximum number of bytes that can be
> written, excluding the trailing NULL.
> 
> Here, the size that is passed, DNAME_INLINE_LEN, does not take into account
> the size of "adf7242-" that is already in the array.
> 
> [...]

Here is the summary with links:
  - [net] net: ieee802154: adf7242: Fix some potential buffer overflow in adf7242_stats_show()
    https://git.kernel.org/netdev/net/c/ca082f019d8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


