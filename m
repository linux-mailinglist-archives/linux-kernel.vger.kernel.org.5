Return-Path: <linux-kernel+bounces-111437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AAC886C58
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704511F21AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402B9405EC;
	Fri, 22 Mar 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clfNNh2U"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91763FE3F;
	Fri, 22 Mar 2024 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111617; cv=none; b=bznbqhXpm3kSn9PChFrMOmFKpaI5eAp8okEMwhcvkOmfk483XAvJy9DuzHM0NLEGyYNdZSTBI98IktLe/I6xlZKit0KtLcmQd9Ndco/KG1cjHw04b7RnDtTQhgENbsXMeXXqr6R6HfXE8qP6SD9oVRBSJh5Qm31qww1Oe4viAOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111617; c=relaxed/simple;
	bh=Mc+nWMMEosm4ccbDGJPAs1X/IhkrsXvc6bhBeMV+Uuk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L4etYaS8KDY3x6u1TEXVQhHKuV3hqySohno6o3pLUR1YWZvqpGf3jb0fOOD0D9cfSETYFWmZAGBqSSI1aCYZm74aMYJ2yeIdyjfUnrNp3GLqQrqqxv+X1fTtVAID86qXi/5cax8eC5nAlP6kxzn021cTe3APu2HEdAjvI522rjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clfNNh2U; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4147c8e27a8so4284665e9.3;
        Fri, 22 Mar 2024 05:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711111614; x=1711716414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RB3xFwev27cGWj/kr3xX//Yti9pwXGl2cOzo4+2MzaA=;
        b=clfNNh2UflSptwX1xbyj5W+0GRuUdeysRjBWFGfhOj/pDedCU+MZDIxaki7xHdtTHk
         s1Urj8wjjlaXAC51en8jsVXiHRWE9uFDcHNTx9H8C6Rv45ytmZ8aqBo9o1yOJ0XsIuAW
         9lyf1H/sAMOAkq9cmdeTVB7pGb4pwUVCpur/TXdiuYXa6UeVK0qet7bkf4Nm4+zc11LJ
         C897+IXOYudUKFcjEK3l0OWkEi/JO3Ojcxe/90NLIQZG32VQmdyyGJ1JHIFD5NnKqoLZ
         M+pIkbyDYwcEZBOepEEsO0c/l4GgjyB1k/xeTdCNyQ3oJjnn4WT4XoLZ2YV30uezqx02
         edPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711111614; x=1711716414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RB3xFwev27cGWj/kr3xX//Yti9pwXGl2cOzo4+2MzaA=;
        b=kSbtoF/p2HU25ZWZKy7IZNCJqwCRoQx1U9jFAzmfj5gL344Xz0nFFIj5H9xB5aON7v
         Gr0CIqDRXw8s67m/BSMDSPIH+DRNOR/Knxmqh8ums+Ap4BCNODtJg5yfOKGwSrzdMnZ3
         fq8640anChg01jd2E3GbctHadDQ98TMfi2b62iz3zChl7gQOAZqyxAE9heWIHPaZoGTb
         rS14EdYcxDruObZqmKxL8mi1YSpqdl99Kg/e/Ae5P1GYCoT4aYfnUOG2BwRWe7Snn9Fg
         zthX5Gbj1+X1BYSXXL9rdJmpCepFXiPYth+HiwuPwyYZGswNluvAWagcunMPnNp7I3AY
         Ymag==
X-Forwarded-Encrypted: i=1; AJvYcCVxjDdv3qz1fnrDyFqZITz8inUmQAFZa1dg6I9P/ui1fP3wIzGRZ/pAWzGx0n58EV6AAyGV31S2fw1h1GXwrTD0AxCYcrpg6eKNHilovl1alSZ074pImrmU6djB0IbCjbXEZbclSV7xOQ==
X-Gm-Message-State: AOJu0YwHi4aaJh+I6J3aCMDSKVmYxmWWuZxTFhYLkahTDFgLHKfE/6rv
	PhGxyQl6mqxDjzZZzJHtnfCwFHXFIBLqCfL4ftK04Y4Ck+mSK2TC
X-Google-Smtp-Source: AGHT+IF1qkzrv8qD8jTN7ZbrlS28HPptaqDOjy8Lg9y2eBBFT2JZD+2cG6aY3z0Wj3QZyyLsLSv+AA==
X-Received: by 2002:a05:600c:4506:b0:412:d149:254c with SMTP id t6-20020a05600c450600b00412d149254cmr1823332wmo.17.1711111613810;
        Fri, 22 Mar 2024 05:46:53 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e622:f700:7937:89a:a375:7ff2])
        by smtp.gmail.com with ESMTPSA id p42-20020a05600c1daa00b004146f93a9d1sm6747201wms.25.2024.03.22.05.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 05:46:53 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: freescale: verdin-imx8mp: enable Verdin I2C_3_HDMI interface
