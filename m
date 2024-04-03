Return-Path: <linux-kernel+bounces-129317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B08896884
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628FE1F2278C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA8C7442A;
	Wed,  3 Apr 2024 08:18:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159EA6BB2F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132330; cv=none; b=EleJLLEAg1Sx7rF0W9KRsT9x7iVp9OrxQF86pS/KRqfBNS67JVSVh7srLiK1sfjoYVOP4VgGSir+KpfHVoLbk2TrSSB31WVHPmc0hPn1aC2QHxqYB35pHneP2ANrtt0AOTt2an+RPPHFifouGhm059juCtQDxPQv7EFgHyl3/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132330; c=relaxed/simple;
	bh=LHMKNwipL5y/ze/oXu72nsM/oT8i12x7vNUYNMYtPUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OCkm+sifgcyxyNt/070H/V++tZZsLoGHkccT0mpMjyNexSjrSjHhR2GhmiTkOFPBrH2nT1HpsJtYH27c0eYdLJAgDpZsZ18Fc/l66K5lbHeGZUxNDuqFF/R4x98WpiyKhSU9FSE0t7kfE6ergSjur6ATnABINX3Zdazr9LiqoXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rrvpP-0006HX-8w; Wed, 03 Apr 2024 10:18:39 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rrvpO-00A8kA-BN; Wed, 03 Apr 2024 10:18:38 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rrvpO-008gNm-0w;
	Wed, 03 Apr 2024 10:18:38 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Wed, 03 Apr 2024 10:18:27 +0200
Subject: [PATCH v2] ARM: dts: imx27-phytec: Add USB support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-pca100-v2-1-d7ff1679f75b@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIANIQDWYC/2WNywqDMBBFf0Vm3ZRJfKVd9T+KixhHHZAoiYpF8
 u9N3XZ5DpdzTwjkmQI8sxM87Rx4dgnULQM7GjeQ4C4xKFQF5kqLxRqJKEyFaGyR64JqSOPWBBK
 tN86Oae62aUpy8dTzcdXfTeKRwzr7z3W2y5/96+5SSFHqrq9qq+yjxNdCbthWPzs+7h1BE2P8A
 uz6M6i2AAAA
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3522;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=LHMKNwipL5y/ze/oXu72nsM/oT8i12x7vNUYNMYtPUc=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmDRDZzMhmunN9ug9rzy06HHj5WPF6gun35cFy1
 KLMS6DkzUSJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZg0Q2QAKCRC/aVhE+XH0
 q92LD/0WTMs+v39Y4IJL6d/wevTebFY46OnfupWCUeJz0nIlp0toCyPkERXJAGh2apomolp4SCV
 +RShO18zsICBs/1hqpMFo71aW7d4syZrR6nZLX5GgGxzlGZS/c5kOzbxqtVGeuZg0wCCEY47l0f
 Ps30Bu7IzssQ/Tov6cp/VPgDrL8MVzLnrXwZqfsefjsp/474p1UeP6tDgA+VR0v/8hCGWCmV11c
 Xu4wL6WCVjqBfc/mvYupRQq1ujfH8LESAPjMNVWS3hL4jaLBTjUYJbEE/1vXMs5nn4F5qbZ1FEa
 Ie+s2nNy14CjMgU5/U6Sqd3kScj7aGaIJ/qiyEWePZVKTgWTNhr7stuucQi8ctd55ukErRkGzhE
 4ZeHMo6K7ee8eIQwkoEGrkwnVUYrXFHwZkmD9qlDdy/Mg24OmSKm+g5WRsJdMLzSNBUqAROCa5q
 dzQdg5JYrSprMQbmlLLJV+eRJKuke9TaFNGYbUNzVvd8LvoyqBypWvHRQyNtZ8fXZfA1rN6bA/g
 LireZNOJcrSiesQnM+C/teQIcXMs5DmVjuhy8Cz+WV9GQvz/2c8iAwcMiEmlhr/naXne5v/JaEg
 Uw/MG8WBa7Te0LWmpXHtU37RuAx9JhrzBhCB8hnwo/QxK3DGAtCysBF7Z1ilBUBinpFbrRwF3+h
 ALhat8wtk+lkUYw==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This patch adds the pinmux and nodes for usbotg and usbh2.

