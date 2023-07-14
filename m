Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A1B75338D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbjGNHu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbjGNHuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A3630EB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 315FA61C44
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92AF1C43391;
        Fri, 14 Jul 2023 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689321021;
        bh=1dpj6UkKiLjgymwg5DEB2OCT6+g1zf51srsO90nPhJU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=d8zihJUIZMLrrK70levafWJPNwVNzttisCIHM5pMSE66yYTPHtl3/SE4dz3Bza5cr
         GYgcuk5Lrvmt+Kj19BeQQoutKqHQ4/GTqyMDehYJRhZ6l0rwMPHh2qvCHwOUjdCb15
         +HDKt3O3u6Suh2VVKbkN3HS6A+H7CNk/IhfRbZsAMlqN/xBo+8e5QNbv99i9lzLrls
         fR/tSbsw2Mq8RZLqwlSJYHlgRh+FtrZ7VP/GRuhmryb2xwW2fEil2Mosa1y90ulYTJ
         zdB1aFqXab39Jl4iNaUX6LIY7d/ryzuPJXzESugWxctr/FC6AXnsqqsn+e4oyKd2YU
         JwfiFotPy4gXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C971E4508D;
        Fri, 14 Jul 2023 07:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: ar9331: Use maple tree register cache
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168932102150.13275.8069520696686192241.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Jul 2023 07:50:21 +0000
References: <20230713-net-ar9331-regmap-maple-v1-1-bffed9f09da7@kernel.org>
In-Reply-To: <20230713-net-ar9331-regmap-maple-v1-1-bffed9f09da7@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 00:45:58 +0100 you wrote:
> We now have a regmap cache which uses a maple tree to store the register
> state, this is a more modern data structure and the regmap level code
> using it makes a number of assumptions better tuned for modern hardware
> than those made by the rbtree cache type that the at9331 driver uses.
> Switch the ar9331 driver to use the more modern data structure.
> 
> This should have minimal practical impact, it's mainly code
> modernisation.
> 
> [...]

Here is the summary with links:
  - net: dsa: ar9331: Use maple tree register cache
    https://git.kernel.org/netdev/net-next/c/88085b3b83f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