Date: Fri, 22 Mar 2024 12:46:20 +0000
Message-Id: <20240322124620.40250-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

Enable Verdin I2C_3_HDMI interface on iMX8MP Toradex Verdin boards.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 .../dts/freescale/imx8mp-verdin-dahlia.dtsi   |  5 ++++
 .../boot/dts/freescale/imx8mp-verdin-dev.dtsi |  5 ++++
 .../dts/freescale/imx8mp-verdin-mallow.dtsi   |  5 ++++
 .../dts/freescale/imx8mp-verdin-yavia.dtsi    |  5 ++++
 .../boot/dts/freescale/imx8mp-verdin.dtsi     | 27 ++++++++++++++++---
 5 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
index 7e9e4b13b5c5..8d954259085f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
@@ -110,6 +110,11 @@ wm8904_1a: audio-codec@1a {
 	};
 };
 
+/* Verdin I2C_3_HDMI */
+&i2c5 {
+	status = "okay";
+};
+
 /* Verdin PCIE_1 */
 &pcie {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
index a509b2b7fa85..e5400140e5c6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
@@ -131,6 +131,11 @@ nau8822_1a: audio-codec@1a {
 	};
 };
 
+/* Verdin I2C_3_HDMI */
+&i2c5 {
+	status = "okay";
+};
+
 /* Verdin PCIE_1 */
 &pcie {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-mallow.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-mallow.dtsi
index 8482393f3cac..1d15f7449c58 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-mallow.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-mallow.dtsi
@@ -112,6 +112,11 @@ &i2c4 {
 	status = "okay";
 };
 
+/* Verdin I2C_3_HDMI */
+&i2c5 {
+	status = "okay";
+};
+
 /* Verdin PCIE_1 */
 &pcie {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
index db1722f0d80e..3a8542266d85 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
@@ -117,6 +117,11 @@ &i2c4 {
 	status = "okay";
 };
 
+/* Verdin I2C_3_HDMI */
+&i2c5 {
+	status = "okay";
+};
+
 /* Verdin PCIE_1 */
 &pcie {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index faa17cbbe2fd..f033d4310305 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -664,8 +664,6 @@ atmel_mxt_ts_mezzanine: touch-mezzanine@4a {
 	};
 };
 
-/* TODO: Verdin I2C_3_HDMI */
-
 /* Verdin I2C_4_CSI */
 &i2c3 {
 	clock-frequency = <400000>;
@@ -764,6 +762,16 @@ eeprom_carrier_board: eeprom@57 {
 	};
 };
 
+/* Verdin I2C_3_HDMI */
+&i2c5 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c5>;
+	pinctrl-1 = <&pinctrl_i2c5_gpio>;
+	scl-gpios = <&gpio3 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio3 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
 /* Verdin PCIE_1 */
 &pcie {
 	pinctrl-names = "default";
@@ -1106,8 +1114,6 @@ pinctrl_gpio_keys: gpiokeysgrp {
 	pinctrl_hdmi_hog: hdmihoggrp {
 		fsl,pins =
 			<MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC	0x40000019>,	/* SODIMM 63 */
-			<MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x400001c3>,	/* SODIMM 59 */
-			<MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x400001c3>,	/* SODIMM 57 */
 			<MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD	0x40000019>;	/* SODIMM 61 */
 	};
 
@@ -1163,6 +1169,19 @@ pinctrl_i2c4_gpio: i2c4gpiogrp {
 			<MX8MP_IOMUXC_I2C4_SDA__GPIO5_IO21		0x400001c6>;	/* SODIMM 12 */
 	};
 
+	/* Verdin I2C_3_HDMI */
+	pinctrl_i2c5: i2c5grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_HDMI_DDC_SCL__I2C5_SCL		0x400001c6>,	/* SODIMM 59 */
+			<MX8MP_IOMUXC_HDMI_DDC_SDA__I2C5_SDA		0x400001c6>;	/* SODIMM 57 */
+	};
+
+	pinctrl_i2c5_gpio: i2c5gpiogrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_HDMI_DDC_SCL__GPIO3_IO26		0x400001c6>,	/* SODIMM 59 */
+			<MX8MP_IOMUXC_HDMI_DDC_SDA__GPIO3_IO27		0x400001c6>;	/* SODIMM 57 */
+	};
+
 	/* Verdin I2S_2_BCLK (TOUCH_RESET#) */
 	pinctrl_i2s_2_bclk_touch_reset: i2s2bclktouchresetgrp {
 		fsl,pins =
-- 
2.34.1


