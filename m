Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272AB7684F5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 13:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjG3LPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 07:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjG3LPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 07:15:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5765B1980
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 04:15:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5221cf2bb8cso5265275a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 04:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690715733; x=1691320533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7+3EyhpcBsHboH41ni+vyFcH49CV73ESCn3SFaRXeg=;
        b=aS/AEAnRGvTu/Qzdq+EmdPenmRpxt31izG6Mc28oX1+wdIHfdxm+VWSZgp8vw9Dnmc
         UuuBjjkmhdmZJlH6FDdIHrLc4SBEyJCYYXF/A5fhYuZ6SihXmYO/CCYOwiZ4/udr6apz
         jBFHgXOVpZRWSBUEv4FuMh88yLZJrv3L3+p2WJZaHisT3Le+x+xHDaMJzqBXdGyo9ds3
         EOS3tHhZsIT+XLSTwSbtrXRfDGztXkq6hsIkrgKZil4qwOQw/m025Uf4BGZJg1qkGRuS
         t9m4KS0btVtztfyUoRNRykkAV2Wf0O7HXl14XI2JwPzEx/5y9XWVdunj5smz5W8YETC9
         GO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690715733; x=1691320533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7+3EyhpcBsHboH41ni+vyFcH49CV73ESCn3SFaRXeg=;
        b=TYXEwloqImfzyE6sffigXgdJdm3qEf219Rg2WkGG8Os2dV0R0Yg3+dnyTbgAPjSatb
         fuy+RAeql15tWJ+GUqe0R/kTdiaklwMTPXHMfpt1g+I8XZTmfXUGzkOLsjlosxhF8JKG
         KW5tzb05pC8rbABQyP/Kue75twGh1UJ2x4QtA2AxKDfs0JEKET25XCtLck4FbOIz14oy
         XfKdu29i4E7KSifPdPCu/VDbQWZGra5H4O9lNskhb0bEY2ebRB4Ufnyq4UQ+9RkxuJDS
         ztFsSmmqZODzD5+hQ/IPpVdMAW/UgdnvGCYg6/6B67YPWsQbNxOTDndkCSIZCiw3WPoh
         U1xw==
X-Gm-Message-State: ABy/qLZyfA8AT0H/acaQhRTIGvzRWH1FnuvHOV4/6VcD6nDewngbwT4s
        3YmcC3j4Y3FeQUS+sivWq8+Wcg==
X-Google-Smtp-Source: APBJJlEa0lxw6eOUJwI4LyWuc/cBUr045qjk6+rh1oV2SaN6dDOC4z9bETSfAyAs8zVWM0qF1/t2jg==
X-Received: by 2002:a17:906:7499:b0:99b:627b:e96d with SMTP id e25-20020a170906749900b0099b627be96dmr5218052ejl.44.1690715733453;
        Sun, 30 Jul 2023 04:15:33 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id x24-20020a170906135800b009930308425csm4481522ejb.31.2023.07.30.04.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 04:15:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: qcom: use defines for interrupts
