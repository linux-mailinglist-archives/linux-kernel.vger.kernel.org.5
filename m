Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF8F7DB359
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjJ3GcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjJ3Gbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:31:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D39135;
        Sun, 29 Oct 2023 23:31:24 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39U6VBkD083087;
        Mon, 30 Oct 2023 01:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698647471;
        bh=wRqcz0GeUPoqwWeMEBPoeB3CSHBuUPhuPWYUDN0JZnQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dtVxkZGIAq1c0C5XLxQAyC/zkfDhLMGvJWrFKA+066/eI0N/Bgjryru8fNjDilnD+
         VrescrTgOdVwmu9l0mW8iCFiVFkhFgQTZmwTsl0sRDlH+OE16I4AZRtnihIp0hKbS6
         CIXhlYaxI3RcPK8/OzRZ9Cf9WOQxHVzgr/T69vfo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39U6VBT6009169
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Oct 2023 01:31:11 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Oct 2023 01:31:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Oct 2023 01:31:11 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39U6VAe4003179;
        Mon, 30 Oct 2023 01:31:10 -0500
From:   Nitin Yadav <n-yadav@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
Date:   Mon, 30 Oct 2023 12:01:07 +0530
Message-ID: <20231030063108.1242981-2-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231030063108.1242981-1-n-yadav@ti.com>
References: <20231030063108.1242981-1-n-yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdhci0 DT node in k3-am62a-main for eMMC support. Droping
ITAP values as they are NA in datasheet[0] for lower speed modes.

[0]https://www.ti.com/lit/gpn/am62a3 Table: 7-79 (Page No. 179)

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index de36abb243f1..89b8b7d302cd 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -488,6 +488,25 @@ main_gpio1: gpio@601000 {
 		status = "disabled";
 	};
 
+	sdhci0: mmc@fa10000 {
+		compatible = "ti,am62-sdhci";
+		reg = <0x00 0xfa10000 0x00 0x260>, <0x00 0xfa18000 0x00 0x134>;
+		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
+		clock-names = "clk_ahb", "clk_xin";
+		assigned-clocks = <&k3_clks 57 6>;
+		assigned-clock-parents = <&k3_clks 57 8>;
+		mmc-hs200-1_8v;
+		ti,trm-icp = <0x2>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-mmc-hs = <0x0>;
+		ti,otap-del-sel-hs200 = <0x6>;
+		bus-width = <8>;
+		ti,clkbuf-sel = <0x7>;
+		status = "disabled";
+	};
+
 	sdhci1: mmc@fa00000 {
 		compatible = "ti,am62-sdhci";
 		reg = <0x00 0xfa00000 0x00 0x260>, <0x00 0xfa08000 0x00 0x134>;
-- 
2.25.1

