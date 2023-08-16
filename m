Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A0077E4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbjHPPUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245173AbjHPPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:20:11 -0400
Received: from pegase1.c-s.fr (unknown [90.115.179.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D9E10C7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:20:10 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RQs155y0mz9vp1;
        Wed, 16 Aug 2023 17:06:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3atOPjPcw6Z2; Wed, 16 Aug 2023 17:06:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RQs155LSdz9vp0;
        Wed, 16 Aug 2023 17:06:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B41468B76C;
        Wed, 16 Aug 2023 17:06:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id exeDb-itREUw; Wed, 16 Aug 2023 17:06:49 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 945618B763;
        Wed, 16 Aug 2023 17:06:49 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37GF6hQL217207
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 17:06:43 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37GF6hk9217204;
        Wed, 16 Aug 2023 17:06:43 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/512x: Make mpc512x_select_reset_compat() static
Date:   Wed, 16 Aug 2023 17:06:37 +0200
Message-ID: <69739e99329507b93c11908dff744ddd9d0d0564.1692198388.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692198396; l=1450; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=xly2nsILNgA/WH6Yw15RtyhWGWKWgDle/td/O5oaiQ4=; b=6xC0vrxVq7FKpyKo9xU4TELhH7Oe5wef6WUwilJDwIEpMZWGb+AFgXuWardDngXj/kFc6ceqr l7ZB+gUVHjlB50zz3e/PZT2BfoZJSkawlgjoOiPK9Poke/EG13Hu10r
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

mpc512x_select_reset_compat() is only used in the file it
is defined.

Make it static.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/512x/mpc512x.h        | 1 -
 arch/powerpc/platforms/512x/mpc512x_shared.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index 2f3c60e373e1..d2cb06e3a436 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -13,7 +13,6 @@ extern void __init mpc512x_init(void);
 extern void __init mpc512x_setup_arch(void);
 extern int __init mpc5121_clk_init(void);
 const char *__init mpc512x_select_psc_compat(void);
-const char *__init mpc512x_select_reset_compat(void);
 extern void __noreturn mpc512x_restart(char *cmd);
 
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 5ac0ead2540f..622fbb0677f6 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -363,7 +363,7 @@ const char *__init mpc512x_select_psc_compat(void)
 	return NULL;
 }
 
-const char *__init mpc512x_select_reset_compat(void)
+static const char *__init mpc512x_select_reset_compat(void)
 {
 	if (of_machine_is_compatible("fsl,mpc5121"))
 		return "fsl,mpc5121-reset";
-- 
2.41.0

