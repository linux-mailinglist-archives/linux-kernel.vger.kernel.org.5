Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DFF7B6DE5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbjJCQBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbjJCQBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:01:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E873D8;
        Tue,  3 Oct 2023 09:01:09 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ad8a822508so201894866b.0;
        Tue, 03 Oct 2023 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696348868; x=1696953668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JiuLEh/EFeAiwa7GG3VhbS7idJtkE2WcLfe5eSvI9M=;
        b=VMgtQUGqg4yClX4Fj9ypQGjwGtsKLsvboRXwDG/gptgGRNJWiZ5+Pv/uDXxYbRPbZ1
         g0ohsZsOJHeBbREEfSYTMoI7xBSDAl5GnGUBrBhPg6KznNZZY+5XgPAGjwvQ3nZRNyHJ
         0a+Kh4dkj72MjgX+IfhRUh8uhH1WcPk+6+Hjk/qYBMs4317tCG9NLtB/ibyLgt0ub93i
         bXVA3PyH15ySMTSpzeJdv/xQtxnMLAe8+d603IFY1o+kA6Jugp2A5qvt9/vP4u5o1EVG
         VNKeBXm8RVPzeiNeEaQpJEZmDhKFxBFOFNfLwEXEr6Zmypuw62URGcrOESanIfps+7za
         yxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348868; x=1696953668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JiuLEh/EFeAiwa7GG3VhbS7idJtkE2WcLfe5eSvI9M=;
        b=S0uzVmH0PoQTgvx9NBKzKn9KK0F51I1Se4d9jrTp3iHa7BYvYQhg+2lQPfI4QqjjbA
         JSdDighInttE2BXyVmZZ3/oTgp1R6FiJsoztsxz69PJTRJRNAN2Q5Psf/s02rcYR8lDw
         yaRBOfqvec+UFeX8wHpcT8GV1+YFGq+elNo7kQSjXZ/hALSjExI98Pce6v2mNcdtWprN
         vQ/c+5MWOStUDvEjIAwtNag9kNtckpBnfxHuSdOD5Q5bQCfJRw0+ofezD0jA7rxtlbsA
         FYryY6narU5EMF1Le2IksL/il94x8mKIvfDOP+k4Er4k9FPme/jZYQxQ60hzhAMm3jNG
         X0Tw==
X-Gm-Message-State: AOJu0Yymz1dassj6pXClYi0ZDS9Lmsxw6G381jgvn22jP/DRY5eMRyNl
        QwB6SInFfdjt7ZPhbJNECmk=
X-Google-Smtp-Source: AGHT+IGhK7wJSetq7gxvJEf+CENG+M6shmXrxbwZPXDLJB+pwvhRNkB4Z/nZvun9LwBueEyrTM5nJw==
X-Received: by 2002:a17:906:28e:b0:9ae:552a:3d3f with SMTP id 14-20020a170906028e00b009ae552a3d3fmr13530474ejf.28.1696348866722;
        Tue, 03 Oct 2023 09:01:06 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id jo3-20020a170906f6c300b0099df2ddfc37sm1270526ejb.165.2023.10.03.09.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:01:06 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v10 9/9] USB: typec: tps6598x: Add status trace for tps25750
Date:   Tue,  3 Oct 2023 11:58:42 -0400
Message-Id: <20231003155842.57313-10-alkuor@gmail.com>
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

tps25750 status register is a subset of tps6598x status register, hence
a trace for tps25750 status register is added.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v10:
  - Move 0014-USB-typec-tps6598x-Add-status-trace-for-tps25750.patch to patch 9
  - Remove status trace prototype from device data
Changes in v9:
  - No changes
Changes in v8:
  - No changes
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - No changes
Changes in v5:
  - Incorporating tps25750 into tps6598x driver
 drivers/usb/typec/tipd/core.c  |  1 +
 drivers/usb/typec/tipd/trace.h | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 7bdf1ef5dd1a..0e867f531d34 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1412,6 +1412,7 @@ static const struct tipd_data tps25750_data = {
 	.irq_handler = tps25750_interrupt,
 	.register_port = tps25750_register_port,
 	.trace_power_status = trace_tps25750_power_status,
+	.trace_status = trace_tps25750_status,
 	.apply_patch = tps25750_apply_patch,
 };
 
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

