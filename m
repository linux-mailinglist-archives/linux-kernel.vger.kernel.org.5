Return-Path: <linux-kernel+bounces-77923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 320BE860C38
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5301F22BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E6D18039;
	Fri, 23 Feb 2024 08:25:36 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5491643E;
	Fri, 23 Feb 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676735; cv=none; b=qvQpbxy0qgGyW9zHV9pxmauuB+4M1al+4C2v3Duwbn1kYUk3V5Xv5BnafJLz35ySLHwKDWxYn16/SiuoOfJNPGOBVycKWGAUKeTtQsX4Kn2akMfqN99WlsM7yFMT3Y9ahKLmsOfMGVWmzlglxXt4DIJxQPXh6woudwH+1PWpgf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676735; c=relaxed/simple;
	bh=qAl1KeYptMFYfDgXCbpPXJEIKYmK6FKlgiquwJOgj3M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=UQoj/DVv5D224DMjvUzTtaK1naTDmedlPcDYfHxJMCN7HgYh1+q/B415f/wcYB6fZegGQs9ElGmeDhZw3JR7fhLi/xGSWYjYZaP7qmTWyT78g/wxv4h4roswrBuB7rp2U8D62HOIun7wXZpqtWebf/xv+J4yOddLd/KRFYegF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8735A1A09B4;
	Fri, 23 Feb 2024 09:17:41 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5082A1A098E;
	Fri, 23 Feb 2024 09:17:41 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A5B651802201;
	Fri, 23 Feb 2024 16:17:39 +0800 (+08)
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
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH 2/2] arm64: dts: imx8mp-evk:Add PDM micphone sound card support
Date: Fri, 23 Feb 2024 16:02:19 +0800
Message-Id: <1708675339-8180-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1708675339-8180-1-git-send-email-shengjiu.wang@nxp.com>
References: <1708675339-8180-1-git-send-email-shengjiu.wang@nxp.com>
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
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 63f6e72fa18a..fdcd1158a34a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -146,6 +146,20 @@ sound-hdmi {
 		status = "okay";
 	};
 
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
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -527,6 +541,16 @@ &lcdif1 {
 	status = "okay";
 };
 
+&micfil {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&clk IMX8MP_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <196608000>;
+	status = "okay";
+};
+
 &mipi_dsi {
 	samsung,esc-clock-frequency = <10000000>;
 	status = "okay";
@@ -793,6 +817,16 @@ MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x40
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXC__AUDIOMIX_PDM_CLK		0xd6
+			MX8MP_IOMUXC_SAI5_RXD0__AUDIOMIX_PDM_BIT_STREAM00	0xd6
+			MX8MP_IOMUXC_SAI5_RXD1__AUDIOMIX_PDM_BIT_STREAM01	0xd6
+			MX8MP_IOMUXC_SAI5_RXD2__AUDIOMIX_PDM_BIT_STREAM02	0xd6
+			MX8MP_IOMUXC_SAI5_RXD3__AUDIOMIX_PDM_BIT_STREAM03	0xd6
+		>;
+	};
+
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x000001c0
-- 
2.34.1