Date:   Sun, 30 Jul 2023 13:15:30 +0200
Message-Id: <20230730111530.98105-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hard-coded interrupt parts (GIC, flags) with standard defines
for readability.  No changes in resulting DTBs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 44 ++++++++++++------------
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi |  2 +-
 arch/arm/boot/dts/qcom/qcom-msm8660.dtsi | 22 ++++++------
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi |  6 ++--
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi   | 18 +++++-----
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi   | 26 +++++++-------
 6 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index e0adf237fc5c..c693bfc63488 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -190,7 +190,7 @@ cpu_crit3: trip1 {
 
 	cpu-pmu {
 		compatible = "qcom,krait-pmu";
-		interrupts = <1 10 0x304>;
+		interrupts = <GIC_PPI 10 0x304>;
 	};
 
 	clocks {
@@ -244,7 +244,7 @@ apps_smsm: apps@0 {
 
 		modem_smsm: modem@1 {
 			reg = <1>;
-			interrupts = <0 38 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>;
 
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -252,7 +252,7 @@ modem_smsm: modem@1 {
 
 		q6_smsm: q6@2 {
 			reg = <2>;
-			interrupts = <0 89 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_EDGE_RISING>;
 
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -260,7 +260,7 @@ q6_smsm: q6@2 {
 
 		wcnss_smsm: wcnss@3 {
 			reg = <3>;
-			interrupts = <0 204 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 204 IRQ_TYPE_EDGE_RISING>;
 
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -268,7 +268,7 @@ wcnss_smsm: wcnss@3 {
 
 		dsps_smsm: dsps@4 {
 			reg = <4>;
-			interrupts = <0 137 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_EDGE_RISING>;
 
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -316,7 +316,7 @@ tlmm_pinmux: pinctrl@800000 {
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			interrupts = <0 16 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&ps_hold>;
@@ -338,9 +338,9 @@ intc: interrupt-controller@2000000 {
 		timer@200a000 {
 			compatible = "qcom,kpss-wdt-apq8064", "qcom,kpss-timer",
 				     "qcom,msm-timer";
-			interrupts = <1 1 0x301>,
-				     <1 2 0x301>,
-				     <1 3 0x301>;
+			interrupts = <GIC_PPI 1 0x301>,
+				     <GIC_PPI 2 0x301>,
+				     <GIC_PPI 3 0x301>;
 			reg = <0x0200a000 0x100>;
 			clock-frequency = <27000000>;
 			cpu-offset = <0x80000>;
@@ -428,7 +428,7 @@ gsbi1_serial: serial@12450000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x12450000 0x100>,
 				      <0x12400000 0x03>;
-				interrupts = <0 193 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI1_UART_CLK>, <&gcc GSBI1_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -440,7 +440,7 @@ gsbi1_i2c: i2c@12460000 {
 				pinctrl-1 = <&i2c1_pins_sleep>;
 				pinctrl-names = "default", "sleep";
 				reg = <0x12460000 0x1000>;
-				interrupts = <0 194 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI1_QUP_CLK>, <&gcc GSBI1_H_CLK>;
 				clock-names = "core", "iface";
 				#address-cells = <1>;
@@ -469,7 +469,7 @@ gsbi2_i2c: i2c@124a0000 {
 				pinctrl-0 = <&i2c2_pins>;
 				pinctrl-1 = <&i2c2_pins_sleep>;
 				pinctrl-names = "default", "sleep";
-				interrupts = <0 196 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI2_QUP_CLK>, <&gcc GSBI2_H_CLK>;
 				clock-names = "core", "iface";
 				#address-cells = <1>;
@@ -544,7 +544,7 @@ gsbi5_serial: serial@1a240000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x1a240000 0x100>,
 				      <0x1a200000 0x03>;
-				interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI5_UART_CLK>, <&gcc GSBI5_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -553,7 +553,7 @@ gsbi5_serial: serial@1a240000 {
 			gsbi5_spi: spi@1a280000 {
 				compatible = "qcom,spi-qup-v1.1.1";
 				reg = <0x1a280000 0x1000>;
-				interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 				pinctrl-0 = <&spi5_default>;
 				pinctrl-1 = <&spi5_sleep>;
 				pinctrl-names = "default", "sleep";
@@ -580,7 +580,7 @@ gsbi6_serial: serial@16540000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16540000 0x100>,
 				      <0x16500000 0x03>;
-				interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI6_UART_CLK>, <&gcc GSBI6_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -616,7 +616,7 @@ gsbi7_serial: serial@16640000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16640000 0x1000>,
 				      <0x16600000 0x1000>;
-				interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI7_UART_CLK>, <&gcc GSBI7_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -677,7 +677,7 @@ ssbi@500000 {
 			pmicintc: pmic {
 				compatible = "qcom,pm8921";
 				interrupt-parent = <&tlmm_pinmux>;
-				interrupts = <74 8>;
+				interrupts = <74 IRQ_TYPE_LEVEL_LOW>;
 				#interrupt-cells = <2>;
 				interrupt-controller;
 				#address-cells = <1>;
@@ -710,7 +710,7 @@ pm8921_mpps: mpps@50 {
 				rtc@11d {
 					compatible = "qcom,pm8921-rtc";
 					interrupt-parent = <&pmicintc>;
-					interrupts = <39 1>;
+					interrupts = <39 IRQ_TYPE_EDGE_RISING>;
 					reg = <0x11d>;
 					allow-set-time;
 				};
@@ -719,7 +719,7 @@ pwrkey@1c {
 					compatible = "qcom,pm8921-pwrkey";
 					reg = <0x1c>;
 					interrupt-parent = <&pmicintc>;
-					interrupts = <50 1>, <51 1>;
+					interrupts = <50 IRQ_TYPE_EDGE_RISING>, <51 IRQ_TYPE_EDGE_RISING>;
 					debounce = <15625>;
 					pull-up;
 				};
@@ -1084,7 +1084,7 @@ sdcc3: mmc@12180000 {
 		sdcc3bam: dma-controller@12182000 {
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12182000 0x8000>;
-			interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc SDC3_H_CLK>;
 			clock-names = "bam_clk";
 			#dma-cells = <1>;
@@ -1112,7 +1112,7 @@ sdcc4: mmc@121c0000 {
 		sdcc4bam: dma-controller@121c2000 {
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x121c2000 0x8000>;
-			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc SDC4_H_CLK>;
 			clock-names = "bam_clk";
 			#dma-cells = <1>;
@@ -1141,7 +1141,7 @@ sdcc1: mmc@12400000 {
 		sdcc1bam: dma-controller@12402000 {
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12402000 0x8000>;
-			interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc SDC1_H_CLK>;
 			clock-names = "bam_clk";
 			#dma-cells = <1>;
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
index 1e06f76a7369..10e9ca281a3f 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
@@ -162,7 +162,7 @@ scm {
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <1 2 0xf08>,
+		interrupts = <GIC_PPI 2 0xf08>,
 			     <1 3 0xf08>,
 			     <1 4 0xf08>,
 			     <1 1 0xf08>;
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
index 78023ed2fdf7..735b71dbe744 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
@@ -47,7 +47,7 @@ memory {
 
 	cpu-pmu {
 		compatible = "qcom,scorpion-mp-pmu";
-		interrupts = <1 9 0x304>;
+		interrupts = <GIC_PPI 9 0x304>;
 	};
 
 	clocks {
@@ -105,9 +105,9 @@ intc: interrupt-controller@2080000 {
 
 		timer@2000000 {
 			compatible = "qcom,scss-timer", "qcom,msm-timer";
-			interrupts = <1 0 0x301>,
-				     <1 1 0x301>,
-				     <1 2 0x301>;
+			interrupts = <GIC_PPI 0 0x301>,
+				     <GIC_PPI 1 0x301>,
+				     <GIC_PPI 2 0x301>;
 			reg = <0x02000000 0x100>;
 			clock-frequency = <27000000>,
 					  <32768>;
@@ -121,7 +121,7 @@ tlmm: pinctrl@800000 {
 			gpio-controller;
 			gpio-ranges = <&tlmm 0 0 173>;
 			#gpio-cells = <2>;
-			interrupts = <0 16 0x4>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
@@ -299,7 +299,7 @@ gsbi12_serial: serial@19c40000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x19c40000 0x1000>,
 				      <0x19c00000 0x1000>;
-				interrupts = <0 195 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI12_UART_CLK>, <&gcc GSBI12_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -308,7 +308,7 @@ gsbi12_serial: serial@19c40000 {
 			gsbi12_i2c: i2c@19c80000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x19c80000 0x1000>;
-				interrupts = <0 196 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI12_QUP_CLK>, <&gcc GSBI12_H_CLK>;
 				clock-names = "core", "iface";
 				#address-cells = <1>;
@@ -342,7 +342,7 @@ ssbi@500000 {
 			pm8058: pmic {
 				compatible = "qcom,pm8058";
 				interrupt-parent = <&tlmm>;
-				interrupts = <88 8>;
+				interrupts = <88 IRQ_TYPE_LEVEL_LOW>;
 				#interrupt-cells = <2>;
 				interrupt-controller;
 				#address-cells = <1>;
@@ -375,7 +375,7 @@ pwrkey@1c {
 					compatible = "qcom,pm8058-pwrkey";
 					reg = <0x1c>;
 					interrupt-parent = <&pm8058>;
-					interrupts = <50 1>, <51 1>;
+					interrupts = <50 IRQ_TYPE_EDGE_RISING>, <51 IRQ_TYPE_EDGE_RISING>;
 					debounce = <15625>;
 					pull-up;
 				};
@@ -384,7 +384,7 @@ pm8058_keypad: keypad@148 {
 					compatible = "qcom,pm8058-keypad";
 					reg = <0x148>;
 					interrupt-parent = <&pm8058>;
-					interrupts = <74 1>, <75 1>;
+					interrupts = <74 IRQ_TYPE_EDGE_RISING>, <75 IRQ_TYPE_EDGE_RISING>;
 					debounce = <15>;
 					scan-delay = <32>;
 					row-hold = <91500>;
@@ -437,7 +437,7 @@ rtc@1e8 {
 					compatible = "qcom,pm8058-rtc";
 					reg = <0x1e8>;
 					interrupt-parent = <&pm8058>;
-					interrupts = <39 1>;
+					interrupts = <39 IRQ_TYPE_EDGE_RISING>;
 					allow-set-time;
 				};
 
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index 706fef53767e..d6bd42fc55e1 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -518,7 +518,7 @@ blsp1_i2c1: i2c@f9923000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9923000 0x1000>;
-			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			pinctrl-names = "default", "sleep";
@@ -546,7 +546,7 @@ blsp1_i2c3: i2c@f9925000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9925000 0x1000>;
-			interrupts = <0 97 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			pinctrl-names = "default", "sleep";
@@ -646,7 +646,7 @@ blsp2_i2c6: i2c@f9968000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9968000 0x1000>;
-			interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP2_QUP6_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
 			pinctrl-names = "default", "sleep";
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 55ce87b75253..20bf6560a6b9 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -740,57 +740,57 @@ timer@17820000 {
 
 			frame@17821000 {
 				frame-number = <0>;
-				interrupts = <GIC_SPI 7 0x4>,
-					     <GIC_SPI 6 0x4>;
+				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17821000 0x1000>,
 				      <0x17822000 0x1000>;
 			};
 
 			frame@17823000 {
 				frame-number = <1>;
-				interrupts = <GIC_SPI 8 0x4>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17823000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17824000 {
 				frame-number = <2>;
-				interrupts = <GIC_SPI 9 0x4>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17824000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17825000 {
 				frame-number = <3>;
-				interrupts = <GIC_SPI 10 0x4>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17825000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17826000 {
 				frame-number = <4>;
-				interrupts = <GIC_SPI 11 0x4>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17826000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17827000 {
 				frame-number = <5>;
-				interrupts = <GIC_SPI 12 0x4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17827000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17828000 {
 				frame-number = <6>;
-				interrupts = <GIC_SPI 13 0x4>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17828000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17829000 {
 				frame-number = <7>;
-				interrupts = <GIC_SPI 14 0x4>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17829000 0x1000>;
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
index 1a3583029a64..8fff67d7a5e9 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
@@ -665,57 +665,57 @@ timer@17820000 {
 
 			frame@17821000 {
 				frame-number = <0>;
-				interrupts = <GIC_SPI 7 0x4>,
-					     <GIC_SPI 6 0x4>;
+				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17821000 0x1000>,
 				      <0x17822000 0x1000>;
 			};
 
 			frame@17823000 {
 				frame-number = <1>;
-				interrupts = <GIC_SPI 8 0x4>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17823000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17824000 {
 				frame-number = <2>;
-				interrupts = <GIC_SPI 9 0x4>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17824000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17825000 {
 				frame-number = <3>;
-				interrupts = <GIC_SPI 10 0x4>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17825000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17826000 {
 				frame-number = <4>;
-				interrupts = <GIC_SPI 11 0x4>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17826000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17827000 {
 				frame-number = <5>;
-				interrupts = <GIC_SPI 12 0x4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17827000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17828000 {
 				frame-number = <6>;
-				interrupts = <GIC_SPI 13 0x4>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17828000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17829000 {
 				frame-number = <7>;
-				interrupts = <GIC_SPI 14 0x4>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17829000 0x1000>;
 				status = "disabled";
 			};
@@ -802,10 +802,10 @@ apps_bcm_voter: bcm-voter {
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <1 13 0xf08>,
-			<1 12 0xf08>,
-			<1 10 0xf08>,
-			<1 11 0xf08>;
+		interrupts = <GIC_PPI 13 0xf08>,
+			     <GIC_PPI 12 0xf08>,
+			     <GIC_PPI 10 0xf08>,
+			     <GIC_PPI 11 0xf08>;
 		clock-frequency = <19200000>;
 	};
 };
-- 
2.34.1

