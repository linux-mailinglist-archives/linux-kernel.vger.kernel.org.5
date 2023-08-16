Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAE777E500
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbjHPPWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344136AbjHPPWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:22:36 -0400
Received: from pegase1.c-s.fr (unknown [90.115.179.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7953410C7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:22:29 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RQsM82Hnsz9vJg;
        Wed, 16 Aug 2023 17:22:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kppk9VN7sGWJ; Wed, 16 Aug 2023 17:22:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RQsM81XKqz9vJW;
        Wed, 16 Aug 2023 17:22:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3122E8B76C;
        Wed, 16 Aug 2023 17:22:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id E-PsoPeOr-Wy; Wed, 16 Aug 2023 17:22:28 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 125B58B763;
        Wed, 16 Aug 2023 17:22:28 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37GFMOHV218456
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 17:22:24 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37GFMOTX218451;
        Wed, 16 Aug 2023 17:22:24 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/83xx: Fix style problems in usb.c and remove unneccessary includes from mpc83xx.h
Date:   Wed, 16 Aug 2023 17:22:16 +0200
Message-ID: <2cb498f637e082a4af8032311fad3cae84d6aa5d.1692199324.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692199335; l=4998; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=ynzTFXLoS0tTZiELq++lt6cYdEFoY79LGeLmrrs4ILY=; b=9C8z8+CHe99JlbwpJkFxYI1agOMhaVDrKKj3D3+fQpT3MZxyOybgU8m/oqCNCnkZ49M690RbV eoJMT4pbWa6DLkbyrpRp96Y2mNYXulcmj7OJ8h60ZxCg3OBs7K6tcDY
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_FAIL,SPF_HELO_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace printk(KERN_WARN with pr_warn(

Remove a couple of blank lines

Re-align multi-line code.

Replace asm/io.h by linux/io.h

mpc83xx.h doesn't need linux/device.h or asm/pci-bridge.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/83xx/mpc83xx.h |  2 --
 arch/powerpc/platforms/83xx/usb.c     | 35 ++++++++++++---------------
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index aea803ba3a15..0b8738a2b980 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -3,8 +3,6 @@
 #define __MPC83XX_H__
 
 #include <linux/init.h>
-#include <linux/device.h>
-#include <asm/pci-bridge.h>
 
 /* System Clock Control Register */
 #define MPC83XX_SCCR_OFFS          0xA08
diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index e2a13a052f96..d5ad6cff9bd8 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -6,19 +6,17 @@
  * Author: Li Yang
  */
 
-
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <sysdev/fsl_soc.h>
 
 #include "mpc83xx.h"
 
-
 #ifdef CONFIG_PPC_MPC834x
 int __init mpc834x_usb_cfg(void)
 {
@@ -44,8 +42,8 @@ int __init mpc834x_usb_cfg(void)
 
 		prop = of_get_property(np, "phy_type", NULL);
 		port1_is_dr = 1;
-		if (prop && (!strcmp(prop, "utmi") ||
-					!strcmp(prop, "utmi_wide"))) {
+		if (prop &&
+		    (!strcmp(prop, "utmi") || !strcmp(prop, "utmi_wide"))) {
 			sicrl |= MPC834X_SICRL_USB0 | MPC834X_SICRL_USB1;
 			sicrh |= MPC834X_SICRH_USB_UTMI;
 			port0_is_dr = 1;
@@ -60,7 +58,7 @@ int __init mpc834x_usb_cfg(void)
 		} else if (prop && !strcmp(prop, "ulpi")) {
 			sicrl |= MPC834X_SICRL_USB1;
 		} else {
-			printk(KERN_WARNING "834x USB PHY type not supported\n");
+			pr_warn("834x USB PHY type not supported\n");
 		}
 		of_node_put(np);
 	}
@@ -71,15 +69,13 @@ int __init mpc834x_usb_cfg(void)
 		prop = of_get_property(np, "port0", NULL);
 		if (prop) {
 			if (port0_is_dr)
-				printk(KERN_WARNING
-					"834x USB port0 can't be used by both DR and MPH!\n");
+				pr_warn("834x USB port0 can't be used by both DR and MPH!\n");
 			sicrl &= ~MPC834X_SICRL_USB0;
 		}
 		prop = of_get_property(np, "port1", NULL);
 		if (prop) {
 			if (port1_is_dr)
-				printk(KERN_WARNING
-					"834x USB port1 can't be used by both DR and MPH!\n");
+				pr_warn("834x USB port1 can't be used by both DR and MPH!\n");
 			sicrl &= ~MPC834X_SICRL_USB1;
 		}
 		of_node_put(np);
@@ -124,14 +120,14 @@ int __init mpc831x_usb_cfg(void)
 	/* Configure clock */
 	immr_node = of_get_parent(np);
 	if (immr_node && (of_device_is_compatible(immr_node, "fsl,mpc8315-immr") ||
-			of_device_is_compatible(immr_node, "fsl,mpc8308-immr")))
+			  of_device_is_compatible(immr_node, "fsl,mpc8308-immr")))
 		clrsetbits_be32(immap + MPC83XX_SCCR_OFFS,
-		                MPC8315_SCCR_USB_MASK,
-		                MPC8315_SCCR_USB_DRCM_01);
+				MPC8315_SCCR_USB_MASK,
+				MPC8315_SCCR_USB_DRCM_01);
 	else
 		clrsetbits_be32(immap + MPC83XX_SCCR_OFFS,
-		                MPC83XX_SCCR_USB_MASK,
-		                MPC83XX_SCCR_USB_DRCM_11);
+				MPC83XX_SCCR_USB_MASK,
+				MPC83XX_SCCR_USB_DRCM_11);
 
 	/* Configure pin mux for ULPI.  There is no pin mux for UTMI */
 	if (prop && !strcmp(prop, "ulpi")) {
@@ -169,8 +165,7 @@ int __init mpc831x_usb_cfg(void)
 	usb_regs = ioremap(res.start, resource_size(&res));
 
 	/* Using on-chip PHY */
-	if (prop && (!strcmp(prop, "utmi_wide") ||
-		     !strcmp(prop, "utmi"))) {
+	if (prop && (!strcmp(prop, "utmi_wide") || !strcmp(prop, "utmi"))) {
 		u32 refsel;
 
 		if (of_device_is_compatible(immr_node, "fsl,mpc8308-immr"))
@@ -182,7 +177,7 @@ int __init mpc831x_usb_cfg(void)
 			refsel = CONTROL_REFSEL_48MHZ;
 		/* Set UTMI_PHY_EN and REFSEL */
 		out_be32(usb_regs + FSL_USB2_CONTROL_OFFS,
-				CONTROL_UTMI_PHY_EN | refsel);
+			 CONTROL_UTMI_PHY_EN | refsel);
 	/* Using external UPLI PHY */
 	} else if (prop && !strcmp(prop, "ulpi")) {
 		/* Set PHY_CLK_SEL to ULPI */
@@ -197,7 +192,7 @@ int __init mpc831x_usb_cfg(void)
 #endif /* CONFIG_USB_OTG */
 		out_be32(usb_regs + FSL_USB2_CONTROL_OFFS, temp);
 	} else {
-		printk(KERN_WARNING "831x USB PHY type not supported\n");
+		pr_warn("831x USB PHY type not supported\n");
 		ret = -EINVAL;
 	}
 
@@ -224,7 +219,7 @@ int __init mpc837x_usb_cfg(void)
 	prop = of_get_property(np, "phy_type", NULL);
 
 	if (!prop || (strcmp(prop, "ulpi") && strcmp(prop, "serial"))) {
-		printk(KERN_WARNING "837x USB PHY type not supported\n");
+		pr_warn("837x USB PHY type not supported\n");
 		of_node_put(np);
 		return -EINVAL;
 	}
-- 
2.41.0

