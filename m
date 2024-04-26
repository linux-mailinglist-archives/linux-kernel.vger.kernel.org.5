Return-Path: <linux-kernel+bounces-160207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4A58B3A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F42286363
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A802149003;
	Fri, 26 Apr 2024 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CKOKiOlu"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5405824B3;
	Fri, 26 Apr 2024 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143994; cv=none; b=jU7xAi2aXTL+x/gCxQ1eX8uoGSs0v4yl4hwa7dDjdsoeuB4Om9zTBH33U23TQ6OLnw2WS6ODZej0oQKsP1BmmZgKjDnRYxw2Nop/3ia3uoOM+1rQTXDLxErVWw1e7GbhpxKwMVt37G354N3t/A5BX751GVPp5sVrds89hPuoa8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143994; c=relaxed/simple;
	bh=TDe1W95xQ4FIVIvV65yXftySxSZ025TIFy7MIrfyogs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rasMnbTYSYZHTiTRS/9PUPTmlSb3so2mNUzG3HamwqXicbkiPUcdsrzNcxxhq0ooGvjYpRKbmBrlinE0Ptor9QP1QD5tNRLMbupkDtCLDeduhqPgn+YioToEgdZ9Li6/kV//GDxYiyZlOdKDsZJM5z+9nCbr8H75mThFTUZtcjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CKOKiOlu; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QDJ35t019021;
	Fri, 26 Apr 2024 17:06:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=owWEwN3frvs+w7rBdunojYWbyC3afbJA5/c/F6xdxWc=; b=CK
	OKiOlutVwfegPcAx3xCXdMwZz2cxFUfxXyHWH2YCzSUL4SPr9nup4VJsswLryR83
	ztkvfYYauJewygP/6hGPISDpQ2u2w/fhQUjwFRaw/paah0541H/dhKNHKtr1Odtu
	1jgbmzwj0lku0BRXSLu0rQ5lTHRBtesSE7DzdHiro7cwdPSLgYVk/0DHwBp7d56+
	AMbd8iyRSZAN3BK452iELAZxOsv+EkAsRLNc5KWEnoJI0KnrJrgYEDTNORwIbReg
	GgJvAazdGEQPhUGQcCNZyRXQlQGckdPBvBrA0JNQv6D1ktSUobICH/VxPub5xDMy
	fNlZZRx5CWwq6Pmxfd3Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4cnu1xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 17:06:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 79A7440047;
	Fri, 26 Apr 2024 17:06:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 60EDB2207CF;
	Fri, 26 Apr 2024 17:05:47 +0200 (CEST)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 17:05:47 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Alain Volmat <alain.volmat@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ARM: dts: stm32: enable camera support on stm32mp135f-dk board
Date: Fri, 26 Apr 2024 17:05:25 +0200
Message-ID: <20240426150526.3094607-3-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426150526.3094607-1-alain.volmat@foss.st.com>
References: <20240426150526.3094607-1-alain.volmat@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02

On STM32MP135F-DK board the camera support is made of the
CSI based GC2145 sensor, connected to the ST-MIPID02 CSI to parallel
bridge, connected to the DCMIPP parallel input.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 87 +++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 567e53ad285f..e43bb9b74b87 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -29,6 +29,20 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	clocks {
+		clk_ext_camera: clk-ext-camera {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+
+		clk_mco1: clk-mco1 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+	};
+
 	memory@c0000000 {
 		device_type = "memory";
 		reg = <0xc0000000 0x20000000>;
@@ -141,6 +155,23 @@ &cryp {
 	status = "okay";
 };
 
+&dcmipp {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&dcmipp_pins_a>;
+	pinctrl-1 = <&dcmipp_sleep_pins_a>;
+	status = "okay";
+
+	port {
+		dcmipp_0: endpoint {
+			remote-endpoint = <&mipid02_2>;
+			bus-width = <8>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			pclk-sample = <0>;
+		};
+	};
+};
+
 &i2c1 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&i2c1_pins_a>;
@@ -201,6 +232,62 @@ &i2c5 {
 	/* spare dmas for other usage */
 	/delete-property/dmas;
 	/delete-property/dma-names;
+
+	stmipi: csi2rx@14 {
+		compatible = "st,st-mipid02";
+		reg = <0x14>;
+		clocks = <&clk_mco1>;
+		clock-names = "xclk";
+		VDDE-supply = <&scmi_v1v8_periph>;
+		VDDIN-supply = <&scmi_v1v8_periph>;
+		reset-gpios = <&mcp23017 2 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
+		status = "okay";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port@0 {
+				reg = <0>;
+
+				mipid02_0: endpoint {
+					data-lanes = <1 2>;
+					lane-polarities = <0 0 0>;
+					remote-endpoint = <&gc2145_ep>;
+				};
+			};
+			port@2 {
+				reg = <2>;
+
+				mipid02_2: endpoint {
+					bus-width = <8>;
+					hsync-active = <0>;
+					vsync-active = <0>;
+					pclk-sample = <0>;
+					remote-endpoint = <&dcmipp_0>;
+				};
+			};
+		};
+	};
+
+	gc2145: camera@3c {
+		compatible = "galaxycore,gc2145";
+		reg = <0x3c>;
+		clocks = <&clk_ext_camera>;
+		iovdd-supply = <&scmi_v3v3_sw>;
+		avdd-supply = <&scmi_v3v3_sw>;
+		dvdd-supply = <&scmi_v3v3_sw>;
+		powerdown-gpios = <&mcp23017 3 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
+		reset-gpios = <&mcp23017 4 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
+		status = "okay";
+
+		port {
+			gc2145_ep: endpoint {
+				remote-endpoint = <&mipid02_0>;
+				data-lanes = <1 2>;
+				link-frequencies = /bits/ 64 <120000000 192000000 240000000>;
+			};
+		};
+	};
 };
 
 &iwdg2 {
-- 
2.34.1


