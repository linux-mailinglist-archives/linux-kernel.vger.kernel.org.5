Return-Path: <linux-kernel+bounces-82789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506248689B7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4F0281AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0361E54672;
	Tue, 27 Feb 2024 07:18:59 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52714CDE5;
	Tue, 27 Feb 2024 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018338; cv=none; b=l4+i1i0By+5D5QhoXra7UvgvHoxsIipz+gSWjCWc57YuD0AwfMwf+TsCNTrzQalooX59c2z6Ih2+7uZCLaE5YilDafMALGZ88u2mdxuUiD64Cq4MdfCtVL9/NrDAEOm+BrkkXGVB3STDQ4pK/KqcgyErcBLSSvLB5lyZHwcAUP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018338; c=relaxed/simple;
	bh=ToisYZuI7MZKU3it1QS/peZAWzZKZvZwXjHvuBMEUNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=g7LCH4ZnIptgj8uPycRDcAk4Kcl8PTkCS9d9LMpMbF2DO8YX4/fUb5oMDjgnVt3KFAziGWlJEEg6Fm8QaFZLMGyzm52ozo+fx8whYOnYbaSf4+dX2whGCUY1DJhYtAMJ1jnjowkSreds6D0d/DnJ521LPwPKS+3bAaxqQ4Oekzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2FB14201473;
	Tue, 27 Feb 2024 08:18:55 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0251F20044A;
	Tue, 27 Feb 2024 08:18:55 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 535A2183AD16;
	Tue, 27 Feb 2024 15:18:53 +0800 (+08)
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
Subject: [PATCH v2 2/2] arm64: dts: imx8mp-evk: Add PDM micphone sound card support
Date: Tue, 27 Feb 2024 15:03:26 +0800
Message-Id: <1709017406-12624-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1709017406-12624-1-git-send-email-shengjiu.wang@nxp.com>
References: <1709017406-12624-1-git-send-email-shengjiu.wang@nxp.com>
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
- none

 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 0fc6c0d21cd6..97a3198f2b59 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -145,6 +145,20 @@ sound-hdmi {
 		hdmi-out;
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
@@ -526,6 +540,16 @@ &lcdif1 {
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
@@ -792,6 +816,16 @@ MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x40
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


