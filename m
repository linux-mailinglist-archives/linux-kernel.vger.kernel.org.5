Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2799678E288
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245007AbjH3Wsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244087AbjH3Wsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:48:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F4DE49;
        Wed, 30 Aug 2023 15:48:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bf55a81eeaso1303965ad.0;
        Wed, 30 Aug 2023 15:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693435695; x=1694040495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ubwb8ZkSJEXL4N31fP6n7OBgqr01nG/Maz7pQ2R1NuQ=;
        b=V5SwwZTQn9kQCU0v9X8V5JNj0q2P4M00n22CBqCt5C2XA47yqgvMU4nBZNdxbaOGkg
         qNKbrDLTYqNSPqkgy38BzL+AUeXh7qgPruOSoW1PzGvWa6bH0oxA7LbQNmqCaz6X54qW
         Nfcqah26E8XuxvKHtLQP6+ko6fs65B3N1vDLY4PV01qOljIJP1mZX7w0jO7zB0IDcwly
         QN91uGjTNKh2+LQo5jg1arh8uACXaIKW+nnv+A9szAN23bSdtL9JOoVoiGdLohyEzgWM
         65iAdE1UGo9VoDd1W//yBJaGFZ8I6HLk18w1HxV0LBSroDqCi+ae6gHk5Kp3b+MxkMA9
         V0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693435695; x=1694040495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubwb8ZkSJEXL4N31fP6n7OBgqr01nG/Maz7pQ2R1NuQ=;
        b=FYdAijkYJbecyp/gTJ43l9j/DQ7g2k7m0GS6nSAPTVl2Bahc578Ho3h9LGTl/Igu2X
         QnhMO/3FO3mYedtcJ7WiJ8xEgEiuwWDITYRoZPPT4V8ElYCGufR52TT1aaNcD8mwNt3x
         fSuBibsHzf11JVcuIctVvPL2E4cIZWavLrow+oxT5ozx7RQf//hf7Q9VZviKnjJRyBO6
         E/urBENNwIr6o3YiKiGQKhSFl8TRgDC4DPRMucQWIZEbH1FFrO5kd6mo3dLzJ/X+C5CH
         go1CVl0XCjSKUcaBDmVBjAPHjn7E0JaTb+NeJhAvvcRoa9676ba9N2pYbZ2mTxWc9uq+
         xxIQ==
X-Gm-Message-State: AOJu0YyNIU1xvTyssH9QCBTcTlIQAQM+Ed7Daehj77juWRUWT9vsZkRK
        m0nB4+9tf1eMVESMSdX6zlE=
X-Google-Smtp-Source: AGHT+IEg7W8QFA14h0a2Pzn6H/lPyU7ZJTbFvU8hcWHYERy18kUYUQ8TOQ4nF9eY3kKjASknNVu4Mw==
X-Received: by 2002:a17:903:32ce:b0:1bf:120a:a29e with SMTP id i14-20020a17090332ce00b001bf120aa29emr4106996plr.10.1693435694678;
        Wed, 30 Aug 2023 15:48:14 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j22-20020a170902759600b001b8ad8382a4sm13010pll.216.2023.08.30.15.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 15:48:13 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Doug Berger <opendmb@gmail.com>
Subject: [PATCH] rtc: brcmstb-waketimer: support level alarm_irq
Date:   Wed, 30 Aug 2023 15:47:47 -0700
Message-Id: <20230830224747.1663044-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Some devices (e.g. BCM72112) use an alarm_irq interrupt that is
connected to a level interrupt controller rather than an edge
interrupt controller. In this case, the interrupt cannot be left
enabled by the irq handler while preserving the hardware wake-up
signal on wake capable devices or an interrupt storm will occur.

The alarm_expired flag is introduced to allow the disabling of
the interrupt when an alarm expires and to support balancing the
calls to disable_irq() and enable_irq() in accordance with the
existing design.