In v6 revision of the pca100 the usb phys were changed to usb3320 which
are connected by their reset pins. We add the phy configuration to the
description.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Changes in v2:
- changed prefix to "ARM: dts: imx27-phytec:"
- Link to v1: https://lore.kernel.org/r/20240328-pca100-v1-1-58df67c2c950@pengutronix.de
---
 .../dts/nxp/imx/imx27-phytec-phycard-s-som.dtsi    | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-som.dtsi
index abc9233c5a1b1..31b3fc972abbf 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-som.dtsi
@@ -15,6 +15,22 @@ memory@a0000000 {
 		device_type = "memory";
 		reg = <0xa0000000 0x08000000>; /* 128MB */
 	};
+
+	usbotgphy: usbotgphy {
+		compatible = "usb-nop-xceiv";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbotgphy>;
+		reset-gpios = <&gpio2 25 GPIO_ACTIVE_LOW>;
+		#phy-cells = <0>;
+	};
+
+	usbh2phy: usbh2phy {
+		compatible = "usb-nop-xceiv";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbh2phy>;
+		reset-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
+		#phy-cells = <0>;
+	};
 };
 
 &cspi1 {
@@ -84,6 +100,52 @@ MX27_PAD_NFRE_B__NFRE_B 0x0
 				MX27_PAD_NFWE_B__NFWE_B 0x0
 			>;
 		};
+
+		pinctrl_usbotgphy: usbotgphygrp {
+			fsl,pins = <
+				MX27_PAD_USBH1_RCV__GPIO2_25		0x1 /* reset gpio */
+			>;
+		};
+
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				MX27_PAD_USBOTG_CLK__USBOTG_CLK		0x0
+				MX27_PAD_USBOTG_DIR__USBOTG_DIR		0x0
+				MX27_PAD_USBOTG_NXT__USBOTG_NXT		0x0
+				MX27_PAD_USBOTG_STP__USBOTG_STP		0x0
+				MX27_PAD_USBOTG_DATA0__USBOTG_DATA0	0x0
+				MX27_PAD_USBOTG_DATA1__USBOTG_DATA1	0x0
+				MX27_PAD_USBOTG_DATA2__USBOTG_DATA2	0x0
+				MX27_PAD_USBOTG_DATA3__USBOTG_DATA3	0x0
+				MX27_PAD_USBOTG_DATA4__USBOTG_DATA4	0x0
+				MX27_PAD_USBOTG_DATA5__USBOTG_DATA5	0x0
+				MX27_PAD_USBOTG_DATA6__USBOTG_DATA6	0x0
+				MX27_PAD_USBOTG_DATA7__USBOTG_DATA7	0x0
+			>;
+		};
+
+		pinctrl_usbh2phy: usbh2phygrp {
+			fsl,pins = <
+				MX27_PAD_USBH1_SUSP__GPIO2_22		0x0 /* reset gpio */
+			>;
+		};
+
+		pinctrl_usbh2: usbh2grp {
+			fsl,pins = <
+				MX27_PAD_USBH2_CLK__USBH2_CLK		0x0
+				MX27_PAD_USBH2_DIR__USBH2_DIR		0x0
+				MX27_PAD_USBH2_NXT__USBH2_NXT		0x0
+				MX27_PAD_USBH2_STP__USBH2_STP		0x0
+				MX27_PAD_CSPI2_SCLK__USBH2_DATA0	0x0
+				MX27_PAD_CSPI2_MOSI__USBH2_DATA1	0x0
+				MX27_PAD_CSPI2_MISO__USBH2_DATA2	0x0
+				MX27_PAD_CSPI2_SS1__USBH2_DATA3		0x0
+				MX27_PAD_CSPI2_SS2__USBH2_DATA4		0x0
+				MX27_PAD_CSPI1_SS2__USBH2_DATA5		0x0
+				MX27_PAD_CSPI2_SS0__USBH2_DATA6		0x0
+				MX27_PAD_USBH2_DATA7__USBH2_DATA7	0x0
+			>;
+		};
 	};
 };
 
@@ -95,3 +157,19 @@ &nfc {
 	nand-on-flash-bbt;
 	status = "okay";
 };
+
+&usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	phy_type = "ulpi";
+	phys = <&usbotgphy>;
+	status = "okay";
+};
+
+&usbh2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh2>;
+	phy_type = "ulpi";
+	phys = <&usbh2phy>;
+	status = "okay";
+};

---
base-commit: 5bab5dc780c9ed0c69fc2f828015532acf4a7848
change-id: 20240328-pca100-a600ac4384e7

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


