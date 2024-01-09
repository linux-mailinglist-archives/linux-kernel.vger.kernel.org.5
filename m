Return-Path: <linux-kernel+bounces-21094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236308289B3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F7D285573
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5033B199;
	Tue,  9 Jan 2024 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MnOUbo2u"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663AF3A1DC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-336897b6bd6so3195922f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 08:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704816363; x=1705421163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSx5APtUI1ZOyaAFGFT4MEy1qdwqq3AbtB7KZy+k8Dk=;
        b=MnOUbo2uJQgjITRE6ZUyCWhrWwZQjEu9wqZUJMsaZqcq0J2sq7MmUBLeJi6CSfJim1
         u5HIw91SIkOXShyg9bvyzz3YfuiMG2WyFsGaBLDc091hstWRCfFzwJp47VPkP2wwFuMk
         WC+9JzoaSRs2+B2raY5pRtp+F+atM5axvZl5R+WcinUn+09ucKBBBIPlCdt1WTP+fs3Z
         Zi1IUKVVHjR2YBIvpi/40KqciRwaYARdzdZZ7qhjCGrR7pRt4YTdd7KwrjvnvNysG50J
         CNgyKMr+TaxHLYaU4FwBPYKayMgseQaioM4VKB56FD74j3vCbCwD0L4J7vRMqBJ8A8Od
         W2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704816363; x=1705421163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSx5APtUI1ZOyaAFGFT4MEy1qdwqq3AbtB7KZy+k8Dk=;
        b=Ujzee1iy8NJe7OakOHKXCVDSbDUxdmTQ3c7XubHacM+hOcmNyUOsw2n9QITcvYr5Ef
         EJbht29N6vYcu49wjN2N6ziBQilcRjak0s1OyN8ro4MhHJIxF1WYHGsLFyJ7Ur7vbB9I
         WFnAt6gdJcY7FmC6fjfdZvmmhUZJUAWwJZVqZOYIW2la4IysN0Z7AUyZQ+hj0UD5d0jr
         5bz0xL/t2qh8nrLafAoOphTFSh8LTwVfYcBw6BJkNHPnuUkychU6RD32n6/3hp/30fzl
         4MjwGQim8qxjh2KylcpbqfzI3Lj4chCuaQe4L5TOEQJggsEI/JonpEm0V7eqGsWmJVeJ
         2k8w==
X-Gm-Message-State: AOJu0YxnHQFLJI/uyET3ObFNktfetxW7gxB9WDJwnDZyXBf3Nk3R+bWv
	+/yQzlX7kOChLwISdhgSur2s4cUONnxUyLoiNEzBDu0aVtWgdg==
X-Google-Smtp-Source: AGHT+IEn8Nlg9eOK5m9dVTJLhzopdWgwUOqLQ4GnOjPuOhYXLURZzKXxvXN9BnL0QcmdrCx5IZ+IfA==
X-Received: by 2002:a05:6000:22f:b0:337:6836:494e with SMTP id l15-20020a056000022f00b003376836494emr627210wrz.95.1704816363756;
        Tue, 09 Jan 2024 08:06:03 -0800 (PST)
Received: from [127.0.1.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b0033762d4ad5asm2726490wrn.81.2024.01.09.08.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 08:06:03 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 09 Jan 2024 16:06:04 +0000
Subject: [PATCH v3 3/4] arm64: dts: qcom: sc8280xp: camss: Add CCI
 definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-3-b8e3a74a6e6a@linaro.org>
References: <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-0-b8e3a74a6e6a@linaro.org>
In-Reply-To: <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-0-b8e3a74a6e6a@linaro.org>
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
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 307 +++++++++++++++++++++++++++++++++
 1 file changed, 307 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index febf28356ff8..f48dfa5e5f36 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3451,6 +3451,169 @@ usb_1_role_switch: endpoint {
 			};
 		};
 
