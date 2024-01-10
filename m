Return-Path: <linux-kernel+bounces-22149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D599829A01
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEE6289510
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A3548CFA;
	Wed, 10 Jan 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyxYWGWt"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F87148CE1;
	Wed, 10 Jan 2024 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e5508ecb9so11461415e9.3;
        Wed, 10 Jan 2024 03:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704887882; x=1705492682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ko49eBT0bsmiNT0TgfCjFuObXjhyGn77qOLTB3IbfiE=;
        b=OyxYWGWtvrdA4Y7kfT/5R+0GEXTIQFceaHkuuSTU/OTsfKmxUvMIoG0ohMypFWyTAn
         ZqonWPAGt/lsXA17GuOaD8Yl6ZQvzl2Vuo6KJ5JB4ay6yFDMIh59f+rgfZoB8gq08Yg/
         +BZjcMlUEBh7AU3pXmrkE/dxNTqvfwyZ8GnkWnf2fgWMyeZVKopAJW0I8g4y1f2kshPK
         QBpG14K4SAa+WMXmTrBVRtQuf5Ga7hAPHccoc/p3r6ZK/QuOhD9hM5fgz7Ej26Tpt5B+
         wWWYKfYNfllRSbUQLI6Xx4QgM980vtFjotOLi099iejUdKzB2v8l66fERJwhc6/EhKuY
         z7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704887882; x=1705492682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ko49eBT0bsmiNT0TgfCjFuObXjhyGn77qOLTB3IbfiE=;
        b=PCiNp67O+8RBMhSOU6+BOPtREJBElvnfsuxHCtaGTrORUxucA5FV8l+XFT/N6BqOjT
         ipAWVl6V4vLhxfC1SI3re2RQ32q/aL0F95w9Ljn4avESm2lppVo9dYl8Kwczwyr28YBm
         gibqCxiHKzH10UAEorHOn/BxWWa8zKWUzJyJl+saHHm+KONqSGQghoJbREovl5xone6b
         Hc8NyWtf0FHSZLuTfNZarC2I52/hN3pzL02uCsChA5R4drqxdsGChbnsBNzPgUGcey3x
         U8XTWMaUT701M9CVNAbRYKWMm4UYX6IeE4E9RU7zFwrUMICLEybypekdsmdS7wtxxjdX
         ruLA==
X-Gm-Message-State: AOJu0Yw9VNwbLAXVFEBOEq812zvDA39/047NEZniSdibxLSuW+r7JGuJ
	EoAdeBvrd1DFInMXFxTynTY=
X-Google-Smtp-Source: AGHT+IFTBf3L+5mbjfTpW/9Gbb3IIOoMzQAF4ws/8bw6KvOSKwNWhnWy/x7SqqHR9Zw+lpXTSL4zSw==
X-Received: by 2002:a05:600c:154e:b0:40e:4672:5227 with SMTP id f14-20020a05600c154e00b0040e46725227mr472520wmg.96.1704887882271;
        Wed, 10 Jan 2024 03:58:02 -0800 (PST)
Received: from localhost.localdomain ([78.209.40.150])
        by smtp.googlemail.com with ESMTPSA id f17-20020a05600c155100b0040d62f89381sm1962136wmg.35.2024.01.10.03.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 03:58:02 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next RFC PATCH 2/5] net: phy: qcom: create and move functions to shared library
Date: Wed, 10 Jan 2024 12:57:32 +0100
Message-ID: <20240110115741.17300-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110115741.17300-1-ansuelsmth@gmail.com>
References: <20240110115741.17300-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create and move functions to shared library in preparation for qca83xx
PHY Family to be detached from at803x driver.

Only the shared defines are moved to the shared qcom.h header.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qcom/Kconfig        |  4 ++
 drivers/net/phy/qcom/Makefile       |  1 +
 drivers/net/phy/qcom/at803x.c       | 75 +----------------------------
 drivers/net/phy/qcom/qcom-phy-lib.c | 53 ++++++++++++++++++++
 drivers/net/phy/qcom/qcom.h         | 34 +++++++++++++
 5 files changed, 94 insertions(+), 73 deletions(-)
 create mode 100644 drivers/net/phy/qcom/qcom-phy-lib.c
 create mode 100644 drivers/net/phy/qcom/qcom.h

