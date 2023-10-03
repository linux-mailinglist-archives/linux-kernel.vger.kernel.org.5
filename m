Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94CA7B6DE1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbjJCQBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240287AbjJCQBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:01:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F32D136;
        Tue,  3 Oct 2023 09:01:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-533d6a8d6b6so1981083a12.2;
        Tue, 03 Oct 2023 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696348862; x=1696953662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foHavn1yNGCukcn3QtzQJjXudL1xRCClcudMiYe9+Bw=;
        b=NFhAS0QTARZ4dBdFNTa55+Lz/zo+YOgYjozBzmpL5qc3YRG1cY8/Ja8l60EXphpidr
         YXZxHwfuYqVjp6no/FBB4ZTBIz8afc84WQ3MOam77hpyDWB4G8HW13wOUIBQ1DD/DwUi
         p5dqTaom0QmedaxAQDX4Ku+Yq9bqnS/WXbvG+DxJRnGT2LEfetO76qA2JZZuUWUJL6uN
         AylvW/L7lz+Er4lupcdYFXkOjyTKvMPNjlP/VlB6WZp0gPZcQ2hCIg065xIujJq6Ftj1
         LFMkZGdX7WKJbxBDgAOS7L7jV9Dx3Ems2MUHkhxyEnXm4HBfUVi6RWbeGzmYKLsDnFYj
         MFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348862; x=1696953662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foHavn1yNGCukcn3QtzQJjXudL1xRCClcudMiYe9+Bw=;
        b=AmPgmhpwwtTxs9wKhnXpr5ioXuDcwcQH5CtCetnlpvQb4c6iiKiD0BbWvN5cxi81w6
         GogvHf5+DvRnR5xSR5UhrisBbKb0P9Rem4bvtUAkw2MYHrqvjUqtXdCc/rYbG7P05NJk
         Ln4ZIWQlFnu4G3gihxGWJ+bJn8XDO7jo9Lgbf61nutAZav4mQks+E5QLEoXirmF5GZS0
         2sRrryW8WypbpbmQSCzHlAyzI8Kx56AShtMba1amdpzRGpTANEza+tmHvx/rnWBW4Cqh
         FYT8p33nrcPH5sV7Gzhjlt9EUcBLDlZcm6wp52gDqsVkZAeBJ+4vJQCy3nZ2SVPOJ7rM
         c1yQ==
X-Gm-Message-State: AOJu0YwyhnYYGkSL344mJaY5Scz1gr71fIlz+ikdJLqMUdsDbXsGQkyn
        NNhN5MZWOfjD19PJJi4FulU=
X-Google-Smtp-Source: AGHT+IG9M2PPVe/dQxgN9ZzP0Q3Hod8EMnMdMvIfw1tQko/ggQ5NQjHvHy1uPnzp3tUoxRqo1W4dxQ==
X-Received: by 2002:a17:906:30cd:b0:9a9:e3be:1310 with SMTP id b13-20020a17090630cd00b009a9e3be1310mr11806623ejb.53.1696348862442;
        Tue, 03 Oct 2023 09:01:02 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id jo3-20020a170906f6c300b0099df2ddfc37sm1270526ejb.165.2023.10.03.09.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:01:02 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v10 7/9] USB: typec: tps6598x: Add trace for tps25750 irq
Date:   Tue,  3 Oct 2023 11:58:40 -0400
Message-Id: <20231003155842.57313-8-alkuor@gmail.com>
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

tps25750 event1 register doesn't have all bits in tps6598x
event registers, only show the events that are masked

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v10:
  - Move 0012-USB-typec-tps6598x-Add-trace-for-tps25750-irq.patch to patch 7
Changes in v9:
  - No changes
Changes in v8:
  - Use device_is_compatible instead of of_device_is_compatible
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - Check tps25750 using is_compatiable device node
Changes in v5:
  - Incorporating tps25750 into tps6598x driver
 drivers/usb/typec/tipd/core.c  |  1 +
 drivers/usb/typec/tipd/trace.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 892432ad80a3..e0ff6fc9f256 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -589,6 +589,7 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 		dev_err(tps->dev, "%s: failed to read events\n", __func__);
 		goto err_unlock;
 	}
+	trace_tps25750_irq(event[0]);
 
 	if (!(event[0] | event[1]))
 		goto err_unlock;
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

