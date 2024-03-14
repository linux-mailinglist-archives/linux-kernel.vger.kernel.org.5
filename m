Return-Path: <linux-kernel+bounces-103449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFC787BF76
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F3C285CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B97971732;
	Thu, 14 Mar 2024 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="NHNbP/sL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="K1Ut0wJP"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5BB7174A;
	Thu, 14 Mar 2024 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428461; cv=none; b=UnPdIBJ7SKTH9ZSSvoVLh78N4QZg0WXI1LPTVC1tCVuC2a+Fm67iHe520OfLeZkn2THZ1kC8EZJzOQGfRlDZ9b1S04wx8+Kd5c5OtWYGePK+uwUDYlkqxPvNQlRC8by+GxayVzjvau2/VJ33LkItx5vqCARVCfB60WY8BQVobHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428461; c=relaxed/simple;
	bh=Z2q6L5bDOTV52pQYpq4xIuEGVItpC1A8IOEPTT7B0N4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CBnJFxVgU60mGql8Hex1yQOXZTB2qReCckGFKoQPn5LminuLjBrdvPnC8sBsVb/cxhd7tyhp+C5u6RGlNtMCoUVWuQQ12uQ/l1jQbW6Vajk5I6TKLU66rigY2k8S8Ym9S5XxTladsN572H05tMF7d67TX8NXX8+QfTWDnUHXEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=NHNbP/sL; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=K1Ut0wJP reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1710428459; x=1741964459;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0GJAuHPiTFLqrorYeW+QRM2ROXrH5HYvFbiD+vQXabw=;
  b=NHNbP/sLxwWIvqPW0+IWl/G1ctS3O9PoNDv+rtkv9Z3W4Hv32ZTmYmyD
   ZfXM8+dCwvx+ElhiJBw9IM+p1taKS7LLo5FOuqXzqRTe+a4HvE+AKnCHu
   evisz/GVNqHlM3ljSU/136/h15RsyZ/N2gf67KiepNGQceVDmVdODFqzs
   9OgCn7WBO2gXNZxsJhK9b9mOx1fSaexlqbegRBIou16rEmieytV20iS5z
   p8PqMObjxEpxIbOlLkPCwzkeNL8XrEEpP4HXYT9nV5j5nNzoEPxiMof7n
   rsZ0qw4SX54j2gtzAngxHG5CQnmSSmulRxXzZjZCwAxqLGVMTLZVpOK/W
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,125,1708383600"; 
   d="scan'208";a="35916708"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 14 Mar 2024 16:00:57 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C60716E9E5;
	Thu, 14 Mar 2024 16:00:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1710428452; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=0GJAuHPiTFLqrorYeW+QRM2ROXrH5HYvFbiD+vQXabw=;
	b=K1Ut0wJPt9lUDfhNsqYEzGXv7UGeV+VMXA1DCGkx06nGwygmtJebkrEDUDaesNgqjXyLah
	t/APkuvErrjc+C0IsywUZZHgmHRItQnEBhlHBv/p+4PvS1u6OxU2K+pz6YL/urrFAXXJai
	4ugXm5E3kUi6X8mF90RaC1RRpKOb6zwUS6VnLy4gPNFOrzRZGJGt7wwWxIJL1wiEmcRaxF
	1MHijXXmLn1OQZty97kgZpK6IhlQwKMblavlAK4k1ZAh0m8HwOxyJ+9+cpo9KFQb99sUyv
	r3UQD+vpSKkxFqP7boq++WQgGTxi4Cu/blINU8DUsg/7Ix+CIYkzcZJAQ4KGPg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ARM: dts: imx6ul: tqma6ul + mba6ulx: Fix pinctrl node names
Date: Thu, 14 Mar 2024 16:00:53 +0100
Message-Id: <20240314150054.2957840-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

imx6ul pinctrl nodes end with 'grp'. Fix node names.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi               | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
index 57e647fc3237..f04c6f71f538 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
@@ -202,7 +202,7 @@ MX6UL_PAD_UART2_RX_DATA__GPIO1_IO21	0x4001b8b0
 		>;
 	};
 
-	pinctrl_pmic: pmic {
+	pinctrl_pmic: grp {
 		fsl,pins = <
 			/* PMIC irq */
 			MX6UL_PAD_CSI_DATA03__GPIO4_IO24	0x1b099
diff --git a/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi b/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
index e78d0a7d8cd2..5258ef81e6c7 100644
--- a/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
@@ -505,7 +505,7 @@ MX6UL_PAD_CSI_HSYNC__UART6_DCE_CTS	0x1b0b1
 		>;
 	};
 
-	pinctrl_uart6dte: uart6dte {
+	pinctrl_uart6dte: uart6dtegrp {
 		fsl,pins = <
 			MX6UL_PAD_CSI_PIXCLK__UART6_DTE_TX	0x1b0b1
 			MX6UL_PAD_CSI_MCLK__UART6_DTE_RX	0x1b0b1
@@ -537,7 +537,7 @@ MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x0001b099
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x00017069
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x000170b9
@@ -552,7 +552,7 @@ MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x0001b099
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x00017069
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x000170f9
-- 
2.34.1


