Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E837B4619
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbjJAIQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjJAIP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:15:58 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE20F1;
        Sun,  1 Oct 2023 01:15:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so4531738a12.1;
        Sun, 01 Oct 2023 01:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696148139; x=1696752939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAQb2lcKCiK4nVCJ/kUlHxpo3G9oP8wSrjvkHy883UA=;
        b=lj0Taukf8WEL+YYxaHBf39L0Im3oSE7WBl7vYlHkk+dTiIoHZ6yd8MSranORdF4PRU
         DA/o8+4lx//teX02wjK+h0YFv+x9HiDyAeja6ouMPr8JDzosXaZ0dArId+tkYiBr72Zw
         UT8+0f2zDRsiIJNYCEGDXr7XeEFusCprWzzBR4aEWdw8BIJJCtCJl8WbjipqjnutpRuN
         Ne6305bSxoTp776EgEnIEZURWkKyu6clMw4JrCk1HEHAYIPVG2x50i1SSVN+o/A1KoA4
         BZuMTUU1+xEB0dB5ZEdgUsPMRjIL/c83UwV6a9wJ1GNpvGm4dAqsz6ridbf6M4wB1PYs
         l4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696148139; x=1696752939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAQb2lcKCiK4nVCJ/kUlHxpo3G9oP8wSrjvkHy883UA=;
        b=PjKJC0Vnd6gA6B+vlYvnBtVho0pFfpfmXL5lFJM6kSE+yjExycnB7VRp43+5x4OiPA
         8zjWjb2DptN7qxIYxYhptcKUgsZfgz3bpwwUsvwe5RlrmMAl3iu8RVmr2SOUJm2TbqsU
         TWZNMUI06KBU6mMJ+oTjj9MWm0tuQ8zqA0fDoBlxllvMSR+aIBxxaJIr5lyNtl7IwXVL
         KnN3guKppSUQMLXd2fbCsGuTNlcqQug4hBfp0w9O2Mcop2gEJrDr7D3gO6r8v4kmduOO
         gfYvky9Qd/1TFsPbE7bOzMOQRvs2mSV4/J+eNCRWZ9bX7danLacU0bzeXkNgtI46EXDU
         EWgA==
X-Gm-Message-State: AOJu0Yz5oq3OYQvKzBQVApDwOLJbQivh3svKcDScOZV1ujVGM8cdRBuT
        yn8E25lZnZy4I8f2Yf7dP58=
X-Google-Smtp-Source: AGHT+IEvXTyTWzFmFiUKoclhrxZvZ7tDtUKEKXNYPczB6yGGj5xDxqb9sARy6u1dxv8x7zeC5NNE4Q==
X-Received: by 2002:a17:906:54:b0:9a2:295a:9bbc with SMTP id 20-20020a170906005400b009a2295a9bbcmr6556487ejg.37.1696148139314;
        Sun, 01 Oct 2023 01:15:39 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm15121841ejc.153.2023.10.01.01.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:15:39 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v9 12/14] USB: typec: tps6598x: Add trace for tps25750 irq
Date:   Sun,  1 Oct 2023 04:11:32 -0400
Message-Id: <20231001081134.37101-13-alkuor@gmail.com>
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

tps25750 event1 register doesn't have all bits in tps6598x
event registers, only show the events that are masked

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v9:
  - No changes
Changes in v8:
  - No changes
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
index ddb5db7d5855..f775e479b92b 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -583,6 +583,7 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
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

