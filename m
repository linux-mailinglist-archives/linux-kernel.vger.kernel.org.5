Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7CF7B4617
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjJAIQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjJAIP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:15:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE3ED8;
        Sun,  1 Oct 2023 01:15:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b2f73e3af3so104822066b.3;
        Sun, 01 Oct 2023 01:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696148141; x=1696752941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AZ7TZBuxgbfz7hxQq4OKpZkJG9RmU/3ei2xqClWle4=;
        b=WOTZWAzMEM9gMUlOPlCXO7csP0dvE3ckA2yNjNOsq5mxMImeWTPcwL+lNg1eaCGIYP
         HRXFnyE+AVetatYGYYfWS8FzXPMjB1Gsp5YD/PTyNvcJwNM9jE2UZsc9LuMdx0uRzKW8
         mEiHu2yLT1rMuzeRJB76W2F8BTJ27aOPzU02llSyalLChm9fIPlGg235hfVm8H7Ao/Pr
         nh0jq+z2GJNlPjaRpogCwFSNTqyMl9FvzHWP+BF5In1H6Kdnp2shcF7ri3jS+YTfDBv1
         GZ2nEiMSs25rRd+Y84Wv9ZJsyATMGHv5wyg/GKk262IpqeQA4TKaC/pNwKiNiawrJrYy
         wXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696148141; x=1696752941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AZ7TZBuxgbfz7hxQq4OKpZkJG9RmU/3ei2xqClWle4=;
        b=ZeHirWpfa1Px/Mp/L+2/0MsUc8WObCSXLEcYm4o4EBdwdOA9l/lB0TZ+19zp6nBzwP
         exK8+Dm3UkfkC2df6X8IrZ+WdwraHTWXwZmvn/QUSGWJBjSPvtX82se1SSnFQRb9aklb
         7sR15kV2Vz5Uv9nkhUnSVN+5HhgT7V9l4qZPLqUStYdZrH++PfgS7EI6AtNfYBNaLivF
         DHLaPyVb4VlAPw1f2RcdSBeMICUXC8E/5v96IKSk/5GSQHwlJE7uAIKHPIvJ1iKcJtnt
         9aocTa9Qg09YfvD9uEW4fqD4LtlghZilyyV7LXf8bRjWc/DauOwwAD5uFFsZzr28VifQ
         Jz/A==
X-Gm-Message-State: AOJu0Yy3vXyWJPkdL4wQN1iWpCa+X5W18BXsEohtgVi8FVBfIOPTLK4F
        v7TyZDTUBAPbuugWTQVluW4=
X-Google-Smtp-Source: AGHT+IFf09f4eWyeXW4StIzAbU77DRWQDEgbK5OkeBJKeQpmRh2JnNp/2eD/DtZzMnn1fRl3KjOC4Q==
X-Received: by 2002:a17:907:724b:b0:9ae:7870:1532 with SMTP id ds11-20020a170907724b00b009ae78701532mr8624554ejc.58.1696148141148;
        Sun, 01 Oct 2023 01:15:41 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm15121841ejc.153.2023.10.01.01.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:15:40 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v9 13/14] USB: typec: tps6598x: Add power status trace for tps25750
Date:   Sun,  1 Oct 2023 04:11:33 -0400
Message-Id: <20231001081134.37101-14-alkuor@gmail.com>
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

tps25750 power status register is a subset of tps6598x power status
register.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v9:
  - Move device data structs to the top of of_device_id
Changes in v8:
  - Change tps->cb to tps->data
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - Add trace power status to tipd data factory
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c     |  8 +++++++-
 drivers/usb/typec/tipd/tps6598x.h | 19 ++++++++++++++++++
 drivers/usb/typec/tipd/trace.h    | 33 +++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index f775e479b92b..a114e786b1a7 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -109,6 +109,7 @@ struct tps6598x;
 struct tipd_data {
 	irq_handler_t irq_handler;
 	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
+	void (*trace_power_status)(u16 status);
 };
 
 struct tps6598x {
@@ -499,7 +500,9 @@ static bool tps6598x_read_power_status(struct tps6598x *tps)
 		return false;
 	}
 	tps->pwr_status = pwr_status;
-	trace_tps6598x_power_status(pwr_status);
+
+	if (tps->data->trace_power_status)
+		tps->data->trace_power_status(pwr_status);
 
 	return true;
 }
