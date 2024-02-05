Return-Path: <linux-kernel+bounces-53046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D33BB849FEE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89258285A64
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2AE4B5CD;
	Mon,  5 Feb 2024 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI/le5uO"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C66482EC;
	Mon,  5 Feb 2024 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151757; cv=none; b=G9f26890Ofg98zgw7FwqEd1r1BfYD5UWNbOqZ3Y2t2aSjv1jQSG+mnbvbOYbXj1ghbPuLNMkTazCItdtESO1PqqvSg8KaOlMKTek14Dr04LWup/50TWr3S+ymREZaMny3+UMW/cMRoElFovP5gj23hL/0GEAxQpTZyZUiJ1pG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151757; c=relaxed/simple;
	bh=DJnY8mF3yKbImXawZIGUIbNxFavZeCJ4NbAohXySnMo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1iXsb3XDSY563pIKKkn5f9R9Mah/oJF83pWFBvjzrRxI8CG2/RQMhFD9zn1kWXKMhvkHWqTlT6C9+vvHxHC4bSvaFdnCfJv7dvewCZSYai/je2AqQUO6WTYc/3veRksYdU+rSTk8nZDjM1cFMsSY6LUPCRKUya2rjOmYYeWjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RI/le5uO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fc6343bd2so29101715e9.1;
        Mon, 05 Feb 2024 08:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151753; x=1707756553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCMP/fDewkGgGWnH4cfQZYvy8INkiAOziFa+q+/zteg=;
        b=RI/le5uOfGyXZgbxLmODf7Of6DNk8+aWGimtU9Vs3fw6HJE6xevQl62ExrFTkIi9Uo
         JWY8rTOqtxXMvp7nt0fjHobZpgkepo/i+nWIcc9hnav4EMmuG2iDSkuRC8JFCyhfmn4o
         XrabiZUCusNo+6BcAdN8UgH4BLTRjgXu9kZiHdpvhSKWM9hnN/fQQALQaQ1oItb0XXDe
         13iHjyb8yoaINUwIlbxf3wagIOMfIL5eH7NO6ycKzuyayM/F5M6E+U3CtwKVHcDrazG8
         o/O30eD8p4+m8hZDl3sLIpTeH0FqqeP45oxftnWtGkbia3XIRPXdXHIsaURe9uHvEl+I
         oqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151753; x=1707756553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCMP/fDewkGgGWnH4cfQZYvy8INkiAOziFa+q+/zteg=;
        b=w5nWybACaTOfOQ3xmWvjlQ4VZCo8wWWUz7WGcJMC2JB8TrToQaen4B2syrfG2XXJLs
         50rV/hRyBzchbwOfjDmJL08Yo2dADd6+1DvLrgek65mji59DyfwDoEb2XNzV0sTJrlg9
         fh05hboaTdRZ1ZYB0s36T++PVEI+ExMyxhNU+Y7wj9WekuIbN0KQZNlSJnOruHSkFJx6
         EcxY8vWhHqKl3BY0VNdpazfrCC0TOXQhpeJTo5L+QsvbMKlNMM1xbZhjxfBl5MD16qHS
         JlXP154Ib8hgXieosf3A5mqvq/wqGkvlk+p8NsNbyxPapwW4Rg4akPxLm4nFDyXScy10
         bgGA==
X-Gm-Message-State: AOJu0Yytx+MW5E87tK1tPmTupLoC5+vsVjfvQal2yJZoTh+OVnu9zU5T
	wwOcQI/1DoyU3KAwqyBTmUvRWFQv3CRYpNuKU0ou2vydclEtZixu
