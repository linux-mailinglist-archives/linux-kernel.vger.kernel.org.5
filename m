Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3235F7701A9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjHDNdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjHDNdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:33:03 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613871BFA;
        Fri,  4 Aug 2023 06:32:38 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RHRRx5x9tz9tG1;
        Fri,  4 Aug 2023 15:30:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HfNVyfa3_gPh; Fri,  4 Aug 2023 15:30:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RHRRr2bDfz9tG5;
        Fri,  4 Aug 2023 15:30:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 530C18B763;
        Fri,  4 Aug 2023 15:30:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id h3GXZUbIiyXS; Fri,  4 Aug 2023 15:30:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A274D8B778;
        Fri,  4 Aug 2023 15:30:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 374DUe25693341
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 4 Aug 2023 15:30:40 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 374DUeTT693340;
        Fri, 4 Aug 2023 15:30:40 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, robh@kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v2 05/10] net: fs_enet: Remove has_phy field in fs_platform_info struct
Date:   Fri,  4 Aug 2023 15:30:15 +0200
Message-ID: <bb5264e09e18f0ce8a0dbee399926a59f33cb248.1691155346.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691155346.git.christophe.leroy@csgroup.eu>
References: <cover.1691155346.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691155810; l=2058; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=M35boY3oJLnv+Ktg3fVSjFga7v0KalODYTNO8b5c+ww=; b=HTz0BE8UipCed9tyxCa6teXM7kZvwkpWnHphLrz8/8eS6ceYy4lYZrs8zFl/OWa0SPO8Bow2+ haBObk1Vn5oAiS7UVn55nswvG6ptQie8n042YSMv9YrL4GubUqv6rkr
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 3dd82a1ea724 ("[POWERPC] CPM: Always use new binding.")
has_phy field is never set.

Remove dead code and remove the field.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c | 14 --------------
 include/linux/fs_enet_pd.h                       |  1 -
 2 files changed, 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
index f609dc112458..cdc89d83cf07 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
@@ -339,11 +339,7 @@ static void restart(struct net_device *dev)
 static void stop(struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
-	const struct fs_platform_info *fpi = fep->fpi;
 	struct fec __iomem *fecp = fep->fec.fecp;
-
-	struct fec_info *feci = dev->phydev->mdio.bus->priv;
-
 	int i;
 
 	if ((FR(fecp, ecntrl) & FEC_ECNTRL_ETHER_EN) == 0)
@@ -363,16 +359,6 @@ static void stop(struct net_device *dev)
 	FC(fecp, ecntrl, FEC_ECNTRL_ETHER_EN);
 
 	fs_cleanup_bds(dev);
-
-	/* shut down FEC1? that's where the mii bus is */
-	if (fpi->has_phy) {
-		FS(fecp, r_cntrl, fpi->use_rmii ?
-				FEC_RCNTRL_RMII_MODE :
-				FEC_RCNTRL_MII_MODE);	/* MII/RMII enable */
-		FS(fecp, ecntrl, FEC_ECNTRL_PINMUX | FEC_ECNTRL_ETHER_EN);
-		FW(fecp, ievent, FEC_ENET_MII);
-		FW(fecp, mii_speed, feci->mii_speed);
-	}
 }
 
 static void napi_clear_event_fs(struct net_device *dev)
diff --git a/include/linux/fs_enet_pd.h b/include/linux/fs_enet_pd.h
index a1905e41c167..2b351b676467 100644
--- a/include/linux/fs_enet_pd.h
+++ b/include/linux/fs_enet_pd.h
@@ -123,7 +123,6 @@ struct fs_platform_info {
 	int napi_weight;	/* NAPI weight                 */
 
 	int use_rmii;		/* use RMII mode 	       */
-	int has_phy;            /* if the network is phy container as well...*/
 
 	struct clk *clk_per;	/* 'per' clock for register access */
 };
-- 
2.41.0

