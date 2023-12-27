Return-Path: <linux-kernel+bounces-11930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F25B81EDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E64281EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653F52D052;
	Wed, 27 Dec 2023 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+CMg2Oo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A9C2C680;
	Wed, 27 Dec 2023 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d5aefcc2fso9931975e9.0;
        Wed, 27 Dec 2023 01:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703668802; x=1704273602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOXxtUN/RpaVqO8XGT4OhJI5twgcCMyVso+fabeQr1A=;
        b=B+CMg2Oo8TWwINZbkswZXqzqcuDDnEoNi53Xlwm1Nh7aEtzjGRD48QuZHYcMehtMQR
         9T3B//A018+E5z/0Oxwqm6XhWWEjkpLrn5duGuEjJOya0wInhRqhzMDfO0duHiowWSjw
         9BNI2IHAlaLuAHYs/GOr0kyhg/WkbyjDzIC7v4tqCra0fO7AnO27iEPzDl2hjYW7k2IU
         JneTGNsbZzcIA6aSrMt3XDUyOYl8XIpPr+sphxe/E14SBkDXC1YfGJcDKIVxcPly0imd
         pr1MvjLdP8f9FWLxMTHtiSIrWSuabUDtP+CKQYKCPUtPYk+e6N6weWFaWrRROjl5oO3N
         vzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703668802; x=1704273602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOXxtUN/RpaVqO8XGT4OhJI5twgcCMyVso+fabeQr1A=;
        b=Z95OMvF+xdVwEhAEFW43JGiHwszsceG4PPYCuzY3E5Mb+9PIN8QRlqAbRVwOaKmZNo
         Go+TIN3fNBlykGYzq34/vbWs/fLwqrT2JdUzzt7tVhOtexfZ7IFpKf/E/YzjzUFM+rP7
         Ilbxb7sAFtsXj48dTd3gCxNbhavw+A9LG7LeJqc3n/FrGhxkez6eS+9pkGgSU4/SbO1B
         yTwgvUNd3mHwqI6HF77DdDOMqbULqrUNh0ntVNz1xSNEkWPkK+6Xa09n//srAs40MpQi
         rlitzx5BD6o1ma54lqH+IAh5g6viMVzLTllTAtOZhSxZ/3m+6EeoUN9nwKQsZchJ6IEO
         lbvA==
X-Gm-Message-State: AOJu0Yx2pEm4gpuYWXTRkDNQ1vkLmm24ezg4E7OsE/9Jx+YlGmcGiWSG
	QtEft70s6v3X8l3pNytA+40=
X-Google-Smtp-Source: AGHT+IHYGUSzwD1hgVdtXKsCTT78IItTmnRNk87yNRuQX38RBfNRtHfZGY8Ej9RKqAEDHpgPwaQKPw==
X-Received: by 2002:a05:600c:1907:b0:40d:5fcd:af7f with SMTP id j7-20020a05600c190700b0040d5fcdaf7fmr157720wmq.60.1703668802140;
        Wed, 27 Dec 2023 01:20:02 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id i2-20020a05600c354200b0040d5ac00dc6sm4539749wmq.8.2023.12.27.01.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 01:20:01 -0800 (PST)
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
Subject: [net-next PATCH 2/3] net: phy: at803x: add support for cdt cross short test for qca808x
Date: Wed, 27 Dec 2023 10:19:45 +0100
Message-Id: <20231227091946.12937-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231227091946.12937-1-ansuelsmth@gmail.com>
References: <20231227091946.12937-1-ansuelsmth@gmail.com>
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
 drivers/net/phy/at803x.c | 90 ++++++++++++++++++++++++++++++++--------
 1 file changed, 73 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 072bcd670ef0..a2f5d608b59e 100644
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
 
 #define QCA808X_MMD7_LED2_CTRL			0x8074
 #define QCA808X_MMD7_LED2_FORCE_CTRL		0x8075
@@ -2008,8 +2037,17 @@ static int qca808x_soft_reset(struct phy_device *phydev)
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
@@ -2021,17 +2059,28 @@ static int qca808x_cable_test_result_trans(int cdt_code)
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
@@ -2057,7 +2106,11 @@ static int qca808x_cdt_fault_length(struct phy_device *phydev, int pair)
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
 
@@ -2110,8 +2163,7 @@ static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finish
 	*finished = false;
 
 	val = QCA808X_CDT_ENABLE_TEST |
-	      QCA808X_CDT_LENGTH_UNIT |
-	      QCA808X_CDT_INTER_CHECK_DIS;
+	      QCA808X_CDT_LENGTH_UNIT;
 	ret = at803x_cdt_start(phydev, val);
 	if (ret)
 		return ret;
@@ -2139,19 +2191,23 @@ static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finish
 				qca808x_cable_test_result_trans(pair_d));
 
 	if (qca808x_cdt_fault_length_valid(pair_a)) {
-		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A);
+		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A,
+					       qca808x_cable_test_result_trans(pair_a));
 		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A, val);
 	}
 	if (qca808x_cdt_fault_length_valid(pair_b)) {
-		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B);
+		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B,
+					       qca808x_cable_test_result_trans(pair_b));
 		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B, val);
 	}
 	if (qca808x_cdt_fault_length_valid(pair_c)) {
-		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C);
+		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C,
+					       qca808x_cable_test_result_trans(pair_c));
 		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C, val);
 	}
 	if (qca808x_cdt_fault_length_valid(pair_d)) {
-		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D);
+		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D,
+					       qca808x_cable_test_result_trans(pair_d));
 		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D, val);
 	}
 
-- 
2.40.1


