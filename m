Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F5B7AF965
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjI0EaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjI0E3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:29:14 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69E783DF;
        Tue, 26 Sep 2023 19:37:57 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38R2bpgt015427;
        Tue, 26 Sep 2023 21:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695782272;
        bh=1YynK1VqnSUvtlYIHIZVlskNYj/GU5J34sPokkW3EZ8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=js4Dj1urhbJMCmqc4YLD4QTr3Ww2EVfhTDiOl3sVV0EAZlXEIhejDs92S9uURk+rZ
         lumCc7ths4d80fNKWj6gLOazxJtHWlC6nqkxSrwSiP6vGOah1ek7LmSQSWRVYTRsXS
         IDdIoqRf3UC8mrWC9YJKwu83Lp9By6l4LKlS2S4E=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38R2bpch026309
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 21:37:51 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 21:37:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 21:37:51 -0500
Received: from localhost.localdomain (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38R2bL7Z013228;
        Tue, 26 Sep 2023 21:37:48 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <j-keerthy@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 7/7] dts: ti: k3-j712s2-mcu: Add the mcu domain watchdog instances
Date:   Wed, 27 Sep 2023 08:03:57 +0530
Message-ID: <20230927023357.9883-8-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230927023357.9883-1-j-keerthy@ti.com>
References: <20230927023357.9883-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are totally 2 instances of watchdog module in MCU domain.
These instances are coupled with the MCU domain R5F instances.
Disabling them as they are not used by Linux.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 4b29418a6076..83377c47e709 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -669,4 +669,28 @@
 		ti,esm-pins = <63>;
 		bootph-pre-ram;
 	};
+
+	/*
+	 * The 2 RTI instances are couple with MCU R5Fs so keeping them
+	 * disabled as these will be used by their respective firmware
+	 */
+	mcu_watchdog0: watchdog@40600000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x40600000 0x00 0x100>;
+		clocks = <&k3_clks 295 1>;
+		power-domains = <&k3_pds 295 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 295 1>;
+		assigned-clock-parents = <&k3_clks 295 5>;
+		status = "disabled";
+	};
+
+	mcu_watchdog1: watchdog@40610000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x40610000 0x00 0x100>;
+		clocks = <&k3_clks 296 1>;
+		power-domains = <&k3_pds 296 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 296 1>;
+		assigned-clock-parents = <&k3_clks 296 5>;
+		status = "disabled";
+	};
 };
-- 
2.17.1

