Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D4775C17C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGUIY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjGUIYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:24:23 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225F7270F;
        Fri, 21 Jul 2023 01:24:21 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36L8O49p006303;
        Fri, 21 Jul 2023 03:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689927844;
        bh=DM7YonzYOrWfC4RvmJONFc7fErZeSa4OYCbSVf6MFxo=;
        h=From:To:CC:Subject:Date;
        b=dAg6uCZ/HcJrpE4I4m7lm+fei90ugIfLlyHEv7j8gTxqLy6XBn0EG6PmpG+X+vATx
         jNoNTW8mhh7BQBIY8r1bKS7fvv+H+1Ss+XV3IsYzjVHtej7W/Kv4T3iOTjTMLcHRD7
         KYDOZ/e/wJYkGAGV3ZCJ5elAWplYGgoseXPxX+t4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36L8O46K117958
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jul 2023 03:24:04 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jul 2023 03:24:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jul 2023 03:24:03 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36L8O0SH114984;
        Fri, 21 Jul 2023 03:24:01 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j721e-som-p0: Remove Duplicated wkup_i2c0 node
Date:   Fri, 21 Jul 2023 13:53:44 +0530
Message-ID: <20230721082344.1534094-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wkup_i2c0 and associated eeprom device node were duplicated,
This patch fixes the node duplication.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Looks same patch is applied twice one with
sha id b04b18ccb3d5c and second time with sha id 4af0332876f94

 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index 38ae13cc3aa3..e90e43202546 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -201,19 +201,6 @@ eeprom@50 {
 	};
 };
 
-&wkup_i2c0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_i2c0_pins_default>;
-	clock-frequency = <400000>;
-
-	eeprom@50 {
-		/* CAV24C256WE-GT3 */
-		compatible = "atmel,24c256";
-		reg = <0x50>;
-	};
-};
-
 &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
-- 
2.34.1

