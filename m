Return-Path: <linux-kernel+bounces-138371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB95189F03D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EDB1F23B23
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D1B159583;
	Wed, 10 Apr 2024 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="R2H1uwrn"
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com [67.231.149.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9AB1598EE;
	Wed, 10 Apr 2024 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746596; cv=none; b=Q7BYN0gWTlVlXxDf8hjQTAILNRkncgtv69xcmaPAA57ROrB/5qeKlKeoQFtzl0fAA4fyYoTmyRpzbJhLrjTtts/NofqxxR6e9OKa5kT5CzUa5dnSk70TOTbj1Whhxkc45uraAZBf1XmbTwmIU5RDrb0DPWSe9AXLoutQNr3a/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746596; c=relaxed/simple;
	bh=nhPe0d6dN1xtXoa/pLx+Q5JNnTdOC3fNY0Y7FDbUkno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B0ELqkMangy6VeAT2mOhUA5sdLbqCRFD7bJx1MTaUjde9Zq542TIzw+fPkk0/tWx7tsjf6frS/4LE7zhw79KhZbB8dswPujMgpFNvINlSm/gLRTaALKynuXbDd/VfpgyUr+VQys79OlSpawZYDfhaoeQdkX4KrG5VZfJmvevUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=R2H1uwrn; arc=none smtp.client-ip=67.231.149.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Received: from pps.filterd (m0047962.ppops.net [127.0.0.1])
	by m0047962.ppops.net-00176a03. (8.17.1.24/8.17.1.24) with ESMTP id 43AA3Gpi006699;
	Wed, 10 Apr 2024 06:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	gehealthcare.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=outbound; bh=gRNkGdhV
	4ndQT+3cfhHl3osGq/PeHfRnMZPdJWTnA9U=; b=R2H1uwrnPTlqEmkA2Kiu0dX+
	0Nlvm2fxhW2fU5GJFrDFbALrFxa24D7nKtdI5VjAwjXYeNxkMu6YwsgDczCmdnyw
	jbyeGWunUBB38Jwfyda3Oa8mY/cCsJLpd5zsbKc/uf6NDsUm/ttMs2flJJ7PBVfT
	V0UNFqQ/nWTuV2sxMzXroYjYoD49lUwCP9Jx1EPizKgwgChPg5MFsFejaVO+BGRC
	9z4XrE0y2nSHFgxgrcCJcAwcLbN+pwGrMb0mdynSR45DiO7Iye040APd8F4Ke70T
	03auGCfThBHW48X5Ye8BeKwFYB6lVpZ5r+teetS00QJ8PYvTXApobMYJ5y7TBQ==
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
Subject: [PATCH V3 1/2] arm64: dts: imx8mp-msc-sm2s: correct i2c{1..6} pad drive strength
Date: Wed, 10 Apr 2024 13:56:10 +0300
Message-Id: <20240410105612.982-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dcDj0jcAueAG4oxK9GL9BXWa2HBSzQmn
X-Proofpoint-ORIG-GUID: dcDj0jcAueAG4oxK9GL9BXWa2HBSzQmn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404100078

Adjust i2c drive strength based on latest Avnet BSP.

Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 .../boot/dts/freescale/imx8mp-msc-sm2s.dtsi   | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
index 61c2a63efc6d..e794f05cf5aa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
@@ -602,38 +602,38 @@ pinctrl_flexspi0: flexspi0grp {
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins =
-			<MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c3>;
+			<MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001e0>,
+			<MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001e0>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins =
-			<MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c3>;
+			<MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001e0>,
+			<MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001e0>;
 	};
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins =
-			<MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c3>;
+			<MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001e0>,
+			<MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001e0>;
 	};
 
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins =
-			<MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA		0x400001c3>;
+			<MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL		0x400001e0>,
+			<MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA		0x400001e0>;
 	};
 
 	pinctrl_i2c5: i2c5grp {
 		fsl,pins =
-			<MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA		0x400001c3>;
+			<MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL		0x400001e0>,
+			<MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA		0x400001e0>;
 	};
 
 	pinctrl_i2c6: i2c6grp {
 		fsl,pins =
-			<MX8MP_IOMUXC_SAI5_RXFS__I2C6_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA		0x400001c3>;
+			<MX8MP_IOMUXC_SAI5_RXFS__I2C6_SCL		0x400001e0>,
+			<MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA		0x400001e0>;
 	};
 
 	pinctrl_lcd0_backlight: lcd0-backlightgrp {
-- 
2.39.2


