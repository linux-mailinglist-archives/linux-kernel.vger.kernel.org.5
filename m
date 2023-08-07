Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2AC772576
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjHGNXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjHGNWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:22:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D541F199C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24E2B61B06
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AB1C433CB;
        Mon,  7 Aug 2023 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414546;
        bh=OYrcmJUT5h7Sipmj2wgw6FsV6N5hRYaYL7WAjV1fktM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=TE6qKtSBb8CZr9ZzECczAZPyKwvJOQeV6P0q5jjOxV8MASANrm5+Die0IZra0FysH
         nKNDip5MqHaLxquMFUc6iMZcMgLrYLd4wauaPNn4kjEF05xW04ihmD/qaEM7T7zKOe
         fR2agB7+LVLK1+aDYkINPK8LftGVRNPmEYGrwdPHMrsVrV31V2EVhEra0BHc0MJeDC
         BFwVZrrFHoDMHADCQ0Jdw7AoiRhTcmYU4+01gGLeRxMpug2eWcnr2rawPMwwiuMYXz
         D/JXD+ig4kto/ZjtVnLxRX2aIg1W5olKFX6PAj/H1KDL4CPXY+nvBb8dnVg4BM/26K
         Qqx17LY0cPWuQ==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:10 +0200
Subject: [PATCH 16/41] mtd: spi-nor: remove or move flash_info comments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-16-3d3d5bef4ba4@kernel.org>
References: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the comments are a relict of the past when the flash_info was
just one table. Most of them are useless. Remove them.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/atmel.c    | 1 -
 drivers/mtd/spi-nor/eon.c      | 1 -
 drivers/mtd/spi-nor/esmt.c     | 1 -
 drivers/mtd/spi-nor/everspin.c | 1 -
 drivers/mtd/spi-nor/intel.c    | 1 -
 drivers/mtd/spi-nor/issi.c     | 2 --
 drivers/mtd/spi-nor/macronix.c | 1 -
 drivers/mtd/spi-nor/spansion.c | 3 ---
 drivers/mtd/spi-nor/sst.c      | 1 -
 drivers/mtd/spi-nor/winbond.c  | 1 -
 drivers/mtd/spi-nor/xmc.c      | 2 +-
 11 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 58968c1e7d2f..d2de2cb0c066 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -163,7 +163,6 @@ static const struct spi_nor_fixups atmel_nor_global_protection_fixups = {
 };
 
 static const struct flash_info atmel_nor_parts[] = {
-	/* Atmel -- some are (confusingly) marketed as "DataFlash" */
 	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4)
 		FLAGS(SPI_NOR_HAS_LOCK)
 		NO_SFDP_FLAGS(SECT_4K)
