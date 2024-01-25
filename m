Return-Path: <linux-kernel+bounces-38911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E1A83C856
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8341C22732
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7874131E45;
	Thu, 25 Jan 2024 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKeaHfOx"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F94130E4E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200974; cv=none; b=PhuS3yJH/r+AZ93rCuSAboc0OKH1jv+TLiPLtxWCFLCmEApRaq50MTwxuhvicASqGUWsfVgpoCMbMi3+WBByh4XZH0iS484VSJcLFbU7p567LmLhUm67PGlLSP8lc4PVvMvFn6S/qMLgVPeGmjz6DFPw/JDCnY1KkrkcnZFGE1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200974; c=relaxed/simple;
	bh=AtOoBFcIQKgUh5ZyEDGWZhd+aEqLc4+3VKAs3noLf70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzJ+8F2ebG6Z7COiEm8nr9veDA3Zqt7WMzQywGnSufSe5/OmWQPAjtP6+qWsA52UtKPsggnBv3bMbzA9ws04TLLxmw1Ic1wEKQSA6G6ydlIYfLwf6QyPmaL4sOI/UTWfLt8keUFjO9ladKaMF2Z5/CM6G+ueOV33wqJNJQd5mYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WKeaHfOx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29036dc3a63so3160071a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706200972; x=1706805772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4FMn289XJfM4JthuVepAmRbmblvDNilSayK8e6lWXw=;
        b=WKeaHfOx6kHe6jr0re4UUuJlS43WhZ6/o2TW8zKYPrfWzClZR9DXIC7ZQtQXm90P/R
         mVulYeS9Mc9RWiy5Eq6h+ysY0bp9BrHQZc86u0DIO9bqOHZN2Ap7vG/vJI7z0nL7eNKc
         4v9caJgF31hKLTlYgrHUE/gy2jrUTWPd/D/rTcttC7hDGnwguNGhCBp0hvW4AyzpVpv8
         Ue/3hDTp2dMfdPr90CsYGCBJbOdH08uMTyWxUFoPBnyEpQVnjqGI7rk2bd0QJH+q5K/l
         BysDepgHZimRsuAkEL+izUWG1YYkOOeNI0lGeSzQSVvT5vjcCpvYBkESr8erv/d5TyO/
         3yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706200972; x=1706805772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4FMn289XJfM4JthuVepAmRbmblvDNilSayK8e6lWXw=;
        b=TvZBeZF5IArFzEzA/k6EgSEE7AOnHTWiHtI3i1se2Cwk0BgrADY/knbILSDc/9Eq24
         r2zzz3QUTzUKSaC4KFa6mISqYiZeDdIUH4MdRH1H2GGeXCY328cpYruwej6hhaEzNQVd
         IPdmcCgp+UieYBamZI2zXmNb6TFPc6SqYYNfblEJ4H+I2iuTX7uFwbbhwRiFLLZCwXv8
         uEUvn4p/zKMetPlRdhELgO9pzxggRiBXcfgv4oZErqE5pYhra3oRrrhzgttovaXCY1rD
         7pkMJ/bbE6dSK8NdNS82+XQB3hOv9mbgmHozKAUXYL+Pl3Vb7aWPzsg7k7mZgYD4SV/J
         vuOA==
X-Gm-Message-State: AOJu0YynnjU2gRxrXht8CUFEL8qTKKg2ySTp2n2cmHOZ1pcfMaS12h1i
	IeZvd+6dEBurI7qoEoy2GaJD+msqT0ihsWJF6P+dunRC+p0N/O1gGo4JF7S2A8U=
X-Google-Smtp-Source: AGHT+IGiG3YsRuhlsrT8kgsnSYoO/2eV4afPGq+FUn/0K5PhA614vzTZW1qtdJ9HT0TN0hVxI9yBng==
X-Received: by 2002:a17:90a:6e42:b0:290:3b83:8897 with SMTP id s2-20020a17090a6e4200b002903b838897mr1064385pjm.40.1706200971989;
        Thu, 25 Jan 2024 08:42:51 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090ac88f00b0028c89122f8asm1769170pjt.6.2024.01.25.08.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 08:42:51 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 25 Jan 2024 17:42:41 +0100
