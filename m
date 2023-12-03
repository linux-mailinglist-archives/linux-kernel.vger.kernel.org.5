Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E7980253F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 16:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjLCPtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 10:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjLCPtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 10:49:12 -0500
X-Greylist: delayed 572 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Dec 2023 07:49:16 PST
Received: from mail-m6023.netease.com (mail-m6023.netease.com [210.79.60.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487D6D7;
        Sun,  3 Dec 2023 07:49:16 -0800 (PST)
Received: from Vostro-3710.lan (unknown [119.122.215.53])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 69DE3800089;
        Sun,  3 Dec 2023 23:39:21 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 1/1] arm64: dts: qcom: ipq6018: Add remaining QUP UART node
Date:   Sun,  3 Dec 2023 23:39:14 +0800
Message-Id: <20231203153914.532654-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGk5NVh1NTR5OTR9DQx0aH1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKQlVKSUlVSUpOVU5IWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8c30558aecb03akuuu69de3800089
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORQ6DBw5Tzw3SwkXVj49NxI*
        EBEwFA9VSlVKTEtKTUpMQk1JSUJDVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
        QlVKSUlVSUpOVU5IWVdZCAFZQUhCTkI3Bg++
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node to support all the QUP UART node controller inside of IPQ6018.
Some routers use these bus to connect Bluetooth chips.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
Changes in v2:
* No changes, resend due to error link to other threads.

 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 50 +++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 9aec89d5e095..ec0a0ce1849e 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -439,6 +439,26 @@ blsp_dma: dma-controller@7884000 {
 			qcom,ee = <0>;
 		};
 
+		blsp1_uart1: serial@78af000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x0 0x78af000 0x0 0x200>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		blsp1_uart2: serial@78b0000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x0 0x78b0000 0x0 0x200>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
 		blsp1_uart3: serial@78b1000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x0 0x078b1000 0x0 0x200>;
@@ -449,6 +469,36 @@ blsp1_uart3: serial@78b1000 {
 			status = "disabled";
 		};
 
+		blsp1_uart4: serial@78b2000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x0 0x078b2000 0x0 0x200>;
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART4_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		blsp1_uart5: serial@78b3000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x0 0x78b3000 0x0 0x200>;
+			interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART5_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		blsp1_uart6: serial@78b4000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x0 0x078b4000 0x0 0x200>;
+			interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART6_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
 		blsp1_spi1: spi@78b5000 {
 			compatible = "qcom,spi-qup-v2.2.1";
 			#address-cells = <1>;
-- 
2.25.1

