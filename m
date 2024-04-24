Return-Path: <linux-kernel+bounces-156395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4988C8B0250
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 750CBB2307D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6614C159201;
	Wed, 24 Apr 2024 06:39:53 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A11591E5;
	Wed, 24 Apr 2024 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940792; cv=none; b=YuAJ7YV/1DIjGEt9Apwz9wiXi0TiPkY8IiKW0B3OP+zb97g9ZaiGVIIG8w/gfjCGpKtKLFrba0l8vAfbcwD15U3i2bvc3l7RLNYoiLmQxw/fGntWEztu2N0VMW/fGibo+n9QqjTZUdwmo3McsYu/tIUJ1t2hvqTKgP/SjrS0DQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940792; c=relaxed/simple;
	bh=WDpYGlyH3D49ELuXMWqTBaxAX1mUNWhzBM30ioj42AE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YlhNCaYx3IB3JUFZqwFDHEoTxYSNOEnzquHyODBf7y8bQB8Jgm120lWklETIG8OfUh0JJ75SQIphPqm1oXIdLcgCLOflx3RaIDjVXRR78UTTpOBEu+zjq91czufrA6r5IpWGhBEwOxT/UPe6EFn0U4FaHbcHLBOQn0qaZqwW/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 12829202228;
	Wed, 24 Apr 2024 08:39:44 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C6BF201BBB;
	Wed, 24 Apr 2024 08:39:43 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BA491181D0FC;
	Wed, 24 Apr 2024 14:39:40 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: conor@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	frank.li@nxp.com,
	conor+dt@kernel.org
Cc: hongxing.zhu@nxp.com,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: [PATCH v3 1/3] dt-bindings: phy: phy-imx8-pcie: Add header file for i.MX8Q HSIO SerDes PHY
Date: Wed, 24 Apr 2024 14:21:21 +0800
Message-Id: <1713939683-15328-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713939683-15328-1-git-send-email-hongxing.zhu@nxp.com>
References: <1713939683-15328-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add lane index and HSIO configuration definitions of the i.MX8Q HSIO
SerDes PHY into header file.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 include/dt-bindings/phy/phy-imx8-pcie.h | 62 +++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/include/dt-bindings/phy/phy-imx8-pcie.h b/include/dt-bindings/phy/phy-imx8-pcie.h
index 8bbe2d6538d8..60447b95a952 100644
--- a/include/dt-bindings/phy/phy-imx8-pcie.h
+++ b/include/dt-bindings/phy/phy-imx8-pcie.h
@@ -11,4 +11,66 @@
 #define IMX8_PCIE_REFCLK_PAD_INPUT	1
 #define IMX8_PCIE_REFCLK_PAD_OUTPUT	2
 
+/*
+ * i.MX8QM HSIO subsystem has three lane PHYs and three controllers:
+ * PCIEA(2 lanes capable PCIe controller), PCIEB (only support one
+ * lane) and SATA.
+ *
+ * Meanwhile, i.MX8QXP HSIO subsystem has one lane PHY and PCIEB(only
+ * support one lane) controller.
+ *
+ * In the different use cases. PCIEA can be bound to PHY lane0, lane1
+ * or Lane0 and lane1. PCIEB can be bound to lane1 or lane2 PHY. SATA
+ * can only be bound to last lane2 PHY.
+ *
+ * +-------------------------------+------------------+
+ * | i.MX8QM                       | i.MX8QXP         |
+ * |-------------------------------|------------------|
+ * |       | PCIEA | PCIEB | SATA  |       | PCIEB    |
+ * |-------------------------------|-------|----------|
+ * | LAN 0 | X     |       |       | LAN 0 | *        |
+ * |-------------------------------|-------|----------|
+ * | LAN 1 | X     | *     |       |       |          |
+ * |-------------------------------|-------|----------|
+ * | LAN 2 |       | *     | *     |       |          |
+ * +-------------------------------+------------------+
+ * NOTE:
+ * *: Choose one only.
+ * X: Choose any of these.
+ *
+ * Define i.MX8Q HSIO PHY lane index here to specify the lane mask.
+ */
+#define IMX8Q_HSIO_LANE0	0x1
+#define IMX8Q_HSIO_LANE1	0x2
+#define IMX8Q_HSIO_LANE2	0x4
+
+/*
+ * Regarding the design of i.MX8QM HSIO subsystem, HSIO module can be
+ * confiured as following three use cases.
+ *
+ * Define different configurations refer to the use cases, since it is
+ * mandatory required in the initialization.
+ *
+ * On i.MX8QXP, HSIO module only has PCIEB and one lane PHY.
+ * Define "IMX8Q_HSIO_CFG_PCIEB" for i.MX8QXP platforms.
+ *
+ * +----------------------------------------------------+----------+
+ * |                               | i.MX8QM            | i.MX8QXP |
+ * |-------------------------------|--------------------|----------|
+ * |                               | LAN0 | LAN1 | LAN2 | LAN0     |
+ * |-------------------------------|------|------|------|----------|
+ * | IMX8Q_HSIO_CFG_PCIEAX2SATA    | PCIEA| PCIEA| SATA |          |
+ * |-------------------------------|------|------|------|----------|
+ * | IMX8Q_HSIO_CFG_PCIEAX2PCIEB   | PCIEA| PCIEA| PCIEB|          |
+ * |-------------------------------|------|------|------|----------|
+ * | IMX8Q_HSIO_CFG_PCIEAPCIEBSATA | PCIEA| PCIEB| SATA |          |
+ * |-------------------------------|------|------|------|----------|
+ * | IMX8Q_HSIO_CFG_PCIEB          | -    | -    | -    | PCIEB    |
+ * +----------------------------------------------------+----------+
+ */
+#define IMX8Q_HSIO_CFG_PCIEAX2SATA	0x1
+#define IMX8Q_HSIO_CFG_PCIEAX2PCIEB	0x2
+#define IMX8Q_HSIO_CFG_PCIEAPCIEBSATA	(IMX8Q_HSIO_CFG_PCIEAX2SATA | IMX8Q_HSIO_CFG_PCIEAX2PCIEB)
+#define IMX8Q_HSIO_CFG_PCIEB		IMX8Q_HSIO_CFG_PCIEAX2PCIEB
+
 #endif /* _DT_BINDINGS_IMX8_PCIE_H */
-- 
2.37.1


