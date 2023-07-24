Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343087602E0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjGXXAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjGXXA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D6C115;
        Mon, 24 Jul 2023 16:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 319E461465;
        Mon, 24 Jul 2023 23:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68B1C433C7;
        Mon, 24 Jul 2023 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690239626;
        bh=0gLqL+skDZyctyEo4XytA7Z78FygL1xuVREEMkFKdSI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V9ZMTQWTDr69DqPhmCHg0Q5D5JNpks3fKkPvZjBfR72bXRLolOpcqpds0YGO+c8uC
         L94c8N1csZFQGlQs06lg18PenCAvfJo794gW/uD4cBTdOGztzI4sKdN3hDFdkKVHhE
         4M73DHrhwMOQepwfymJNAgO2SwaRy3SzYfnXmpj9MJUcDJ1ojX9pymGwoO7ed3oKN1
         gSxENlM/QD3BPsHlAdNnv/brc+GyrKiAFcEOC5Ga8ReThNgJ/ZTDo5r7WDT8crlEeO
         R+Gp9QYD0VlPXaLn6ruSxCe7D/cSGophyzs8wCDKe+0RkGThw4VX74tXurmLJO7Cky
         cxWe4qzjMlo0Q==
Date:   Mon, 24 Jul 2023 16:00:24 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
        Greg Ungerer <gerg@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v5 0/9] net: ethernet: mtk_eth_soc: add basic
 support for MT7988 SoC
Message-ID: <20230724160024.427b2bef@kernel.org>
In-Reply-To: <cover.1690148927.git.daniel@makrotopia.org>
References: <cover.1690148927.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2023 22:57:08 +0100 Daniel Golle wrote:
> The series should not conflict with Russell's recently submitted series
> "Remove legacy phylink behaviour", hence the order of them being
> picked into net-next doesn't matter.

Not sure what the exact conflict is, but:

Failed to apply patch:
Applying: dt-bindings: net: mediatek,net: add missing mediatek,mt7621-eth
Applying: dt-bindings: net: mediatek,net: add mt7988-eth binding
Applying: net: ethernet: mtk_eth_soc: add version in mtk_soc_data
Applying: net: ethernet: mtk_eth_soc: increase MAX_DEVS to 3
Applying: net: ethernet: mtk_eth_soc: rely on MTK_MAX_DEVS and remove MTK_MAC_COUNT
Applying: net: ethernet: mtk_eth_soc: add NETSYS_V3 version support
Applying: net: ethernet: mtk_eth_soc: convert caps in mtk_soc_data struct to u64
Applying: net: ethernet: mtk_eth_soc: convert clock bitmap to u64
Applying: net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC
error: sha1 information is lacking or useless (drivers/net/ethernet/mediatek/mtk_eth_soc.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Patch failed at 0009 net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
-- 
pw-bot: cr
