Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7899F767386
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjG1RfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjG1RfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:35:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C373A85;
        Fri, 28 Jul 2023 10:34:58 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36SHYi8a002927;
        Fri, 28 Jul 2023 12:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690565684;
        bh=Z55/HUIXK8orSYloXnAC1hgDacmy2ij7nqKkB6P1BSQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ShiqEPghP6ebDPknv7NGpOHR6C4M+kL5tueI0GyaXZgSHi8W6zAb3kGZa3wvoYQ3Z
         3lCjSeReMXSc8zbn2TRhwa65y3TQXdLFSQ2F5G9FZlI2EN8H3vpj4ZswS46CcqIm8O
         AaDKIuYJrDJP5FpehSxCXQxNkNEdGHAopjruXj+4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36SHYiZG061048
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jul 2023 12:34:44 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jul 2023 12:34:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jul 2023 12:34:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36SHYhlc130299;
        Fri, 28 Jul 2023 12:34:44 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v3 3/8] arm64: dts: ti: k3-am62x-sk-common: Add DSS pinmux info
Date:   Fri, 28 Jul 2023 23:04:33 +0530
Message-ID: <20230728173438.12995-4-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728173438.12995-1-a-bhatia1@ti.com>
References: <20230728173438.12995-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinmux info for video output signals from DSS and OLDI.

The DSS outputs OLDI signals through its first video port (VP1) and DPI
signals via its second video port (VP2). DSS has 2 OLDI transmitters,
and each of them outputs 4 Data Lanes and 1 Clock Lane. The DPI output
from DSS is 24 bits (RGB888) and is forwarded to an HDMI transmitter
(SIL9022) on the board.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 540ed8a0d7fb..d479c0c415a7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -226,6 +226,64 @@ AM62X_IOPAD(0x08c, PIN_OUTPUT, 2) /* (L25/J17) GPMC0_WEN.MCASP1_AXR0 */
 			AM62X_IOPAD(0x084, PIN_INPUT, 2) /* (L23/K20) GPMC0_ADVN_ALE.MCASP1_AXR2 */
 		>;
 	};
