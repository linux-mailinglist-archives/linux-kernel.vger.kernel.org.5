Return-Path: <linux-kernel+bounces-116831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCB488A3AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01B21C3A749
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09B61B630F;
	Mon, 25 Mar 2024 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="upm0HtrL"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D164A13FD8E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362410; cv=none; b=r7ALeKP/V11qpQSH5As2uvge9kMgmrhM5xIhCi72xNlzUECBCGA0x7kj7+1/JGBYT85/56mLD1IP7Jh+7Gu2FmAAtQegWihyiC7WDMigZcu9htFvKyrtdZgkvIZ9r4TzKSik9uQlpriEywis37aIhcJyvNwa3gsIVgEgzFXSiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362410; c=relaxed/simple;
	bh=utb8MlR+QRUd2Cb9KlQ/9bxS0H2RPGqz/yXGE5NsQIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tLrVSZCFjOPUXIeY6FdbhTxOa84GAZJi6Fct1q9zdn32uVG0+zHrmlTypo1yfCat+AOGh44zqkWSwA/DBkFXMtrvMlCuRP5ugkRGpi/ZsctnJZWRztEXIHUcRypg2IpomTjQiyHY3lTBvBc3oyaEcQnaxnA5tQfz8JbDrXXvDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=upm0HtrL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4148c04396dso895115e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711362406; x=1711967206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lm/wNR2WGm8TRk11z3YnZcAFN1nrtcSK2+8wIHeeHn4=;
        b=upm0HtrLEO2V2ZUgqce+80q8RcIYxDLT+PmmqnD4qwGbQRiJ5H0eu59hfm7nA93Jzr
         lvb4ppgxDWAwnrg9i0aGqqBP+fb+ih9/q7xhkn1vrpAlnyZ/8d/5GQ0+dfY6EL33gB/6
         PTDehY4diFeG/2nVln6+SkuANrWUMZJkU7rXyUXGaEIiTIDflnBIDyx07WiuyD5va3ds
         mvTMltIzljcWJ4cXNN5KTY8HbtZleUJnPyTC1rhfOALltgfTWcqmGNwzoLWGiDmC0NsC
         GGMoMYllic5tobqA5GdEQ7Us48nnxxqmrUX9P/v4f0NZ48mH09XFFmA6Gjo7zRmqnqYh
         AVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711362406; x=1711967206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lm/wNR2WGm8TRk11z3YnZcAFN1nrtcSK2+8wIHeeHn4=;
        b=fPas3NRCcJCyxOATA7a+15LZUG+ONgtpl2UsoORaWlNduBvy9GVTcUoAtVIsXqTt+7
         UrlrZHSDL+IyiMgt1WVW5Xh422Qvz2xmnraCJWvzjOv3giBQTapOhlFC9koLgkvHaFl5
         fMIB6UVuCDqjW1ExQ0OE738x6hiO8heq+qhzSbuz0iMchAHEQzLQM14Yl4a0c1D5Pvxa
         j2G2mi+WfVBWcr9vvcntKZfCg0Gn9rxSVZ6Ggg1neNY9l6ccLE2okXZ2zNFLdBqhRj1Q
         +Ku0bNRst0suNFbAqVzmhdkJj15d8nuE7x2zM70i+FuowGQSgLzq33bqyS27bkk4FfA+
         xLfg==
X-Forwarded-Encrypted: i=1; AJvYcCUgnKCaJDlPqXzOzSe84gbWLxGUCFNL6QYnzQJlbpkG/khW9WxNb+brC+7Bl9UHb7GGO7R/RRNMY81JZtah2AR2yc9urrdmab5CaMn5
X-Gm-Message-State: AOJu0Yyo5MORolm1B5XP0gAMPSSRQU6p2KNvSbGxFmXPydRhMfz6pNMq
	Y50OOJSHvwx4d1f9MV6vMh8H9tKVDvN2F+XaNiwjHfcBOSnN/Ii2e89AVg77upo=
