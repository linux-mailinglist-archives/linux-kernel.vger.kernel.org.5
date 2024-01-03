Return-Path: <linux-kernel+bounces-15066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C018226E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C0C1F22F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6C01799B;
	Wed,  3 Jan 2024 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXb7avzo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD2468C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so6777137f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 18:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704248321; x=1704853121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMtQXbKl7iE2JQo0KabWtcLPthObXGqXrak3j9MLehE=;
        b=BXb7avzon6zspbTcTtJmRtMYrDBVeruQgAU+XvbThaAXDvhk62+88o2JQQci2ZJzXW
         C9PPASg1AlxSmQp4x/wYLtk2entc7gUTPA/iPLV7CGl3xq7m6CAl/XKvR6hZqZMkXPyP
         WqlI2rAKoozzFhW5uWiRKFFjVBCKnU4RJPryPyEWZrGptv7oKjo4B8smTsdriaRAH0w3
         3OaBnSymsY5yjMByIBjP661LIfLV33mvJ2puUPqmZ+heAZHsTm7uVWm4h7y4XpKsAK0V
         a/OW0thh5OJ2EITWKBZlCKCmnnlNc6dQ7PlE7O5kBpXrtUyK35LyDQbHYDt6KF6DfIev
         B0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704248321; x=1704853121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMtQXbKl7iE2JQo0KabWtcLPthObXGqXrak3j9MLehE=;
        b=eXNWr7ENvlpPL2aqGMcY8uD8rTER4u2cY8DJD4BtUF3UXu2+FYqTT/YpIGxztnz64y
         Xv8ZmHrj1PB9rkMjB2TqHXI24T7Hj9I1lJo32ykWkOGXLfAMk8oHAdeXhZiEm3NoAqZV
         tZS+/oj9QrfVclxrCMOyHRZuegstexp01OTn0WYvi3ZXuYFUPL1nVM7pdq3O5Yezc62K
         BiplLIjnHGVsbg+eXJbsFEmEailgc76EzyykYwJcixdDdyVc18PpviQRvsDO867KXfgK
         Bvqs06cl90dK/rARV2EkL1971zyvjUfEJ5I4SjtYha8wenPwsg/MH3+tgNxVNVuxtEbR
         28qA==
X-Gm-Message-State: AOJu0YxpQb32dS1vXbm6h0Zy+V+KEkSNoDKvuWJWY+WCxqnXn+9hF7QE
	MWUWpYIoHK52ibBS8C3NMMwIzOA1BXnMaA==
X-Google-Smtp-Source: AGHT+IGXO2qQw+aKbrnoPDpz8h/r/oesY5bRjklU/Qeal90gWQW+4QVyL6IggQTG0JbmNTndhm/tUw==
X-Received: by 2002:a05:600c:3548:b0:40d:5a47:ebe4 with SMTP id i8-20020a05600c354800b0040d5a47ebe4mr6497439wmq.120.1704248321388;
        Tue, 02 Jan 2024 18:18:41 -0800 (PST)
Received: from [127.0.1.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b0040d3276ba19sm734374wmq.25.2024.01.02.18.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 18:18:41 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Wed, 03 Jan 2024 02:18:40 +0000
Subject: [PATCH 2/3] arm64: dts: qcom: sc8280xp: camss: Add CCI definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v1-2-abacaa63a961@linaro.org>
References: <20240103-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v1-0-abacaa63a961@linaro.org>
In-Reply-To: <20240103-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v1-0-abacaa63a961@linaro.org>
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-4e032

sc8280xp has four Camera Control Interface (CCI) blocks which pinout to
two I2C master controllers for each CCI.

The CCI I2C pins are not muxed so we define them in the dtsi.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 324 +++++++++++++++++++++++++++++++++
 1 file changed, 324 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index febf28356ff8..4f6acd4a3f00 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3451,6 +3451,170 @@ usb_1_role_switch: endpoint {
 			};
 		};
 
