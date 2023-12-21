Return-Path: <linux-kernel+bounces-8350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5B881B607
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B418B27076
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980B1768FA;
	Thu, 21 Dec 2023 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2hahOQz5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D0760B2;
	Thu, 21 Dec 2023 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BLCVIVF026219;
	Thu, 21 Dec 2023 13:31:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=f+RuX/Eia9uR2MHJdZssTap6bVCpuc5frqUe4l82QhE=; b=2h
	ahOQz5JifuxVoA0OYdFj/Ue+3k4I8L8jDuYDD+UXKwQJTsNMtjPWKax1HXf1ZQ+c
	oTPwx6VD22ERWODSXMSNZWFiVKfnSaLuqqaRhS3Bcc5r/3uT/sfMXmmR+mDu29/n
	DNFBpgjKlW0/oonS5T3tETbFSNVAc1RTE5xz1ee2OAExdrecK/2C/u9e7aktmBIQ
	M1lbDUSARjCOgKt226SLup3TxD7k+0AZyiH4RNVsLn5l88gsRPehW1RUdhSJzK3J
	BFZ8LGkFxSjaNK0IqciaIJlIKM73vUxNf8C6Aj/lt8xnvHaEV3esiiGmlNjFRmRo
	+3TVE5NVp73BXPiGZXWA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v126m7ywe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 13:31:31 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8C93C10005F;
	Thu, 21 Dec 2023 13:31:29 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 820AA2747C5;
	Thu, 21 Dec 2023 13:31:29 +0100 (CET)
Received: from localhost (10.252.25.159) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Dec
 2023 13:31:27 +0100
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
Subject: [PATCH v1 8/8] arm64: dts: st: add display support on stm32mp257f-ev
Date: Thu, 21 Dec 2023 13:30:37 +0100
Message-ID: <20231221123037.418851-9-raphael.gallais-pou@foss.st.com>
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

This patch enables the following IPs on stm32mp257f-ev :
  * LTDC
  * LVDS
  * WSVGA LVDS panel (1024x600)
  * Panel backlight
  * Ilitek touchescreen

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 0ea8e69bfb3d..ca2da988d91c 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -29,6 +29,43 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x1 0x0>;
 	};
 
+	panel_lvds: panel-lvds {
+		compatible = "edt,etml0700z9ndha", "panel-lvds";
+		enable-gpios = <&gpiog 15 GPIO_ACTIVE_HIGH>;
+		backlight = <&panel_lvds_backlight>;
+		status = "okay";
+
+		width-mm = <156>;
+		height-mm = <92>;
+		data-mapping = "vesa-24";
+
+		panel-timing {
+			clock-frequency = <54000000>;
+			hactive = <1024>;
+			vactive = <600>;
+			hfront-porch = <150>;
+			hback-porch = <150>;
+			hsync-len = <21>;
+			vfront-porch = <24>;
+			vback-porch = <24>;
+			vsync-len = <21>;
+		};
+
+		port {
+			lvds_panel_in: endpoint {
+				remote-endpoint = <&lvds_out0>;
+			};
+		};
+	};
+
+	panel_lvds_backlight: panel-lvds-backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpioi 5 GPIO_ACTIVE_HIGH>;
+		default-on;
+		default-brightness-level = <0>;
+		status = "okay";
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -63,6 +100,15 @@ &i2c2 {
 	i2c-scl-falling-time-ns = <13>;
 	clock-frequency = <400000>;
 	status = "okay";
+
+	ili2511: ili2511@41 {
+		compatible = "ilitek,ili251x";
+		reg = <0x41>;
+		interrupt-parent = <&gpioi>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpiog 14 GPIO_ACTIVE_LOW>;
+		status = "okay";
+	};
 };
 
 &i2c8 {
@@ -75,6 +121,39 @@ &i2c8 {
 	status = "disabled";
 };
 
+&ltdc {
+	status = "okay";
+
+	port {
+		ltdc_ep0_out: endpoint {
+			remote-endpoint = <&lvds_in>;
+		};
+	};
+};
+
+&lvds {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			lvds_in: endpoint {
+				remote-endpoint = <&ltdc_ep0_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			lvds_out0: endpoint {
+				remote-endpoint = <&lvds_panel_in>;
+			};
+		};
+	};
+};
+
 &sdmmc1 {
 	pinctrl-names = "default", "opendrain", "sleep";
 	pinctrl-0 = <&sdmmc1_b4_pins_a>;
-- 
2.25.1


