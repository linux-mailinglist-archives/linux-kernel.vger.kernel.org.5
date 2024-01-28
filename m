Return-Path: <linux-kernel+bounces-41611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D2383F55A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0F81F21D96
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470B288DF;
	Sun, 28 Jan 2024 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IATGDZ+m"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95472208DF;
	Sun, 28 Jan 2024 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706443505; cv=none; b=XTPfSHIexNoupR6wQ0ITNuZoivVlOVe5KNPODTnPfig4fomO2Qe+A+YtpukjBhdAP3qzKQW2O0jP6Zc0eqQze4dVavQeDOL1pH/DQacIiuIDuMrz74U6a6umPwv/HICCJMCUSjMLcGQGooaLWZs4KI8mIqrGhBMswBsSMZOBsaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706443505; c=relaxed/simple;
	bh=1P84uWnRIKIgz6qkEtANAjEhNyEQWilNRbwaIxKXO/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T88+WHuS5ZtKQW76yx637nOa1jNa+v+BFnYFgUqP8HUnzfSJLCP0LHiiV8pb7EHQK3GSpVrtgcUMYIerAnjc3tVzp++IK/UZMlpFZl0hzwWmH5745wY1zPfrR09FwS81JKjRW/QU3F8Y9m5bN0i3jHTtbPS0RmPktwvdl3j+/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IATGDZ+m; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3392b12dd21so1845555f8f.0;
        Sun, 28 Jan 2024 04:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706443502; x=1707048302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGHsGF7Zb3mjjN+w/56njE9RmyZHFaePzBhoAjYDQMg=;
        b=IATGDZ+mFzDx8lCsgVmQJDAud+FyQGhBbpKWKbOAHsOB9RZndtCXD7xEycyq10EY/E
         ItYmcTPwxF8LJSLxTTuC0eG50eQnK9F9yuL5P453NwGddAFMjMHV7D2J16Nf1vGhSDVD
         DcSuMA623j8OsGd1qhIK4Ou6lzxA0z6xyEZyqGsmwAxPKcPXYse3H598imL4qkq91/rS
         BRExq4OgT7MkKcU2e8BGRs4WG8uvcocRJPuwZ1PWGAQSBgljSj0sM6LW7OF9alNVnop+
         OmH4XYzUuMPRJdShSVaLVlGWNebNFrOgyofRR8SznQgUHuNxVcrGtbf5BXEWK6jnskr3
         PJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706443502; x=1707048302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGHsGF7Zb3mjjN+w/56njE9RmyZHFaePzBhoAjYDQMg=;
        b=tuID4uucMck0oyFHnkFPaC9ag9+Ugq5DAYeolo5B4w+0C0ZAFi7Mx72oPjVAmw0sSq
         O39O//Dqkerj59PY6hkdZn00OTIfVsJ/AV0Qw63H7ZzEtMXOivgfRRZGyF9dG8Y7kd20
         fCm9bvJSeeqndt0Smd2pXfyXBLJhwaYQpwF9EfQ9pO3Hu/3zuh+2OgbaWiA9t02BqGOF
         Aa+4XSwuZ+eMjAev0ahltlPYMDu2KezX43FhEfoV8JZGN/oy6qZZE/ZGBC//2V9qLBOi
         Md03iFfDlfeSwmqT1IFgAdOKHkbzK7Lv64WcjKC9mrh1ORR1vkuBQMgo41NIFbmtGCam
         ya6g==
X-Gm-Message-State: AOJu0YyPSbUExZhGa7lG/HgdeNop7S9w54KO7hFSf4YYxDNm+cUWTc5f
	ZTP52jTal9fQ+MLFLzQxdhvsoir3k4xqnPOlL/Tg8s6QtOnLTjZB
X-Google-Smtp-Source: AGHT+IHRweuTBhcOnOWo1RA6WnWxr6p0njCcVy/jbP4RA3xEGFmXi3NO8ZeVhI0hDSnoFf58nTYb4w==
X-Received: by 2002:a5d:45cd:0:b0:337:c6be:7737 with SMTP id b13-20020a5d45cd000000b00337c6be7737mr2636586wrs.48.1706443501443;
        Sun, 28 Jan 2024 04:05:01 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id v1-20020a5d59c1000000b0033aeab6f75fsm1110034wry.79.2024.01.28.04.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 04:05:01 -0800 (PST)
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
Subject: [net-next PATCH v3 2/5] net: phy: qcom: create and move functions to shared library
Date: Sun, 28 Jan 2024 13:04:23 +0100
Message-ID: <20240128120451.31219-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128120451.31219-1-ansuelsmth@gmail.com>
References: <20240128120451.31219-1-ansuelsmth@gmail.com>
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


