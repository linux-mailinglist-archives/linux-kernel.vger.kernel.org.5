Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64CC807CD6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441935AbjLGAAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441887AbjLGAAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:14 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B95BD68;
        Wed,  6 Dec 2023 16:00:19 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c2718a768so3802305e9.0;
        Wed, 06 Dec 2023 16:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701907218; x=1702512018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ry9/OcH5p4w9QNEkHN6mJ+DUe89PzwuGd5SiP435vxk=;
        b=h3ETGmDyxfUwxk5YuR3+UGL2MPxUwBtznM/dF5GOD8RYC/+JopiWr/ICZsvoRrhpQG
         oevjoeoP24IV9m88vMsch0yGicwbLPztDolXKfWkRg+nyA9oDtYWEiYabXv8/mOQ6+qv
         ukfm15IwFPop/9fwMU7TM+Sz0YDRHXBMDggfLBWjdYKdMlyOadmal4HfZ/64ofi3LS7T
         Hbsp2HMoXRthORfDIIGSfbW9chmf2b0OcbBWTsA326vxzwrc+N2+LdBR4vUw/tHTFFR7
         qhoLC6qjZmOIIGOHjet+JjZmWSGSULLzqVlBGDc6M2WijFG8t6osKhTBFAHOWK9HNMCo
         pw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907218; x=1702512018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ry9/OcH5p4w9QNEkHN6mJ+DUe89PzwuGd5SiP435vxk=;
        b=S+rBLWpR5bDI+BunnDAYE17fNNJJ9nTkozsNWo3w7QwN3wBoTDZh5kiG1vDXWsgZjz
         q0xs1nrggqsikiuNVphepSsQQ8w7+RAqADOCKpP//PRVHtnpIDBzyj+JZ3nIv0kBG06J
         p5TmSscJx9ZDYzIJIfFQau1pmCAAtPptUO2WFG2JdqweN8SFsT4UyIeJIQXIuBrVPA2K
         bwpDaugJO75xS431rO2MY6sssFfO0YS/1jCyvC0zdLRF6Z/qThkI+cmMdXamNo+u5xaI
         FK7qgfhEW+rpBvePxT7LzB4vyIoUAalnSLV2AYlHRrhzjaDzJDr1JmfUNHBJxP67qcfP
         uQ5Q==
X-Gm-Message-State: AOJu0YyoI2XvRpSZtnaxIJLBWWTbl8AhKh3xufJT6kokfUViMUcZvcaj
        Sl9XaKo21dt3R+eNZ0HWsbc=
X-Google-Smtp-Source: AGHT+IH2vA+otiLYH+acwdCTTbDW2Pp/hIrnaCyIBDORx2wp8u/8gwQg3/eKHJe74FAVt01K3EyAQw==
X-Received: by 2002:a7b:cbc6:0:b0:40b:5e22:98e with SMTP id n6-20020a7bcbc6000000b0040b5e22098emr1216967wmi.125.1701907217409;
        Wed, 06 Dec 2023 16:00:17 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id je16-20020a05600c1f9000b00405442edc69sm50280wmb.14.2023.12.06.16.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:00:17 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v3 02/13] net: phy: at803x: move disable WOL to specific at8031 probe
Date:   Thu,  7 Dec 2023 00:57:17 +0100
Message-Id: <20231206235728.6985-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231206235728.6985-1-ansuelsmth@gmail.com>
References: <20231206235728.6985-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the WOL disable call to specific at8031 probe to make at803x_probe
more generic and drop extra check for PHY ID.

Keep the same previous behaviour by first calling at803x_probe and then
disabling WOL.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index ef203b0807e5..85302d96d133 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -886,15 +886,6 @@ static int at803x_probe(struct phy_device *phydev)
 			priv->is_fiber = true;
 			break;
 		}
-
-		/* Disable WoL in 1588 register which is enabled
-		 * by default
-		 */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
-				     AT803X_PHY_MMD3_WOL_CTRL,
-				     AT803X_WOL_EN, 0);
-		if (ret)
-			return ret;
 	}
 
 	return 0;
@@ -1591,6 +1582,24 @@ static int at803x_cable_test_start(struct phy_device *phydev)
 	return 0;
 }
 
+static int at8031_probe(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = at803x_probe(phydev);
+	if (ret)
+		return ret;
+
+	/* Disable WoL in 1588 register which is enabled
+	 * by default
+	 */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+			     AT803X_PHY_MMD3_WOL_CTRL,
+			     AT803X_WOL_EN, 0);
+
+	return ret;
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -2092,7 +2101,7 @@ static struct phy_driver at803x_driver[] = {
 	PHY_ID_MATCH_EXACT(ATH8031_PHY_ID),
 	.name			= "Qualcomm Atheros AR8031/AR8033",
 	.flags			= PHY_POLL_CABLE_TEST,
-	.probe			= at803x_probe,
+	.probe			= at8031_probe,
 	.config_init		= at803x_config_init,
 	.config_aneg		= at803x_config_aneg,
 	.soft_reset		= genphy_soft_reset,
-- 
2.40.1

