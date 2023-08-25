Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B4078841A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbjHYJxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbjHYJxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:53:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B331FD3;
        Fri, 25 Aug 2023 02:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692957189; x=1724493189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OXd/cO1jC0n1lhZm5VNzylnvJMWqGYjkafbXBg592zg=;
  b=qrdUcOJ0+YkIh6c8j+cBgCrhtBDVVpNL7RlNW/5oC9hI6ajBJ2QliwKu
   QbAxuO+EyOibm4BFvWZ1wvMNd6Xuvvomol9sdxE1ZVKv3WHpFIqfW9BeF
   s8o7Z/CFStolIm4HkkvFuZ4TcrFBaOaCmmgrBMSJmMhsuHDD+80QvaiJo
   X9aI/lEyjfZX2mzUck9OSutGxpCJ3XWlhrgFxsxutuGvY2L2e9h9FpLVG
   SEr+i9k4Sl6+DO5iZifrar3k2RU8+xRKOLJrHRFqqC7fG6aGjD8zTdTdk
   wMPQtBkBCbaxxZJgLdPNoA1rGuCyg+tbCpUqLaqv4bmIDr6ugmpx/s7/J
   w==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="231695116"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2023 02:53:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 25 Aug 2023 02:52:40 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 25 Aug 2023 02:52:35 -0700
From:   Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
To:     <linus.walleij@linaro.org>, <dmitry.torokhov@gmail.com>,
        <ulf.hansson@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <hari.prasathge@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH v6 2/3] mmc: atmel-mci: move atmel MCI header file
Date:   Fri, 25 Aug 2023 15:21:56 +0530
Message-ID: <20230825095157.76073-3-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230825095157.76073-1-balamanikandan.gunasundar@microchip.com>
References: <20230825095157.76073-1-balamanikandan.gunasundar@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the contents of linux/atmel-mci.h into
drivers/mmc/host/atmel-mci.c as it is only used in one file

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/mmc/host/atmel-mci.c | 39 +++++++++++++++++++++++++++++-
 include/linux/atmel-mci.h    | 46 ------------------------------------
 2 files changed, 38 insertions(+), 47 deletions(-)
 delete mode 100644 include/linux/atmel-mci.h

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 892d29fed9ec..6f815818dd22 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -29,7 +29,6 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdio.h>
 
-#include <linux/atmel-mci.h>
 #include <linux/atmel_pdc.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
@@ -39,6 +38,8 @@
 #include <asm/io.h>
 #include <asm/unaligned.h>
 
+#define ATMCI_MAX_NR_SLOTS	2
+
 /*
  * Superset of MCI IP registers integrated in Atmel AT91 Processor
  * Registers and bitfields marked with [2] are only available in MCI2
@@ -200,6 +201,42 @@ enum atmci_pdc_buf {
 	PDC_SECOND_BUF,
 };
 
+/**
+ * struct mci_slot_pdata - board-specific per-slot configuration
+ * @bus_width: Number of data lines wired up the slot
+ * @detect_pin: GPIO pin wired to the card detect switch
+ * @wp_pin: GPIO pin wired to the write protect sensor
+ * @detect_is_active_high: The state of the detect pin when it is active
+ * @non_removable: The slot is not removable, only detect once
+ *
+ * If a given slot is not present on the board, @bus_width should be
+ * set to 0. The other fields are ignored in this case.
+ *
+ * Any pins that aren't available should be set to a negative value.
+ *
+ * Note that support for multiple slots is experimental -- some cards
+ * might get upset if we don't get the clock management exactly right.
+ * But in most cases, it should work just fine.
+ */
+struct mci_slot_pdata {
+	unsigned int		bus_width;
+	struct gpio_desc        *detect_pin;
+	struct gpio_desc	*wp_pin;
+	bool			detect_is_active_high;
+	bool			non_removable;
+};
+
+/**
+ * struct mci_platform_data - board-specific MMC/SDcard configuration
+ * @dma_slave: DMA slave interface to use in data transfers.
+ * @slot: Per-slot configuration data.
+ */
+struct mci_platform_data {
+	void			*dma_slave;
+	dma_filter_fn		dma_filter;
+	struct mci_slot_pdata	slot[ATMCI_MAX_NR_SLOTS];
+};
+
 struct atmel_mci_caps {
 	bool    has_dma_conf_reg;
 	bool    has_pdc;
diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
deleted file mode 100644
index 017e7d8f6126..000000000000
--- a/include/linux/atmel-mci.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_ATMEL_MCI_H
-#define __LINUX_ATMEL_MCI_H
-
-#include <linux/types.h>
-#include <linux/dmaengine.h>
-
-#define ATMCI_MAX_NR_SLOTS	2
-
-/**
- * struct mci_slot_pdata - board-specific per-slot configuration
- * @bus_width: Number of data lines wired up the slot
- * @detect_pin: GPIO pin wired to the card detect switch
- * @wp_pin: GPIO pin wired to the write protect sensor
- * @detect_is_active_high: The state of the detect pin when it is active
- * @non_removable: The slot is not removable, only detect once
- *
- * If a given slot is not present on the board, @bus_width should be
- * set to 0. The other fields are ignored in this case.
- *
- * Any pins that aren't available should be set to a negative value.
- *
- * Note that support for multiple slots is experimental -- some cards
- * might get upset if we don't get the clock management exactly right.
- * But in most cases, it should work just fine.
- */
-struct mci_slot_pdata {
-	unsigned int		bus_width;
-	struct gpio_desc        *detect_pin;
-	struct gpio_desc	*wp_pin;
-	bool			detect_is_active_high;
-	bool			non_removable;
-};
-
-/**
- * struct mci_platform_data - board-specific MMC/SDcard configuration
- * @dma_slave: DMA slave interface to use in data transfers.
- * @slot: Per-slot configuration data.
- */
-struct mci_platform_data {
-	void			*dma_slave;
-	dma_filter_fn		dma_filter;
-	struct mci_slot_pdata	slot[ATMCI_MAX_NR_SLOTS];
-};
-
-#endif /* __LINUX_ATMEL_MCI_H */
-- 
2.25.1

