Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DAC7908EF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 19:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjIBRdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 13:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjIBRdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 13:33:17 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B0AA4;
        Sat,  2 Sep 2023 10:33:12 -0700 (PDT)
Received: from [192.168.178.23] (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 8DAA1D0765;
        Sat,  2 Sep 2023 17:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1693675960; bh=G4bv/044FBMyHyk8YKL12LUcdZXw2wbi25M7HJWmSFg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=OUHdblhBKl0J+Hq+80CLIyJwob2kBvtCXtzBZ+ijhM92C9m6FpZbguHnPadTLNk1M
         N+f0DqODnm7o53sfhXJKsjiY0tfcTnSvNrOJRUWFSBX6Ilq/88UnGzV1Cko+hlMGe9
         JF8V4mJsZa/G0k6OJMTFgID44UKIdHTrmNgW3AwE=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sat, 02 Sep 2023 19:32:25 +0200
Subject: [PATCH 2/2] ARM: dts: qcom: msm8226: Add blsp1_i2c6 and
 blsp1_uart2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230902-msm8226-i2c6-v1-2-9632b8916789@z3ntu.xyz>
References: <20230902-msm8226-i2c6-v1-0-9632b8916789@z3ntu.xyz>
In-Reply-To: <20230902-msm8226-i2c6-v1-0-9632b8916789@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=G4bv/044FBMyHyk8YKL12LUcdZXw2wbi25M7HJWmSFg=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBk83G2DhWrNqjFx3CXw3XnCTRHFRK3VDIXBT3XW
 /dKsn9sG12JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZPNxtgAKCRBy2EO4nU3X
 VlIVD/4vwLTbuMhonqEjzU0Xzyl8fEVjlBFQ8/kRU+CjiTf4+1i3qRJwnb7ZRRBWg/7usSZUF2r
 xw13/iCEP8k8wswrKGSCoRYqQSF10S0BzHrsNH1cVC9T9tcn4bB15eKk7kQKHl/aKCderzLWX50
 6h6fipNgQvS+b7BwWt8iA4SzwRb6lhEVLhiLMED2z1Ps/2osU7o4vfFutV7IoaQCin9njf8ZnwC
 kqWjDSJ1d9dmSJrymIq70GF016b1LvHX3AZobiB+MNosiMcT4wReNTcBIPBfKgSk41liiuYzThB
 pO4+27xRDqNQFVXe0w9MiNz0fkhUUNj5uDS8ZL9TkBocVaMbTWMh07/hbIsLMsaKKVnlNeNhamr
 p84SnrSmO0drxkIpkI6w3m97pdySMVEibZWvpDQh1dGA0CH8fntkN6B0Vehmke16PjYV0Jl8iso
 UmZBtG8XYfUjm2FJNBrsXJbiOaOkv6Ck4rQmtcSs5ziVjcjJX6XxKegaC8nAzdts5BIFLQykQyO
 NpaGcttPI5adGXxeShTIIndTd4286xg6N69oSATRGTOc9L3KfOwt8URbldLrFDibio6wbf+wykR
 v4X4zDJnDifyg5L6cT+1ssZfcH//LxduZG8KO2BgJlWsQNC/Tkh+WIHhwG/X1pQ1j4y72mTgNAv
 ZSjtdj34q/wUilA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more busses found on msm8226 SoC.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
index b6ae4b7936e3..3b6114049e61 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
@@ -230,6 +230,15 @@ blsp1_uart1: serial@f991d000 {
 			status = "disabled";
 		};
 
+		blsp1_uart2: serial@f991e000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0xf991e000 0x1000>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
 		blsp1_uart3: serial@f991f000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf991f000 0x1000>;
@@ -313,6 +322,19 @@ blsp1_i2c5: i2c@f9927000 {
 			#size-cells = <0>;
 		};
 
+		blsp1_i2c6: i2c@f9928000 {
+			status = "disabled";
+			compatible = "qcom,i2c-qup-v2.1.1";
+			reg = <0xf9928000 0x1000>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_i2c6_pins>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		cci: cci@fda0c000 {
 			compatible = "qcom,msm8226-cci";
 			#address-cells = <1>;
@@ -460,6 +482,13 @@ blsp1_i2c5_pins: blsp1-i2c5-state {
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

