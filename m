Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877E27B6DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbjJCQBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbjJCQBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:01:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BF7E9;
        Tue,  3 Oct 2023 09:00:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b6559cbd74so207188266b.1;
        Tue, 03 Oct 2023 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696348857; x=1696953657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2K7a5LL546LQr9bmpZ89EvpcKPD/ZJxo00KN8Mtq8M=;
        b=IHyHwx+yDNS63VDftlw0Fnlj00C9yIhT2DmSSYlZt95d59Di/1VP0md7MP7zulfhNO
         CwIgOg8ZVkA2XFA+NA6JY6AgjChoBTT5CTReccdq5XqWr83CjuO+l9kWUlixNMNaeg+d
         OQlVv2ozPn5D7JBZgqmyjOO2XuzX4YlXgoEmtFA08eVSirGwc2T/XpL5+1PrPp9Eh3tY
         pK4Rvd7z8zBLwdAudwaSdK8zqm1cgG5+5kuhiFtsYY3mXNgJHwpd2bf0/I4vIiIB7DRV
         Tc7fR045mu3vsV03ez68BJLSXWsVxDN76i6TgOjxC43wXFkFh3neMg2FmRhFTP2XS3sz
         lSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348857; x=1696953657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2K7a5LL546LQr9bmpZ89EvpcKPD/ZJxo00KN8Mtq8M=;
        b=OXBCvTwu65g3iZQ7NN9yz9r9iVVPLd3QzkojI+cUf2B8iJCHt09C2rR8mW0Kkfdz94
         KfcnHbNCzSQEdPyofFP26z2k+XrP/bpbn1n9XG6lpGX5UFC73VMJivdXu5jHHuf87H6+
         dtS2PR4DU3Y2Q9qMlDb8VA9Xj8tp+jajXaSTTvj7TuqpBFz2JGorQqO2K1EoQqrPl8ZK
         a80sJ1o8hKj+k60GP1XylcwclILwLj7/cRAdeOZzDbcQ6qHGHLRZvry0L/Fx/7HdmQ+N
         UK6I1RRgikVp/gm/L8hYrSlz1DCyD/aMrtz8omPbGZT5gN92pODvsua2TovV8Khv3NXe
         KxIA==
X-Gm-Message-State: AOJu0YzboJinYBlzLATToJUcbCG+OSpUNHK5Irn8Ov48NfSc2HU2+eL4
        L0FrAdCeTLU29/s3ybDMxNE=
X-Google-Smtp-Source: AGHT+IFuQVf044dXBiBHWwV1+c0G/aZrUnBxFv1UWO4U30+1nQCCo2GGOmZjsQH179AJMTk9Tm5PTA==
X-Received: by 2002:a17:906:10b:b0:9b2:794d:628a with SMTP id 11-20020a170906010b00b009b2794d628amr13329284eje.22.1696348857374;
        Tue, 03 Oct 2023 09:00:57 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id jo3-20020a170906f6c300b0099df2ddfc37sm1270526ejb.165.2023.10.03.09.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:00:57 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v10 5/9] USB: typec: tps6598x: Add device data to of_device_id
Date:   Tue,  3 Oct 2023 11:58:38 -0400
Message-Id: <20231003155842.57313-6-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003155842.57313-1-alkuor@gmail.com>
References: <20231003155842.57313-1-alkuor@gmail.com>
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

Part of tps6598x refactoring, we need to move the following functions
to device data as tps25750 has different implementation than tps6598x
and cd321x:
- interrupt handler
- port registration
- power status trace
- status trace

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v10:
  - Move 0005-USB-typec-tps6598x-Check-for-EEPROM-present.patch to patch 6
  - Add device data for tps6598x and cd321x
Changes in v9:
  - No changes
Changes in v8:
  - No changes
Changes in v7:
  - Add driver name to commit subject
Changes in v6: 
  - Update eeprom macro to use TPS instead
