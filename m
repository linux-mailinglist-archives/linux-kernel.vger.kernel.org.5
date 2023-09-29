Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4AF7B355E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjI2Oce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbjI2OcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:32:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43167CDE;
        Fri, 29 Sep 2023 07:32:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1916958166b.1;
        Fri, 29 Sep 2023 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695997930; x=1696602730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6cndaHgXnb2S15BU3PnP0VkZgs3jUstsWRylsqE55Y=;
        b=gb/eaqJxf1i8qOi3rEB/hJ3f8t7J14QFJM7KjaicLnqbLwZyEYzny2tYt+vjD8aYuI
         bSO2s55ggbAzcsH/LPSrcTuRFUCHWKOqEyPpBzTKENG9SsBERlIXRyaKczXtuutfA9TR
         pqcd0fhH97hbcKWUbMrzMi0ej+p+6yxcNQjZztVwOfm4DDpOzFjMgbHoSd/mL3531M0F
         x23mtcvZcXPiZASzwlLGG1vAhKEdTQbGMBv7z8IgZLvvseEBfJvBUfLojTAHrK1+Bxcc
         KtmqxSudSJ3DloUuCHnRpDPw52FKovb/iq6CkIU8VE+XV0KbdMurVgpr1uhX2kcPDYaA
         qzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997930; x=1696602730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6cndaHgXnb2S15BU3PnP0VkZgs3jUstsWRylsqE55Y=;
        b=p/3LiZihfuM+iVM5KZoFGN/BlGs92l7LnS3ql7WGoWYqIP5IXKqSO1S8OF3JDxqFnK
         utkDWD2VpXoRvLb6cZqXrOExNlBhN/rjSKObD3TRnq0/FvmbArFBk0ZvBJhrMN6g2gDi
         vYul8vGCMEHKo0aU7moy7si8FSBU76ntJ2Sw15w2N5Vqn+H4C2Cpw5jgApq45k1seXux
         l4gyV4ahy696AXNpD6sttjnSGPLWcJ9e1KASS0i2kUaebIZMPz9cKx1Oey1imfB2bDLD
         F1ZowS/nfUo4T3VbF/KlzN07e7offvU08fvF3HggXZ2pb/n40W4f+L1D1WF7K+O7qApj
         yIIg==
X-Gm-Message-State: AOJu0YwKoPb+sgphcYalbF24o3xsfg0tMHuov5HznK+CMuKuYmWN9ih7
        E03T+m0EzHGOhPiqP3RH3yI=
X-Google-Smtp-Source: AGHT+IGCgGLjRAg2mHek23dMXtQX1tXL38yESqYLoxmdyH/tFN0BP2ImOZ+4xu7efnB6nzkS1MrR8A==
X-Received: by 2002:a17:906:319b:b0:99d:e617:abeb with SMTP id 27-20020a170906319b00b0099de617abebmr3885669ejy.23.1695997930537;
        Fri, 29 Sep 2023 07:32:10 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b0099293cdbc98sm12660105ejp.145.2023.09.29.07.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:32:10 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v8 08/14] USB: typec: tps6598x: Add interrupt support for TPS25750
Date:   Fri, 29 Sep 2023 10:30:49 -0400
Message-Id: <20230929143055.31360-9-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929143055.31360-1-alkuor@gmail.com>
References: <20230929143055.31360-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

tps25750 event registers structure is different than tps6598x's,
tps25750 has 11 bytes of events which are read at once where
tps6598x has two event registers of 8 bytes each which are read
separately. Likewise MASK event registers. Also, not all events
are supported in both devices.

- Create a new handler to accommodate tps25750 interrupt
- Add device data to of_device_id

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v8:
  - Populate of_device_id with device data
  - Change tps->cb to tps->data
  - Assign matched data to tps data
Changes in v7:
  - Add driver name to commit subject
  - Create tps25750 interrupt handler
Changes in v6:
  - Create tipd callbacks factory 
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c | 109 +++++++++++++++++++++++++++++-----
 1 file changed, 95 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 32e42798688f..9dc4c3ae5c60 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -18,6 +18,7 @@
 #include <linux/usb/role.h>
 #include <linux/workqueue.h>
 #include <linux/firmware.h>
+#include <linux/of_device.h>
 
 #include "tps6598x.h"
 #include "trace.h"
