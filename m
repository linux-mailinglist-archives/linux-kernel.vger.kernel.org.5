Return-Path: <linux-kernel+bounces-135315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9A189BEE7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5071C2313A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA9E6BFC8;
	Mon,  8 Apr 2024 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="cJUnpV9A"
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com [67.231.149.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFEA6BB22;
	Mon,  8 Apr 2024 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579054; cv=none; b=DCThYP6cayKfOOQidL0cYFUvo9ITKVl5JVCo+4hk2Dtu5TosZlrmyd6cAW29zf4O/zRPuR0z6AEvAX626Wka2zBhQEOBAeC8lRXLIfcS5Pt4iKOyPqt+gdo7UqsC2/rnU6RsE4sJbOo+fbm8UhnTVVHI0bF92aX4AEb565hcgEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579054; c=relaxed/simple;
	bh=GpnFs2t5w2IroOlrRJ01bHIpoZ/Lyml1s7LCsMB/URE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g/iA+9k1/fTMVC6RPgG+UYSv8g93vc3pg+EJs7Qs8xNfZndG6pG8YWzQ4K7Ei0gpOUlkOtViyxNYyIaLlpKIHp827nRuPsixxypVk8TGfwqik7Gj3ZIVA4R07dPaxCmzitXG+d2rAtGOPt75k2iGiKm9/FU2aWtOeH5v+oOOE8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=cJUnpV9A; arc=none smtp.client-ip=67.231.149.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Received: from pps.filterd (m0048275.ppops.net [127.0.0.1])
	by m0048275.ppops.net-00176a03. (8.17.1.24/8.17.1.24) with ESMTP id 438AFiuJ045351;
	Mon, 8 Apr 2024 08:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	gehealthcare.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=outbound; bh=lceKTOV2
	r6mmdYTSBe6CCsGlaOpiBawAq4xmDcAYVHU=; b=cJUnpV9A/+uNMoYMGXxn+/Jz
	m17rOTVcLURAJWs+E1nekE9xqPbEYo1j9xWodi/5dE7NnmG+hrsAN5mucdb2f+Dv
	hTT000kT3DCIUMjazoXemplOWLliDVQqPA78qsD5XSEA7w+T0/FOcxQYrEPP1mBV
	bQejhkLdWe4MIRrUjwcJcFK+/LRqHcGqKYUm3Tp3ivb0gk8M3Nqwqu/FVR3J2Gwf
	ntIdUlluoRUYhMAL9ifF9jwK2ho+OlVjOKdePxYUuwQxtE/1nkRfx1Nf/JJqFtPN
	o9MgOU4XDnHmzlbrkwEqgt/VqkNjv432yDI3cEkXyX5Fgrhj2u69pNcjFbJ5fQ==
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
Subject: [PATCH V2 1/2] arm64: dts: imx8mp-msc-sm2s: do not write i2c pinctrl reserved bit
Date: Mon,  8 Apr 2024 15:23:20 +0300
Message-Id: <20240408122321.464-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MKMn7oxtkMDGUD-yYKVygExIrMIc25R3
X-Proofpoint-ORIG-GUID: MKMn7oxtkMDGUD-yYKVygExIrMIc25R3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_11,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=939 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080095

Better not to write to the reserved bit.

Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 .../boot/dts/freescale/imx8mp-msc-sm2s.dtsi   | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
index 61c2a63efc6d..940bdbe115a3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
@@ -602,38 +602,38 @@ pinctrl_flexspi0: flexspi0grp {
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins =
-			<MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c3>;
+			<MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c2>,
+			<MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins =
-			<MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c3>;
+			<MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2>,
+			<MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c2>;
 	};
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins =
-			<MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c3>;
+			<MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c2>,
+			<MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c2>;
 	};
 
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins =
-			<MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA		0x400001c3>;
+			<MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL		0x400001c2>,
+			<MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA		0x400001c2>;
 	};
 
 	pinctrl_i2c5: i2c5grp {
 		fsl,pins =
-			<MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA		0x400001c3>;
+			<MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL		0x400001c2>,
+			<MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA		0x400001c2>;
 	};
 
 	pinctrl_i2c6: i2c6grp {
 		fsl,pins =
-			<MX8MP_IOMUXC_SAI5_RXFS__I2C6_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA		0x400001c3>;
+			<MX8MP_IOMUXC_SAI5_RXFS__I2C6_SCL		0x400001c2>,
+			<MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA		0x400001c2>;
 	};
 
 	pinctrl_lcd0_backlight: lcd0-backlightgrp {
-- 
2.39.2


