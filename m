Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772A47B0B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjI0R6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjI0R6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:58:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BB710F1;
        Wed, 27 Sep 2023 10:57:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso10604157f8f.0;
        Wed, 27 Sep 2023 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695837471; x=1696442271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wXh/hi9rdCXT//s8PNBxmTKFVVUBiplEMbkFSyoXnA=;
        b=NQ9RxLX20HXei9p4kNWz42Q6HwqfdDofGH1uH6Umr0968az7VXE618UgrjDX+nTrUr
         GJUVbXyC3fVVJ4maEcgQH/07E7DJl/isd2VtzDQqP82gOzxvGIQa8+jadrpggGLDwh+M
         NgwlURiST6KGffkyxb8n4DUcy5tXsj4v+zPnfAi7WbvcO81c+nLWzEUU1dgzsRcxy7o2
         iGt0iq7yVRtH/TGsm0SRoyg6MNFxYChmKS6/wr4RZHVz5klWv5gTVa9FY/OlQd2JNrZZ
         lLCZ/sw7xNMRVuPb62fqEjahViZYU5DOoj5AxulNBK3ic90hTXUbAhz7qJkK9HEaSouv
         j67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695837471; x=1696442271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wXh/hi9rdCXT//s8PNBxmTKFVVUBiplEMbkFSyoXnA=;
        b=Uywn/B47GzSlx6SNqJokyX8PTt1mFC5lzaOLAbu+KmPKlnZxDNwsQGLBgO5Qu45uCH
         fh+llD+0Vg4WjYPRrfshYQnOZ6WO6bCUc8JQZLE0rmsJiKS87BmOyqeNcJaRok8+I4Fe
         OEm7hTHoPOiIZSDkpWfVQj6tFNs0GfKu5MpcuheKWXTTJjvYDsMhqw2lB4CCTtXjV5dq
         9vIsB0GUPp0cEVCiFc5jkyaeb0ny3ubN6hlGdLGl0SJnv7IdttAIRPYbUIM075XKqQ97
         dqw6TqFNfNjTfOtNaRN0n8Vi322mCqjS8HQJiAO50Pk6cHaSjYr2cOMwBW+sfOydaCxt
         8hvA==
X-Gm-Message-State: AOJu0Yzh7cZrcY3YJI7X/O7n+Lgm28cZLNP7XLVKwvi/b7/FNgLM0Ad5
        PfNQ1/G8q8FwxcTORrhZkRs=
X-Google-Smtp-Source: AGHT+IHIS7Y0ifE0sKpyEQp3YtYoYAk40SE8tWT3qDSU29swV5cyqBj3yCPQDREFsQL7fOMDwPrC4Q==
X-Received: by 2002:adf:cd04:0:b0:31c:804b:5ec3 with SMTP id w4-20020adfcd04000000b0031c804b5ec3mr2393453wrm.67.1695837471218;
        Wed, 27 Sep 2023 10:57:51 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id d4-20020a170906370400b0099bd8c1f67esm9654593ejc.109.2023.09.27.10.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:57:50 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v7 12/14] USB: typec: tps6598x: Add trace for tps25750 irq
Date:   Wed, 27 Sep 2023 13:53:46 -0400
Message-Id: <20230927175348.18041-13-alkuor@gmail.com>
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

tps25750 event1 register doesn't have all bits in tps6598x
event registers, only show the events that are masked

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v7:
  - Add driver name to commit subject
  - Call trace_tps25750_irq directly from tps25750 interrupt
    handler
Changes in v6:
  - Add trace irq to tipd callbacks factory
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c  |  1 +
 drivers/usb/typec/tipd/trace.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 19bb2105b5b2..deb2b756fec4 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -582,6 +582,7 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
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

