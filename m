Return-Path: <linux-kernel+bounces-124262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678F289148E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FCB28766C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2753840BE4;
	Fri, 29 Mar 2024 07:48:38 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207DC3D569;
	Fri, 29 Mar 2024 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698517; cv=none; b=TeMgcgnLnD6Jb3GBkHHcV1MxrrtvH814/UnfUcJNrLPmiPoRBA4x/cT82FG8ct5WUV0vhV057g+UqcgqaRPiRMsmz0SzOrNkXkap/hXAZW27VFGCBN7wZiKscAyZCkdqkK6sAUj1R29615L4H5lgPqVWfP4T+77jOfuMqZeS2a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698517; c=relaxed/simple;
	bh=ALaE+zcSQMtY5KqTM7PnPkfpveagz52jI+cnc103xNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=s6k2eoAOcZ5uh4LgMRLdyd58cOznloo3oYdUG+Sl1uAfMKamv9NGVQFA4WIANi9Z1PsxTu9usvCKKC8EN6ulqVHDZ7asHvaE2lnh+hNXVSnU08Jox/OCiIiq5cfCB/mu56asOfTSgbFCisjslDwd5BfqeEKtv8B02d973g8m65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 675AF2008BA;
	Fri, 29 Mar 2024 08:48:34 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1C3E52008D9;
	Fri, 29 Mar 2024 08:48:34 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 325D0183ACAC;
	Fri, 29 Mar 2024 15:48:32 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	frank.li@nxp.com
Cc: hongxing.zhu@nxp.com,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-imx@nxp.com
Subject: [RFC 2/3] dt-bindings: phy: phy-imx8-pcie: Add binding for i.MX8Q HSIO SerDes PHY
Date: Fri, 29 Mar 2024 15:31:32 +0800
Message-Id: <1711697493-16151-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711697493-16151-1-git-send-email-hongxing.zhu@nxp.com>
References: <1711697493-16151-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add binding for controller ID and HSIO configuration setting of the
i.MX8Q HSIO SerDes PHY.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 include/dt-bindings/phy/phy-imx8-pcie.h | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/dt-bindings/phy/phy-imx8-pcie.h b/include/dt-bindings/phy/phy-imx8-pcie.h
index 8bbe2d6538d8..5cd5580879fa 100644
--- a/include/dt-bindings/phy/phy-imx8-pcie.h
+++ b/include/dt-bindings/phy/phy-imx8-pcie.h
@@ -11,4 +11,30 @@
 #define IMX8_PCIE_REFCLK_PAD_INPUT	1
 #define IMX8_PCIE_REFCLK_PAD_OUTPUT	2
 
+/*
+ * i.MX8QM HSIO subsystem has three lane PHYs and three controllers:
+ * PCIEA(2 lanes capapble PCIe controller), PCIEB (only support one
+ * lane) and SATA.
+ * In the different use cases. PCIEA can be binded to PHY lane0, lane1
+ * or Lane0 and lane1. PCIEB can be binded to lane1 or lane2 PHY. SATA
+ * can only be binded to last lane2 PHY.
+ * Define i.MX8Q HSIO controller ID here to specify the controller
+ * binded to the PHY.
+ * Meanwhile, i.MX8QXP HSIO subsystem has one lane PHY and PCIEB(only
+ * support one lane) controller.
+ */
+#define IMX8Q_HSIO_PCIEA_ID	0
+#define IMX8Q_HSIO_PCIEB_ID	1
+#define IMX8Q_HSIO_SATA_ID	2
+
+/*
+ * On i.MX8QM, PCIEA is mandatory required if the HSIO is enabled.
+ * Define configurations beside PCIEA is enabled.
+ * On i.MX8QXP, HSIO module only has PCIEB and one lane PHY.
+ * The "IMX8Q_HSIO_CFG_PCIEB" can be used on i.MX8QXP platforms.
+ */
+#define IMX8Q_HSIO_CFG_SATA		1
+#define IMX8Q_HSIO_CFG_PCIEB		2
+#define IMX8Q_HSIO_CFG_PCIEBSATA	3
+
 #endif /* _DT_BINDINGS_IMX8_PCIE_H */
-- 
2.37.1


