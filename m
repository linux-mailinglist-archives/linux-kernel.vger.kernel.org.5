Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AC57AA8D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjIVGPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjIVGPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:15:50 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119AF19D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=BTlcmFnnfxEfNUisgi/VE1hSD2DIqTeGV9pSI5JKow0=; b=N7OCC2
        yEDAZZBCJomsG+N7CW92pSkN0zXqQa+hKpd0yENypzbHd92rvRbmHB2DTvhSS1S+
        fWaxLWYyVXd8SRun71cQwd++pqYdggI5rvLT7oAe8kv/4toA0tQkcpGbBV9h59uf
        Sof4gkRIZSemZJs+2zKA/oT7JWTyECdJZ+mmUrDLGsvjsaeF8k5JKqHRKpUlWNtt
        wq2RcBxmrbH7bpbxWzC3Hmz4Wfb7hXNtyaLYjvbqhvtr6yu8jR29xJW/1vUkjrxI
        m1odKgtZEPAJCBLj/fJLsTIZxL6WVCZ5HiDuAIYh3xrQGXmXi9Dy+otjhqSzzdwD
        xsshjicSVtlBAE3w==
Received: (qmail 1269071 invoked from network); 22 Sep 2023 08:15:41 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2023 08:15:41 +0200
X-UD-Smtp-Session: l3s3148p1@E3mxiewF9JkujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Russell King <linux@armlinux.org.uk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 2/6] mtd: parsers: ar7: remove support
Date:   Fri, 22 Sep 2023 08:15:23 +0200
Message-Id: <20230922061530.3121-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AR7 is going to be removed from the Kernel, so remove its support for
MTD.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes since v1:
* added ack

 arch/arm/configs/pxa_defconfig |   1 -
 drivers/mtd/parsers/Kconfig    |   5 --
 drivers/mtd/parsers/Makefile   |   1 -
 drivers/mtd/parsers/ar7part.c  | 129 ---------------------------------
 4 files changed, 136 deletions(-)
 delete mode 100644 drivers/mtd/parsers/ar7part.c

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 23c131b0854b..9e81b1849e4c 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -100,7 +100,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_CONNECTOR=y
 CONFIG_MTD=y
-CONFIG_MTD_AR7_PARTS=m
 CONFIG_MTD_CMDLINE_PARTS=m
 CONFIG_MTD_OF_PARTS=m
 CONFIG_MTD_AFS_PARTS=m
diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
index 60738edcd5d5..da03ab6efe04 100644
--- a/drivers/mtd/parsers/Kconfig
+++ b/drivers/mtd/parsers/Kconfig
@@ -1,9 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config MTD_AR7_PARTS
-	tristate "TI AR7 partitioning parser"
-	help
-	  TI AR7 partitioning parser support
-
 config MTD_BCM47XX_PARTS
 	tristate "BCM47XX partitioning parser"
 	depends on BCM47XX || ARCH_BCM_5301X
diff --git a/drivers/mtd/parsers/Makefile b/drivers/mtd/parsers/Makefile
index 0e70b621a1d8..9b00c62b837a 100644
--- a/drivers/mtd/parsers/Makefile
+++ b/drivers/mtd/parsers/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_MTD_AR7_PARTS)		+= ar7part.o
 obj-$(CONFIG_MTD_BCM47XX_PARTS)		+= bcm47xxpart.o
 obj-$(CONFIG_MTD_BCM63XX_PARTS)		+= bcm63xxpart.o
 obj-$(CONFIG_MTD_BRCM_U_BOOT)		+= brcm_u-boot.o
diff --git a/drivers/mtd/parsers/ar7part.c b/drivers/mtd/parsers/ar7part.c
deleted file mode 100644
index 8cd683711ac6..000000000000
-- 
2.35.1