@@ -1392,16 +1395,19 @@ static const struct dev_pm_ops tps6598x_pm_ops = {
 static const struct tipd_data cd321x_data = {
 	.irq_handler = cd321x_interrupt,
 	.register_port = tps6598x_register_port,
+	.trace_power_status = trace_tps6598x_power_status,
 };
 
 static const struct tipd_data tps6598x_data = {
 	.irq_handler = tps6598x_interrupt,
 	.register_port = tps6598x_register_port,
+	.trace_power_status = trace_tps6598x_power_status,
 };
 
 static const struct tipd_data tps25750_data = {
 	.irq_handler = tps25750_interrupt,
 	.register_port = tps25750_register_port,
+	.trace_power_status = trace_tps25750_power_status,
 };
 
 static const struct of_device_id tps6598x_of_match[] = {
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index f86b5e96efba..01609bf509e4 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -161,6 +161,25 @@
 #define TPS_POWER_STATUS_BC12_STATUS_CDP 2
 #define TPS_POWER_STATUS_BC12_STATUS_DCP 3
 
+/* TPS25750_REG_POWER_STATUS bits */
+#define TPS25750_POWER_STATUS_CHARGER_DETECT_STATUS_MASK	GENMASK(7, 4)
+#define TPS25750_POWER_STATUS_CHARGER_DETECT_STATUS(p) \
+	TPS_FIELD_GET(TPS25750_POWER_STATUS_CHARGER_DETECT_STATUS_MASK, (p))
+#define TPS25750_POWER_STATUS_CHARGER_ADVERTISE_STATUS_MASK	GENMASK(9, 8)
+#define TPS25750_POWER_STATUS_CHARGER_ADVERTISE_STATUS(p) \
+	TPS_FIELD_GET(TPS25750_POWER_STATUS_CHARGER_ADVERTISE_STATUS_MASK, (p))
+
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DISABLED	0
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_IN_PROGRESS	1
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_NONE		2
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_SPD		3
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_BC_1_2_CPD	4
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_BC_1_2_DPD	5
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_1_DCP	6
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_2_DCP	7
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_3_DCP	8
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_1_2V_DCP	9
+
 /* TPS_REG_DATA_STATUS bits */
 #define TPS_DATA_STATUS_DATA_CONNECTION	     BIT(0)
 #define TPS_DATA_STATUS_UPSIDE_DOWN	     BIT(1)
diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
index 28725234a2d8..739b0a2a867d 100644
--- a/drivers/usb/typec/tipd/trace.h
+++ b/drivers/usb/typec/tipd/trace.h
@@ -166,6 +166,19 @@
 		{ TPS_POWER_STATUS_BC12_STATUS_CDP, "cdp" }, \
 		{ TPS_POWER_STATUS_BC12_STATUS_SDP, "sdp" })
 
+#define show_tps25750_power_status_charger_detect_status(power_status) \
+	__print_symbolic(TPS25750_POWER_STATUS_CHARGER_DETECT_STATUS(power_status), \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DISABLED,	"disabled"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_IN_PROGRESS,	"in progress"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_NONE,	"none"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_SPD,		"spd"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_BC_1_2_CPD,	"cpd"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_BC_1_2_DPD,	"dpd"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_1_DCP,	"divider 1 dcp"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_2_DCP,	"divider 2 dcp"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_3_DCP,	"divider 3 dpc"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_1_2V_DCP,	"1.2V dpc"})
+
 #define TPS_DATA_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_DATA_STATUS_DP_PIN_ASSIGNMENT_MASK | \
 						      TPS_DATA_STATUS_TBT_CABLE_SPEED_MASK | \
 						      TPS_DATA_STATUS_TBT_CABLE_GEN_MASK))
@@ -299,6 +312,26 @@ TRACE_EVENT(tps6598x_power_status,
 		    )
 );
 
+TRACE_EVENT(tps25750_power_status,
+	    TP_PROTO(u16 power_status),
+	    TP_ARGS(power_status),
+
+	    TP_STRUCT__entry(
+			     __field(u16, power_status)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->power_status = power_status;
+			   ),
+
+	    TP_printk("conn: %d, pwr-role: %s, typec: %s, charger detect: %s",
+		      !!TPS_POWER_STATUS_CONNECTION(__entry->power_status),
+		      show_power_status_source_sink(__entry->power_status),
+		      show_power_status_typec_status(__entry->power_status),
+		      show_tps25750_power_status_charger_detect_status(__entry->power_status)
+		    )
+);
+
 TRACE_EVENT(tps6598x_data_status,
 	    TP_PROTO(u32 data_status),
 	    TP_ARGS(data_status),
-- 
2.34.1