X-Google-Smtp-Source: AGHT+IG215POtBLQSBQwa3yTnhi9BZiMKsS0BbyxD1ll4LM1I/2biR4IdTys7nCoSgq0zzm6a8nV9A==
X-Received: by 2002:a05:600c:450c:b0:40f:c234:1fd5 with SMTP id t12-20020a05600c450c00b0040fc2341fd5mr279165wmo.11.1707151753052;
        Mon, 05 Feb 2024 08:49:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWqJAEv33qKKL54gkHxCeYKV57Wfq2DmrwVvkbZ2MlQUA2v8Id7yDhDjVSXWM0tcKDdMbFrWlnHw0uqrTNL2aG/kkgpZVTZlbsV7xeNMfg5/hig7PqG0nhepX9fz6w1VzH6rh+385WFajgT4ootPaeTwUt0mNksG37yX+KHDr/qVbfIUXm2D2M+tzVAj2otm4lnkR2WJW7ScqinIoGggu2Iz4dmGEfUa333d2y9BQa58HcSaC/EgTzb2JFHrF8/frMEV5V1Bzx6RZJf3uZiG3VufQA/YSjPhaUkINs7q1bFaBx7vSMJYNU127dl7ZC53us7lGNY7QocY/YISaxFNlyotZdWRRCa2lH6J5+DCrywyYfVsTz8dCUesT8G40GaWJrNhHP4pCvZUSlsn8mWKkqGRDsotseVW2+O9Hj2DvXt0uG0nl5IH4W1h9dJ4i2myM8y23IqUJrn7CUqbnA/WIV6gGcIs66WbXl9SaaLQBkEBfrP8m5QcVqoa+DXgDp+S/CZ/hivJIsDA1pNMQYBgxSnAN3LfVyFJZ7cKmOKGR+VKItI/eaUEURXnZuGIJE88DzYu2/wXNfOT2LVgS7+v3etJRvyYJQIbaA54fPbN2FWdzK6KIiKPOlIPhIeeOfoFy+0Blh3SWJ8EIl7xeMOLcMS4DET+yycvJp2WnvbhZwZ24SEwR3/QQ==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id k2-20020a05600c1c8200b0040fafd84095sm9140567wms.41.2024.02.05.08.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:49:12 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v6 08/10] net: phy: qcom: move common qca808x LED define to shared header
Date: Mon,  5 Feb 2024 17:48:40 +0100
Message-ID: <20240205164851.1351-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205164851.1351-1-ansuelsmth@gmail.com>
References: <20240205164851.1351-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LED implementation of qca808x and qca807x is the same but qca807x
supports also Fiber port and have different hw control bits for Fiber
port.

In preparation for qca807x introduction, move all the common define to
shared header.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qcom/qca808x.c | 65 ----------------------------------
 drivers/net/phy/qcom/qcom.h    | 65 ++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 8124bc2d5e5f..b6ff2676d921 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -62,29 +62,6 @@
 #define QCA808X_DBG_AN_TEST			0xb
 #define QCA808X_HIBERNATION_EN			BIT(15)
 
-#define QCA808X_MMD7_LED_GLOBAL			0x8073
-#define QCA808X_LED_BLINK_1			GENMASK(11, 6)
-#define QCA808X_LED_BLINK_2			GENMASK(5, 0)
-/* Values are the same for both BLINK_1 and BLINK_2 */
-#define QCA808X_LED_BLINK_FREQ_MASK		GENMASK(5, 3)
-#define QCA808X_LED_BLINK_FREQ_2HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x0)
-#define QCA808X_LED_BLINK_FREQ_4HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x1)
-#define QCA808X_LED_BLINK_FREQ_8HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x2)
-#define QCA808X_LED_BLINK_FREQ_16HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x3)
-#define QCA808X_LED_BLINK_FREQ_32HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x4)
-#define QCA808X_LED_BLINK_FREQ_64HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x5)
-#define QCA808X_LED_BLINK_FREQ_128HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x6)
-#define QCA808X_LED_BLINK_FREQ_256HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x7)
-#define QCA808X_LED_BLINK_DUTY_MASK		GENMASK(2, 0)
-#define QCA808X_LED_BLINK_DUTY_50_50		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x0)
-#define QCA808X_LED_BLINK_DUTY_75_25		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x1)
-#define QCA808X_LED_BLINK_DUTY_25_75		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x2)
-#define QCA808X_LED_BLINK_DUTY_33_67		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x3)
-#define QCA808X_LED_BLINK_DUTY_67_33		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x4)
-#define QCA808X_LED_BLINK_DUTY_17_83		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x5)
-#define QCA808X_LED_BLINK_DUTY_83_17		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x6)
-#define QCA808X_LED_BLINK_DUTY_8_92		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x7)
-
 #define QCA808X_MMD7_LED2_CTRL			0x8074
 #define QCA808X_MMD7_LED2_FORCE_CTRL		0x8075
 #define QCA808X_MMD7_LED1_CTRL			0x8076
