Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9151C764535
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjG0FA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjG0FAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB17E47
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 424AA61D40
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 911D9C433C8;
        Thu, 27 Jul 2023 05:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690434021;
        bh=Ho/Rc97euneW3X7+KywJSmYkbBsCi+0ii+vr0Lg7AH8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DeXwY1FAOBCm6nBgzy/dJXh8JdgAE6MaJDYvPXnQu0m8hITSNArjVrHWUSawZFKjs
         V7KIq7Ei+r+SNlTX2ALb20z7BZ+VcUZl+sTvwK7OfxQSqsj+ZnmrEFj/ep2S6V/Ope
         LWc1eru8+wSDlG0i15XwFz3M/0mp3H4xqsOVVxw/BQV4E6szKliVJ9q8WKtUuazNmN
         N0ioBB+l8u8hGME/JnUKGgeNAviCVs8DAsop2t5kO3VhoHjkOOKrF25urLF5iuFUd6
         VoI8yx6egPPBZcoSnIR16Inw5MfEXIDK091MW++8o6giBr09OSVGalK3DHoD0/f8VO
         Hk+etct+udOSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CACBC41672;
        Thu, 27 Jul 2023 05:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: dsa: Explicitly include correct DT includes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169043402150.24382.17232071139070506085.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Jul 2023 05:00:21 +0000
References: <20230724211859.805481-1-robh@kernel.org>
In-Reply-To: <20230724211859.805481-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kurt@linutronix.de, woojung.huh@microchip.com,
        UNGLinuxDriver@microchip.com, arinc.unal@arinc9.com,
        daniel@makrotopia.org, Landen.Chao@mediatek.com, dqfext@gmail.com,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, claudiu.manoil@nxp.com,
        alexandre.belloni@bootlin.com, linus.walleij@linaro.org,
        alsi@bang-olufsen.dk, george.mccollister@gmail.com,
        richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Jul 2023 15:18:58 -0600 you wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Here is the summary with links:
  - [v2] net: dsa: Explicitly include correct DT includes
    https://git.kernel.org/netdev/net-next/c/f44a90104ee5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


