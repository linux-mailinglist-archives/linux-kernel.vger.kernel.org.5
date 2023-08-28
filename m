Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D26778A88F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjH1JLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjH1JKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:10:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF9A132
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44DBB634AE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CD02C433CA;
        Mon, 28 Aug 2023 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693213822;
        bh=+wWRJuF6zpwzycLF5hMliLOvycFkNHXy2NQX6pDQBzs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LQ8fbqC6qI8HnljwBTWWBzWF9gyo1SYGjSXx9dt9C8cu80am2qP6+PlU67Mh92SOq
         xSOEoktSPWY+I3xT1dpYuJAdBvrOW3n722ZUb5uIshKtz0CWuBdb9hIpjr0psjLNFC
         rU8lJfRDiwmL0PMnd1WC3BVbakZqmhjPd3JvrlgbyA+c0buhHLPkmfJt4QLjNqiLkI
         j8KS2LW8QBrpSW2CdC85oU+Hcj2PLgvksQ3Rk4gKa5SZdqjYU6DO5yUs8Z50TMpEic
         Xh6VAEP9mZ+AWgbFlzjFuo5VlYgc0RCHXWrT7p6DQPCRc/lJadYGxhwnw114oWVbJ0
         25Wvic0i72uCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8318DC3959E;
        Mon, 28 Aug 2023 09:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dt-bindings: net: dsa: marvell: fix wrong model in
 compatibility list
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169321382253.1934.4875969409159413370.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Aug 2023 09:10:22 +0000
References: <20230825082027.18773-1-alexis.lothore@bootlin.com>
In-Reply-To: <20230825082027.18773-1-alexis.lothore@bootlin.com>
To:     =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@ci.codeaurora.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, airat.gl@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 25 Aug 2023 10:20:27 +0200 you wrote:
> From: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> Fix wrong switch name in compatibility list. 88E6163 switch does not exist
> and is in fact 88E6361
> 
> Fixes: 9229a9483d80 ("dt-bindings: net: dsa: marvell: add MV88E6361 switch to compatibility list")
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net] dt-bindings: net: dsa: marvell: fix wrong model in compatibility list
    https://git.kernel.org/netdev/net/c/72dd7e427e16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