diff --git a/drivers/net/phy/qcom/Kconfig b/drivers/net/phy/qcom/Kconfig
index 2c274fbbe410..fe47cc7c94d2 100644
--- a/drivers/net/phy/qcom/Kconfig
+++ b/drivers/net/phy/qcom/Kconfig
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config QCOM_NET_PHYLIB
+	tristate
+
 config AT803X_PHY
 	tristate "Qualcomm Atheros AR803X PHYs and QCA833x PHYs"
+	select QCOM_NET_PHYLIB
 	depends on REGULATOR
 	help
 	  Currently supports the AR8030, AR8031, AR8033, AR8035 and internal
diff --git a/drivers/net/phy/qcom/Makefile b/drivers/net/phy/qcom/Makefile
index 6a68da8aaa7b..bfba2ed7db27 100644
--- a/drivers/net/phy/qcom/Makefile
+++ b/drivers/net/phy/qcom/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_QCOM_NET_PHYLIB)	+= qcom-phy-lib.o
 obj-$(CONFIG_AT803X_PHY)	+= at803x.o
diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index 992497310fba..2e0df55da5e1 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -22,6 +22,8 @@
 #include <linux/sfp.h>
 #include <dt-bindings/net/qca-ar803x.h>
 
+#include "qcom.h"
+
 #define AT803X_SPECIFIC_FUNCTION_CONTROL	0x10
 #define AT803X_SFC_ASSERT_CRS			BIT(11)
 #define AT803X_SFC_FORCE_LINK			BIT(10)
@@ -84,9 +86,6 @@
 #define AT803X_REG_CHIP_CONFIG			0x1f
 #define AT803X_BT_BX_REG_SEL			0x8000
 
-#define AT803X_DEBUG_ADDR			0x1D
-#define AT803X_DEBUG_DATA			0x1E
-
 #define AT803X_MODE_CFG_MASK			0x0F
 #define AT803X_MODE_CFG_BASET_RGMII		0x00
 #define AT803X_MODE_CFG_BASET_SGMII		0x01
@@ -103,19 +102,6 @@
 #define AT803X_PSSR				0x11	/*PHY-Specific Status Register*/
 #define AT803X_PSSR_MR_AN_COMPLETE		0x0200
 
-#define AT803X_DEBUG_ANALOG_TEST_CTRL		0x00
-#define QCA8327_DEBUG_MANU_CTRL_EN		BIT(2)
-#define QCA8337_DEBUG_MANU_CTRL_EN		GENMASK(3, 2)
-#define AT803X_DEBUG_RX_CLK_DLY_EN		BIT(15)
-
-#define AT803X_DEBUG_SYSTEM_CTRL_MODE		0x05
-#define AT803X_DEBUG_TX_CLK_DLY_EN		BIT(8)
-
-#define AT803X_DEBUG_REG_HIB_CTRL		0x0b
-#define   AT803X_DEBUG_HIB_CTRL_SEL_RST_80U	BIT(10)
-#define   AT803X_DEBUG_HIB_CTRL_EN_ANY_CHANGE	BIT(13)
-#define   AT803X_DEBUG_HIB_CTRL_PS_HIB_EN	BIT(15)
-
 #define AT803X_DEBUG_REG_3C			0x3C
 
 #define AT803X_DEBUG_REG_GREEN			0x3D
@@ -393,24 +379,6 @@ MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
 
