Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F01076B71D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjHAOTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjHAOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:19:41 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359F4BF;
        Tue,  1 Aug 2023 07:19:40 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 371EJWqX055662;
        Tue, 1 Aug 2023 09:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690899572;
        bh=n2rRx8pB8T/Zi6wh1widcHtcJC9FOdfiiBjMAQ0+Ras=;
        h=From:To:CC:Subject:Date;
        b=ZVSg8ir4Kkl0kq9EO4aT9AFj/VQbL/UJl93vLwYGxBu+5YX4j2ri9Bv++1RAl3g4r
         ru2VZy16ab4KIcEUR84jfz2CJ8nXqf7nrHFSiNNHSK0WYZXjxeLXPUuttLw55PzN3i
         jyvnjzPN1pU2IrlujweJXxvOiUOHTdfn3eJQtDBw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 371EJW3T029849
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 09:19:32 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 09:19:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 09:19:32 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 371EJS3g022895;
        Tue, 1 Aug 2023 09:19:29 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <t-konduru@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j784s4-evm: Correct Pin mux offset for ospi
Date:   Tue, 1 Aug 2023 19:49:20 +0530
Message-ID: <20230801141920.3317697-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After splitting wkup_pmx pin mux for J784S4 into four regions.
Pin mux offset for OSPI nodes were not updated to align with new
regions, due to this while setting ospi pin muxes out of range
error was seen.

Pin mux offsets for OSPI nodes are corrected in this patch.

Fixes: 14462bd0b247 ("arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and pinctrl node offsets")
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Original test log
https://gist.github.com/uditkumarti/85b5076df99c3019aa56da4268724295
line 1104 and 1107, out of range error is seen

Test log with patch
https://gist.github.com/uditkumarti/29b424d0a1527e77947f72d2e8a38f01

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 31 +++++++++++++++---------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 7ad152a1b90f..1961cd819f5e 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -379,21 +379,28 @@ J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D34) MCU_OSPI0_D5 */
 			J784S4_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (E34) MCU_OSPI0_D6 */
 			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (E33) MCU_OSPI0_D7 */
 			J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
-			J784S4_WKUP_IOPAD(0x03c, PIN_OUTPUT, 6) /* (C32) MCU_OSPI0_CSn3.MCU_OSPI0_ECC_FAIL */
-			J784S4_WKUP_IOPAD(0x038, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_CSn2.MCU_OSPI0_RESET_OUT0 */
+		>;
+	};
+};
+
+&wkup_pmx1 {
+	mcu_fss0_ospi0_pins1_default: mcu-fss0-ospi0-default-pins1 {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x004, PIN_OUTPUT, 6) /* (C32) MCU_OSPI0_ECC_FAIL */
+			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_RESET_OUT0 */
 		>;
 	};
 
-	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-default-pins {
+	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-pins-default {
 		pinctrl-single,pins = <
-			J784S4_WKUP_IOPAD(0x040, PIN_OUTPUT, 0) /* (F32) MCU_OSPI1_CLK */
-			J784S4_WKUP_IOPAD(0x05c, PIN_OUTPUT, 0) /* (G32) MCU_OSPI1_CSn0 */
-			J784S4_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (E35) MCU_OSPI1_D0 */
-			J784S4_WKUP_IOPAD(0x050, PIN_INPUT, 0) /* (D31) MCU_OSPI1_D1 */
-			J784S4_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (G31) MCU_OSPI1_D2 */
-			J784S4_WKUP_IOPAD(0x058, PIN_INPUT, 0) /* (F33) MCU_OSPI1_D3 */
-			J784S4_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (F31) MCU_OSPI1_DQS */
-			J784S4_WKUP_IOPAD(0x044, PIN_INPUT, 0) /* (C31) MCU_OSPI1_LBCLKO */
+			J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (F32) MCU_OSPI1_CLK */
+			J784S4_WKUP_IOPAD(0x024, PIN_OUTPUT, 0) /* (G32) MCU_OSPI1_CSn0 */
+			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (E35) MCU_OSPI1_D0 */
+			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (D31) MCU_OSPI1_D1 */
+			J784S4_WKUP_IOPAD(0x01C, PIN_INPUT, 0) /* (G31) MCU_OSPI1_D2 */
+			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (F33) MCU_OSPI1_D3 */
+			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (F31) MCU_OSPI1_DQS */
+			J784S4_WKUP_IOPAD(0x00C, PIN_INPUT, 0) /* (C31) MCU_OSPI1_LBCLKO */
 		>;
 	};
 };
@@ -437,7 +444,7 @@ &fss {
 &ospi0 {
 	status = "okay";
 	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
+	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>, <&mcu_fss0_ospi0_pins1_default>;
 
 	flash@0 {
 		compatible = "jedec,spi-nor";
-- 
2.34.1

