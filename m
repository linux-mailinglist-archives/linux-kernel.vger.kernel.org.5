Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3112C78DE61
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241036AbjH3TCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242207AbjH3H1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:27:22 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34951BE;
        Wed, 30 Aug 2023 00:27:18 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37U7R5gi101375;
        Wed, 30 Aug 2023 02:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693380425;
        bh=yjj/DRJ+owa+QmrJdEDHY3LLteR+DaXWiK8Q0siZ6OE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=i1s6dQeMMHCsrsyFUVdy1Ugd/GmgVnOXZ4RURsCujL+Oea2Q6zejp0ktNP3PjlFpM
         +JDqpaZavRxUMZiEVbk61FkQNDnFeMbPeq2QcYsZnwHJLFoimugS1WdOT2evBhGzmC
         DL+gV7ZdTjGVCfS/3FT2y6qpmusraoJOyzOmkIEM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37U7R5Cb101962
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Aug 2023 02:27:05 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Aug 2023 02:27:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Aug 2023 02:27:04 -0500
Received: from localhost.localdomain (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37U7QuLI125116;
        Wed, 30 Aug 2023 02:27:01 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kristo@kernel.org>
CC:     <j-keerthy@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] arm64: dts: ti: k3-j721s2: Add ESM instances
Date:   Wed, 30 Aug 2023 12:56:18 +0530
Message-ID: <20230830072622.19539-2-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230830072622.19539-1-j-keerthy@ti.com>
References: <20230830072622.19539-1-j-keerthy@ti.com>
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

Patch adds the ESM instances for j721s2. It has 3 instances.
One in the main domain and two in the mcu-wakeup domian.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi       |  6 ++++++
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index ed79ab3a3271..87841bcc509d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -1507,4 +1507,10 @@
 		clocks = <&k3_clks 346 1>;
 		status = "disabled";
 	};
+
+	main_esm: esm@700000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x0 0x700000 0x0 0x1000>;
+		ti,esm-pins = <344>, <345>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index e7dd947a1814..e8c6c27c2e2c 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -652,4 +652,16 @@
 		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
 	};
+
+	mcu_esm: esm@40800000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x0 0x40800000 0x0 0x1000>;
+		ti,esm-pins = <95>;
+	};
+
+	wkup_esm: esm@42080000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x0 0x42080000 0x0 0x1000>;
+		ti,esm-pins = <63>;
+	};
 };
-- 
2.17.1

