Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FF5762F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjGZII2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjGZIHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:07:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B5519AF;
        Wed, 26 Jul 2023 01:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4672D61811;
        Wed, 26 Jul 2023 08:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0BB3C433CC;
        Wed, 26 Jul 2023 08:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690358420;
        bh=yWSdPYZf5W9vc3gmJ8AeUrtS+Dz7ZzMlfiBA1k/PSzI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=j6JF2nTKGzruBY9zlzjprZUkOx05r/FtY7z9wG7MmFibR04VWBH3m9joSHdmdnUz+
         VT96uUaGn8z941+xreQmV0JVYbmr7FxFku8joWyNW/q+EG5Zw+AZuY6BBVw5oQmYKY
         yRuPtzf4yfIxPiuJpmzbTYujm4sWjXFUG5AJfoVUY6Q/k1KQXtlasn9mXQyicCTvJ3
         qW+Ypq/oFqjkiJycXY3jXqFw5oVhHysmf2bxRkvwsMK+3bXgJypiZxPF8pAGSkf1q2
         bwQJPLKNe/1OOkHTDYZbDk1lLNB/9MikhLZHI62nwZtB210MtHL+WkGeooqozOxAx7
         m1p8Ecyo52U7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84EA5C691D7;
        Wed, 26 Jul 2023 08:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH 1/4] net: dsa: qca8k: enable use_single_write for qca8xxx
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169035842054.6334.15739257039093388104.git-patchwork-notify@kernel.org>
Date:   Wed, 26 Jul 2023 08:00:20 +0000
References: <20230724032531.15998-1-ansuelsmth@gmail.com>
In-Reply-To: <20230724032531.15998-1-ansuelsmth@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, hi@atinb.me, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        stable@vger.kernel.org
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

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 24 Jul 2023 05:25:28 +0200 you wrote:
> The qca8xxx switch supports 2 way to write reg values, a slow way using
> mdio and a fast way by sending specially crafted mgmt packet to
> read/write reg.
> 
> The fast way can support up to 32 bytes of data as eth packet are used
> to send/receive.
> 
> [...]

Here is the summary with links:
  - [net,1/4] net: dsa: qca8k: enable use_single_write for qca8xxx
    https://git.kernel.org/netdev/net/c/2c39dd025da4
  - [net,2/4] net: dsa: qca8k: fix search_and_insert wrong handling of new rule
    https://git.kernel.org/netdev/net/c/80248d416089
  - [net,3/4] net: dsa: qca8k: fix broken search_and_del
    https://git.kernel.org/netdev/net/c/ae70dcb9d9ec
  - [net,4/4] net: dsa: qca8k: fix mdb add/del case with 0 VID
    https://git.kernel.org/netdev/net/c/dfd739f182b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


