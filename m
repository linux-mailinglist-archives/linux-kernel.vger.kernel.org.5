Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AADE7749C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjHHUDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjHHUC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:02:57 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3946285878
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:20:19 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RKjN64Gt7z9t3F;
        Tue,  8 Aug 2023 08:05:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mbQHZJsKMiuL; Tue,  8 Aug 2023 08:05:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RKjN63bk5z9t2l;
        Tue,  8 Aug 2023 08:05:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 783288B76E;
        Tue,  8 Aug 2023 08:05:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Wt3cb4BQLekF; Tue,  8 Aug 2023 08:05:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.230])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3603D8B76D;
        Tue,  8 Aug 2023 08:05:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37865Mi81246313
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 08:05:22 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37865M5K1246303;
        Tue, 8 Aug 2023 08:05:22 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 4/6] powerpc: Remove CONFIG_PCI_8260
Date:   Tue,  8 Aug 2023 08:04:41 +0200
Message-ID: <19a4c07466ce8b80f287a06eadcc80c4ab1d2c9e.1691474658.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <b056c4e986a4a7707fc1994304c34f7bd15d6871.1691474658.git.christophe.leroy@csgroup.eu>
References: <b056c4e986a4a7707fc1994304c34f7bd15d6871.1691474658.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691474677; l=1221; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=VkocQWr62lQu3qbNUS8b96Jlj/u/wPKl/eWyJyb+RBU=; b=vrBdkW8uHlYzq+n4g/ooWaNex/y2lT+b/kGLzFId+QlKn1/dVfiKrwcf0B00jJ2h4lT4HBaP6 dbKbNWuy1fsCO+tqqw7RC+NlWjiYELEZ3BLcvbZNfu3qNX65lG1OI43
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PCI_8260 is not used anymore, remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig                | 6 ------
 arch/powerpc/platforms/82xx/Kconfig | 1 +
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0b1172cbeccb..c157be9547c5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1144,12 +1144,6 @@ config FSL_GTM
 	help
 	  Freescale General-purpose Timers support
 
-config PCI_8260
-	bool
-	depends on PCI && 8260
-	select PPC_INDIRECT_PCI
-	default y
-
 config FSL_RIO
 	bool "Freescale Embedded SRIO Controller support"
 	depends on RAPIDIO = y && HAVE_RAPIDIO
diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 4eb372bdab70..58e58b4f6a12 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -32,6 +32,7 @@ config 8260
 	bool
 	depends on PPC_BOOK3S_32
 	select CPM2
+	select PPC_INDIRECT_PCI if PCI
 	help
 	  The MPC8260 is a typical embedded CPU made by Freescale.  Selecting
 	  this option means that you wish to build a kernel for a machine with
-- 
2.41.0

