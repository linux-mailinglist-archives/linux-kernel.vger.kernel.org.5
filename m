Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453397BA08F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbjJEOih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbjJEOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:35:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABFD93D7;
        Thu,  5 Oct 2023 01:52:26 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso534514b3a.2;
        Thu, 05 Oct 2023 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696495945; x=1697100745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUkS6wMtaxA5uunPctyTHaq2tck/+416ywTiH4ESHuo=;
        b=TTsqWI78oOJtzCRYVOYSCP3Xha/LC8LB5iNwb1tkhlfAmpD88c4z5WnznfPWK1PB26
         eJnl/4T/zYdDnmhz4p8BxdoSvWgbY4ndPGwVH+mV2kjJiozphBmPtuMYFzm0OExEXwh2
         hmQwWse+X2jw7FBpaHM2ZupS0LOV/efnWe88DSTgjQfnf3EsEDxld3iH4ggRU9OcnFSn
         ZuL5FAvswBPZIUCQC5rZGpOup7vi2Ks6QaHWpV/M5ifVtZLimblBYRnu9Zi4fYs21b8v
         nQjBExGN8bBhRYdxKGK87HQt/EiSpj6Arf0uvCl7e7yFUMqbfSfiwf9YSQ/4rcPjU0I+
         j2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696495945; x=1697100745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUkS6wMtaxA5uunPctyTHaq2tck/+416ywTiH4ESHuo=;
        b=Apl6IHARVYXHoHop97P/IPL1g/XXT4SvPV63Scty791mmHj+AkhsIexmUe/pZ1NrvW
         H27xS/j+hSPzlPZ/hZIGPHQPLrd9JQ2qZ1q8r2uuMaaG16tjPtsAJ0cGf9bTagKpo+gO
         rAanKuMVAxHXgHH/nz5bflM86sSvFHsJ9/XJUl72iJ3Tjjz4UzFGEtWKwWD8SmpPFAsO
         +AYXwotLlv8VsKIFcXzZnqjchMFKbt79VAAKnU8+5XS42WfNgSkIbNB5rb9hh12cax3q
         h6hKuLwc8Knypzl5SshSCGBCjSCREs7qOXBBF+owb1EHXI/i96O7edv+hVDgCJMrfIxp
         AyAA==
X-Gm-Message-State: AOJu0YxTiNZjkVky1REL1F7M+XJp76Q+KWJAnuHl7FLwOqWE+cElscdA
        UYh5AXXazPba/VoPXhOkZZZtWqh7mLsuTg==
X-Google-Smtp-Source: AGHT+IGSDhxxF/QhqslmQbhj6F5951BdKdtUFUCEty2MOQx/wlntJDKMgJRjMW8MSUvGSCr4SZ8Pfw==
X-Received: by 2002:a05:6a00:23ce:b0:68e:3eb6:d45 with SMTP id g14-20020a056a0023ce00b0068e3eb60d45mr5052132pfc.30.1696495945126;
        Thu, 05 Oct 2023 01:52:25 -0700 (PDT)
Received: from wenkaidev (118-163-147-182.hinet-ip.hinet.net. [118.163.147.182])
        by smtp.gmail.com with ESMTPSA id e18-20020aa78c52000000b0068fb8080939sm865701pfd.65.2023.10.05.01.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 01:52:24 -0700 (PDT)
From:   advantech.susiteam@gmail.com
To:     advantech.susiteam@gmail.com
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 5/5] watchdog: eiois200_wdt: Enhanced IRQ trigger behavior
Date:   Thu,  5 Oct 2023 16:51:23 +0800
Message-Id: <0ddce182fa353592979be2a6762e89a1dc436985.1696495372.git.advantech.susiteam@gmail.com>
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

This patch improved functionality when IRQ is used as the trigger event.

When the IRQ event selected. If the pretimeout is specified, when the
pretimeout time expires, it will trigger the associated IRQ event and
invoke the pretimeout governor's actions.

And, if the pretimeout is not specified, when the timeout time expires,
the driver initiates an emergency system restart.

