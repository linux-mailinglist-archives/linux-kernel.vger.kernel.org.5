Return-Path: <linux-kernel+bounces-17245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57394824A5A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5C7EB238D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A1D2D600;
	Thu,  4 Jan 2024 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL1BFsti"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F952C875;
	Thu,  4 Jan 2024 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d894764e7so9582595e9.1;
        Thu, 04 Jan 2024 13:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704403869; x=1705008669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aDqVp7CNb1mfCjhu2U82SFtVn7m4mZQtajq5BiBF4U=;
        b=dL1BFstizkp3jyb/uqrkgeeHX+9ojskRONZMLu8K+fQQmn6k82nXlDIbzl4WspZx1q
         DFyUAWnVaXQ0EYb1ZVGg6ELGj6q8IC/24akxT0QhdF9fpUXozr917zqAPasb0wIC80hM
         07gpWDzQDKT3QvGDUwv031sYQZ1SNT0NmMe6crJGDPWSZd8m4OTNodZEcsI1a5TTgVJ5
         gB4NMHPoVDSd72+d7qoifjldukmXC0SvuSaq5VRE8hc8ZmhIYcPHrHSpEcTiNBrmNFrX
         h7AaIi4gEyeXWn0iwaZUZyXVgh0F3HdvW5uU8fBTOlXri8vmTyp77u5l6T2O530YSFsM
         Rbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704403869; x=1705008669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aDqVp7CNb1mfCjhu2U82SFtVn7m4mZQtajq5BiBF4U=;
        b=EkiyDTUbTdfMcidRG+d3TzknfKge2V9+EBsUvwAVkNcxqptKOBlNuI/Bc0n5dbTtNQ
         5xNP8o4OVG9neu7z3X3SqYCQ5MzL+yi6cgOHN7Y14tJlmoxwdme2/Jl5rfqlKo03iCzh
         P2EAVCnhnB9J+hLgSlsUwlKO+zI9KEuBUObe9vZQp1L71YcATu0Q0GkCDBze5ZgmyRLq
         gfJ5cW/Nt9FTbZaB/SCKZsJA3a3qu2cwfeAolzvmqQ5KrkYfhoHg1wRlLkvUNOhCT04g
         mc6hiL52ISM8LQOcJ/+UhrpjtOXosMLnkxhNeHWQmMdA2Vj81bEhI63GhE31O1aq2f2n
         cs5g==
X-Gm-Message-State: AOJu0YxGDgduWDAH16umKHcPFJXQnlF8U/bbJNfnaoj8oL5vhzvNEj2N
	JngivX2KK/Q2CGbkmO9xudw=
X-Google-Smtp-Source: AGHT+IFwnNbK9Fdlrc/9XaKVewhnZDFwbx8PLBqg2CeMG6caFV1g6sawRfWpOmoacLaRpBcD9stG5Q==
X-Received: by 2002:a05:600c:3112:b0:40d:88a7:f908 with SMTP id g18-20020a05600c311200b0040d88a7f908mr512044wmo.229.1704403868680;
        Thu, 04 Jan 2024 13:31:08 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.pool80116.interbusiness.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id f14-20020a05600c4e8e00b0040d3dc78003sm407291wmq.17.2024.01.04.13.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 13:31:08 -0800 (PST)
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
Subject: [net-next PATCH v4 3/4] net: phy: at803x: add support for cdt cross short test for qca808x
Date: Thu,  4 Jan 2024 22:30:40 +0100
Message-ID: <20240104213044.4653-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104213044.4653-1-ansuelsmth@gmail.com>
References: <20240104213044.4653-1-ansuelsmth@gmail.com>
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
index 8d824094bc71..b44b91c58696 100644
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
 static int qca808x_cable_test_get_pair_status(struct phy_device *phydev, u8 pair,
 					      u16 status)
 {
+	int length, result;
 	u16 pair_code;
-	int length;
 
 	switch (pair) {
 	case ETHTOOL_A_CABLE_PAIR_A:
@@ -2060,11 +2113,11 @@ static int qca808x_cable_test_get_pair_status(struct phy_device *phydev, u8 pair
 		return -EINVAL;
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
 
@@ -2078,8 +2131,7 @@ static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finish
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


