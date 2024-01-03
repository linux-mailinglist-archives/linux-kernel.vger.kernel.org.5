Return-Path: <linux-kernel+bounces-15534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF0E822D74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414A61C23411
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36A01A289;
	Wed,  3 Jan 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awWjsNRz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56497199C9;
	Wed,  3 Jan 2024 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d5336986cso102026845e9.1;
        Wed, 03 Jan 2024 04:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704286013; x=1704890813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLK5iCROUw8443l+GbLHNZT9zorVpYX24QDPt5c4KHg=;
        b=awWjsNRzxWzjNKbRpyb9EfVhZK4mOld2FfmKStzXa0GPLKb3ebDsARcXQE4YafpV9x
         CkHHg8k89tAHbVWVIXPAPu8hsFBr5Ou1tA2gvKPIcur+NyDrB84KXqnYoIOvnb2alkVK
         buWgznT2QcxQAcD6lw7SDWC9Dgy2xcBlH6+kSrDT/HmpC1MJnJ8nhssP7FQ0o9zWBvjH
         7OkJ0LPqGcxpGGUxg1d+S6mSi7F2zwpUf8XF6ODV4r3NuggzZKDh5dU3AMgp3cCMK3qC
         Az7b1t3pKEuJYtk8pCWTHrFeanXClcf3SZLqqxPYU4dKmPhFh8ZHgqWimgbKMEhBJerm
         rf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704286013; x=1704890813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLK5iCROUw8443l+GbLHNZT9zorVpYX24QDPt5c4KHg=;
        b=ppHcK/E+H3zVxYn5nChhTVgCPh4RApjt00JMCfFjS7Pb90F6+kScq1KAb51WWquvCj
         iBCRiryQEuxAaZ1Yesw2DAxwUKg8P2QNIlp0UhHUZfW3Lxi5eIEAT1Kq8fmLRG1XrPHk
         LDZtwlMogfGb8m8vhd0Af+glxzRKBT+FtzIm736wMFCSEgnH/Q1WmeNqcyxGRyNoerSL
         ABDahY9UwuuuldSRKYgRk02YXX6mVDad7z3CEariv66PuVtyv8rsBhnBuJT/NaTqogar
         K5T5UMaDmXdlXNzuXcP+2nmHtbWOBrPVjnAKBqblVsihsAvOlAcObOIHaliHy0MXFAfZ
         5Kdg==
X-Gm-Message-State: AOJu0Yw0ZGu7F0/p8rGjYUnnzVvtv7cY2xmqCAttjH3/0g+7SSnEDWVF
	JkKsxXLCkTKtDTVrm6D9fy0=
X-Google-Smtp-Source: AGHT+IG32cRCa7TOIH2XjBjJ/8f2Vh/2f7l+rYA17uznCoenFXLhnD0FSqhL+U5UzMSSB0knY2kKuA==
X-Received: by 2002:a05:600c:3652:b0:40d:5c54:9bb5 with SMTP id y18-20020a05600c365200b0040d5c549bb5mr6167204wmq.170.1704286013288;
        Wed, 03 Jan 2024 04:46:53 -0800 (PST)
Received: from localhost.localdomain (host-87-10-250-100.retail.telecomitalia.it. [87.10.250.100])
        by smtp.googlemail.com with ESMTPSA id fc16-20020a05600c525000b0040d5c58c41dsm2219676wmb.24.2024.01.03.04.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 04:46:52 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v3 3/4] net: phy: at803x: add support for cdt cross short test for qca808x
Date: Wed,  3 Jan 2024 13:46:34 +0100
Message-ID: <20240103124637.3078-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103124637.3078-1-ansuelsmth@gmail.com>
References: <20240103124637.3078-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QCA808x PHY Family supports Cable Diagnostic Test also for Cross Pair
Short.

Add all the define to make enable and support these additional tests.

Cross Short test was previously disabled by default, this is now changed
and enabled by default. In this mode, the mask changed a bit and length
is shifted based on the fault condition.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 86 ++++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index b87293ee736c..d6dfe906cb62 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -254,6 +254,7 @@
 
 #define QCA808X_CDT_ENABLE_TEST			BIT(15)
 #define QCA808X_CDT_INTER_CHECK_DIS		BIT(13)
