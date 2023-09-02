Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A3B79095E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 21:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjIBTdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 15:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjIBTdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 15:33:43 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 876EACE0;
        Sat,  2 Sep 2023 12:33:40 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,223,1688396400"; 
   d="scan'208";a="178511807"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2023 04:33:40 +0900
Received: from localhost.localdomain (unknown [10.226.92.16])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5E8D64003890;
        Sun,  3 Sep 2023 04:33:38 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] power: supply: bq24257_charger: Some cleanups
Date:   Sat,  2 Sep 2023 20:33:31 +0100
Message-Id: <20230902193331.83672-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230902193331.83672-1-biju.das.jz@bp.renesas.com>
References: <20230902193331.83672-1-biju.das.jz@bp.renesas.com>
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
 drivers/power/supply/bq24257_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 188812f4a79b..801d0d2c5f2e 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -1136,7 +1136,7 @@ static const struct i2c_device_id bq24257_i2c_ids[] = {
 	{ "bq24250", (kernel_ulong_t)&bq24250_info },
 	{ "bq24251", (kernel_ulong_t)&bq24251_info },
 	{ "bq24257", (kernel_ulong_t)&bq24257_info },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, bq24257_i2c_ids);
 
@@ -1144,7 +1144,7 @@ static const struct of_device_id bq24257_of_match[] __maybe_unused = {
 	{ .compatible = "ti,bq24250", &bq24250_info },
 	{ .compatible = "ti,bq24251", &bq24251_info },
 	{ .compatible = "ti,bq24257", &bq24257_info },
-	{ },
+	{}
 };
 MODULE_DEVICE_TABLE(of, bq24257_of_match);
 
@@ -1153,7 +1153,7 @@ static const struct acpi_device_id bq24257_acpi_match[] = {
 	{ "BQ242500", (kernel_ulong_t)&bq24250_info },
 	{ "BQ242510", (kernel_ulong_t)&bq24251_info },
 	{ "BQ242570", (kernel_ulong_t)&bq24257_info },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(acpi, bq24257_acpi_match);
 #endif
-- 
2.25.1

