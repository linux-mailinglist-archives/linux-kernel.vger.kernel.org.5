Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B1D76A316
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjGaVkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjGaVkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C82D8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D955612F2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 21:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71CC6C433CC;
        Mon, 31 Jul 2023 21:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690839621;
        bh=kt5xjvwpq3sc0kobAAU7Du6fClhn8IZqhVSwmf8tcY0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ki9RbAQAOWeQn9+qOt2JxoXvCj/l0zMd+OM+T7FW98v29dlBalWx0FPMtkFKyYOVb
         XsVec6irJ75v6s/emCKyKjod6vWt8OZHi2O6vwMPglNrJGgi+I2ebM4inKOpT0PLoe
         jsljutQ/cbyuXhTuOSkAZVnsIk2YcNwbJNG18b1K4P24BwZRQu+kMLCUKhTo3jhEtU
         Ftue/WG5ACbShTjbJx1rHDUOEQ7tNdLdp1yDhm0gtizI65YsT/3Zdkbg/0hzyZQQ3R
         2qjtnGJRqU6p4B5vw8uSK/Ki7VxKt1PoTP+e7ggfSk7UF/nwTsL6yRt1sFKzGDAUlm
         afuakEeU8a1tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CDDEE96AC0;
        Mon, 31 Jul 2023 21:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: Remove unused function declarations
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169083962137.7301.4040424865826797881.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 21:40:21 +0000
References: <20230729122644.10648-1-yuehaibing@huawei.com>
In-Reply-To: <20230729122644.10648-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
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

On Sat, 29 Jul 2023 20:26:44 +0800 you wrote:
> commit 8a59f9d1e3d4 ("sock: Introduce sk->sk_prot->psock_update_sk_prot()")
> left behind tcp_bpf_get_proto() declaration. And tcp_v4_tw_remember_stamp()
> function is remove in ccb7c410ddc0 ("timewait_sock: Create and use getpeer op.").
> Since commit 686989700cab ("tcp: simplify tcp_mark_skb_lost")
> tcp_skb_mark_lost_uncond_verify() declaration is not used anymore.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/68223f96997e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


