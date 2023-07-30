Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C18768735
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 20:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjG3S4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 14:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjG3S4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 14:56:35 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE17C10F0;
        Sun, 30 Jul 2023 11:56:30 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36UIuHFb009252;
        Sun, 30 Jul 2023 13:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690743377;
        bh=eFwkKcDHy5a0D+fjNeM04lyGOmAYW9xO+TcXBwnbHD0=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=KtE9TGkfcqoi/KxVU2s+Zurg8Xnw79KmfXs5lgM9QSOC5nTkLy9hqXNcB7y1ae7xH
         CRmuFrSVOloN4vWa/7ckaFMDZbJnQmanvq2LK4wvfyXtK/tjHz7hUZFVSOTO5UNr1v
         SCOB1Yo9qIPq9dQBBys3srUIJXgbeMlBnTHnAlRQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36UIuHTo017919
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Jul 2023 13:56:17 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 30
 Jul 2023 13:56:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 30 Jul 2023 13:56:16 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36UIuGMs015693;
        Sun, 30 Jul 2023 13:56:16 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Date:   Mon, 31 Jul 2023 00:25:57 +0530
Subject: [PATCH 4/5] arm64: dts: ti: k3-am62: Add dt node, cbass_main
 ranges for MCRC64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230719-mcrc-upstream-v1-4-dc8798a24c47@ti.com>
References: <20230719-mcrc-upstream-v1-0-dc8798a24c47@ti.com>
In-Reply-To: <20230719-mcrc-upstream-v1-0-dc8798a24c47@ti.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690743369; l=1735;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=rAsjlJl8jzh/RLqkLURx52tluKdmY4dVom5JnKv6FS0=;
 b=McAciNLcv3haU/bDoIP9th+WdovQV2ntG5bQk2Wmm/aNNeznmBp1UBW8R7dZfbKgMLZgLZgdf
 aPjpf46AKxZBRDkKO2IA1CTOS87wZZ0XxiYC9xLsWggIKT7rHrC9QLw
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the address space for MCRC64 to the ranges property of the
cbass_main node and add dt node for MCRC64 engine

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 7 +++++++
 arch/arm64/boot/dts/ti/k3-am62.dtsi      | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 33b6aadc9083..bd12616a120c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -183,6 +183,13 @@ crypto: crypto@40900000 {
 		dma-names = "tx", "rx1", "rx2";
 	};
 
+	mcrc64: mcrc64@30300000 {
+		compatible = "ti,mcrc64";
+		reg = <0x00 0x30300000 0x00 0x1000>;
+		clocks = <&k3_clks 116 0>;
+		power-domains = <&k3_pds 116 TI_SCI_PD_EXCLUSIVE>;
+	};
+
 	secure_proxy_sa3: mailbox@43600000 {
 		compatible = "ti,am654-secure-proxy";
 		#mbox-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
index 5e72c445f37a..1511e649a916 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -65,6 +65,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
 			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00010100>, /* CSI window */
 			 <0x00 0x30200000 0x00 0x30200000 0x00 0x00010000>, /* DSS */
+			 <0x00 0x30300000 0x00 0x30300000 0x00 0x00001000>, /* MCRC */
 			 <0x00 0x31000000 0x00 0x31000000 0x00 0x00050000>, /* USB0 DWC3 Core window */
 			 <0x00 0x31100000 0x00 0x31100000 0x00 0x00050000>, /* USB1 DWC3 Core window */
 			 <0x00 0x40900000 0x00 0x40900000 0x00 0x00030000>, /* SA3UL */

-- 
2.34.1

