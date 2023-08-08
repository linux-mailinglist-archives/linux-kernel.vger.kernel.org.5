Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423E87749C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjHHUDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjHHUDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:03:02 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1595F8624C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:20:25 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RKjN70g2kz9t2l;
        Tue,  8 Aug 2023 08:05:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sPlOYgmixael; Tue,  8 Aug 2023 08:05:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RKjN63q2Nz9t2v;
        Tue,  8 Aug 2023 08:05:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F8DD8B76D;
        Tue,  8 Aug 2023 08:05:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tZXo-HzivclY; Tue,  8 Aug 2023 08:05:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.230])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 32D908B763;
        Tue,  8 Aug 2023 08:05:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37865NU91246321
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 08:05:23 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37865NYT1246320;
        Tue, 8 Aug 2023 08:05:23 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 6/6] powerpc/cpm2: Remove cpm2_map() and cpm2_unmap()
Date:   Tue,  8 Aug 2023 08:04:43 +0200
Message-ID: <9fe6ff7284e9f968b12abe7de7c08d7ea40e29d6.1691474658.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <b056c4e986a4a7707fc1994304c34f7bd15d6871.1691474658.git.christophe.leroy@csgroup.eu>
References: <b056c4e986a4a7707fc1994304c34f7bd15d6871.1691474658.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691474677; l=4998; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=2+WlZlX2O4XYffLlBvVdqv5rYcat6CMn4ApluWEGn7E=; b=tCpW9z+P6ZyxHcq3xkTLUpyY11ddYGbF5jqFVQJi+ims5/z1ulCa0r7Fjzxe5CL/3kMNUzKel rysTeOVpGmgDrq3G0YuI7O8dlxWs1+ySPuThYVMBjwlScXOJuE3wLMD
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 449012daa92a ("[POWERPC] cpm2: Infrastructure code
cleanup.") cpm2_map() is just returning cpm2_immr pointer and
cpm2_unmap() does nothing.

We already have parts of code that use cpm2_immr directly so get rid
of cpm2_map() and cpm2_unmap() by using cpm2_immr directly. And avoid
going through local pointers that hide the pointed structure.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/fs_pd.h |  8 --------
 arch/powerpc/sysdev/cpm2.c       | 32 +++++++++++---------------------
 arch/powerpc/sysdev/cpm2_pic.c   |  3 +--
 3 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/fs_pd.h b/arch/powerpc/include/asm/fs_pd.h
index 82f0e528e21c..d530f68b4eef 100644
--- a/arch/powerpc/include/asm/fs_pd.h
+++ b/arch/powerpc/include/asm/fs_pd.h
@@ -14,14 +14,6 @@
 #include <sysdev/fsl_soc.h>
 #include <asm/time.h>
 
-#ifdef CONFIG_CPM2
-#include <asm/cpm2.h>
-
-#define cpm2_map(member) (&cpm2_immr->member)
-#define cpm2_map_size(member, size) (&cpm2_immr->member)
-#define cpm2_unmap(addr) do {} while(0)
-#endif
-
 static inline int uart_baudrate(void)
 {
         return get_baudrate();
diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index a92691193314..14cc5ea936c0 100644
--- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -40,7 +40,6 @@
 #include <asm/page.h>
 #include <asm/cpm2.h>
 #include <asm/rheap.h>
-#include <asm/fs_pd.h>
 
 #include <sysdev/fsl_soc.h>
 
@@ -118,9 +117,9 @@ void __cpm2_setbrg(uint brg, uint rate, uint clk, int div16, int src)
 	/* This is good enough to get SMCs running.....
 	*/
 	if (brg < 4) {
-		bp = cpm2_map_size(im_brgc1, 16);
+		bp = &cpm2_immr->im_brgc1;
 	} else {
-		bp = cpm2_map_size(im_brgc5, 16);
+		bp = &cpm2_immr->im_brgc5;
 		brg -= 4;
 	}
 	bp += brg;
@@ -130,7 +129,6 @@ void __cpm2_setbrg(uint brg, uint rate, uint clk, int div16, int src)
 		val |= CPM_BRG_DIV16;
 
 	out_be32(bp, val);
-	cpm2_unmap(bp);
 }
 EXPORT_SYMBOL(__cpm2_setbrg);
 
@@ -139,7 +137,6 @@ int __init cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
 	int ret = 0;
 	int shift;
 	int i, bits = 0;
-	cpmux_t __iomem *im_cpmux;
 	u32 __iomem *reg;
 	u32 mask = 7;
 
@@ -202,35 +199,33 @@ int __init cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
 		{CPM_CLK_SCC4, CPM_CLK8, 7},
 	};
 