Signed-off-by: Wenkai <advantech.susiteam@gmail.com>
---
 drivers/watchdog/eiois200_wdt.c | 237 ++++++++++++++++++++++++++++++--
 1 file changed, 228 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/eiois200_wdt.c b/drivers/watchdog/eiois200_wdt.c
index 85179806ab7e..c9acb63b1152 100644
--- a/drivers/watchdog/eiois200_wdt.c
+++ b/drivers/watchdog/eiois200_wdt.c
@@ -2,10 +2,34 @@
 /*
  * Advantech EIO-IS200 Watchdog Driver
  *
+ * This driver enables watchdog functionality for the Advantech EIO-IS200
+ * embedded controller. Its has a dependency on the eiois200_core module.
+ * It allows the specification of a timeout or pretimeout associated trigger
+ * event, which can be one of the following pins:
+ * - PWRBTN (Power button)
+ * - SCI (ACPI System Control Interrupt)
+ * - IRQ
+ * - GPIO
+ *
+ * If the pretimeout is specified, when the pretimeout time expires, it
+ * triggers the associated pin; if the timeout expires, it always triggers
+ * a reset. If the associated pin is IRQ, the IRQ will trigger the system's
+ * original pretimeout behavior through the pretimeout governor.
+ *
+ * If the pretimeout is not specified, the timeout expiration triggers the
+ * associated pin only. If the associated pin is IRQ, it triggers a system
+ * emergency restart.
+ *
+ * NOTE: Advantech machines are shipped with proper IRQ and related event
+ * configurations. If you are unsure about these settings, just keep the
+ * device's default settings, and load this module without specifying any
+ * parameters.
+ *
  * Copyright (C) 2023 Advantech Co., Ltd.
  * Author: wenkai <advantech.susiteam@gmail.com>
  */
 
+#include <linux/interrupt.h>
 #include <linux/mfd/core.h>
 #include <linux/reboot.h>
 #include <linux/uaccess.h>
@@ -59,7 +83,7 @@
 #define PMC_READ(cmd, data)	pmc(CMD_WDT_READ, cmd, data)
 
 /* Mapping event type to supported bit */
-#define EVENT_BIT(type)   	BIT(type + 2)
+#define EVENT_BIT(type)	BIT(type + 2)
 
 enum event_type {
 	EVENT_NONE,
@@ -72,6 +96,7 @@ enum event_type {
 static struct _wdt {
 	u32	event_type;
 	u32	support;
+	u32	irq;
 	long	last_time;
 	struct	regmap  *iomap;
 	struct	device *dev;
@@ -101,6 +126,12 @@ static char *event_type = "NONE";
 module_param(event_type, charp, 0);
 MODULE_PARM_DESC(event_type,
 		 "Watchdog timeout event type (RESET, PWRBTN, SCI, IRQ, GPIO)");
+
+/* Specify the IRQ number when the IRQ event is triggered */
+static int irq;
+module_param(irq, int, 0);
+MODULE_PARM_DESC(irq, "The IRQ number for IRQ event");
+
 static struct watchdog_info wdinfo = {
 	.identity = KBUILD_MODNAME,
 	.options  = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
@@ -145,8 +176,8 @@ static int wdt_get_type(void)
 				return -EINVAL;
 			}
 
-			dev_info(wdt.dev, "Trigger type is %d:%s\n", 
-					  i, type_strs[i]);
+			dev_info(wdt.dev, "Trigger type is %d:%s\n",
+				 i, type_strs[i]);
 			wdt.event_type = i;
 
 			return 0;
@@ -204,7 +235,7 @@ static int wdt_set_config(void)
 		if (wddev.timeout < wddev.pretimeout)
 			return -EINVAL;
 
-	reset_time = wddev.timeout;
+		reset_time = wddev.timeout;
 		event_time = wddev.timeout - wddev.pretimeout;
 
 	} else if (wddev.timeout) {
@@ -228,7 +259,7 @@ static int wdt_set_config(void)
 	dev_dbg(wdt.dev, "Config wdt reset time %d\n", reset_time);
 	dev_dbg(wdt.dev, "Config wdt event time %d\n", event_time);
 	dev_dbg(wdt.dev, "Config wdt event type %s\n",
-			  type_strs[wdt.event_type]);
+		type_strs[wdt.event_type]);
 
 	return ret;
 }
@@ -261,11 +292,11 @@ static int wdt_get_config(void)
 			if (reset_time < event_time)
 				continue;
 
-	wddev.timeout	 = reset_time;
+			wddev.timeout = reset_time;
 			wddev.pretimeout = reset_time - event_time;
 
 			dev_dbg(wdt.dev, "Pretimeout H/W enabled with event %s of %d secs\n",
-				 type_strs[type], wddev.pretimeout);
+				type_strs[type], wddev.pretimeout);
 		} else {
 			wddev.timeout = event_time;
 			wddev.pretimeout = 0;
@@ -274,7 +305,7 @@ static int wdt_get_config(void)
 		wdt.event_type = type;
 
 		dev_dbg(wdt.dev, "Timeout H/W enabled of %d secs\n",
-				  wddev.timeout);
+			wddev.timeout);
 		return 0;
 	}
 
