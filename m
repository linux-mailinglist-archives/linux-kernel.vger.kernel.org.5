Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EB5778196
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbjHJT3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbjHJT3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:29:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0819126A0;
        Thu, 10 Aug 2023 12:29:50 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AJTadt001587;
        Thu, 10 Aug 2023 14:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691695776;
        bh=FiJCR7yJLEMZTDpeB2yH3hbmht/9ZbSgRee+Gj9dwVo=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=uFyHWTKLbdkGiEi/0UY0hJctRuoYzzJd3Nq44xV6Nyh1pG711awSDBiDN3Y9x6NZg
         5dIleBOL2KcHCvXG88DFMESmfrFYLpQauUQb3RnqNNIvruBLKUmVG9W114XwpzDejz
         +bbLc0sLHjYG5doy16E9ojh68OQvf+8ATzmBihJM=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AJTaE9109005
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 14:29:36 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 14:29:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 14:29:36 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AJTZI0021444;
        Thu, 10 Aug 2023 14:29:35 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Date:   Fri, 11 Aug 2023 00:58:52 +0530
Subject: [PATCH v2 5/6] arm64: dts: ti: k3-am62: Add dt node, cbass_main
 ranges for MCRC64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230719-mcrc-upstream-v2-5-4152b987e4c2@ti.com>
References: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
In-Reply-To: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691695767; l=1736;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=PQ29srS8CIAyTw2SOnS1apCZNWSsj0TeJse9EG6sII0=;
 b=e3NaQlbAGavNqr96O6W3XUWbMY4N2girHX5Bj4vY7jvMXMwQScUHclwVFvZeKRBBzOFxgrhgV
 sNZBdP75OMcDyWI6dCEhtO1WxlOMbpWSkaE7llveTIcZyVJmMHALvaB
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 5f19ef46d44c..84a7e7d43d02 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -201,6 +201,13 @@ crypto: crypto@40900000 {
 		dma-names = "tx", "rx1", "rx2";
 	};
 
+	crc: crc@30300000 {
+		compatible = "ti,am62-mcrc64";
+		reg = <0x00 0x30300000 0x00 0x1000>;
+		clocks = <&k3_clks 116 0>;
+		power-domains = <&k3_pds 116 TI_SCI_PD_EXCLUSIVE>;
+	};
+
 	secure_proxy_sa3: mailbox@43600000 {
 		compatible = "ti,am654-secure-proxy";
 		#mbox-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
index 5e72c445f37a..7acd8009aa28 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -65,6 +65,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
 			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00010100>, /* CSI window */
 			 <0x00 0x30200000 0x00 0x30200000 0x00 0x00010000>, /* DSS */
+			 <0x00 0x30300000 0x00 0x30300000 0x00 0x00001000>, /* MCRC64 */
 			 <0x00 0x31000000 0x00 0x31000000 0x00 0x00050000>, /* USB0 DWC3 Core window */
 			 <0x00 0x31100000 0x00 0x31100000 0x00 0x00050000>, /* USB1 DWC3 Core window */
 			 <0x00 0x40900000 0x00 0x40900000 0x00 0x00030000>, /* SA3UL */

-- 
2.34.1

