Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF1B7CFF29
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345591AbjJSQKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345102AbjJSQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:10:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D09E112;
        Thu, 19 Oct 2023 09:10:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1016C433CA;
        Thu, 19 Oct 2023 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697731824;
        bh=ZSHnlwGKVf0pTTc0ZzD9hgMl3t8ZCUhEI3/eJiY4aFQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g58PwMQZnJ4RJRiO8+msu58Y6jNJM9gZ3qsxvkA+6vQIFHiWzFHQQOIZxVuCWBrFR
         5Dtsl2Zf05Y4rwNHAyL9m2zN+PY9HDSs0NHl71IMKtAhzpdXc3HaNx0scB1fp04qxX
         brDITEHGT8UEBpqrIuZ7EiKyvTYeRFEH9t6WKc+n708rud1MlD9zsWPmqErjz6jlKs
         l8l+Jzk4NhPjURhEVmFfUwUX+eVb0x2+CbChHH6GVYEA1sb1HuPpN9Fz4mjCK7Wcft
         +UYvJSvS7rNgu5Hcs3ocbdlgU54v0aSXBHNcZqZSjwOwWNMVe6A3n+JIeK1nr8uPfM
         QYn7P3uPixRpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDDF7C04E27;
        Thu, 19 Oct 2023 16:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] dt-bindings: net: Child node schema cleanups
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169773182376.32102.12284978532277554063.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Oct 2023 16:10:23 +0000
References: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
In-Reply-To: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, andrew@lunn.ch, f.fainelli@gmail.com,
        olteanv@gmail.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, woojung.huh@microchip.com,
        UNGLinuxDriver@microchip.com, linus.walleij@linaro.org,
        alsi@bang-olufsen.dk, clement.leger@bootlin.com,
        geert+renesas@glider.be, magnus.damm@gmail.com, mripard@kernel.org,
        arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
        sean.wang@mediatek.com, daniel@makrotopia.org, john@phrozen.org,
        gerhard@engleder-embedded.com, hkallweit1@gmail.com,
        s.shtylyov@omp.ru, sergei.shtylyov@gmail.com,
        justin.chen@broadcom.com, florian.fainelli@broadcom.com,
        grygorii.strashko@ti.com, nsekhar@ti.com, claudiu.manoil@nxp.com,
        alexandre.belloni@bootlin.com, vladimir.oltean@nxp.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Oct 2023 16:44:19 -0500 you wrote:
> This is a series of clean-ups related to ensuring that child node
> schemas are constrained to not allow undefined properties. Typically,
> that means just adding additionalProperties or unevaluatedProperties as
> appropriate. The DSA/switch schemas turned out to be a bit more
> involved, so there's some more fixes and a bit of restructuring in them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] dt-bindings: net: Add missing (unevaluated|additional)Properties on child node schemas
    https://git.kernel.org/netdev/net-next/c/659fd097b098
  - [net-next,2/8] dt-bindings: net: renesas: Drop ethernet-phy node schema
    https://git.kernel.org/netdev/net-next/c/ac8fe40c3628
  - [net-next,3/8] dt-bindings: net: dsa/switch: Make 'ethernet-port' node addresses hex
    https://git.kernel.org/netdev/net-next/c/51ff5150258a
  - [net-next,4/8] dt-bindings: net: ethernet-switch: Add missing 'ethernet-ports' level
    https://git.kernel.org/netdev/net-next/c/f0fdec925fe7
  - [net-next,5/8] dt-bindings: net: ethernet-switch: Rename $defs "base" to 'ethernet-ports'
    https://git.kernel.org/netdev/net-next/c/b9823df7bbad
  - [net-next,6/8] dt-bindings: net: mscc,vsc7514-switch: Clean-up example indentation
    https://git.kernel.org/netdev/net-next/c/491ec40d67a5
  - [net-next,7/8] dt-bindings: net: mscc,vsc7514-switch: Simplify DSA and switch references
    https://git.kernel.org/netdev/net-next/c/7c93392d754e
  - [net-next,8/8] dt-bindings: net: dsa: Drop 'ethernet-ports' node properties
    https://git.kernel.org/netdev/net-next/c/31f47f303c6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


