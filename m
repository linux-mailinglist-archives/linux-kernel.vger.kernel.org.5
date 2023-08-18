Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D50C7815B1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 01:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242292AbjHRXPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 19:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241858AbjHRXPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 19:15:08 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80FF30C2;
        Fri, 18 Aug 2023 16:15:05 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qX8g4-000153-2C;
        Fri, 18 Aug 2023 23:14:49 +0000
Date:   Sat, 19 Aug 2023 00:14:26 +0100
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
Subject: [PATCH net-next 0/4] net: ethernet: mtk_eth_soc: improve support for
 MT7988
Message-ID: <cover.1692400170.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes and completes commit 445eb6448ed3b ("net: ethernet:
mtk_eth_soc: add basic support for MT7988 SoC") and also adds support
for using the in-SoC SRAM to previous MT7986 and MT7981 SoCs.

Daniel Golle (4):
  net: ethernet: mtk_eth_soc: fix register definitions for MT7988
  net: ethernet: mtk_eth_soc: add reset bits for MT7988
  net: ethernet: mtk_eth_soc: add support for in-SoC SRAM
  net: ethernet: mtk_eth_soc: support 36-bit DMA addressing on MT7988

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 190 +++++++++++++++-----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  42 ++++-
 2 files changed, 182 insertions(+), 50 deletions(-)


base-commit: c2e5f4fd1148727801a63d938cec210f16b48864
-- 
2.41.0
