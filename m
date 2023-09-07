Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2481797F46
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbjIGXi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjIGXiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:38:25 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D1F1BC6;
        Thu,  7 Sep 2023 16:38:21 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 387BvLcg105870;
        Thu, 7 Sep 2023 06:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694087841;
        bh=6bopD5MB0j9Sqf+m7lZaHw4lVjNjBzjuvwK3tClqVw8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OO712YtINAguDDRLpfoLLiy2twRrgg8VIAoaTTEOqOyqlW+uWVBRslyvljxOgVDVo
         lLGeOLwInWxeOUYa1kM1RhcNXmwi8RqXf01UzJZED0pi77Z/bWOmV/5dKLZbV2TUZL
         K7q6yWDS3uQqW8mRCIQZAG/pDizW5mLqpuv3FWUU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 387BvLgb083034
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Sep 2023 06:57:21 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 06:57:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 06:57:20 -0500
Received: from localhost.localdomain (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 387BusmW005696;
        Thu, 7 Sep 2023 06:57:17 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <j-keerthy@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v2 6/7] arm64: dts: ti: k3-j721s2-main: Add the main domain watchdog instances
Date:   Thu, 7 Sep 2023 17:26:48 +0530
Message-ID: <20230907115649.28289-7-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230907115649.28289-1-j-keerthy@ti.com>
References: <20230907115649.28289-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are totally 9 instances of watchdog module. One each for the
2 A72 cores, one each for the 2 C7x cores, 1 for the GPU, 1 each
for the 4 R5F cores in the main domain. Keeping only the A72 instances
enabled and disabling the rest by default.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 88 ++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index c60c5116bace..b9e0953e4fb3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -1701,4 +1701,92 @@
 		reg = <0x00 0x700000 0x00 0x1000>;
 		ti,esm-pins = <688>, <689>;
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
+	watchdog16: watchdog@2300000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2300000 0x00 0x100>;
+		clocks = <&k3_clks 288 1>;
+		power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 288 1>;
+		assigned-clock-parents = <&k3_clks 288 5>;
+		status = "disabled";
+	};
+
+	watchdog17: watchdog@2310000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2310000 0x00 0x100>;
+		clocks = <&k3_clks 289 1>;
+		power-domains = <&k3_pds 289 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 289 1>;
+		assigned-clock-parents = <&k3_clks 289 5>;
+		status = "disabled";
+	};
+
+	watchdog15: watchdog@22f0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x22f0000 0x00 0x100>;
+		clocks = <&k3_clks 290 1>;
+		power-domains = <&k3_pds 290 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 290 1>;
+		assigned-clock-parents = <&k3_clks 290 5>;
+		status = "disabled";
+	};
+
+	watchdog28: watchdog@23c0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23c0000 0x00 0x100>;
+		clocks = <&k3_clks 291 1>;
+		power-domains = <&k3_pds 291 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 291 1>;
+		assigned-clock-parents = <&k3_clks 291 5>;
+		status = "disabled";
+	};
+
+	watchdog29: watchdog@23d0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23d0000 0x00 0x100>;
+		clocks = <&k3_clks 292 1>;
+		power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 292 1>;
+		assigned-clock-parents = <&k3_clks 292 5>;
+		status = "disabled";
+	};
+
+	watchdog30: watchdog@23e0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23e0000 0x00 0x100>;
+		clocks = <&k3_clks 293 1>;
+		power-domains = <&k3_pds 293 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 293 1>;
+		assigned-clock-parents = <&k3_clks 293 5>;
+		status = "disabled";
+	};
+
+	watchdog31: watchdog@23f0000 {
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

