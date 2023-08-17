Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B347E77F8DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351881AbjHQO14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351930AbjHQO1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:27:43 -0400
Received: from pegase1.c-s.fr (unknown [90.115.179.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744182D76
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:27:42 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RRS5T1wrFz9x7v;
        Thu, 17 Aug 2023 16:27:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JZV6txLA989B; Thu, 17 Aug 2023 16:27:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RRS5T1DJcz9x7n;
        Thu, 17 Aug 2023 16:27:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 26A268B76C;
        Thu, 17 Aug 2023 16:27:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 12zksZKOPVCI; Thu, 17 Aug 2023 16:27:41 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.19.54.59])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD3688B763;
        Thu, 17 Aug 2023 16:27:40 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37HERT42446275
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 16:27:29 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37HERTJ8446236;
        Thu, 17 Aug 2023 16:27:29 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] powerpc/4xx: Add missing includes to fix no previous prototype errors
Date:   Thu, 17 Aug 2023 16:27:23 +0200
Message-ID: <c8253017e355638132737ff47936e290df8738d1.1692282432.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692282442; l=1777; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=yGTRAmMTYM0Y3spDgeN3QkgVKi9Gx46oVPN1AD83t74=; b=WYxGZjBxhhd1DmqCSQYw0oT0E4p4RUZpBkLFnaiOkgn8Z2A27j150A0CWsCDO5ShRC3OTwe2F e7J0OaJfqlNAn8UA+vdC4ceBaTr9rjdUA3yHQT7nkdcra7Uo/auAIyx
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

A W=1 build of ppc40x_defconfig throws the followings errors:

  CC      arch/powerpc/platforms/4xx/uic.o
arch/powerpc/platforms/4xx/uic.c:274:13: warning: no previous prototype for 'uic_init_tree' [-Wmissing-prototypes]
  274 | void __init uic_init_tree(void)
      |             ^~~~~~~~~~~~~
arch/powerpc/platforms/4xx/uic.c:319:14: warning: no previous prototype for 'uic_get_irq' [-Wmissing-prototypes]
  319 | unsigned int uic_get_irq(void)
      |              ^~~~~~~~~~~
  CC      arch/powerpc/platforms/4xx/machine_check.o
  CC      arch/powerpc/platforms/4xx/soc.o
arch/powerpc/platforms/4xx/soc.c:193:6: warning: no previous prototype for 'ppc4xx_reset_system' [-Wmissing-prototypes]
  193 | void ppc4xx_reset_system(char *cmd)
      |      ^~~~~~~~~~~~~~~~~~~

Add missing includes to get the missing prototypes.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/4xx/soc.c | 1 +
 arch/powerpc/platforms/4xx/uic.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/4xx/soc.c b/arch/powerpc/platforms/4xx/soc.c
index f91df0827877..b2d940437a66 100644
--- a/arch/powerpc/platforms/4xx/soc.c
+++ b/arch/powerpc/platforms/4xx/soc.c
@@ -21,6 +21,7 @@
 #include <asm/dcr.h>
 #include <asm/dcr-regs.h>
 #include <asm/reg.h>
+#include <asm/ppc4xx.h>
 
 static u32 dcrbase_l2c;
 
diff --git a/arch/powerpc/platforms/4xx/uic.c b/arch/powerpc/platforms/4xx/uic.c
index d667ad039bd3..e3e148b9dd18 100644
--- a/arch/powerpc/platforms/4xx/uic.c
+++ b/arch/powerpc/platforms/4xx/uic.c
@@ -24,6 +24,7 @@
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/dcr.h>
+#include <asm/uic.h>
 
 #define NR_UIC_INTS	32
 
-- 
2.41.0

