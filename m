Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31651776D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 02:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjHJA4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 20:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHJA4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 20:56:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CC71982;
        Wed,  9 Aug 2023 17:56:41 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A0uWeD079016;
        Wed, 9 Aug 2023 19:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691628992;
        bh=nAfhAzgqJrcaITECZY1eX2E0itZ34RXhq7XV/mPackg=;
        h=From:To:CC:Subject:Date;
        b=MUvOXhkNFusqTrycbHmbVvPXEcbhZX9e1WQseJW33ThIJE4gPLGdTruu2DQ9IcF3H
         pEXTixL0bBjV9UByBbprmhLhML3lopvBdE0v7mWOZI/lz+x+1lA8XeEpKhQ+o7BU46
         DPoZUvu3yiAzvonGkMNA0TG78ro0JFHGFg/WONpQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A0uW7R071275
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 19:56:32 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 19:56:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 19:56:32 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A0uWDh055023;
        Wed, 9 Aug 2023 19:56:32 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-j784s4-main: disable remote proc nodes
Date:   Wed, 9 Aug 2023 19:56:29 -0500
Message-ID: <20230810005629.21738-1-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

Disable the dsp and r5f subsystem nodes by default. Proper functioning
of remote processors with ipc need mailbox configurations which can
vary between board configurations and applications. Hence move enabling
the remote processor device nodes to where the required configurations
are complete.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
This patch fixes the remote proc yamllint errors for am69-sk board

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index a04c44708a09..e7b54338b220 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -1402,6 +1402,7 @@ main_r5fss0: r5fss@5c00000 {
 		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
 			 <0x5d00000 0x00 0x5d00000 0x20000>;
 		power-domains = <&k3_pds 336 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 
 		main_r5fss0_core0: r5f@5c00000 {
 			compatible = "ti,j721s2-r5f";
@@ -1442,6 +1443,7 @@ main_r5fss1: r5fss@5e00000 {
 		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
 			 <0x5f00000 0x00 0x5f00000 0x20000>;
 		power-domains = <&k3_pds 337 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 
 		main_r5fss1_core0: r5f@5e00000 {
 			compatible = "ti,j721s2-r5f";
@@ -1482,6 +1484,7 @@ main_r5fss2: r5fss@5900000 {
 		ranges = <0x5900000 0x00 0x5900000 0x20000>,
 			 <0x5a00000 0x00 0x5a00000 0x20000>;
 		power-domains = <&k3_pds 338 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 
 		main_r5fss2_core0: r5f@5900000 {
 			compatible = "ti,j721s2-r5f";
@@ -1524,6 +1527,7 @@ c71_0: dsp@64800000 {
 		ti,sci-proc-ids = <0x30 0xff>;
 		resets = <&k3_reset 30 1>;
 		firmware-name = "j784s4-c71_0-fw";
+		status = "disabled";
 	};
 
 	c71_1: dsp@65800000 {
@@ -1536,6 +1540,7 @@ c71_1: dsp@65800000 {
 		ti,sci-proc-ids = <0x31 0xff>;
 		resets = <&k3_reset 33 1>;
 		firmware-name = "j784s4-c71_1-fw";
+		status = "disabled";
 	};
 
 	c71_2: dsp@66800000 {
@@ -1548,6 +1553,7 @@ c71_2: dsp@66800000 {
 		ti,sci-proc-ids = <0x32 0xff>;
 		resets = <&k3_reset 37 1>;
 		firmware-name = "j784s4-c71_2-fw";
+		status = "disabled";
 	};
 
 	c71_3: dsp@67800000 {
@@ -1560,5 +1566,6 @@ c71_3: dsp@67800000 {
 		ti,sci-proc-ids = <0x33 0xff>;
 		resets = <&k3_reset 40 1>;
 		firmware-name = "j784s4-c71_3-fw";
+		status = "disabled";
 	};
 };
-- 
2.34.1