Changes in v5:
  - Incorporating tps25750 into tps6598x driver
 drivers/usb/typec/tipd/core.c | 57 ++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 56e4997c484a..9c973ffb4c49 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -82,6 +82,15 @@ static const char *const modes[] = {
 /* Unrecognized commands will be replaced with "!CMD" */
 #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
 
+struct tps6598x;
+
+struct tipd_data {
+	irq_handler_t irq_handler;
+	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
+	void (*trace_power_status)(u16 status);
+	void (*trace_status)(u32 status);
+};
+
 struct tps6598x {
 	struct device *dev;
 	struct regmap *regmap;
@@ -101,7 +110,8 @@ struct tps6598x {
 	int wakeup;
 	u16 pwr_status;
 	struct delayed_work	wq_poll;
-	irq_handler_t irq_handler;
+
+	const struct tipd_data *data;
 };
 
 static enum power_supply_property tps6598x_psy_props[] = {
@@ -432,7 +442,9 @@ static bool tps6598x_read_status(struct tps6598x *tps, u32 *status)
 		dev_err(tps->dev, "%s: failed to read status\n", __func__);
 		return false;
 	}
-	trace_tps6598x_status(*status);
+
+	if (tps->data->trace_status)
+		tps->data->trace_status(*status);
 
 	return true;
 }
@@ -463,7 +475,9 @@ static bool tps6598x_read_power_status(struct tps6598x *tps)
 		return false;
 	}
 	tps->pwr_status = pwr_status;
-	trace_tps6598x_power_status(pwr_status);
+
+	if (tps->data->trace_power_status)
+		tps->data->trace_power_status(pwr_status);
 
 	return true;
 }
@@ -581,7 +595,7 @@ static void tps6598x_poll_work(struct work_struct *work)
 	struct tps6598x *tps = container_of(to_delayed_work(work),
 					    struct tps6598x, wq_poll);
 
-	tps->irq_handler(0, tps);
+	tps->data->irq_handler(0, tps);
 	queue_delayed_work(system_power_efficient_wq,
 			   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
 }
@@ -765,7 +779,6 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 
 static int tps6598x_probe(struct i2c_client *client)
 {
-	irq_handler_t irq_handler = tps6598x_interrupt;
 	struct device_node *np = client->dev.of_node;
 	struct tps6598x *tps;
 	struct fwnode_handle *fwnode;
@@ -807,7 +820,6 @@ static int tps6598x_probe(struct i2c_client *client)
 			APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
 			APPLE_CD_REG_INT_PLUG_EVENT;
 
-		irq_handler = cd321x_interrupt;
 	} else {
 		/* Enable power status, data status and plug event interrupts */
 		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
@@ -815,7 +827,10 @@ static int tps6598x_probe(struct i2c_client *client)
 			TPS_REG_INT_PLUG_EVENT;
 	}
 
-	tps->irq_handler = irq_handler;
+	tps->data = device_get_match_data(tps->dev);
+	if (!tps->data)
+		return -EINVAL;
+
 	/* Make sure the controller has application firmware running */
 	ret = tps6598x_check_mode(tps);
 	if (ret)
@@ -825,10 +840,10 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
-	if (ret < 0)
+	if (!tps6598x_read_status(tps, &status)) {
+		ret = -ENODEV;
 		goto err_clear_mask;
-	trace_tps6598x_status(status);
+	}
 
 	/*
 	 * This fwnode has a "compatible" property, but is never populated as a
@@ -851,7 +866,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret)
 		goto err_role_put;
 
-	ret = tps6598x_register_port(tps, fwnode);
+	ret = tps->data->register_port(tps, fwnode);
 	if (ret)
 		goto err_role_put;
 
@@ -868,7 +883,7 @@ static int tps6598x_probe(struct i2c_client *client)
 
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-						irq_handler,
+						tps->data->irq_handler,
 						IRQF_SHARED | IRQF_ONESHOT,
 						dev_name(&client->dev), tps);
 	} else {
@@ -954,9 +969,23 @@ static const struct dev_pm_ops tps6598x_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(tps6598x_suspend, tps6598x_resume)
 };
 
+static const struct tipd_data cd321x_data = {
+	.irq_handler = cd321x_interrupt,
+	.register_port = tps6598x_register_port,
+	.trace_power_status = trace_tps6598x_power_status,
+	.trace_status = trace_tps6598x_status,
+};
+
+static const struct tipd_data tps6598x_data = {
+	.irq_handler = tps6598x_interrupt,
+	.register_port = tps6598x_register_port,
+	.trace_power_status = trace_tps6598x_power_status,
+	.trace_status = trace_tps6598x_status,
+};
+
 static const struct of_device_id tps6598x_of_match[] = {
-	{ .compatible = "ti,tps6598x", },
-	{ .compatible = "apple,cd321x", },
+	{ .compatible = "ti,tps6598x", &tps6598x_data},
+	{ .compatible = "apple,cd321x", &cd321x_data},
 	{}
 };
 MODULE_DEVICE_TABLE(of, tps6598x_of_match);
-- 
2.34.1

