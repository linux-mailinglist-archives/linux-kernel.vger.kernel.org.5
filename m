Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659DD81140B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379375AbjLMOEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379239AbjLMOEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:04:37 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017CE2718;
        Wed, 13 Dec 2023 05:51:57 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BDDpll3026773;
        Wed, 13 Dec 2023 07:51:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702475507;
        bh=ALW9zThfv5LSEPU4i6e67keaT9XMRbgcY0oV0r49IkI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=S2UHxNxxabIPEzZkLNVhFA2xuqSL5egl968xqxCuOFvGHF6zUT/BjhH4mfh8vMhkt
         e7SCTLy39nBjFwxC15UpdGKRsHAOSGLHtuI3KzLegY/8ZVoEhlR2R5BX7oVcPXNdUL
         k5jA6H0D/uZk8nlFfPYS9BimZcr2RC+APPM3Tb08=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BDDplHu120614
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Dec 2023 07:51:47 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 07:51:47 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 07:51:47 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BDDpeLC101220;
        Wed, 13 Dec 2023 07:51:44 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-luthra@ti.com>
Subject: [PATCH v2 1/3] arm64: dts: ti: k3-am65: Add additional regs for DMA components
Date:   Wed, 13 Dec 2023 19:21:36 +0530
Message-ID: <20231213135138.929517-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213135138.929517-1-vigneshr@ti.com>
References: <20231213135138.929517-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manorit Chawdhry <m-chawdhry@ti.com>

Add additional reg properties for UDMA and RingAcc nodes which are
mostly used by bootloader components before Device Manager firmware
services are available, in order to setup DMA transfers.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 8 ++++++--
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi  | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index cc59fc648b56..fcea54465636 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -792,8 +792,12 @@ main_udmap: dma-controller@31150000 {
 			compatible = "ti,am654-navss-main-udmap";
 			reg = <0x0 0x31150000 0x0 0x100>,
 			      <0x0 0x34000000 0x0 0x100000>,
-			      <0x0 0x35000000 0x0 0x100000>;
-			reg-names = "gcfg", "rchanrt", "tchanrt";
+			      <0x0 0x35000000 0x0 0x100000>,
+			      <0x0 0x30b00000 0x0 0x10000>,
+			      <0x0 0x30c00000 0x0 0x10000>,
+			      <0x0 0x30d00000 0x0 0x8000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt",
+				    "tchan", "rchan", "rflow";
 			msi-parent = <&inta_main_udmass>;
 			#dma-cells = <1>;
 
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index edd5cfbec40e..ecd7356f3315 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -214,8 +214,12 @@ mcu_udmap: dma-controller@285c0000 {
 			compatible = "ti,am654-navss-mcu-udmap";
 			reg = <0x0 0x285c0000 0x0 0x100>,
 			      <0x0 0x2a800000 0x0 0x40000>,
-			      <0x0 0x2aa00000 0x0 0x40000>;
-			reg-names = "gcfg", "rchanrt", "tchanrt";
+			      <0x0 0x2aa00000 0x0 0x40000>,
+			      <0x0 0x284a0000 0x0 0x4000>,
+			      <0x0 0x284c0000 0x0 0x4000>,
+			      <0x0 0x28400000 0x0 0x2000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt",
+				    "tchan", "rchan", "rflow";
 			msi-parent = <&inta_main_udmass>;
 			#dma-cells = <1>;
 
-- 
2.43.0

