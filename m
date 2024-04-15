Return-Path: <linux-kernel+bounces-144586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633FA8A4822
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85ED41C218CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD9B1EB48;
	Mon, 15 Apr 2024 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xytczxid"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1B1CFA9;
	Mon, 15 Apr 2024 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162840; cv=none; b=gQyi8Wf7GZcAj6JnlpivIshjQXvhGtFilsQbjDkLmVpZSBvz9gRcWS3iA93Ujuy4ITlvW2SR49X88VX+kMIZFCEWUjfQIiXKhR39uJ2Sb0Rtg5a1e395oLVvKTaPxAuUH2+8pf/9HOU/0JLIo5Dzwkenoeq9ORzaSJrt99t0bW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162840; c=relaxed/simple;
	bh=yiOgU31guwE0yS3yPks8W3ChQ4EhxyZWUWd/eIA1QMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdAnhYmngNwb59XPPI6okeJBP1lrOrQ3UyGijxiN2lLVtfxLlyEUBnZKbW93CG+2bFPlMo55cDFOO/bYe5IarBRmKwcFEu7A/GRvoEKvfqY+W6PX0sqszzEKfyvlxxP2eEWWm/CsOx7mBQxG6bniIYVnyyB2APkBnsb3A8x9qIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Xytczxid; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43F6Xpnl035466;
	Mon, 15 Apr 2024 01:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713162831;
	bh=4GkLe55tAQSbz0WwbIl6rAJnyMu7v63gfE6qyn1EgEU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XytczxidaDc5CIgEqFdgr7HN1ER1zUaw2RL98dzvK7eTlnlVPVSY2et6bWPCD1Xny
	 mwUCZV2XoPD9ymMAVixERKJlUUInV0E3prBzqxBxIu3EdsQoqSZigtvyPs0TV8y4sU
	 wxZwcI8pEUpW3DAa7FbDzOwChFFb0mnlnZZf+1QE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43F6XpEY049294
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Apr 2024 01:33:51 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 01:33:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 01:33:51 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43F6Xidc065992;
	Mon, 15 Apr 2024 01:33:48 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar
	<u-kumar1@ti.com>
Subject: [PATCH 1/4] arm64: dts: ti: k3-j784s4-evm: Arranging mux and macro update
Date: Mon, 15 Apr 2024 12:03:26 +0530
Message-ID: <20240415063329.3286600-2-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415063329.3286600-1-u-kumar1@ti.com>
References: <20240415063329.3286600-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Updating J784S4 macro for pin mux instead of J721S2.

Also arranging pin mux in order of main_pmx0/1, wkup_pmx0/1/2/3
along with fixing pin type for TX as output of wkup_uart.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 116 +++++++++++------------
 1 file changed, 56 insertions(+), 60 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 81fd7afac8c5..1424c6be8e39 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -338,21 +338,73 @@ J784S4_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AH33) MCAN13_RX.I2C4_SDA */
 	};
 };
 
+&wkup_pmx0 {
+	bootph-all;
+	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (E32) MCU_OSPI0_CLK */
+			J784S4_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (A32) MCU_OSPI0_CSn0 */
+			J784S4_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (B33) MCU_OSPI0_D0 */
+			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (B32) MCU_OSPI0_D1 */
+			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (C33) MCU_OSPI0_D2 */
+			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (C35) MCU_OSPI0_D3 */
+			J784S4_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (D33) MCU_OSPI0_D4 */
+			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D34) MCU_OSPI0_D5 */
+			J784S4_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (E34) MCU_OSPI0_D6 */
+			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (E33) MCU_OSPI0_D7 */
+			J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
+		>;
+	};
+};
+
+&wkup_pmx1 {
+	bootph-all;
+	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x004, PIN_OUTPUT, 6) /* (C32) MCU_OSPI0_ECC_FAIL */
+			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_RESET_OUT0 */
+		>;
+	};
+
+	pmic_irq_pins_default: pmic-irq-default-pins {
+		pinctrl-single,pins = <
+			/* (G33) MCU_OSPI1_CSn1.WKUP_GPIO0_39 */
+			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 7)
+		>;
+	};
+
+	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (F32) MCU_OSPI1_CLK */
+			J784S4_WKUP_IOPAD(0x024, PIN_OUTPUT, 0) /* (G32) MCU_OSPI1_CSn0 */
+			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (E35) MCU_OSPI1_D0 */
+			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (D31) MCU_OSPI1_D1 */
+			J784S4_WKUP_IOPAD(0x01C, PIN_INPUT, 0) /* (G31) MCU_OSPI1_D2 */
+			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (F33) MCU_OSPI1_D3 */
+			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (F31) MCU_OSPI1_DQS */
+			J784S4_WKUP_IOPAD(0x00C, PIN_INPUT, 0) /* (C31) MCU_OSPI1_LBCLKO */
+		>;
+	};
+};
+
 &wkup_pmx2 {
 	bootph-all;
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (K35) WKUP_UART0_RXD */
-			J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (K34) WKUP_UART0_TXD */
+			J784S4_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (K35) WKUP_UART0_RXD */
+			J784S4_WKUP_IOPAD(0x04c, PIN_OUTPUT, 0) /* (K34) WKUP_UART0_TXD */
 		>;
 	};
 
 	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x98, PIN_INPUT, 0) /* (N33) WKUP_I2C0_SCL */
