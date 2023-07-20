Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1A675A50C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 06:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjGTEU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 00:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGTEUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 00:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E2D210B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 21:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3309461303
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81328C433CA;
        Thu, 20 Jul 2023 04:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689826821;
        bh=zrcWXvlGwF0/Gsyotaj6bAKjRzyfWdgaY8YfW205qtw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kBDyWnEX5LUI3u9/GVS37fs2MtVK4he5svjAiu96vw+SOyJfmlG/rsTi92KPZLDoW
         OLUFmcNeUl3+VCcufonriYQKNYci4Uf8b0Of3CO3AGtebrNF0yFe7dEfza9tX0Dm4H
         hgBokhuMz5EjoaQBK30dudEbKonD2SGiKBxSmmOWxb2QK5Tb1RPDQf5QErzb3AGkjf
         GMVQiZ1RRpXnbEolur9yd3mjtrhUGYTozIXg7gjPArAMHB0JCio1IJeFTWFPDnCfY+
         O/V1GrPCppri3mzDgANlB7daHectf9EOIm4ykxKykkSJPfyrt/Ccaq/wEqqa2kDGdH
         JH/Rzpez7Ybmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62AC9E22AE2;
        Thu, 20 Jul 2023 04:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: always mtk_get_ib1_pkt_type
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168982682139.14645.4950996915143284587.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Jul 2023 04:20:21 +0000
References: <c0ae03d0182f4d27b874cbdf0059bc972c317f3c.1689727134.git.daniel@makrotopia.org>
In-Reply-To: <c0ae03d0182f4d27b874cbdf0059bc972c317f3c.1689727134.git.daniel@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
        Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        sujuan.chen@mediatek.com, Bo.Jiao@mediatek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Jul 2023 01:39:36 +0100 you wrote:
> entries and bind debugfs files would display wrong data on NETSYS_V2 and
> later because instead of using mtk_get_ib1_pkt_type the driver would use
> MTK_FOE_IB1_PACKET_TYPE which corresponds to NETSYS_V1(.x) SoCs.
> Use mtk_get_ib1_pkt_type so entries and bind records display correctly.
> 
> Fixes: 03a3180e5c09e ("net: ethernet: mtk_eth_soc: introduce flow offloading support for mt7986")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mtk_eth_soc: always mtk_get_ib1_pkt_type
    https://git.kernel.org/netdev/net/c/9f9d4c1a2e82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


