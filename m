Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E327985DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243164AbjIHK3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241067AbjIHK26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:28:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D34A211F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:28:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A890C433CC;
        Fri,  8 Sep 2023 10:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168222;
        bh=x6MlbOtyMTEis48jZu3CaXo/cE7HmlRwgBEAeE0K+gg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=a66LllebDlgsZY66OAV5wu0R/s515h8jL6oPU83cMll1pdms96ZfFRAsmFWrQLmD+
         W2RqtpsM0HuuwbHUVeHWP9D+Fzt1A5QBpUrmQBjOFjWxDib3RSXMH+4BxQWbN6/xae
         7Up0rAJ0OD4hGpKtRM0K9IjBwLMJFhXsX2xVJ3cQl0DWfxy7KlG8mH0lajHt2A1OHf
         DmUqaTokHywXVePobWaANLxjRARByYsn+iK79u+mCxSUXWtUBhC7DyxpVP60+RFY8i
         pejhBvmRujmEFrg9DixN/cJN9j3Q7ePmZKQwdANBvk6psSu2g6RD6pvHjcJ9QJliPj
         gw3MI5xoVvV8g==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:34 +0200
Subject: [PATCH v3 16/41] mtd: spi-nor: remove or move flash_info comments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-16-e60548861b10@kernel.org>
References: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the comments are a relict of the past when the flash_info was
just one table. Most of them are useless. Remove them.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
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
index 57df68eab6aa..1e06c6841a18 100644
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
index ecf52b9e3148..0ca3e612ccf5 100644
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

