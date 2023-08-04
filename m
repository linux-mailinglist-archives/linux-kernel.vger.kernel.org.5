Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C55376FA81
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjHDGw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbjHDGw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:52:26 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFA94C04;
        Thu,  3 Aug 2023 23:51:59 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RHGKd0qdNz9t1w;
        Fri,  4 Aug 2023 08:39:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r6kF7WeVgq69; Fri,  4 Aug 2023 08:39:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RHGKX73qLz9t1J;
        Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E58DA8B778;
        Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2pPMD2x1z9IG; Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 83B568B775;
        Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 3746dbEo629345
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 4 Aug 2023 08:39:37 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 3746dbFt629344;
        Fri, 4 Aug 2023 08:39:37 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next v1 04/10] net: fs_enet: Remove unused fields in fs_platform_info struct
Date:   Fri,  4 Aug 2023 08:39:28 +0200
Message-ID: <2e584fcd75e21a0f7e7d5f942eebdc067b2f82f9.1691130766.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691130766.git.christophe.leroy@csgroup.eu>
References: <cover.1691130766.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691131164; l=1436; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=0/YG+ECmlJ0XPq+JUSw3GxZiM59UdKjS68Y1/zZt6EA=; b=CCraaMhS+Xkp6PJvStlPUuZkMPoqAtec5SZxlKYtXhFX+bYny7Hi1mr0lB8VeoXVYTsv4kOXO 1lcxuHH95eMC6IEIGWoJroMSd2iuu8+1Lpn4KJwsOYRJufdV6I1CHlF
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 3dd82a1ea724 ("[POWERPC] CPM: Always use new binding.")
many fields of fs_platform_info structure are not used anymore.

Remove them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/fs_enet_pd.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/linux/fs_enet_pd.h b/include/linux/fs_enet_pd.h
index 2351c3d9404d..a1905e41c167 100644
--- a/include/linux/fs_enet_pd.h
+++ b/include/linux/fs_enet_pd.h
@@ -111,33 +111,14 @@ struct fs_mii_bb_platform_info {
 };
 
 struct fs_platform_info {
-
-	void(*init_ioports)(struct fs_platform_info *);
 	/* device specific information */
-	int fs_no;		/* controller index            */
-	char fs_type[4];	/* controller type             */
-
-	u32 cp_page;		/* CPM page */
-	u32 cp_block;		/* CPM sblock */
 	u32 cp_command;		/* CPM page/sblock/mcn */
 
-	u32 clk_trx;		/* some stuff for pins & mux configuration*/
-	u32 clk_rx;
-	u32 clk_tx;
-	u32 clk_route;
-	u32 clk_mask;
-
-	u32 mem_offset;
 	u32 dpram_offset;
-	u32 fcc_regs_c;
 	
-	u32 device_flags;
-
 	struct device_node *phy_node;
-	const struct fs_mii_bus_info *bus_info;
 
 	int rx_ring, tx_ring;	/* number of buffers on rx     */
-	__u8 macaddr[ETH_ALEN];	/* mac address                 */
 	int rx_copybreak;	/* limit we copy small frames  */
 	int napi_weight;	/* NAPI weight                 */
 
-- 
2.41.0

