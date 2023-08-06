Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EA0771622
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 18:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjHFQtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 12:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFQs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 12:48:59 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9758310CC;
        Sun,  6 Aug 2023 09:48:58 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 376Gml6q020260;
        Sun, 6 Aug 2023 11:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691340527;
        bh=7q6VvTj7zCInrnfOecFlb1jOVk+v0+/lH9T8gEC27a0=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=PlIkdbwCCBitgLEcbG6bW+AqL2eGfN+3hG3ZwN/okpcRnhY5acEylVNuPqEfH04qG
         M9RiKD+lCH4AhkkMmhpuwCLEUBVLCe6LWznvXyngtCnwMD93Bed3HngG1vHn5feXP5
         ERlKXbgVn8evp4Zw6s0eoeXEW2SQKmsfE0UmghJg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 376GmlfS086824
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 6 Aug 2023 11:48:47 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 6
 Aug 2023 11:48:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 6 Aug 2023 11:48:46 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 376GmdMY009591;
        Sun, 6 Aug 2023 11:48:43 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-j784s4-main: Add bootph-pre-ram property for SPL nodes
Date:   Sun, 6 Aug 2023 22:18:36 +0530
Message-ID: <20230806164838.18088-2-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806164838.18088-1-a-nandan@ti.com>
References: <20230806164838.18088-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add bootph-pre-ram property for all the nodes used in SPL stage,
for syncing it later to u-boot j784s4 dts.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index a04c44708a09..6bba73c8f359 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -6,6 +6,7 @@
  */
 
 &cbass_main {
+	bootph-pre-ram;
 	msmc_ram: sram@70000000 {
 		compatible = "mmio-sram";
 		reg = <0x00 0x70000000 0x00 0x800000>;
@@ -670,6 +671,7 @@ main_sdhci1: mmc@4fb0000 {
 	};
 
 	main_navss: bus@30000000 {
+		bootph-pre-ram;
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -705,6 +707,7 @@ main_udmass_inta: msi-controller@33d00000 {
 		};
 
 		secure_proxy_main: mailbox@32c00000 {
+			bootph-pre-ram;
 			compatible = "ti,am654-secure-proxy";
 			#mbox-cells = <1>;
 			reg-names = "target_data", "rt", "scfg";
-- 
2.34.1

