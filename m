Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C6975334A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjGNHk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjGNHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1927C2D75
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9772261C37
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6BB5C433C9;
        Fri, 14 Jul 2023 07:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689320421;
        bh=2Pu8AZKXPQyErrJn8SAB2LYoI0Xe1043MMv6vJSeFqo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ho4jqT8XdIepn2AGe+YL6a2HyoWek41IKWkh6SVMqD4wGYZuRdUeacXXg/JODrWjx
         lqZPucdCdk0jy0gKt8eyGYMRcd45zwov+DEnM8o8qUolLMDPWis6jSrSakqK1B1hHt
         Ynur3C0l2kXz2ghHjda/ZZDuDAh1nmOjRTPv0xKfz5c6MNsus1i/WcrWrNEOk/B53h
         h511Q2xgmCPP4hQGpSsa8ccQhiv04LZszp5dNcrNuZ3PZ0NSNxCBdsRAPNL1rYZpa3
         TXo7wngFNL2MdvcqQp4q8ytm2LFzFjAtSfZbu1R/eS8Hc/UmEgZNP05Hejyl05xojy
         rzpQ+DwASlxMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C555FE4508F;
        Fri, 14 Jul 2023 07:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: ar9331: Use explict flags for regmap single
 read/write
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168932042079.7517.10211211896014478722.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Jul 2023 07:40:20 +0000
References: <20230712-net-at9331-regmap-v1-1-ebe66e81ed83@kernel.org>
In-Reply-To: <20230712-net-at9331-regmap-v1-1-ebe66e81ed83@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, 12 Jul 2023 12:16:16 +0100 you wrote:
> The at9331 is only able to read or write a single register at once.  The
> driver has a custom regmap bus and chooses to tell the regmap core about
> this by reporting the maximum transfer sizes rather than the explicit
> flags that exist at the regmap level.  Since there are a number of
> problems with the raw transfer limits and the regmap level flags are
> better integrated anyway convert the driver to use the flags.
> 
> [...]

Here is the summary with links:
  - net: dsa: ar9331: Use explict flags for regmap single read/write
    https://git.kernel.org/netdev/net/c/9845217d60d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


