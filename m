Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CC37AB68E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjIVQ4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjIVQz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:55:58 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00837114;
        Fri, 22 Sep 2023 09:55:49 -0700 (PDT)
Received: from [192.168.178.23] (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 6E97AD0F56;
        Fri, 22 Sep 2023 16:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1695401748; bh=GJWbp0yNmezRqNlFG1Tmg62rLzGTuqKy0Vjb8rr6bHc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=QVw72Akovv+yT5kYbZFSLlmcnrBCQKACFMq/D2rdJQxXCWWXEEDOzz/KEOcaaF/vN
         cEXipdlYNcG7in6fTnpb+IMh1oz8OV4wKf/7ChFrfYS7g6d7f7974XmnhC/QZQm8de
         RFcHMzrkLX6tg5AcLDfD9cuB8HHVMfuCnvpuq7iA=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 22 Sep 2023 18:55:14 +0200
Subject: [PATCH v2 3/3] ARM: dts: qcom: msm8226: Add blsp1_i2c6 and
 blsp1_uart2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230922-msm8226-i2c6-v2-3-3fb55c47a084@z3ntu.xyz>
References: <20230922-msm8226-i2c6-v2-0-3fb55c47a084@z3ntu.xyz>
In-Reply-To: <20230922-msm8226-i2c6-v2-0-3fb55c47a084@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=GJWbp0yNmezRqNlFG1Tmg62rLzGTuqKy0Vjb8rr6bHc=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlDccSZDKWbcCeDfvwMLYz94Bpu9O4+bsG2TC1F
 ulQGb193mSJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZQ3HEgAKCRBy2EO4nU3X
 VgXqD/9ltSJS41hhIq+c+OgR7pkd94q7B4huz4TXaX7it6s7CGj0KLgmflMVK1+oweEZOWywBSb
 SSfgHBNRfNbXiPGhnFWA1oKTrOtextf4XUdX0RnCq7/nLz0F1h4xWiK7Ikd9xhLlw66XhRAd+lB
 vNOXFzurVT/pFjxLnqbRIDmZFGkIIkdx4QtUaqwKkyPEhqpxmvIvtofoZv8mOUqtza+oS0RovRe
 7oHRbadIrNH1HSIsH81ZnWga6g74IsELt6xNOvmLOf13dnY+aETS69JqrqPnjZ5KYE4PF5Yg+hC
 hv+byNKSlDCW+tmj1HOlFGkw/AVHGZJ1kv26r27XiX7TD4Uj0n4ykUQq7bCTI2WUgZEG//7siIP
 6eZ/sYM634LKPLtOdJYcIfOM1t7vHkdpDKsxV4DGe2IseGpHU7gY6TdeWCYWLDZrLAUT3mry9ut
 wocUmNcsm3EJ2/rlD208HuYlgIrbJBgKLfOiwe0De+pPV9oud+bZ93XBdwX4jVn2Ka5CT1bDHG7
 CO24FYEtK9f1RezhpC3miDRdOFGXOK0siPNMp5zIJV6S2vf38YWYKmvMVXpDzDRgDPJdOfEE+oh
 eij0Y9Yjcse++UXQO/JP20EnduMSABg+tPbtBRmDFloJTTP4P/1hKJvqrk86JXjYbjt49xed3G5
 UgToEk8X7xiAocg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more busses found on msm8226 SoC.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
index 44f3f0127fd7..82e830e9d254 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
@@ -230,6 +230,17 @@ blsp1_uart1: serial@f991d000 {
 			status = "disabled";
 		};
 
+		blsp1_uart2: serial@f991e000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0xf991e000 0x1000>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core",
+				      "iface";
+			status = "disabled";
+		};
+
 		blsp1_uart3: serial@f991f000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf991f000 0x1000>;
@@ -313,6 +324,21 @@ blsp1_i2c5: i2c@f9927000 {
 			#size-cells = <0>;
 		};
 
+		blsp1_i2c6: i2c@f9928000 {
+			compatible = "qcom,i2c-qup-v2.1.1";
+			reg = <0xf9928000 0x1000>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core",
+				      "iface";
+			pinctrl-0 = <&blsp1_i2c6_pins>;
+			pinctrl-names = "default";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		cci: cci@fda0c000 {
 			compatible = "qcom,msm8226-cci";
 			#address-cells = <1>;
@@ -460,6 +486,13 @@ blsp1_i2c5_pins: blsp1-i2c5-state {
 				bias-disable;
 			};
 
+			blsp1_i2c6_pins: blsp1-i2c6-state {
+				pins = "gpio22", "gpio23";
+				function = "blsp_i2c6";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			cci_default: cci-default-state {
 				pins = "gpio29", "gpio30";
 				function = "cci_i2c0";

-- 
2.42.0