-			J721S2_WKUP_IOPAD(0x9c, PIN_INPUT, 0) /* (N35) WKUP_I2C0_SDA */
+			J784S4_WKUP_IOPAD(0x98, PIN_INPUT, 0) /* (N33) WKUP_I2C0_SCL */
+			J784S4_WKUP_IOPAD(0x9c, PIN_INPUT, 0) /* (N35) WKUP_I2C0_SDA */
 		>;
 	};
 
@@ -417,62 +469,6 @@ J784S4_WKUP_IOPAD(0x108, PIN_INPUT, 0) /* (Y36) MCU_ADC1_AIN7 */
 	};
 };
 
-&wkup_pmx1 {
-	status = "okay";
-
-	pmic_irq_pins_default: pmic-irq-default-pins {
-		pinctrl-single,pins = <
-			/* (G33) MCU_OSPI1_CSn1.WKUP_GPIO0_39 */
-			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 7)
-		>;
-	};
-};
-
-&wkup_pmx0 {
-	bootph-all;
-	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
-		bootph-all;
-		pinctrl-single,pins = <
-			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (E32) MCU_OSPI0_CLK */
-			J784S4_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (A32) MCU_OSPI0_CSn0 */
-			J784S4_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (B33) MCU_OSPI0_D0 */
-			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (B32) MCU_OSPI0_D1 */
-			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (C33) MCU_OSPI0_D2 */
-			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (C35) MCU_OSPI0_D3 */
-			J784S4_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (D33) MCU_OSPI0_D4 */
-			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D34) MCU_OSPI0_D5 */
-			J784S4_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (E34) MCU_OSPI0_D6 */
-			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (E33) MCU_OSPI0_D7 */
-			J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
-		>;
-	};
-};
-
-&wkup_pmx1 {
-	bootph-all;
-	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
-		bootph-all;
-		pinctrl-single,pins = <
-			J784S4_WKUP_IOPAD(0x004, PIN_OUTPUT, 6) /* (C32) MCU_OSPI0_ECC_FAIL */
-			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_RESET_OUT0 */
-		>;
-	};
-
-	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-default-pins {
-		bootph-all;
-		pinctrl-single,pins = <
-			J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (F32) MCU_OSPI1_CLK */
-			J784S4_WKUP_IOPAD(0x024, PIN_OUTPUT, 0) /* (G32) MCU_OSPI1_CSn0 */
-			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (E35) MCU_OSPI1_D0 */
-			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (D31) MCU_OSPI1_D1 */
-			J784S4_WKUP_IOPAD(0x01C, PIN_INPUT, 0) /* (G31) MCU_OSPI1_D2 */
-			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (F33) MCU_OSPI1_D3 */
-			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (F31) MCU_OSPI1_DQS */
-			J784S4_WKUP_IOPAD(0x00C, PIN_INPUT, 0) /* (C31) MCU_OSPI1_LBCLKO */
-		>;
-	};
-};
-
 &wkup_uart0 {
 	/* Firmware usage */
 	status = "reserved";
-- 
2.34.1


