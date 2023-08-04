Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB4D76FA7E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjHDGwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjHDGwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:52:08 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC934EE4;
        Thu,  3 Aug 2023 23:51:44 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RHGKk3XWfz9t1k;
        Fri,  4 Aug 2023 08:39:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zeQhrJ3xkRop; Fri,  4 Aug 2023 08:39:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RHGKc57sFz9t1l;
        Fri,  4 Aug 2023 08:39:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ABF138B775;
        Fri,  4 Aug 2023 08:39:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DhfHzEQ3HM_x; Fri,  4 Aug 2023 08:39:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 401648B776;
        Fri,  4 Aug 2023 08:39:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 3746dh8M629368
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 4 Aug 2023 08:39:43 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 3746dhWG629367;
        Fri, 4 Aug 2023 08:39:43 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next v1 09/10] net: fs_enet: Remove linux/fs_enet_pd.h
Date:   Fri,  4 Aug 2023 08:39:33 +0200
Message-ID: <3034bb9dbca62540e7236ad0c8bc56f3679694cc.1691130766.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691130766.git.christophe.leroy@csgroup.eu>
References: <cover.1691130766.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691131164; l=3315; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=ahI/5xn7Gm1hdcNAly2aG36Caa0YBSZ+1UeBWlU8m/k=; b=fmKTYaBeozpkzr6Zjg81jq0AOxcicRe+X6hX2ZxlIDLIbZufRhkmpPZfMq8sKIyrFiUY99IkS blNTo6wPqf5DD7ICvDWoswUV4cUAJeA+ugR4B/An0wwKyTb51zm92BD
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

linux/fs_enet_pd.h is not used anymore.

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 MAINTAINERS                |   1 -
 include/linux/fs_enet_pd.h | 118 -------------------------------------
 2 files changed, 119 deletions(-)
 delete mode 100644 include/linux/fs_enet_pd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e2bb1059ab6..5bf1be70e4a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8371,7 +8371,6 @@ L:	linuxppc-dev@lists.ozlabs.org
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/freescale/fs_enet/
-F:	include/linux/fs_enet_pd.h
 
 FREESCALE SOC SOUND DRIVERS
 M:	Shengjiu Wang <shengjiu.wang@gmail.com>
diff --git a/include/linux/fs_enet_pd.h b/include/linux/fs_enet_pd.h
deleted file mode 100644
index 7c9897dab558..000000000000
--- a/include/linux/fs_enet_pd.h
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * Platform information definitions for the
- * universal Freescale Ethernet driver.
- *
- * Copyright (c) 2003 Intracom S.A. 
- *  by Pantelis Antoniou <panto@intracom.gr>
- *
- * 2005 (c) MontaVista Software, Inc. 
- * Vitaly Bordug <vbordug@ru.mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License 
- * version 2. This program is licensed "as is" without any warranty of any 
- * kind, whether express or implied.
- */
-
-#ifndef FS_ENET_PD_H
-#define FS_ENET_PD_H
-
-#include <linux/clk.h>
-#include <linux/string.h>
-#include <linux/of_mdio.h>
-#include <linux/if_ether.h>
-#include <asm/types.h>
-
-#define FS_ENET_NAME	"fs_enet"
-
-enum fs_id {
-	fsid_fec1,
-	fsid_fec2,
-	fsid_fcc1,
-	fsid_fcc2,
-	fsid_fcc3,
-	fsid_scc1,
-	fsid_scc2,
-	fsid_scc3,
-	fsid_scc4,
-};
-
-#define FS_MAX_INDEX	9
-
-static inline int fs_get_fec_index(enum fs_id id)
-{
-	if (id >= fsid_fec1 && id <= fsid_fec2)
-		return id - fsid_fec1;
-	return -1;
-}
-
-static inline int fs_get_fcc_index(enum fs_id id)
-{
-	if (id >= fsid_fcc1 && id <= fsid_fcc3)
-		return id - fsid_fcc1;
-	return -1;
-}
-
-static inline int fs_get_scc_index(enum fs_id id)
-{
-	if (id >= fsid_scc1 && id <= fsid_scc4)
-		return id - fsid_scc1;
-	return -1;
-}
-
-static inline int fs_fec_index2id(int index)
-{
-	int id = fsid_fec1 + index - 1;
-	if (id >= fsid_fec1 && id <= fsid_fec2)
-		return id;
-	return FS_MAX_INDEX;
-		}
-
-static inline int fs_fcc_index2id(int index)
-{
-	int id = fsid_fcc1 + index - 1;
-	if (id >= fsid_fcc1 && id <= fsid_fcc3)
-		return id;
-	return FS_MAX_INDEX;
-}
-
-static inline int fs_scc_index2id(int index)
-{
-	int id = fsid_scc1 + index - 1;
-	if (id >= fsid_scc1 && id <= fsid_scc4)
-		return id;
-	return FS_MAX_INDEX;
-}
-
-enum fs_mii_method {
-	fsmii_fixed,
-	fsmii_fec,
-	fsmii_bitbang,
-};
-
-enum fs_ioport {
-	fsiop_porta,
-	fsiop_portb,
-	fsiop_portc,
-	fsiop_portd,
-	fsiop_porte,
-};
-
-struct fs_mii_bit {
-	u32 offset;
-	u8 bit;
-	u8 polarity;
-};
-struct fs_mii_bb_platform_info {
-	struct fs_mii_bit 	mdio_dir;
-	struct fs_mii_bit 	mdio_dat;
-	struct fs_mii_bit	mdc_dat;
-	int delay;	/* delay in us         */
-	int irq[32]; 	/* irqs per phy's */
-};
-
-struct fs_mii_fec_platform_info {
-	u32 irq[32];
-	u32 mii_speed;
-};
-
-#endif
-- 
2.41.0

