Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EC77B3584
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjI2OdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbjI2Oca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:32:30 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C891708;
        Fri, 29 Sep 2023 07:32:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5335725cf84so16996586a12.2;
        Fri, 29 Sep 2023 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695997942; x=1696602742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEjsMkQ9GIeWHBCsfRSsqMZ7Yk3v0h6W2BQ04LYGZ6U=;
        b=B13FjOcgWLIe914gsuQqqzPk7RYUj5r+tsUSzc6UFKdzil30dJQkFB/CWmZY1oofd6
         m/vN/txwbWXjEMYb7wQjDI+QL06bJl7blD2m1QT92xAoXG8674OyaE1iyvAu9D9JfjDe
         duC53dFwKCN+4il8BIvNoiahLgfZ2LXKGlGe05HHl+zVntuRaDv9v1O6RQcgcasZORg9
         p6+VNdXyOEqWmlgeBql1P6+KvVUbqoMDOU/3f4QantXsgUMu4ZEwm528onRt3LmviySL
         gKLKkZz7+/ZfI762pXiFP59qbi9pfH852y1hjDl89BpRDgiKY+zQIo1tW84+Xrh55N3R
         ZxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997942; x=1696602742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEjsMkQ9GIeWHBCsfRSsqMZ7Yk3v0h6W2BQ04LYGZ6U=;
        b=T8LJZA1BHgJeFDClQToret7YSfQD6Xhh/TaG9eLXmNDezLx+rUPeELuv8ofdMqBOqA
         j5QuulE7yPgOmOZLBxnDc362WRDKOuGQlFmJF5it1MovXLyqgnf+UsLdmNoy1PCatO3k
         Ysq5h/VU4DKfOUjImkW/thlmmbZmKatCXkTuyqOBcvRRb0uFJWHyYhtZO2A7Ig9SYfIC
         W/yr02RmB3B75SvMXm2s3+l8CkUF+VT1yoNf+XVfvGIfYPR0wA2guIO8J2VOZsko2IMk
         RluXFom7KG/lj7/EIcntnzDfHkMrpadRffKlaIHYfDGpz59GE9At/vb0uHKgaiIrQTK+
         8vwg==
X-Gm-Message-State: AOJu0YxFFhF1P/AzTYD0ZxMA6IjpEI5FEpqviX/6DV3pIBun3gEoJH8i
        6WEfjqzidHY6ZM4fRaFUmmA=
X-Google-Smtp-Source: AGHT+IG/Ye25RdLBKKcGWLiRjd7cM/sOpbX9WdcF8+qlrQiugTZF48Xh5XbkrYnkWencqLhqDDTDJQ==
X-Received: by 2002:a17:906:53ce:b0:9ae:614f:bcec with SMTP id p14-20020a17090653ce00b009ae614fbcecmr4134319ejo.70.1695997942013;
        Fri, 29 Sep 2023 07:32:22 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b0099293cdbc98sm12660105ejp.145.2023.09.29.07.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:32:21 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v8 14/14] USB: typec: tps6598x: Add status trace for tps25750
Date:   Fri, 29 Sep 2023 10:30:55 -0400
Message-Id: <20230929143055.31360-15-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929143055.31360-1-alkuor@gmail.com>
References: <20230929143055.31360-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

tps25750 status register is a subset of tps6598x status register, hence
a trace for tps25750 status register is added.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v8:
  - Change tps->cb to tps->data
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
 - Add trace status to tipd data factory
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c  | 12 +++++++----
 drivers/usb/typec/tipd/trace.h | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index c7bec4464b8e..1afd598c6a1b 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -110,6 +110,7 @@ struct tipd_data {
 	irq_handler_t irq_handler;
 	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
 	void (*trace_power_status)(u16 status);
+	void (*trace_status)(u32 status);
 };
 
 struct tps6598x {
@@ -469,7 +470,9 @@ static bool tps6598x_read_status(struct tps6598x *tps, u32 *status)
 		dev_err(tps->dev, "%s: failed to read status\n", __func__);
 		return false;
 	}
-	trace_tps6598x_status(*status);
+
+	if (tps->data->trace_status)
+		tps->data->trace_status(*status);
 
 	return true;
 }