-enum stat_access_type {
-	PHY,
-	MMD
-};
-
-struct at803x_hw_stat {
-	const char *string;
-	u8 reg;
-	u32 mask;
-	enum stat_access_type access_type;
-};
-
-static struct at803x_hw_stat qca83xx_hw_stats[] = {
-	{ "phy_idle_errors", 0xa, GENMASK(7, 0), PHY},
-	{ "phy_receive_errors", 0x15, GENMASK(15, 0), PHY},
-	{ "eee_wake_errors", 0x16, GENMASK(15, 0), MMD},
-};
-
 struct at803x_ss_mask {
 	u16 speed_mask;
 	u8 speed_shift;
@@ -439,45 +407,6 @@ struct at803x_context {
 	u16 led_control;
 };
 
-static int at803x_debug_reg_write(struct phy_device *phydev, u16 reg, u16 data)
-{
-	int ret;
-
-	ret = phy_write(phydev, AT803X_DEBUG_ADDR, reg);
-	if (ret < 0)
-		return ret;
-
-	return phy_write(phydev, AT803X_DEBUG_DATA, data);
-}
-
-static int at803x_debug_reg_read(struct phy_device *phydev, u16 reg)
-{
-	int ret;
-
-	ret = phy_write(phydev, AT803X_DEBUG_ADDR, reg);
-	if (ret < 0)
-		return ret;
-
-	return phy_read(phydev, AT803X_DEBUG_DATA);
-}
-
-static int at803x_debug_reg_mask(struct phy_device *phydev, u16 reg,
-				 u16 clear, u16 set)
-{
-	u16 val;
-	int ret;
-
-	ret = at803x_debug_reg_read(phydev, reg);
-	if (ret < 0)
-		return ret;
-
-	val = ret & 0xffff;
-	val &= ~clear;
-	val |= set;
-
-	return phy_write(phydev, AT803X_DEBUG_DATA, val);
-}
-
 static int at803x_write_page(struct phy_device *phydev, int page)
 {
 	int mask;
diff --git a/drivers/net/phy/qcom/qcom-phy-lib.c b/drivers/net/phy/qcom/qcom-phy-lib.c
new file mode 100644
index 000000000000..7192184429b7
--- /dev/null
+++ b/drivers/net/phy/qcom/qcom-phy-lib.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/phy.h>
+#include <linux/module.h>
+
+#include "qcom.h"
+
+MODULE_DESCRIPTION("Qualcomm PHY driver Common Functions");
+MODULE_AUTHOR("Matus Ujhelyi");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_LICENSE("GPL");
+
+int at803x_debug_reg_read(struct phy_device *phydev, u16 reg)
+{
+	int ret;
+
+	ret = phy_write(phydev, AT803X_DEBUG_ADDR, reg);
+	if (ret < 0)
+		return ret;
+
+	return phy_read(phydev, AT803X_DEBUG_DATA);
+}
+EXPORT_SYMBOL_GPL(at803x_debug_reg_read);
+
+int at803x_debug_reg_mask(struct phy_device *phydev, u16 reg,
+			  u16 clear, u16 set)
+{
+	u16 val;
+	int ret;
+
+	ret = at803x_debug_reg_read(phydev, reg);
+	if (ret < 0)
+		return ret;
+
+	val = ret & 0xffff;
+	val &= ~clear;
+	val |= set;
+
+	return phy_write(phydev, AT803X_DEBUG_DATA, val);
+}
+EXPORT_SYMBOL_GPL(at803x_debug_reg_mask);
+
+int at803x_debug_reg_write(struct phy_device *phydev, u16 reg, u16 data)
+{
+	int ret;
+
+	ret = phy_write(phydev, AT803X_DEBUG_ADDR, reg);
+	if (ret < 0)
+		return ret;
+
+	return phy_write(phydev, AT803X_DEBUG_DATA, data);
+}
+EXPORT_SYMBOL_GPL(at803x_debug_reg_write);
diff --git a/drivers/net/phy/qcom/qcom.h b/drivers/net/phy/qcom/qcom.h
new file mode 100644
index 000000000000..e7a874df16fd
--- /dev/null
+++ b/drivers/net/phy/qcom/qcom.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define AT803X_DEBUG_ANALOG_TEST_CTRL		0x00
+#define QCA8327_DEBUG_MANU_CTRL_EN		BIT(2)
+#define QCA8337_DEBUG_MANU_CTRL_EN		GENMASK(3, 2)
+#define AT803X_DEBUG_RX_CLK_DLY_EN		BIT(15)
+
+#define AT803X_DEBUG_SYSTEM_CTRL_MODE		0x05
+#define AT803X_DEBUG_TX_CLK_DLY_EN		BIT(8)
+
+#define AT803X_DEBUG_REG_HIB_CTRL		0x0b
+#define   AT803X_DEBUG_HIB_CTRL_SEL_RST_80U	BIT(10)
+#define   AT803X_DEBUG_HIB_CTRL_EN_ANY_CHANGE	BIT(13)
+#define   AT803X_DEBUG_HIB_CTRL_PS_HIB_EN	BIT(15)
+
+#define AT803X_DEBUG_ADDR			0x1D
+#define AT803X_DEBUG_DATA			0x1E
+
+enum stat_access_type {
+	PHY,
+	MMD
+};
+
+struct at803x_hw_stat {
+	const char *string;
+	u8 reg;
+	u32 mask;
+	enum stat_access_type access_type;
+};
+
+int at803x_debug_reg_read(struct phy_device *phydev, u16 reg);
+int at803x_debug_reg_mask(struct phy_device *phydev, u16 reg,
+			  u16 clear, u16 set);
+int at803x_debug_reg_write(struct phy_device *phydev, u16 reg, u16 data);
-- 
2.43.0