X-Google-Smtp-Source: AGHT+IHBDYaEdbVHCjLEtLcXsvxoyEvFzAkWCS+AGDdf1qteezZmG4Yo4ZjwyI1mS12kK4C7lLn7Rg==
X-Received: by 2002:a05:600c:3514:b0:414:6ee:a37e with SMTP id h20-20020a05600c351400b0041406eea37emr4176268wmq.19.1711362406119;
        Mon, 25 Mar 2024 03:26:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id jg24-20020a05600ca01800b0041489884a98sm2899023wmb.6.2024.03.25.03.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:26:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Mar 2024 11:26:38 +0100
Subject: [PATCH v3 2/3] arm64: dts: qcom: sm8650: add support for the
 SM8650-HDK board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-topic-sm8650-upstream-hdk-v3-2-4f365d7932af@linaro.org>
References: <20240325-topic-sm8650-upstream-hdk-v3-0-4f365d7932af@linaro.org>
In-Reply-To: <20240325-topic-sm8650-upstream-hdk-v3-0-4f365d7932af@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=32867;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=utb8MlR+QRUd2Cb9KlQ/9bxS0H2RPGqz/yXGE5NsQIY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmAVFixw7yxl8ZNpfeQ1yGJBWme3Z7PwOpdtp22pQu
 XU4PxcCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZgFRYgAKCRB33NvayMhJ0VzlEA
 DI1pITfdQxdhzB4DsEIjJDkeDkq75NHHbKo31GBwgJDaBJMFKCqKLWPI1x7GHyi+9onMdqGgZCNJmS
 VSDNZvu7Sa0yK5Yg0ONSsjCPEIbbS6WD5qLJmB5siYu9YU3H9umHPZKNZcomPekmxqqTfPx+jWd3Qd
 oISZtFFPwI69QcnpL9CQfO2gQTCJyY+lq6ECnT9A72ZmsMN5fHBfKXUXB9BV9eCIg/ngpjskdbN62J
 kdGk/wWagZOxcnPoS3l65BiEEWxRGSoM2y4q6qL7jAXC76Sj2QWrVSl+NgmsgegmqhnpJK2zKuFk2B
 jJid9LeiRervbz9GN5l+jH5wUTRf41TgCsYkKysMV2MMYWVbxFBFB89hTp17NCC9jtS9nM+41Y2vn5
 b29obwBtgQYObDK60cHXDgndcOiv3cFpjvMhzmG9imbDWAR2avUz6R2msoFQG6Py6TEHoPuQURT/SC
 3or39fWV1852K1lVl+GrtA279MHHEZgF7a7jI+ai0kMJ+sQ90Vt4caOlswx7UhksjwQTo46ol4gZZl
 kUQujsg0a+j3c0o4OnHWt5qj80GiIBBsqBYZYr6L1w2Mkuz0k9Chc9cXQbl0vD5DE2OUYP8+50bqgN
 wTMuXcX6eEkTWiZFsFRWQra5A7G8wAENEv0WrZW0FrEUfBCwN5fu8sydhJpA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The SM8650-HDK is an embedded development platforms for the
Snapdragon 8 Gen 3 SoC aka SM8650, with the following features:
- Qualcomm SM8650 SoC
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
[3] https://www.lantronix.com/products/snapdragon-8-gen-3-mobile-hardware-development-kit/

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile       |    1 +
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 1251 +++++++++++++++++++++++++++++++
 2 files changed, 1252 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 7d40ec5e7d21..4f48c98451de 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -241,6 +241,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-crd.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