+		cci0: cci@ac4a000 {
+			compatible = "qcom,sm8250-cci", "qcom,msm8996-cci";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			reg = <0 0x0ac4a000 0 0x1000>;
+			interrupts = <GIC_SPI 460 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&camcc TITAN_TOP_GDSC>;
+
+			clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
+				 <&camcc CAMCC_SLOW_AHB_CLK_SRC>,
+				 <&camcc CAMCC_CPAS_AHB_CLK>,
+				 <&camcc CAMCC_CCI_0_CLK>,
+				 <&camcc CAMCC_CCI_0_CLK_SRC>;
+			clock-names = "camnoc_axi",
+				      "slow_ahb_src",
+				      "cpas_ahb",
+				      "cci",
+				      "cci_src";
+
+			pinctrl-0 = <&cci0_default>;
+			pinctrl-1 = <&cci0_sleep>;
+			pinctrl-names = "default", "sleep";
+
+			status = "disabled";
+
+			cci0_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci0_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		cci1: cci@ac4b000 {
+			compatible = "qcom,sm8250-cci", "qcom,msm8996-cci";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			reg = <0 0x0ac4b000 0 0x1000>;
+			interrupts = <GIC_SPI 271 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&camcc TITAN_TOP_GDSC>;
+
+			clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
+				 <&camcc CAMCC_SLOW_AHB_CLK_SRC>,
+				 <&camcc CAMCC_CPAS_AHB_CLK>,
+				 <&camcc CAMCC_CCI_1_CLK>,
+				 <&camcc CAMCC_CCI_1_CLK_SRC>;
+			clock-names = "camnoc_axi",
+				      "slow_ahb_src",
+				      "cpas_ahb",
+				      "cci",
+				      "cci_src";
+
+			pinctrl-0 = <&cci1_default>;
+			pinctrl-1 = <&cci1_sleep>;
+			pinctrl-names = "default", "sleep";
+
+			status = "disabled";
+
+			cci1_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci1_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		cci2: cci@ac4c000 {
+			compatible = "qcom,sm8250-cci", "qcom,msm8996-cci";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			reg = <0 0x0ac4c000 0 0x1000>;
+			interrupts = <GIC_SPI 651 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&camcc TITAN_TOP_GDSC>;
+
+			clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
+				 <&camcc CAMCC_SLOW_AHB_CLK_SRC>,
+				 <&camcc CAMCC_CPAS_AHB_CLK>,
+				 <&camcc CAMCC_CCI_2_CLK>,
+				 <&camcc CAMCC_CCI_2_CLK_SRC>;
+			clock-names = "camnoc_axi",
+				      "slow_ahb_src",
+				      "cpas_ahb",
+				      "cci",
+				      "cci_src";
+
+			pinctrl-0 = <&cci2_default>;
+			pinctrl-1 = <&cci2_sleep>;
+			pinctrl-names = "default", "sleep";
+
+			status = "disabled";
+
+			cci2_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci2_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		cci3: cci@ac4d000 {
+			compatible = "qcom,sm8250-cci", "qcom,msm8996-cci";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			reg = <0 0x0ac4d000 0 0x1000>;
+			interrupts = <GIC_SPI 650 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&camcc TITAN_TOP_GDSC>;
+
+			clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
+				 <&camcc CAMCC_SLOW_AHB_CLK_SRC>,
+				 <&camcc CAMCC_CPAS_AHB_CLK>,
+				 <&camcc CAMCC_CCI_3_CLK>,
+				 <&camcc CAMCC_CCI_3_CLK_SRC>;
+			clock-names = "camnoc_axi",
+				      "slow_ahb_src",
+				      "cpas_ahb",
+				      "cci",
+				      "cci_src";
+
+			pinctrl-0 = <&cci3_default>;
+			pinctrl-1 = <&cci3_sleep>;
+			pinctrl-names = "default", "sleep";
+
+			status = "disabled";
+
+			cci3_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci3_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		camcc: clock-controller@ad00000 {
 			compatible = "qcom,sc8280xp-camcc";
 			reg = <0 0x0ad00000 0 0x20000>;
@@ -4076,6 +4240,166 @@ tlmm: pinctrl@f100000 {
 			#interrupt-cells = <2>;
 			gpio-ranges = <&tlmm 0 0 230>;
 			wakeup-parent = <&pdc>;
+
+			cci0_default: cci0-default-state {
+				cci0_i2c0_default: cci0-i2c0-default-pins {
+					/* cci_i2c_sda0, cci_i2c_scl0 */
+					pins = "gpio113", "gpio114";
+					function = "cci_i2c";
+
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+
+				cci0_i2c1_default: cci0-i2c1-default-pins {
+					/* cci_i2c_sda1, cci_i2c_scl1 */
+					pins = "gpio115", "gpio116";
+					function = "cci_i2c";
+
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+			};
+
+			cci0_sleep: cci0-sleep-state {
+				cci0_i2c0_sleep: cci0-i2c0-sleep-pins {
+					/* cci_i2c_sda0, cci_i2c_scl0 */
+					pins = "gpio113", "gpio114";
+					function = "cci_i2c";
+
+					drive-strength = <2>; /* 2 mA */
+					bias-pull-down;
+				};
+
+				cci0_i2c1_sleep: cci0-i2c1-sleep-pins {
+					/* cci_i2c_sda1, cci_i2c_scl1 */
+					pins = "gpio115", "gpio116";
+					function = "cci_i2c";
+
+					drive-strength = <2>; /* 2 mA */
+					bias-pull-down;
+				};
+			};
+
+			cci1_default: cci1-default-state {
+				cci1_i2c0_default: cci1-i2c0-default-pins {
+					/* cci_i2c_sda2, cci_i2c_scl2 */
+					pins = "gpio10","gpio11";
+					function = "cci_i2c";
+
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+
+				cci1_i2c1_default: cci1-i2c1-default-pins {
+					/* cci_i2c_sda3, cci_i2c_scl3 */
+					pins = "gpio123","gpio124";
+					function = "cci_i2c";
+
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+			};
+
+			cci1_sleep: cci1-sleep-state {
+				cci1_i2c0_sleep: cci1-i2c0-sleep-pins {
+					/* cci_i2c_sda2, cci_i2c_scl2 */
+					pins = "gpio10","gpio11";
+					function = "cci_i2c";
+
+					bias-pull-down;
+					drive-strength = <2>; /* 2 mA */
+				};
+
+				cci1_i2c1_sleep: cci1-i2c1-sleep-pins {
+					/* cci_i2c_sda3, cci_i2c_scl3 */
+					pins = "gpio123","gpio124";
+					function = "cci_i2c";
+
+					bias-pull-down;
+					drive-strength = <2>; /* 2 mA */
+				};
+			};
+
+			cci2_default: cci2-default-state {
+				cci2_i2c0_default: cci2-i2c0-default-pins {
+					/* cci_i2c_sda4, cci_i2c_scl4 */
+					pins = "gpio117","gpio118";
+					function = "cci_i2c";
+
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+
+				cci2_i2c1_default: cci2-i2c1-default-pins {
+					/* cci_i2c_sda5, cci_i2c_scl5 */
+					pins = "gpio12","gpio13";
+					function = "cci_i2c";
+
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+			};
+
+			cci2_sleep: cci2-sleep-state {
+				cci2_i2c0_sleep: cci2-i2c0-sleep-pins {
+					/* cci_i2c_sda4, cci_i2c_scl4 */
+					pins = "gpio117","gpio118";
+					function = "cci_i2c";
+
+					bias-pull-down;
+					drive-strength = <2>; /* 2 mA */
+				};
+
+				cci2_i2c1_sleep: cci2-i2c1-sleep-pins {
+					/* cci_i2c_sda5, cci_i2c_scl5 */
+					pins = "gpio12","gpio13";
+					function = "cci_i2c";
+
+					bias-pull-down;
+					drive-strength = <2>; /* 2 mA */
+				};
+			};
+
+			cci3_default: cci3-default-state {
+				cci3_i2c0_default: cci3-i2c0-default-pins {
+					/* cci_i2c_sda6, cci_i2c_scl6 */
+					pins = "gpio145","gpio146";
+					function = "cci_i2c";
+
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+
+				cci3_i2c1_default: cci3-i2c1-default-pins {
+					/* cci_i2c_sda7, cci_i2c_scl7 */
+					pins = "gpio164","gpio165";
+					function = "cci_i2c";
+
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+			};
+
+			cci3_sleep: cci3-sleep-state {
+				cci3_i2c0_sleep: cci3-i2c0-sleep-pins {
+					/* cci_i2c_sda6, cci_i2c_scl6 */
+					pins = "gpio145","gpio146";
+					function = "cci_i2c";
+
+					bias-pull-down;
+					drive-strength = <2>; /* 2 mA */
+				};
+
+				cci3_i2c1_sleep: cci3-i2c1-sleep-pins {
+					/* cci_i2c_sda7, cci_i2c_scl7 */
+					pins = "gpio164","gpio165";
+					function = "cci_i2c";
+
+					bias-pull-down;
+					drive-strength = <2>; /* 2 mA */
+				};
+			};
 		};
 
 		apps_smmu: iommu@15000000 {

-- 
2.42.0


