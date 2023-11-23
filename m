Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE7F7F5EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345230AbjKWMGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345196AbjKWMGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:06:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16F84B2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:06:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A0271063;
        Thu, 23 Nov 2023 04:07:13 -0800 (PST)
Received: from e127643.arm.com (unknown [10.57.3.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 198543F7A6;
        Thu, 23 Nov 2023 04:06:24 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 1/4] coresight: Fix uninitialized struct warnings
Date:   Thu, 23 Nov 2023 12:04:56 +0000
Message-Id: <20231123120459.287578-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123120459.287578-1-james.clark@arm.com>
References: <20231123120459.287578-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These warnings would be hit with the following W=1 build change so
initialize all structs properly.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-cti-core.c   | 2 +-
 drivers/hwtracing/coresight/coresight-etb10.c      | 2 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 2 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 +-
 drivers/hwtracing/coresight/coresight-funnel.c     | 4 ++--
 drivers/hwtracing/coresight/coresight-replicator.c | 2 +-
 drivers/hwtracing/coresight/coresight-stm.c        | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   | 2 +-
 drivers/hwtracing/coresight/coresight-tpda.c       | 2 +-
 drivers/hwtracing/coresight/coresight-tpdm.c       | 2 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       | 2 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c         | 2 +-
 12 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index 3999d0a2cb60..e805617020d0 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -974,7 +974,7 @@ static const struct amba_id cti_ids[] = {
 	CS_AMBA_ID(0x000bb9aa), /* CTI - C-A73 */
 	CS_AMBA_UCI_ID(0x000bb9da, uci_id_cti), /* CTI - C-A35 */
 	CS_AMBA_UCI_ID(0x000bb9ed, uci_id_cti), /* Coresight CTI (SoC 600) */
-	{ 0, 0},
+	{ 0, 0, NULL },
 };
 
 MODULE_DEVICE_TABLE(amba, cti_ids);
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index fa80039e0821..05e21cffd33b 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -837,7 +837,7 @@ static const struct amba_id etb_ids[] = {
 		.id	= 0x000bb907,
 		.mask	= 0x000fffff,
 	},
-	{ 0, 0},
+	{ 0, 0, NULL },
 };
 
 MODULE_DEVICE_TABLE(amba, etb_ids);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 116a91d90ac2..8da1622e0837 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -1003,7 +1003,7 @@ static const struct amba_id etm_ids[] = {
 	CS_AMBA_ID_DATA(0x000bb95f, "PTM 1.1"),
 	/* PTM 1.1 Qualcomm */
 	CS_AMBA_ID_DATA(0x000b006f, "PTM 1.1"),
-	{ 0, 0},
+	{ 0, 0, NULL},
 };
 
 MODULE_DEVICE_TABLE(amba, etm_ids);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index ce1995a2827f..c5ea808ea662 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2390,7 +2390,7 @@ static const struct of_device_id etm4_sysreg_match[] = {
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id etm4x_acpi_ids[] = {
-	{"ARMHC500", 0}, /* ARM CoreSight ETM4x */
+	{"ARMHC500", 0, 0, 0}, /* ARM CoreSight ETM4x */
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, etm4x_acpi_ids);
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index a5b1fc787766..ef1a0abfee4e 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -350,7 +350,7 @@ MODULE_DEVICE_TABLE(of, static_funnel_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id static_funnel_ids[] = {
-	{"ARMHC9FE", 0},
+	{"ARMHC9FE", 0, 0, 0},
 	{},
 };
 
@@ -391,7 +391,7 @@ static const struct amba_id dynamic_funnel_ids[] = {
 		.id     = 0x000bb9eb,
 		.mask   = 0x000fffff,
 	},
-	{ 0, 0},
+	{ 0, 0, NULL },
 };
 
 MODULE_DEVICE_TABLE(amba, dynamic_funnel_ids);
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 91d93060dda5..73452d9dc13b 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -363,7 +363,7 @@ MODULE_DEVICE_TABLE(of, static_replicator_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id static_replicator_acpi_ids[] = {
-	{"ARMHC985", 0}, /* ARM CoreSight Static Replicator */
+	{"ARMHC985", 0, 0, 0}, /* ARM CoreSight Static Replicator */
 	{}
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index a1c27c901ad1..891ee64efed8 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -950,7 +950,7 @@ static const struct dev_pm_ops stm_dev_pm_ops = {
 static const struct amba_id stm_ids[] = {
 	CS_AMBA_ID_DATA(0x000bb962, "STM32"),
 	CS_AMBA_ID_DATA(0x000bb963, "STM500"),
-	{ 0, 0},
+	{ 0, 0, NULL },
 };
 
 MODULE_DEVICE_TABLE(amba, stm_ids);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 7ec5365e2b64..39bae35d4ffd 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -594,7 +594,7 @@ static const struct amba_id tmc_ids[] = {
 	CS_AMBA_ID(0x000bb9e9),
 	/* Coresight SoC 600 TMC-ETF */
 	CS_AMBA_ID(0x000bb9ea),
-	{ 0, 0},
+	{ 0, 0, NULL },
 };
 
 MODULE_DEVICE_TABLE(amba, tmc_ids);
diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 5f82737c37bb..4ac954f4bc13 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -300,7 +300,7 @@ static struct amba_id tpda_ids[] = {
 		.id     = 0x000f0f00,
 		.mask   = 0x000fff00,
 	},
-	{ 0, 0},
+	{ 0, 0, NULL },
 };
 
 static struct amba_driver tpda_driver = {
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 97654aa4b772..bd13a548375c 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -933,7 +933,7 @@ static struct amba_id tpdm_ids[] = {
 		.id = 0x000f0e00,
 		.mask = 0x000fff00,
 	},
-	{ 0, 0},
+	{ 0, 0, NULL },
 };
 
 static struct amba_driver tpdm_driver = {
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 59eac93fd6bb..7e69048ac944 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -218,7 +218,7 @@ static const struct amba_id tpiu_ids[] = {
 		.id	= 0x000bb9e7,
 		.mask	= 0x000fffff,
 	},
-	{ 0, 0},
+	{ 0, 0, NULL },
 };
 
 MODULE_DEVICE_TABLE(amba, tpiu_ids);
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index 10e886455b8b..f0b6806202d1 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -586,7 +586,7 @@ static void smb_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id ultrasoc_smb_acpi_match[] = {
-	{"HISI03A1", 0},
+	{"HISI03A1", 0, 0, 0},
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, ultrasoc_smb_acpi_match);
-- 
2.34.1