+#define QCA808X_CDT_STATUS			BIT(11)
 #define QCA808X_CDT_LENGTH_UNIT			BIT(10)
 
 #define QCA808X_MMD3_CDT_STATUS			0x8064
@@ -261,16 +262,44 @@
 #define QCA808X_MMD3_CDT_DIAG_PAIR_B		0x8066
 #define QCA808X_MMD3_CDT_DIAG_PAIR_C		0x8067
 #define QCA808X_MMD3_CDT_DIAG_PAIR_D		0x8068
-#define QCA808X_CDT_DIAG_LENGTH			GENMASK(7, 0)
+#define QCA808X_CDT_DIAG_LENGTH_SAME_SHORT	GENMASK(15, 8)
+#define QCA808X_CDT_DIAG_LENGTH_CROSS_SHORT	GENMASK(7, 0)
 
 #define QCA808X_CDT_CODE_PAIR_A			GENMASK(15, 12)
 #define QCA808X_CDT_CODE_PAIR_B			GENMASK(11, 8)
 #define QCA808X_CDT_CODE_PAIR_C			GENMASK(7, 4)
 #define QCA808X_CDT_CODE_PAIR_D			GENMASK(3, 0)
-#define QCA808X_CDT_STATUS_STAT_FAIL		0
-#define QCA808X_CDT_STATUS_STAT_NORMAL		1
-#define QCA808X_CDT_STATUS_STAT_OPEN		2
-#define QCA808X_CDT_STATUS_STAT_SHORT		3
+
+#define QCA808X_CDT_STATUS_STAT_TYPE		GENMASK(1, 0)
+#define QCA808X_CDT_STATUS_STAT_FAIL		FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_TYPE, 0)
+#define QCA808X_CDT_STATUS_STAT_NORMAL		FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_TYPE, 1)
+#define QCA808X_CDT_STATUS_STAT_SAME_OPEN	FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_TYPE, 2)
+#define QCA808X_CDT_STATUS_STAT_SAME_SHORT	FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_TYPE, 3)
+
+#define QCA808X_CDT_STATUS_STAT_MDI		GENMASK(3, 2)
+#define QCA808X_CDT_STATUS_STAT_MDI1		FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_MDI, 1)
+#define QCA808X_CDT_STATUS_STAT_MDI2		FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_MDI, 2)
+#define QCA808X_CDT_STATUS_STAT_MDI3		FIELD_PREP_CONST(QCA808X_CDT_STATUS_STAT_MDI, 3)
+
+/* NORMAL are MDI with type set to 0 */
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_NORMAL	QCA808X_CDT_STATUS_STAT_MDI1
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_OPEN		(QCA808X_CDT_STATUS_STAT_SAME_OPEN |\
+									 QCA808X_CDT_STATUS_STAT_MDI1)
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_SHORT	(QCA808X_CDT_STATUS_STAT_SAME_SHORT |\
+									 QCA808X_CDT_STATUS_STAT_MDI1)
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_NORMAL	QCA808X_CDT_STATUS_STAT_MDI2
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_OPEN		(QCA808X_CDT_STATUS_STAT_SAME_OPEN |\
+									 QCA808X_CDT_STATUS_STAT_MDI2)
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_SHORT	(QCA808X_CDT_STATUS_STAT_SAME_SHORT |\
+									 QCA808X_CDT_STATUS_STAT_MDI2)
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_NORMAL	QCA808X_CDT_STATUS_STAT_MDI3
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_OPEN		(QCA808X_CDT_STATUS_STAT_SAME_OPEN |\
+									 QCA808X_CDT_STATUS_STAT_MDI3)
+#define QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_SHORT	(QCA808X_CDT_STATUS_STAT_SAME_SHORT |\
+									 QCA808X_CDT_STATUS_STAT_MDI3)
+
+/* Added for reference of existence but should be handled by wait_for_completion already */
+#define QCA808X_CDT_STATUS_STAT_BUSY		(BIT(1) | BIT(3))
 
 /* QCA808X 1G chip type */
 #define QCA808X_PHY_MMD7_CHIP_TYPE		0x901d