Fixes: 24304a87158a ("rtc: brcmstb-waketimer: allow use as non-wake alarm")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 47 ++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index 3cdc015692ca..1a65a4e0dc00 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright © 2014-2017 Broadcom
+ * Copyright © 2014-2023 Broadcom
  */
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
@@ -34,6 +34,7 @@ struct brcmstb_waketmr {
 	u32 rate;
 	unsigned long rtc_alarm;
 	bool alarm_en;
+	bool alarm_expired;
 };
 
 #define BRCMSTB_WKTMR_EVENT		0x00
@@ -64,6 +65,11 @@ static inline void brcmstb_waketmr_clear_alarm(struct brcmstb_waketmr *timer)
 	writel_relaxed(reg - 1, timer->base + BRCMSTB_WKTMR_ALARM);
 	writel_relaxed(WKTMR_ALARM_EVENT, timer->base + BRCMSTB_WKTMR_EVENT);
 	(void)readl_relaxed(timer->base + BRCMSTB_WKTMR_EVENT);
+	if (timer->alarm_expired) {
+		timer->alarm_expired = false;
+		/* maintain call balance */
+		enable_irq(timer->alarm_irq);
+	}
 }
 
 static void brcmstb_waketmr_set_alarm(struct brcmstb_waketmr *timer,
@@ -105,10 +111,17 @@ static irqreturn_t brcmstb_alarm_irq(int irq, void *data)
 		return IRQ_HANDLED;
 
 	if (timer->alarm_en) {
-		if (!device_may_wakeup(timer->dev))
+		if (device_may_wakeup(timer->dev)) {
+			disable_irq_nosync(irq);
+			timer->alarm_expired = true;
+		} else {
 			writel_relaxed(WKTMR_ALARM_EVENT,
 				       timer->base + BRCMSTB_WKTMR_EVENT);
+		}
 		rtc_update_irq(timer->rtc, 1, RTC_IRQF | RTC_AF);
+	} else {
+		writel_relaxed(WKTMR_ALARM_EVENT,
+			       timer->base + BRCMSTB_WKTMR_EVENT);
 	}
 
 	return IRQ_HANDLED;
@@ -221,8 +234,14 @@ static int brcmstb_waketmr_alarm_enable(struct device *dev,
 		    !brcmstb_waketmr_is_pending(timer))
 			return -EINVAL;
 		timer->alarm_en = true;
-		if (timer->alarm_irq)
+		if (timer->alarm_irq) {
+			if (timer->alarm_expired) {
+				timer->alarm_expired = false;
+				/* maintain call balance */
+				enable_irq(timer->alarm_irq);
+			}
 			enable_irq(timer->alarm_irq);
+		}
 	} else if (!enabled && timer->alarm_en) {
 		if (timer->alarm_irq)
 			disable_irq(timer->alarm_irq);
@@ -352,6 +371,17 @@ static int brcmstb_waketmr_suspend(struct device *dev)
 	return brcmstb_waketmr_prepare_suspend(timer);
 }
 
+static int brcmstb_waketmr_suspend_noirq(struct device *dev)
+{
+	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
+
+	/* Catch any alarms occurring prior to noirq */
+	if (timer->alarm_expired && device_may_wakeup(dev))
+		return -EBUSY;
+
+	return 0;
+}
+
 static int brcmstb_waketmr_resume(struct device *dev)
 {
 	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
@@ -368,10 +398,17 @@ static int brcmstb_waketmr_resume(struct device *dev)
 
 	return ret;
 }
+#else
+#define brcmstb_waketmr_suspend		NULL
+#define brcmstb_waketmr_suspend_noirq	NULL
+#define brcmstb_waketmr_resume		NULL
 #endif /* CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(brcmstb_waketmr_pm_ops,
-			 brcmstb_waketmr_suspend, brcmstb_waketmr_resume);
+static const struct dev_pm_ops brcmstb_waketmr_pm_ops = {
+	.suspend	= brcmstb_waketmr_suspend,
+	.suspend_noirq	= brcmstb_waketmr_suspend_noirq,
+	.resume		= brcmstb_waketmr_resume,
+};
 
 static const __maybe_unused struct of_device_id brcmstb_waketmr_of_match[] = {
 	{ .compatible = "brcm,brcmstb-waketimer" },
-- 
2.34.1

