Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE4B7EF646
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346117AbjKQQd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346098AbjKQQdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:33:53 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A08A196;
        Fri, 17 Nov 2023 08:33:50 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AHGXfJD000580;
        Fri, 17 Nov 2023 10:33:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700238821;
        bh=TRVFdbxp5TfB9zohoIzap5ZelvMfSVt1e9KtfukunVc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=p8ZiYuR3j+zQLfETJ0OmYQF/VmtESq62TxInPoZl0cHr73sLuMFmGo3m1tknDdK7h
         0gFgZLqn1snrVLtvW3Hv4JzG837Ds+3C4Pz9dibBXMe9MYqa0DG6VsEqWl4I/kRFWL
         F/n/0gSngu9bBnv4bHaWyU0pj9qwkUHuL2o7oQdM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AHGXfpY097084
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Nov 2023 10:33:41 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 10:33:41 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 10:33:41 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AHGXeYg127988;
        Fri, 17 Nov 2023 10:33:41 -0600
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am64: Enable SDHCI nodes at the board level
Date:   Fri, 17 Nov 2023 10:33:39 -0600
Message-ID: <20231117163339.89952-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231117163339.89952-1-afd@ti.com>
References: <20231117163339.89952-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDHCI nodes defined in the top-level AM64 SoC dtsi files are incomplete
and will not be functional unless they are extended.

As the attached SD/eMMC is only known about at the board integration level,
these nodes should only be enabled when provided with this information.

Disable the SDHCI nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi                 | 2 ++
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi          | 1 +
 arch/arm64/boot/dts/ti/k3-am642-evm.dts                  | 6 ++++--
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 1 +
 arch/arm64/boot/dts/ti/k3-am642-sk.dts                   | 4 +++-
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts   | 1 -
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi           | 1 +
 7 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 0be642bc1b86d..c3300c36fdbcb 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -623,6 +623,7 @@ sdhci0: mmc@fa10000 {
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-ddr52 = <0x6>;
 		ti,otap-del-sel-hs200 = <0x7>;
+		status = "disabled";
 	};
 
 	sdhci1: mmc@fa00000 {
@@ -641,6 +642,7 @@ sdhci1: mmc@fa00000 {
 		ti,otap-del-sel-sdr104 = <0x6>;
 		ti,otap-del-sel-ddr50 = <0x9>;
 		ti,clkbuf-sel = <0x7>;
+		status = "disabled";
 	};
 
 	cpsw3g: ethernet@8000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index f87f09d83c956..b8f844f667afc 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -211,6 +211,7 @@ flash@0 {
 };
 
 &sdhci0 {
+	status = "okay";
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 4dba18941015d..256606be56fef 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -487,17 +487,19 @@ eeprom@0 {
 	};
 };
 
+/* eMMC */
 &sdhci0 {
-	/* emmc */
+	status = "okay";
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
 
+/* SD/MMC */
 &sdhci1 {
-	/* SD/MMC */
 	bootph-all;
+	status = "okay";
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
 	bus-width = <4>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 9175e96842d82..53b64e55413f9 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -264,6 +264,7 @@ &main_uart1 {
 };
 
 &sdhci1 {
+	status = "okay";
 	vmmc-supply = <&vcc_3v3_mmc>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index f29c8a9b59ba7..bffbd234f715a 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -439,6 +439,7 @@ &mcu_gpio0 {
 };
 
 &sdhci0 {
+	status = "okay";
 	vmmc-supply = <&wlan_en>;
 	bus-width = <4>;
 	non-removable;
@@ -458,9 +459,10 @@ wlcore: wlcore@2 {
 	};
 };
 
+/* SD/MMC */
 &sdhci1 {
-	/* SD/MMC */
 	bootph-all;
+	status = "okay";
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
 	bus-width = <4>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
index d95d80076a427..55102d35cecc1 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
@@ -425,7 +425,6 @@ &sdhci1 {
 	ti,driver-strength-ohm = <50>;
 	ti,fails-without-test-cd;
 	/* Enabled by overlay */
-	status = "disabled";
 };
 
 &tscadc0 {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
index d82d4a98306a7..6c785eff7d2ff 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
@@ -219,6 +219,7 @@ partitions {
 };
 
 &sdhci0 {
+	status = "okay";
 	non-removable;
 	disable-wp;
 	no-sdio;
-- 
2.39.2

