Return-Path: <linux-kernel+bounces-51997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61538849289
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB0E1F2163B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE1EA94C;
	Mon,  5 Feb 2024 02:55:34 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F3D8F47;
	Mon,  5 Feb 2024 02:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707101734; cv=none; b=WG5wV3lpX0unNnScL/MPHLrIeG4oXU+iUjIVggjy+6RD7+DYQ5w2/fq+xo2C+awSZHOP9NopSNW6kltGrb9Q9o80B4dYCbgdEXLHpO8xH43n6fiMy6S9PzaqsgPfHsaxTby+Zb8Jgu/Erww+p7tpxUwsuz/EofUWTYTqGlEPsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707101734; c=relaxed/simple;
	bh=2zIjNReeMUVvgXqg+L5v/97JF3tJ7El8lMfaOsXh+g4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=j6aoOnbfmmrnwa1swBUCSMbtgzq1bbyDQgLyHSkCBQZNum/Ja8enKxwrZBwobGzaXtgoqj1wNlrbdwRtajs9hNCdlF/UWgg0JBnQI5101QzA0TEf/uzfwVMu3HxDVX8Rjc9DpePrhFWGEvuRaV0/DRNfiNbTc8E3ncYzE0U3GVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 301721A1B6D;
	Mon,  5 Feb 2024 03:48:08 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0338D1A1B7C;
	Mon,  5 Feb 2024 03:48:08 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 52A5D1820F76;
	Mon,  5 Feb 2024 10:48:06 +0800 (+08)
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
Subject: [PATCH v2 2/2] arm64: dts: imx8mn-evk: Add PDM micphone sound card support
Date: Mon,  5 Feb 2024 10:04:24 +0800
Message-Id: <1707098664-23265-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1707098664-23265-1-git-send-email-shengjiu.wang@nxp.com>
References: <1707098664-23265-1-git-send-email-shengjiu.wang@nxp.com>
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

 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index a0e13d3324ed..269e70f66a13 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -110,6 +110,20 @@ sound-spdif {
 		spdif-out;
 		spdif-in;
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
 
 &easrc {
@@ -285,6 +299,16 @@ &isi {
 	status = "okay";
 };
 
+&micfil {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&clk IMX8MN_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <196608000>;
+	status = "okay";
+};
+
 &mipi_csi {
 	status = "okay";
 
@@ -522,6 +546,18 @@ MX8MN_IOMUXC_I2C3_SDA_GPIO5_IO19	0x1c3
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI5_MCLK_SAI5_MCLK	0xd6
+			MX8MN_IOMUXC_SAI5_RXC_PDM_CLK		0xd6
+			MX8MN_IOMUXC_SAI5_RXFS_SAI5_RX_SYNC	0xd6
+			MX8MN_IOMUXC_SAI5_RXD0_PDM_BIT_STREAM0	0xd6
+			MX8MN_IOMUXC_SAI5_RXD1_PDM_BIT_STREAM1	0xd6
+			MX8MN_IOMUXC_SAI5_RXD2_PDM_BIT_STREAM2	0xd6
+			MX8MN_IOMUXC_SAI5_RXD3_PDM_BIT_STREAM3	0xd6
+		>;
+	};
+
 	pinctrl_pmic: pmicirqgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x141
-- 
2.34.1