-	im_cpmux = cpm2_map(im_cpmux);
-
 	switch (target) {
 	case CPM_CLK_SCC1:
-		reg = &im_cpmux->cmx_scr;
+		reg = &cpm2_immr->im_cpmux.cmx_scr;
 		shift = 24;
 		break;
 	case CPM_CLK_SCC2:
-		reg = &im_cpmux->cmx_scr;
+		reg = &cpm2_immr->im_cpmux.cmx_scr;
 		shift = 16;
 		break;
 	case CPM_CLK_SCC3:
-		reg = &im_cpmux->cmx_scr;
+		reg = &cpm2_immr->im_cpmux.cmx_scr;
 		shift = 8;
 		break;
 	case CPM_CLK_SCC4:
-		reg = &im_cpmux->cmx_scr;
+		reg = &cpm2_immr->im_cpmux.cmx_scr;
 		shift = 0;
 		break;
 	case CPM_CLK_FCC1:
-		reg = &im_cpmux->cmx_fcr;
+		reg = &cpm2_immr->im_cpmux.cmx_fcr;
 		shift = 24;
 		break;
 	case CPM_CLK_FCC2:
-		reg = &im_cpmux->cmx_fcr;
+		reg = &cpm2_immr->im_cpmux.cmx_fcr;
 		shift = 16;
 		break;
 	case CPM_CLK_FCC3:
-		reg = &im_cpmux->cmx_fcr;
+		reg = &cpm2_immr->im_cpmux.cmx_fcr;
 		shift = 8;
 		break;
 	default:
@@ -260,7 +255,6 @@ int __init cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
 
 	out_be32(reg, (in_be32(reg) & ~mask) | bits);
 
-	cpm2_unmap(im_cpmux);
 	return ret;
 }
 
@@ -269,7 +263,6 @@ int __init cpm2_smc_clk_setup(enum cpm_clk_target target, int clock)
 	int ret = 0;
 	int shift;
 	int i, bits = 0;
-	cpmux_t __iomem *im_cpmux;
 	u8 __iomem *reg;
 	u8 mask = 3;
 
@@ -284,16 +277,14 @@ int __init cpm2_smc_clk_setup(enum cpm_clk_target target, int clock)
 		{CPM_CLK_SMC2, CPM_CLK15, 3},
 	};
 
-	im_cpmux = cpm2_map(im_cpmux);
-
 	switch (target) {
 	case CPM_CLK_SMC1:
-		reg = &im_cpmux->cmx_smr;
+		reg = &cpm2_immr->im_cpmux.cmx_smr;
 		mask = 3;
 		shift = 4;
 		break;
 	case CPM_CLK_SMC2:
-		reg = &im_cpmux->cmx_smr;
+		reg = &cpm2_immr->im_cpmux.cmx_smr;
 		mask = 3;
 		shift = 0;
 		break;
@@ -316,7 +307,6 @@ int __init cpm2_smc_clk_setup(enum cpm_clk_target target, int clock)
 
 	out_8(reg, (in_8(reg) & ~mask) | bits);
 
-	cpm2_unmap(im_cpmux);
 	return ret;
 }
 
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index d6c1359ae89d..e14493685fe8 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -34,7 +34,6 @@
 
 #include <asm/immap_cpm2.h>
 #include <asm/io.h>
-#include <asm/fs_pd.h>
 
 #include "cpm2_pic.h"
 
@@ -230,7 +229,7 @@ void cpm2_pic_init(struct device_node *node)
 {
 	int i;
 
-	cpm2_intctl = cpm2_map(im_intctl);
+	cpm2_intctl = &cpm2_immr->im_intctl;
 
 	/* Clear the CPM IRQ controller, in case it has any bits set
 	 * from the bootloader
-- 
2.41.0