+
+	main_dss0_pins_default: main-dss0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0100, PIN_OUTPUT, 0) /* (AC25) VOUT0_VSYNC */
+			AM62X_IOPAD(0x00f8, PIN_OUTPUT, 0) /* (AB24) VOUT0_HSYNC */
+			AM62X_IOPAD(0x0104, PIN_OUTPUT, 0) /* (AC24) VOUT0_PCLK */
+			AM62X_IOPAD(0x00fc, PIN_OUTPUT, 0) /* (Y20) VOUT0_DE */
+			AM62X_IOPAD(0x00b8, PIN_OUTPUT, 0) /* (U22) VOUT0_DATA0 */
+			AM62X_IOPAD(0x00bc, PIN_OUTPUT, 0) /* (V24) VOUT0_DATA1 */
+			AM62X_IOPAD(0x00c0, PIN_OUTPUT, 0) /* (W25) VOUT0_DATA2 */
+			AM62X_IOPAD(0x00c4, PIN_OUTPUT, 0) /* (W24) VOUT0_DATA3 */
+			AM62X_IOPAD(0x00c8, PIN_OUTPUT, 0) /* (Y25) VOUT0_DATA4 */
+			AM62X_IOPAD(0x00cc, PIN_OUTPUT, 0) /* (Y24) VOUT0_DATA5 */
+			AM62X_IOPAD(0x00d0, PIN_OUTPUT, 0) /* (Y23) VOUT0_DATA6 */
+			AM62X_IOPAD(0x00d4, PIN_OUTPUT, 0) /* (AA25) VOUT0_DATA7 */
+			AM62X_IOPAD(0x00d8, PIN_OUTPUT, 0) /* (V21) VOUT0_DATA8 */
+			AM62X_IOPAD(0x00dc, PIN_OUTPUT, 0) /* (W21) VOUT0_DATA9 */
+			AM62X_IOPAD(0x00e0, PIN_OUTPUT, 0) /* (V20) VOUT0_DATA10 */
+			AM62X_IOPAD(0x00e4, PIN_OUTPUT, 0) /* (AA23) VOUT0_DATA11 */
+			AM62X_IOPAD(0x00e8, PIN_OUTPUT, 0) /* (AB25) VOUT0_DATA12 */
+			AM62X_IOPAD(0x00ec, PIN_OUTPUT, 0) /* (AA24) VOUT0_DATA13 */
+			AM62X_IOPAD(0x00f0, PIN_OUTPUT, 0) /* (Y22) VOUT0_DATA14 */
+			AM62X_IOPAD(0x00f4, PIN_OUTPUT, 0) /* (AA21) VOUT0_DATA15 */
+			AM62X_IOPAD(0x005c, PIN_OUTPUT, 1) /* (R24) GPMC0_AD8.VOUT0_DATA16 */
+			AM62X_IOPAD(0x0060, PIN_OUTPUT, 1) /* (R25) GPMC0_AD9.VOUT0_DATA17 */
+			AM62X_IOPAD(0x0064, PIN_OUTPUT, 1) /* (T25) GPMC0_AD10.VOUT0_DATA18 */
+			AM62X_IOPAD(0x0068, PIN_OUTPUT, 1) /* (R21) GPMC0_AD11.VOUT0_DATA19 */
+			AM62X_IOPAD(0x006c, PIN_OUTPUT, 1) /* (T22) GPMC0_AD12.VOUT0_DATA20 */
+			AM62X_IOPAD(0x0070, PIN_OUTPUT, 1) /* (T24) GPMC0_AD13.VOUT0_DATA21 */
+			AM62X_IOPAD(0x0074, PIN_OUTPUT, 1) /* (U25) GPMC0_AD14.VOUT0_DATA22 */
+			AM62X_IOPAD(0x0078, PIN_OUTPUT, 1) /* (U24) GPMC0_AD15.VOUT0_DATA23 */
+		>;
+	};
+
+	main_oldi0_pins_default: main-oldi0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0260, PIN_OUTPUT, 0) /* (AA5) OLDI0_A0N */
+			AM62X_IOPAD(0x025c, PIN_OUTPUT, 0) /* (Y6) OLDI0_A0P */
+			AM62X_IOPAD(0x0268, PIN_OUTPUT, 0) /* (AD3) OLDI0_A1N */
+			AM62X_IOPAD(0x0264, PIN_OUTPUT, 0) /* (AB4) OLDI0_A1P */
+			AM62X_IOPAD(0x0270, PIN_OUTPUT, 0) /* (Y8) OLDI0_A2N */
+			AM62X_IOPAD(0x026c, PIN_OUTPUT, 0) /* (AA8) OLDI0_A2P */
+			AM62X_IOPAD(0x0278, PIN_OUTPUT, 0) /* (AB6) OLDI0_A3N */
+			AM62X_IOPAD(0x0274, PIN_OUTPUT, 0) /* (AA7) OLDI0_A3P */
+			AM62X_IOPAD(0x0280, PIN_OUTPUT, 0) /* (AC6) OLDI0_A4N */
+			AM62X_IOPAD(0x027c, PIN_OUTPUT, 0) /* (AC5) OLDI0_A4P */
+			AM62X_IOPAD(0x0288, PIN_OUTPUT, 0) /* (AE5) OLDI0_A5N */
+			AM62X_IOPAD(0x0284, PIN_OUTPUT, 0) /* (AD6) OLDI0_A5P */
+			AM62X_IOPAD(0x0290, PIN_OUTPUT, 0) /* (AE6) OLDI0_A6N */
+			AM62X_IOPAD(0x028c, PIN_OUTPUT, 0) /* (AD7) OLDI0_A6P */
+			AM62X_IOPAD(0x0298, PIN_OUTPUT, 0) /* (AD8) OLDI0_A7N */
+			AM62X_IOPAD(0x0294, PIN_OUTPUT, 0) /* (AE7) OLDI0_A7P */
+			AM62X_IOPAD(0x02a0, PIN_OUTPUT, 0) /* (AD4) OLDI0_CLK0N */
+			AM62X_IOPAD(0x029c, PIN_OUTPUT, 0) /* (AE3) OLDI0_CLK0P */
+			AM62X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (AE4) OLDI0_CLK1N */
+			AM62X_IOPAD(0x02a4, PIN_OUTPUT, 0) /* (AD5) OLDI0_CLK1P */
+		>;
+	};
 };
 
 &mcu_pmx0 {
@@ -410,3 +468,8 @@ &mcasp1 {
 	tx-num-evt = <32>;
 	rx-num-evt = <32>;
 };
+
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_dss0_pins_default &main_oldi0_pins_default>;
+};
-- 
2.40.1

