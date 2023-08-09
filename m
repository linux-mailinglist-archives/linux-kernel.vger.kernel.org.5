Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA3377571A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjHIKa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjHIKaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CB61BCF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B4DE63111
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 10:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2413C433D9;
        Wed,  9 Aug 2023 10:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691577021;
        bh=qbspp0328vZLcetH1+KQHBQwIOPAmGQNXoLuQUhJeyk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aq0FBdt9UhZOiZxSQ8y7RoSNrEFZQbk9LfIBk0gVNlugSC0oSC/LihHfrToE630Sl
         NUdW5bSXHixzwmQrsdZElUu6H4KP7+dYlYn8W974Z3SDbJdEMONG/L7HZ8RZpLtJDj
         kVwtpxUV2d6SJ2D1eZdFOH7qJd5+GFZOVYF8EIWOUmxjAIlM5jBE0A6fC47f+HVhBs
         uyFOM0k59yH4tdwdwD36K7RJ352bdVbU5RbTdE841sosga4y6WYzt7PIXtAgIULZXK
         Gy4xa+w4iZYU+AazHbhNSB5PuVnADC86rS1hTZHnGQbyNmA4NUjmXLt8E4/1lgv9pp
         q6D8pOTfSrlTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CB60E505D5;
        Wed,  9 Aug 2023 10:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: mt7530: improve and relax PHY driver
 dependency
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169157702163.3448.7851235321094476296.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Aug 2023 10:30:21 +0000
References: <3ae907b7b60792e36bc5292c2e0bab74f84285e7.1691246642.git.daniel@makrotopia.org>
In-Reply-To: <3ae907b7b60792e36bc5292c2e0bab74f84285e7.1691246642.git.daniel@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 5 Aug 2023 15:45:36 +0100 you wrote:
> Different MT7530 variants require different PHY drivers.
> Use 'imply' instead of 'select' to relax the dependency on the PHY
> driver, and choose the appropriate driver.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/dsa/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: dsa: mt7530: improve and relax PHY driver dependency
    https://git.kernel.org/netdev/net-next/c/b9b05381e5d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


