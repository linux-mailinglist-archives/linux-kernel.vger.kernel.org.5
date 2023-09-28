Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4909B7B1B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjI1Lpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjI1Lpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:45:38 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D391C9C;
        Thu, 28 Sep 2023 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1695901536; x=1727437536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EnjcF8thYe5kjKLOpP9xHh/GIEKF/HW45uCb1c/GqF0=;
  b=gVgesdl/+TbsDvqtnmRP1NtQn+wYqZVtjNgT9so+0yCaPX6SsTcOpk6K
   Lf93sL2Y4vdr7aPXnGyt59P417Hy63MAndVOSoOBSTlagj+hr2q7p7/D0
   Pote+6pTThVZM+GQy1xUBbcp/0OUzZ5yLMYGrLR0fTH6T3ZCAz0ImhlAP
   adpJhEUdnzId04CnA72yfhVn9yrQV4pf1TrIEpiJsFV5ePxw7VXJbVnyc
   SVxNafEmKn9swE1F0z9wl9cVjBe/KsbFW901uVl/sA180dcylHdEbSwBY
   St3rjFsyhEGCjE2CodO6p6D2R6QMYP4mAkytLIxXdTf7QmuA64EgxsWJf
   g==;
X-IronPort-AV: E=Sophos;i="6.03,183,1694728800"; 
   d="scan'208";a="33198950"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Sep 2023 13:45:30 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 2318E280084;
        Thu, 28 Sep 2023 13:45:30 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/4] arm64: dts: ti: k3-am64-tqma64xxl-mbax4xxl: add muxing for GPIOs on pin headers
Date:   Thu, 28 Sep 2023 13:45:11 +0200
Message-Id: <77c30081154774ce31fc4306474a3afa52b07753.1695901360.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d5991041263c96c798b94c0844a1550e28daa3b1.1695901360.git.matthias.schiffer@ew.tq-group.com>
References: <d5991041263c96c798b94c0844a1550e28daa3b1.1695901360.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pin headers X41 and X42 do not have a fixed function. All of these
pins can be assigned to PRG0, but as a default, it makes more sense to
configure them as simple GPIOs, as the MBaX4XxL is a starterkit/evaluation
mainboard.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 .../dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts    | 76 ++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
index 04c15b64f0b77..7c49d30587d25 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
@@ -170,7 +170,8 @@ &main_gpio0 {
 
 &main_gpio1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&main_gpio1_hog_pins>;
+	pinctrl-0 = <&main_gpio1_hog_pins>,
+		    <&main_gpio1_pru_pins>;
 	gpio-line-names =
 		"", "", "", "", /* 0-3 */
 		"", "", "", "", /* 4-7 */
@@ -545,6 +546,79 @@ AM64X_IOPAD(0x0278, PIN_INPUT, 7)
 		>;
 	};
 
