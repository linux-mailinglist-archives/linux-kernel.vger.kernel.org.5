Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772427B9F2C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjJEOSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244418AbjJENxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:53:34 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FFF93D2;
        Thu,  5 Oct 2023 01:52:15 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c5c91bece9so5436955ad.3;
        Thu, 05 Oct 2023 01:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696495934; x=1697100734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgM5ckKPxNB77t1sRiLlpy3j0VyAqto+yLSEBB/aNRg=;
        b=BNSXk1jGkIh2FykCW3jyKH1DLljKVV/vo0OuYJ+hpWYw6/WAoSZqdfLgXu/u/ZNW8U
         g05XbCIwqNasy4Z2vk9a51BWV9PBJXMY1mfwThOo+cCA9x0m0MT6B4DJI1DBKoCGtRah
         TpCjjCgAMWLUw7iIuuYFnXtMpXpnMNLfS0epzQmPz184gw4pTFq62+UPXtJJeSIToaiI
         JmCu5j4yv29QbYViBTg+eTHy8IlNr9/JHQoueC5pEKhbrAveEeUp3qhKBxBnw5/trs1o
         icIPjX3s/NgF0n3djkhk8JZu95u2fx936596KkflHSg+WcKets0QuKN3puAtTxEnTa04
         heZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696495934; x=1697100734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgM5ckKPxNB77t1sRiLlpy3j0VyAqto+yLSEBB/aNRg=;
        b=wMbd2tVQ1K0EOGUsJHxKqpE+kzfsLEPO7jLiT/oZuKOZu4KEs67EImcZtNGEJ2qhsP
         CGCgsRoAOfRomUwPR/PJZTWQecOp5KYxwob3au8dRNA9JcFZyNafNquj0ycQAqZYp0fw
         8Mj/1IDJh3Bs7hKMRqd63DBo/dzqtKx3vgF48mvveqBMWpiJbohLYxSTcLsL6v5WXY6p
         Zvnp5yOVLjYnzNYNrEqr12c78MbOZw9OF9lVq88r5zdMTFykkW0qB4DsO1NXDEAXwZbs
         RzbgaL+eaxrzgUzjQcXNAXnqYgUjhnvtnhQqPD2RwsZuaqCj7FP6p/oK324MkaMnplnO
         4Dvg==
X-Gm-Message-State: AOJu0YxF2puC02EGF+FxgUUknptYWcUTsd1f22bOuiDiD5LcY9neZdNc
        gKc53x15fZETYhUYzn8Z673oxKOf7MCNZg==
X-Google-Smtp-Source: AGHT+IHaquDPsukG6jJq108ZBRy06PSDfaFfZOEMKm3D8kLZf8yJt6ZNQ2ty+aXqa8AoHdUElL3Ogg==
X-Received: by 2002:a17:902:e883:b0:1c6:19da:b29f with SMTP id w3-20020a170902e88300b001c619dab29fmr5291623plg.26.1696495934010;
        Thu, 05 Oct 2023 01:52:14 -0700 (PDT)
Received: from wenkaidev ([123.51.235.123])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f7d300b001bc59cd718asm1058645plw.278.2023.10.05.01.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 01:52:13 -0700 (PDT)
From:   advantech.susiteam@gmail.com
To:     advantech.susiteam@gmail.com
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 2/5] watchdog: eiois200_wdt: Add PMC support with eiois200_core.
Date:   Thu,  5 Oct 2023 16:51:20 +0800
Message-Id: <a3e22f8ebd9154e4fd4e11aef253de762e0523cf.1696495372.git.advantech.susiteam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696495372.git.advantech.susiteam@gmail.com>
References: <cover.1696495372.git.advantech.susiteam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenkai <advantech.susiteam@gmail.com>

All eiois200 series driver functionalities are based on PMC (Peripheral
Management Controller) communication. This patch enables communication
between the driver and the eiois200_core. However, this version does
not yet implement the watchdog timer's functionality.

Signed-off-by: Wenkai <advantech.susiteam@gmail.com>
---
 drivers/watchdog/eiois200_wdt.c | 114 ++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/watchdog/eiois200_wdt.c b/drivers/watchdog/eiois200_wdt.c
index bf132a75a2ec..ce4435ac62f2 100644
--- a/drivers/watchdog/eiois200_wdt.c
+++ b/drivers/watchdog/eiois200_wdt.c
@@ -16,6 +16,40 @@
 #define WATCHDOG_TIMEOUT	60
 #define WATCHDOG_PRETIMEOUT	10
 
