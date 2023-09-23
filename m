Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0D67ABE8B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjIWHlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjIWHlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:41:31 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454B4E51;
        Sat, 23 Sep 2023 00:40:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-503397ee920so5315047e87.1;
        Sat, 23 Sep 2023 00:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695454855; x=1696059655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMU1+3f9rhhujzu3jJshYss3tD8nbrjDTUeRPgbi6ws=;
        b=h4GcvH8ImLGjJoR8I5K0YeFbd7Kzu0jIohSCNT9pu4qKIVLja9HgJoV2VBum8DSNAK
         6Bh2gHR1movCBbodJ9GA+L7Uc2FTrLa6fSeyQWP1g9g4X2oXrUJRfL8nLifTuki0x8Go
         sYpswUB0TSJRQY6ZZYoacdjg0RGj7b6HCV0rvtrXlV+TeXa4eO8h2w8vx6z6LnnOniWY
         +hLNkHqwzMwTy+kTEdui8BeqRfrHTRiI9EB37pfPsWhmjIaHDiapOsZPkpzh+hzG2+U8
         npS1/1I3pJAv0uWvVLquCwbTKq2W5TMDVtBFeStSUvPol2Ve7EpgXypKpvWvN1xO71M4
         rHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695454855; x=1696059655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMU1+3f9rhhujzu3jJshYss3tD8nbrjDTUeRPgbi6ws=;
        b=TjgDkj4WLiaVabmCGDah1Kkq7YNee8Bmy1zvpUcxYlXShy2v1M8hmWEaFzoJBXJXkR
         FD76B/CCm8fdaFWJ/bXo031iTnqPD04LhLyIba/iYsVuETjyQi9FBNvVkDlHvosxClZJ
         UBDh+C70DaDhblmcajneu7dNfFYF4a0Lrh5RoCKHS76cnaMNudzxcWVnZtvOTW5o4Blc
         f89g/bB7KeT9uJkokl3sBoXV+jCChe0yEBzPhXkEB6ZS2v768x6EMZXnbDye+29JcT6i
         INkMr1jL3XLGLRuFTTHAUSw1s4WVMYCxZhOJ6M7iNenTvTeCxXGMlIW3B6betXlW6//j
         DL2Q==
X-Gm-Message-State: AOJu0Yz1rN38MvjJtXc/xn3WnycqRb0/BhHH7h8Rm/p9SwkegMWJYYmZ
        830GXvqMFBws8ZsZWpZk6sk=
X-Google-Smtp-Source: AGHT+IGlWr48iNngPUgltbTuoDJPUIknvFjjdCx1gmIr5BOEquLXsV5OAbmrp/+0KD7fEyJf/MJZ5A==
X-Received: by 2002:a05:6512:6cc:b0:500:7a21:3e78 with SMTP id u12-20020a05651206cc00b005007a213e78mr1545330lff.55.1695454855458;
        Sat, 23 Sep 2023 00:40:55 -0700 (PDT)
Received: from primary.. ([213.139.62.222])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe3c6000000b003196e992567sm6236955wrm.115.2023.09.23.00.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 00:40:55 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        ryan.eleceng@gmail.com, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v6 12/14] USB: typec: Add trace for tps25750 irq
Date:   Sat, 23 Sep 2023 03:39:57 -0400
Message-Id: <20230923073959.86660-13-alkuor@gmail.com>
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

tps25750 event1 register doesn't have all bits in tps6598x
event registers, only show the events that are masked

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v6:
  - Add trace irq to tipd callbacks factory
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c  | 17 ++++++++++++++++-
 drivers/usb/typec/tipd/trace.h | 22 ++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 661ded2ff2d5..ba28ce477f21 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -110,6 +110,7 @@ struct tipd_data {
 	int (*read_events)(struct tps6598x *tps, void *events);
 	int (*clear_events)(struct tps6598x *tps, void *events);
 	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
+	void (*trace_irq)(void *events);
 };
 
 struct tps6598x {
@@ -534,6 +535,13 @@ static int tps6598x_clear_events(struct tps6598x *tps, void *events)
 	       tps6598x_write64(tps, TPS_REG_INT_CLEAR2, e[1]);
 }
 
