Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF0D7B6E5A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjJCQY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240256AbjJCQBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:01:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5FC1B4;
        Tue,  3 Oct 2023 09:01:06 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so1940209a12.0;
        Tue, 03 Oct 2023 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696348865; x=1696953665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Po1rEVvzfOl+HpfHr0AjMfvITpiFf89TZV0oU9GubQ=;
        b=BAu7aw2bUsVR2K6LtzAdE/+j4RVYUgedYiuVanN0axTFZR0eQmjhCH/IXAVnySL/Oe
         OzKmpIC8KI+eOk2cbVtUeegDAaDT1PAKkmWLAAIX5O5sbgry6sWIG3LD86CmjaSbEu6I
         YHnClDkCTH9WhmXquNYBvDzdYzIRf2N8wfU4NQ9qzvSRb+BmyXXLOHRbvkAABZLtOJwN
         44Oedn+oHPWe5BJ/ltOMUJkxwpHg4PiIZzoAFRozp8ZsjRu6GqCpzqlT333EF00yGlGe
         CQOsi0iBv9I1YohdPZG6oncGU9O/79lv5EYM2oNTIIj+Sbhl2CCAgy979KRHinSwznPe
         PXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348865; x=1696953665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Po1rEVvzfOl+HpfHr0AjMfvITpiFf89TZV0oU9GubQ=;
        b=wCosikAGhgsoz1gFd2Z1g7x3nVvEFxwJyCxiGCQ4a4VRW6HIe4Vqgph4P4sTDAeM8i
         ghrvSuSLzzlZT5EIbDjzAQlSn+vRWVBa7U+NvaLUHG2mBo5Q/0KigVQbGmS930bUTWTF
         g3IjaouufwQtksXEgfCSh3Di1rBs9KYX1esCmS4iXBnwAQUMiQkijMGdw6Fbyu0f5qAX
         XWm+lfP5HvJH6awj64jASBjS/7Bftk86Q87uM7wl9SzgbYOsg8KaxSFlWN/YAq3ZFlf+
         xeE01CR6t4QASTW/HiFfzRwVkBu8gx7y+8Ob1A/l/KNf+prILoKR2abaDjXZlT/AoaTf
         UjGg==
X-Gm-Message-State: AOJu0YxlQonvJAt6jaJkhtkkPrf9DkoChWRIM2l+OZax4zkzl9GpdQ9l
        PAIhpa1mMzMw4v1ugBGiWmM=
X-Google-Smtp-Source: AGHT+IGMUtjrDBPA2YXoI2+cgm3M7uPSeAY4dIMrNODfrhlKvdf18gedQ6BT4rXd3qsb3UGSqhqCDw==
X-Received: by 2002:a17:907:7702:b0:9b2:b7f2:bc95 with SMTP id kw2-20020a170907770200b009b2b7f2bc95mr12376641ejc.38.1696348864814;
        Tue, 03 Oct 2023 09:01:04 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id jo3-20020a170906f6c300b0099df2ddfc37sm1270526ejb.165.2023.10.03.09.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:01:04 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v10 8/9] USB: typec: tps6598x: Add power status trace for tps25750
Date:   Tue,  3 Oct 2023 11:58:41 -0400
Message-Id: <20231003155842.57313-9-alkuor@gmail.com>
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

tps25750 power status register is a subset of tps6598x power status
register.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v10:
  - Move 0013-USB-typec-tps6598x-Add-power-status-trace-for-tps257.patch to patch 8
  - Remove power status trace prototype from device data
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
 drivers/usb/typec/tipd/core.c     |  1 +
 drivers/usb/typec/tipd/tps6598x.h | 19 ++++++++++++++++++
 drivers/usb/typec/tipd/trace.h    | 33 +++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index e0ff6fc9f256..7bdf1ef5dd1a 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1411,6 +1411,7 @@ static const struct tipd_data tps6598x_data = {
 static const struct tipd_data tps25750_data = {
 	.irq_handler = tps25750_interrupt,
 	.register_port = tps25750_register_port,
+	.trace_power_status = trace_tps25750_power_status,
 	.apply_patch = tps25750_apply_patch,
 };
 
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