+/* Support Flags */
+#define SUPPORT_AVAILABLE	BIT(0)
+#define SUPPORT_RESET		BIT(7)
+
+/* PMC registers */
+#define REG_STATUS		0x00
+#define REG_CONTROL		0x02
+#define REG_EVENT		0x10
+#define REG_RESET_EVENT_TIME	0x14
+#define REG_IRQ_NUMBER		0x17
+
+/* PMC command and control */
+#define CMD_WDT_WRITE		0x2A
+#define CMD_WDT_READ		0x2B
+#define CTRL_STOP		0x00
+#define CTRL_START		0x01
+#define CTRL_TRIGGER		0x02
+
+/* I/O register and its flags */
+#define IOREG_UNLOCK		0x87
+#define IOREG_LOCK		0xAA
+#define IOREG_LDN		0x07
+#define IOREG_LDN_PMCIO		0x0F
+#define IOREG_IRQ		0x70
+#define IOREG_WDT_STATUS	0x30
+
+/* Flags */
+#define FLAG_WDT_ENABLED	0x01
+#define FLAG_TRIGGER_IRQ	BIT(4)
+
+/* PMC read and write a value */
+#define PMC_WRITE(cmd, data)	pmc(CMD_WDT_WRITE, cmd, data)
+#define PMC_READ(cmd, data)	pmc(CMD_WDT_READ, cmd, data)
+
 static struct _wdt {
 	u32	support;
 	long	last_time;
@@ -47,6 +81,48 @@ static int wdt_set_timeout(struct watchdog_device *dev,
 	return 0;
 }
 
+static int pmc(u8 cmd, u8 ctrl, void *payload)
+{
+	struct pmc_op op = {
+		.cmd      = cmd,
+		.control  = ctrl,
+		.size     = ctrl <= REG_EVENT	   ? 1 :
+			    ctrl >= REG_IRQ_NUMBER ? 1 : 4,
+		.payload  = payload,
+	};
+
+	return eiois200_core_pmc_operation(wdt.dev, &op);
+}
+
+static int get_time(u8 ctrl, u32 *val)
+{
+	int ret;
+
+	ret = PMC_READ(ctrl, val);
+
+	/* ms to sec */
+	*val /= 1000;
+
+	return ret;
+}
+
+
+static int wdt_get_config(void)
+{
+	int ret;
+	u32 reset_time;
+
+	/* Get Reset Time */
+	ret = get_time(REG_RESET_EVENT_TIME, &reset_time);
+	if (ret)
+		return ret;
+
+	dev_info(wdt.dev, "Timeout H/W default timeout: %d secs\n", reset_time);
+	wddev.timeout	 = reset_time;
+
+	return 0;
+}
+
 static int wdt_start(struct watchdog_device *dev)
 {
 	return 0;
@@ -67,6 +143,40 @@ static unsigned int wdt_get_timeleft(struct watchdog_device *dev)
 	return 0;
 }
 
+static int wdt_support(void)
+{
+	u8 support;
+
+	if (PMC_READ(REG_STATUS, &support))
+		return -EIO;
+
+	if ((support & SUPPORT_AVAILABLE) == 0)
+		return -EIO;
+
+	/* Must support reset */
+	if ((support & SUPPORT_RESET) != SUPPORT_RESET)
+		return -EIO;
+
+	/* Must has support event **/
+	wdt.support = support;
+
+	return 0;
+}
+static int wdt_init(struct device *dev)
+{
+	int ret = 0;
+
+	ret = wdt_support();
+	if (ret)
+		return ret;
+
+	ret = wdt_get_config();
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
 static const struct watchdog_ops wdt_ops = {
 	.owner		= THIS_MODULE,
 	.start		= wdt_start,
@@ -91,6 +201,10 @@ static int wdt_probe(struct platform_device *pdev)
 	wdt.iomap = dev_get_regmap(dev->parent, NULL);
 	if (!wdt.iomap)
 		return dev_err_probe(dev, -ENOMEM, "Query parent regmap fail\n");
+	
+	/* Initialize EC watchdog */
+	if (wdt_init(dev))
+		return dev_err_probe(dev, -EIO, "wdt_init fail\n");
 
 	/* Inform watchdog info */
 	wddev.ops = &wdt_ops;
-- 
2.34.1

