Return-Path: <linux-kernel+bounces-14457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF960821D46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E012B1C222E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4535314A82;
	Tue,  2 Jan 2024 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZM2Fg+s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A911704;
	Tue,  2 Jan 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d8e7a50c1so1611995e9.2;
        Tue, 02 Jan 2024 06:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704204218; x=1704809018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsA0JDN11Q2nz8SUx5kA6LiRo/4zS6VELKeRkM4TXVA=;
        b=OZM2Fg+skPXGCyBQJKo57m5mD6aNcZCZsqlMcRxX2ZotQXN4yI7Y8y5B1OESfyDdT5
         +ZJAFRSnqM/kLDIYj5kJ8TBj4+A/lXMEJB7GeWQ222HXprEQWZ2wTLV5Ee2TaGGWeOq1
         PR7qdkEuuTSSKtW81woIcOSDyS3b66EuZ7FttPdRqX0hKuAnsLdvDrpM/NbmxwYA+Dni
         rcSjy91n+cCWh8Ryoe0KpHqWXjsupA7KLVDdHK76VBIhOkCFdO+gPrVPm57zxbDQeDD9
         uyMUf3QHOT2iRiYxdgGbUXhj/1faJsVIgTHZ+WXSZmsUF/UmFFA4nzfXri/XrA4r3Jg6
         oZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204218; x=1704809018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsA0JDN11Q2nz8SUx5kA6LiRo/4zS6VELKeRkM4TXVA=;
        b=OmJnbu8cMmocmHp1gR/RnOK0gEDHNC6/F39XXo156Z2NWpTO22VyNNdYtB1VxOLZXO
         0/hrMl2doLYFN7xLEq6ZJytX/feqiKeWfcjX6pN61syH5mRIKa/BbBJZAR/T6Ddj1P/P
         aTzKQ+LUaclloFUBH6BPu88ZsjQHByMQDlX7bth33BO9rgKQjXZiNIh0LM9eQdHLB8bx
         dWK3GGRHTFBo9oZlgFjG4YNu8hpd2vi7/ikQHXV2qiuj+wgAOdk+//TR70KPv4jCQeAu
         7twxijmpBBbVR2WlhFR1nbtnXNThy8anWwtcCNKZ5rIXi6sNZCf2mqtc14bHw7KtwowB
         tqrg==
X-Gm-Message-State: AOJu0Yyw+cxiFOAmryyga/v5bq5Plnvr3Sd6/+D8p4HkYVatAPZv1n6b
	hXwHele6RSZ9fsaqsOMWxsM=
X-Google-Smtp-Source: AGHT+IFO0x7FPOLsqiy7eB8aN0MJGrnwjAvilVQMmuk9oZMM3Jx8gJ0f0Sx9LugBJ5EbovoepY3BiQ==
X-Received: by 2002:a7b:c4cc:0:b0:40d:88c4:a59e with SMTP id g12-20020a7bc4cc000000b0040d88c4a59emr1239494wmk.164.1704204218226;
        Tue, 02 Jan 2024 06:03:38 -0800 (PST)
Received: from localhost.localdomain (host-87-10-250-100.retail.telecomitalia.it. [87.10.250.100])
        by smtp.googlemail.com with ESMTPSA id e17-20020a5d5311000000b0033672cfca96sm28427527wrv.89.2024.01.02.06.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:03:37 -0800 (PST)
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
Subject: [net-next PATCH v2 2/4] net: phy: at803x: refactor qca808x cable test get status function
Date: Tue,  2 Jan 2024 15:03:26 +0100
Message-ID: <20240102140330.7371-3-ansuelsmth@gmail.com>
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

Refactor qca808x cable test get status function to remove code
duplication and clean things up.

The same logic is applied to each pair hence it can be generalized and
moved to a common function.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 65 +++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 072bcd670ef0..9610b51a5928 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -2102,10 +2102,39 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
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
 
@@ -2124,36 +2153,10 @@ static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finish
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


