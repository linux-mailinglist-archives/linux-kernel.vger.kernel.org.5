Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA757ABE85
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjIWHlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjIWHk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:40:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2739719E;
        Sat, 23 Sep 2023 00:40:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40537481094so30022165e9.0;
        Sat, 23 Sep 2023 00:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695454848; x=1696059648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NngsX8OKUIlXcUyUeEx3ndnNs3TPCLexEhwQVJVkbuQ=;
        b=Hzz5s5CW9IHN892hZa/nOLwGTbsoqNLM6Jh3CmYFnHV2a69A4BvINHZa0UFmY9qopT
         KYhB/RCVsL2n5upjiRddXX1yqZG6E0NsL+BXKfb37otR2IOuEVMIRszk19DBfRRFOWyC
         7mpElL3A9hb4Z+wwBQpF7cn1QQAlOcpxJy5jTYHoaEnHo09sUUI9SslQoSd2ZoLyea/f
         PPPiwz56wc5azVVE2vWNlhij9gL29ihDP0NOYv60IC5oQeXg8THotng45UVEdReqkWUl
         VioyWNzREgImSccBKQew3hvvqJFZceUcQv4S45D6u8sDjufPbSh/QmjBAgyeLFtEF88I
         gsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695454848; x=1696059648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NngsX8OKUIlXcUyUeEx3ndnNs3TPCLexEhwQVJVkbuQ=;
        b=GTI/JdGKi+xbDv1TpJ2wncxd7Pj3HyPMzGAKX9mslvKvdsBJiO7eCPpLTTiJrif2X8
         JDhZPgAnNQkNM89tph926aHqOPyybclCoj/DqIr92z7KtDEuZT/U7IXPGCnrlUN37G33
         xfJHh00aar2WYQkLC9rd7o9uj4Uv/77srEXZWqmixPzrwVVhsO2zKca31jIWO33E9hWH
         8lXmvJV9u5EUtAwodyd5jfyZE09w1n63px76xOLx2NjSErHY9CdunuJmQwYs6+rLFhKI
         xh0aPIhJT+hF11P9gbVNway3ppBWBY18enuX+KhuckL9xUw9l4+GMhMDQYDBkLAvzs4X
         Nd4A==
X-Gm-Message-State: AOJu0YxXHD8sOuyf/VPGz0dKKErOcF6oOWzOgFzD4Z2e1smwVvTKUJc0
        J95JEW7QhWwneS9TqxsC0Dz4pegraztAuL7dxec=
X-Google-Smtp-Source: AGHT+IGYlEaE7FWRiCnUFm3LHqvabtkBg0/2PG1TllGJ+XC9i89rFN/RCwp34Y2K7e/aUSfFWqNczw==
X-Received: by 2002:a1c:4b04:0:b0:402:ff8d:609b with SMTP id y4-20020a1c4b04000000b00402ff8d609bmr1224520wma.33.1695454848232;
        Sat, 23 Sep 2023 00:40:48 -0700 (PDT)
Received: from primary.. ([213.139.62.222])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe3c6000000b003196e992567sm6236955wrm.115.2023.09.23.00.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 00:40:47 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        ryan.eleceng@gmail.com, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v6 08/14] USB: typec: Add interrupt support for TPS25750
Date:   Sat, 23 Sep 2023 03:39:53 -0400
Message-Id: <20230923073959.86660-9-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923073959.86660-1-alkuor@gmail.com>
References: <20230923073959.86660-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

Update tps6598x interrupt handler to accommodate tps25750 interrupt

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v6:
  - Create tipd callbacks factory 
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c | 102 +++++++++++++++++++++++++++-------
 1 file changed, 83 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 56ffffe225f2..cde52afe5097 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -101,6 +101,14 @@ static const char *const modes[] = {
 /* Unrecognized commands will be replaced with "!CMD" */
 #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
 
+struct tps6598x;
+
+struct tipd_data {
+	irq_handler_t irq_handler;
+	int (*read_events)(struct tps6598x *tps, void *events);
+	int (*clear_events)(struct tps6598x *tps, void *events);
+};
+
 struct tps6598x {
 	struct device *dev;
 	struct regmap *regmap;
@@ -118,9 +126,11 @@ struct tps6598x {
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
@@ -500,6 +510,32 @@ static void tps6598x_handle_plug_event(struct tps6598x *tps, u32 status)
 	}
 }
 
+static int tps6598x_read_events(struct tps6598x *tps, void *events)
+{
+	uint64_t *e = events;
+
+	return tps6598x_read64(tps, TPS_REG_INT_EVENT1, &e[0]) |
+	       tps6598x_read64(tps, TPS_REG_INT_EVENT2, &e[1]);
+}
+
+static int tps6598x_clear_events(struct tps6598x *tps, void *events)
+{
+	uint64_t *e = events;
+
+	return tps6598x_write64(tps, TPS_REG_INT_CLEAR1, e[0]) |
+	       tps6598x_write64(tps, TPS_REG_INT_CLEAR2, e[1]);
+}
+
+static int tps25750_read_events(struct tps6598x *tps, void *events)
+{
+	return tps6598x_block_read(tps, TPS_REG_INT_EVENT1, events, 11);
+}
+
+static int tps25750_clear_events(struct tps6598x *tps, void *events)
+{
+	return tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, events, 11);
+}
+
 static irqreturn_t cd321x_interrupt(int irq, void *data)
 {
 	struct tps6598x *tps = data;
@@ -545,50 +581,60 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
 	return IRQ_NONE;
 }
 
