Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DB5797F2E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbjIGXY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjIGXY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:24:28 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D89CF3;
        Thu,  7 Sep 2023 16:24:23 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 387Bqj1x020288;
        Thu, 7 Sep 2023 06:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694087565;
        bh=YujZEUssrlbH/9FGuudc+2vsBtPLhKL2GTlDe8Yd7MM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xcg2TOA8tdqeD9pdEdQ1ltEh0DozGJ+tuyhyGDvWRF9usU147ScsQ4yc7N1f1clCG
         75mnyHX/eupxUK4Ay0i0AgesOPk+fdCeW8RSZUOcxR+2jWWLBSQZEjWThesZbBORTZ
         f+FZW2MpZaPT+Z8I9NdA1dQU7ZMuOKAIF06JzMfU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 387BqjYg002563
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Sep 2023 06:52:45 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 06:52:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 06:52:44 -0500
Received: from localhost.localdomain (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 387BqFVl129423;
        Thu, 7 Sep 2023 06:52:41 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <conor+dt@kernel.org>, <kristo@kernel.org>,
        <rzysztof.kozlowski+dt@linaro.org>
CC:     <j-keerthy@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 7/7] arm64: dts: ti: k3-j721s2-mcu: Add the main domain watchdog instances
Date:   Thu, 7 Sep 2023 17:22:10 +0530
Message-ID: <20230907115210.28082-8-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230907115210.28082-1-j-keerthy@ti.com>
References: <20230907115210.28082-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are totally 2 instances of watchdog module in MCU domain.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index e3f597f3e169..b5e3d6fb5e64 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -667,4 +667,24 @@
 		reg = <0x00 0x42080000 0x00 0x1000>;
 		ti,esm-pins = <63>;
 	};
+
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

