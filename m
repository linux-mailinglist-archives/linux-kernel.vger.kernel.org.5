Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743C776D8F5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjHBUxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjHBUxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:53:25 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA4D1FF2;
        Wed,  2 Aug 2023 13:53:24 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372KrICs045385;
        Wed, 2 Aug 2023 15:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691009598;
        bh=eDbpN4GN5cN13qWNNOtLQP7WEzXKsAfX2/vHBGDMoPY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=m0TVr0sI1qQ2xI8cbUgtL9ROE8Bak5Gvn3AsBPJEztU0daPBpY5HpKQLLfU3N75s2
         mJDr6MoyEXv5dK+tlZA33n4F0Q4okwah27RW/KiQstx/KtLutqkSqoIqFS1fU0CzCU
         B1ZvIXz7HxO5PBGK+T1YfwDQZNCgjx81EnbCzCEU=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372KrIL0071689
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 15:53:18 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 15:53:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 15:53:17 -0500
Received: from lelv0326.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372KrASI090834;
        Wed, 2 Aug 2023 15:53:17 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 11/13] arm64: dts: ti: k3-j721e: Enable TSCADC nodes at the board level
Date:   Wed, 2 Aug 2023 15:53:07 -0500
Message-ID: <20230802205309.257392-12-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802205309.257392-1-afd@ti.com>
References: <20230802205309.257392-1-afd@ti.com>
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

TSCADC nodes defined in the top-level J721e SoC dtsi files are incomplete
and may not be functional unless they are extended with pinmux and/or
device information.

Disable the TSCADC nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts    |  2 ++
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts |  2 ++
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi       |  2 ++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                | 10 ----------
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index 99536765939d9..79245a85d7c69 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -748,6 +748,7 @@ &usb1 {
 };
 
 &tscadc0 {
+	status = "okay";
 	/* BBB Header: P9.39, P9.40, P9.37, P9.38, P9.33, P9.36, P9.35 */
 	adc {
 		ti,adc-channels = <0 1 2 3 4 5 6>;
@@ -755,6 +756,7 @@ adc {
 };
 
 &tscadc1 {
+	status = "okay";
 	/* MCU mikroBUS Header J10.1 - MCU_ADC1_AIN0 */
 	adc {
 		ti,adc-channels = <0>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 2fd940893eb5f..6cea309fc247a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -621,12 +621,14 @@ partition@3fe0000 {
 };
 
 &tscadc0 {
+	status = "okay";
 	adc {
 		ti,adc-channels = <0 1 2 3 4 5 6 7>;
 	};
 };
 
 &tscadc1 {
+	status = "okay";
 	adc {
 		ti,adc-channels = <0 1 2 3 4 5 6 7>;
 	};
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 4d107eee9b341..37a8c80de3bc5 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -411,6 +411,7 @@ tscadc0: tscadc@40200000 {
 		dmas = <&main_udmap 0x7400>,
 			<&main_udmap 0x7401>;
 		dma-names = "fifo0", "fifo1";
+		status = "disabled";
 
 		adc {
 			#io-channel-cells = <1>;
@@ -430,6 +431,7 @@ tscadc1: tscadc@40210000 {
 		dmas = <&main_udmap 0x7402>,
 			<&main_udmap 0x7403>;
 		dma-names = "fifo0", "fifo1";
+		status = "disabled";
 
 		adc {
 			#io-channel-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index dfb6af60482e7..ca5be7797a02b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -829,16 +829,6 @@ &usb1 {
 	phy-names = "cdns3,usb3-phy";
 };
 
-&tscadc0 {
-	/* Unused */
-	status = "disabled";
-};
-
-&tscadc1 {
-	/* Unused */
-	status = "disabled";
-};
-
 &mcu_cpsw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
-- 
2.39.2

