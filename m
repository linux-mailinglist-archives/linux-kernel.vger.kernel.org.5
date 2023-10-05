Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5787B9DCC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 15:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjJEN4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243728AbjJENtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:49:03 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0193A93D0;
        Thu,  5 Oct 2023 01:52:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690bd8f89baso569810b3a.2;
        Thu, 05 Oct 2023 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696495930; x=1697100730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIyP9FGLHDdotVle9KkMUcCQfjZGob1ifbnnnZcJG2c=;
        b=fT/UPpPl2B9BkfA+i+pCZ7oIK6jXZ6cVCXUTGAOhogvs2hEKFVOaNZyukfBzczCnsf
         uZvNVdtaRp8qJ9hbgOd6dW3N59exZKeWHtL2iUsK1EgK/uRI8i49Wz22v/JTYGCFL3Vg
         zDDKx5zCf8vSd1De8T/gkGg2SKAQ5oEplCsA59+hPCNrd8huANLGfIzBOCEDAzw8cTNF
         3uT2eOGx6xXKOsUXhX5X+ohkYku8ntjiGoVHZh+f0Lt1OVgVOwwI2KzSD7uRxG928pth
         q7l3tVm9MmjN8tgCyLRLGkMNcdPunh2orltfFSvQn61//FWVEVwJttBxQITK4CoHc4TM
         rIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696495930; x=1697100730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIyP9FGLHDdotVle9KkMUcCQfjZGob1ifbnnnZcJG2c=;
        b=hThXKWx+bU7ROWjSKwtP+qBYMioxH5k+0te28v0pFIhhL68Km6PDpeAVboWMQLV/rm
         MVVl9saEl9pOKRff+kR8M+utuYRsAQInu8cphm970NjPEEl2Hieltt6ceSqQmAYCWhNO
         GN4IetiG5ZNNlYph1ZzMCdXOPzc8DJTmMbo/uVkjQpWleNJ3uX2KTGpxS1osJVYk3ATj
         XBM0R9tGyf8HxD0/CmokuFx5DTXjTzwdwQA51vdv4c86ZTx0Bf9fMVShabzTVpFuMWfY
         djNe8MMofTMQpg1cJcLn8bxF/Ch7MC0QsIQeLVHLB8bXdJ0wORNFWhBRjQg5JcQmS4bO
         UdKA==
X-Gm-Message-State: AOJu0YyahfLWuZGuCpp5AgVEwG8DQlQAAN0Y02r1tQkSBv9L2y/S0XSA
        eFdArFUdfZyE39P/cLx4bAH09Lu2iKvtnQ==
X-Google-Smtp-Source: AGHT+IHRe8y1VtpH5ZcQKqlSFq+oDdJTBvmplz9WTmoiYdbTUe182GPvvFf4kQznuqOp58MTWGrQ9w==
X-Received: by 2002:a05:6a20:12d6:b0:15d:bc0f:9b64 with SMTP id v22-20020a056a2012d600b0015dbc0f9b64mr5333019pzg.45.1696495929893;
        Thu, 05 Oct 2023 01:52:09 -0700 (PDT)
Received: from wenkaidev (118-163-147-182.hinet-ip.hinet.net. [118.163.147.182])
        by smtp.gmail.com with ESMTPSA id b19-20020a170902ed1300b001c737950e4dsm1066781pld.2.2023.10.05.01.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 01:52:09 -0700 (PDT)
From:   advantech.susiteam@gmail.com
To:     advantech.susiteam@gmail.com
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 1/5] watchdog: eiois200_wdt: Constructing Advantech EIO-IS200 watchdog driver
Date:   Thu,  5 Oct 2023 16:51:19 +0800
Message-Id: <b627f827d13514c1746beb31bb80db71023e9bb1.1696495372.git.advantech.susiteam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696495372.git.advantech.susiteam@gmail.com>
References: <cover.1696495372.git.advantech.susiteam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenkai <advantech.susiteam@gmail.com>

This is the initial patch that adds the Advantech EIO-IS200 Watchdog
Driver to the kernel. It includes the necessary Makefile and Kconfig
entries to integrate the driver with the watchdog framework. However,
please note that this patch does not yet implement the actual watchdog
functionality. When configuring the kernel using tools like menuconfig,
as all other eiois200 series drivers, it cannot be selected Y as built
in, you can select M to build it as a module or select N to exclude it.

Please also be aware that this driver is a sub-driver of
`drivers/mfd/eiois200_core`. Therefore, it is required for the proper
compilation of the Advantech EIO-IS200 support. Failing to include this
driver may result in compilation errors.

Signed-off-by: Wenkai <advantech.susiteam@gmail.com>
---
 drivers/watchdog/Kconfig        |  14 ++++
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/eiois200_wdt.c | 124 ++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 drivers/watchdog/eiois200_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ee97d89dfc11..218c90714830 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1079,6 +1079,20 @@ config ADVANTECH_EC_WDT
 		This driver supports Advantech products with ITE based Embedded Controller.
 		It does not support Advantech products with other ECs or without EC.
 
