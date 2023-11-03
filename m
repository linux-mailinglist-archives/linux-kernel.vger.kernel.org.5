Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37617E0300
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376497AbjKCMft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376439AbjKCMfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:35:45 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68783CE;
        Fri,  3 Nov 2023 05:35:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c50ec238aeso28613361fa.0;
        Fri, 03 Nov 2023 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699014939; x=1699619739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WlXoM+vnYwBwzeCJHulUjKX4ggXCw4tLhrFljW5lQc=;
        b=Qg+ZBjfwGm+wPzW/n7JLnGYwP0UaeAjDAivB0ww6D09/S+oa7DpRWS+0F7uxFVsqAt
         OqUrr+TH1KeHaPHCeu/MkZvdzHNYKXn9zaUT2GNKDVKTY8OQ4OBFdUZoQMWPoxxITO1L
         4lwMA4lXsBpTsi5jyRuyeE5Q8FnrpYvo4iGF1pUQm348ecQDuYOWcskXSusR9tMbzo5w
         mPYQp2GZCnWC2dHu3/7U9dCJRbfxBdcmLQ1wGMd3b/xa5maCw2vDwDenQ8ovtzBgBgag
         SQ4aHUiTi0rH4ds7W46ht1qPRBUKZ8A/uT1FGzG7E1193XAyi8/vqXd7t91UEwXYI/zL
         VTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699014939; x=1699619739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WlXoM+vnYwBwzeCJHulUjKX4ggXCw4tLhrFljW5lQc=;
        b=XHhbwrDtTPSwi2ygMTvfn+UQLEFZaUgTrhZPAkSoGNJD1Zt5iPp0zq34Y3U6olfJob
         C5U1vINd1jgEjo+yTKSZVcqkobQG6Kcxe9ZhhhEgLvQGiyrmeVA32utE2G+Uq8BV9uNJ
         Yz3lSFu1GNPr99k4Wk8ERytanKod1zGxGrDcI0j1fD71C+9xkvVjImWoK9F2guwPAdgQ
         3pgytX1maNHfhJvrZRD942iRkRjKAU1UaTaPtRWvCtk93JUAsR/7hryauGgRouyLzBaw
         y0uIEOI3coVv4iLlvUymG4laLMS+04nZE0qSm0YMr6WOs2gcYZslBNtCAK8FS1yUTk2a
         Ju7g==
X-Gm-Message-State: AOJu0YxXkAPQhbV60pIt9itCGVbCNrOZ4JH4ufdOCCwHUYFDrYXViMW1
        Wv09+yWzg/FSM5/i8P1jnUU=
X-Google-Smtp-Source: AGHT+IHEvyVKhv1TZ3vs0oVgfhUtVf9TftSNKQCDLH7GQOcoREK0T4iNwF9Ru/j0aBOFC+zqydLTgw==
X-Received: by 2002:a05:651c:155:b0:2c5:1042:b6e8 with SMTP id c21-20020a05651c015500b002c51042b6e8mr18005917ljd.12.1699014939300;
        Fri, 03 Nov 2023 05:35:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id gy14-20020a05600c880e00b00403b63e87f2sm2277014wmb.32.2023.11.03.05.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 05:35:38 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v4 2/4] net: phy: aquantia: move MMD_VEND define to header
Date:   Fri,  3 Nov 2023 13:35:30 +0100
Message-Id: <20231103123532.687-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231103123532.687-1-ansuelsmth@gmail.com>
References: <20231103123532.687-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move MMD_VEND define to header to clean things up and in preparation for
firmware loading support that require some define placed in
aquantia_main.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes v4:
- Add Reviewed-by tag
Changes v3:
- Add this patch

 drivers/net/phy/aquantia/aquantia.h       | 69 +++++++++++++++++++++++
 drivers/net/phy/aquantia/aquantia_hwmon.c | 14 -----
 drivers/net/phy/aquantia/aquantia_main.c  | 55 ------------------
 3 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index c684b65c642c..f0c767c4fad1 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -9,6 +9,75 @@
 #include <linux/device.h>
 #include <linux/phy.h>
 
