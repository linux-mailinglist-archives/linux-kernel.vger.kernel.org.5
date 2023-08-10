Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CE1776D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 02:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjHJAis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 20:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjHJAic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 20:38:32 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF511171D;
        Wed,  9 Aug 2023 17:38:31 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A0cNn8075438;
        Wed, 9 Aug 2023 19:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691627903;
        bh=Jdf9IIbbApx2Gwl+ovKKLjLw4eP+gnLXtqOc4/6W/Eo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=upgj84iCYqoC8LY5qN3z+DabE6MMhCZBBXkWLyrFSZI0ig70XOeWX9cLZliH98QA9
         ro8gnMvBfs662sewu7weQJim0dW/oRKg64ogjAy7ieyYCC5EOpB8xL+WTeKjxvPbiH
         ATda8hUUNNK+G+X606mU7RK5KYtLBuKCHMzoFuAc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A0cNk9061504
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 19:38:23 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 19:38:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 19:38:23 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A0cGFD014775;
        Wed, 9 Aug 2023 19:38:22 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v3 10/13] arm64: dts: ti: k3-j7200: Enable GPIO nodes at the board level
Date:   Wed, 9 Aug 2023 19:38:11 -0500
Message-ID: <20230810003814.85450-11-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810003814.85450-1-afd@ti.com>
References: <20230810003814.85450-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO nodes defined in the top-level J7200 SoC dtsi files are incomplete
and may not be functional unless they are extended with pinmux and
device information.

Disable the GPIO nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../boot/dts/ti/k3-j7200-common-proc-board.dts  | 17 +++--------------
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       |  4 ++++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi |  2 ++
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index dee9056f56051..cee2b4b0eb87d 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -240,27 +240,16 @@ &main_uart3 {
 	pinctrl-0 = <&main_uart3_pins_default>;
 };
 
-&main_gpio2 {
-	status = "disabled";
-};
-
-&main_gpio4 {
-	status = "disabled";
-};
-
-&main_gpio6 {
-	status = "disabled";
+&main_gpio0 {
+	status = "okay";
 };
 
 &wkup_gpio0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_gpio_pins_default>;
 };
 
-&wkup_gpio1 {
-	status = "disabled";
-};
-
 &mcu_cpsw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 5d7542ba41b93..6a776f3bbcb19 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -832,6 +832,7 @@ main_gpio0: gpio@600000 {
 		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 105 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio2: gpio@610000 {
@@ -849,6 +850,7 @@ main_gpio2: gpio@610000 {
 		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 107 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio4: gpio@620000 {
@@ -866,6 +868,7 @@ main_gpio4: gpio@620000 {
 		power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 109 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio6: gpio@630000 {
@@ -883,6 +886,7 @@ main_gpio6: gpio@630000 {
 		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 111 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_spi0: spi@2100000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 571eb0e2eac92..5ae7320efad7b 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -297,6 +297,7 @@ wkup_gpio0: gpio@42110000 {
 		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 113 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	wkup_gpio1: gpio@42100000 {
@@ -313,6 +314,7 @@ wkup_gpio1: gpio@42100000 {
 		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 114 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	mcu_navss: bus@28380000 {
-- 
2.39.2

