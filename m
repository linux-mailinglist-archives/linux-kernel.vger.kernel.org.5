Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F4177CC30
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbjHOL5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbjHOL5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:57:18 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961B82133;
        Tue, 15 Aug 2023 04:56:33 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-589e0eef06dso21744887b3.2;
        Tue, 15 Aug 2023 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692100521; x=1692705321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pUUqBcqT59hyILPiVoLGBuxUbat2hApdIu7q/UjQIKo=;
        b=NSNWbUvCe/JsxExiKXXKEzqk860ZcjtDGoD/MpdivNF/g/+AdFTiEt16JTKxIUvs7h
         jxGsjfgGcnuJhNo82UO0RXa/D5Wa7YfpXhw5xvroDHMKC8piXRbwLOmPySt8vcfxzcAP
         MDE++Bwmgbvc4Rbpby1/A8P79VqzPKLlMksE8rQaWuie9Ed9nd2owCrv3m8VZ0kNLBHB
         q/wjsVGHs0rrb75Fz7vRPsTlqr5nf8SasMjGJRUacDM658YnpS53fwnVVVJOhGVsPBwN
         BlJE8sWzXmDDPw7QAcAu1/5M1NX6J0GNMK86m5Wt9DAjUPbrUUm4DuOg7E3CwndJeldC
         xtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692100521; x=1692705321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUUqBcqT59hyILPiVoLGBuxUbat2hApdIu7q/UjQIKo=;
        b=FNmv1L8RPBvIvAz77b6bpOFOCwebYLQGX79F13DXoWOd3xTYGBOLgyXtnFf6xtHnPh
         wJw8G59QAhRIGiphM/dOuMw89NLYadfCItkMoGRKz7F4u/Z9z4JfruQR24zdwWad8WYS
         aFTG2fuAMN1dD1m9ki2o0JkA2gtV6U9FgdIU1GC6M1xffbrpkE5R6QJnVrtcdCW3GQBy
         RZJp5RnNkWAVmYfZOk2h1WWZq89j26pbzC2H4mduU//6t0Z7Go/cb3tPNOJ8IEuaHj6N
         /hz0fx5Mu2HZmiy7y1VHXFKkTrflSZ6OWtZedsjGeM/kplGz922nfD+bntUPjHe8woG8
         QVPg==
X-Gm-Message-State: AOJu0YxMKx6tdLFzOzmlv2Na9BkKnHd4y4y1LR//KhTjgeiT4TuNxu9f
        O6KIz6a+ssseg1NU/1j6KzrGEtERmoGpyg==
X-Google-Smtp-Source: AGHT+IHHpAzw1+E7FaKb7p3bQybbwwwRoRZGdtLCq7i+b4ujtealIW6yrvoV5CHW8q9u3kvLbFfZzw==
X-Received: by 2002:a81:77d5:0:b0:573:cacd:306 with SMTP id s204-20020a8177d5000000b00573cacd0306mr10494744ywc.16.1692100521491;
        Tue, 15 Aug 2023 04:55:21 -0700 (PDT)
Received: from z-Lenovo-Product.lan ([2605:59c8:6244:7600:676:9fca:53:170f])
        by smtp.gmail.com with ESMTPSA id z20-20020a81c214000000b0058038e6609csm3308329ywc.74.2023.08.15.04.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 04:55:20 -0700 (PDT)
From:   David Ober <dober6023@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        dober@lenovo.com, mpearson@lenovo.com,
        David Ober <dober6023@gmail.com>
Subject: [PATCH] hwmon: add in watchdog for nct6686
Date:   Tue, 15 Aug 2023 07:55:15 -0400
Message-Id: <20230815115515.286142-1-dober6023@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds in the watchdog timer support for the nct6686
chip so that it can be used on the Lenovo m90n IOT device

Signed-off-by: David Ober <dober6023@gmail.com>
---
 Documentation/hwmon/nct6683.rst |   5 +-
 drivers/hwmon/nct6683.c         | 247 ++++++++++++++++++++++++++++++--
 2 files changed, 242 insertions(+), 10 deletions(-)

diff --git a/Documentation/hwmon/nct6683.rst b/Documentation/hwmon/nct6683.rst
index 2e1408d174bd..7421bc444365 100644
--- a/Documentation/hwmon/nct6683.rst
+++ b/Documentation/hwmon/nct6683.rst
@@ -3,7 +3,7 @@ Kernel driver nct6683
 
 Supported chips:
 
-  * Nuvoton NCT6683D/NCT6687D
+  * Nuvoton NCT6683D/NCT6686D/NCT6687D
 
     Prefix: 'nct6683'
 
