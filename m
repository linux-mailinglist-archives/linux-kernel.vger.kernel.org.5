Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ED5764515
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjG0Eud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjG0EuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8B72728;
        Wed, 26 Jul 2023 21:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7588461CD2;
        Thu, 27 Jul 2023 04:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA0A5C433CA;
        Thu, 27 Jul 2023 04:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690433419;
        bh=A8g5S1Nua2BRqzftlNe+ucpQ4lBpqepcn/KYo+LnZ+0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=c7uJPXxRw4qdxh5oeAYbrpiIylsrNrj+zwuYExkPVVDAughy7CBvC6Y7Jw2bAxlL3
         bmWCrhqPA26jiGlVe1fAuHZ6UHB4l7EhsX/siqn18XFMG9E43OLhCuFiYK+a9u/IVb
         jpEnC9Ep/caMkWOCyCsJMbSKxh9dxe2WuoFHO9qY9R0fBnbvPQ3kSCIC08Yla6JbcO
         aB0C6EKAxnZw5EEIeVA+/Ms/cQjlP+xruhbAFRNTPNeoYPS+Sv4dXelLIgl8M22knp
         +BmEleDQDxTBi7XvzuV3Oq8MPQxVSig9EOPB8Hvm7hbICI4P8/WM6xkfMvsI0Uwrb8
         itC6T/mtXuJgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0118C59A4C;
        Thu, 27 Jul 2023 04:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: qca,ar803x: add missing
 unevaluatedProperties for each regulator
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169043341971.19452.6017745582935502470.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Jul 2023 04:50:19 +0000
References: <20230725123711.149230-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230725123711.149230-1-krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 25 Jul 2023 14:37:11 +0200 you wrote:
> Each regulator node, which references common regulator.yaml schema,
> should disallow additional or unevaluated properties.  Otherwise
> mistakes in properties will go unnoticed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/qca,ar803x.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net-next] dt-bindings: net: qca,ar803x: add missing unevaluatedProperties for each regulator
    https://git.kernel.org/netdev/net-next/c/c1b0b6118b48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


