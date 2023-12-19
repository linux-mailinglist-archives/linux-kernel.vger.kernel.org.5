Return-Path: <linux-kernel+bounces-6072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EDA8193E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B7D2880E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676103D0C1;
	Tue, 19 Dec 2023 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9xKYhqS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9733C6AC;
	Tue, 19 Dec 2023 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3365f09de18so4036070f8f.2;
        Tue, 19 Dec 2023 14:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703026452; x=1703631252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pCT19HnqF3NUzf8PCXbeQVIOPBViMyp3LuuKZVmyGug=;
        b=b9xKYhqSOF3XGm4N0tB9147ZifSasUPr8fK7UvTFm0I+SB0BJ1XVYMYw63S+MnGi8K
         ZWMZZE03qcFWblGGFhE2rU6u+Wt4WnyalcSD6BJoIFxx29SyYv5DUanlHeGHD3NXBpmk
         Ocz4x0yDGRszFXCVUarljHzzWVrfwWVys6XWzxOBTNY90wI+5NwBIficu3bNv8Tf1BrD
         QMoxqHDI7lLDaexJqel5mZ3leE/zHv3EmA7Xe942VSwgroqaIICWVFelvwgA23Iz24O6
         H/QOWtPY6z8xO5GC4EvMlBBZfuR2wDXe6Y+OczJdyyEHUyn6xOMNOPonTT5QY3n/vi0f
         2ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703026452; x=1703631252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCT19HnqF3NUzf8PCXbeQVIOPBViMyp3LuuKZVmyGug=;
        b=HDQUB4giWzt28ikabNyAFboB3XR0UIA8YyWXe02OK0vAPmiS17zAe19Y5XQFm2tg+b
         lEGo+gTqSboS+rzLNXmx7xy9y6/mXO7hMy9KEpWWsnjx4n2jh88P5046A49FGmu6XZRv
         v5wO4ZTiNcwkr0ZIODm6Ajns12INScapcVkvxUNxFzPOyALe0199KivpMHRGUfOeqqIu
         ZJpFE/0MfjawdHZumQYpsW680jM1T5UDlYjuJZo/BC7URYW3Oac2RW76fs8ydU4MDI0j
         kIjlpa8XYDnEbjJC5vLVQcPNt3MA184ETRRK4BFWfPpq8ciP6Z22KA5qkwczw4fzW6Ee
         c2og==
X-Gm-Message-State: AOJu0YzKLwKTo3IOSHw5QnGLZvmnweckkqwQoqQmGT3Swmks0/UGg91u
	PqGVro27Q2WI9DOCEsVVlKI=
X-Google-Smtp-Source: AGHT+IHn3IDcMlvIHXjaPCxrKdvppLJkdRNylWZWCyOb8Sn3QtKz7VXp6Sea/9jh7VJIbbrrxd8tHQ==
X-Received: by 2002:a5d:5182:0:b0:336:4477:38ee with SMTP id k2-20020a5d5182000000b00336447738eemr6240235wrv.69.1703026452007;
        Tue, 19 Dec 2023 14:54:12 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id u6-20020a5d6ac6000000b003365cdaa5a6sm10833379wrw.28.2023.12.19.14.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 14:54:11 -0800 (PST)
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
Subject: [net-next PATCH v2] net: phy: at803x: better align function varibles to open parenthesis
Date: Tue, 19 Dec 2023 21:21:24 +0100
Message-Id: <20231219202124.30013-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Better align function variables to open parenthesis as suggested by
checkpatch script for qca808x function to make code cleaner.

For cable_test_get_status function some additional rework was needed to
handle too long functions.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Add an additional fixup for qca808x_is_prefer_master

 drivers/net/phy/at803x.c | 67 ++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index d5dc927618ab..19cfbf36fe80 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1781,27 +1781,27 @@ static int qca808x_phy_fast_retrain_config(struct phy_device *phydev)
 		return ret;
 
 	phy_write_mmd(phydev, MDIO_MMD_AN, QCA808X_PHY_MMD7_TOP_OPTION1,
-			QCA808X_TOP_OPTION1_DATA);
+		      QCA808X_TOP_OPTION1_DATA);
 	phy_write_mmd(phydev, MDIO_MMD_PMAPMD, QCA808X_PHY_MMD1_MSE_THRESHOLD_20DB,
-			QCA808X_MSE_THRESHOLD_20DB_VALUE);
+		      QCA808X_MSE_THRESHOLD_20DB_VALUE);
 	phy_write_mmd(phydev, MDIO_MMD_PMAPMD, QCA808X_PHY_MMD1_MSE_THRESHOLD_17DB,
-			QCA808X_MSE_THRESHOLD_17DB_VALUE);
+		      QCA808X_MSE_THRESHOLD_17DB_VALUE);
 	phy_write_mmd(phydev, MDIO_MMD_PMAPMD, QCA808X_PHY_MMD1_MSE_THRESHOLD_27DB,
-			QCA808X_MSE_THRESHOLD_27DB_VALUE);
+		      QCA808X_MSE_THRESHOLD_27DB_VALUE);
 	phy_write_mmd(phydev, MDIO_MMD_PMAPMD, QCA808X_PHY_MMD1_MSE_THRESHOLD_28DB,
-			QCA808X_MSE_THRESHOLD_28DB_VALUE);
+		      QCA808X_MSE_THRESHOLD_28DB_VALUE);
 	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_1,
