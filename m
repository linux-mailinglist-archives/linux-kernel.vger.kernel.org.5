Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0E1766AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbjG1Kbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjG1KbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:31:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A2E4228
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540176; x=1722076176;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ig30gwYZkr/IoUPy5H3F0pxktm0wBBqBXGc48gOkR1U=;
  b=GdheOqtzgKkEYZhpqc/icjpwp/6OTCD+qAEOQWsH5OaMLK5BYHLJ7Rcj
   LZYpmkZGew4fDVmOmjU37SEAfmsfytri+kVy5XzSTcoI0QRY31C+iroiR
   1WwrrX1Kcsk9q/4ju8BuDxI81qJ2+mDtKT27Y4yoQBBpLoKZRC9Hvr4vt
   tfSVEiwOgKp6aB2zHwpi7f1KRdI4K5SgqA9THMCxYn5NUzsqLUisqLUHB
   BRfalY4jeMVBEwsnZJGCRSr9Ukzb1aXJc2D9gkl9Lb/Mr9roGxQUxAXbP
   AFcX6yoQGBNXwhru/8Qb7zip1ZrSK+hrMk0lw7BOdYdHGsAdI6BGj4mTj
   w==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="226623395"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:29:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:29:04 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:29:01 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 35/50] ARM: at91: pm: add sam9x7 SoC init config
Date:   Fri, 28 Jul 2023 15:58:58 +0530
Message-ID: <20230728102858.267082-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SoC init config for sam9x7 family.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/mach-at91/Makefile |  1 +
 arch/arm/mach-at91/sam9x7.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 arch/arm/mach-at91/sam9x7.c

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 794bd12ab0a8..7d8a7bc44e65 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
 obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
 obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
+obj-$(CONFIG_SOC_SAM9X7)	+= sam9x7.o
 obj-$(CONFIG_SOC_SAMA5)		+= sama5.o sam_secure.o
 obj-$(CONFIG_SOC_SAMA7)		+= sama7.o
 obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
diff --git a/arch/arm/mach-at91/sam9x7.c b/arch/arm/mach-at91/sam9x7.c
new file mode 100644
index 000000000000..d998fb327860
--- /dev/null
+++ b/arch/arm/mach-at91/sam9x7.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Setup code for SAM9X7.
+ *
+ * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Varshini Rajendran <varshini.rajendran@microchip.com>
+ */
+
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+#include <asm/mach/arch.h>
+#include <asm/system_misc.h>
+
+#include "generic.h"
+
+static void __init sam9x7_init(void)
+{
+	of_platform_default_populate(NULL, NULL, NULL);
+
+	sam9x7_pm_init();
+}
+
+static const char *const sam9x7_dt_board_compat[] __initconst = {
+	"microchip,sam9x7",
+	NULL
+};
+
+DT_MACHINE_START(sam9x7_dt, "Microchip SAM9X7")
+	/* Maintainer: Microchip */
+	.init_machine	= sam9x7_init,
+	.dt_compat	= sam9x7_dt_board_compat,
+MACHINE_END
-- 
2.25.1

