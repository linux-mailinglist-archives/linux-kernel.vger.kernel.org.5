Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BAE7B491E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 20:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjJASPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 14:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjJASPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 14:15:21 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7326B10C8;
        Sun,  1 Oct 2023 11:15:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 391IEthp030753;
        Sun, 1 Oct 2023 13:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696184095;
        bh=eUKyMaiwDBhhDfao3HgGqZKXZHY07oNCCupSFQouZUQ=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=skJX9Hdq4pIy8nqaRd9lFinNa9h1D0ysL9295CDz/5/5rAj5ReAyQLcfL0GNp7ukW
         /1+XAN+v01UebHwcb+8UZi3t3rXHy9xDuWx40knedaUmZudym/5p9syxjF7O0vcLxa
         hZDJw12RqB/ZvDfpoKsayJF9bBKvI2v01z6Y0/ys=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 391IEtGY004949
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 1 Oct 2023 13:14:55 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Oct 2023 13:14:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Oct 2023 13:14:54 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 391IEHtw063395;
        Sun, 1 Oct 2023 13:14:51 -0500
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
Subject: [PATCH v5 9/9] arm64: dts : ti: k3-am69-sk: Add DDR carveout memory nodes for C71x DSP
Date:   Sun, 1 Oct 2023 23:44:17 +0530
Message-ID: <20231001181417.743306-10-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001181417.743306-1-a-nandan@ti.com>
References: <20231001181417.743306-1-a-nandan@ti.com>
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

Two carveout reserved memory nodes each have been added for each of the
C71x DSP for the TI K3 AM69 SK boards. These nodes are assigned to the
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
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 104 ++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 3cde9c644613..bc1d21ff6d03 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -143,6 +143,54 @@ main_r5fss2_core1_memory_region: r5f-memory@a7100000 {
 			reg = <0x00 0xa7100000 0x00 0xf00000>;
 			no-map;
 		};
+
+		c71_0_dma_memory_region: c71-dma-memory@a8000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa8000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c71_0_memory_region: c71-memory@a8100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa8100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c71_1_dma_memory_region: c71-dma-memory@a9000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa9000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c71_1_memory_region: c71-memory@a9100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa9100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c71_2_dma_memory_region: c71-dma-memory@aa000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xaa000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c71_2_memory_region: c71-memory@aa100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xaa100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c71_3_dma_memory_region: c71-dma-memory@ab000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xab000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c71_3_memory_region: c71-memory@ab100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xab100000 0x00 0xf00000>;
+			no-map;
+		};
 	};
 
 	vusb_main: regulator-vusb-main5v0 {
@@ -400,6 +448,34 @@ mbox_main_r5fss2_core1: mbox-main-r5fss2-core1 {
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
+&mailbox0_cluster5 {
+	status = "okay";
+	interrupts = <416>;
+	mbox_c71_2: mbox-c71-2 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_c71_3: mbox-c71-3 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
 &wkup_uart0 {
 	/* Firmware usage */
 	status = "reserved";
@@ -562,3 +638,31 @@ &main_r5fss2_core1 {
 	memory-region = <&main_r5fss2_core1_dma_memory_region>,
 			<&main_r5fss2_core1_memory_region>;
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
+
+&c71_2 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster5>, <&mbox_c71_2>;
+	memory-region = <&c71_2_dma_memory_region>,
+			<&c71_2_memory_region>;
+};
+
+&c71_3 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster5>, <&mbox_c71_3>;
+	memory-region = <&c71_3_dma_memory_region>,
+			<&c71_3_memory_region>;
+};
-- 
2.34.1