+static void tps6598x_trace_irq(void *events)
+{
+	uint64_t *e = events;
+
+	trace_tps6598x_irq(e[0], e[1]);
+}
+
 static int tps25750_read_events(struct tps6598x *tps, void *events)
 {
 	return tps6598x_block_read(tps, TPS_REG_INT_EVENT1, events, 11);
@@ -544,6 +552,11 @@ static int tps25750_clear_events(struct tps6598x *tps, void *events)
 	return tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, events, 11);
 }
 
+static void tps25750_trace_irq(void *events)
+{
+	trace_tps25750_irq(*(uint64_t *)events);
+}
+
 static irqreturn_t cd321x_interrupt(int irq, void *data)
 {
 	struct tps6598x *tps = data;
@@ -610,7 +623,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 		dev_err(tps->dev, "%s: failed to read events\n", __func__);
 		goto err_unlock;
 	}
-	trace_tps6598x_irq(event[0], event[1]);
+	tps->cb.trace_irq(event);
 
 	if (!(event[0] | event[1]))
 		goto err_unlock;
@@ -1155,6 +1168,7 @@ static const struct tipd_data tps6598x_data = {
 	.read_events = tps6598x_read_events,
 	.clear_events = tps6598x_clear_events,
 	.register_port = tps6598x_register_port,
+	.trace_irq = tps6598x_trace_irq,
 };
 
 static const struct tipd_data tps25750_data = {
@@ -1162,6 +1176,7 @@ static const struct tipd_data tps25750_data = {
 	.read_events = tps25750_read_events,
 	.clear_events = tps25750_clear_events,
 	.register_port = tps25750_register_port,
+	.trace_irq = tps25750_trace_irq,
 };
 
 static int tps6598x_probe(struct i2c_client *client)
diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
index 12cad1bde7cc..28725234a2d8 100644
--- a/drivers/usb/typec/tipd/trace.h
+++ b/drivers/usb/typec/tipd/trace.h
@@ -74,6 +74,13 @@
 		{ APPLE_CD_REG_INT_DATA_STATUS_UPDATE,		"DATA_STATUS_UPDATE" }, \
 		{ APPLE_CD_REG_INT_STATUS_UPDATE,		"STATUS_UPDATE" })
 
+#define show_tps25750_irq_flags(flags) \
+	__print_flags_u64(flags, "|", \
+		{ TPS_REG_INT_PLUG_EVENT,			"PLUG_EVENT" }, \
+		{ TPS_REG_INT_POWER_STATUS_UPDATE,		"POWER_STATUS_UPDATE" }, \
+		{ TPS_REG_INT_STATUS_UPDATE,			"STATUS_UPDATE" }, \
+		{ TPS_REG_INT_PD_STATUS_UPDATE,			"PD_STATUS_UPDATE" })
+
 #define TPS6598X_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_STATUS_CONN_STATE_MASK | \
 						      TPS_STATUS_PP_5V0_SWITCH_MASK | \
 						      TPS_STATUS_PP_HV_SWITCH_MASK | \
@@ -230,6 +237,21 @@ TRACE_EVENT(cd321x_irq,
 		      show_cd321x_irq_flags(__entry->event))
 );
 
+TRACE_EVENT(tps25750_irq,
+	    TP_PROTO(u64 event),
+	    TP_ARGS(event),
+
+	    TP_STRUCT__entry(
+			     __field(u64, event)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->event = event;
+			   ),
+
+	    TP_printk("event=%s", show_tps25750_irq_flags(__entry->event))
+);
+
 TRACE_EVENT(tps6598x_status,
 	    TP_PROTO(u32 status),
 	    TP_ARGS(status),
-- 
2.34.1