+		cci0: cci@ac4a000 {
+			compatible = "qcom,sc8280xp-cci", "qcom,msm8996-cci";
+			reg = <0 0x0ac4a000 0 0x1000>;
+
+			interrupts = <GIC_SPI 460 IRQ_TYPE_EDGE_RISING>;
+
+			clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
+				 <&camcc CAMCC_SLOW_AHB_CLK_SRC>,
+				 <&camcc CAMCC_CPAS_AHB_CLK>,
+				 <&camcc CAMCC_CCI_0_CLK>;
+			clock-names = "camnoc_axi",
+				      "slow_ahb_src",
+				      "cpas_ahb",
+				      "cci";
+
+			power-domains = <&camcc TITAN_TOP_GDSC>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&cci0_default>;
+			pinctrl-1 = <&cci0_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
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
+			compatible = "qcom,sc8280xp-cci", "qcom,msm8996-cci";
+			reg = <0 0x0ac4b000 0 0x1000>;
+
+			interrupts = <GIC_SPI 271 IRQ_TYPE_EDGE_RISING>;
+
+			clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
+				 <&camcc CAMCC_SLOW_AHB_CLK_SRC>,
+				 <&camcc CAMCC_CPAS_AHB_CLK>,
+				 <&camcc CAMCC_CCI_1_CLK>;
+			clock-names = "camnoc_axi",
+				      "slow_ahb_src",
+				      "cpas_ahb",
+				      "cci";
+
+			power-domains = <&camcc TITAN_TOP_GDSC>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&cci1_default>;
+			pinctrl-1 = <&cci1_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
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
+			compatible = "qcom,sc8280xp-cci", "qcom,msm8996-cci";
+			reg = <0 0x0ac4c000 0 0x1000>;
+
+			interrupts = <GIC_SPI 651 IRQ_TYPE_EDGE_RISING>;
+
+			clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
+				 <&camcc CAMCC_SLOW_AHB_CLK_SRC>,
+				 <&camcc CAMCC_CPAS_AHB_CLK>,
+				 <&camcc CAMCC_CCI_2_CLK>;
+			clock-names = "camnoc_axi",
+				      "slow_ahb_src",
+				      "cpas_ahb",
+				      "cci";
+			power-domains = <&camcc TITAN_TOP_GDSC>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&cci2_default>;
+			pinctrl-1 = <&cci2_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
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
+			compatible = "qcom,sc8280xp-cci", "qcom,msm8996-cci";
+			reg = <0 0x0ac4d000 0 0x1000>;
+
+			interrupts = <GIC_SPI 650 IRQ_TYPE_EDGE_RISING>;
+
+			clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
+				 <&camcc CAMCC_SLOW_AHB_CLK_SRC>,
+				 <&camcc CAMCC_CPAS_AHB_CLK>,
+				 <&camcc CAMCC_CCI_3_CLK>;
+			clock-names = "camnoc_axi",
+				      "slow_ahb_src",
+				      "cpas_ahb",
+				      "cci";
+
+			power-domains = <&camcc TITAN_TOP_GDSC>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&cci3_default>;
+			pinctrl-1 = <&cci3_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
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
@@ -4076,6 +4239,150 @@ tlmm: pinctrl@f100000 {
 			#interrupt-cells = <2>;
 			gpio-ranges = <&tlmm 0 0 230>;
 			wakeup-parent = <&pdc>;
+
+			cci0_default: cci0-default-state {
+				cci0_i2c0_default: cci0-i2c0-default-pins {
+					/* cci_i2c_sda0, cci_i2c_scl0 */
+					pins = "gpio113", "gpio114";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				cci0_i2c1_default: cci0-i2c1-default-pins {
+					/* cci_i2c_sda1, cci_i2c_scl1 */
+					pins = "gpio115", "gpio116";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			cci0_sleep: cci0-sleep-state {
+				cci0_i2c0_sleep: cci0-i2c0-sleep-pins {
+					/* cci_i2c_sda0, cci_i2c_scl0 */
+					pins = "gpio113", "gpio114";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				cci0_i2c1_sleep: cci0-i2c1-sleep-pins {
+					/* cci_i2c_sda1, cci_i2c_scl1 */
+					pins = "gpio115", "gpio116";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			cci1_default: cci1-default-state {
+				cci1_i2c0_default: cci1-i2c0-default-pins {
+					/* cci_i2c_sda2, cci_i2c_scl2 */
+					pins = "gpio10","gpio11";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				cci1_i2c1_default: cci1-i2c1-default-pins {
+					/* cci_i2c_sda3, cci_i2c_scl3 */
+					pins = "gpio123","gpio124";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			cci1_sleep: cci1-sleep-state {
+				cci1_i2c0_sleep: cci1-i2c0-sleep-pins {
+					/* cci_i2c_sda2, cci_i2c_scl2 */
+					pins = "gpio10","gpio11";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				cci1_i2c1_sleep: cci1-i2c1-sleep-pins {
+					/* cci_i2c_sda3, cci_i2c_scl3 */
+					pins = "gpio123","gpio124";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			cci2_default: cci2-default-state {
+				cci2_i2c0_default: cci2-i2c0-default-pins {
+					/* cci_i2c_sda4, cci_i2c_scl4 */
+					pins = "gpio117","gpio118";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				cci2_i2c1_default: cci2-i2c1-default-pins {
+					/* cci_i2c_sda5, cci_i2c_scl5 */
+					pins = "gpio12","gpio13";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			cci2_sleep: cci2-sleep-state {
+				cci2_i2c0_sleep: cci2-i2c0-sleep-pins {
+					/* cci_i2c_sda4, cci_i2c_scl4 */
+					pins = "gpio117","gpio118";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				cci2_i2c1_sleep: cci2-i2c1-sleep-pins {
+					/* cci_i2c_sda5, cci_i2c_scl5 */
+					pins = "gpio12","gpio13";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			cci3_default: cci3-default-state {
+				cci3_i2c0_default: cci3-i2c0-default-pins {
+					/* cci_i2c_sda6, cci_i2c_scl6 */
+					pins = "gpio145","gpio146";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				cci3_i2c1_default: cci3-i2c1-default-pins {
+					/* cci_i2c_sda7, cci_i2c_scl7 */
+					pins = "gpio164","gpio165";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			cci3_sleep: cci3-sleep-state {
+				cci3_i2c0_sleep: cci3-i2c0-sleep-pins {
+					/* cci_i2c_sda6, cci_i2c_scl6 */
+					pins = "gpio145","gpio146";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				cci3_i2c1_sleep: cci3-i2c1-sleep-pins {
+					/* cci_i2c_sda7, cci_i2c_scl7 */
+					pins = "gpio164","gpio165";
+					function = "cci_i2c";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
 		};
 
 		apps_smmu: iommu@15000000 {

-- 
2.42.0


