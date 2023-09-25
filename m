Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848507ADEF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjIYSef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjIYSeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:34:12 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94440192
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:33:48 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RvWgV0JrPz9vB0;
        Mon, 25 Sep 2023 20:32:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f4FQP5vTIL9t; Mon, 25 Sep 2023 20:32:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RvWg52rKVz9v8C;
        Mon, 25 Sep 2023 20:31:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E3978B763;
        Mon, 25 Sep 2023 20:31:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id l2pzYw_uSzla; Mon, 25 Sep 2023 20:31:45 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.137])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5868C8B79E;
        Mon, 25 Sep 2023 20:31:44 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 38PIVbVk1499276
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 20:31:37 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 38PIVblc1499275;
        Mon, 25 Sep 2023 20:31:37 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 36/37] powerpc: Finally remove _PAGE_USER
Date:   Mon, 25 Sep 2023 20:31:50 +0200
Message-ID: <76ebe74fdaed4297a1d8203a61174650c1d8d278.1695659959.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695659959.git.christophe.leroy@csgroup.eu>
References: <cover.1695659959.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695666677; l=1535; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=JeXw0+OAX63QGGbdC4m6O2snFcr+VIrOekmfQeoIUeI=; b=TsNXJqgg2LuWU6c9XEiJ2ARL8hyvnjwDfTO1jhPar18S8BU02bJXU5DhHz9W/k38oxUWBNO6y 9yi9hLEiAPqDbsPfHHSRwLMFigcWG+089pHNR/oWT40idVvmubJEz2k
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

_PAGE_USER is now gone on all targets. Remove it completely.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/pgtable.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index aba56fe3b1c6..f922c84b23eb 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -183,18 +183,14 @@ static inline int pte_young(pte_t pte)
 }
 
 /*
- * Don't just check for any non zero bits in __PAGE_USER, since for book3e
+ * Don't just check for any non zero bits in __PAGE_READ, since for book3e
  * and PTE_64BIT, PAGE_KERNEL_X contains _PAGE_BAP_SR which is also in
- * _PAGE_USER.  Need to explicitly match _PAGE_BAP_UR bit in that case too.
+ * _PAGE_READ.  Need to explicitly match _PAGE_BAP_UR bit in that case too.
  */
 #ifndef pte_read
 static inline bool pte_read(pte_t pte)
 {
-#ifdef _PAGE_READ
 	return (pte_val(pte) & _PAGE_READ) == _PAGE_READ;
-#else
-	return (pte_val(pte) & _PAGE_USER) == _PAGE_USER;
-#endif
 }
 #endif
 
@@ -206,7 +202,7 @@ static inline bool pte_read(pte_t pte)
 static inline bool pte_access_permitted(pte_t pte, bool write)
 {
 	/*
-	 * A read-only access is controlled by _PAGE_USER bit.
+	 * A read-only access is controlled by _PAGE_READ bit.
 	 * We have _PAGE_READ set for WRITE and EXECUTE
 	 */
 	if (!pte_present(pte) || !pte_read(pte))
-- 
2.41.0

