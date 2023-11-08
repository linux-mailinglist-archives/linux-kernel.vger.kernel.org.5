Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3157E5E73
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjKHTRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjKHTRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:17:07 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D8B210E;
        Wed,  8 Nov 2023 11:17:05 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A8JGr3r027277;
        Wed, 8 Nov 2023 13:16:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699471013;
        bh=NMhYGXJRyOK/yzQfDKagVg0su+ebpTginWly+7LsBDA=;
        h=From:To:CC:Subject:Date;
        b=n57j9mLx7kBwMLmZcHXynZptwXhnaBT1KK049dboFjRttixqNEI+7BvSM4iSFkj4M
         GHz9kk8PjaeVcKU/HdFDg7WB5v+HgAz9Qidtsr2RLcij4cV6navDBUF7ONSa7TiJNh
         AUAdH+5MD+abuvPaABMCz3zCb2Y/xwvCJxhFjk7U=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A8JGr3i053833
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Nov 2023 13:16:53 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 Nov 2023 13:16:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 Nov 2023 13:16:53 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A8JGqQQ030283;
        Wed, 8 Nov 2023 13:16:53 -0600
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62a7-sk: Add interrupt support for IO Expander
Date:   Thu, 9 Nov 2023 00:46:52 +0530
Message-ID: <20231108191652.1118155-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hot Plug Detect (HPD) signal for the HDMI display travels from the
on-board HDMI connector, through the IO Expander 1, and finally to the
main_gpio1 line #23, of the SoC.

Add interrupt information for the IO Expander 1 (exp1).
Also add pinmux info of main gpio 1, line #23.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---

Notes:

  - HDMI display on AM62A7 is not in the mainline yet. All the patches,
    including this one, required to enable HDMI display and HPD on
    AM62A7 SK-EVM, can be found on my github fork in the branch
    "next_am62a-v3"[0].

[0]: https://github.com/aradhya07/linux-ab/tree/next_am62a-v3

 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 8f64ac2c7568..560dad02ef62 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -274,6 +274,12 @@ AM62AX_IOPAD(0x08c, PIN_OUTPUT, 2) /* (K19) GPMC0_WEn.MCASP1_AXR0 */
 			AM62AX_IOPAD(0x084, PIN_INPUT, 2) /* (L18) GPMC0_ADVn_ALE.MCASP1_AXR2 */
 		>;
 	};
+
+	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x01d4, PIN_INPUT, 7) /* (C15) UART0_RTSn.GPIO1_23 */
+		>;
+	};
 };
 
 &mcu_pmx0 {
@@ -407,6 +413,12 @@ exp1: gpio@22 {
 		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
 
 		gpio-line-names = "GPIO_CPSW2_RST", "GPIO_CPSW1_RST",
 				   "BT_EN_SOC", "MMC1_SD_EN",

base-commit: 2220f68f4504aa1ccce0fac721ccdb301e9da32f
-- 
2.42.0

