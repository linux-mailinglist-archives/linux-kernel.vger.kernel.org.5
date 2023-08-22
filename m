Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE8678479E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbjHVQbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjHVQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:31:40 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C469F137;
        Tue, 22 Aug 2023 09:31:38 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qYUHk-0000G9-2m;
        Tue, 22 Aug 2023 16:31:17 +0000
Date:   Tue, 22 Aug 2023 17:30:56 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3 0/4] net: ethernet: mtk_eth_soc: improve support
 for MT7988
Message-ID: <cover.1692721443.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes and completes commit 445eb6448ed3b ("net: ethernet:
mtk_eth_soc: add basic support for MT7988 SoC") and also adds support
for using the in-SoC SRAM to previous MT7986 and MT7981 SoCs.

Changes since v2:
 * fold changes to commit they were supposed to go into

Changes since v1:
 * SRAM is actual memory and doesn't require __iomem
 * Introduce stub ADDR64 operations on 32-bit platforms to avoid
   compiler warning

Daniel Golle (4):
  net: ethernet: mtk_eth_soc: fix register definitions for MT7988
  net: ethernet: mtk_eth_soc: add reset bits for MT7988
  net: ethernet: mtk_eth_soc: add support for in-SoC SRAM
  net: ethernet: mtk_eth_soc: support 36-bit DMA addressing on MT7988

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 194 +++++++++++++++-----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  52 +++++-
 2 files changed, 196 insertions(+), 50 deletions(-)


base-commit: 691b2bf1494620ff8c292626e4967c57e5705a8b
-- 
2.41.0