Subject: [PATCH 1/3] arm64: dts: qcom: sm8650-qrd: add Audio nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-topic-sm8650-upstream-audio-dt-v1-1-c24d23ae5763@linaro.org>
References: <20240125-topic-sm8650-upstream-audio-dt-v1-0-c24d23ae5763@linaro.org>
In-Reply-To: <20240125-topic-sm8650-upstream-audio-dt-v1-0-c24d23ae5763@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6723;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=AtOoBFcIQKgUh5ZyEDGWZhd+aEqLc4+3VKAs3noLf70=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlso+FrwlSsmsjFNd6JFDd4+HcThBnKiqtDxP4W4dB
 yX/6IbuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZbKPhQAKCRB33NvayMhJ0XDJEA
 CVxqdti9xDFRC71wo4EqbZlQfDjl+ZI2/4xyjQsiwYHAfXePZC+bBF6ZoR9MGFtAdQ4yTLYeGjbthZ
 ByaDOU2KpS9J1Afbel8IzPqdsQjXbwzON/gt1YRUVzptboauwOl1phzFlJrWtdZsK5ZkT9ote/E67Z
 4H4Vt75umLM0TX2mWjSEIHDJTYZcq0kRdfKg9rA+tYu3mUpGVj5dvqliF8FynmzQtvdj/lsoM6PG4h
 v9L7LUOtgVQYffH/mBb1VdbxTrKvf0pqTyvIB0ZY0nMrs4JIWsS1yasVK8jFlCbo3Mc3oS67tvXNen
 m+IPmGUu7DKf8LnnxMLoQMXzCPU+M9vVjRyp+CigZs6OZU0iS1ujmpd6xhVsm2YGP+vnqPDiYXj4mS
 nX5pM/3G/a4jwIzQ8F19UXdOs65xGJdKX/QKzY80MxFfu5eujh620d2nVgA4enjbT4MHq8aMREEXfq
 FFp0uZmfFzwgWTy4YkL5dNX2S27kU1ItdMNmpZQueL5mcKEqHeWcPKzMBqjXAkJy1oQYbFNLRBwN+p
 VKklnWadzqaumZlRdbMh1yWjS0BxxronqwrIR6I22hRm5Ky5nlPnXHjF4/VEUL2mhQ/JEO/p9Kxv0W
 j6n6h9d5feGctQ0I8X4/FjJsccPL2kt8pWUP2R3Zw0i2XjTeq5ZzuKBrU4Sw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add the remaining Audio nodes on the SM8650-QRD board including:
- Qualcomm Aqstic WCD9395 audio codec on the RX & TX Soundwire interfaces
- WSA8845 Left & Right Speakers
- Link the WCD9395 Codec node to the WCD9395 USB SubSystem node to handle
  the USB-C Audio Accessory Mode events & lane swapping
- Sound card with routing for Speakers and Microphones

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 203 ++++++++++++++++++++++++++++++++
 1 file changed, 203 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index 8515498553bf..277b1ba81685 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -92,6 +92,72 @@ pmic_glink_sbu: endpoint {
 		};
 	};
 
+	sound {
+		compatible = "qcom,sm8650-sndcard", "qcom,sm8450-sndcard";
+		model = "SM8650-QRD";
+		audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
+				"SpkrRight IN", "WSA_SPK2 OUT",
+				"IN1_HPHL", "HPHL_OUT",
+				"IN2_HPHR", "HPHR_OUT",
+				"AMIC1", "MIC BIAS1",
+				"AMIC2", "MIC BIAS2",
+				"AMIC3", "MIC BIAS3",
+				"AMIC4", "MIC BIAS3",
+				"AMIC5", "MIC BIAS4",
+				"TX SWR_INPUT0", "ADC1_OUTPUT",
+				"TX SWR_INPUT1", "ADC2_OUTPUT",
+				"TX SWR_INPUT2", "ADC3_OUTPUT",
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
+				sound-dai = <&left_spkr>, <&right_spkr>, <&swr0 0>, <&lpass_wsamacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 
@@ -102,6 +168,41 @@ vph_pwr: vph-pwr-regulator {
 		regulator-always-on;
 		regulator-boot-on;
 	};
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
+
+		mode-switch;
+		orientation-switch;
+
+		port {
+			wcd_codec_headset_in: endpoint {
+				remote-endpoint = <&wcd_usbss_headset_out>;
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -478,6 +579,14 @@ wcd_usbss_sbu_mux: endpoint {
 					remote-endpoint = <&pmic_glink_sbu>;
 				};
 			};
+
+			port@1 {
+				reg = <1>;
+
+				wcd_usbss_headset_out: endpoint {
+					remote-endpoint = <&wcd_codec_headset_in>;
+				};
+			};
 		};
        };
 };
@@ -525,6 +634,16 @@ &ipa {
 	status = "okay";
 };
 
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
 &mdss {
 	status = "okay";
 };
@@ -743,6 +862,74 @@ touchscreen@0 {
 	};
 };
 
+&swr0 {
+	status = "okay";
+
+	/* WSA8845, Speaker Left */
+	left_spkr: speaker@0,0 {
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
+	/* WSA8845, Speaker Right */
+	right_spkr: speaker@0,1 {
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
 &tlmm {
 	/* Reserved I/Os for NFC */
 	gpio-reserved-ranges = <32 8>, <74 1>;
@@ -790,6 +977,14 @@ mdp_vsync_suspend: mdp-vsync-suspend-state {
 		bias-pull-down;
 	};
 
+	spkr_2_sd_n_active: spkr-2-sd-n-active-state {
+		pins = "gpio77";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+
 	ts_irq: ts-irq-state {
 		pins = "gpio161";
 		function = "gpio";
@@ -804,6 +999,14 @@ ts_reset: ts-reset-state {
 		drive-strength = <8>;
 		bias-pull-up;
 	};
+
+	wcd_default: wcd-reset-n-active-state {
+		pins = "gpio107";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
 };
 
 &uart14 {

-- 
2.34.1