@@ -49,6 +49,8 @@ The driver has only been tested with the Intel firmware, and by default
 only instantiates on Intel boards. To enable it on non-Intel boards,
 set the 'force' module parameter to 1.
 
+Implement the watchdog functionality of the NCT6686D eSIO chip
+
 Tested Boards and Firmware Versions
 -----------------------------------
 
@@ -63,4 +65,5 @@ Intel DH87MC	NCT6683D EC firmware version 1.0 build 04/03/13
 Intel DB85FL	NCT6683D EC firmware version 1.0 build 04/03/13
 ASRock X570	NCT6683D EC firmware version 1.0 build 06/28/19
 MSI B550	NCT6687D EC firmware version 1.0 build 05/07/20
+LENOVO M90n-1	NCT6686D EC firmware version 9.0 build 04/21/21
 =============== ===============================================
diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index f673f7d07941..eb95b91c4d39 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -24,15 +24,16 @@
 #include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/jiffies.h>
-#include <linux/hwmon.h>
-#include <linux/hwmon-sysfs.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/watchdog.h>
 
 enum kinds { nct6683, nct6686, nct6687 };
 
@@ -73,6 +74,34 @@ static const char * const nct6683_chip_names[] = {
 #define SIO_NCT6687_ID		0xd590
 #define SIO_ID_MASK		0xFFF0
 
+#define WDT_CFG			0x828    /* W/O Lock Watchdog Register */
+#define WDT_CNT			0x829    /* R/W Watchdog Timer Register */
+#define WDT_STS			0x82A    /* R/O Watchdog Status Register */
+#define WDT_STS_EVT_POS		(0)
+#define WDT_STS_EVT_MSK		(0x3 << WDT_STS_EVT_POS)
+#define WDT_SOFT_EN		0x87    /* Enable soft watchdog timer */
+#define WDT_SOFT_DIS		0xAA    /* Disable soft watchdog timer */
+
+#define WATCHDOG_TIMEOUT	60      /* 1 minute default timeout */
+
+/* The timeout range is 1-255 seconds */
+#define MIN_TIMEOUT		1
+#define MAX_TIMEOUT		255
+
+static int timeout;
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. 1 <= timeout <= 255, default="
+		 __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static int early_disable;
+module_param(early_disable, int, 0);
+MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
+
 static inline void
 superio_outb(int ioreg, int reg, int val)
 {
@@ -171,10 +200,10 @@ superio_exit(int ioreg)
 
 #define NCT6683_REG_CUSTOMER_ID		0x602
 #define NCT6683_CUSTOMER_ID_INTEL	0x805
+#define NCT6683_CUSTOMER_ID_LENOVO	0x1101
 #define NCT6683_CUSTOMER_ID_MITAC	0xa0e
 #define NCT6683_CUSTOMER_ID_MSI		0x201
-#define NCT6683_CUSTOMER_ID_MSI2	0x200
-#define NCT6683_CUSTOMER_ID_ASROCK		0xe2c
+#define NCT6683_CUSTOMER_ID_ASROCK	0xe2c
 #define NCT6683_CUSTOMER_ID_ASROCK2	0xe1b
 
 #define NCT6683_REG_BUILD_YEAR		0x604
@@ -183,6 +212,9 @@ superio_exit(int ioreg)
 #define NCT6683_REG_SERIAL		0x607
 #define NCT6683_REG_VERSION_HI		0x608
 #define NCT6683_REG_VERSION_LO		0x609
+#define NCT6686_PAGE_REG_OFFSET		0
+#define NCT6686_ADDR_REG_OFFSET		1
+#define NCT6686_DATA_REG_OFFSET		2
 
 #define NCT6683_REG_CR_CASEOPEN		0xe8
 #define NCT6683_CR_CASEOPEN_MASK	(1 << 7)
@@ -304,6 +336,7 @@ struct nct6683_data {
 
 	struct device *hwmon_dev;
 	const struct attribute_group *groups[6];
+	struct watchdog_device wdt;
 
 	int temp_num;			/* number of temperature attributes */
 	u8 temp_index[NCT6683_NUM_REG_MON];
@@ -518,6 +551,39 @@ static void nct6683_write(struct nct6683_data *data, u16 reg, u16 value)
 	outb_p(value & 0xff, data->addr + EC_DATA_REG);
 }
 
+static inline void nct6686_wdt_set_bank(int base_addr, u16 reg)
+{
+	outb_p(0xFF, base_addr + NCT6686_PAGE_REG_OFFSET);
+	outb_p(reg >> 8, base_addr + NCT6686_PAGE_REG_OFFSET);
+}
+
+/* Not strictly necessary, but play it safe for now */
+static inline void nct6686_wdt_reset_bank(int base_addr, u16 reg)
+{
+	if (reg & 0xff00)
+		outb_p(0xFF, base_addr + NCT6686_PAGE_REG_OFFSET);
+}
+
+static u8 nct6686_read(struct nct6683_data *data, u16 reg)
+{
+	u8 res;
+
+	nct6686_wdt_set_bank(data->addr, reg);
+	outb_p(reg & 0xff, data->addr + NCT6686_ADDR_REG_OFFSET);
+	res = inb_p(data->addr + NCT6686_DATA_REG_OFFSET);
+
+	nct6686_wdt_reset_bank(data->addr, reg);
+	return res;
+}
+
+static void nct6686_write(struct nct6683_data *data, u16 reg, u8 value)
+{
+	nct6686_wdt_set_bank(data->addr, reg);
+	outb_p(reg & 0xff, data->addr + NCT6686_ADDR_REG_OFFSET);
+	outb_p(value & 0xff, data->addr + NCT6686_DATA_REG_OFFSET);
+	nct6686_wdt_reset_bank(data->addr, reg);
+}
+
 static int get_in_reg(struct nct6683_data *data, int nr, int index)
 {
 	int ch = data->in_index[index];
@@ -680,11 +746,12 @@ static umode_t nct6683_in_is_visible(struct kobject *kobj,
 	int nr = index % 4;	/* attribute */
 
 	/*
-	 * Voltage limits exist for Intel boards,
+	 * Voltage limits exist for Intel and Lenovo boards,
 	 * but register location and encoding is unknown
 	 */
 	if ((nr == 2 || nr == 3) &&
-	    data->customer_id == NCT6683_CUSTOMER_ID_INTEL)
+	    (data->customer_id == NCT6683_CUSTOMER_ID_INTEL ||
+	     data->customer_id == NCT6683_CUSTOMER_ID_LENOVO))
 		return 0;
 
 	return attr->mode;
@@ -1186,6 +1253,139 @@ static void nct6683_setup_sensors(struct nct6683_data *data)
 	}
 }
 
+/*
+ * Watchdog Functions
+ */
+static int nct6686_wdt_enable(struct watchdog_device *wdog, bool enable)
+{
+	struct nct6683_data *data = watchdog_get_drvdata(wdog);
+
+	u_char reg;
+
+	mutex_lock(&data->update_lock);
+	reg = nct6686_read(data, WDT_CFG);
+
+	if (enable) {
+		nct6686_write(data, WDT_CFG, reg | 0x3);
+		mutex_unlock(&data->update_lock);
+		return 0;
+	}
+
+	nct6686_write(data, WDT_CFG, reg & ~BIT(0));
+	mutex_unlock(&data->update_lock);
+
+	return 0;
+}
+
+static int nct6686_wdt_set_time(struct watchdog_device *wdog)
+{
+	struct nct6683_data *data = watchdog_get_drvdata(wdog);
+
+	mutex_lock(&data->update_lock);
+	nct6686_write(data, WDT_CNT, wdog->timeout);
+	mutex_unlock(&data->update_lock);
+
+	if (wdog->timeout) {
+		nct6686_wdt_enable(wdog, true);
+		return 0;
+	}
+
+	nct6686_wdt_enable(wdog, false);
+	return 0;
+}
+
+static int nct6686_wdt_start(struct watchdog_device *wdt)
+{
+	struct nct6683_data *data = watchdog_get_drvdata(wdt);
+	u_char reg;
+
+	nct6686_wdt_set_time(wdt);
+
+	/* Enable soft watchdog timer */
+	mutex_lock(&data->update_lock);
+	/* reset trigger status */
+	reg = nct6686_read(data, WDT_STS);
+	nct6686_write(data, WDT_STS, reg & ~WDT_STS_EVT_MSK);
+	mutex_unlock(&data->update_lock);
+	return 0;
+}
+
+static int nct6686_wdt_stop(struct watchdog_device *wdt)
+{
+	struct nct6683_data *data = watchdog_get_drvdata(wdt);
+
+	mutex_lock(&data->update_lock);
+	nct6686_write(data, WDT_CFG, WDT_SOFT_DIS);
+	mutex_unlock(&data->update_lock);
+	return 0;
+}
+
+static int nct6686_wdt_set_timeout(struct watchdog_device *wdt,
+				   unsigned int timeout)
+{
+	struct nct6683_data *data = watchdog_get_drvdata(wdt);
+
+	wdt->timeout = timeout;
+	mutex_lock(&data->update_lock);
+	nct6686_write(data, WDT_CNT, timeout);
+	mutex_unlock(&data->update_lock);
+	return 0;
+}
+
+static int nct6686_wdt_ping(struct watchdog_device *wdt)
+{
+	struct nct6683_data *data = watchdog_get_drvdata(wdt);
+	int timeout;
+
+	/*
+	 * Note:
+	 * NCT6686 does not support refreshing WDT_TIMER_REG register when
+	 * the watchdog is active. Please disable watchdog before feeding
+	 * the watchdog and enable it again.
+	 */
+	/* Disable soft watchdog timer */
+	nct6686_wdt_enable(wdt, false);
+
+	/* feed watchdog */
+	timeout = wdt->timeout;
+	mutex_lock(&data->update_lock);
+	nct6686_write(data, WDT_CNT, timeout);
+	mutex_unlock(&data->update_lock);
+
+	/* Enable soft watchdog timer */
+	nct6686_wdt_enable(wdt, true);
+	return 0;
+}
+
+static unsigned int nct6686_wdt_get_timeleft(struct watchdog_device *wdt)
+{
+	struct nct6683_data *data = watchdog_get_drvdata(wdt);
+	int ret;
+
+	mutex_lock(&data->update_lock);
+	ret = nct6686_read(data, WDT_CNT);
+	mutex_unlock(&data->update_lock);
+	if (ret < 0)
+		return 0;
+
+	return ret;
+}
+
+static const struct watchdog_info nct6686_wdt_info = {
+	.options        = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
+			  WDIOF_MAGICCLOSE,
+	.identity       = "nct6686 watchdog",
+};
+
+static const struct watchdog_ops nct6686_wdt_ops = {
+	.owner          = THIS_MODULE,
+	.start          = nct6686_wdt_start,
+	.stop           = nct6686_wdt_stop,
+	.ping           = nct6686_wdt_ping,
+	.set_timeout    = nct6686_wdt_set_timeout,
+	.get_timeleft   = nct6686_wdt_get_timeleft,
+};
+
 static int nct6683_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1195,7 +1395,9 @@ static int nct6683_probe(struct platform_device *pdev)
 	struct device *hwmon_dev;
 	struct resource *res;
 	int groups = 0;
+	int ret;
 	char build[16];
+	u_char reg;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!devm_request_region(dev, res->start, IOREGION_LENGTH, DRVNAME))
@@ -1215,14 +1417,14 @@ static int nct6683_probe(struct platform_device *pdev)
 
 	/* By default only instantiate driver if the customer ID is known */
 	switch (data->customer_id) {
+	case NCT6683_CUSTOMER_ID_LENOVO:
+		break;
 	case NCT6683_CUSTOMER_ID_INTEL:
 		break;
 	case NCT6683_CUSTOMER_ID_MITAC:
 		break;
 	case NCT6683_CUSTOMER_ID_MSI:
 		break;
-	case NCT6683_CUSTOMER_ID_MSI2:
-		break;
 	case NCT6683_CUSTOMER_ID_ASROCK:
 		break;
 	case NCT6683_CUSTOMER_ID_ASROCK2:
@@ -1294,7 +1496,34 @@ static int nct6683_probe(struct platform_device *pdev)
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
 			nct6683_device_names[data->kind], data, data->groups);
