Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0059577FA9A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353147AbjHQPUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353125AbjHQPUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:20:12 -0400
X-Greylist: delayed 1684 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 08:20:10 PDT
Received: from pegase1.c-s.fr (unknown [90.115.179.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781F31AE;
        Thu, 17 Aug 2023 08:20:10 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RRSdd3c0Wz9wDZ;
        Thu, 17 Aug 2023 16:52:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Xu1Wi41DeIWd; Thu, 17 Aug 2023 16:52:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RRSdd2zBVz9wDR;
        Thu, 17 Aug 2023 16:52:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E5298B76C;
        Thu, 17 Aug 2023 16:52:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YD0PK2gt8x9D; Thu, 17 Aug 2023 16:52:05 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.19.54.59])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2C13F8B763;
        Thu, 17 Aug 2023 16:52:05 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37HEq05R469319
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 16:52:00 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37HEprmG469307;
        Thu, 17 Aug 2023 16:51:53 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] block: swim3: Mark swim3_init() static to fix no previous prototype error
Date:   Thu, 17 Aug 2023 16:51:40 +0200
Message-ID: <4798f19879b0470c07ee6a37aa79eae04db5d433.1692283840.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692283899; l=838; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=wlYp3VeZpONLYQueB+H0V50QRiOXOc6nd6WiozapWLA=; b=OEdpamS1V+IuoDmX+sUxNq62U71ABstA2/v+nkid48E3b8hfIbTwe3conzyA2Cz2DrCWU+Zax /DRiNiTyj1oD/KtaQ3iscVsDr9UCmsxcE+V1DwKTzV1qGh1aY2yYtee
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

With pmac32_defconfig W=1:

  CC [M]  drivers/block/swim3.o
drivers/block/swim3.c:1280:5: warning: no previous prototype for 'swim3_init' [-Wmissing-prototypes]
 1280 | int swim3_init(void)
      |     ^~~~~~~~~~

swim3_init() is called locally via module_init(), it should be static.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/swim3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index dc43a63b3469..c2bc85826358 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1277,7 +1277,7 @@ static struct macio_driver swim3_driver =
 };
 
 
-int swim3_init(void)
+static int swim3_init(void)
 {
 	macio_register_driver(&swim3_driver);
 	return 0;
-- 
2.41.0