diff --git a/drivers/mtd/spi-nor/eon.c b/drivers/mtd/spi-nor/eon.c
index 434aaf155856..4848ffe8b38f 100644
--- a/drivers/mtd/spi-nor/eon.c
+++ b/drivers/mtd/spi-nor/eon.c
@@ -9,7 +9,6 @@
 #include "core.h"
 
 static const struct flash_info eon_nor_parts[] = {
-	/* EON -- en25xxx */
 	{ "en25f32",    INFO(0x1c3116, 0, 64 * 1024,   64)
 		NO_SFDP_FLAGS(SECT_4K) },
 	{ "en25p32",    INFO(0x1c2016, 0, 64 * 1024,   64) },
diff --git a/drivers/mtd/spi-nor/esmt.c b/drivers/mtd/spi-nor/esmt.c
index fcc3b0e7cda9..12779bec5f99 100644
--- a/drivers/mtd/spi-nor/esmt.c
+++ b/drivers/mtd/spi-nor/esmt.c
@@ -9,7 +9,6 @@
 #include "core.h"
 
 static const struct flash_info esmt_nor_parts[] = {
-	/* ESMT */
 	{ "f25l32pa", INFO(0x8c2016, 0, 64 * 1024, 64)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
 		NO_SFDP_FLAGS(SECT_4K) },
diff --git a/drivers/mtd/spi-nor/everspin.c b/drivers/mtd/spi-nor/everspin.c
index 84a07c2e0536..d02c32f2f7ad 100644
--- a/drivers/mtd/spi-nor/everspin.c
+++ b/drivers/mtd/spi-nor/everspin.c
@@ -9,7 +9,6 @@
 #include "core.h"
 
 static const struct flash_info everspin_nor_parts[] = {
-	/* Everspin */
 	{ "mr25h128", CAT25_INFO(16 * 1024, 1, 256, 2) },
 	{ "mr25h256", CAT25_INFO(32 * 1024, 1, 256, 2) },
 	{ "mr25h10",  CAT25_INFO(128 * 1024, 1, 256, 3) },
diff --git a/drivers/mtd/spi-nor/intel.c b/drivers/mtd/spi-nor/intel.c
index 9179f2d09cba..aba62759a02e 100644
--- a/drivers/mtd/spi-nor/intel.c
+++ b/drivers/mtd/spi-nor/intel.c
@@ -9,7 +9,6 @@
 #include "core.h"
 
 static const struct flash_info intel_nor_parts[] = {
-	/* Intel/Numonyx -- xxxs33b */
 	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
 	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64)
diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index b936a28a85df..d31401bcab64 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -47,7 +47,6 @@ static const struct spi_nor_fixups pm25lv_nor_fixups = {
 };
 
 static const struct flash_info issi_nor_parts[] = {
-	/* ISSI */
 	{ "is25cd512",  INFO(0x7f9d20, 0, 32 * 1024,   2)
 		NO_SFDP_FLAGS(SECT_4K) },
 	{ "is25lq040b", INFO(0x9d4013, 0, 64 * 1024,   8)
@@ -76,7 +75,6 @@ static const struct flash_info issi_nor_parts[] = {
 		FLAGS(SPI_NOR_QUAD_PP)
 		.fixups = &is25lp256_fixups },
 
-	/* PMC */
 	{ "pm25lv512",   INFO0(32 * 1024,    2)
 		NO_SFDP_FLAGS(SECT_4K)
 		.fixups = &pm25lv_nor_fixups
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 0f3bd3ed8eff..b21e688fe056 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -33,7 +33,6 @@ static const struct spi_nor_fixups mx25l25635_fixups = {
 };
 
 static const struct flash_info macronix_nor_parts[] = {
-	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1)
 		NO_SFDP_FLAGS(SECT_4K) },
 	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4)
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index d7012ab3de2c..1a1d2368c462 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -756,9 +756,6 @@ static const struct spi_nor_fixups s25fs_s_nor_fixups = {
 };
 
 static const struct flash_info spansion_nor_parts[] = {
-	/* Spansion/Cypress -- single (large) sector size only, at least
-	 * for the chips listed here (without boot sectors).
-	 */
 	{ "s25sl032p",  INFO(0x010215, 0x4d00,  64 * 1024,  64)
 		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "s25sl064p",  INFO(0x010216, 0x4d00,  64 * 1024, 128)
diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 09fdc7023e09..42e29441a7f7 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -61,7 +61,6 @@ static const struct spi_nor_fixups sst26vf_nor_fixups = {
 };
 
 static const struct flash_info sst_nor_parts[] = {
-	/* SST -- large erase sizes are "overlays", "sectors" are 4K */
 	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
 		NO_SFDP_FLAGS(SECT_4K)
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 7873cc394f07..2d3ae972b419 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -42,7 +42,6 @@ static const struct spi_nor_fixups w25q256_fixups = {
 };
 
 static const struct flash_info winbond_nor_parts[] = {
-	/* Winbond -- w25x "blocks" are 64K, "sectors" are 4KiB */
 	{ "w25x05", INFO(0xef3010, 0, 64 * 1024,  1)
 		NO_SFDP_FLAGS(SECT_4K) },
 	{ "w25x10", INFO(0xef3011, 0, 64 * 1024,  2)
diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
index 051411e86339..48062ccb22fa 100644
--- a/drivers/mtd/spi-nor/xmc.c
+++ b/drivers/mtd/spi-nor/xmc.c
@@ -9,7 +9,6 @@
 #include "core.h"
 
 static const struct flash_info xmc_nor_parts[] = {
-	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
 	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
@@ -18,6 +17,7 @@ static const struct flash_info xmc_nor_parts[] = {
 			      SPI_NOR_QUAD_READ) },
 };
 
+/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
 const struct spi_nor_manufacturer spi_nor_xmc = {
 	.name = "xmc",
 	.parts = xmc_nor_parts,

-- 
2.39.2

