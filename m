Return-Path: <linux-kernel+bounces-15533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1F3822D72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C7928324B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F9C199DE;
	Wed,  3 Jan 2024 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfUaXq8i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C461946B;
	Wed,  3 Jan 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3366e78d872so10037963f8f.3;
        Wed, 03 Jan 2024 04:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704286012; x=1704890812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCJqZdq/iqlteXCIkR1kOvJH/pGADA5Hu358ETfwzNc=;
        b=AfUaXq8i4gzX5Cr8POjULLsWuAI9CKSmUcLkoZ5qAtyot0H2gULh2UXLs1cMiiRFdl
         rBkpadouheHNioCl4MAs2wexM8UHTD2tvkI8jUV144WrjsQnmF1XmQ01zZ/uPefLK/oh
         +TdJw1sQx14b2vu6zMnyCO3zTnBAyjsG7Ya3m+W4IYMRvJxKvdNV/jG5TD5AJsdWPl8q
         I8QoK43xQk4jXHre4iRKjQLK5GEq8UeFvQF1VDOQTZru1uKvxpTBlF7GViGls3ElBDFi
         dT0J2Qxq4+KNwbC2BCZOqO3wBu8zkDq7NQ+1L4INVe7uDN/jfzzbmwxFPs9jOvDrSK3O
         UMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704286012; x=1704890812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCJqZdq/iqlteXCIkR1kOvJH/pGADA5Hu358ETfwzNc=;
        b=gzKH6mpKaKFEJRdgTbpF5TGomyqYuR6DD2vKWTxeYbux0vyNE7oQUYxefuGThd4x1u
         X5Uo3mMvRE7JvXEh5az3xT3d6UVQuLaUYNGH0lMv6GD+YuHiE66tY1phHKJ9dpuW2CYo
         wo8fS+l/RXeTXHt7WJEIYCFIHzDUi5/BxLOgsDp4z+YMsJ/e5bgFvZWxIrr/RV+wq7y2
         TVO5mI57kMaNAp+SfNX/TdxtSHOgBHfHcl7SXg5413jWjazsRxokCJOYCPc+yIvgqEo7
         cbdFvGcmqA2OO4R2HljlxOArVfMHB3xcj9qQzSiDM3TP81E1XMhvKDarnPkFkqQyPZl+
         X5pA==
X-Gm-Message-State: AOJu0YwvKXzv1D53F/65NTsNqpwX+Uj1vh2BZnSszBVmBcsMN1bKZSTb
	W9cKeiNysRT52mrntBk1CvE=
X-Google-Smtp-Source: AGHT+IFsHG+aL1d2o3l8gkE3tvPrX7dtHc1YZa0s7VMNnweJcK9cu64DMQ1jLm7U9VpDEoSWAG5Qlw==
X-Received: by 2002:a05:600c:3c94:b0:40d:62f9:8e5f with SMTP id bg20-20020a05600c3c9400b0040d62f98e5fmr2631717wmb.214.1704286011846;
        Wed, 03 Jan 2024 04:46:51 -0800 (PST)
Received: from localhost.localdomain (host-87-10-250-100.retail.telecomitalia.it. [87.10.250.100])
        by smtp.googlemail.com with ESMTPSA id fc16-20020a05600c525000b0040d5c58c41dsm2219676wmb.24.2024.01.03.04.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 04:46:51 -0800 (PST)
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
Subject: [net-next PATCH v3 2/4] net: phy: at803x: refactor qca808x cable test get status function
Date: Wed,  3 Jan 2024 13:46:33 +0100
Message-ID: <20240103124637.3078-3-ansuelsmth@gmail.com>
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

Refactor qca808x cable test get status function to remove code
duplication and clean things up.

The same logic is applied to each pair hence it can be generalized and
moved to a common function.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 65 +++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index acf483fa0887..b87293ee736c 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -2037,10 +2037,39 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
 	return 0;
 }
 
+static void qca808x_cable_test_get_pair_status(struct phy_device *phydev, u8 pair,
+					       u16 status)
+{
+	u16 pair_code;
+	int length;
+
+	switch (pair) {
+	case ETHTOOL_A_CABLE_PAIR_A:
+		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_A, status);
+		break;
+	case ETHTOOL_A_CABLE_PAIR_B:
+		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_B, status);
+		break;
+	case ETHTOOL_A_CABLE_PAIR_C:
+		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_C, status);
+		break;
+	case ETHTOOL_A_CABLE_PAIR_D:
+		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_D, status);
+		break;
+	}
+
+	ethnl_cable_test_result(phydev, pair,
+				qca808x_cable_test_result_trans(pair_code));
+
+	if (qca808x_cdt_fault_length_valid(pair_code)) {
+		length = qca808x_cdt_fault_length(phydev, pair);
+		ethnl_cable_test_fault_length(phydev, pair, length);
+	}
+}
+
 static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished)
 {
 	int ret, val;
-	int pair_a, pair_b, pair_c, pair_d;
 
 	*finished = false;
 
@@ -2059,36 +2088,10 @@ static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finish
 	if (val < 0)
 		return val;
 
-	pair_a = FIELD_GET(QCA808X_CDT_CODE_PAIR_A, val);
-	pair_b = FIELD_GET(QCA808X_CDT_CODE_PAIR_B, val);
-	pair_c = FIELD_GET(QCA808X_CDT_CODE_PAIR_C, val);
-	pair_d = FIELD_GET(QCA808X_CDT_CODE_PAIR_D, val);
-
-	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
-				qca808x_cable_test_result_trans(pair_a));
-	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_B,
-				qca808x_cable_test_result_trans(pair_b));
-	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_C,
-				qca808x_cable_test_result_trans(pair_c));
-	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_D,
-				qca808x_cable_test_result_trans(pair_d));
-
-	if (qca808x_cdt_fault_length_valid(pair_a)) {
-		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A);
-		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A, val);
-	}
-	if (qca808x_cdt_fault_length_valid(pair_b)) {
-		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B);
-		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B, val);
-	}
-	if (qca808x_cdt_fault_length_valid(pair_c)) {
-		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C);
-		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C, val);
-	}
-	if (qca808x_cdt_fault_length_valid(pair_d)) {
-		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D);
-		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D, val);
-	}
+	qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_A, val);
+	qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_B, val);
+	qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_C, val);
+	qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_D, val);
 
 	*finished = true;
 
-- 
2.43.0