-	return PTR_ERR_OR_ZERO(hwmon_dev);
+
+	ret = PTR_ERR_OR_ZERO(hwmon_dev);
+	if (ret)
+		return ret;
+
+	if (data->kind == nct6686 && data->customer_id == NCT6683_CUSTOMER_ID_LENOVO) {
+		/* Watchdog initialization */
+		data->wdt.ops = &nct6686_wdt_ops;
+		data->wdt.info = &nct6686_wdt_info;
+
+		data->wdt.timeout = WATCHDOG_TIMEOUT; /* Set default timeout */
+		data->wdt.min_timeout = MIN_TIMEOUT;
+		data->wdt.max_timeout = MAX_TIMEOUT;
+		data->wdt.parent = &pdev->dev;
+
+		watchdog_init_timeout(&data->wdt, timeout, &pdev->dev);
+		watchdog_set_nowayout(&data->wdt, nowayout);
+		watchdog_set_drvdata(&data->wdt, data);
+
+		/* reset trigger status */
+		reg = nct6686_read(data, WDT_STS);
+		nct6686_write(data, WDT_STS, reg & ~WDT_STS_EVT_MSK);
+
+		watchdog_stop_on_unregister(&data->wdt);
+
+		return devm_watchdog_register_device(dev, &data->wdt);
+	}
+	return ret;
 }
 
 #ifdef CONFIG_PM
-- 
2.34.1

