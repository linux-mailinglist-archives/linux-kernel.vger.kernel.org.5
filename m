Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44D37B491B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 20:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjJASPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 14:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbjJASPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 14:15:00 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DD3112;
        Sun,  1 Oct 2023 11:14:52 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 391IElR9030324;
        Sun, 1 Oct 2023 13:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696184087;
        bh=SHbGXXOtRNPEQfLL0Egkty57qX5FHMAyWBjU1sLP7Ks=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=N70uEXNItN3Zj55ixip5ZjD0YKR2ncOy+tfDFz6Mj0ISrQM8zt9at+HetRveA+NFl
         5ajmNAxiRLTncVLiXF7zbIQd3J9jPKzr1Afwmc6jNAOfEO5r0DZ9TbTU/haSE4VPy+
         X6PUsDGrc10U+C40PVy1KrTEVx+bS8fhaaTZuFvQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 391IElW3042182
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 1 Oct 2023 13:14:47 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Oct 2023 13:14:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Oct 2023 13:14:47 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 391IEHtu063395;
        Sun, 1 Oct 2023 13:14:44 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v5 7/9] arm64: dts : ti: k3-am68-sk-som: Add DDR carveout memory nodes for C71x DSP
Date:   Sun, 1 Oct 2023 23:44:15 +0530
Message-ID: <20231001181417.743306-8-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001181417.743306-1-a-nandan@ti.com>
References: <20231001181417.743306-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Two carveout reserved memory nodes each have been added for each of the
C71x DSP for the TI K3 AM68 SK boards. These nodes are assigned to the
respective rproc device nodes as well. The first region will be used as
the DMA pool for the rproc device, and the second region will furnish
the static carveout regions for the firmware memory.

The current carveout addresses and sizes are defined statically for each
device. The C71x DSP processor supports a MMU called CMMU, but is not
currently supported and as such requires the exact memory used by the
firmware to be set-aside.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
index beab405274ab..20861a0a46b0 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
@@ -98,6 +98,30 @@ main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
 			no-map;
 		};
 
+		c71_0_dma_memory_region: c71-dma-memory@a6000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa6000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c71_0_memory_region: c71-memory@a6100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa6100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c71_1_dma_memory_region: c71-dma-memory@a7000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa7000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c71_1_memory_region: c71-memory@a7100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa7100000 0x00 0xf00000>;
+			no-map;
+		};
+
 		rtos_ipc_memory_region: ipc-memories@a8000000 {
 			reg = <0x00 0xa8000000 0x00 0x01c00000>;
 			alignment = <0x1000>;
@@ -170,6 +194,20 @@ mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
 	};
 };
 
+&mailbox0_cluster4 {
+	status = "okay";
+	interrupts = <420>;
+	mbox_c71_0: mbox-c71-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_c71_1: mbox-c71-1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
 &mcu_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
@@ -205,3 +243,17 @@ &main_r5fss1_core1 {
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
 };
+
+&c71_0 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster4>, <&mbox_c71_0>;
+	memory-region = <&c71_0_dma_memory_region>,
+			<&c71_0_memory_region>;
+};
+
+&c71_1 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster4>, <&mbox_c71_1>;
+	memory-region = <&c71_1_dma_memory_region>,
+			<&c71_1_memory_region>;
+};
-- 
2.34.1

