Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C1777B241
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjHNHUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbjHNHUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:20:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD86E77;
        Mon, 14 Aug 2023 00:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0208F63579;
        Mon, 14 Aug 2023 07:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 563BAC43391;
        Mon, 14 Aug 2023 07:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691997622;
        bh=Sk/MwmfdtPqlWCnzyKRYQGPjeiANNitkM94nFXMS1xo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=d+5t1PoC4mXgA12Yrr7mDxD7e0CpGoGbQ01Pl+KkXA2aMNPwmE/Y4GDZ4AinU9op1
         MyiF7yFW/nNGT3tiN0+cD0XwQ6Ddi4mWwRXKrkzpZFzEW1+2Qvw/f3D6PCSXld4hCx
         UZQCo2f8mmjLjqTyoMBIrZFio5Ugx/6OxgTqe3BJoWtXzAumqY44xtRpiPA01FFcei
         bPkQmsyXyr6vd2Zl6r06txo2+aINlEfyMhn8iYoFShtw4NAp7V0B/yD6ZYQMB3NhYP
         kgM9MsxA1EUdLvGxo+JBscHc7p90hRFhp5jffcxg4+RLfZWq8Q89QKs3f9gzwj9VtE
         C4Torl2DsqMnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35928C395C5;
        Mon, 14 Aug 2023 07:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: ethernet-controller: add
 PSGMII mode
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169199762221.17065.4040096090781040409.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Aug 2023 07:20:22 +0000
References: <20230811111032.231308-1-robert.marko@sartura.hr>
In-Reply-To: <20230811111032.231308-1-robert.marko@sartura.hr>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        corbet@lwn.net, netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        luka.perkov@sartura.hr, robh@kernel.org
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

On Fri, 11 Aug 2023 13:10:06 +0200 you wrote:
> Add a new PSGMII mode which is similar to QSGMII with the difference being
> that it combines 5 SGMII lines into a single link compared to 4 on QSGMII.
> 
> It is commonly used by Qualcomm on their QCA807x PHY series.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Acked-by: Rob Herring <robh@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] dt-bindings: net: ethernet-controller: add PSGMII mode
    https://git.kernel.org/netdev/net-next/c/de875d35e0b0
  - [net-next,v2,2/2] net: phy: Introduce PSGMII PHY interface mode
    https://git.kernel.org/netdev/net-next/c/83b5f0253b1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


