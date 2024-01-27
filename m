Return-Path: <linux-kernel+bounces-41223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8044E83ED9C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFB31F22CE3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA982C194;
	Sat, 27 Jan 2024 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8MCwaTV"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30EF28DB5;
	Sat, 27 Jan 2024 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706366588; cv=none; b=mFFkGrd5gnYPwpSPrW2jUA/+MX9bdbJss2yhgiAB5gbmlKRyJCEgQMSGXubynzD8pDV4CPHUhv+IH9SBTmnjl1wje28bkYhoGWi1HG5dKELDRw0n6qQ3s8sHuRnslp6Z/Qjgd5Qa0PMjk3sQlhv21oK7674JDUF2FVNAKHzWziA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706366588; c=relaxed/simple;
	bh=1P84uWnRIKIgz6qkEtANAjEhNyEQWilNRbwaIxKXO/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADvfxlF4wftaKzeWbi8l3uLjyp6VSHnLia0k3+VO15AlOn+ih7Zeu1sUm/ZzLoz7bwO/+XvUmIQl90YcYbe3QQNkfauIjDPV2VzufSmye0MoPtSlVQj6d4tlUjKn1Hw48AtCZJ6aBO9owViPsANgLfO0TqjMXVPfvG/OtHTi2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8MCwaTV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40ee705e9bfso17467355e9.0;
        Sat, 27 Jan 2024 06:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706366585; x=1706971385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGHsGF7Zb3mjjN+w/56njE9RmyZHFaePzBhoAjYDQMg=;
        b=c8MCwaTVUcZrjFImeZaYFd0q5aVOs0GcOesf4GJatpCRB4PeF4TGL5sfbbruygAIU0
         NZ/+6QBhhqmIR2vHNNhUJSyZO2hxU4qfVK2Q64TQUeQfOJjUUkiu0DpI5CHofDXyMTS6
         tx8fmNPtqq/V5at7ADmGND70V97FMAQl6UmOr2nWGuiOR4XzwljvBg36cwBDYS1gThLc
         Iy56a/cCpKs+dORxkR7w47bLs3zzmJ+3DNasM0nop0yNtI2PqYA2QFSHpS5F8YzzAbpl
         oAsakZ7ffh3sFwBdVq8od9SeUPYZHpA0/C4Xk4kwbhwxUuUYdJ97jBvaEHKp8q5/DmTh
         SYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706366585; x=1706971385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGHsGF7Zb3mjjN+w/56njE9RmyZHFaePzBhoAjYDQMg=;
        b=gxk4l7tlK6fRypJTVK8EJu7mzR7cCskV2Js7l005WxAezxhB26UZq3DfrCPXk1+Hvx
         p/cTmIJZ7L6h/zSnwCABX6G8NgpB7/XteRKQagYLWGDb1lt6/5RpHKd8VYWqd+lxrc4D
         OyKkuW8X0gMSHj9KEiOPTDwnOhVnmwYMhkyrgjV/BN7BUYDbMG/zcLCTpXS/zMaNjNfn
         TvJoz7c0YiRoY5S0UZyDxMlN95Zs9JWKc8bcD3XLkOJiXoJRjMLuNiOMVxs6YKhsJRT9
         5F1SBj4lHGTf5gezRiG0U3L0nBBRQj8vg7Qx9x+zj7xr9RTGhDmegUbB590cs8Wu4m6C
         lFLg==
X-Gm-Message-State: AOJu0Yxd//2+iaWADA18L1AtJQaT9/WxxLeHctrvRzfR9qXfmi/bI3+g
	nZ6YzEd7Ixx3lmjMVNTCM8jdC4ztrlCX69cAjkSp9MBN87PyHeR2
X-Google-Smtp-Source: AGHT+IHhWmwQhsNvBhBNicFvtZqTCPnJwmGrM/ZkqhzGP0xT2f2wCSJgiXjvdt5VjLwaMyIYn31vZg==
X-Received: by 2002:a05:600c:4ed2:b0:40e:8fe8:a173 with SMTP id g18-20020a05600c4ed200b0040e8fe8a173mr1243221wmq.4.1706366584819;
        Sat, 27 Jan 2024 06:43:04 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id a11-20020a05600c348b00b0040eef2aed28sm1412590wmq.23.2024.01.27.06.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 06:43:04 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 2/5] net: phy: qcom: create and move functions to shared library
Date: Sat, 27 Jan 2024 15:42:42 +0100
Message-ID: <20240127144252.24767-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127144252.24767-1-ansuelsmth@gmail.com>
References: <20240127144252.24767-1-ansuelsmth@gmail.com>
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
 drivers/net/phy/qcom/at803x.c       | 69 +----------------------------
 drivers/net/phy/qcom/qcom-phy-lib.c | 53 ++++++++++++++++++++++
 drivers/net/phy/qcom/qcom.h         | 34 ++++++++++++++
 5 files changed, 94 insertions(+), 67 deletions(-)
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
index 9c07a6cc6e67..8194618c0865 100644
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
@@ -393,18 +379,6 @@ MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
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
 static struct at803x_hw_stat qca83xx_hw_stats[] = {
 	{ "phy_idle_errors", 0xa, GENMASK(7, 0), PHY},
 	{ "phy_receive_errors", 0x15, GENMASK(15, 0), PHY},
@@ -439,45 +413,6 @@ struct at803x_context {
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
index 000000000000..8eb476d7c282
--- /dev/null
+++ b/drivers/net/phy/qcom/qcom.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define AT803X_DEBUG_ADDR			0x1D
+#define AT803X_DEBUG_DATA			0x1E
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