+	main_gpio1_pru_pins: main-gpio1-pru-pins {
+		pinctrl-single,pins = <
+			/* (Y1) PRG0_PRU0_GPO0.GPIO1_0 */
+			AM64X_IOPAD(0x0160, PIN_INPUT, 7)
+			/* (R4) PRG0_PRU0_GPO1.GPIO1_1 */
+			AM64X_IOPAD(0x0164, PIN_INPUT, 7)
+			/* (U2) PRG0_PRU0_GPO2.GPIO1_2 */
+			AM64X_IOPAD(0x0168, PIN_INPUT, 7)
+			/* (V2) PRG0_PRU0_GPO3.GPIO1_3 */
+			AM64X_IOPAD(0x016c, PIN_INPUT, 7)
+			/* (AA2) PRG0_PRU0_GPO4.GPIO1_4 */
+			AM64X_IOPAD(0x0170, PIN_INPUT, 7)
+			/* (R3) PRG0_PRU0_GPO5.GPIO1_5 */
+			AM64X_IOPAD(0x0174, PIN_INPUT, 7)
+			/* (T3) PRG0_PRU0_GPO6.GPIO1_6 */
+			AM64X_IOPAD(0x0178, PIN_INPUT, 7)
+			/* (T1) PRG0_PRU0_GPO7.GPIO1_7 */
+			AM64X_IOPAD(0x017c, PIN_INPUT, 7)
+			/* (T2) PRG0_PRU0_GPO8.GPIO1_8 */
+			AM64X_IOPAD(0x0180, PIN_INPUT, 7)
+			/* (Y3) PRG0_PRU0_GPO11.GPIO1_11 */
+			AM64X_IOPAD(0x018c, PIN_INPUT, 7)
+			/* (AA3) PRG0_PRU0_GPO12.GPIO1_12 */
+			AM64X_IOPAD(0x0190, PIN_INPUT, 7)
+			/* (R6) PRG0_PRU0_GPO13.GPIO1_13 */
+			AM64X_IOPAD(0x0194, PIN_INPUT, 7)
+			/* (V4) PRG0_PRU0_GPO14.GPIO1_14 */
+			AM64X_IOPAD(0x0198, PIN_INPUT, 7)
+			/* (T5) PRG0_PRU0_GPO15.GPIO1_15 */
+			AM64X_IOPAD(0x019c, PIN_INPUT, 7)
+			/* (U4) PRG0_PRU0_GPO16.GPIO1_16 */
+			AM64X_IOPAD(0x01a0, PIN_INPUT, 7)
+			/* (U1) PRG0_PRU0_GPO17.GPIO1_17 */
+			AM64X_IOPAD(0x01a4, PIN_INPUT, 7)
+			/* (V1) PRG0_PRU0_GPO18.GPIO1_18 */
+			AM64X_IOPAD(0x01a8, PIN_INPUT, 7)
+			/* (W1) PRG0_PRU0_GPO19.GPIO1_19 */
+			AM64X_IOPAD(0x01ac, PIN_INPUT, 7)
+			/* (Y2) PRG0_PRU1_GPO0.GPIO1_20 */
+			AM64X_IOPAD(0x01b0, PIN_INPUT, 7)
+			/* (W2) PRG0_PRU1_GPO1.GPIO1_21 */
+			AM64X_IOPAD(0x01b4, PIN_INPUT, 7)
+			/* (V3) PRG0_PRU1_GPO2.GPIO1_22 */
+			AM64X_IOPAD(0x01b8, PIN_INPUT, 7)
+			/* (T4) PRG0_PRU1_GPO3.GPIO1_23 */
+			AM64X_IOPAD(0x01bc, PIN_INPUT, 7)
+			/* (W3) PRG0_PRU1_GPO4.GPIO1_24 */
+			AM64X_IOPAD(0x01c0, PIN_INPUT, 7)
+			/* (P4) PRG0_PRU1_GPO5.GPIO1_25 */
+			AM64X_IOPAD(0x01c4, PIN_INPUT, 7)
+			/* (R5) PRG0_PRU1_GPO6.GPIO1_26 */
+			AM64X_IOPAD(0x01c8, PIN_INPUT, 7)
+			/* (R1) PRG0_PRU1_GPO8.GPIO1_28 */
+			AM64X_IOPAD(0x01d0, PIN_INPUT, 7)
+			/* (W4) PRG0_PRU1_GPO11.GPIO1_31 */
+			AM64X_IOPAD(0x01dc, PIN_INPUT, 7)
+			/* (Y4) PRG0_PRU1_GPO12.GPIO1_32 */
+			AM64X_IOPAD(0x01e0, PIN_INPUT, 7)
+			/* (T6) PRG0_PRU1_GPO13.GPIO1_33 */
+			AM64X_IOPAD(0x01e4, PIN_INPUT, 7)
+			/* (U6) PRG0_PRU1_GPO14.GPIO1_34 */
+			AM64X_IOPAD(0x01e8, PIN_INPUT, 7)
+			/* (U5) PRG0_PRU1_GPO15.GPIO1_35 */
+			AM64X_IOPAD(0x01ec, PIN_INPUT, 7)
+			/* (AA4) PRG0_PRU1_GPO16.GPIO1_36 */
+			AM64X_IOPAD(0x01f0, PIN_INPUT, 7)
+			/* (P2) PRG0_MDIO0_MDIO.GPIO1_40 */
+			AM64X_IOPAD(0x0200, PIN_INPUT, 7)
+			/* (P3) PRG0_MDIO0_MDC.GPIO1_41 */
+			AM64X_IOPAD(0x0204, PIN_INPUT, 7)
+		>;
+	};
+
 	main_mcan0_pins: main-mcan0-pins {
 		pinctrl-single,pins = <
 			/* (B17) MCAN0_RX */
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

