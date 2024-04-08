Return-Path: <linux-kernel+bounces-135168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2453C89BC1B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E501F230C5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358D14AEC2;
	Mon,  8 Apr 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="o4vdlasY"
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com [67.231.149.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69ED4176B;
	Mon,  8 Apr 2024 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569305; cv=none; b=sQiskNwfbnWrem2L2vzB9IRq6MdBWE1wzXcvRIatsiGB8aLbwFEqkGOtFwopddfIAFwZoRQDCGOw6c7vzYA0q4XUZeIUDRzogbqsqMMEZM8bT2FDeFQWmEki/OeM0H/2RevZlkPRVTGCoCRVU4l2dzh4marsgA4+RtpJtmeDtYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569305; c=relaxed/simple;
	bh=VBbyy+f6ApNNw/g8S5UqMO+gnfsVcOxeQZsix2HzRAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dKOpjfisI8EN/1nMGskivwxOQTqzeW2vZoYxj5rZjC33zlkBRediRH5VgliWV522rmqwujR/QS4XRwXiku9x9Jwh5Eh/piowzCmJ/6dtT5thNvyhuT4WAXHN1ywLNTpJ1AqmJ5ExSnxxXTQ8EBINLkw73Brh3D6bc8eE9mynEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=o4vdlasY; arc=none smtp.client-ip=67.231.149.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Received: from pps.filterd (m0048274.ppops.net [127.0.0.1])
	by m0048274.ppops.net-00176a03. (8.17.1.24/8.17.1.24) with ESMTP id 4386aW4c011966;
	Mon, 8 Apr 2024 05:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	gehealthcare.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=outbound; bh=qYN2gTSX
	hF9fQTvXvqjS4pLs+E5SrnBzBEJm94NG1bk=; b=o4vdlasYAGzFSXaGpDDp754F
	VPkKd1iB60geg86+mCnlAq2BH7pzAV1yC2+cFKO4kw15IhVaEhLlCcsoETCzsy5g
	1rk4HqxtLv/JccHcfNQ6ydnIRYQbadwzdIThr0OIfvGW4DJppG2xaWqEgk2j+Yu2
	h+SIktSytYfKvkf6Q5vsHqctUZZKLRcBIHXQajKl3BlhHOW+7SxJ5X0o/WvBT1fR
	n+yw+MJNPKvWdpd5D2fYFENufmBOZ7rRw22uny64qXREkrDurN8sv3rNLidICzW8
	zX+yWMEp4pBx4V+iJ4Q5+NaztVbSulQU8ElkSlcQbG2oplH++OZbAIGzCryQng==
From: Ian Ray <ian.ray@gehealthcare.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>, devicetree@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp-msc-sm2s: Add i2c{1,6} sda-/scl-gpios
Date: Mon,  8 Apr 2024 12:24:49 +0300
Message-Id: <20240408092449.6-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: w2OUKmRIns4E--hL0KlioGlPlTKoGXpb
X-Proofpoint-ORIG-GUID: w2OUKmRIns4E--hL0KlioGlPlTKoGXpb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_07,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 phishscore=0
 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080072

Add i2c{1,6} sda-/scl-gpios with the corresponding pinmux entries.

Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 .../boot/dts/freescale/imx8mp-msc-sm2s.dtsi   | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
index 61c2a63efc6d..7e4327084d26 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
@@ -200,8 +200,11 @@ ethphy1: ethernet-phy@1 {
 };
 
 &i2c1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	clock-frequency = <400000>;
 	status = "okay";
 
@@ -241,8 +244,11 @@ &i2c5 {
 };
 
 &i2c6 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c6>;
+	pinctrl-1 = <&pinctrl_i2c6_gpio>;
+	scl-gpios = <&gpio3 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio3 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	clock-frequency = <400000>;
 	status = "okay";
 
@@ -606,6 +612,12 @@ pinctrl_i2c1: i2c1grp {
 			<MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c3>;
 	};
 
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14		0x400001c3>,
+			<MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15		0x400001c3>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins =
 			<MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c3>,
@@ -636,6 +648,12 @@ pinctrl_i2c6: i2c6grp {
 			<MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA		0x400001c3>;
 	};
 
+	pinctrl_i2c6_gpio: i2c5gpiogrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19		0x400001c3>,
+			<MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20		0x400001c3>;
+	};
+
 	pinctrl_lcd0_backlight: lcd0-backlightgrp {
 		fsl,pins =
 			<MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05		0x41>;
-- 
2.39.2


