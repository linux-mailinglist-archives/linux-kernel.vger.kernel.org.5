Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3615E7BB0E2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 06:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjJFE34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 00:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjJFE3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 00:29:47 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B52D118;
        Thu,  5 Oct 2023 21:29:44 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3964Tch1122683;
        Thu, 5 Oct 2023 23:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696566578;
        bh=xxU6QgLh1dnn/aE8fCc2W2oeEev82KezupE9hKHzv4A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QY9qBM6HZApKtqBNyK73nG+E6UrOsycQznDpusRC0y6lvc88yYtA+dTqaESKSu+Vi
         JlIb+QFDV+A+DNjhIyZEMVdrlY7SNk8AJIKUt/SKbD2ag1YcMoTh1555ejZaV2Ty5X
         LNYQeShAq6gih/eljRUdVfBYUa6l7azmtPv5IZWI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3964Tc9T035858
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Oct 2023 23:29:38 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 23:29:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 23:29:38 -0500
Received: from keerthy.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3964TDHB074236;
        Thu, 5 Oct 2023 23:29:35 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <j-keerthy@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 6/7] arm64: dts: ti: k3-j721s2-main: Add the main domain watchdog instances
Date:   Fri, 6 Oct 2023 09:59:00 +0530
Message-ID: <20231006042901.6474-7-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231006042901.6474-1-j-keerthy@ti.com>
References: <20231006042901.6474-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are totally 9 instances of watchdog module. One each for the
2 A72 cores, one each for the 2 C7x cores, 1 for the GPU, 1 each
for the 4 R5F cores in the main domain. Keeping only the A72 instances
enabled and disabling the rest by default as they will be used by
their respective firmware.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 7ce802c6808d..0a05aad6be49 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -1808,4 +1808,97 @@
 		ti,esm-pins = <688>, <689>;
 		bootph-pre-ram;
 	};
+
+	watchdog0: watchdog@2200000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2200000 0x00 0x100>;
+		clocks = <&k3_clks 286 1>;
+		power-domains = <&k3_pds 286 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 286 1>;
+		assigned-clock-parents = <&k3_clks 286 5>;
+	};
+
+	watchdog1: watchdog@2210000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2210000 0x00 0x100>;
+		clocks = <&k3_clks 287 1>;
+		power-domains = <&k3_pds 287 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 287 1>;
+		assigned-clock-parents = <&k3_clks 287 5>;
+	};
+
+	/*
+	 * The following RTI instances are coupled with MCU R5Fs, c7x and
+	 * GPU so keeping them disabled as these will be used by their
+	 * respective firmware
+	 */
+	watchdog2: watchdog@22f0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x22f0000 0x00 0x100>;
+		clocks = <&k3_clks 290 1>;
+		power-domains = <&k3_pds 290 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 290 1>;
+		assigned-clock-parents = <&k3_clks 290 5>;
+		status = "disabled";
+	};
+
+	watchdog3: watchdog@2300000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2300000 0x00 0x100>;
+		clocks = <&k3_clks 288 1>;
+		power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 288 1>;
+		assigned-clock-parents = <&k3_clks 288 5>;
+		status = "disabled";
+	};
+
+	watchdog4: watchdog@2310000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2310000 0x00 0x100>;
+		clocks = <&k3_clks 289 1>;
+		power-domains = <&k3_pds 289 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 289 1>;
+		assigned-clock-parents = <&k3_clks 289 5>;
+		status = "disabled";
+	};
+
+	watchdog5: watchdog@23c0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23c0000 0x00 0x100>;
+		clocks = <&k3_clks 291 1>;
+		power-domains = <&k3_pds 291 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 291 1>;
+		assigned-clock-parents = <&k3_clks 291 5>;
+		status = "disabled";
+	};
+
+	watchdog6: watchdog@23d0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23d0000 0x00 0x100>;
+		clocks = <&k3_clks 292 1>;
+		power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 292 1>;
+		assigned-clock-parents = <&k3_clks 292 5>;
+		status = "disabled";
+	};
+
+	watchdog7: watchdog@23e0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23e0000 0x00 0x100>;
+		clocks = <&k3_clks 293 1>;
+		power-domains = <&k3_pds 293 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 293 1>;
+		assigned-clock-parents = <&k3_clks 293 5>;
+		status = "disabled";
+	};
+
+	watchdog8: watchdog@23f0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23f0000 0x00 0x100>;
+		clocks = <&k3_clks 294 1>;
+		power-domains = <&k3_pds 294 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 294 1>;
+		assigned-clock-parents = <&k3_clks 294 5>;
+		status = "disabled";
+	};
 };
-- 
2.17.1

