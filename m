Return-Path: <linux-kernel+bounces-2871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5B381637F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B4D1F21A4F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EDF4B124;
	Sun, 17 Dec 2023 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNZPT8as"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B828495FE;
	Sun, 17 Dec 2023 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c3ceded81so23768645e9.1;
        Sun, 17 Dec 2023 15:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702857017; x=1703461817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xR7tl5f0eEtrlD5LFPMRAiYLIoBM+AWhJFKBaPFOMnU=;
        b=TNZPT8aslSJACKIe1loJvWZwyCcQacNrtqi8X9KeU2jp125XSu5b2m2981AvEyu7Qj
         M7N4Y0lNQmnKN7OSwtTMPmGulIml3LaSbukcP8G8qz2NqlT5ytg5Opx8EbB0+OSw0d0R
         Q6sn1fa6zAYLSAYCOexi+gNOmgtzB+DHkCECCVaEQbIjzDMvn4Mb3v7JsF9fYOIu1ZGI
         Y98eRLmCd1Sk/iXiMeEa2BYGSNotTxsq5BxejhEZNDXhxdey5HR5OiRA6ENF9/dFariQ
         Qquzq1NgKosmpg4HjgoNmiQOH5WRHN6Vfm6MpXuFDgiyIEbfliBR4CM6HKAF1EJLoc5f
         WL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702857017; x=1703461817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xR7tl5f0eEtrlD5LFPMRAiYLIoBM+AWhJFKBaPFOMnU=;
        b=JTtjwiAXMZReuNrSOKQZjkZJdiGuyVJJbfgWegfULEu/C4TlFVF2iUMVAZazGBSB67
         Ppddz3zf1Ce/cZ8KV/kZv/3TZ2CwPIq5+zaCxoFlLhGdbp6i4DLkTfDVDkgNciBnBjsk
         8Z55kvlnEZYSboqjTpBjKt0TeWKQ3Lqjo4y/RT1Jp02sOl1ees3V3+WN4wZ27L7jMS1q
         I+bB3uRbuwrq6taX5xOoV1okLjWMVr9A+G0EcPE9Z/TSpsgZFmYZ4TlBDw3SQG/4Cwh6
         P6pDDRI+c2egKn5PeplXyV5FJyydanvuesKuKknt5/EJtp1et2LVaP9j0i1kU/fVM9w9
         BqXQ==
X-Gm-Message-State: AOJu0YydK/MflF5pLzET14k/I4feY+W7E88JFL6w9VooAVnFODf29Ya4
	sT82WowQnnwo4shXuRGh83Q=
X-Google-Smtp-Source: AGHT+IFATOv3AXnFZoUUZdba3OzdKU7lXNkxbBSDAwPJkswphsS1JnwxqpW5bjlTk70UCYlZSNv3eg==
X-Received: by 2002:a7b:c8d0:0:b0:40c:6162:2d1e with SMTP id f16-20020a7bc8d0000000b0040c61622d1emr3131614wml.52.1702857017432;
        Sun, 17 Dec 2023 15:50:17 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id p32-20020a05600c1da000b0040b360cc65csm39862067wms.0.2023.12.17.15.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 15:50:17 -0800 (PST)
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
Subject: [net-next PATCH] net: phy: at803x: better align function varibles to open parenthesis
Date: Mon, 18 Dec 2023 00:50:11 +0100
Message-Id: <20231217235011.2070-1-ansuelsmth@gmail.com>
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
 drivers/net/phy/at803x.c | 65 ++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index d5dc927618ab..5e3fbaa7c26c 100644
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


