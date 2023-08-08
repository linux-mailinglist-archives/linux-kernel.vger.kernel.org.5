Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FCA77409C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjHHRFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjHHRFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:05:04 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866571A758;
        Tue,  8 Aug 2023 09:02:12 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378DZDTX025842;
        Tue, 8 Aug 2023 08:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691501713;
        bh=z4OV57lSCAoQhb85slW8Rs/YcSK/nhWTReFljQynbDc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=boTPTYXY55sO59JNXtOH4rhJxVyMwPqFF/GWvrIBupzKelu4mVYebzMmOhV2tYuWP
         ddP/yJuu1FaEMNYm00M5OguNKZZckyaFJbGEwlyvwmvl/iGpFWWcO59orVl4UtAymg
         yrT3qN9cuk+6PyA2Sz7wkzQ4dhtSL0U28Vs51dJw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378DZCf4028320
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 08:35:12 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 08:35:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 08:35:12 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378DZ4Q3053163;
        Tue, 8 Aug 2023 08:35:11 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 11/13] arm64: dts: ti: k3-j721e: Enable TSCADC nodes at the board level
Date:   Tue, 8 Aug 2023 08:34:55 -0500
Message-ID: <20230808133457.25060-12-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808133457.25060-1-afd@ti.com>
References: <20230808133457.25060-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index f06e7bda46f01..9f3a809ddf90b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -747,6 +747,7 @@ &usb1 {
 };
 
 &tscadc0 {
+	status = "okay";
 	/* BBB Header: P9.39, P9.40, P9.37, P9.38, P9.33, P9.36, P9.35 */
 	adc {
 		ti,adc-channels = <0 1 2 3 4 5 6>;
@@ -754,6 +755,7 @@ adc {
 };
 
 &tscadc1 {
+	status = "okay";
 	/* MCU mikroBUS Header J10.1 - MCU_ADC1_AIN0 */
 	adc {
 		ti,adc-channels = <0>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 824874a7dcb95..fe5207ac7d85d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -619,12 +619,14 @@ partition@3fe0000 {
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
index ed4994d264f26..4032601fd53fa 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -828,16 +828,6 @@ &usb1 {
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

