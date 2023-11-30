Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F047FE7CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbjK3DuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjK3DuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:50:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A824210C6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 19:50:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47281C433C8;
        Thu, 30 Nov 2023 03:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701316227;
        bh=4zckGJFRAzH37LrC9gfAOndOwF53u3FwhjhwYgqH29k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Vgh67kEMaTt/ndXRM3pm5AEt8elRemi7fqw66sfxwVMKDTbj+udWj/fKNX5uAqubT
         /f4mMllVDKtHRLH/YVmtbWOQewfLsI+YnpX1lsovn/VqoKmhDPa5M3xIznD+nQOAd0
         XuesJ8s8tDArL4CYrYRuSjrFiB17LFF3waFF5Er658S/VL2QNj3Er6cdapDm+fA7j3
         eAZ3EHAFcnidOwbzIMuVXT3bwfHz3zai07pb/CztprqVSobYqRqzN3TR61/qirEcix
         eCyAy/EaERPfhFsOadWHMYdo84gbCncXJHe2B02PdoXp0n7AY6RoP7Pu1zGSmAKPMi
         ay8+B2fI5XcQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F3FBE00090;
        Thu, 30 Nov 2023 03:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/5] Create a binding for the Marvell MV88E6xxx
 DSA switches
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170131622718.14621.9765816710568948685.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Nov 2023 03:50:27 +0000
References: <20231127-marvell-88e6152-wan-led-v9-0-272934e04681@linaro.org>
In-Reply-To: <20231127-marvell-88e6152-wan-led-v9-0-272934e04681@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kabel@kernel.org, ansuelsmth@gmail.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        robh@kernel.org, florian.fainelli@broadcom.com,
        krzysztof.kozlowski@linaro.org, vladimir.oltean@nxp.com
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Nov 2023 16:43:03 +0100 you wrote:
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
  - [net-next,v9,1/5] dt-bindings: net: dsa: Require ports or ethernet-ports
    https://git.kernel.org/netdev/net-next/c/fbb7033b76eb
  - [net-next,v9,2/5] dt-bindings: net: mvusb: Fix up DSA example
    https://git.kernel.org/netdev/net-next/c/a6e44f3028e7
  - [net-next,v9,3/5] dt-bindings: net: ethernet-switch: Accept special variants
    https://git.kernel.org/netdev/net-next/c/f45c197465ed
  - [net-next,v9,4/5] dt-bindings: marvell: Rewrite MV88E6xxx in schema
    https://git.kernel.org/netdev/net-next/c/43915b2f4bb9
  - [net-next,v9,5/5] dt-bindings: marvell: Add Marvell MV88E6060 DSA schema
    https://git.kernel.org/netdev/net-next/c/017ca9c9f310

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


