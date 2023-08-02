Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5857876C95C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjHBJU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjHBJUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BEFC3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC887618D5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47F97C433CA;
        Wed,  2 Aug 2023 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690968022;
        bh=cu5aFRwVJ/7kjFhP/oCYSGiLSpU8rxfsKLa8ggeJqWg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZXBO7mGaYccWur6Rn/Bx6PHo9QStJ5f4TwDw3dTyxAd43gA+QK5TS2p/ZW26M/Knk
         HXJVQJ2Z0cScJAxltKZRml0ULPe2o75L1o/xr9SzIHMbuBhwtnMmGVQuqP59K+r7Pu
         WY2EHPwR04U1Bpouo6riDSqiIQkhwestTqBdC2SRvKU/1FpIIlmKIXx+VUAGcIPsSc
         83xkIEqYQVO1BtzMtY3TeUXxwMBTt21GgnKgCXfIpVyXkciR1IXoxuzzsBJtxLs1B4
         x8lrGT5z0JvGXrbLKRzBBhdAfljXnp6T1qu2MyfSSMRcUNr3dElR2qy9E8x5NOEXjS
         +eyQPtd4zkmgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34041C6445A;
        Wed,  2 Aug 2023 09:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/4] Packet classify by matching against SPI
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169096802220.5600.7149545725575410006.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Aug 2023 09:20:22 +0000
References: <20230801014101.2955887-1-rkannoth@marvell.com>
In-Reply-To: <20230801014101.2955887-1-rkannoth@marvell.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        jiri@resnulli.us
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
by David S. Miller <davem@davemloft.net>:

On Tue, 1 Aug 2023 07:10:57 +0530 you wrote:
> 1.  net: flow_dissector: Add IPSEC dissector.
> Flow dissector patch reads IPSEC headers (ESP or AH) header
> from packet and retrieves the SPI header.
> 
> 2. tc: flower: support for SPI.
> TC control path changes to pass SPI field from userspace to
> kernel.
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/4] net: flow_dissector: Add IPSEC dissector
    https://git.kernel.org/netdev/net-next/c/a57c34a80cbe
  - [v1,net-next,2/4] tc: flower: support for SPI
    https://git.kernel.org/netdev/net-next/c/4c13eda757e3
  - [v1,net-next,3/4] tc: flower: Enable offload support IPSEC SPI field.
    https://git.kernel.org/netdev/net-next/c/c8915d7329d6
  - [v1,net-next,4/4] octeontx2-pf: TC flower offload support for SPI field
    https://git.kernel.org/netdev/net-next/c/73b4c04e2e9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