+static bool tps6598x_has_role_changed(struct tps6598x *tps, u32 status)
+{
+	status ^= tps->status;
+
+	return status & (TPS_STATUS_PORTROLE | TPS_STATUS_DATAROLE);
+}
+
 static irqreturn_t tps6598x_interrupt(int irq, void *data)
 {
 	struct tps6598x *tps = data;
-	u64 event1 = 0;
-	u64 event2 = 0;
+	u64 event[2] = { };
 	u32 status;
 	int ret;
 
 	mutex_lock(&tps->lock);
 
-	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
-	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
+	ret = tps->cb.read_events(tps, event);
 	if (ret) {
 		dev_err(tps->dev, "%s: failed to read events\n", __func__);
 		goto err_unlock;
 	}
-	trace_tps6598x_irq(event1, event2);
+	trace_tps6598x_irq(event[0], event[1]);
 
-	if (!(event1 | event2))
+	if (!(event[0] | event[1]))
 		goto err_unlock;
 
 	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
+	if ((event[0] | event[1]) & TPS_REG_INT_POWER_STATUS_UPDATE)
 		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
+	if ((event[0] | event[1]) & TPS_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
 
-	/* Handle plug insert or removal */
-	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
+	/*
+	 * data/port roles could be updated independently after
+	 * a plug event. Therefore, we need to check
+	 * for pr/dr status change to set TypeC dr/pr accordingly.
+	 */
+	if ((event[0] | event[1]) & TPS_REG_INT_PLUG_EVENT ||
+	    tps6598x_has_role_changed(tps, status))
 		tps6598x_handle_plug_event(tps, status);
 
+	tps->status = status;
 err_clear_ints:
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
+	tps->cb.clear_events(tps, event);
 
 err_unlock:
 	mutex_unlock(&tps->lock);
 
-	if (event1 | event2)
+	if (event[0] | event[1])
 		return IRQ_HANDLED;
 	return IRQ_NONE;
 }
@@ -600,7 +646,7 @@ static void tps6598x_poll_work(struct work_struct *work)
 	struct tps6598x *tps = container_of(to_delayed_work(work),
 					    struct tps6598x, wq_poll);
 
-	tps->irq_handler(0, tps);
+	tps->cb.irq_handler(0, tps);
 	queue_delayed_work(system_power_efficient_wq,
 			   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
 }
@@ -967,9 +1013,24 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 	return 0;
 };
 
+static const struct tipd_data cd321x_data = {
+	.irq_handler = cd321x_interrupt,
+};
+
+static const struct tipd_data tps6598x_data = {
+	.irq_handler = tps6598x_interrupt,
+	.read_events = tps6598x_read_events,
+	.clear_events = tps6598x_clear_events,
+};
+
+static const struct tipd_data tps25750_data = {
+	.irq_handler = tps6598x_interrupt,
+	.read_events = tps25750_read_events,
+	.clear_events = tps25750_clear_events,
+};
+
 static int tps6598x_probe(struct i2c_client *client)
 {
-	irq_handler_t irq_handler = tps6598x_interrupt;
 	struct device_node *np = client->dev.of_node;
 	struct typec_capability typec_cap = { };
 	struct tps6598x *tps;
@@ -1017,15 +1078,18 @@ static int tps6598x_probe(struct i2c_client *client)
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
@@ -1125,7 +1189,7 @@ static int tps6598x_probe(struct i2c_client *client)
 
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-						irq_handler,
+						tps->cb.irq_handler,
 						IRQF_SHARED | IRQF_ONESHOT,
 						dev_name(&client->dev), tps);
 	} else {
-- 
2.34.1

