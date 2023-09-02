Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BB8790989
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 22:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjIBUZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 16:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjIBUZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 16:25:18 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7437C1A8;
        Sat,  2 Sep 2023 13:25:15 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,223,1688396400"; 
   d="scan'208";a="178513365"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2023 05:25:14 +0900
Received: from localhost.localdomain (unknown [10.226.92.16])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id F126C4072B19;
        Sun,  3 Sep 2023 05:25:12 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] power: supply: bq256xx: Some cleanups
Date:   Sat,  2 Sep 2023 21:25:05 +0100
Message-Id: <20230902202505.97609-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230902202505.97609-1-biju.das.jz@bp.renesas.com>
References: <20230902202505.97609-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cleanups:
 * Remove trailing comma in the terminator entry for OF/ID/ACPI table.
 * Drop a space from terminator entry for OF table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/power/supply/bq256xx_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index fda4286323ee..474201815a27 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1778,7 +1778,7 @@ static const struct i2c_device_id bq256xx_i2c_ids[] = {
 	{ "bq25611d", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25611D] },
 	{ "bq25618", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25618] },
 	{ "bq25619", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25619] },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, bq256xx_i2c_ids);
 
@@ -1790,7 +1790,7 @@ static const struct of_device_id bq256xx_of_match[] = {
 	{ .compatible = "ti,bq25611d", .data = &bq256xx_chip_info_tbl[BQ25611D] },
 	{ .compatible = "ti,bq25618", .data = &bq256xx_chip_info_tbl[BQ25618] },
 	{ .compatible = "ti,bq25619", .data = &bq256xx_chip_info_tbl[BQ25619] },
-	{ },
+	{}
 };
 MODULE_DEVICE_TABLE(of, bq256xx_of_match);
 
@@ -1802,7 +1802,7 @@ static const struct acpi_device_id bq256xx_acpi_match[] = {
 	{ "bq25611d", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25611D] },
 	{ "bq25618", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25618] },
 	{ "bq25619", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25619] },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(acpi, bq256xx_acpi_match);
 
-- 
2.25.1

