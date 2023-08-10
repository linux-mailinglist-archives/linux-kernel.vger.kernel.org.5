Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0023D776D18
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 02:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjHJAid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 20:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHJAia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 20:38:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2DA171D;
        Wed,  9 Aug 2023 17:38:28 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A0cJvu075423;
        Wed, 9 Aug 2023 19:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691627899;
        bh=4LT4963dRldzKkRdy4xE8Yzrplmp7dcMCoa3bbbam/M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kOkVn7xuxDz/i2d0GGYMHx1XPQA+HM1RxIy40KCvYtW/Qa637MdIvhzCX5odglzbq
         htmXDUGWgl4imc+PsFBWqXBccVXfdJRtjIiKRDrOPsPNaJvfkYNxEWXzjiMfTmJ9ai
         39gzap1Y5Ddzl2WVsj0EQbVDcGnhJBPpLLaC7VU4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A0cJ92078365
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 19:38:19 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 19:38:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 19:38:19 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A0cGF6014775;
        Wed, 9 Aug 2023 19:38:18 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v3 03/13] arm64: dts: ti: k3-j721s2: Enable SDHCI nodes at the board level
Date:   Wed, 9 Aug 2023 19:38:04 -0500
Message-ID: <20230810003814.85450-4-afd@ti.com>
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

SDHCI nodes defined in the top-level J721s2 SoC dtsi files are incomplete
and will not be functional unless they are extended.

As the attached SD/eMMC is only known about at the board integration level,
these nodes should only be enabled when provided with this information.

Disable the SDHCI nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts       | 6 +-----
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 2 ++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi             | 2 ++
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index e6e4133d1e9b9..5fd06cd26b479 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -475,13 +475,9 @@ exp2: gpio@20 {
 	};
 };
 
-&main_sdhci0 {
-	/* Unused */
-	status = "disabled";
-};
-
 &main_sdhci1 {
 	/* SD card */
+	status = "okay";
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	pinctrl-names = "default";
 	disable-wp;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index e81ef8a7a8a26..7794063b77c8a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -366,6 +366,7 @@ exp2: gpio@22 {
 
 &main_sdhci0 {
 	/* eMMC */
+	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
@@ -373,6 +374,7 @@ &main_sdhci0 {
 
 &main_sdhci1 {
 	/* SD card */
+	status = "okay";
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	pinctrl-names = "default";
 	disable-wp;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index dc7920a352373..0e0092fa7b9fb 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -737,6 +737,7 @@ main_sdhci0: mmc@4f80000 {
 		mmc-hs200-1_8v;
 		mmc-hs400-1_8v;
 		dma-coherent;
+		status = "disabled";
 	};
 
 	main_sdhci1: mmc@4fb0000 {
@@ -766,6 +767,7 @@ main_sdhci1: mmc@4fb0000 {
 		dma-coherent;
 		/* Masking support for SDR104 capability */
 		sdhci-caps-mask = <0x00000003 0x00000000>;
+		status = "disabled";
 	};
 
 	main_navss: bus@30000000 {
-- 
2.39.2

