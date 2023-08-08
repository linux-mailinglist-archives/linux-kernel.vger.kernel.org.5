Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDA47749C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjHHUDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjHHUDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:03:00 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1153686247
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:20:23 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RKjN05xwXz9t2b;
        Tue,  8 Aug 2023 08:05:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D3jkJswzO1Ba; Tue,  8 Aug 2023 08:05:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RKjN05Ft1z9t1q;
        Tue,  8 Aug 2023 08:05:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B09248B76E;
        Tue,  8 Aug 2023 08:05:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CHQslQO16iuk; Tue,  8 Aug 2023 08:05:20 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.230])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 719F08B763;
        Tue,  8 Aug 2023 08:05:20 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37865G0v1246288
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 08:05:16 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37865FCi1246253;
        Tue, 8 Aug 2023 08:05:15 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 1/6] powerpc/include: Remove unneeded #include <asm/fs_pd.h>
Date:   Tue,  8 Aug 2023 08:04:38 +0200
Message-ID: <b056c4e986a4a7707fc1994304c34f7bd15d6871.1691474658.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691474677; l=1181; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=8wdCUsSlZXzuwg/I86D6mJJCOiQgvc6jMMSxdMXB5qo=; b=iE46uKhUYpDbqAGpF9fHiPVTC0SWgbLNE2q7MU0GzpVW7h26m2PveV/OhGxo4TtatH4TKeixM 62QwexxFwK/CCiRLj3Lsc/eHBId9CnNw2zPtlpNmjcc/azr93GozzVX
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tqm8xx_setup.c and fs_enet.h don't use any items provided by fs_pd.h

Remove unneeded #include <asm/fs_pd.h>

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/8xx/tqm8xx_setup.c        | 1 -
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/tqm8xx_setup.c b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
index 7d8eb50bb9cd..c422262ba27b 100644
--- a/arch/powerpc/platforms/8xx/tqm8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
@@ -39,7 +39,6 @@
 #include <asm/time.h>
 #include <asm/8xx_immap.h>
 #include <asm/cpm1.h>
-#include <asm/fs_pd.h>
 #include <asm/udbg.h>
 
 #include "mpc8xx.h"
diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
index cb419aef8d1b..aad96cb2ab4e 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
@@ -10,7 +10,6 @@
 #include <linux/dma-mapping.h>
 
 #include <linux/fs_enet_pd.h>
-#include <asm/fs_pd.h>
 
 #ifdef CONFIG_CPM1
 #include <asm/cpm1.h>
-- 
2.41.0

