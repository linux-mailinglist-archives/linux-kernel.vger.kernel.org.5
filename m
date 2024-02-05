Return-Path: <linux-kernel+bounces-52259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14226849606
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FDD1F21C2A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F5614013;
	Mon,  5 Feb 2024 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="f9zdSFop"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215AF13FF9;
	Mon,  5 Feb 2024 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124065; cv=none; b=UntUbFxusxiN8erpzS9ndXz0oxO1Vk0UOrEQZ8DT1X+mYUgWksS6vpVE+YtGzVpMtZ7dRGgEmmCCF2Yl6GSVk8OJFOBTBQri0JjGJKrP/WVu7w0Hlmn4GlwMJNJtFGUVNZwxU43vVOthn63x9ijRzbe6azQ2Q2rCPkmsHcN2oC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124065; c=relaxed/simple;
	bh=qpGVHez+xUG/R77lNrUzwGXEWMO51jugJxa+2R716VM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=i921669EJoqCn7/ACGWDNnrLCRro90gwYAkSCxAWAXnKOTUvMwR2v4IzYHUF0gcfswe+UUcoVELyrQBrVy9Y3oGUlUsCklLanAyiAuctd08tgTd1vpR9r+ytlvSvCh4MwUs74zxJqMNS8LiX8Ay7DYpVq4tsTt38Vp2daxszkWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=f9zdSFop; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4158JfUX017463;
	Mon, 5 Feb 2024 10:06:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=selector1; bh=44uxu8CEcvShH8eLpIXKggO7bIejdghXxS3SHpQ45mI
	=; b=f9zdSFopbtmju7LlaOMH1voM0rCRgE9CWBE0hAhfarxeCou2koEwuR9vcWn
	XdzmoyINHKyqOHiOzl4qw9yhQadbIo2UZ2+RTBbqZEysONod0T5tNaPsu7J1ZlxZ
	JsZWc7lCw79d4s44vT1q1Uqv1l4Oryt3V+l+dUfY7u+fKPLQ+Y5+cJ+CagviULL5
	43/d4vu/3Kg0/kAJgMKqSoQ2ykUpgP2yBDIbnMKV2c/SShTQBWQ4vrdhpK7AK5ne
	g/hklPSQBpD1Hd7RWaZVRNH3Q8XTw0Xwon8YspvfbXrtPIbRawGyJBBtCZZXaFLL
	gUomezCy1xUmFmIfW8tc563650A==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w1eyp60ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 10:06:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B056F100061;
	Mon,  5 Feb 2024 10:06:54 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A6C8829E60D;
	Mon,  5 Feb 2024 10:06:54 +0100 (CET)
Received: from localhost (10.252.18.216) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 5 Feb
 2024 10:06:54 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Mon, 5 Feb 2024 10:06:53 +0100
Subject: [PATCH 3/5] ARM: dts: stm32: enable display support on
 stm32mp135f-dk board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-ltdc_mp13-v1-3-072d24bf1b36@foss.st.com>
References: <20240205-ltdc_mp13-v1-0-072d24bf1b36@foss.st.com>
In-Reply-To: <20240205-ltdc_mp13-v1-0-072d24bf1b36@foss.st.com>
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
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_04,2024-01-31_01,2023-05-22_02

Link panel and display controller.
Enable panel, backlight and display controller.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 55 +++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index eea740d097c7..4a52d314c46d 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -66,6 +66,48 @@ led-blue {
 			default-state = "off";
 		};
 	};
+
+	panel_backlight: panel-backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpioe 12 GPIO_ACTIVE_HIGH>;
+		default-on;
+		default-brightness-level = <0>;
+		status = "okay";
+	};
+
+	panel_rgb: panel-rgb {
+		compatible = "rocktech,rk043fn48h", "panel-dpi";
+		enable-gpios = <&gpioi 7 GPIO_ACTIVE_HIGH>;
+		backlight = <&panel_backlight>;
+		power-supply = <&scmi_v3v3_sw>;
+		data-mapping = "bgr666";
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
@@ -160,6 +202,19 @@ &iwdg2 {
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


