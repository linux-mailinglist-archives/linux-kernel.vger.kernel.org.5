Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A5A789B91
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 08:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjH0GV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 02:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjH0GVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 02:21:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A9C183;
        Sat, 26 Aug 2023 23:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D148861BFD;
        Sun, 27 Aug 2023 06:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27B7AC433C9;
        Sun, 27 Aug 2023 06:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693117307;
        bh=6UUXpO9T2ZjC/jSRr1ot3zZfncDhgWdLHcdF5xDh8zk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FO5tXPdOEjpQmNZOqrRATWIad10KITbXuBLgewxwStt1JiDPZCd0dhDxMzc66WPxV
         yiklSu54L3pE4rHSiCdpcfV0+j1ZdKGc6DLDVpr0FPps2G4R+RUu7wilxXlyWJpize
         6kEmJAnGOliHg5rcHU5vvhJxB5HepbCR8ScvCGR65WXFUOm8U/HY+MiKAo62TeqBIX
         pnAQN+sGNzxJv1ditKAvOpny/ODkllPi176IecAYDCYjtCh9Q/mfeChQ7OUq01MWUS
         TSDLBXdBLWvMq8HE2opTzevd9JQTE8lYywNRcwawF+DM7rVkaV240dX/whs59B1E9q
         0RP6Zh6oKuV+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BB27E33083;
        Sun, 27 Aug 2023 06:21:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 0/5] Introduce IEP driver and packet timestamping support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169311730704.334.2679024548095794148.git-patchwork-notify@kernel.org>
Date:   Sun, 27 Aug 2023 06:21:47 +0000
References: <20230824114618.877730-1-danishanwar@ti.com>
In-Reply-To: <20230824114618.877730-1-danishanwar@ti.com>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     rdunlap@infradead.org, rogerq@kernel.org,
        simon.horman@corigine.com, vigneshr@ti.com, andrew@lunn.ch,
        richardcochran@gmail.com, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Thu, 24 Aug 2023 17:16:13 +0530 you wrote:
> This series introduces Industrial Ethernet Peripheral (IEP) driver to
> support timestamping of ethernet packets and thus support PTP and PPS
> for PRU ICSSG ethernet ports.
> 
> This series also adds 10M full duplex support for ICSSG ethernet driver.
> 
> There are two IEP instances. IEP0 is used for packet timestamping while IEP1
> is used for 10M full duplex support.
> 
> [...]

Here is the summary with links:
  - [v7,1/5] dt-bindings: net: Add ICSS IEP
    https://git.kernel.org/netdev/net-next/c/f0035689c036
  - [v7,2/5] dt-bindings: net: Add IEP property in ICSSG
    https://git.kernel.org/netdev/net-next/c/b12056278378
  - [v7,3/5] net: ti: icss-iep: Add IEP driver
    https://git.kernel.org/netdev/net-next/c/c1e0230eeaab
  - [v7,4/5] net: ti: icssg-prueth: add packet timestamping and ptp support
    https://git.kernel.org/netdev/net-next/c/186734c15886
  - [v7,5/5] net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support
    https://git.kernel.org/netdev/net-next/c/443a2367ba3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