+/* Vendor specific 1, MDIO_MMD_VEND1 */
+#define VEND1_GLOBAL_FW_ID			0x0020
+#define VEND1_GLOBAL_FW_ID_MAJOR		GENMASK(15, 8)
+#define VEND1_GLOBAL_FW_ID_MINOR		GENMASK(7, 0)
+
+/* The following registers all have similar layouts; first the registers... */
+#define VEND1_GLOBAL_CFG_10M			0x0310
+#define VEND1_GLOBAL_CFG_100M			0x031b
+#define VEND1_GLOBAL_CFG_1G			0x031c
+#define VEND1_GLOBAL_CFG_2_5G			0x031d
+#define VEND1_GLOBAL_CFG_5G			0x031e
+#define VEND1_GLOBAL_CFG_10G			0x031f
+/* ...and now the fields */
+#define VEND1_GLOBAL_CFG_RATE_ADAPT		GENMASK(8, 7)
+#define VEND1_GLOBAL_CFG_RATE_ADAPT_NONE	0
+#define VEND1_GLOBAL_CFG_RATE_ADAPT_USX		1
+#define VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE	2
+
+/* Vendor specific 1, MDIO_MMD_VEND2 */
+#define VEND1_THERMAL_PROV_HIGH_TEMP_FAIL	0xc421
+#define VEND1_THERMAL_PROV_LOW_TEMP_FAIL	0xc422
+#define VEND1_THERMAL_PROV_HIGH_TEMP_WARN	0xc423
+#define VEND1_THERMAL_PROV_LOW_TEMP_WARN	0xc424
+#define VEND1_THERMAL_STAT1			0xc820
+#define VEND1_THERMAL_STAT2			0xc821
+#define VEND1_THERMAL_STAT2_VALID		BIT(0)
+#define VEND1_GENERAL_STAT1			0xc830
+#define VEND1_GENERAL_STAT1_HIGH_TEMP_FAIL	BIT(14)
+#define VEND1_GENERAL_STAT1_LOW_TEMP_FAIL	BIT(13)
+#define VEND1_GENERAL_STAT1_HIGH_TEMP_WARN	BIT(12)
+#define VEND1_GENERAL_STAT1_LOW_TEMP_WARN	BIT(11)
+
+#define VEND1_GLOBAL_GEN_STAT2			0xc831
+#define VEND1_GLOBAL_GEN_STAT2_OP_IN_PROG	BIT(15)
+
+#define VEND1_GLOBAL_RSVD_STAT1			0xc885
+#define VEND1_GLOBAL_RSVD_STAT1_FW_BUILD_ID	GENMASK(7, 4)
+#define VEND1_GLOBAL_RSVD_STAT1_PROV_ID		GENMASK(3, 0)
+
+#define VEND1_GLOBAL_RSVD_STAT9			0xc88d
+#define VEND1_GLOBAL_RSVD_STAT9_MODE		GENMASK(7, 0)
+#define VEND1_GLOBAL_RSVD_STAT9_1000BT2		0x23
+
+#define VEND1_GLOBAL_INT_STD_STATUS		0xfc00
+#define VEND1_GLOBAL_INT_VEND_STATUS		0xfc01
+
+#define VEND1_GLOBAL_INT_STD_MASK		0xff00
+#define VEND1_GLOBAL_INT_STD_MASK_PMA1		BIT(15)
+#define VEND1_GLOBAL_INT_STD_MASK_PMA2		BIT(14)
+#define VEND1_GLOBAL_INT_STD_MASK_PCS1		BIT(13)
+#define VEND1_GLOBAL_INT_STD_MASK_PCS2		BIT(12)
+#define VEND1_GLOBAL_INT_STD_MASK_PCS3		BIT(11)
+#define VEND1_GLOBAL_INT_STD_MASK_PHY_XS1	BIT(10)
+#define VEND1_GLOBAL_INT_STD_MASK_PHY_XS2	BIT(9)
+#define VEND1_GLOBAL_INT_STD_MASK_AN1		BIT(8)
+#define VEND1_GLOBAL_INT_STD_MASK_AN2		BIT(7)
+#define VEND1_GLOBAL_INT_STD_MASK_GBE		BIT(6)
+#define VEND1_GLOBAL_INT_STD_MASK_ALL		BIT(0)
+
+#define VEND1_GLOBAL_INT_VEND_MASK		0xff01
+#define VEND1_GLOBAL_INT_VEND_MASK_PMA		BIT(15)
+#define VEND1_GLOBAL_INT_VEND_MASK_PCS		BIT(14)
+#define VEND1_GLOBAL_INT_VEND_MASK_PHY_XS	BIT(13)
+#define VEND1_GLOBAL_INT_VEND_MASK_AN		BIT(12)
+#define VEND1_GLOBAL_INT_VEND_MASK_GBE		BIT(11)
+#define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL1	BIT(2)
+#define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL2	BIT(1)
+#define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL3	BIT(0)
+
 #if IS_REACHABLE(CONFIG_HWMON)
 int aqr_hwmon_probe(struct phy_device *phydev);
 #else
diff --git a/drivers/net/phy/aquantia/aquantia_hwmon.c b/drivers/net/phy/aquantia/aquantia_hwmon.c
index 0da451e46f69..7b3c49c3bf49 100644
--- a/drivers/net/phy/aquantia/aquantia_hwmon.c
+++ b/drivers/net/phy/aquantia/aquantia_hwmon.c
@@ -13,20 +13,6 @@
 
 #include "aquantia.h"
 
