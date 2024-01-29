Return-Path: <linux-kernel+bounces-42875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B27A2840808
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB6228D326
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3690E67740;
	Mon, 29 Jan 2024 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwmQjSMh"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A966B40;
	Mon, 29 Jan 2024 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537808; cv=none; b=hvlFxYom/bFXUQYUq3yCsIbTM1ON/j3silm1+5gjuG0anMyreZMWHkKVB+wcdIVolbashhSXTHZVvqM6vqa95OPnrgMSQTEgFkScxNv9y6xKubuDxeCW5o57zS58ZSaPKNE5jrEgKWxv4LqgLd7Ioh9fOlQW5XiMx1zqcjwYsP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537808; c=relaxed/simple;
	bh=4+ZOUQi4kO1YPpR6F+GdTy046L+HvYrNK/BfjZzdEPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImS/YyqyOd7ma5ewwJRo/GXlzN0ImFEk4lvpAwCYbvsSTHHFvCAnqSZiVNSMc8UjaeQ9qpmx1VtQ6TCN+XZ4iEgis0uLNk+uFGmN29U4fiT1RdHwLXxYfJ1BumtndyqMBBwhA7Z4xWaKcOryIaPeVLzu7YkgPz3xk/jpeIwqpLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwmQjSMh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a349ed467d9so296129666b.1;
        Mon, 29 Jan 2024 06:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706537804; x=1707142604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGxQ9t7URXleabajQhXYTWzeHabHJIEn3DuKmBAm5Vg=;
        b=lwmQjSMhvokQzrR4D4Tlo0ve5SUfGhsQIBqMp7PpvkH/WB+8+P2NHDGAeJtbni8f+3
         jKihh2GHxIRJj8V457Uul9E9hUEAZ4DgC4YsS2gOpb3gElUF2VdNDwibOVoGHwnAL9gz
         mIhvfjWqgxKZ//8GMDxTTmJQGn210ch3QUUEm9dZdNFT9uIJd4ZKNJtxUmYLMJfM3WB0
         85Z9qHi8aOmcY2n5G70+od2Erg2v0QHR68a5C+WXY53pgAxpekHl13SLm5yrljhBVFln
         XBOQyatmsObvzUWbbb0QXoY80QwTrwWoxf+IgHdq5YwVIwu8vXnjHUcbmrycFZ4El3XA
         9P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706537804; x=1707142604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGxQ9t7URXleabajQhXYTWzeHabHJIEn3DuKmBAm5Vg=;
        b=R8ks/BuNiA3JaVW2/g4ezxB+ea5nhGNneylhUTl4pKncG00Wn8oTx11uWtoufD1QLK
         2JCpEvE7kGvSBc+xsGi4ispH8ypJq7Etfu5TndD1sRP9zT+DA7oIb8GgegCAHXPmluZq
         AqBr0vvM/qLr4GN9ydJndUwazwbBzSviXrm498HSchiDrz9qrpB2Yprk2DFxaoyisQr0
         sl28qGe2B+uiutV2BFTq5WFFeRgZS05kNu0S1oM6X08K05Bf9S9BvpPGQwqosdSL0eCX
         p0lgWIs1fgtrbb2csmmx1i44SyTSPPNj7etjyRXR6nqBGUbmR5lr53JnaD6z7ISgqXqg
         yWGQ==
X-Gm-Message-State: AOJu0Yyi9sDq2ZKk90OIT/5TvR4LkyLYwtS/msUsmi9TNESVLwQrvSAU
	adskavSohcVJD/JGpuMesDA/keptAsqyIMqFc32lp/Om722UDVsq
X-Google-Smtp-Source: AGHT+IEDY9BrBkiNQVC9W/FwSr0+KN/Dh1SkeoeSpc+BuvGJJNqdm4VWoviBerfN//xJsCiNgIxH+A==
X-Received: by 2002:a17:906:11ca:b0:a35:de06:23f1 with SMTP id o10-20020a17090611ca00b00a35de0623f1mr1196633eja.0.1706537804159;
        Mon, 29 Jan 2024 06:16:44 -0800 (PST)
Received: from localhost.localdomain ([78.208.142.203])
        by smtp.googlemail.com with ESMTPSA id cu12-20020a170906ba8c00b00a27a32e6502sm3919470ejd.117.2024.01.29.06.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:16:43 -0800 (PST)
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
Subject: [net-next PATCH v4 2/5] net: phy: qcom: create and move functions to shared library
Date: Mon, 29 Jan 2024 15:15:20 +0100
Message-ID: <20240129141600.2592-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129141600.2592-1-ansuelsmth@gmail.com>
References: <20240129141600.2592-1-ansuelsmth@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


