Return-Path: <linux-kernel+bounces-32722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EB6835F66
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D556AB25EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFD43A1A5;
	Mon, 22 Jan 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbZgyd95"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0533A1DA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918771; cv=none; b=QB89pO3vhryGw+rJacr8uci/fOva9X+aYVigDdhJqczqDryOEX170CN7WEE2b8FT5cvJLrSOTC3CHZiSruwF/CmU4u6LI2ffr5zD9y0bKk1ZpMb0DVbOiOrD70cGxjzDKdv17KiJC+JczcEHscCkWndHmWwCwrDajUKpG3eOFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918771; c=relaxed/simple;
	bh=jPMlgnVeYY+dxb0TvxHoTA00byAx2ei2mHKSe9MWCcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DM61bhZWOYdABzZo+LqWSHp55nhRknS1oyIsxHyyc5noaJK4l3K0t4/CHsM9u1ypcFgn8qU3XTBZyqtfmyab9xasqpBYZBV+/i8fvTT3qvJzBLMVBAXEBOtqaGmgnqyx3qCQXk2PkrZlB3REzzbFqGpuhQ2YoXrC8OtfkVWwQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sbZgyd95; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso36678195e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705918766; x=1706523566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbJHWThGJqlTIE2Hfo1wIi0EMowUQIHASdcNxO5vK6A=;
        b=sbZgyd95alYDRmpDffKo3+c2y3Uw/DiZ2QomZQHqj+uKXxk8zFM75CQ/xukXCqsVN+
         wjD1SAhT3pDmjiHa6TvE8kWGpaOVwFiQM9Hnzh9BQis1dSFM+2EuzPIsq0CtGeUgK3/u
         ifPCXl+tboaHcwchX/5OOMKCC1d0+mxoxBqbKW37gIMivkSVXUlPSv/Of9SONWbrcybE
         JxhlGgUWGEXzLz9bjLEYMkhi0afucDn+r2g8c0XCBCrfJmNWLkOlFtMyDqCvRoCxghSa
         miuebaT9bL/KNpW288ugUMEsQzI3g4XpfzaynnvPg2KuxU/QzIwHPYCy0B7ThHQ0+hqE
         vefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918766; x=1706523566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbJHWThGJqlTIE2Hfo1wIi0EMowUQIHASdcNxO5vK6A=;
        b=MhnshqXDHq3QVmofux0dfJAvRte2c7+JhWf0K5s8DzaO1ACvNlT2fyaX7xo+pfptIK
         NA0M1EtlI6pyOr8ptWOOLGVzpvbjGAAK705jM8Rm8I1/HbiJdyoPMxjVv54uffDeY+Qx
         GPRwnYIzdcQ+OnEuWqkbNAdj185PJOOZ8y+r+orh4Rh48DRKnRZGHiD8Uv1zbrb/fpXo
         58IclmqCLQunOB3IrTYFRtv0XtlXiHoJDr3SLFBgY79FCI9cZzgLaPKKa68SX/IARj/g
         sV6dvSoVZ4n3XP7YWDOaKqGcNBotEtJhGoucBp/5swqq8iBzVmTw/8twYqJzFjdJdpnn
         M/Mw==
X-Gm-Message-State: AOJu0Yw57TbsfzmzucmmiezQemXII04EeHJD190oNLwAh5gJeUroZ/pt
	kMAZK1L27dKbIcG3tERY8H8YKhpKMPyGXNhYniYRo/Y7JipX7VEo2vn0PWJ5TOg=
X-Google-Smtp-Source: AGHT+IF1uF43i0rNpn68HlKPCbCJkEpJKQbfJGJIyD8/ADMnLYLNA5bO8kB1XK07o8kl8gadORYssQ==
X-Received: by 2002:a05:600c:8608:b0:40e:9ef9:8482 with SMTP id ha8-20020a05600c860800b0040e9ef98482mr1159357wmb.290.1705918765810;
        Mon, 22 Jan 2024 02:19:25 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q4-20020adfab04000000b00337d603fd01sm10396114wrc.66.2024.01.22.02.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:19:25 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 22 Jan 2024 11:19:20 +0100
