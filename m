Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE06E774B5C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjHHUpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjHHUpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:45:33 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76865F3A10;
        Tue,  8 Aug 2023 09:37:06 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378DZ8AE081682;
        Tue, 8 Aug 2023 08:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691501708;
        bh=fQ/532nBdHyDyg7gVLVsTIcGiqz0ZCTnjYpgJNoX93k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZD+qiHqtPtDYxBm/yEkmNt/uF3HaHm2KpWoM7wUiw8JDlhTNYorIgg0sgIaaO3ytH
         /oLTEHE1eK25OhMIAdIW9HjBTDlyST7OO5SyM9lHg1RaGlN1P8USMoyqfGcMJlq1Ft
         dankptUHXIFqJYtTrQk9iQUnVtbAVTe8tIOkdTSQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378DZ8DL028282
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 08:35:08 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 08:35:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 08:35:08 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378DZ4Pv053163;
        Tue, 8 Aug 2023 08:35:07 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 05/13] arm64: dts: ti: k3-j721e: Enable OSPI nodes at the board level
Date:   Tue, 8 Aug 2023 08:34:49 -0500
Message-ID: <20230808133457.25060-6-afd@ti.com>
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

OSPI nodes defined in the top-level J721e SoC dtsi files are incomplete
and may not be functional unless they are extended with pinmux and
device information.

As the attached OSPI device is only known about at the board integration
level, these nodes should only be enabled when provided with this
information.

Disable the OSPI nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 10 ----------
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |  2 ++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             |  6 +-----
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        |  1 +
 4 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index 64eed76bbb7a3..0b89977351c98 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -580,16 +580,6 @@ &main_sdhci1 {
 	disable-wp;
 };
 
-&ospi0 {
-	/* Unused */
-	status = "disabled";
-};
-
-&ospi1 {
-	/* Unused */
-	status = "disabled";
-};
-
 &main_i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index c1b6f8d7d1898..0c01bdd9656f1 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -378,6 +378,7 @@ ospi0: spi@47040000 {
 			power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		ospi1: spi@47050000 {
@@ -392,6 +393,7 @@ ospi1: spi@47050000 {
 			power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index bd1bd1b746056..4cd5346f2dd59 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -594,6 +594,7 @@ &main_sdhci1 {
 };
 
 &ospi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
 
@@ -657,11 +658,6 @@ partition@3fc0000 {
 	};
 };
 
-&ospi1 {
-	/* Unused */
-	status = "disabled";
-};
-
 &main_i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index e90e43202546e..928d3a8ad2d09 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -202,6 +202,7 @@ eeprom@50 {
 };
 
 &ospi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
 
-- 
2.39.2

