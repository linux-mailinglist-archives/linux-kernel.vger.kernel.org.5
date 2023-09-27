Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6628F7B0B84
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjI0R6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjI0R5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:57:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D809CD5;
        Wed, 27 Sep 2023 10:57:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ae75ece209so1319880166b.3;
        Wed, 27 Sep 2023 10:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695837464; x=1696442264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg1oWc/TwN4fGrhVhvQgxMm7Z4lMcGdoKvRf8Q8jP8s=;
        b=IB8iXeGskq6V5MuWdPg/CZDjicdMtvi/hYZq5aZ5Ff4GtIWDIPmUP1KsCs6PVSsR/q
         6bV8OljBjLmQnPwARVrnMhyMWU3rCONzmsn0AfUxO3go7RuxHjyTmixqDSfAaYPRExnW
         /KANMLtS4iJGMetpwTpTXZMYLgDJCcuesOGZutdZ358QTOWq+OejdTijCA8cbfaWGvKD
         UI/c5f3XxDVP6UJqWTNNxO1xxgwueHEUPkFh43WrqAwrmtExWezvPSGfHJMg62+DjP+S
         RCAHPkAwDKuZAJQ0xSa73/5K9TYRpZ0oV8sWUBB8gG5ELMGZbNyoxA01HDESQs8NWhjt
         AZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695837464; x=1696442264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bg1oWc/TwN4fGrhVhvQgxMm7Z4lMcGdoKvRf8Q8jP8s=;
        b=eg2lEPlWYB5urRGHvDciutw6NNzztNl43cKDobQZxvIXnMRBjo+e6X1U93oGQkKx+B
         pEI4/K44wgMtV12RHlSAsmFyl0C+S2PGJKg5Z73OsJkNOghp18Ir3hY+LQe8w8yWSr99
         OdsFDTSHGEo+RA01GN+q3rcA/amb34FtAMwQFG0NE3DpqAsTQLnxDxOsfI65DCFy8GpS
         JS03xQ+rW3ULclpF2CDIOpZEdzPsCJ7rcjpBa5pc22VzbjOFblxmh+wJwIwmuMiNNUVj
         wthZJ5HgigIoLAvH5qQ+0KM4o1Yzo8mvp/YMt87r2Y1mZIXj9Pa8pTQRu8ejnFsBMSzQ
         o57g==
X-Gm-Message-State: AOJu0YzOvqr9dJ47sotbToPP2i8B7xwHUQR5dImhQsmNv3s0knIrztrW
        l0pk3Wm9k9Azk59h4VMrYDc=
X-Google-Smtp-Source: AGHT+IGPuotsgdSXtnRnKyuSZAfhG6CftycDuBiZIxlVuvfOYSlQcHeEL7lWUXjPOo0M3LjVGrCqCA==
X-Received: by 2002:a17:906:3299:b0:9a1:c44d:7056 with SMTP id 25-20020a170906329900b009a1c44d7056mr2573758ejw.26.1695837463842;
        Wed, 27 Sep 2023 10:57:43 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id d4-20020a170906370400b0099bd8c1f67esm9654593ejc.109.2023.09.27.10.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:57:43 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v7 08/14] USB: typec: tps6598x: Add interrupt support for TPS25750
Date:   Wed, 27 Sep 2023 13:53:42 -0400
Message-Id: <20230927175348.18041-9-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175348.18041-1-alkuor@gmail.com>
References: <20230927175348.18041-1-alkuor@gmail.com>
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

Create a new handler to accommodate tps25750 interrupt

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v7:
  - Add driver name to commit subject
  - Create tps25750 interrupt handler
Changes in v6:
  - Create tipd callbacks factory 
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c | 90 ++++++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 56ffffe225f2..40a76826a44e 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -101,6 +101,10 @@ static const char *const modes[] = {
 /* Unrecognized commands will be replaced with "!CMD" */
 #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
 
+struct tipd_data {
+	irq_handler_t irq_handler;
+};
+
 struct tps6598x {
 	struct device *dev;
 	struct regmap *regmap;
@@ -118,9 +122,11 @@ struct tps6598x {
 	enum power_supply_usb_type usb_type;
 
 	int wakeup;
+	u32 status; /* status reg */
 	u16 pwr_status;
 	struct delayed_work	wq_poll;
-	irq_handler_t irq_handler;
+
+	struct tipd_data cb;
 };
 
 static enum power_supply_property tps6598x_psy_props[] = {
@@ -545,6 +551,64 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
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
@@ -600,7 +664,7 @@ static void tps6598x_poll_work(struct work_struct *work)
 	struct tps6598x *tps = container_of(to_delayed_work(work),
 					    struct tps6598x, wq_poll);
 
-	tps->irq_handler(0, tps);
+	tps->cb.irq_handler(0, tps);
 	queue_delayed_work(system_power_efficient_wq,
 			   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
 }
@@ -967,9 +1031,20 @@ static int tps25750_apply_patch(struct tps6598x *tps)
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
 static int tps6598x_probe(struct i2c_client *client)
 {
-	irq_handler_t irq_handler = tps6598x_interrupt;
 	struct device_node *np = client->dev.of_node;
 	struct typec_capability typec_cap = { };
 	struct tps6598x *tps;
@@ -1017,15 +1092,18 @@ static int tps6598x_probe(struct i2c_client *client)
 			APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
 			APPLE_CD_REG_INT_PLUG_EVENT;
 
-		irq_handler = cd321x_interrupt;
+		tps->cb = cd321x_data;
 	} else {
+		if (is_tps25750)
+			tps->cb = tps25750_data;
+		else
+			tps->cb = tps6598x_data;
 		/* Enable power status, data status and plug event interrupts */
 		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
 			TPS_REG_INT_DATA_STATUS_UPDATE |
 			TPS_REG_INT_PLUG_EVENT;
 	}
 
-	tps->irq_handler = irq_handler;
 	/* Make sure the controller has application firmware running */
 	ret = tps6598x_check_mode(tps);
 	if (ret < 0)
@@ -1125,7 +1203,7 @@ static int tps6598x_probe(struct i2c_client *client)
 
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-						irq_handler,
+						tps->cb.irq_handler,
 						IRQF_SHARED | IRQF_ONESHOT,
 						dev_name(&client->dev), tps);
 	} else {
-- 
2.34.1