+config EIOIS200_WDT
+	tristate "Advantech EIO IS-200 Watchdog Timer"
+	depends on X86 && m
+	default m
+	select MFD_EIOIS200
+	help
+	  This is the driver for the hardware watchdog on the EIO IS-200 EC
+	  chip as used in Advantech boards (and likely others).
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called eiois200_wdt.
+
+	  Most people will say M.
+
 config ALIM1535_WDT
 	tristate "ALi M1535 PMU Watchdog Timer"
 	depends on X86 && PCI
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 3633f5b98236..713872a4f7de 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_SUNPLUS_WATCHDOG) += sunplus_wdt.o
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
 obj-$(CONFIG_ADVANTECH_WDT) += advantechwdt.o
 obj-$(CONFIG_ADVANTECH_EC_WDT) += advantech_ec_wdt.o
+obj-$(CONFIG_EIOIS200_WDT) += eiois200_wdt.o
 obj-$(CONFIG_ALIM1535_WDT) += alim1535_wdt.o
 obj-$(CONFIG_ALIM7101_WDT) += alim7101_wdt.o
 obj-$(CONFIG_EBC_C384_WDT) += ebc-c384_wdt.o
diff --git a/drivers/watchdog/eiois200_wdt.c b/drivers/watchdog/eiois200_wdt.c
new file mode 100644
index 000000000000..bf132a75a2ec
--- /dev/null
+++ b/drivers/watchdog/eiois200_wdt.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Advantech EIO-IS200 Watchdog Driver
+ *
+ * Copyright (C) 2023 Advantech Co., Ltd.
+ * Author: wenkai <advantech.susiteam@gmail.com>
+ */
+
+#include <linux/mfd/core.h>
+#include <linux/reboot.h>
+#include <linux/uaccess.h>
+#include <linux/watchdog.h>
+
+#include "../mfd/eiois200.h"
+
+#define WATCHDOG_TIMEOUT	60
+#define WATCHDOG_PRETIMEOUT	10
+
+static struct _wdt {
+	u32	support;
+	long	last_time;
+	struct	regmap  *iomap;
+	struct	device *dev;
+} wdt;
+
+/* Pointer to the eiois200_core device structure */
+static struct eiois200_dev *eiois200_dev;
+
+static struct watchdog_info wdinfo = {
+	.identity = KBUILD_MODNAME,
+	.options  = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
+		    WDIOF_MAGICCLOSE,
+};
+
+static struct watchdog_device wddev = {
+	.info	     = &wdinfo,
+	.max_timeout = 0x7FFF,
+	.min_timeout = 1,
+};
+
+static int wdt_set_timeout(struct watchdog_device *dev,
+			   unsigned int _timeout)
+{
+	dev->timeout = _timeout;
+	dev_dbg(wdt.dev, "Set timeout: %d\n", _timeout);
+
+	return 0;
+}
+
+static int wdt_start(struct watchdog_device *dev)
+{
+	return 0;
+}
+
+static int wdt_stop(struct watchdog_device *dev)
+{
+	return 0;
+}
+
+static int wdt_ping(struct watchdog_device *dev)
+{
+	return 0;
+}
+
+static unsigned int wdt_get_timeleft(struct watchdog_device *dev)
+{
+	return 0;
+}
+
+static const struct watchdog_ops wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= wdt_start,
+	.stop		= wdt_stop,
+	.ping		= wdt_ping,
+	.set_timeout	= wdt_set_timeout,
+	.get_timeleft	= wdt_get_timeleft,
+};
+
+static int wdt_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct device *dev = &pdev->dev;
+
+	/* Contact eiois200_core */
+	eiois200_dev = dev_get_drvdata(dev->parent);
+	if (!eiois200_dev)
+		return dev_err_probe(dev, ret,
+				     "Error contact eiois200_core %d\n", ret);
+
+	wdt.dev = dev;
+	wdt.iomap = dev_get_regmap(dev->parent, NULL);
+	if (!wdt.iomap)
+		return dev_err_probe(dev, -ENOMEM, "Query parent regmap fail\n");
+
+	/* Inform watchdog info */
+	wddev.ops = &wdt_ops;
+	ret = watchdog_init_timeout(&wddev, wddev.timeout, dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Init timeout fail\n");
+
+	watchdog_stop_on_reboot(&wddev);
+
+	watchdog_stop_on_unregister(&wddev);
+
+	/* Register watchdog */
+	ret = devm_watchdog_register_device(dev, &wddev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Cannot register watchdog device (err: %d)\n",
+				     ret);
+
+	return 0;
+}
+
+static struct platform_driver eiois200_wdt_driver = {
+	.driver = {
+		.name  = "eiois200_wdt",
+	},
+};
+module_platform_driver_probe(eiois200_wdt_driver, wdt_probe);
+
+MODULE_AUTHOR("wenkai <advantech.susiteam@gmail.com>");
+MODULE_DESCRIPTION("Watchdog interface for Advantech EIO-IS200 embedded controller");
+MODULE_LICENSE("GPL");
-- 
2.34.1