@@ -359,6 +390,180 @@ static int wdt_support(void)
 	return 0;
 }
 
+static int wdt_get_irq_io(void)
+{
+	int ret  = 0;
+	int idx  = EIOIS200_PNP_INDEX;
+	int data = EIOIS200_PNP_DATA;
+	struct regmap *map = wdt.iomap;
+
+	mutex_lock(&eiois200_dev->mutex);
+
+	/* Unlock EC IO port */
+	ret |= regmap_write(map, idx,  IOREG_UNLOCK);
+	ret |= regmap_write(map, idx,  IOREG_UNLOCK);
+
+	/* Select logical device to PMC */
+	ret |= regmap_write(map, idx,  IOREG_LDN);
+	ret |= regmap_write(map, data, IOREG_LDN_PMCIO);
+
+	/* Get IRQ number */
+	ret |= regmap_write(map, idx,  IOREG_IRQ);
+	ret |= regmap_read(map, data, &wdt.irq);
+
+	/* Lock up */
+	ret |= regmap_write(map, idx,  IOREG_LOCK);
+
+	mutex_unlock(&eiois200_dev->mutex);
+
+	return ret ? -EIO : 0;
+}
+
+static int wdt_get_irq_pmc(void)
+{
+	return PMC_READ(REG_IRQ_NUMBER, &wdt.irq);
+}
+
+static int wdt_get_irq(struct device *dev)
+{
+	int ret;
+
+	if ((wdt.support & BIT(EVENT_IRQ)) == 0)
+		return -ENODEV;
+
+	/* Get IRQ number through PMC */
+	ret = wdt_get_irq_pmc();
+	if (ret)
+		return dev_err_probe(dev, ret, "Error get irq by pmc\n");
+
+	if (wdt.irq)
+		return 0;
+
+	/* Get IRQ number from the watchdog device in EC */
+	ret = wdt_get_irq_io();
+	if (ret)
+		return dev_err_probe(dev, ret, "Error get irq by io\n");
+
+	if (wdt.irq == 0)
+		return dev_err_probe(dev, ret, "Error IRQ number = 0\n");
+
+	return ret;
+}
+
+static int wdt_set_irq_io(void)
+{
+	int ret  = 0;
+	int idx  = EIOIS200_PNP_INDEX;
+	int data = EIOIS200_PNP_DATA;
+	struct regmap *map = wdt.iomap;
+
+	mutex_lock(&eiois200_dev->mutex);
+
+	/* Unlock EC IO port */
+	ret |= regmap_write(map, idx,  IOREG_UNLOCK);
+	ret |= regmap_write(map, idx,  IOREG_UNLOCK);
+
+	/* Select logical device to PMC */
+	ret |= regmap_write(map, idx,  IOREG_LDN);
+	ret |= regmap_write(map, data, IOREG_LDN_PMCIO);
+
+	/* Enable WDT */
+	ret |= regmap_write(map, idx,  IOREG_WDT_STATUS);
+	ret |= regmap_write(map, data, FLAG_WDT_ENABLED);
+
+	/* Set IRQ number */
+	ret |= regmap_write(map, idx,  IOREG_IRQ);
+	ret |= regmap_write(map, data, wdt.irq);
+
+	/* Lock up */
+	ret |= regmap_write(map, idx,  IOREG_LOCK);
+
+	mutex_unlock(&eiois200_dev->mutex);
+
+	return ret ? -EIO : 0;
+}
+
+static int wdt_set_irq_pmc(void)
+{
+	return PMC_WRITE(REG_IRQ_NUMBER, &wdt.irq);
+}
+
+static int wdt_set_irq(struct device *dev)
+{
+	int ret;
+
+	if ((wdt.support & BIT(EVENT_IRQ)) == 0)
+		return -ENODEV;
+
+	/* Set IRQ number to the watchdog device in EC */
+	ret = wdt_set_irq_io();
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Error set irq by io\n");
+
+	/* Notice EC that watchdog IRQ changed */
+	ret = wdt_set_irq_pmc();
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Error set irq by pmc\n");
+
+	return ret;
+}
+
+/**
+ * wdt_get_irq_event - Check if IRQ been triggered
+ * Returns:	The current status read from the PMC,
+ *		or 0 if there was an error.
+ */
+static int wdt_get_irq_event(void)
+{
+	u8 status;
+
+	if (PMC_READ(REG_EVENT, &status))
+		return 0;
+
+	return status;
+}
+
+static irqreturn_t wdt_isr(int irq, void *arg)
+{
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t wdt_threaded_isr(int irq, void *arg)
+{
+	u8 status = wdt_get_irq_event() & FLAG_TRIGGER_IRQ;
+
+	if (!status)
+		return IRQ_NONE;
+
+	if (wddev.pretimeout) {
+		watchdog_notify_pretimeout(&wddev);
+	} else {
+		pr_crit("Watchdog Timer expired. Initiating system reboot\n");
+		emergency_restart();
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int query_irq(struct device *dev)
+{
+	int ret;
+
+	if (irq) {
+		wdt.irq = irq;
+	} else {
+		ret = wdt_get_irq(dev);
+		if (ret)
+			return ret;
+	}
+
+	dev_dbg(wdt.dev, "IRQ = %d\n", wdt.irq);
+
+	return wdt_set_irq(dev);
+}
+
 static int wdt_init(struct device *dev)
 {
 	int ret = 0;
@@ -374,6 +579,10 @@ static int wdt_init(struct device *dev)
 	ret = wdt_get_type();
 	if (ret)
 		return ret;
+
+	if (wdt.event_type == EVENT_IRQ)
+		ret = query_irq(dev);
+
 	return ret;
 }
 
@@ -402,11 +611,21 @@ static int wdt_probe(struct platform_device *pdev)
 	wdt.iomap = dev_get_regmap(dev->parent, NULL);
 	if (!wdt.iomap)
 		return dev_err_probe(dev, -ENOMEM, "Query parent regmap fail\n");
-	
+
 	/* Initialize EC watchdog */
 	if (wdt_init(dev))
 		return dev_err_probe(dev, -EIO, "wdt_init fail\n");
 
+	/* Request IRQ */
+	if (wdt.event_type == EVENT_IRQ)
+		ret = devm_request_threaded_irq(dev, wdt.irq, wdt_isr,
+						wdt_threaded_isr,
+						IRQF_SHARED, pdev->name, dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				    "IRQ %d request fail:%d. Disabled.\n",
+				    wdt.irq, ret);
+
 	/* Inform watchdog info */
 	wddev.ops = &wdt_ops;
 	ret = watchdog_init_timeout(&wddev, wddev.timeout, dev);
-- 
2.34.1

