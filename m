Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A087D66CE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjJYJab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjJYJa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:30:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B97CCE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:30:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C00AAC433C8;
        Wed, 25 Oct 2023 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698226227;
        bh=gi1MycaQsEeSaHkP57k8UHrhNqbz6x8s67hLvq+/I8A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=F16v3tWs0pv3CMlH6zWzWC2AX4TuxMogR0bRdIPk/QXymkUwUy+LOhYSZW3m8e8Td
         6slAALoKaOR3L2pl6pIfwQ1VLvGAigigsnSTNpZJHPbO7MaS4h3g9coryPVdXs0B17
         4LAmxdjgnIXZQpfX+eaOFb7P22ldnVgSCi882ULj5bnGAeV0eKPBQQPVZ/52j9Q8z1
         F8dt+BNfU/O+1Wl3BXIoAJyxKWm1Q8COJ0/NATV4iMj04wdqJagIRpoAy6PJ/SMvmK
         V/EFAfpGBxU+AuuM1GaimupHdKsjBBEofRT5wQYOFPdBpUvQPDIfNirvhZ6iWpZbxC
         M4yKKd20k+/Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7C89E11F56;
        Wed, 25 Oct 2023 09:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/7] Create a binding for the Marvell MV88E6xxx
 DSA switches
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169822622768.10826.14051215485905127447.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Oct 2023 09:30:27 +0000
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kabel@kernel.org, ansuelsmth@gmail.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        robh@kernel.org, vladimir.oltean@nxp.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 24 Oct 2023 15:20:26 +0200 you wrote:
> The Marvell switches are lacking DT bindings.
> 
> I need proper schema checking to add LED support to the
> Marvell switch. Just how it is, it can't go on like this.
> 
> Some Device Tree fixes are included in the series, these
> remove the major and most annoying warnings fallout noise:
> some warnings remain, and these are of more serious nature,
> such as missing phy-mode. They can be applied individually,
> or to the networking tree with the rest of the patches.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/7] dt-bindings: net: dsa: Require ports or ethernet-ports
    https://git.kernel.org/netdev/net-next/c/b5ef61718ad7
  - [net-next,v7,2/7] dt-bindings: net: mvusb: Fix up DSA example
    https://git.kernel.org/netdev/net-next/c/ddae07ce9bb3
  - [net-next,v7,3/7] ARM: dts: marvell: Fix some common switch mistakes
    https://git.kernel.org/netdev/net-next/c/2b83557a588f
  - [net-next,v7,4/7] ARM: dts: nxp: Fix some common switch mistakes
    https://git.kernel.org/netdev/net-next/c/bfedd8423643
  - [net-next,v7,5/7] ARM64: dts: marvell: Fix some common switch mistakes
    https://git.kernel.org/netdev/net-next/c/605a5f5d406d
  - [net-next,v7,6/7] dt-bindings: marvell: Rewrite MV88E6xxx in schema
    https://git.kernel.org/netdev/net-next/c/0f35369b4efe
  - [net-next,v7,7/7] dt-bindings: marvell: Add Marvell MV88E6060 DSA schema
    https://git.kernel.org/netdev/net-next/c/53313ed25ba8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


