Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821B87E828E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjKJT3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346313AbjKJT2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:28:34 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EAAA7522;
        Fri, 10 Nov 2023 05:25:34 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AADPOke039033;
        Fri, 10 Nov 2023 07:25:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699622724;
        bh=Kj3QbB6T4AI9lsPOH7GSuVqfZc/NRGxVS2s+h5UDiIk=;
        h=From:To:CC:Subject:Date;
        b=RfdNUs7g3F+0Q0nf8G3Q2LF0cKhrI7ZwjjIb1OLGr88KD1anj2SzSfS/HAeW8ZA3P
         c0K4n4Kcemvqvbj+zqjfg3T82GGyHLIoim2dVc1GMXcBluOC1A5EMNY9wCLEEgjrSu
         8uppWm85XZc7QT5jt4WErFHutH/9OH1igQIi/19I=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AADPObH025907
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Nov 2023 07:25:24 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 07:25:23 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 07:25:23 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AADPKXY041795;
        Fri, 10 Nov 2023 07:25:21 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] arm64: dts: ti: k3-am642-evm/sk: Mark mcu_gpio_intr as reserved
Date:   Fri, 10 Nov 2023 18:55:06 +0530
Message-ID: <20231110132508.3137454-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.42.0
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

Similar to MCU GPIO, mark the MCU GPIO router also as reserved for MCU
domain firmware usage.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 6 +++++-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts  | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 4dba18941015..45f64b6f8281 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -468,11 +468,15 @@ &main_gpio0 {
 	bootph-all;
 };
 
-/* mcu_gpio0 is reserved for mcu firmware usage */
+/* mcu_gpio0 and mcu_gpio_intr are reserved for mcu firmware usage */
 &mcu_gpio0 {
 	status = "reserved";
 };
 
+&mcu_gpio_intr {
+	status = "reserved";
+};
+
 &main_spi0 {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index f29c8a9b59ba..d2d3b5017ac4 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -433,11 +433,15 @@ exp2: gpio@60 {
 	};
 };
 
-/* mcu_gpio0 is reserved for mcu firmware usage */
+/* mcu_gpio0 and mcu_gpio_intr are reserved for mcu firmware usage */
 &mcu_gpio0 {
 	status = "reserved";
 };
 
+&mcu_gpio_intr {
+	status = "reserved";
+};
+
 &sdhci0 {
 	vmmc-supply = <&wlan_en>;
 	bus-width = <4>;
-- 
2.42.0