-/* Vendor specific 1, MDIO_MMD_VEND2 */
-#define VEND1_THERMAL_PROV_HIGH_TEMP_FAIL	0xc421
-#define VEND1_THERMAL_PROV_LOW_TEMP_FAIL	0xc422
-#define VEND1_THERMAL_PROV_HIGH_TEMP_WARN	0xc423
-#define VEND1_THERMAL_PROV_LOW_TEMP_WARN	0xc424
-#define VEND1_THERMAL_STAT1			0xc820
-#define VEND1_THERMAL_STAT2			0xc821
-#define VEND1_THERMAL_STAT2_VALID		BIT(0)
-#define VEND1_GENERAL_STAT1			0xc830
-#define VEND1_GENERAL_STAT1_HIGH_TEMP_FAIL	BIT(14)
-#define VEND1_GENERAL_STAT1_LOW_TEMP_FAIL	BIT(13)
-#define VEND1_GENERAL_STAT1_HIGH_TEMP_WARN	BIT(12)
-#define VEND1_GENERAL_STAT1_LOW_TEMP_WARN	BIT(11)
-
 #if IS_REACHABLE(CONFIG_HWMON)
 
 static umode_t aqr_hwmon_is_visible(const void *data,
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 334a6904ca5a..4498426e9a52 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -91,61 +91,6 @@
 #define MDIO_C22EXT_STAT_SGMII_TX_FRAME_ALIGN_ERR	0xd31a
 #define MDIO_C22EXT_STAT_SGMII_TX_RUNT_FRAMES		0xd31b
 
-/* Vendor specific 1, MDIO_MMD_VEND1 */
-#define VEND1_GLOBAL_FW_ID			0x0020
-#define VEND1_GLOBAL_FW_ID_MAJOR		GENMASK(15, 8)
-#define VEND1_GLOBAL_FW_ID_MINOR		GENMASK(7, 0)
-
-#define VEND1_GLOBAL_GEN_STAT2			0xc831
-#define VEND1_GLOBAL_GEN_STAT2_OP_IN_PROG	BIT(15)
-
-/* The following registers all have similar layouts; first the registers... */
-#define VEND1_GLOBAL_CFG_10M			0x0310
-#define VEND1_GLOBAL_CFG_100M			0x031b
-#define VEND1_GLOBAL_CFG_1G			0x031c
-#define VEND1_GLOBAL_CFG_2_5G			0x031d
-#define VEND1_GLOBAL_CFG_5G			0x031e
-#define VEND1_GLOBAL_CFG_10G			0x031f
-/* ...and now the fields */
-#define VEND1_GLOBAL_CFG_RATE_ADAPT		GENMASK(8, 7)
-#define VEND1_GLOBAL_CFG_RATE_ADAPT_NONE	0
-#define VEND1_GLOBAL_CFG_RATE_ADAPT_USX		1
-#define VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE	2
-
-#define VEND1_GLOBAL_RSVD_STAT1			0xc885
-#define VEND1_GLOBAL_RSVD_STAT1_FW_BUILD_ID	GENMASK(7, 4)
-#define VEND1_GLOBAL_RSVD_STAT1_PROV_ID		GENMASK(3, 0)
-
-#define VEND1_GLOBAL_RSVD_STAT9			0xc88d
-#define VEND1_GLOBAL_RSVD_STAT9_MODE		GENMASK(7, 0)
-#define VEND1_GLOBAL_RSVD_STAT9_1000BT2		0x23
-
-#define VEND1_GLOBAL_INT_STD_STATUS		0xfc00
-#define VEND1_GLOBAL_INT_VEND_STATUS		0xfc01
-
-#define VEND1_GLOBAL_INT_STD_MASK		0xff00
-#define VEND1_GLOBAL_INT_STD_MASK_PMA1		BIT(15)
-#define VEND1_GLOBAL_INT_STD_MASK_PMA2		BIT(14)
-#define VEND1_GLOBAL_INT_STD_MASK_PCS1		BIT(13)
-#define VEND1_GLOBAL_INT_STD_MASK_PCS2		BIT(12)
-#define VEND1_GLOBAL_INT_STD_MASK_PCS3		BIT(11)
-#define VEND1_GLOBAL_INT_STD_MASK_PHY_XS1	BIT(10)
-#define VEND1_GLOBAL_INT_STD_MASK_PHY_XS2	BIT(9)
-#define VEND1_GLOBAL_INT_STD_MASK_AN1		BIT(8)
-#define VEND1_GLOBAL_INT_STD_MASK_AN2		BIT(7)
-#define VEND1_GLOBAL_INT_STD_MASK_GBE		BIT(6)
-#define VEND1_GLOBAL_INT_STD_MASK_ALL		BIT(0)
-
-#define VEND1_GLOBAL_INT_VEND_MASK		0xff01
-#define VEND1_GLOBAL_INT_VEND_MASK_PMA		BIT(15)
-#define VEND1_GLOBAL_INT_VEND_MASK_PCS		BIT(14)
-#define VEND1_GLOBAL_INT_VEND_MASK_PHY_XS	BIT(13)
-#define VEND1_GLOBAL_INT_VEND_MASK_AN		BIT(12)
-#define VEND1_GLOBAL_INT_VEND_MASK_GBE		BIT(11)
-#define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL1	BIT(2)
-#define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL2	BIT(1)
-#define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL3	BIT(0)
-
 /* Sleep and timeout for checking if the Processor-Intensive
  * MDIO operation is finished
  */
-- 
2.40.1