-			QCA808X_MMD3_DEBUG_1_VALUE);
+		      QCA808X_MMD3_DEBUG_1_VALUE);
 	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_4,
-			QCA808X_MMD3_DEBUG_4_VALUE);
+		      QCA808X_MMD3_DEBUG_4_VALUE);
 	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_5,
-			QCA808X_MMD3_DEBUG_5_VALUE);
+		      QCA808X_MMD3_DEBUG_5_VALUE);
 	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_3,
-			QCA808X_MMD3_DEBUG_3_VALUE);
+		      QCA808X_MMD3_DEBUG_3_VALUE);
 	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_6,
-			QCA808X_MMD3_DEBUG_6_VALUE);
+		      QCA808X_MMD3_DEBUG_6_VALUE);
 	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_2,
-			QCA808X_MMD3_DEBUG_2_VALUE);
+		      QCA808X_MMD3_DEBUG_2_VALUE);
 
 	return 0;
 }
@@ -1838,13 +1838,14 @@ static int qca808x_config_init(struct phy_device *phydev)
 
 	/* Active adc&vga on 802.3az for the link 1000M and 100M */
 	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_ADDR_CLD_CTRL7,
-			QCA808X_8023AZ_AFE_CTRL_MASK, QCA808X_8023AZ_AFE_EN);
+			     QCA808X_8023AZ_AFE_CTRL_MASK, QCA808X_8023AZ_AFE_EN);
 	if (ret)
 		return ret;
 
 	/* Adjust the threshold on 802.3az for the link 1000M */
 	ret = phy_write_mmd(phydev, MDIO_MMD_PCS,
-			QCA808X_PHY_MMD3_AZ_TRAINING_CTRL, QCA808X_MMD3_AZ_TRAINING_VAL);
+			    QCA808X_PHY_MMD3_AZ_TRAINING_CTRL,
+			    QCA808X_MMD3_AZ_TRAINING_VAL);
 	if (ret)
 		return ret;
 
@@ -1870,7 +1871,8 @@ static int qca808x_config_init(struct phy_device *phydev)
 
 	/* Configure adc threshold as 100mv for the link 10M */
 	return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_ADC_THRESHOLD,
-			QCA808X_ADC_THRESHOLD_MASK, QCA808X_ADC_THRESHOLD_100MV);
+				     QCA808X_ADC_THRESHOLD_MASK,
+				     QCA808X_ADC_THRESHOLD_100MV);
 }
 
 static int qca808x_read_status(struct phy_device *phydev)
@@ -1883,7 +1885,7 @@ static int qca808x_read_status(struct phy_device *phydev)
 		return ret;
 
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->lp_advertising,
-			ret & MDIO_AN_10GBT_STAT_LP2_5G);
+			 ret & MDIO_AN_10GBT_STAT_LP2_5G);
 
 	ret = genphy_read_status(phydev);
 	if (ret)
@@ -1913,7 +1915,7 @@ static int qca808x_read_status(struct phy_device *phydev)
 		 */
 		if (qca808x_has_fast_retrain_or_slave_seed(phydev)) {
 			if (phydev->master_slave_state == MASTER_SLAVE_STATE_ERR ||
-					qca808x_is_prefer_master(phydev)) {
+			    qca808x_is_prefer_master(phydev)) {
 				qca808x_phy_ms_seed_enable(phydev, false);
 			} else {
 				qca808x_phy_ms_seed_enable(phydev, true);
@@ -2070,18 +2072,22 @@ static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finish
 	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_D,
 				qca808x_cable_test_result_trans(pair_d));
 
-	if (qca808x_cdt_fault_length_valid(pair_a))
-		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A,
-				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A));
-	if (qca808x_cdt_fault_length_valid(pair_b))
-		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B,
-				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B));
-	if (qca808x_cdt_fault_length_valid(pair_c))
-		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C,
-				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C));
-	if (qca808x_cdt_fault_length_valid(pair_d))
-		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D,
-				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D));
+	if (qca808x_cdt_fault_length_valid(pair_a)) {
+		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A);
+		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A, val);
+	}
+	if (qca808x_cdt_fault_length_valid(pair_b)) {
+		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B);
+		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B, val);
+	}
+	if (qca808x_cdt_fault_length_valid(pair_c)) {
+		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C);
+		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C, val);
+	}
+	if (qca808x_cdt_fault_length_valid(pair_d)) {
+		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D);
+		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D, val);
+	}
 
 	*finished = true;
 
@@ -2148,8 +2154,9 @@ static void qca808x_link_change_notify(struct phy_device *phydev)
 	 * the interface device address is always phy address added by 1.
 	 */
 	mdiobus_c45_modify_changed(phydev->mdio.bus, phydev->mdio.addr + 1,
-			MDIO_MMD_PMAPMD, QCA8081_PHY_SERDES_MMD1_FIFO_CTRL,
-			QCA8081_PHY_FIFO_RSTN, phydev->link ? QCA8081_PHY_FIFO_RSTN : 0);
+				   MDIO_MMD_PMAPMD, QCA8081_PHY_SERDES_MMD1_FIFO_CTRL,
+				   QCA8081_PHY_FIFO_RSTN,
+				   phydev->link ? QCA8081_PHY_FIFO_RSTN : 0);
 }
 
 static struct phy_driver at803x_driver[] = {
-- 
2.40.1


