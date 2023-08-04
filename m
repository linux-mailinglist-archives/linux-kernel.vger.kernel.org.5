Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDE176FA79
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjHDGwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjHDGvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:51:43 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A9246AC;
        Thu,  3 Aug 2023 23:51:28 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RHGKg6ctJz9t1x;
        Fri,  4 Aug 2023 08:39:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f4QCbGl5mZMv; Fri,  4 Aug 2023 08:39:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RHGKc4pprz9t1c;
        Fri,  4 Aug 2023 08:39:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9CB928B77A;
        Fri,  4 Aug 2023 08:39:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Hk1z7RT71E7d; Fri,  4 Aug 2023 08:39:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4018D8B778;
        Fri,  4 Aug 2023 08:39:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 3746dhCf629364
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 4 Aug 2023 08:39:43 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 3746dhgl629363;
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
Subject: [PATCH net-next v1 08/10] net: fs_enet: Don't include fs_enet_pd.h when not needed
Date:   Fri,  4 Aug 2023 08:39:32 +0200
Message-ID: <b16e25c709c247fdf71d7a705f79d057d50de945.1691130766.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691130766.git.christophe.leroy@csgroup.eu>
References: <cover.1691130766.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691131164; l=1659; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=wiYZJaVAd6C6hv7T6eDAPFilwlr4eeTyZnzPcByG1cc=; b=YE0txyjSABOK4njA5LaEpejuEobZ+6wGpC6AXEYB1sj4u24tgUCA+hEgDQeYQmK3v3gTxGOEu hMJwzecLYN1BlP7CllNKvqCg8wZtRKl//80KeWXum/3gYTxtIL0vqAj
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

Three platforms in arch/powerpc/platforms/8xx/ include fs_enet_pd.h
but don't use anything from it.

Remove the includes.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/8xx/adder875.c        | 1 -
 arch/powerpc/platforms/8xx/mpc885ads_setup.c | 1 -
 arch/powerpc/platforms/8xx/tqm8xx_setup.c    | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/adder875.c b/arch/powerpc/platforms/8xx/adder875.c
index 7e83eb6746f4..f6bd232f8323 100644
--- a/arch/powerpc/platforms/8xx/adder875.c
+++ b/arch/powerpc/platforms/8xx/adder875.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/fs_enet_pd.h>
 #include <linux/of_platform.h>
 
 #include <asm/time.h>
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index 2fc7cacbcd96..c7c4f082b838 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -21,7 +21,6 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 
-#include <linux/fs_enet_pd.h>
 #include <linux/fs_uart_pd.h>
 #include <linux/fsl_devices.h>
 #include <linux/mii.h>
diff --git a/arch/powerpc/platforms/8xx/tqm8xx_setup.c b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
index 7d8eb50bb9cd..6e56be852b2c 100644
--- a/arch/powerpc/platforms/8xx/tqm8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
@@ -24,7 +24,6 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 
-#include <linux/fs_enet_pd.h>
 #include <linux/fs_uart_pd.h>
 #include <linux/fsl_devices.h>
 #include <linux/mii.h>
-- 
2.41.0

