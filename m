Return-Path: <linux-kernel+bounces-17244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C92824A58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76006281C21
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB032CCDD;
	Thu,  4 Jan 2024 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKKMn/Uq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6EC2C848;
	Thu,  4 Jan 2024 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40b5155e154so10404695e9.3;
        Thu, 04 Jan 2024 13:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704403867; x=1705008667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvtR6iye3JdQbBg2U9ZsdQ8z0E/SeiPleS7A09isN6U=;
        b=hKKMn/UqOCNQcbWvDYKQE2dIN1CBbXWzpw9GBcecMEA8Ff1UtWZ+9erF3MfOlDzj1n
         ZlpefgHUY+gcHhD3Svxx5vVu3DxOCIUUzl82DoGGcE7KuH9e0qkOyaVFk3qbCxGEqdse
         OBTSScE/K/YgSc5ANY4fXJjF6E5TRv7rg5UiyVgqgedb+cMxW5LxBdaBzOlF6iaedNL2
         kcTKrX1zN4RI9xF+ScRSHutDzqGstzNpvXN+do0v+kTrn01c9lqpMUgyDGJPIbZ2czhK
         TtK4IH/cFVHaYhHI0rkSWBZneEmpqj749xJA/Wmgq0WnbO9x70lb+8uFcbVEBsUPdpii
         3xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704403867; x=1705008667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvtR6iye3JdQbBg2U9ZsdQ8z0E/SeiPleS7A09isN6U=;
        b=NTASupT2ycTLAWbRyDXzKXa60L6N9mvkdD9r3+QwLxa37IgBhAeAhPHSsE+P3FJjio
         XXvPLNvZEYBGlyvH+eRcjejTL9vXiPM9bX0yRbqcMsqD3dVAafwmncZgih7612yur2+C
         lXItEb+WLBHWRbDweNqYO2oUziPp4xppMpki4GGawvKfSZVwKmr5RGoua567+/4IY4rM
         MgXJMi1rxb6Pf2lz8ZrdkkFVXb8L5iqJ7+lcPAvyjJmiM53Vlq1th6mEfK2uh6ieuAz1
         T5WrYoD5DBXvSaDF0lWLqRuuXhmVxSbfz9jmQPM2p0vCNXvNgiQxpdsGTzU4d8qgkxeN
         7wKA==
X-Gm-Message-State: AOJu0Yy9scbxj6xNUaERVIiL1owDjobSQGtE6ZC8VF5XxPkkRzjsucAG
	sHFTbt032SJjQWo1/8Pw+4c=
X-Google-Smtp-Source: AGHT+IHxNFI8XYrNm5dUdq3Znjpgg3sDKf8jQ1TgpPoUAjhJldACHA4cpK1FjRq3t+o/jaca0sVsHg==
X-Received: by 2002:a05:600c:502a:b0:40d:3267:5d92 with SMTP id n42-20020a05600c502a00b0040d32675d92mr622440wmr.247.1704403867405;
        Thu, 04 Jan 2024 13:31:07 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.pool80116.interbusiness.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id f14-20020a05600c4e8e00b0040d3dc78003sm407291wmq.17.2024.01.04.13.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 13:31:07 -0800 (PST)
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
Subject: [net-next PATCH v4 2/4] net: phy: at803x: refactor qca808x cable test get status function
Date: Thu,  4 Jan 2024 22:30:39 +0100
Message-ID: <20240104213044.4653-3-ansuelsmth@gmail.com>
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

Refactor qca808x cable test get status function to remove code
duplication and clean things up.

The same logic is applied to each pair hence it can be generalized and
moved to a common function.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 80 ++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index acf483fa0887..8d824094bc71 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -2037,10 +2037,43 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca808x_cable_test_get_pair_status(struct phy_device *phydev, u8 pair,
+					      u16 status)
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
+	default:
+		return -EINVAL;
+	}
+
+	ethnl_cable_test_result(phydev, pair,
+				qca808x_cable_test_result_trans(pair_code));
+
+	if (qca808x_cdt_fault_length_valid(pair_code)) {
+		length = qca808x_cdt_fault_length(phydev, pair);
+		ethnl_cable_test_fault_length(phydev, pair, length);
+	}
+
+	return 0;
+}
+
 static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished)
 {
 	int ret, val;
-	int pair_a, pair_b, pair_c, pair_d;
 
 	*finished = false;
 
@@ -2059,36 +2092,21 @@ static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finish
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
+	ret = qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_A, val);
+	if (ret)
+		return ret;
+
+	ret = qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_B, val);
+	if (ret)
+		return ret;
+
+	ret = qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_C, val);
+	if (ret)
+		return ret;
+
+	ret = qca808x_cable_test_get_pair_status(phydev, ETHTOOL_A_CABLE_PAIR_D, val);
+	if (ret)
+		return ret;
 
 	*finished = true;
 
-- 
2.43.0