@@ -1943,8 +1972,17 @@ static int qca808x_soft_reset(struct phy_device *phydev)
 static bool qca808x_cdt_fault_length_valid(int cdt_code)
 {
 	switch (cdt_code) {
-	case QCA808X_CDT_STATUS_STAT_SHORT:
-	case QCA808X_CDT_STATUS_STAT_OPEN:
+	case QCA808X_CDT_STATUS_STAT_SAME_SHORT:
+	case QCA808X_CDT_STATUS_STAT_SAME_OPEN:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_NORMAL:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_OPEN:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_SHORT:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_NORMAL:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_OPEN:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_SHORT:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_NORMAL:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_OPEN:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_SHORT:
 		return true;
 	default:
 		return false;
@@ -1956,17 +1994,28 @@ static int qca808x_cable_test_result_trans(int cdt_code)
 	switch (cdt_code) {
 	case QCA808X_CDT_STATUS_STAT_NORMAL:
 		return ETHTOOL_A_CABLE_RESULT_CODE_OK;
-	case QCA808X_CDT_STATUS_STAT_SHORT:
+	case QCA808X_CDT_STATUS_STAT_SAME_SHORT:
 		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
-	case QCA808X_CDT_STATUS_STAT_OPEN:
+	case QCA808X_CDT_STATUS_STAT_SAME_OPEN:
 		return ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_NORMAL:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_OPEN:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI1_SAME_SHORT:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_NORMAL:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_OPEN:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI2_SAME_SHORT:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_NORMAL:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_OPEN:
+	case QCA808X_CDT_STATUS_STAT_CROSS_SHORT_WITH_MDI3_SAME_SHORT:
+		return ETHTOOL_A_CABLE_RESULT_CODE_CROSS_SHORT;
 	case QCA808X_CDT_STATUS_STAT_FAIL:
 	default:
 		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
 	}
 }
 
-static int qca808x_cdt_fault_length(struct phy_device *phydev, int pair)
+static int qca808x_cdt_fault_length(struct phy_device *phydev, int pair,
+				    int result)
 {
 	int val;
 	u32 cdt_length_reg = 0;
@@ -1992,7 +2041,11 @@ static int qca808x_cdt_fault_length(struct phy_device *phydev, int pair)
 	if (val < 0)
 		return val;
 
-	val = FIELD_GET(QCA808X_CDT_DIAG_LENGTH, val);
+	if (result == ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT)
+		val = FIELD_GET(QCA808X_CDT_DIAG_LENGTH_SAME_SHORT, val);
+	else
+		val = FIELD_GET(QCA808X_CDT_DIAG_LENGTH_CROSS_SHORT, val);
+
 	return at803x_cdt_fault_length(val);
 }
 
@@ -2040,8 +2093,8 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
 static void qca808x_cable_test_get_pair_status(struct phy_device *phydev, u8 pair,
 					       u16 status)
 {
+	int length, result;
 	u16 pair_code;
-	int length;
 
 	switch (pair) {
 	case ETHTOOL_A_CABLE_PAIR_A:
@@ -2058,11 +2111,11 @@ static void qca808x_cable_test_get_pair_status(struct phy_device *phydev, u8 pai
 		break;
 	}
 
-	ethnl_cable_test_result(phydev, pair,
-				qca808x_cable_test_result_trans(pair_code));
+	result = qca808x_cable_test_result_trans(pair_code);
+	ethnl_cable_test_result(phydev, pair, result);
 
 	if (qca808x_cdt_fault_length_valid(pair_code)) {
-		length = qca808x_cdt_fault_length(phydev, pair);
+		length = qca808x_cdt_fault_length(phydev, pair, result);
 		ethnl_cable_test_fault_length(phydev, pair, length);
 	}
 }
@@ -2074,8 +2127,7 @@ static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finish
 	*finished = false;
 
 	val = QCA808X_CDT_ENABLE_TEST |
-	      QCA808X_CDT_LENGTH_UNIT |
-	      QCA808X_CDT_INTER_CHECK_DIS;
+	      QCA808X_CDT_LENGTH_UNIT;
 	ret = at803x_cdt_start(phydev, val);
 	if (ret)
 		return ret;
-- 
2.43.0


