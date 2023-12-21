Return-Path: <linux-kernel+bounces-8347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C8B81B601
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AB41F235BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8836745E7;
	Thu, 21 Dec 2023 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gvgNSaoU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C666EB52;
	Thu, 21 Dec 2023 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BLB0O4f023358;
	Thu, 21 Dec 2023 13:31:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=Nsa2H5miBl9akiMiWy7Ow+OggKNKlHu8xqBbyIslAYs=; b=gv
	gNSaoUjsjiUUId1Vnh9nz3oHoX5hASULFtEeA8AcblY+8aJgUitlTKIQniuawxvu
	qroWXKs41yxDL9jr41cje2CDJI9tIjPGjO7ltnyp2yGNyd/A956ySbM6KLYBQNzd
	508TvQFK2imUqUAm5D2DaSY44UK58lPwiRBT7rF+idDajHCO+0Qa7a31BApEatDQ
	nzzYKSR1NWgu2zw+WL1gOHEt+acXqt0mIuS53Zb7xX/uD7G/fkHL8zfNXXIAhHoV
	sssTM0svSxvntlluqS6ZwhQiTMnkjZtcMbwHFaPaPVT3Yizy7TeF7q+/03BhI9Rh
	NnCyobxcLdMioZ056ttg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v3q810nns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 13:31:24 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6EEA0100053;
	Thu, 21 Dec 2023 13:31:22 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 63E4F2747C4;
	Thu, 21 Dec 2023 13:31:22 +0100 (CET)
Received: from localhost (10.252.25.159) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Dec
 2023 13:31:19 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam
 Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lad
 Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thierry Reding
	<thierry.reding@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v1 6/8] arm64: dts: st: add ltdc support on stm32mp251
Date: Thu, 21 Dec 2023 13:30:35 +0100
Message-ID: <20231221123037.418851-7-raphael.gallais-pou@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221123037.418851-6-raphael.gallais-pou@foss.st.com>
References: <20231221123037.418851-6-raphael.gallais-pou@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_05,2023-12-20_01,2023-05-22_02

The LCD-TFT Display Controller (LTDC) handles display composition,
scaling and rotation. It provides a parallel digital RGB flow to be used
by display interfaces.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 93bc8a8908ce..064077e98dfd 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -212,6 +212,18 @@ i2c8: i2c@46040000 {
 				status = "disabled";
 			};
 
+			ltdc: display-controller@48010000 {
+				compatible = "st,stm32-ltdc";
+				reg = <0x48010000 0x400>;
+				st,syscon = <&syscfg>;
+				interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_BUS_LTDC>, <&rcc CK_KER_LTDC>;
+				clock-names = "bus", "lcd";
+				resets = <&rcc LTDC_R>;
+				status = "disabled";
+			};
+
 			sdmmc1: mmc@48220000 {
 				compatible = "st,stm32mp25-sdmmc2", "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00353180>;
-- 
2.25.1


