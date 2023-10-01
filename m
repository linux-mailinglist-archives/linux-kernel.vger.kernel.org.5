Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1B77B460F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjJAIQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbjJAIPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:15:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101B4CCD;
        Sun,  1 Oct 2023 01:15:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a645e54806so2073325266b.0;
        Sun, 01 Oct 2023 01:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696148132; x=1696752932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgR1N5k8+EU4qN1VDI9cvb4KNqSDKnzmfopTxEYsXqs=;
        b=i6uXOmi1en2aPZSFDpYb9H6bYBIaiYgjTbjpc97m2njbKjvsaFZdVjv0iHE069PDVm
         u5tGbN6Xqw+6632o5zR/0+U4B0aYID0pMpbPO9I3OQDWdtPR9fDe3CSOprOKF1p1gPAz
         dLtKbtiL6byvkvlnXoc/F6MqWlPNhAZU9w+AM/VExIDOYINYkGrLrMSrXEfPraYDhfy0
         OHsE7fMGl9TPAnLqNKwoqnUlNdllp6Ak9bs0zE9f3m9duASig4Fz7QP+RD6if55v/1th
         +RcD8uWcBl6yopA4ionytuANulntwA6mbyxWhIM7g99wGqbWfU/QXjv+ih388mTNPriI
         mMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696148132; x=1696752932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgR1N5k8+EU4qN1VDI9cvb4KNqSDKnzmfopTxEYsXqs=;
        b=uHlOslfM0eJ5NUOYsbsnUicCuJ7M3hiYAXkWNx2CvWfGiSC4cjDu5SFfuysYXoVFs4
         gxO5yJPrJE6gwzlZy8YJ/vglItPfAw4oFS1LQHdCLZuO+qkMEGHbdoGSXPrqUtMkmXe5
         6JlaKm4qnM7KOKnHIISX/sRK9jlVAgSWmoYPXUi+ntuZX9z+lBP8hQCqJDqtv+eQyuC6
         eEq2cyC8/S/RMUDf3O5FVDwz8i5VYwqC3hDvjnfeO6JgzJhVAeus7QV1VgTFmjTv9a2g
         qABV+AG8ef08m+GjgsIOKfBDJqiA/YZPnHCROQLBdx7ipfDM4ykxh6jYoct6OweH5RsC
         /3ug==
X-Gm-Message-State: AOJu0YyM3edXGisT7LHXS7h7sBMhf1EXp71mmCjI4TOmojmvpZ/4y1JB
        Pto2Ap4oPRbaDDRCzIMV3TA=
X-Google-Smtp-Source: AGHT+IF3JMMlJg34zvbr+QQPt3DMWQCDQ9ppBaqiGFpr5Au2PKRXRqYnemAKDBDAV4f5UMFUL7Bj1w==
X-Received: by 2002:a17:907:60cd:b0:9a9:d5e7:5531 with SMTP id hv13-20020a17090760cd00b009a9d5e75531mr10113751ejc.74.1696148131828;
        Sun, 01 Oct 2023 01:15:31 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm15121841ejc.153.2023.10.01.01.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:15:31 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v9 08/14] USB: typec: tps6598x: Add interrupt support for TPS25750
Date:   Sun,  1 Oct 2023 04:11:28 -0400
Message-Id: <20231001081134.37101-9-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001081134.37101-1-alkuor@gmail.com>
References: <20231001081134.37101-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes in v9:
  - Move of_device_id to its original place
  - Move device data structs to the top of of_device_id
  - Use device_get_match_data to get device data
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

 drivers/usb/typec/tipd/core.c | 96 +++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 32e42798688f..52dc1cc16bed 100644
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
@@ -969,7 +1034,6 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 
 static int tps6598x_probe(struct i2c_client *client)
 {
-	irq_handler_t irq_handler = tps6598x_interrupt;
 	struct device_node *np = client->dev.of_node;
 	struct typec_capability typec_cap = { };
 	struct tps6598x *tps;
@@ -1017,7 +1081,6 @@ static int tps6598x_probe(struct i2c_client *client)
 			APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
 			APPLE_CD_REG_INT_PLUG_EVENT;
 
-		irq_handler = cd321x_interrupt;
 	} else {
 		/* Enable power status, data status and plug event interrupts */
 		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
@@ -1025,7 +1088,10 @@ static int tps6598x_probe(struct i2c_client *client)
 			TPS_REG_INT_PLUG_EVENT;
 	}
 
-	tps->irq_handler = irq_handler;
+	tps->data = device_get_match_data(tps->dev);
+	if (!tps->data)
+		return -EINVAL;
+
 	/* Make sure the controller has application firmware running */
 	ret = tps6598x_check_mode(tps);
 	if (ret < 0)
@@ -1125,7 +1191,7 @@ static int tps6598x_probe(struct i2c_client *client)
 
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-						irq_handler,
+						tps->data->irq_handler,
 						IRQF_SHARED | IRQF_ONESHOT,
 						dev_name(&client->dev), tps);
 	} else {
@@ -1231,10 +1297,22 @@ static const struct dev_pm_ops tps6598x_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(tps6598x_suspend, tps6598x_resume)
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
 static const struct of_device_id tps6598x_of_match[] = {
-	{ .compatible = "ti,tps6598x", },
-	{ .compatible = "apple,cd321x", },
-	{ .compatible = "ti,tps25750", },
+	{ .compatible = "ti,tps6598x", &tps6598x_data},
+	{ .compatible = "apple,cd321x", &cd321x_data},
+	{ .compatible = "ti,tps25750", &tps25750_data},
 	{}
 };
 MODULE_DEVICE_TABLE(of, tps6598x_of_match);
-- 
2.34.1

