Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B8277A0E8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjHLPw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHLPwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:52:54 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D612E4D;
        Sat, 12 Aug 2023 08:52:56 -0700 (PDT)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id BBA8516074D;
        Sat, 12 Aug 2023 17:52:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1691855573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nKiwwtStQeo2iwbfC4NwzJYRLyuxnMS+WXh6ZsB/n9M=;
        b=zKt4VY3CyU/vtZfBzyvaTg0zgCE5xWbYb2TGv88rAXPv6BIW6hoU9HagxjXMs9thoVu0Dy
        mR6Cwy/QN5518UKRi9DyU4+aYokn5BCZ7EtBTq2mjZW3zl4RwY3yR7U7Nn51/L/rU6D8WJ
        AlNoKHTmqthlhCbQMvnihQ+j/rbGxss=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     David Heidelberg <david@ixit.cz>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: apq8064: add support to gsbi4 uart
Date:   Sat, 12 Aug 2023 17:52:34 +0200
Message-Id: <20230812155234.338016-1-david@ixit.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to gsbi4 uart which is used in LG Mako.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi      | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi
index 1f15186dd710..a939b7336506 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi
@@ -233,6 +233,22 @@ pinconf {
 		};
 	};
 
+	gsbi4_uart_pin_a: gsbi4-uart-pin-active {
+		rx {
+			pins = "gpio11";
+			function = "gsbi4";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		tx {
+			pins = "gpio10";
+			function = "gsbi4";
+			drive-strength = <4>;
+			bias-disable;
+		};
+	};
+
 	gsbi6_uart_2pins: gsbi6_uart_2pins {
 		mux {
 			pins = "gpio14", "gpio15";
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 2ab69dd69862..870205028f5c 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -547,6 +547,18 @@ gsbi4: gsbi@16300000 {
 			#size-cells = <1>;
 			ranges;
 
+			gsbi4_serial: serial@16340000 {
+				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+				reg = <0x16340000 0x100>,
+				      <0x16300000 0x3>;
+				interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&gsbi4_uart_pin_a>;
+				pinctrl-names = "default";
+				clocks = <&gcc GSBI4_UART_CLK>, <&gcc GSBI4_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+			};
+
 			gsbi4_i2c: i2c@16380000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				pinctrl-0 = <&i2c4_pins>;
-- 
2.40.1

