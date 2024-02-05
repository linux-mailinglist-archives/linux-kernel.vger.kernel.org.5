Return-Path: <linux-kernel+bounces-52000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C65BB84928E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC76283437
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CA6111A0;
	Mon,  5 Feb 2024 02:57:02 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF661118A;
	Mon,  5 Feb 2024 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707101822; cv=none; b=XUZgrEdB/iCNvfYI1n7PcgTxytDbITci+oHUhitj8+wjClhNUbGjf/zf8IZZRGhnUy7ZO84d2vjONq+FAscj3GCz9R3QhcUDSscNRRYbZ1VU6hRDtkdNs6Qzfj9dGxqkrJlJbgDCtLMEZJuOBNB3k5G72ZADahpCjbBT2NzMKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707101822; c=relaxed/simple;
	bh=homk0SBMfTseGCJzG7S17xRuUCucS/WJwV7nHlibeD8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MrM3M0azwzmjUUtBaPjFlmPjW0+63xms+MXc7BGj8DX6jy3ddoLWrAyho121tY/0jZ9PgO2mdeavw7c3WdVct1bJ+N81muE5b3Qeg3GdK2Mz7Kb2qmWoRDapvJBGqehEt56KecQx+cH1P0gTb1HQmwPebkm6/27KdrxJsLUeJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 04D81201B3A;
	Mon,  5 Feb 2024 03:48:07 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C24F4201E33;
	Mon,  5 Feb 2024 03:48:06 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1908E18002A2;
	Mon,  5 Feb 2024 10:48:05 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: shengjiu.wang@gmail.com
Subject: [PATCH v2 1/2] arm64: dts: imx8mm-evk: Add PDM micphone sound card support
Date: Mon,  5 Feb 2024 10:04:23 +0800
Message-Id: <1707098664-23265-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add PDM micphone sound card support, configure the pinmux.

This sound card supports recording sound from PDM micphone
and convert the PDM format data to PCM data.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2:
- add newline between properties and child node

 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index b53104ed8919..9b39458f3fa5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -151,6 +151,20 @@ simple-audio-card,codec {
 			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
 		};
 	};
+
+	sound-micfil {
+		compatible = "fsl,imx-audio-card";
+		model = "micfil-audio";
+
+		pri-dai-link {
+			link-name = "micfil hifi";
+			format = "i2s";
+
+			cpu {
+				sound-dai = <&micfil>;
+			};
+		};
+	};
 };
 
 &A53_0 {
@@ -434,6 +448,16 @@ &lcdif {
 	status = "okay";
 };
 
+&micfil {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&clk IMX8MM_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <196608000>;
+	status = "okay";
+};
+
 &mipi_csi {
 	status = "okay";
 
@@ -636,6 +660,18 @@ MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5       0x41
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_MCLK_SAI5_MCLK        0xd6
+			MX8MM_IOMUXC_SAI5_RXC_PDM_CLK           0xd6
+			MX8MM_IOMUXC_SAI5_RXFS_SAI5_RX_SYNC     0xd6
+			MX8MM_IOMUXC_SAI5_RXD0_PDM_DATA0        0xd6
+			MX8MM_IOMUXC_SAI5_RXD1_PDM_DATA1        0xd6
+			MX8MM_IOMUXC_SAI5_RXD2_PDM_DATA2        0xd6
+			MX8MM_IOMUXC_SAI5_RXD3_PDM_DATA3        0xd6
+		>;
+	};
+
 	pinctrl_pmic: pmicirqgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x141
-- 
2.34.1


