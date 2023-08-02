Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE4C76D8F6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjHBUxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjHBUxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:53:25 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777BF26AB;
        Wed,  2 Aug 2023 13:53:24 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372KrIw1109479;
        Wed, 2 Aug 2023 15:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691009598;
        bh=zciprX999203YuLCsDKMILGBWNGLQeNjXQ4jCdJgqyY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SZupBAirJmJK0+8vjR4+i1iRrrV3yDGeHsCX8HydfoZQ1E5f8+ZqSaDtIIkBf/uq0
         FnKh6ZiqhwBZkkz2FIlGTeC/3fi4+ZKBAQA2BUj7Q8DKAMDU8yby4HsVCxc+5sx9rX
         89+UGKbrAfmim87s183dwqFkOKQbLoYeRBn8I350=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372KrIqV018962
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 15:53:18 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 15:53:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 15:53:18 -0500
Received: from lelv0326.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372KrASJ090834;
        Wed, 2 Aug 2023 15:53:17 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 12/13] arm64: dts: ti: k3-am65: Enable TSCADC nodes at the board level
Date:   Wed, 2 Aug 2023 15:53:08 -0500
Message-ID: <20230802205309.257392-13-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802205309.257392-1-afd@ti.com>
References: <20230802205309.257392-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TSCADC nodes defined in the top-level AM65 SoC dtsi files are incomplete
and may not be functional unless they are extended with pinmux and/or
device information.

Disable the TSCADC nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 5 +----
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            | 2 ++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 2 ++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 6041862d5aa75..ba1c14a54acf4 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -582,11 +582,8 @@ &mcu_spi0 {
 	ti,pindir-d0-out-d1-in;
 };
 
-&tscadc0 {
-	status = "disabled";
-};
-
 &tscadc1 {
+	status = "okay";
 	adc {
 		ti,adc-channels = <0 1 2 3 4 5>;
 	};
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 2c9c20a9d9179..4defde540fe0b 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -112,6 +112,7 @@ tscadc0: tscadc@40200000 {
 		dmas = <&mcu_udmap 0x7100>,
 			<&mcu_udmap 0x7101 >;
 		dma-names = "fifo0", "fifo1";
+		status = "disabled";
 
 		adc {
 			#io-channel-cells = <1>;
@@ -130,6 +131,7 @@ tscadc1: tscadc@40210000 {
 		dmas = <&mcu_udmap 0x7102>,
 			<&mcu_udmap 0x7103>;
 		dma-names = "fifo0", "fifo1";
+		status = "disabled";
 
 		adc {
 			#io-channel-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 43de7c132d343..17f45a9f7b146 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -478,12 +478,14 @@ &usb0_phy {
 };
 
 &tscadc0 {
+	status = "okay";
 	adc {
 		ti,adc-channels = <0 1 2 3 4 5 6 7>;
 	};
 };
 
 &tscadc1 {
+	status = "okay";
 	adc {
 		ti,adc-channels = <0 1 2 3 4 5 6 7>;
 	};
-- 
2.39.2

