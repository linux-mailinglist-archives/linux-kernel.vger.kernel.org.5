Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2667A3672
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbjIQP2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjIQP1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:27:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AEE187;
        Sun, 17 Sep 2023 08:27:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40472c3faadso35587655e9.2;
        Sun, 17 Sep 2023 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694964457; x=1695569257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tQbjNBA0eBP8DdL0NmRWM+a5YA5TtpgDMffVlXzxR0=;
        b=LVAOd8qjwniXU/6gVi88gXGJZWSjTWRpGnnDO21kBvYTpG20pMQFQtIG9j4LET9i8C
         Bu2vJqCa3Kyl6dWH7ds/ZyITW9zSVsnuDJSbjxYgafKPqyQ4uQNcfGtApAiCTzhgInAo
         ErlRHP0imguDxh0SDaCLJ6ShaYmsCXEaBJ+prPuvivp2AqKbIYo3hPhIlJNm7sSzj5NN
         lCIfh0NDiUMBGB8ZRqxI1M+ARUdEBj73mSRaknMLpw77fWTLoFjij1fHj3L1z2zfCIPs
         Zth+RMDurKJya37AUeHRxYXnJT7Qs08n3R15NHRHFOArHcQZjkNB/S/DWbWe1NhQPQhW
         k46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694964457; x=1695569257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tQbjNBA0eBP8DdL0NmRWM+a5YA5TtpgDMffVlXzxR0=;
        b=MHmtSipM8is/pDhjVslD95Li27Rd6DP3f89HpGFM6GSklnd++G5/OYSHgNz5w6/2Bo
         v5FPPCA5pY/ce+ASg7LpMqqVf+YUq+fQu0j04fxl8DJy0mVxDAUAWgRu4vbo/wKVru6r
         fcAQHNoNgR+MDIC1XSYHUh2QVCyTH6ljfo7CPiWk7xMbThlcHCKBIfVVUC5qGKa/vo6/
         wkEE2p+cCANbcQmnqTNOgDMpUXiV5OGnpoJiEbmzq4E1x4zfNQ1FmisxcplJhZFF1qzE
         PnZGDWn0MYJvXHR/lxais6czmLnwG0SG4hBPo+fakdsBCyZ9dn3jLSOEkPBBnRmUjMKO
         X5hg==
X-Gm-Message-State: AOJu0YzP1/edZyfheOrxCGobklPPpA7C1Icma/qODkat/Uh/cnz0EF11
        g7okfM00bVF+DcNgBdYBvDQ=
X-Google-Smtp-Source: AGHT+IEzHH309aK1MdqEVdMZK5QwworImmdO54o7bTeVFiV3eTQuv0wiAWiEeP7n2zNb9NGtwNRLpw==
X-Received: by 2002:a1c:4c0f:0:b0:402:fec4:fddc with SMTP id z15-20020a1c4c0f000000b00402fec4fddcmr5523275wmf.17.1694964457063;
        Sun, 17 Sep 2023 08:27:37 -0700 (PDT)
Received: from localhost.localdomain ([5.45.134.53])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c489700b003fe15ac0934sm7388865wmp.1.2023.09.17.08.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:27:36 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: [PATCH v5 08/15] USB: typec: Add interrupt support for TPS25750
Date:   Sun, 17 Sep 2023 11:26:32 -0400
Message-Id: <20230917152639.21443-9-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230917152639.21443-1-alkuor@gmail.com>
References: <20230917152639.21443-1-alkuor@gmail.com>
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

Update tps6598x interrupt handler to accommodate tps25750 interrupt

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
 drivers/usb/typec/tipd/core.c | 49 +++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index bd5436fd88fd..17b3bc480f97 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -120,6 +120,7 @@ struct tps6598x {
 	enum power_supply_usb_type usb_type;
 
 	int wakeup;
+	u32 status; /* status reg */
 	u16 pwr_status;
 	struct delayed_work	wq_poll;
 	irq_handler_t irq_handler;
@@ -539,50 +540,71 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
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
+	if (tps->is_tps25750) {
+		ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event, 11);
+	} else {
+		ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event[0]);
+		ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event[1]);
+	}
+
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
+		tps6598x_has_role_changed(tps, status))
 		tps6598x_handle_plug_event(tps, status);
 
+	tps->status = status;
 err_clear_ints:
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
+	if (tps->is_tps25750) {
+		tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event, 11);
+	} else {
+		tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event[0]);
+		tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event[1]);
+	}
 
 err_unlock:
 	mutex_unlock(&tps->lock);
 
-	if (event1 | event2)
+	if (event[0] | event[1])
 		return IRQ_HANDLED;
 	return IRQ_NONE;
 }
@@ -1003,7 +1025,6 @@ static int tps6598x_probe(struct i2c_client *client)
 
 		irq_handler = cd321x_interrupt;
 	} else {
-
 		tps->is_tps25750 = of_device_is_compatible(np, "ti,tps25750");
 		/* Enable power status, data status and plug event interrupts */
 		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
-- 
2.34.1

