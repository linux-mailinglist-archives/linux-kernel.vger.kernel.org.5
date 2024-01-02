Return-Path: <linux-kernel+bounces-14458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C95821D48
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE5BB2237B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1C914F77;
	Tue,  2 Jan 2024 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLCHUUNk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C622313ADA;
	Tue,  2 Jan 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33686649b72so9638710f8f.3;
        Tue, 02 Jan 2024 06:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704204220; x=1704809020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCe7bi22I9OO+O1jPW0w/LAeUi3E0GH8xhFVY0QzJoM=;
        b=fLCHUUNkmQDujZtVtblj+Zr0aey0ivB+dSQQvLzAvQkeYcoh7jIfzQFsrhbNHvaOLW
         +hLEaWuVc20PMzK0/QD1FYd6C3LckqLTUnVWcz3vuaNVFTNTFkLLH0M/DDmhtoJe4mTx
         yFfJkQdd00nLB3WeTP2yWJkEQR6ywUUf0TpUu3zNagBzuQSMuBjJrgoC/pA+YytA4Que
         ET4hKkbo6ptiHq75QswTfqUlz6fIpsCe7W0x44dzHgm56RYBUTCiemYNu1rzMXcF4gT3
         dKULmC/wgr4CkTwjNUXNX7ArQa8rBqgjvfF2drd+ZOmIgBxCFhVfniu5KHLw7S0xlhQU
         AwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204220; x=1704809020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCe7bi22I9OO+O1jPW0w/LAeUi3E0GH8xhFVY0QzJoM=;
        b=Ox85IbzxNNvr0Rw/YPdMMlZmGBlqJc7J5Rnyyz55fo2MQ/Y/b++j98Ledkxcdwbmxu
         VFmILtbz4QehaNRHPpSP/2K4w5HvQrjNs7qrZvTrjV/Oj+1tpBWXF1CMfiD42M/Mo57B
         2ILv70QKmAfyPM3M6G5iYlUQsaPbmjMGYC7jK01/Fmuo0iFohUFQCU9RPPT0oTMwV2Nh
         v5lGhxXQGHtoF1hjb5PQS08rDyHjGz3WAmOrXTkcJGAZdCY6q44ioIHYhh8RZLqZSkTg
         X/ykjw41SXNrLx5ysp1fODHRnYm8tHVVbHq/+v5aV69ish3yQkuIWZBtOBsrQYp0Xcvh
         G1XA==
X-Gm-Message-State: AOJu0YxgZ3XUIypEC02qXirSIFUxKuQ9iLKtXSb48weYZ5kioXnwsaQ7
	k4tDBSHeWUFZIW5BVybfLgs=
X-Google-Smtp-Source: AGHT+IGvj4P47fCByDf4o6F+GBqbQH9myaYdMVw+NiYZkwgBnb7U8EVWISXW5Q0eWcOShzGHiKi4cg==
X-Received: by 2002:adf:fa84:0:b0:336:b937:3d0e with SMTP id h4-20020adffa84000000b00336b9373d0emr9009616wrr.14.1704204219894;
        Tue, 02 Jan 2024 06:03:39 -0800 (PST)
Received: from localhost.localdomain (host-87-10-250-100.retail.telecomitalia.it. [87.10.250.100])
        by smtp.googlemail.com with ESMTPSA id e17-20020a5d5311000000b0033672cfca96sm28427527wrv.89.2024.01.02.06.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:03:39 -0800 (PST)
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
Subject: [net-next PATCH v2 3/4] net: phy: at803x: add support for cdt cross short test for qca808x
Date: Tue,  2 Jan 2024 15:03:27 +0100
Message-ID: <20240102140330.7371-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102140330.7371-1-ansuelsmth@gmail.com>
References: <20240102140330.7371-1-ansuelsmth@gmail.com>
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
index 9610b51a5928..3d3d34ef594c 100644
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
 
@@ -2105,8 +2158,8 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
 static void qca808x_cable_test_get_pair_status(struct phy_device *phydev, u8 pair,
 					       u16 status)
 {
+	int length, result;
 	u16 pair_code;
-	int length;
 
 	switch (pair) {
 	case ETHTOOL_A_CABLE_PAIR_A:
@@ -2123,11 +2176,11 @@ static void qca808x_cable_test_get_pair_status(struct phy_device *phydev, u8 pai
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
@@ -2139,8 +2192,7 @@ static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finish
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