@@ -92,51 +69,9 @@
 #define QCA808X_MMD7_LED0_CTRL			0x8078
 #define QCA808X_MMD7_LED_CTRL(x)		(0x8078 - ((x) * 2))
 
-/* LED hw control pattern is the same for every LED */
-#define QCA808X_LED_PATTERN_MASK		GENMASK(15, 0)
-#define QCA808X_LED_SPEED2500_ON		BIT(15)
-#define QCA808X_LED_SPEED2500_BLINK		BIT(14)
-/* Follow blink trigger even if duplex or speed condition doesn't match */
-#define QCA808X_LED_BLINK_CHECK_BYPASS		BIT(13)
-#define QCA808X_LED_FULL_DUPLEX_ON		BIT(12)
-#define QCA808X_LED_HALF_DUPLEX_ON		BIT(11)
-#define QCA808X_LED_TX_BLINK			BIT(10)
-#define QCA808X_LED_RX_BLINK			BIT(9)
-#define QCA808X_LED_TX_ON_10MS			BIT(8)
-#define QCA808X_LED_RX_ON_10MS			BIT(7)
-#define QCA808X_LED_SPEED1000_ON		BIT(6)
-#define QCA808X_LED_SPEED100_ON			BIT(5)
-#define QCA808X_LED_SPEED10_ON			BIT(4)
-#define QCA808X_LED_COLLISION_BLINK		BIT(3)
-#define QCA808X_LED_SPEED1000_BLINK		BIT(2)
-#define QCA808X_LED_SPEED100_BLINK		BIT(1)
-#define QCA808X_LED_SPEED10_BLINK		BIT(0)
-
 #define QCA808X_MMD7_LED0_FORCE_CTRL		0x8079
 #define QCA808X_MMD7_LED_FORCE_CTRL(x)		(0x8079 - ((x) * 2))
 
-/* LED force ctrl is the same for every LED
- * No documentation exist for this, not even internal one
- * with NDA as QCOM gives only info about configuring
- * hw control pattern rules and doesn't indicate any way
- * to force the LED to specific mode.
- * These define comes from reverse and testing and maybe
- * lack of some info or some info are not entirely correct.
- * For the basic LED control and hw control these finding
- * are enough to support LED control in all the required APIs.
- *
- * On doing some comparison with implementation with qca807x,
- * it was found that it's 1:1 equal to it and confirms all the
- * reverse done. It was also found further specification with the
- * force mode and the blink modes.
- */
-#define QCA808X_LED_FORCE_EN			BIT(15)
-#define QCA808X_LED_FORCE_MODE_MASK		GENMASK(14, 13)
-#define QCA808X_LED_FORCE_BLINK_1		FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x3)
-#define QCA808X_LED_FORCE_BLINK_2		FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x2)
-#define QCA808X_LED_FORCE_ON			FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x1)
-#define QCA808X_LED_FORCE_OFF			FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x0)
-
 #define QCA808X_MMD7_LED_POLARITY_CTRL		0x901a
 /* QSDK sets by default 0x46 to this reg that sets BIT 6 for
  * LED to active high. It's not clear what BIT 3 and BIT 4 does.
diff --git a/drivers/net/phy/qcom/qcom.h b/drivers/net/phy/qcom/qcom.h
index dc259bbf0678..9e24997c355f 100644
--- a/drivers/net/phy/qcom/qcom.h
+++ b/drivers/net/phy/qcom/qcom.h
@@ -103,6 +103,71 @@
 /* Added for reference of existence but should be handled by wait_for_completion already */
 #define QCA808X_CDT_STATUS_STAT_BUSY		(BIT(1) | BIT(3))
 
