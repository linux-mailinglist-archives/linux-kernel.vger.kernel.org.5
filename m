Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEF07A8D81
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjITUKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjITUKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:10:51 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC734AB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=Ke7MWwiVf9//t6v+IkBiNGOrHjI51uuQ1nwsG7+ZaAw=; b=MbI/kY
        eMqf2sCwUzAQGytVQlTayFe513+vdJqK7SFCvO0s/Vs8PrHbshTWMfVBhnwG203W
        UGosj85tfVxMPJ4ukwIKy5M5kYppSlHEcj94A0A5kyjpUzGyyAuwhQGeHbPwkjoO
        WXh4Cre5Q3n5dPKW6UCdQ+RenaBu/3ysAMfuw+UgzXNcJtyvWNZ2ceag7keFklmR
        F8zr/2fAq4EoJjaSYaPkxIKWa/JUf/h/PVWKWx9mUrWctL+pchu1QnIAu09rkjcL
        4A+yhtMnkHIOzljaNQNt0ASvKyg9+IgBblvIJUjAsUsGvJHDIoGYZKpdUC/6Zhng
        ViyDRwkp3rlObqTw==
Received: (qmail 720226 invoked from network); 20 Sep 2023 22:10:42 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Sep 2023 22:10:42 +0200
X-UD-Smtp-Session: l3s3148p1@x31J+M8F3tgujntX
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
Subject: [PATCH 2/6] mtd: parsers: ar7: remove support
Date:   Wed, 20 Sep 2023 22:10:28 +0200
Message-Id: <20230920201035.3445-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AR7 is going to be removed from the Kernel, so remove its support for
MTD.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
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