Subject: [PATCH 2/2] arm64: dts: qcom: sm8550: add support for the
 SM8550-HDK board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-topic-sm8550-upstream-hdk8550-v1-2-bff7eb3a17eb@linaro.org>
References: <20240122-topic-sm8550-upstream-hdk8550-v1-0-bff7eb3a17eb@linaro.org>
In-Reply-To: <20240122-topic-sm8550-upstream-hdk8550-v1-0-bff7eb3a17eb@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=33425;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jPMlgnVeYY+dxb0TvxHoTA00byAx2ei2mHKSe9MWCcU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlrkEr3pDzzu/FTe0x+6SNSP5aLYTKEdPrKTEkJAUY
 E2zgoySJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZa5BKwAKCRB33NvayMhJ0YQYD/
 4hJWRmY5UYN9PYCmyBtoQSacPFjiOqGuWGW5nZD5drx2pm82jElK0IiruE/8rg3qdov7HD9r5tM/K9
 +YOi5cbKBhVvYyledTWVi/3EXWNicXGXH4qH37ZNlsg+5NsjEF3lkTWRa/Dxum/xT1K0xqBHu3UBwT
 YKuWjBXeIF7YPGXrdmxazY4he3ZVf8zb+BDH/LL9HpZ4XrIeRLCTS0XpFM2P3u9Kt5faiZdVR5tQGK
 zuymDigFNKeru95lLLjocYN0RTac94rK7vn2L7Auu9Aw8yGWhv1BvEUrvZC3q1JUW3OM2x8q6rY4GH
 3eFGmlVYE5WvA5gCAoyPu567JbhFYwX71GmqmlVtdS/UbrHwNYgkOBaN7CI8FqMNmfY23bs3wwHBhS
 sGQ8t5M1VJTzH/o4DcxtTsuDbuKzLIfQv+2VfB/lJkJsEHB8jO2ZtRb1zogp8pEiHMRxV9p4e702y4
 fnLe1JrnQ7KJjugtXRFE+Yrz4un/Jz1A7WATHyl2JFREHfD1qESirvEK9Tu1PLChGYtyrmc+TMAMux
 xXEd1SCYtQo+r3ZxmuaB3KKuuy+2pTiripCXBPcCWcHFFqDhDGlpvVHxbcwhFV6DIZghUcdCmEizH+
 3UCtkZNkLHVUHOA7rNNk+LqHz2N0rRIPYepQrZ1kUF9dSwMYGNisJeRNh73w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The SM8550-HDK is an embedded development platforms for the
Snapdragon 8 Gen 2 SoC aka SM8550, with the followwing features:
- Qualcomm SM8550 SoC
- 16GiB On-board LPDDR5
- On-board WiFi 7 + Bluetooth 5.3/BLE
- On-board UFS4.0
- M.2 Key B+M Gen3x2 PCIe Slot
- HDMI Output
- USB-C Connector with DP Almode & Audio Accessory mode
- Micro-SDCard Slot
- Audio Jack with Playback and Microphone
- 2 On-board Analog microphones
- 2 On-board Speakers
- 96Boards Compatible Low-Speed and High-Speed connectors [1]
  - For Camera, Sensors and external Display cards
  - Compatible with the Linaro Debug board [2]
- SIM Slot for Modem
- Debug connectors
- 6x On-Board LEDs

Product Page: [3]

[1] https://www.96boards.org/specifications/
[2] https://git.codelinaro.org/linaro/qcomlt/debugboard
[3] https://www.lantronix.com/products/snapdragon-8-gen-2-mobile-hardware-development-kit/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile       |    1 +
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts | 1291 +++++++++++++++++++++++++++++++
 2 files changed, 1292 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 39889d5f8e12..42e50f2b2ec3 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -233,6 +233,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx223.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-mtp.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