+#define QCA808X_MMD7_LED_GLOBAL			0x8073
+#define QCA808X_LED_BLINK_1			GENMASK(11, 6)
+#define QCA808X_LED_BLINK_2			GENMASK(5, 0)
+/* Values are the same for both BLINK_1 and BLINK_2 */
+#define QCA808X_LED_BLINK_FREQ_MASK		GENMASK(5, 3)
+#define QCA808X_LED_BLINK_FREQ_2HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x0)
+#define QCA808X_LED_BLINK_FREQ_4HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x1)
+#define QCA808X_LED_BLINK_FREQ_8HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x2)
+#define QCA808X_LED_BLINK_FREQ_16HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x3)
+#define QCA808X_LED_BLINK_FREQ_32HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x4)
+#define QCA808X_LED_BLINK_FREQ_64HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x5)
+#define QCA808X_LED_BLINK_FREQ_128HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x6)
+#define QCA808X_LED_BLINK_FREQ_256HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x7)
+#define QCA808X_LED_BLINK_DUTY_MASK		GENMASK(2, 0)
+#define QCA808X_LED_BLINK_DUTY_50_50		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x0)
+#define QCA808X_LED_BLINK_DUTY_75_25		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x1)
+#define QCA808X_LED_BLINK_DUTY_25_75		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x2)
+#define QCA808X_LED_BLINK_DUTY_33_67		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x3)
+#define QCA808X_LED_BLINK_DUTY_67_33		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x4)
+#define QCA808X_LED_BLINK_DUTY_17_83		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x5)
+#define QCA808X_LED_BLINK_DUTY_83_17		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x6)
+#define QCA808X_LED_BLINK_DUTY_8_92		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x7)
+
+/* LED hw control pattern is the same for every LED */
+#define QCA808X_LED_PATTERN_MASK		GENMASK(15, 0)
+#define QCA808X_LED_SPEED2500_ON		BIT(15)
+#define QCA808X_LED_SPEED2500_BLINK		BIT(14)
+/* Follow blink trigger even if duplex or speed condition doesn't match */
+#define QCA808X_LED_BLINK_CHECK_BYPASS		BIT(13)
+#define QCA808X_LED_FULL_DUPLEX_ON		BIT(12)
+#define QCA808X_LED_HALF_DUPLEX_ON		BIT(11)
+#define QCA808X_LED_TX_BLINK			BIT(10)
+#define QCA808X_LED_RX_BLINK			BIT(9)
+#define QCA808X_LED_TX_ON_10MS			BIT(8)
+#define QCA808X_LED_RX_ON_10MS			BIT(7)
+#define QCA808X_LED_SPEED1000_ON		BIT(6)
+#define QCA808X_LED_SPEED100_ON			BIT(5)
+#define QCA808X_LED_SPEED10_ON			BIT(4)
+#define QCA808X_LED_COLLISION_BLINK		BIT(3)
+#define QCA808X_LED_SPEED1000_BLINK		BIT(2)
+#define QCA808X_LED_SPEED100_BLINK		BIT(1)
+#define QCA808X_LED_SPEED10_BLINK		BIT(0)
+
+/* LED force ctrl is the same for every LED
+ * No documentation exist for this, not even internal one
+ * with NDA as QCOM gives only info about configuring
+ * hw control pattern rules and doesn't indicate any way
+ * to force the LED to specific mode.
+ * These define comes from reverse and testing and maybe
+ * lack of some info or some info are not entirely correct.
+ * For the basic LED control and hw control these finding
+ * are enough to support LED control in all the required APIs.
+ *
+ * On doing some comparison with implementation with qca807x,
+ * it was found that it's 1:1 equal to it and confirms all the
+ * reverse done. It was also found further specification with the
+ * force mode and the blink modes.
+ */
+#define QCA808X_LED_FORCE_EN			BIT(15)
+#define QCA808X_LED_FORCE_MODE_MASK		GENMASK(14, 13)
+#define QCA808X_LED_FORCE_BLINK_1		FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x3)
+#define QCA808X_LED_FORCE_BLINK_2		FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x2)
+#define QCA808X_LED_FORCE_ON			FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x1)
+#define QCA808X_LED_FORCE_OFF			FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x0)
+
 #define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
 #define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
 #define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
-- 
2.43.0


