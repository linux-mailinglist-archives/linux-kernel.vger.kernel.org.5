Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684D57C4220
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343906AbjJJVNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjJJVM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:12:58 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA46798
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:12:55 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1dd1714b9b6so4248478fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696972375; x=1697577175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dl0PVkUbqTQUh7CeF07K0JAD05VmhLtJ0L4pxcpgSQ=;
        b=3DdiKNuXIbm+BaIGBuSLXIhp/76erp9K6yOykYfDGiQCNoO+E/nXhy5Sid4PT7Sppu
         66i2p2yTXUg6B0oLK17QZ+QqM/MHeM+x+LCIk5oaIfpS7SBAhbBMg9BV4yA4YKG1uHTF
         K2RY+nS1eZWpjfa092PQOls3szKl7pkgPEP/lvZ82qBiiMSEtpBWtRhl5SpX+swLVFdq
         GX2zyEjdwyTJfLOTK8zlX9Bce8uq5rfckbCx3m+H9iUNZU8zYR8W1uqKFyXQyDUPCORv
         AWORnz5GR01lMIfBi5G/cYSquCZZfqu1UWvG+2CVE8q22kUlU6xs2eDLmG2KSat/N38k
         RWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696972375; x=1697577175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dl0PVkUbqTQUh7CeF07K0JAD05VmhLtJ0L4pxcpgSQ=;
        b=P0rbBS0sbvAa+90g+9Z+s4aZ1rdDdm494etvZHIz6EpuatfuTyxtZGISc+1BENPxAr
         lXeL6rlx61cAzvaeY6Z7PPQQo+pmc+8vSClCQdJM+RIenpl5MrCmY1T3PskEEkQ3rpTq
         A7gayWTNhuTTMDMDYTxWXTdo+T+ixP5JqIKorxd0ytwVI8voCmkSP/Sfj/Sdz+l5/hG4
         DDGd8vPu8DUJAGbB7VtyJB4lh0pjZpdnKhNdOWyDJOfMPSSaIVxjw3jUb3y9CG/BpYK1
         JmWOGP7Vqy+kH9s49iMvscVELnf+do+1rXt1A5nLtj5ym0UgTjEp262EvCxECChIwbc/
         BJDQ==
X-Gm-Message-State: AOJu0Yz0rvi4sTk7SR7kRV1q16mquwFaneysbgH31uIWrs90bx3IPR9d
        jc0kalHfvIH49NXpyC1tpWMVMA==
X-Google-Smtp-Source: AGHT+IEp7Iox6+XTb6EqSgkNZ6rYDfaZHXv9bmQpeEXZiJesGGO2MkkD0pbgtDQXWNgE2ewQpPhM9w==
X-Received: by 2002:a05:6870:2326:b0:1bb:8867:f7ed with SMTP id w38-20020a056870232600b001bb8867f7edmr23858681oao.33.1696972374798;
        Tue, 10 Oct 2023 14:12:54 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id ed46-20020a056870b7ae00b001e98b1544fesm52494oab.9.2023.10.10.14.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:12:54 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] staging: iio: resolver: ad2s1210: refactor sample toggle
Date:   Tue, 10 Oct 2023 16:12:33 -0500
Message-ID: <20231010-ad2s1210-mainline-v5-1-35a0f6ffa04a@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010-ad2s1210-mainline-v5-0-35a0f6ffa04a@baylibre.com>
References: <20231010-ad2s1210-mainline-v5-0-35a0f6ffa04a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This refactors the sample line toggle in the ad2s1210 resolver driver
to a separate function. The sample has some timing requirements, so
this ensures that it is always done the same way, both in the existing
call sites and any future usage.

Previously, the sample line was kept on for the duration of the read,
but this is not necessary. Data is latched in on the rising edge and
after the specified delay the state of the sample line does not matter.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes: New patch in v5.

 drivers/staging/iio/resolver/ad2s1210.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index e0bea3c68664..59c273a4b6a9 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -286,6 +286,26 @@ static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
 	return 0;
 }
 
+/*
+ * Toggles the SAMPLE line on the AD2S1210 to latch in the current position,
+ * velocity, and faults.
+ *
+ * Must be called with lock held.
+ */
+static void ad2s1210_toggle_sample_line(struct ad2s1210_state *st)
+{
+	/*
+	 * Datasheet specifies minimum hold time t16 = 2 * tck + 20 ns. So the
+	 * longest time needed is when CLKIN is 6.144 MHz, in which case t16
+	 * ~= 350 ns. The same delay is also needed before re-asserting the
+	 * SAMPLE line.
+	 */
+	gpiod_set_value(st->sample_gpio, 1);
+	ndelay(350);
+	gpiod_set_value(st->sample_gpio, 0);
+	ndelay(350);
+}
+
 /*
  * Sets the excitation frequency and performs software reset.
  *
@@ -405,10 +425,8 @@ static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
 	int ret;
 
 	mutex_lock(&st->lock);
-	gpiod_set_value(st->sample_gpio, 1);
+	ad2s1210_toggle_sample_line(st);
 	timestamp = iio_get_time_ns(indio_dev);
-	/* delay (6 * tck + 20) nano seconds */
-	udelay(1);
 
 	switch (chan->type) {
 	case IIO_ANGL:
@@ -444,9 +462,6 @@ static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
 	ad2s1210_push_events(indio_dev, st->sample.fault, timestamp);
 
 error_ret:
-	gpiod_set_value(st->sample_gpio, 0);
-	/* delay (2 * tck + 20) nano seconds */
-	udelay(1);
 	mutex_unlock(&st->lock);
 	return ret;
 }
@@ -1268,7 +1283,7 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 	mutex_lock(&st->lock);
 
 	memset(&st->scan, 0, sizeof(st->scan));
-	gpiod_set_value(st->sample_gpio, 1);
+	ad2s1210_toggle_sample_line(st);
 
 	if (test_bit(0, indio_dev->active_scan_mask)) {
 		ret = ad2s1210_set_mode(st, MOD_POS);
@@ -1298,7 +1313,6 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, pf->timestamp);
 
 error_ret:
-	gpiod_set_value(st->sample_gpio, 0);
 	mutex_unlock(&st->lock);
 	iio_trigger_notify_done(indio_dev->trig);
 

-- 
2.42.0

