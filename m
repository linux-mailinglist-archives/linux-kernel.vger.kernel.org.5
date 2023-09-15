Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6457A1F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbjIONAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbjIONAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:00:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186EAA8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:00:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9B86C433D9;
        Fri, 15 Sep 2023 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694782826;
        bh=xqj4QRqO55KywEoX85nsOwjXLp4zs8awExP+e9hTfw0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=r2vvDkgOcTnfhCa6pwsvekB2TPv8uQQx1JSHYnKpR8+8dsFOOnZZ3SPJitEYx64ac
         /+ACzjUGYafLevq74JPFr/LIfkeKtlAIReWdBIG55dcIuCUrGE7dA131iB7lxNwnMs
         vY6iA0nujDJFXt1RRR6u8A6eo896sxSGl70uTTW+S4YC4M0lAIHB2XLTXbVqLfiXQb
         O4GMv/hzKsA3EIVPPSzdieAHGLjR97O0P43zrH8J5bj8jp/71P8NR89UW+YzMRtbBC
         pH9VqasJrdlqdx8MSHv3U+lcE3gvfyDyP5m+tCQtSXbYxkGDC5K40UpFhj+Z/ZSiXH
         ToaFP6ZWe76tQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9643EE22AEE;
        Fri, 15 Sep 2023 13:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] Add Half Duplex support for ICSSG Driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169478282660.10241.3855414468809647924.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Sep 2023 13:00:26 +0000
References: <20230913091011.2808202-1-danishanwar@ti.com>
In-Reply-To: <20230913091011.2808202-1-danishanwar@ti.com>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     andrew@lunn.ch, rogerq@ti.com, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, vigneshr@ti.com, horms@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
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

On Wed, 13 Sep 2023 14:40:09 +0530 you wrote:
> This series adds support for half duplex operation for ICSSG driver.
> 
> In order to support half-duplex operation at 10M and 100M link speeds, the
> PHY collision detection signal (COL) should be routed to ICSSG GPIO pin
> (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal and apply
> the CSMA/CD algorithm applicable for half duplex operation. A DT property,
> "ti,half-duplex-capable" is introduced for this purpose in the first patch
> of the series. If board has PHY COL pin conencted to PRGx_PRU1_GPIO10,
> this DT property can be added to eth node of ICSSG, MII port to support
> half duplex operation at that port.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] dt-bindings: net: Add documentation for Half duplex support.
    https://git.kernel.org/netdev/net-next/c/927c568d6212
  - [net-next,v3,2/2] net: ti: icssg-prueth: Add support for half duplex operation
    https://git.kernel.org/netdev/net-next/c/0a205f0fe8dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


