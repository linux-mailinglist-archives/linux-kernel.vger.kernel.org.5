Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0B1785328
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbjHWIz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbjHWIxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E88C198C;
        Wed, 23 Aug 2023 01:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A69B6585D;
        Wed, 23 Aug 2023 08:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD98CC433D9;
        Wed, 23 Aug 2023 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692780622;
        bh=2XtfpRtDnIU/IzTymjZdBOGFulqWEEJEegtUUR1ce9o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=B7z9mvY5R3DS5mkLH5PZtEUIAFTM05i2+DoUbuKfPU3yAIQoqbDmQPWhvgiPzPbYW
         Pm//3oXZL/nMrPW/u/nXdPP2IPRpzFy7VUWo20p6R0ECA60iG2r6FqM62N5YWneWCf
         CzaAzOIukbdjucIAK3utBZ0Z0CfWmGIL/9ueBTRLwo+TR4IwcbI5edM+U4gnlRAtWR
         uHfM9iivmawwgnCvErdkm7xKrV7gTfDxGPnt9fcSXAWwZ/7COIBOEz6teFYtWFzgOR
         w/OB3Sssah1IbxJ1Z6my723fnZN51lWJsu50a6wv/JKaLkkW2S7pDZo9k3niogfh0q
         07/FxMFywcDAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF514E4EAF6;
        Wed, 23 Aug 2023 08:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: rzn1-a5psw: remove redundant logs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169278062271.13745.4624932060918576814.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Aug 2023 08:50:22 +0000
References: <20230822084112.54803-1-alexis.lothore@bootlin.com>
In-Reply-To: <20230822084112.54803-1-alexis.lothore@bootlin.com>
To:     =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@ci.codeaurora.org
Cc:     clement@clement-leger.fr, andrew@lunn.ch, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        milan.stevanovic@se.com, jimmy.lalande@se.com,
        pascal.eberhard@se.com, thomas.petazzoni@bootlin.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 22 Aug 2023 10:41:12 +0200 you wrote:
> From: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> Remove debug logs in port vlan management, since there are already multiple
> tracepoints defined for those operations in DSA
> 
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: rzn1-a5psw: remove redundant logs
    https://git.kernel.org/netdev/net-next/c/2e0c8ee2b56f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


