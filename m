Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1558B7A3658
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbjIQP2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjIQP15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:27:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB079186;
        Sun, 17 Sep 2023 08:27:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401da71b83cso42177515e9.2;
        Sun, 17 Sep 2023 08:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694964470; x=1695569270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48igqbWoZ6rl5cAwQg8BttYETGq1bFuqrgNpEHB1dVg=;
        b=hh7O0bMGsG7deqbwcqrweZ32uH7xxvfLtPuXaA1Ju+ViyXjwTOhDGbc6AcUCdyucIx
         7b/bZFB0XRfK1SQusqoJgpzRehr7D6rGxVM7z+4dbGih1RChnDewY2yRV9UpZ+f1nNTH
         2fdEHXB9PrZ+X4xZlZN20HdzcJodes17K+p1ghw1KzqBNRtT/f2JTjOHPFQ6Q7l5xGPC
         44OmMeXNGumz1CUf4o0ExrlEVLwn67jKS46amBqhMhEAnOaM0yfS9E7ySryUNJZy+0R3
         L5JJw88C3Mbd49eI45/BnqogbK6u0aHJHJcwUtmbE/IGudSV7KC84Nd9QSAyaUEq44V5
         WkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694964470; x=1695569270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48igqbWoZ6rl5cAwQg8BttYETGq1bFuqrgNpEHB1dVg=;
        b=RsEuClIP2GyX6XhHfiQ3Fp9eW3HPgzsNfkl9KLp49TaEdMxuB+C2XUdnqtPlqFZzVh
         7QiC8fbiARNQ5nycFSYTD5mTlX4o+MiPc0c3GjNU/ASKLm4i8vTKZ60LBt4SEt6c2g95
         8KL4kkY+/+o+E2hxL8+JEAumsMNAlI2IcF0teecrWPsOdyowQMo+2+URhnxm3i81HzX9
         oDiXWlDQNeC4KxGGAxm4U3gfNqHQm7kAQ1OEUtEp8Y61BQUoAUkVzu26nvDgcqQ0panv
         GTFhg2QcjQr0W+BT6CIHZt9dVRJmELz24jiJm8+h4dx3VMK3a7p6mwNdu+yZHkz0dqZT
         zLUQ==
X-Gm-Message-State: AOJu0Yy0pJkpLeLDJDwdv1JX4aHhHz74u25yZ9gbxdO4EIhEBjdPub4Z
        mVzb4q4MxUvCJZL7KuXCRJM=
X-Google-Smtp-Source: AGHT+IGB+bA/4PQpZ/qUKlRuqi5qcjkbXqV8r79ypUwa1oouPfnlFZ7Sotpv7prtQEW8BMLAt+IYUw==
X-Received: by 2002:a05:600c:144:b0:401:b504:b6a0 with SMTP id w4-20020a05600c014400b00401b504b6a0mr6937162wmm.3.1694964470280;
        Sun, 17 Sep 2023 08:27:50 -0700 (PDT)
Received: from localhost.localdomain ([5.45.134.53])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c489700b003fe15ac0934sm7388865wmp.1.2023.09.17.08.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:27:49 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: [PATCH v5 13/15] USB: typec: Add power status trace for tps25750
Date:   Sun, 17 Sep 2023 11:26:37 -0400
Message-Id: <20230917152639.21443-14-alkuor@gmail.com>
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

tps25750 power status register is a subset of tps6598x power status
register.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
 drivers/usb/typec/tipd/core.c     |  6 +++++-
 drivers/usb/typec/tipd/tps6598x.h | 19 ++++++++++++++++++
 drivers/usb/typec/tipd/trace.h    | 33 +++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 8d6cb67898a5..dd3c76b57aaa 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -484,7 +484,11 @@ static bool tps6598x_read_power_status(struct tps6598x *tps)
 		return false;
 	}
 	tps->pwr_status = pwr_status;
-	trace_tps6598x_power_status(pwr_status);
+
+	if (tps->is_tps25750)
+		trace_tps25750_power_status(pwr_status);
+	else
+		trace_tps6598x_power_status(pwr_status);
 
 	return true;
 }
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 0344b65cd55a..bab6b0f026fc 100644
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

