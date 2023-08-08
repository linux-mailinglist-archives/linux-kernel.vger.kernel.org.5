Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583A67742B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjHHRsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjHHRsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:48:07 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD28A7C;
        Tue,  8 Aug 2023 09:21:22 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378DZ7YM099651;
        Tue, 8 Aug 2023 08:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691501707;
        bh=ii78j4No8lcqtrUHJW2m2flXO5hcFSHcWifBBAtfUPA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yNU0UUYyvRgVDCytL7HEr6UkimqiiEQQwAnpKPUaJM6MO10Eiqq0kSf9THWN0q3yl
         Z56AXcF/7RddXQdHwvUOIyqAul3kq+BagucS/pIWWKhS2ZNuN4PlnwhaHya9l7k3vy
         wIJuuej9h1e0fVWzotcr4DdDttqcU/H7SRvxKeLk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378DZ7uJ103150
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 08:35:07 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 08:35:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 08:35:05 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378DZ4Pr053163;
        Tue, 8 Aug 2023 08:35:05 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 01/13] arm64: dts: ti: k3-j721e: Enable SDHCI nodes at the board level
Date:   Tue, 8 Aug 2023 08:34:45 -0500
Message-ID: <20230808133457.25060-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808133457.25060-1-afd@ti.com>
References: <20230808133457.25060-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDHCI nodes defined in the top-level J721e SoC dtsi files are incomplete
and will not be functional unless they are extended.

As the attached SD/eMMC is only known about at the board integration level,
these nodes should only be enabled when provided with this information.

Disable the SDHCI nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts    |  7 ++-----
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts |  7 ++-----
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi             |  3 +++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                | 11 +----------
 4 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index 66aac145e7530..64eed76bbb7a3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -563,6 +563,7 @@ &main_uart0 {
 
 &main_sdhci0 {
 	/* eMMC */
+	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
@@ -570,6 +571,7 @@ &main_sdhci0 {
 
 &main_sdhci1 {
 	/* SD Card */
+	status = "okay";
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vdd_sd_dv_alt>;
 	pinctrl-names = "default";
@@ -578,11 +580,6 @@ &main_sdhci1 {
 	disable-wp;
 };
 
-&main_sdhci2 {
-	/* Unused */
-	status = "disabled";
-};
-
 &ospi0 {
 	/* Unused */
 	status = "disabled";
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index c1cbbae761827..e9b84d2c64b26 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -504,6 +504,7 @@ &wkup_gpio1 {
 
 &main_sdhci0 {
 	/* eMMC */
+	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
@@ -511,6 +512,7 @@ &main_sdhci0 {
 
 &main_sdhci1 {
 	/* SD/MMC */
+	status = "okay";
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vdd_sd_dv_alt>;
 	pinctrl-names = "default";
@@ -519,11 +521,6 @@ &main_sdhci1 {
 	disable-wp;
 };
 
-&main_sdhci2 {
-	/* Unused */
-	status = "disabled";
-};
-
 &usb_serdes_mux {
 	idle-states = <1>, <0>; /* USB0 to SERDES3, USB1 to SERDES1 */
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 3acd55ffd4ffc..0ca31186b9b74 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1478,6 +1478,7 @@ main_sdhci0: mmc@4f80000 {
 		ti,itap-del-sel-ddr52 = <0x3>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
+		status = "disabled";
 	};
 
 	main_sdhci1: mmc@4fb0000 {
@@ -1505,6 +1506,7 @@ main_sdhci1: mmc@4fb0000 {
 		ti,clkbuf-sel = <0x7>;
 		dma-coherent;
 		sdhci-caps-mask = <0x2 0x0>;
+		status = "disabled";
 	};
 
 	main_sdhci2: mmc@4f98000 {
@@ -1532,6 +1534,7 @@ main_sdhci2: mmc@4f98000 {
 		ti,clkbuf-sel = <0x7>;
 		dma-coherent;
 		sdhci-caps-mask = <0x2 0x0>;
+		status = "disabled";
 	};
 
 	usbss0: cdns-usb@4104000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 0ee4f38ec8f03..bd1bd1b746056 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -582,13 +582,9 @@ &main_uart1 {
 	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
-&main_sdhci0 {
-	/* Unused */
-	status = "disabled";
-};
-
 &main_sdhci1 {
 	/* SD Card */
+	status = "okay";
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vdd_sd_dv_alt>;
 	pinctrl-names = "default";
@@ -597,11 +593,6 @@ &main_sdhci1 {
 	disable-wp;
 };
 
-&main_sdhci2 {
-	/* Unused */
-	status = "disabled";
-};
-
 &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
-- 
2.39.2