@@ -101,6 +102,10 @@ static const char *const modes[] = {
 /* Unrecognized commands will be replaced with "!CMD" */
 #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
 
+struct tipd_data {
+	irq_handler_t irq_handler;
+};
+
 struct tps6598x {
 	struct device *dev;
 	struct regmap *regmap;
@@ -118,9 +123,11 @@ struct tps6598x {
 	enum power_supply_usb_type usb_type;
 
 	int wakeup;
+	u32 status; /* status reg */
 	u16 pwr_status;
 	struct delayed_work	wq_poll;
-	irq_handler_t irq_handler;
+
+	const struct tipd_data *data;
 };
 
 static enum power_supply_property tps6598x_psy_props[] = {
@@ -545,6 +552,64 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
 	return IRQ_NONE;
 }
 
+static bool tps6598x_has_role_changed(struct tps6598x *tps, u32 status)
+{
+	status ^= tps->status;
+
+	return status & (TPS_STATUS_PORTROLE | TPS_STATUS_DATAROLE);
+}
+
+static irqreturn_t tps25750_interrupt(int irq, void *data)
+{
+	struct tps6598x *tps = data;
+	u64 event[2] = { };
+	u32 status;
+	int ret;
+
+	mutex_lock(&tps->lock);
+
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event, 11);
+	if (ret) {
+		dev_err(tps->dev, "%s: failed to read events\n", __func__);
+		goto err_unlock;
+	}
+
+	if (!(event[0] | event[1]))
+		goto err_unlock;
+
+	if (!tps6598x_read_status(tps, &status))
+		goto err_clear_ints;
+
+	if ((event[0] | event[1]) & TPS_REG_INT_POWER_STATUS_UPDATE)
+		if (!tps6598x_read_power_status(tps))
+			goto err_clear_ints;
+
+	if ((event[0] | event[1]) & TPS_REG_INT_DATA_STATUS_UPDATE)
+		if (!tps6598x_read_data_status(tps))
+			goto err_clear_ints;
+
+	/*
+	 * data/port roles could be updated independently after
+	 * a plug event. Therefore, we need to check
+	 * for pr/dr status change to set TypeC dr/pr accordingly.
+	 */
+	if ((event[0] | event[1]) & TPS_REG_INT_PLUG_EVENT ||
+	    tps6598x_has_role_changed(tps, status))
+		tps6598x_handle_plug_event(tps, status);
+
+	tps->status = status;
+
+err_clear_ints:
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event, 11);
+
+err_unlock:
+	mutex_unlock(&tps->lock);
+
+	if (event[0] | event[1])
+		return IRQ_HANDLED;
+	return IRQ_NONE;
+}
+
 static irqreturn_t tps6598x_interrupt(int irq, void *data)
 {
 	struct tps6598x *tps = data;
@@ -600,7 +665,7 @@ static void tps6598x_poll_work(struct work_struct *work)
 	struct tps6598x *tps = container_of(to_delayed_work(work),
 					    struct tps6598x, wq_poll);
 
-	tps->irq_handler(0, tps);
+	tps->data->irq_handler(0, tps);
 	queue_delayed_work(system_power_efficient_wq,
 			   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
 }
@@ -967,13 +1032,33 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 	return 0;
 };
 
+static const struct tipd_data cd321x_data = {
+	.irq_handler = cd321x_interrupt,
+};
+
+static const struct tipd_data tps6598x_data = {
+	.irq_handler = tps6598x_interrupt,
+};
+
+static const struct tipd_data tps25750_data = {
+	.irq_handler = tps25750_interrupt,
+};
+
+static const struct of_device_id tps6598x_of_match[] = {
+	{ .compatible = "ti,tps6598x", &tps6598x_data},
+	{ .compatible = "apple,cd321x", &cd321x_data},
+	{ .compatible = "ti,tps25750", &tps25750_data},
+	{}
+};
+MODULE_DEVICE_TABLE(of, tps6598x_of_match);
+
 static int tps6598x_probe(struct i2c_client *client)
 {
-	irq_handler_t irq_handler = tps6598x_interrupt;
 	struct device_node *np = client->dev.of_node;
 	struct typec_capability typec_cap = { };
 	struct tps6598x *tps;
 	struct fwnode_handle *fwnode;
+	const struct of_device_id *match;
 	u32 status;
 	u32 conf;
 	u32 vid;
@@ -1017,7 +1102,6 @@ static int tps6598x_probe(struct i2c_client *client)
 			APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
 			APPLE_CD_REG_INT_PLUG_EVENT;
 
-		irq_handler = cd321x_interrupt;
 	} else {
 		/* Enable power status, data status and plug event interrupts */
 		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
@@ -1025,7 +1109,12 @@ static int tps6598x_probe(struct i2c_client *client)
 			TPS_REG_INT_PLUG_EVENT;
 	}
 
-	tps->irq_handler = irq_handler;
+	match = of_match_device(tps6598x_of_match, tps->dev);
+	if (!match)
+		return -EINVAL;
+
+	tps->data = match->data;
+
 	/* Make sure the controller has application firmware running */
 	ret = tps6598x_check_mode(tps);
 	if (ret < 0)
@@ -1125,7 +1214,7 @@ static int tps6598x_probe(struct i2c_client *client)
 
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-						irq_handler,
+						tps->data->irq_handler,
 						IRQF_SHARED | IRQF_ONESHOT,
 						dev_name(&client->dev), tps);
 	} else {
@@ -1231,14 +1320,6 @@ static const struct dev_pm_ops tps6598x_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(tps6598x_suspend, tps6598x_resume)
 };
 
-static const struct of_device_id tps6598x_of_match[] = {
-	{ .compatible = "ti,tps6598x", },
-	{ .compatible = "apple,cd321x", },
-	{ .compatible = "ti,tps25750", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, tps6598x_of_match);
-
 static const struct i2c_device_id tps6598x_id[] = {
 	{ "tps6598x" },
 	{ }
-- 
2.34.1

