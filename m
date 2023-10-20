Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC27D078F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346633AbjJTFUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjJTFT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:19:58 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A445D51;
        Thu, 19 Oct 2023 22:19:56 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39K5JibB047984;
        Fri, 20 Oct 2023 00:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697779184;
        bh=0Pqn2OGPXM8kTWPiB0Qjuk0mw9waFYyVvPCF2PsR/8U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=w8+WeT47dklNa5RNJqV0rPpA1dhTXmMV8HQrVG7H8pWdyjhAq2Gs6W6advJ94q0D4
         fN+KUiLiPqACvOgkhe50UG2qYzdd5rUTe920Lb3j0vgx3B7gbBvOh/mDT9ULOZajZ6
         MOAAgK6qlluzbDdllplptqQJx9zA04w/3ZaxaSxQ=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39K5JiSZ005497
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Oct 2023 00:19:44 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Oct 2023 00:19:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Oct 2023 00:19:44 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39K5JiNL042170;
        Fri, 20 Oct 2023 00:19:44 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.31])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 39K5JhAN026777;
        Fri, 20 Oct 2023 00:19:44 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH v6 1/3] arm64: dts: ti: k3-am65-main: Add ICSSG IEP nodes
Date:   Fri, 20 Oct 2023 10:49:35 +0530
Message-ID: <20231020051937.3709871-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020051937.3709871-1-danishanwar@ti.com>
References: <20231020051937.3709871-1-danishanwar@ti.com>
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

The ICSSG IP on AM65x SoCs have two Industrial Ethernet Peripherals (IEPs)
to manage/generate Industrial Ethernet functions such as time stamping.
Each IEP sub-module is sourced from an internal clock mux that can be
sourced from either of the IP instance's ICSSG_IEP_GCLK or ICSSG_ICLK.
Add the IEP nodes for all the ICSSG instances.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 36 ++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index d0c85eb3bb04..5ebb87f467de 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -1151,6 +1151,18 @@ icssg0_iepclk_mux: iepclk-mux@30 {
 			};
 		};
 
+		icssg0_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg0_iepclk_mux>;
+		};
+
+		icssg0_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg0_iepclk_mux>;
+		};
+
 		icssg0_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;
@@ -1293,6 +1305,18 @@ icssg1_iepclk_mux: iepclk-mux@30 {
 			};
 		};
 
+		icssg1_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg1_iepclk_mux>;
+		};
+
+		icssg1_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg1_iepclk_mux>;
+		};
+
 		icssg1_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;
@@ -1435,6 +1459,18 @@ icssg2_iepclk_mux: iepclk-mux@30 {
 			};
 		};
 
+		icssg2_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg2_iepclk_mux>;
+		};
+
+		icssg2_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg2_iepclk_mux>;
+		};
+
 		icssg2_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;
-- 
2.34.1

