Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354477DF587
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343828AbjKBPBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjKBPBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:01:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96E6185;
        Thu,  2 Nov 2023 08:01:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso7954625e9.3;
        Thu, 02 Nov 2023 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698937260; x=1699542060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZ6oY6lovsmfUSEeU78MEbVZf9JRhGDWBITtPDQw/FA=;
        b=MFZe/j+G96y7tGuaUSrJPLsBHrHbtpaBK9ms5SuI1fn6gorBDj6LZpMLIINv/eK/5u
         lhgmZvSi4k6VO4VK/Jj1KQkN+C5vaX+ybPUSb4o1Y7bCeko2pe10xNmHjlwplqYiQ6P5
         jp6VGN5XZnWNqYRUjApzctdknFFCVHfpOw0I1fR2xlnQwDSoNuWBJWJY0a4HRRnA78um
         NHAr4KgIvJv5DKRuiISgkBuETNoNh5SpV32dKA3ohbjYlcneTxxXOJd7emPX4miAhPWX
         E2zvXhpQ2NYOjSMQeUYvIbN5PYucWtK6iHL+LI69XbBfu5jW+dG0FH17hk6qTfx5ifGx
         CRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698937260; x=1699542060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ6oY6lovsmfUSEeU78MEbVZf9JRhGDWBITtPDQw/FA=;
        b=OwGJtyh9MzIRJSSDPUScK8PUeZD7rvon/T8zqr8iC7zTVW12R3aHxEB5G5QSyiygmI
         EmsRxsHohdE5Bv/CWJo5hSkJ+nQ5uxEaNajfzzYsoPZ9ZFqp/uWX89nIgcCRKYGfAe8s
         os4sCXaBLdwHhZOU4LT69qk09VmCPu7e9y0c+irvv78FnzkapOCTF4Bv6EbVwdHjpJ7n
         FWtslNa9VPAE8utIk0MeJZPm4oVtuM9GnLil2R4tl6CS7eV9JPrZb9eD35peQRY+H5pU
         6xYTRZ/ZOrgfkvD/nHf0SEmmkYH0NCoQPG3cwzqMZ5BBv5f/AfGLhYmD5XT+u31dCuE4
         do4w==
X-Gm-Message-State: AOJu0Yxv2GAjk8BnOgDXQDon0yLu7QzWy68XQf8vhDUigVII9ill9FYX
        JrKQTlx/+ujRbLr1dcSwfpag1U7En68=
X-Google-Smtp-Source: AGHT+IFfwrnBE6QU+fsMV5M2111diPyABOZA0F+Z0WvpKEoOWLJTYbxIQ3sbz4Pk5gn/Mw7vJ9d8CA==
X-Received: by 2002:a7b:cbcb:0:b0:3fe:2b8c:9f0b with SMTP id n11-20020a7bcbcb000000b003fe2b8c9f0bmr14620505wmi.23.1698937259909;
        Thu, 02 Nov 2023 08:00:59 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j15-20020a05600c130f00b003fbe4cecc3bsm3131007wmf.16.2023.11.02.08.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 08:00:53 -0700 (PDT)
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
Subject: [net-next RFC PATCH v3 2/4] net: phy: aquantia: move MMD_VEND define to header
Date:   Thu,  2 Nov 2023 16:00:30 +0100
Message-Id: <20231102150032.10740-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231102150032.10740-1-ansuelsmth@gmail.com>
References: <20231102150032.10740-1-ansuelsmth@gmail.com>
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
---
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

