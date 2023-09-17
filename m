Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A122A7A35B0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 15:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjIQNae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 09:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjIQNac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 09:30:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40F1131
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 06:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 715C0C433C7;
        Sun, 17 Sep 2023 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694957427;
        bh=pF02AHZ82eZiKHq52bV+zJKRphKfFVcJLjrf21UaCeo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BrmbLoepHO6JfjEOo1mQBGS3OEmH66r61AI6ma0yZtnmN5jSd77WaVn9heLe4WDoI
         Kd0JWFgN4PTgmBLHIFJatONcH7rBr1tC5m6oEeOCOy3tVJdyTzCwEVeiqKxoeSyQt9
         ae+5zKwHlkK5uGGGFIxuaTrfA94J8WPl66RneqaxluEtxnfwfz2cVp3djE4zZjBB26
         INYdR3iS2jGDSjbYL6zZ2egWultRf+npJL01vPnNUDZNSo0J6QeSMg/KMinQamGAQM
         Q5RBlmvASG1KkRzo88WeJoiIIGdhunGIwd6pRVmu+PzxlJAWRB0WFKm+UX0a2eY/R6
         7ywwaqI5rVOwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54E92E26880;
        Sun, 17 Sep 2023 13:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: dsa: microchip: Move *_port_setup code to
 dsa_switch_ops::port_setup()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169495742734.23476.17293099132297430994.git-patchwork-notify@kernel.org>
Date:   Sun, 17 Sep 2023 13:30:27 +0000
References: <20230914131145.23336-1-o.rempel@pengutronix.de>
In-Reply-To: <20230914131145.23336-1-o.rempel@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
        f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com,
        olteanv@gmail.com, woojung.huh@microchip.com,
        arun.ramadoss@microchip.com, linux@armlinux.org.uk,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        petrm@nvidia.com, lukma@denx.de
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Sep 2023 15:11:44 +0200 you wrote:
> Right now, the *_port_setup code is in dsa_switch_ops::port_enable(),
> which is not the best place for it. This patch moves it to a more
> suitable place, dsa_switch_ops::port_setup(), to match the function's
> purpose and name.
> 
> This patch is a preparation for coming ACL support patch.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: dsa: microchip: Move *_port_setup code to dsa_switch_ops::port_setup()
    https://git.kernel.org/netdev/net-next/c/152992279e41
  - [net-next,2/2] net: dsa: microchip: Add partial ACL support for ksz9477 switches
    https://git.kernel.org/netdev/net-next/c/002841be134e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


