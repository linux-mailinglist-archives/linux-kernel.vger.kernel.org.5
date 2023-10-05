Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B4A7BABBF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjJEVCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjJEVCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:02:17 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB70A6;
        Thu,  5 Oct 2023 14:02:13 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3959bgMw075038;
        Thu, 5 Oct 2023 04:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696498662;
        bh=0Gn6/PYIoJpPuNDgc2yeQHtFCNiWP22YX5Y9NvePorw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=U9nURZmvVMbH3mqem4z4ZuiVQkDpLiHZMLJoXFYuXVpdppXVJCZfnHfT73U7iVrqB
         zG5YbeQmtSeptmmyWv8tjue45sMMd6xiuc86whDT0tSl+q8gIa/wa3DiEsnCViGplO
         UJyqgBjJy9zm8qRLbEcndqlEu1z/L8n2m4klktAU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3959bgos014587
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Oct 2023 04:37:42 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 04:37:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 04:37:42 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3959bfqi038670;
        Thu, 5 Oct 2023 04:37:41 -0500
From:   Nitin Yadav <n-yadav@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <rogerq@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] arm64: dts: ti: Add GPMC support for AM62x LP SK
Date:   Thu, 5 Oct 2023 15:07:37 +0530
Message-ID: <20231005093739.4071934-2-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005093739.4071934-1-n-yadav@ti.com>
References: <20231005093739.4071934-1-n-yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM62 SoC has GPMC ( General Purpose Memory Controller)
and ELM ( Error Location Module) which allow to interface
Parallel memory like NAND/NOR and FPGAs etc. Add DT nodes
for the same.

Include the ranges for GPMC CFG and DATA region in top
level dtsi file.

Keep these nodes disabled as they are incomplete without
required board level pinmux and client node definitions.

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 30 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62.dtsi      |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index ac760d9b831d..8fb47fbae4ca 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -965,4 +965,34 @@ mcasp2: audio-controller@2b20000 {
 		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
+
+	gpmc0: memory-controller@3b000000 {
+		compatible = "ti,am64-gpmc";
+		reg = <0x00 0x03b000000 0x00 0x400>,
+		      <0x00 0x050000000 0x00 0x8000000>;
+		reg-names = "cfg", "data";
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 80 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
+		gpmc,num-cs = <3>;
+		gpmc,num-waitpins = <2>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		status = "disabled";    /* Needs pinmux */
+	};
+
+	elm0: ecc@25010000 {
+		compatible = "ti,am3352-elm";
+		reg = <0x00 0x25010000 0x00 0x2000>;
+		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 54 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 54 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";    /* Depends on NAND to be present */
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
index f1e15206e1ce..5fa272eb0ac2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -68,11 +68,13 @@ cbass_main: bus@f0000 {
 			 <0x00 0x30200000 0x00 0x30200000 0x00 0x00010000>, /* DSS */
 			 <0x00 0x31000000 0x00 0x31000000 0x00 0x00050000>, /* USB0 DWC3 Core window */
 			 <0x00 0x31100000 0x00 0x31100000 0x00 0x00050000>, /* USB1 DWC3 Core window */
+			 <0x00 0x3b000000 0x00 0x3b000000 0x00 0x00000400>, /* GPMC0 CFG */
 			 <0x00 0x40900000 0x00 0x40900000 0x00 0x00030000>, /* SA3UL */
 			 <0x00 0x43600000 0x00 0x43600000 0x00 0x00010000>, /* SA3 sproxy data */
 			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
 			 <0x00 0x44860000 0x00 0x44860000 0x00 0x00040000>, /* SA3 sproxy config */
 			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>, /* DMSS */
+			 <0x00 0x50000000 0x00 0x50000000 0x00 0x08000000>, /* GPMC0 DATA */
 			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
 			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00010000>, /* OCSRAM */
 			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */
-- 
2.25.1