@@ -1174,18 +1177,21 @@ static const struct tipd_data cd321x_data = {
 	.irq_handler = cd321x_interrupt,
 	.register_port = tps6598x_register_port,
 	.trace_power_status = trace_tps6598x_power_status,
+	.trace_status = trace_tps6598x_status,
 };
 
 static const struct tipd_data tps6598x_data = {
 	.irq_handler = tps6598x_interrupt,
 	.register_port = tps6598x_register_port,
 	.trace_power_status = trace_tps6598x_power_status,
+	.trace_status = trace_tps6598x_status,
 };
 
 static const struct tipd_data tps25750_data = {
 	.irq_handler = tps25750_interrupt,
 	.register_port = tps25750_register_port,
 	.trace_power_status = trace_tps25750_power_status,
+	.trace_status = trace_tps25750_status,
 };
 
 static const struct of_device_id tps6598x_of_match[] = {
@@ -1272,10 +1278,8 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret)
 		goto err_reset_controller;
 
-	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
-	if (ret < 0)
+	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_mask;
-	trace_tps6598x_status(status);
 
 	/*
 	 * This fwnode has a "compatible" property, but is never populated as a
diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
index 739b0a2a867d..0669cca12ea1 100644
--- a/drivers/usb/typec/tipd/trace.h
+++ b/drivers/usb/typec/tipd/trace.h
@@ -91,6 +91,14 @@
 						      TPS_STATUS_USB_HOST_PRESENT_MASK | \
 						      TPS_STATUS_LEGACY_MASK))
 
+#define TPS25750_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_STATUS_CONN_STATE_MASK | \
+						      GENMASK(19, 7) | \
+						      TPS_STATUS_VBUS_STATUS_MASK | \
+						      TPS_STATUS_USB_HOST_PRESENT_MASK | \
+						      TPS_STATUS_LEGACY_MASK | \
+						      BIT(26) | \
+						      GENMASK(31, 28)))
+
 #define show_status_conn_state(status) \
 	__print_symbolic(TPS_STATUS_CONN_STATE((status)), \
 		{ TPS_STATUS_CONN_STATE_CONN_WITH_R_A,	"conn-Ra"  }, \
@@ -148,6 +156,14 @@
 		      { TPS_STATUS_HIGH_VOLAGE_WARNING,	"HIGH_VOLAGE_WARNING" }, \
 		      { TPS_STATUS_HIGH_LOW_VOLTAGE_WARNING, "HIGH_LOW_VOLTAGE_WARNING" })
 
+#define show_tps25750_status_flags(flags) \
+	__print_flags((flags & TPS25750_STATUS_FLAGS_MASK), "|", \
+		      { TPS_STATUS_PLUG_PRESENT,	"PLUG_PRESENT" }, \
+		      { TPS_STATUS_PLUG_UPSIDE_DOWN,	"UPSIDE_DOWN" }, \
+		      { TPS_STATUS_PORTROLE,		"PORTROLE" }, \
+		      { TPS_STATUS_DATAROLE,		"DATAROLE" }, \
+		      { TPS_STATUS_BIST,		"BIST" })
+
 #define show_power_status_source_sink(power_status) \
 	__print_symbolic(TPS_POWER_STATUS_SOURCESINK(power_status), \
 		{ 1, "sink" }, \
@@ -292,6 +308,27 @@ TRACE_EVENT(tps6598x_status,
 		    )
 );
 
+TRACE_EVENT(tps25750_status,
+	    TP_PROTO(u32 status),
+	    TP_ARGS(status),
+
+	    TP_STRUCT__entry(
+			     __field(u32, status)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->status = status;
+			   ),
+
+	    TP_printk("conn: %s, vbus: %s, usb-host: %s, legacy: %s, flags: %s",
+		      show_status_conn_state(__entry->status),
+		      show_status_vbus_status(__entry->status),
+		      show_status_usb_host_present(__entry->status),
+		      show_status_legacy(__entry->status),
+		      show_tps25750_status_flags(__entry->status)
+		    )
+);
+
 TRACE_EVENT(tps6598x_power_status,
 	    TP_PROTO(u16 power_status),
 	    TP_ARGS(power_status),
-- 
2.34.1