new file mode 100644
index 000000000000..3791c36579be
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -0,0 +1,1251 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2024, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "sm8650.dtsi"
+#include "pm8010.dtsi"
+#include "pm8550.dtsi"
+#include "pm8550b.dtsi"
+#define PMK8550VE_SID 8
+#include "pm8550ve.dtsi"
+#include "pm8550vs.dtsi"
+#include "pmk8550.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. SM8650 HDK";
+	compatible = "qcom,sm8650-hdk", "qcom,sm8650";
+	chassis-type = "embedded";
+
+	aliases {
+		serial0 = &uart15;
+		serial1 = &uart14;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
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
+			gpios = <&pm8550_gpios 11 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "bluetooth-power";
+			default-state = "off";
+		};
+
+		led-1 {
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&pm8550b_gpios 9 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			panic-indicator;
+		};
+
+		led-2 {
+			function = LED_FUNCTION_WLAN;
+			color = <LED_COLOR_ID_ORANGE>;
+			gpios = <&pm8550b_gpios 10 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+	};
+
+	pmic-glink {
+		compatible = "qcom,sm8650-pmic-glink",
+			     "qcom,sm8550-pmic-glink",
+			     "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		orientation-gpios = <&tlmm 29 GPIO_ACTIVE_HIGH>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+
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
+						remote-endpoint = <&wcd_usbss_sbu_mux>;
+				    };
+				};
+			};
+		};
+	};
+
+	lt9611_1v2: regulator-lt9611-1v2 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "LT9611_1V2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+
+		vin-supply = <&vph_pwr>;
+		gpio = <&tlmm 79 GPIO_ACTIVE_HIGH>;
+
+		enable-active-high;
+	};
+
+	lt9611_3v3: regulator-lt9611-3v3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "LT9611_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		vin-supply = <&vreg_bob_3v3>;
+		gpio = <&tlmm 78 GPIO_ACTIVE_HIGH>;
+
+		enable-active-high;
+	};
+
+	sound {
+		compatible = "qcom,sm8650-sndcard", "qcom,sm8450-sndcard";
+		model = "SM8650-HDK";
+		audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
+				"SpkrRight IN", "WSA_SPK2 OUT",
+				"IN1_HPHL", "HPHL_OUT",
+				"IN2_HPHR", "HPHR_OUT",
+				"AMIC1", "MIC BIAS1",
+				"AMIC2", "MIC BIAS2",
+				"AMIC5", "MIC BIAS4",
+				"TX SWR_INPUT0", "ADC1_OUTPUT",
+				"TX SWR_INPUT1", "ADC2_OUTPUT",
+				"TX SWR_INPUT3", "ADC4_OUTPUT";
+
+		wcd-playback-dai-link {
+			link-name = "WCD Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&wcd939x 0>, <&swr1 0>, <&lpass_rxmacro 0>;
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
+				sound-dai = <&wcd939x 1>, <&swr2 0>, <&lpass_txmacro 0>;
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
+	};
+
+	vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vreg_bob_3v3: regulator-vreg-bob-3v3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_BOB_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		vin-supply = <&vph_pwr>;
+	};
+
+	wcd939x: audio-codec {
+		compatible = "qcom,wcd9395-codec", "qcom,wcd9390-codec";
+
+		pinctrl-0 = <&wcd_default>;
+		pinctrl-names = "default";
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
+		reset-gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
+
+		vdd-buck-supply = <&vreg_l15b_1p8>;
+		vdd-rxtx-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l15b_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob1>;
+
+		#sound-dai-cells = <1>;
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm8550-rpmh-regulators";
+
+		vdd-bob1-supply = <&vph_pwr>;
+		vdd-bob2-supply = <&vph_pwr>;
+		vdd-l2-l13-l14-supply = <&vreg_bob1>;
+		vdd-l3-supply = <&vreg_s1c_1p2>;
+		vdd-l5-l16-supply = <&vreg_bob1>;
+		vdd-l6-l7-supply = <&vreg_bob1>;
+		vdd-l8-l9-supply = <&vreg_bob1>;
+		vdd-l11-supply = <&vreg_s1c_1p2>;
+		vdd-l12-supply = <&vreg_s6c_1p8>;
+		vdd-l15-supply = <&vreg_s6c_1p8>;
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
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
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
+		vdd-l1-supply = <&vreg_s1c_1p2>;
+		vdd-l2-supply = <&vreg_s1c_1p2>;
+		vdd-l3-supply = <&vreg_s1c_1p2>;
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+
+		qcom,pmic-id = "c";
+
+		vreg_s1c_1p2: smps1 {
+			regulator-name = "vreg_s1c_1p2";
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1348000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s2c_0p8: smps2 {
+			regulator-name = "vreg_s2c_0p8";
+			regulator-min-microvolt = <852000>;
+			regulator-max-microvolt = <1036000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s3c_0p9: smps3 {
+			regulator-name = "vreg_s3c_0p9";
+			regulator-min-microvolt = <976000>;
+			regulator-max-microvolt = <1064000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s4c_1p2: smps4 {
+			regulator-name = "vreg_s4c_1p2";
+			regulator-min-microvolt = <1224000>;
+			regulator-max-microvolt = <1280000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s5c_0p7: smps5 {
+			regulator-name = "vreg_s5c_0p7";
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <900000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s6c_1p8: smps6 {
+			regulator-name = "vreg_s6c_1p8";
+			regulator-min-microvolt = <1856000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1c_1p2: ldo1 {
+			regulator-name = "vreg_l1c_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3c_1p2: ldo3 {
+			regulator-name = "vreg_l3c_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
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
+		vdd-l1-supply = <&vreg_s3c_0p9>;
+
+		qcom,pmic-id = "d";
+
+		vreg_l1d_0p88: ldo1 {
+			regulator-name = "vreg_l1d_0p88";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-3 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+
+		vdd-l3-supply = <&vreg_s3c_0p9>;
+
+		qcom,pmic-id = "e";
+
+		vreg_l3e_0p9: ldo3 {
+			regulator-name = "vreg_l3e_0p9";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-4 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+
+		vdd-l1-supply = <&vreg_s3c_0p9>;
+		vdd-l3-supply = <&vreg_s3c_0p9>;
+
+		qcom,pmic-id = "g";
+
+		vreg_l1g_0p91: ldo1 {
+			regulator-name = "vreg_l1g_0p91";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3g_0p91: ldo3 {
+			regulator-name = "vreg_l3g_0p91";
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
+		compatible = "qcom,pm8550ve-rpmh-regulators";
+
+		vdd-l1-supply = <&vreg_s3c_0p9>;
+		vdd-l2-supply = <&vreg_s3c_0p9>;
+		vdd-l3-supply = <&vreg_s1c_1p2>;
+		vdd-s4-supply = <&vph_pwr>;
+
+		qcom,pmic-id = "i";
+
+		vreg_s4i_0p85: smps4 {
+			regulator-name = "vreg_s4i_0p85";
+			regulator-min-microvolt = <852000>;
+			regulator-max-microvolt = <1004000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1i_0p88: ldo1 {
+			regulator-name = "vreg_l1i_0p88";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2i_0p88: ldo2 {
+			regulator-name = "vreg_l2i_0p88";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3i_1p2: ldo3 {
+			regulator-name = "vreg_l3i_0p91";
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
+		qcom,pmic-id = "m";
+
+		vdd-l1-l2-supply = <&vreg_s1c_1p2>;
+		vdd-l3-l4-supply = <&vreg_bob2>;
+		vdd-l5-supply = <&vreg_s6c_1p8>;
+		vdd-l6-supply = <&vreg_bob1>;
+		vdd-l7-supply = <&vreg_bob1>;
+
+		vreg_l1m_1p1: ldo1 {
+			regulator-name = "vreg_l1m_1p1";
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1104000>;
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
+		vreg_l6m_2p8: ldo6 {
+			regulator-name = "vreg_l6m_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7m_2p96: ldo7 {
+			regulator-name = "vreg_l7m_2p96";
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-7 {
+		compatible = "qcom,pm8010-rpmh-regulators";
+		qcom,pmic-id = "n";
+
+		vdd-l1-l2-supply = <&vreg_s1c_1p2>;
+		vdd-l3-l4-supply = <&vreg_s6c_1p8>;
+		vdd-l5-supply = <&vreg_bob2>;
+		vdd-l6-supply = <&vreg_bob2>;
+		vdd-l7-supply = <&vreg_bob1>;
+
+		vreg_l1n_1p1: ldo1 {
+			regulator-name = "vreg_l1n_1p1";
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2n_1p056: ldo2 {
+			regulator-name = "vreg_l2n_1p056";
+			regulator-min-microvolt = <1056000>;
+			regulator-max-microvolt = <1056000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3n_1p8: ldo3 {
+			regulator-name = "vreg_l3n_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4n_1p8: ldo4 {
+			regulator-name = "vreg_l4n_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5n_2p8: ldo5 {
+			regulator-name = "vreg_l5n_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6n_2p8: ldo6 {
+			regulator-name = "vreg_l6n_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7n_3p3: ldo7 {
+			regulator-name = "vreg_l7n_3p3";
+			regulator-min-microvolt = <3304000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&dispcc {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&i2c3 {
+       status = "okay";
+
+       wcd_usbss: typec-mux@e {
+		compatible = "qcom,wcd9395-usbss", "qcom,wcd9390-usbss";
+		reg = <0xe>;
+
+		vdd-supply = <&vreg_l15b_1p8>;
+		reset-gpios = <&tlmm 152 GPIO_ACTIVE_HIGH>;
+
+		mode-switch;
+		orientation-switch;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				wcd_usbss_sbu_mux: endpoint {
+					remote-endpoint = <&pmic_glink_sbu>;
+				};
+			};
+		};
+       };
+};
+
+&i2c6 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	lt9611_codec: hdmi-bridge@2b {
+		compatible = "lontium,lt9611uxc";
+		reg = <0x2b>;
+
+		interrupts-extended = <&tlmm 85 IRQ_TYPE_EDGE_FALLING>;
+
+		reset-gpios = <&tlmm 28 GPIO_ACTIVE_HIGH>;
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
+&ipa {
+	qcom,gsi-loader = "self";
+	memory-region = <&ipa_fw_mem>;
+	firmware-name = "qcom/sm8650/ipa_fws.mbn";
+	status = "okay";
+};
+
+&lpass_tlmm {
+	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
+		pins = "gpio21";
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
+	vdda-supply = <&vreg_l3i_1p2>;
+
+	status = "okay";
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&lt9611_a>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l1i_0p88>;
+
+	status = "okay";
+};
+
+&mdss_dp0 {
+	status = "okay";
+};
+
+&mdss_dp0_out {
+	data-lanes = <0 1>;
+	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
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
+	vdda-phy-supply = <&vreg_l1i_0p88>;
+	vdda-pll-supply = <&vreg_l3i_1p2>;
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
+	vdda-phy-supply = <&vreg_l3e_0p9>;
+	vdda-pll-supply = <&vreg_l3i_1p2>;
+	vdda-qref-supply = <&vreg_l1i_0p88>;
+
+	status = "okay";
+};
+
+&pm8550_gpios {
+	sdc2_card_det_n: sdc2-card-det-state {
+		pins = "gpio12";
+		function = "normal";
+		bias-pull-up;
+		input-enable;
+		output-disable;
+		power-source = <1>; /* 1.8 V */
+	};
+
+	volume_up_n: volume-up-n-state {
+		pins = "gpio6";
+		function = "normal";
+		bias-pull-up;
+		input-enable;
+		power-source = <1>;
+	};
+};
+
+/* The RGB signals are routed to 3 separate LEDs on the HDK8650 */
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
+&pmk8550_rtc {
+	status = "okay";
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
+&qup_i2c3_data_clk {
+	/* Use internal I2C pull-up */
+	bias-pull-up = <2200>;
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
+	firmware-name = "qcom/sm8650/adsp.mbn",
+			"qcom/sm8650/adsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm8650/cdsp.mbn",
+			"qcom/sm8650/cdsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sm8650/modem.mbn",
+			"qcom/sm8650/modem_dtb.mbn";
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	cd-gpios = <&pm8550_gpios 12 GPIO_ACTIVE_HIGH>;
+
+	vmmc-supply = <&vreg_l9b_2p9>;
+	vqmmc-supply = <&vreg_l8b_1p8>;
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default>, <&sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep>, <&sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
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
+		pinctrl-0 = <&spkr_1_sd_n_active>;
+		pinctrl-names = "default";
+		powerdown-gpios = <&lpass_tlmm 21 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrLeft";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l3c_1p2>;
+	};
+
+	/* WSA8845, Speaker South */
+	south_spkr: speaker@0,1 {
+		compatible = "sdw20217020400";
+		reg = <0 1>;
+		pinctrl-0 = <&spkr_2_sd_n_active>;
+		pinctrl-names = "default";
+		powerdown-gpios = <&tlmm 77 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrRight";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l3c_1p2>;
+	};
+};
+
+&swr1 {
+	status = "okay";
+
+	/* WCD9395 RX */
+	wcd_rx: codec@0,4 {
+		compatible = "sdw20217010e00";
+		reg = <0 4>;
+
+		/*
+		 * WCD9395 RX Port 1 (HPH_L/R)      <=> SWR1 Port 1 (HPH_L/R)
+		 * WCD9395 RX Port 2 (CLSH)         <=> SWR1 Port 2 (CLSH)
+		 * WCD9395 RX Port 3 (COMP_L/R)     <=> SWR1 Port 3 (COMP_L/R)
+		 * WCD9395 RX Port 4 (LO)           <=> SWR1 Port 4 (LO)
+		 * WCD9395 RX Port 5 (DSD_L/R)      <=> SWR1 Port 5 (DSD_L/R)
+		 * WCD9395 RX Port 6 (HIFI_PCM_L/R) <=> SWR1 Port 9 (HIFI_PCM_L/R)
+		 */
+		qcom,rx-port-mapping = <1 2 3 4 5 9>;
+	};
+};
+
+&swr2 {
+	status = "okay";
+
+	/* WCD9395 TX */
+	wcd_tx: codec@0,3 {
+		compatible = "sdw20217010e00";
+		reg = <0 3>;
+
+		/*
+		 * WCD9395 TX Port 1 (ADC1,2,3,4)         <=> SWR2 Port 2 (TX SWR_INPUT 0,1,2,3)
+		 * WCD9395 TX Port 2 (ADC3,4 & DMIC0,1)   <=> SWR2 Port 2 (TX SWR_INPUT 0,1,2,3)
+		 * WCD9395 TX Port 3 (DMIC0,1,2,3 & MBHC) <=> SWR2 Port 3 (TX SWR_INPUT 4,5,6,7)
+		 * WCD9395 TX Port 4 (DMIC4,5,6,7)        <=> SWR2 Port 4 (TX SWR_INPUT 8,9,10,11)
+		 */
+		qcom,tx-port-mapping = <2 2 3 4>;
+	};
+};
+
+&tlmm {
+	/* Reserved I/Os for NFC */
+	gpio-reserved-ranges = <32 8>, <74 1>;
+
+	bt_default: bt-default-state {
+		bt-en-pins {
+			pins = "gpio17";
+			function = "gpio";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		sw-ctrl-pins {
+			pins = "gpio18";
+			function = "gpio";
+			bias-pull-down;
+		};
+	};
+
+	lt9611_irq_pin: lt9611-irq-state {
+		pins = "gpio85";
+		function = "gpio";
+		bias-disable;
+	};
+
+	lt9611_rst_pin: lt9611-rst-state {
+		pins = "gpio28";
+		function = "gpio";
+		output-high;
+	};
+
+	spkr_2_sd_n_active: spkr-2-sd-n-active-state {
+		pins = "gpio77";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+
+	wcd_default: wcd-reset-n-active-state {
+		pins = "gpio107";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+};
+
+&uart14 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn7850-bt";
+
+		vddio-supply = <&vreg_l3c_1p2>;
+		vddaon-supply = <&vreg_l15b_1p8>;
+		vdddig-supply = <&vreg_s3c_0p9>;
+		vddrfa0p8-supply = <&vreg_s3c_0p9>;
+		vddrfa1p2-supply = <&vreg_s1c_1p2>;
+		vddrfa1p9-supply = <&vreg_s6c_1p8>;
+
+		max-speed = <3200000>;
+
+		enable-gpios = <&tlmm 17 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 18 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&bt_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&uart15 {
+	status = "okay";
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l17b_2p5>;
+	vcc-max-microamp = <1300000>;
+	vccq-supply = <&vreg_l1c_1p2>;
+	vccq-max-microamp = <1200000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l1d_0p88>;
+	vdda-pll-supply = <&vreg_l3i_1p2>;
+
+	status = "okay";
+};
+
+/*
+ * DPAUX -> WCD9395 -> USB_SBU -> USB-C
+ * eUSB2 DP/DM -> PM85550HS -> eUSB2 DP/DM -> WCD9395 -> USB-C
+ * USB SS -> USB-C
+ */
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
+	vdd-supply = <&vreg_l1i_0p88>;
+	vdda12-supply = <&vreg_l3i_1p2>;
+
+	phys = <&pm8550b_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_dp_qmpphy {
+	vdda-phy-supply = <&vreg_l3i_1p2>;
+	vdda-pll-supply = <&vreg_l3g_0p91>;
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