new file mode 100644
index 000000000000..5a4813388172
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -0,0 +1,1291 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2024 Linaro Limited
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "sm8550.dtsi"
+#include "pm8010.dtsi"
+#include "pm8550.dtsi"
+#include "pm8550b.dtsi"
+#define PMK8550VE_SID 5
+#include "pm8550ve.dtsi"
+#include "pm8550vs.dtsi"
+#include "pmk8550.dtsi"
+#include "pmr735d_a.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. SM8550 HDK";
+	compatible = "qcom,sm8550-hdk", "qcom,sm8550";
+	chassis-type = "embedded";
+
+	aliases {
+		serial0 = &uart7;
+		serial1 = &uart14;
+	};
+
+	wcd938x: audio-codec {
+		compatible = "qcom,wcd9385-codec";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wcd_default>;
+
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+
+		reset-gpios = <&tlmm 108 GPIO_ACTIVE_LOW>;
+
+		vdd-buck-supply = <&vreg_l15b_1p8>;
+		vdd-rxtx-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l15b_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob1>;
+
+		#sound-dai-cells = <1>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_out: endpoint {
+				remote-endpoint = <&lt9611_out>;
+			};
+		};
+	};
+
+	vreg_bob_3v3: vreg-bob-3v3-regulator {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_BOB_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		vin-supply = <&vph_pwr>;
+	};
+
+	lt9611_1v2: lt9611-vdd12-regulator {
+		compatible = "regulator-fixed";
+
+		regulator-name = "LT9611_1V2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+
+		vin-supply = <&vph_pwr>;
+		gpio = <&tlmm 152 GPIO_ACTIVE_HIGH>;
+
+		enable-active-high;
+	};
+
+	lt9611_3v3: lt9611-3v3-regulator {
+		compatible = "regulator-fixed";
+
+		regulator-name = "LT9611_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		vin-supply = <&vreg_bob_3v3>;
+		gpio = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+
+		enable-active-high;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&volume_up_n>;
+		pinctrl-names = "default";
+
+		key-volume-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm8550_gpios 6 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			function = LED_FUNCTION_BLUETOOTH;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&tlmm 159 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "bluetooth-power";
+			default-state = "off";
+		};
+
+		led-1 {
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&tlmm 160 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			panic-indicator;
+		};
+
+		led-2 {
+			function = LED_FUNCTION_WLAN;
+			color = <LED_COLOR_ID_ORANGE>;
+			gpios = <&tlmm 162 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+	};
+
+	pmic-glink {
+		compatible = "qcom,sm8550-pmic-glink", "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		orientation-gpios = <&tlmm 11 GPIO_ACTIVE_HIGH>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss_in: endpoint {
+						remote-endpoint = <&usb_dp_qmpphy_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_sbu: endpoint {
+						remote-endpoint = <&fsa4480_sbu_mux>;
+					};
+				};
+			};
+		};
+	};
+
+	sound {
+		compatible = "qcom,sm8550-sndcard", "qcom,sm8450-sndcard";
+		model = "SM8550-HDK";
+		audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
+				"SpkrRight IN", "WSA_SPK2 OUT",
+				"IN1_HPHL", "HPHL_OUT",
+				"IN2_HPHR", "HPHR_OUT",
+				"AMIC1", "MIC BIAS1",
+				"AMIC2", "MIC BIAS2",
+				"AMIC5", "MIC BIAS4",
+				"TX SWR_ADC0", "ADC1_OUTPUT",
+				"TX SWR_ADC1", "ADC2_OUTPUT",
+				"TX SWR_ADC3", "ADC4_OUTPUT";
+
+
+		wcd-playback-dai-link {
+			link-name = "WCD Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&wcd938x 0>, <&swr1 0>, <&lpass_rxmacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		wcd-capture-dai-link {
+			link-name = "WCD Capture";
+
+			cpu {
+				sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
+			};
+
+			codec {
+				sound-dai = <&wcd938x 1>, <&swr2 0>, <&lpass_txmacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		wsa-dai-link {
+			link-name = "WSA Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&north_spkr>, <&south_spkr>, <&swr0 0>, <&lpass_wsamacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		va-dai-link {
+			link-name = "VA Capture";
+
+			cpu {
+				sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
+			};
+
+			codec {
+				sound-dai = <&lpass_vamacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm8550-rpmh-regulators";
+
+		vdd-bob1-supply = <&vph_pwr>;
+		vdd-bob2-supply = <&vph_pwr>;
+		vdd-l1-l4-l10-supply = <&vreg_s6g_1p86>;
+		vdd-l2-l13-l14-supply = <&vreg_bob1>;
+		vdd-l3-supply = <&vreg_s4g_1p25>;
+		vdd-l5-l16-supply = <&vreg_bob1>;
+		vdd-l6-l7-supply = <&vreg_bob1>;
+		vdd-l8-l9-supply = <&vreg_bob1>;
+		vdd-l11-supply = <&vreg_s4g_1p25>;
+		vdd-l12-supply = <&vreg_s6g_1p86>;
+		vdd-l15-supply = <&vreg_s6g_1p86>;
+		vdd-l17-supply = <&vreg_bob2>;
+
+		qcom,pmic-id = "b";
+
+		vreg_bob1: bob1 {
+			regulator-name = "vreg_bob1";
+			regulator-min-microvolt = <3296000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_bob2: bob2 {
+			regulator-name = "vreg_bob2";
+			regulator-min-microvolt = <2720000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1b_1p8: ldo1 {
+			regulator-name = "vreg_l1b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2b_3p0: ldo2 {
+			regulator-name = "vreg_l2b_3p0";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5b_3p1: ldo5 {
+			regulator-name = "vreg_l5b_3p1";
+			regulator-min-microvolt = <3104000>;
+			regulator-max-microvolt = <3104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6b_1p8: ldo6 {
+			regulator-name = "vreg_l6b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7b_1p8: ldo7 {
+			regulator-name = "vreg_l7b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8b_1p8: ldo8 {
+			regulator-name = "vreg_l8b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9b_2p9: ldo9 {
+			regulator-name = "vreg_l9b_2p9";
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11b_1p2: ldo11 {
+			regulator-name = "vreg_l11b_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12b_1p8: ldo12 {
+			regulator-name = "vreg_l12b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13b_3p0: ldo13 {
+			regulator-name = "vreg_l13b_3p0";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l14b_3p2: ldo14 {
+			regulator-name = "vreg_l14b_3p2";
+			regulator-min-microvolt = <3200000>;
+			regulator-max-microvolt = <3200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15b_1p8: ldo15 {
+			regulator-name = "vreg_l15b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16b_2p8: ldo16 {
+			regulator-name = "vreg_l16b_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17b_2p5: ldo17 {
+			regulator-name = "vreg_l17b_2p5";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+
+		vdd-l1-supply = <&vreg_s4g_1p25>;
+		vdd-l2-supply = <&vreg_s4e_0p95>;
+		vdd-l3-supply = <&vreg_s4e_0p95>;
+
+		qcom,pmic-id = "c";
+
+		vreg_l3c_0p9: ldo3 {
+			regulator-name = "vreg_l3c_0p9";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-2 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+
+		vdd-l1-supply = <&vreg_s4e_0p95>;
+		vdd-l2-supply = <&vreg_s4e_0p95>;
+		vdd-l3-supply = <&vreg_s4e_0p95>;
+
+		qcom,pmic-id = "d";
+
+		vreg_l1d_0p88: ldo1 {
+			regulator-name = "vreg_l1d_0p88";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		/* ldo2 supplies SM8550 VDD_LPI_MX */
+	};
+
+	regulators-3 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+
+		vdd-l1-supply = <&vreg_s4e_0p95>;
+		vdd-l2-supply = <&vreg_s4e_0p95>;
+		vdd-l3-supply = <&vreg_s4g_1p25>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+
+		qcom,pmic-id = "e";
+
+		vreg_s4e_0p95: smps4 {
+			regulator-name = "vreg_s4e_0p95";
+			regulator-min-microvolt = <904000>;
+			regulator-max-microvolt = <984000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s5e_1p08: smps5 {
+			regulator-name = "vreg_s5e_1p08";
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1120000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1e_0p88: ldo1 {
+			regulator-name = "vreg_l1e_0p88";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2e_0p9: ldo2 {
+			regulator-name = "vreg_l2e_0p9";
+			regulator-min-microvolt = <904000>;
+			regulator-max-microvolt = <970000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3e_1p2: ldo3 {
+			regulator-name = "vreg_l3e_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-4 {
+		compatible = "qcom,pm8550ve-rpmh-regulators";
+
+		vdd-l1-supply = <&vreg_s4e_0p95>;
+		vdd-l2-supply = <&vreg_s4e_0p95>;
+		vdd-l3-supply = <&vreg_s4e_0p95>;
+		vdd-s4-supply = <&vph_pwr>;
+
+		qcom,pmic-id = "f";
+
+		vreg_s4f_0p5: smps4 {
+			regulator-name = "vreg_s4f_0p5";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <700000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1f_0p9: ldo1 {
+			regulator-name = "vreg_l1f_0p9";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2f_0p88: ldo2 {
+			regulator-name = "vreg_l2f_0p88";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3f_0p88: ldo3 {
+			regulator-name = "vreg_l3f_0p88";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-5 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+
+		vdd-l1-supply = <&vreg_s4g_1p25>;
+		vdd-l2-supply = <&vreg_s4g_1p25>;
+		vdd-l3-supply = <&vreg_s4g_1p25>;
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+
+		qcom,pmic-id = "g";
+
+		vreg_s1g_1p25: smps1 {
+			regulator-name = "vreg_s1g_1p25";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s2g_0p85: smps2 {
+			regulator-name = "vreg_s2g_0p85";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s3g_0p8: smps3 {
+			regulator-name = "vreg_s3g_0p8";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1004000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s4g_1p25: smps4 {
+			regulator-name = "vreg_s4g_1p25";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1352000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s5g_0p85: smps5 {
+			regulator-name = "vreg_s5g_0p85";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1004000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s6g_1p86: smps6 {
+			regulator-name = "vreg_s6g_1p86";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1g_1p2: ldo1 {
+			regulator-name = "vreg_l1g_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3g_1p2: ldo3 {
+			regulator-name = "vreg_l3g_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-6 {
+		compatible = "qcom,pm8010-rpmh-regulators";
+
+		vdd-l1-l2-supply = <&vreg_s4g_1p25>;
+		vdd-l3-l4-supply = <&vreg_bob2>;
+		vdd-l5-supply = <&vreg_s6g_1p86>;
+		vdd-l6-supply = <&vreg_s6g_1p86>;
+		vdd-l7-supply = <&vreg_bob1>;
+
+		qcom,pmic-id = "m";
+
+		vreg_l1m_1p056: ldo1 {
+			regulator-name = "vreg_l1m_1p056";
+			regulator-min-microvolt = <1056000>;
+			regulator-max-microvolt = <1056000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2m_1p056: ldo2 {
+			regulator-name = "vreg_l2m_1p056";
+			regulator-min-microvolt = <1056000>;
+			regulator-max-microvolt = <1056000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3m_2p8: ldo3 {
+			regulator-name = "vreg_l3m_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4m_2p8: ldo4 {
+			regulator-name = "vreg_l4m_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5m_1p8: ldo5 {
+			regulator-name = "vreg_l5m_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6m_1p8: ldo6 {
+			regulator-name = "vreg_l6m_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7m_2p9: ldo7 {
+			regulator-name = "vreg_l7m_2p9";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2904000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-7 {
+		compatible = "qcom,pm8010-rpmh-regulators";
+
+		vdd-l1-l2-supply = <&vreg_s4g_1p25>;
+		vdd-l3-l4-supply = <&vreg_bob2>;
+		vdd-l5-supply = <&vreg_s6g_1p86>;
+		vdd-l6-supply = <&vreg_bob1>;
+		vdd-l7-supply = <&vreg_bob1>;
+
+		qcom,pmic-id = "n";
+
+		vreg_l1n_1p1: ldo1 {
+			regulator-name = "vreg_l1n_1p1";
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2n_1p1: ldo2 {
+			regulator-name = "vreg_l2n_1p1";
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3n_2p8: ldo3 {
+			regulator-name = "vreg_l3n_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4n_2p8: ldo4 {
+			regulator-name = "vreg_l4n_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5n_1p8: ldo5 {
+			regulator-name = "vreg_l5n_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6n_3p3: ldo6 {
+			regulator-name = "vreg_l6n_3p3";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7n_2p96: ldo7 {
+			regulator-name = "vreg_l7n_2p96";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&i2c_master_hub_0 {
+	status = "okay";
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	lt9611_codec: hdmi-bridge@2b {
+		compatible = "lontium,lt9611uxc";
+		reg = <0x2b>;
+
+		interrupts-extended = <&tlmm 8 IRQ_TYPE_EDGE_FALLING>;
+
+		reset-gpios = <&tlmm 7 GPIO_ACTIVE_HIGH>;
+
+		vdd-supply = <&lt9611_1v2>;
+		vcc-supply = <&lt9611_3v3>;
+
+		pinctrl-0 = <&lt9611_irq_pin>, <&lt9611_rst_pin>;
+		pinctrl-names = "default";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lt9611_a: endpoint {
+					remote-endpoint = <&mdss_dsi0_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				lt9611_out: endpoint {
+					remote-endpoint = <&hdmi_connector_out>;
+				};
+			};
+		};
+	};
+};
+
+&i2c_hub_2 {
+	status = "okay";
+
+	typec-mux@42 {
+		compatible = "fcs,fsa4480";
+		reg = <0x42>;
+
+		vcc-supply = <&vreg_bob1>;
+
+		mode-switch;
+		orientation-switch;
+
+		port {
+			fsa4480_sbu_mux: endpoint {
+				remote-endpoint = <&pmic_glink_sbu>;
+			};
+		};
+	};
+};
+
+&ipa {
+	qcom,gsi-loader = "self";
+	memory-region = <&ipa_fw_mem>;
+	firmware-name = "qcom/sm8550/ipa_fws.mbn";
+	status = "okay";
+};
+
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/sm8550/a740_zap.mbn";
+	};
+};
+
+&lpass_tlmm {
+	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
+		pins = "gpio17";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+
+	spkr_2_sd_n_active: spkr-2-sd-n-active-state {
+		pins = "gpio18";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l3e_1p2>;
+	status = "okay";
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&lt9611_a>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l1e_0p88>;
+	status = "okay";
+};
+
+&mdss_dp0 {
+	status = "okay";
+};
+
+&mdss_dp0_out {
+	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
+	data-lanes = <0 1>;
+};
+
+&pcie0 {
+	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+
+	pinctrl-0 = <&pcie0_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l1e_0p88>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
+&pcie1 {
+	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+	perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+
+	pinctrl-0 = <&pcie1_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l3c_0p9>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+	vdda-qref-supply = <&vreg_l1e_0p88>;
+
+	status = "okay";
+};
+
+&pm8550_gpios {
+	sdc2_card_det_n: sdc2-card-det-state {
+		pins = "gpio12";
+		function = "normal";
+		input-enable;
+		output-disable;
+		bias-pull-up;
+		power-source = <1>; /* 1.8 V */
+	};
+
+	volume_up_n: volume-up-n-state {
+		pins = "gpio6";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+/* The RGB signals are routed to 3 separate LEDs on the HDK8550 */
+&pm8550_pwm {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	status = "okay";
+
+	led@1 {
+		reg = <1>;
+		function = LED_FUNCTION_STATUS;
+		color = <LED_COLOR_ID_RED>;
+		default-state = "off";
+	};
+
+	led@2 {
+		reg = <2>;
+		function = LED_FUNCTION_STATUS;
+		color = <LED_COLOR_ID_GREEN>;
+		default-state = "off";
+	};
+
+	led@3 {
+		reg = <3>;
+		function = LED_FUNCTION_STATUS;
+		color = <LED_COLOR_ID_BLUE>;
+		default-state = "off";
+	};
+};
+
+&pm8550b_eusb2_repeater {
+	vdd18-supply = <&vreg_l15b_1p8>;
+	vdd3-supply = <&vreg_l5b_3p1>;
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+
+	status = "okay";
+};
+
+&pcie_1_phy_aux_clk {
+	clock-frequency = <1000>;
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/sm8550/adsp.mbn",
+			"qcom/sm8550/adsp_dtb.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm8550/cdsp.mbn",
+			"qcom/sm8550/cdsp_dtb.mbn";
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sm8550/modem.mbn",
+			"qcom/sm8550/modem_dtb.mbn";
+	status = "okay";
+};
+
+&sdhc_2 {
+	cd-gpios = <&pm8550_gpios 12 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&sdc2_default>, <&sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep>, <&sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
+	vmmc-supply = <&vreg_l9b_2p9>;
+	vqmmc-supply = <&vreg_l8b_1p8>;
+
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+
+	status = "okay";
+};
+
+&sleep_clk {
+	clock-frequency = <32000>;
+};
+
+&swr0 {
+	status = "okay";
+
+	/* WSA8845, Speaker North */
+	north_spkr: speaker@0,0 {
+		compatible = "sdw20217020400";
+		reg = <0 0>;
+
+		pinctrl-0 = <&spkr_1_sd_n_active>;
+		pinctrl-names = "default";
+
+		powerdown-gpios = <&lpass_tlmm 17 GPIO_ACTIVE_LOW>;
+
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l15b_1p8>;
+
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrLeft";
+	};
+
+	/* WSA8845, Speaker South */
+	south_spkr: speaker@0,1 {
+		compatible = "sdw20217020400";
+		reg = <0 1>;
+
+		pinctrl-0 = <&spkr_2_sd_n_active>;
+		pinctrl-names = "default";
+
+		powerdown-gpios = <&lpass_tlmm 18 GPIO_ACTIVE_LOW>;
+
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l15b_1p8>;
+
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrRight";
+	};
+};
+
+&swr1 {
+	status = "okay";
+
+	/* WCD9385 RX */
+	wcd_rx: codec@0,4 {
+		compatible = "sdw20217010d00";
+		reg = <0 4>;
+
+		qcom,rx-port-mapping = <1 2 3 4 5>;
+	};
+};
+
+&swr2 {
+	status = "okay";
+
+	/* WCD9385 TX */
+	wcd_tx: codec@0,3 {
+		compatible = "sdw20217010d00";
+		reg = <0 3>;
+
+		qcom,tx-port-mapping = <1 1 2 3>;
+	};
+};
+
+&tlmm {
+	/* Reserved I/Os for NFC */
+	gpio-reserved-ranges = <32 8>;
+
+	bt_default: bt-default-state {
+		bt-en-pins {
+			pins = "gpio81";
+			function = "gpio";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		sw-ctrl-pins {
+			pins = "gpio82";
+			function = "gpio";
+			bias-pull-down;
+		};
+	};
+
+	lt9611_irq_pin: lt9611-irq-state {
+		pins = "gpio8";
+		function = "gpio";
+		bias-disable;
+	};
+
+	lt9611_rst_pin: lt9611-rst-state {
+		pins = "gpio7";
+		function = "gpio";
+		output-high;
+	};
+
+	wcd_default: wcd-reset-n-active-state {
+		pins = "gpio108";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+};
+
+&uart7 {
+	status = "okay";
+};
+
+&uart14 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn7850-bt";
+
+		vddio-supply = <&vreg_l15b_1p8>;
+		vddaon-supply = <&vreg_s4e_0p95>;
+		vdddig-supply = <&vreg_s4e_0p95>;
+		vddrfa0p8-supply = <&vreg_s4e_0p95>;
+		vddrfa1p2-supply = <&vreg_s4g_1p25>;
+		vddrfa1p9-supply = <&vreg_s6g_1p86>;
+
+		max-speed = <3200000>;
+
+		enable-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 82 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&bt_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l17b_2p5>;
+	vcc-max-microamp = <1300000>;
+	vccq-supply = <&vreg_l1g_1p2>;
+	vccq-max-microamp = <1200000>;
+	vdd-hba-supply = <&vreg_l3g_1p2>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l1d_0p88>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "otg";
+	usb-role-switch;
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
+};
+
+&usb_1_dwc3_ss {
+	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
+};
+
+&usb_1_hsphy {
+	vdd-supply = <&vreg_l1e_0p88>;
+	vdda12-supply = <&vreg_l3e_1p2>;
+
+	phys = <&pm8550b_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_dp_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l3f_0p88>;
+
+	orientation-switch;
+
+	status = "okay";
+};
+
+&usb_dp_qmpphy_dp_in {
+	remote-endpoint = <&mdss_dp0_out>;
+};
+
+&usb_dp_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in>;
+};
+
+&usb_dp_qmpphy_usb_ss_in {
+	remote-endpoint = <&usb_1_dwc3_ss>;
+};
+
+&xo_board {
+	clock-frequency = <76800000>;
+};

-- 
2.34.1


