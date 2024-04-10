Return-Path: <linux-kernel+bounces-138370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3BF89F039
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402181C2267E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1214159573;
	Wed, 10 Apr 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="Dktcxcjj"
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com [67.231.157.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF315956B;
	Wed, 10 Apr 2024 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746593; cv=none; b=I6/JlUyyAXgYlPoidmzsaWaJYh9QplowpoT5IicBo1uT+Gj3h0SWfztktj8FMqkkTAzWHmtT7xPCxs2fNDvE+AarejFYsjcgYwPVeLZCI8UPGFfZXT6WWGDU4otamJfgHn0X63vPL4MEE2R4eXwUufrRX1ZcrJKKzyoTvqihFbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746593; c=relaxed/simple;
	bh=T2Cxr4cQmLbIrGYgWWPyBq4OPBDB8i8INtNZfa2a06o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=er8Ie671hPRQMdI1xwGqrmZHbXKT+obyDuXmHVO5BJaqEShwxi5YxW+4iD43lB49c5GWXUbuGDNpxqsdTXLRSWGjZ0LpTm998Tt64iRgLz0DXZSwNk5X2p/5OagtlpH6IcUmLXjcNV522n5Rqqgkq/KhM9D90ws4Wx75h5s4KZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=Dktcxcjj; arc=none smtp.client-ip=67.231.157.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Received: from pps.filterd (m0048206.ppops.net [127.0.0.1])
	by m0048206.ppops.net-00176a03. (8.17.1.24/8.17.1.24) with ESMTP id 43A898Ms004481;
	Wed, 10 Apr 2024 06:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	gehealthcare.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=outbound; bh=9nrWY9DytoleI3fgu32cTyh5F+jGWl2jyLpk3CAefTg=; b=
	DktcxcjjbVf0H9wQkAN91LDTjutpxi9qX+PdOnqHzioZlEIuxHN1l+u1TCtpkx+h
	HjI28Qg13/Jm+KCN5iBPg6/YiUrp3GM3J1chZ8HETYF1mcLEo3EOy9Iwmjb53y5o
	/PPvUolyIrbYcEi6S3uaflybnk6Fw4nTEVTh+2PU44jBOLDvb8h0ecr/v6aTgSoJ
	JE/8bGaIPBEkAf0xHaGKi5GLNZGlamGbOvnjLhWxQ+iV/fgl+S9KR20a5TtB9k1e
	0EVC//d7GNIB8Ntk+zc04tgHKLbXK84nG1y67ypVE/ntQxf2kKwWX2MmEtP14iqo
	kJb2FEHG0kuF2wQRrDXMRQ==
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
Subject: [PATCH V3 2/2] arm64: dts: imx8mp-msc-sm2s: Add i2c{1,6} sda-/scl-gpios
Date: Wed, 10 Apr 2024 13:56:11 +0300
Message-Id: <20240410105612.982-2-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410105612.982-1-ian.ray@gehealthcare.com>
References: <20240410105612.982-1-ian.ray@gehealthcare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zzNEZ2C6v6r31bR0u8LXi5DxSsUwnH2k
X-Proofpoint-ORIG-GUID: zzNEZ2C6v6r31bR0u8LXi5DxSsUwnH2k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100078

Add i2c{1,6} sda-/scl-gpios with the corresponding pinmux entries.

Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 .../boot/dts/freescale/imx8mp-msc-sm2s.dtsi   | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
index e794f05cf5aa..0fd5c3abcdb7 100644
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
 			<MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001e0>;
 	};
 
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14		0x1e0>,
+			<MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15		0x1e0>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins =
 			<MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001e0>,
@@ -636,6 +648,12 @@ pinctrl_i2c6: i2c6grp {
 			<MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA		0x400001e0>;
 	};
 
+	pinctrl_i2c6_gpio: i2c6gpiogrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19		0x1e0>,
+			<MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20		0x1e0>;
+	};
+
 	pinctrl_lcd0_backlight: lcd0-backlightgrp {
 		fsl,pins =
 			<MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05		0x41>;
-- 
2.39.2


