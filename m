Return-Path: <linux-kernel+bounces-78303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466C58611A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EDA8B218D2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDB87E579;
	Fri, 23 Feb 2024 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Yg1oWazS"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B053365;
	Fri, 23 Feb 2024 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691940; cv=none; b=hk+OaJW6AGrHbQXwxvnfFBdRaaEvGQfrKItmVKVUOGWt0LcshKA70OIlffUec4iLQTesQpukqhBAQGeOOqEcL+UA/X9DKGgJvP8L5mWwu5qoHOGHHDADw9lGN//vZ7W04PTV3LbMUtfXy5tRU8VnzZ8fnUVmSxWczXz/gFJKIzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691940; c=relaxed/simple;
	bh=8hy1sz1BHapHdaS5nPZrmROYuJbQJZ76RnTZlNCPW+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ihe+fowLFNYnmVToNumfQbZwr97dYl27/Iq99/AIlS008qAbNS4D08IBH0ky+HAIjHA0gBIrjzsz8IsbkWWJXB+45AHSZwKKO+NvI8718Vl2H7wmVcSrM5e2AZCye6lO8coNDiB3e8lwXwEBYTdjeDxvSyVsf5smaOIYUZI8PBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Yg1oWazS; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NAZHt5028218;
	Fri, 23 Feb 2024 13:38:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=selector1; bh=Dn4f3GfvCGhg9NuA1T7NEVx1XeeRBh/2a8fH4stLPtw
	=; b=Yg1oWazSP7Ff195paEYAmoqsIkbL8K+wa4GJgHEmXzVn59rrnrhFeaqS7fF
	Tp86iwEMoH5Ln2FjhVOaoe25BBbZKkDID+kbO8/U4qnrG4JZZuUXQANOfDActWMF
	9rwq8L2XD6sgyQ5TUHWYfSxIQZGKwI3l4NXv8PmnTgq85egfub8+eoKUETq0PSHY
	TBaDN00sYvLBjwq9vay3yls3ellXDn8qdZCKh2ZhY5NhEhOOcn9QGHqN0MnuTLoD
	oyjrxYR/YEZ437GFE9eyxPn1S7Elq3rgm7tzFirukh/8FmeVLZA7inCjwkb+squm
	ciE88MG9cDUnkzwWnUfXA5DIK2Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wesr88fdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 13:38:10 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 575364002D;
	Fri, 23 Feb 2024 13:38:01 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5E76728DDB8;
	Fri, 23 Feb 2024 13:36:54 +0100 (CET)
Received: from localhost (10.129.178.151) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 23 Feb
 2024 13:36:54 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Fri, 23 Feb 2024 13:36:50 +0100
Subject: [PATCH v3 3/4] ARM: dts: stm32: enable display support on
 stm32mp135f-dk board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240223-ltdc_mp13-v3-3-7f92a59ca11f@foss.st.com>
References: <20240223-ltdc_mp13-v3-0-7f92a59ca11f@foss.st.com>
In-Reply-To: <20240223-ltdc_mp13-v3-0-7f92a59ca11f@foss.st.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02

Link panel and display controller.
Enable panel, backlight and display controller.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

---
Changes in v2:
  - Fixed dtbs_check warnings :
arch/arm/boot/dts/st/stm32mp135f-dk.dtb: panel-backlight: 'default-brightness-level' does not match any of the regexes: 'pinctrl-[0-9]+'
  from schema $id: http://devicetree.org/schemas/leds/backlight/gpio-backlight.yaml#
arch/arm/boot/dts/st/stm32mp135f-dk.dtb: panel-rgb: data-mapping:0: 'bgr666' is not one of ['jeida-18', 'jeida-24', 'vesa-24']
  from schema $id: http://devicetree.org/schemas/display/panel/panel-simple.yaml#
arch/arm/boot/dts/st/stm32mp135f-dk.dtb: panel-rgb: compatible: ['rocktech,rk043fn48h', 'panel-dpi'] is too long
  from schema $id: http://devicetree.org/schemas/display/panel/panel-simple.yaml#
arch/arm/boot/dts/st/stm32mp135f-dk.dtb: panel-rgb: data-mapping: False schema does not allow ['bgr666']
  from schema $id: http://devicetree.org/schemas/display/panel/panel-simple.yaml#
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 53 +++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index eea740d097c7..c918f332cbfd 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -66,6 +66,46 @@ led-blue {
 			default-state = "off";
 		};
 	};
+
+	panel_backlight: panel-backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpioe 12 GPIO_ACTIVE_HIGH>;
+		default-on;
+		status = "okay";
+	};
+
+	panel_rgb: panel-rgb {
+		compatible = "rocktech,rk043fn48h";
+		enable-gpios = <&gpioi 7 GPIO_ACTIVE_HIGH>;
+		backlight = <&panel_backlight>;
+		power-supply = <&scmi_v3v3_sw>;
+		status = "okay";
+
+		width-mm = <105>;
+		height-mm = <67>;
+
+		panel-timing {
+			clock-frequency = <10000000>;
+			hactive = <480>;
+			hback-porch = <43>;
+			hfront-porch = <10>;
+			hsync-len = <1>;
+			hsync-active = <0>;
+			vactive = <272>;
+			vback-porch = <26>;
+			vfront-porch = <4>;
+			vsync-len = <10>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+
+		port {
+			panel_in_rgb: endpoint {
+				remote-endpoint = <&ltdc_out_rgb>;
+			};
+		};
+	};
 };
 
 &adc_1 {
@@ -160,6 +200,19 @@ &iwdg2 {
 	status = "okay";
 };
 
+&ltdc {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&ltdc_pins_a>;
+	pinctrl-1 = <&ltdc_sleep_pins_a>;
+	status = "okay";
+
+	port {
+		ltdc_out_rgb: endpoint {
+			remote-endpoint = <&panel_in_rgb>;
+		};
+	};
+};
+
 &rtc {
 	status = "okay";
 };

-- 
2.25.1


