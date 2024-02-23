Return-Path: <linux-kernel+bounces-77924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4B5860C39
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612C01F23638
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5925E18042;
	Fri, 23 Feb 2024 08:25:36 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D6171C8;
	Fri, 23 Feb 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676735; cv=none; b=V1YM32w96uYXGd1JL4V0naBtBa2iUxXQka6jWNV+S9y+cCuKm2sJLQm4oQKVTiU/YPZbsgC1HH20002MxpSW/fNh+UYuD/bxshPWuJmP0LqsLVrW/sirBgWSl/ga46rL91/U+D6+8lyfyuBeszeyaRz2HXLju41Uo+c0cFF4/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676735; c=relaxed/simple;
	bh=qB8IC0HQ792BgYcZ4+9CfgE1Ygvie81C6Gp2+oiS/0A=;
	h=From:To:Subject:Date:Message-Id; b=p8TFmOFInQVIJuJgk+GlngM1zReVZrhBTLPO4Q1+/bIv7mjXtBo0cbDIawU84O7kgM6siD0kQVHOgbSUDASbvEtahJsYqoogWpWcdeIRtVBSBBCXML79PKw++RJfetR+IBO/OkGPsvDh3/5o64aSg6obxcIMBi3/c22gmoE7t6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5D8AC1A09CB;
	Fri, 23 Feb 2024 09:17:40 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2208F1A0997;
	Fri, 23 Feb 2024 09:17:40 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 75654183AC0A;
	Fri, 23 Feb 2024 16:17:38 +0800 (+08)
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
Subject: [PATCH 1/2] arm64: dts: imx8mp-evk: Add HDMI audio sound card support
Date: Fri, 23 Feb 2024 16:02:18 +0800
Message-Id: <1708675339-8180-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The AUD2HTX is a digital module that provides a bridge between
the Audio Subsystem and the HDMI RTX Subsystem. This
module includes intermediate storage to queue SDMA transactions
prior to being synchronized and passed to the HDMI
RTX Subsystem over the Audio Link.

AUD2HTX works as the cpu dai in HDMI audio sound card.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 12 ++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index f87fa5a948cc..63f6e72fa18a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -138,6 +138,14 @@ simple-audio-card,codec {
 
 	};
 
+	sound-hdmi {
+		compatible = "fsl,imx-audio-hdmi";
+		model = "audio-hdmi";
+		audio-cpu = <&aud2htx>;
+		hdmi-out;
+		status = "okay";
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -191,6 +199,10 @@ &A53_3 {
 	cpu-supply = <&reg_arm>;
 };
 
+&aud2htx {
+	status = "okay";
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9ab9c057f41e..721ab630d895 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1513,6 +1513,16 @@ micfil: audio-controller@30ca0000 {
 					status = "disabled";
 				};
 
+				aud2htx: aud2htx@30cb0000 {
+					compatible = "fsl,imx8mp-aud2htx";
+					reg = <0x30cb0000 0x10000>;
+					interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_AUD2HTX_IPG>;
+					clock-names = "bus";
+					dmas = <&sdma2 26 2 0>;
+					dma-names = "tx";
+					status = "disabled";
+				};
 			};
 
 			sdma3: dma-controller@30e00000 {
-- 
2.34.1


