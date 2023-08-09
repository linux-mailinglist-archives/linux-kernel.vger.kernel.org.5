Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE697766DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjHISCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjHISBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:01:55 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AED01BD9;
        Wed,  9 Aug 2023 11:01:54 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379I1ljU120397;
        Wed, 9 Aug 2023 13:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691604107;
        bh=2GcltlLr2Cryy6/HKdClkFMNUHRT9qaoDZYMPFDOI5M=;
        h=From:To:CC:Subject:Date;
        b=pIcrggmeDpJvIIJ0GjKG6deaSxbXi02FNXaK3OD+3BdG4CHGhn6G0/gXU6msD+EPh
         jQ16dnIHBVd7mmny/ZKgJ6IiLUROMs9W9IOeeI5ewmP8jyyXWT2oq9Vw2K2y9lQpEq
         V9/HCwqopBPVKjXKBkFTUk6Svpgc5sBN5EVDZI3Q=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379I1lZL096419
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 13:01:47 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 13:01:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 13:01:47 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379I1k56103030;
        Wed, 9 Aug 2023 13:01:46 -0500
From:   Andrew Davis <afd@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Udit Kumar <u-kumar1@ti.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-j721e: Enable C7x DSP nodes at the board level
Date:   Wed, 9 Aug 2023 13:01:43 -0500
Message-ID: <20230809180145.53158-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

C7x DSP nodes defined in the top-level J721e SoC dtsi files are incomplete
and will not be functional unless they are extended with both mboxes and
memory-region information.

As theses only known about at the board integration level, these nodes
should only be enabled when provided with this information.

Disable the C7x DSP nodes in the dtsi files and only enable the ones that
are given the required mboxes and memory-region on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 1 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          | 1 +
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             | 1 +
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index 66aac145e7530..d1235e7c786d6 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -1024,6 +1024,7 @@ &c66_1 {
 };
 
 &c71_0 {
+	status = "okay";
 	mboxes = <&mailbox0_cluster4>, <&mbox_c71_0>;
 	memory-region = <&c71_0_dma_memory_region>,
 			<&c71_0_memory_region>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 3acd55ffd4ffc..1aeb97b42b34b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -2134,6 +2134,7 @@ c71_0: dsp@64800000 {
 		ti,sci-proc-ids = <0x30 0xff>;
 		resets = <&k3_reset 15 1>;
 		firmware-name = "j7-c71_0-fw";
+		status = "disabled";
 	};
 
 	icssg0: icssg@b000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 0ee4f38ec8f03..377588ba30998 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -1110,6 +1110,7 @@ &c66_1 {
 };
 
 &c71_0 {
+	status = "okay";
 	mboxes = <&mailbox0_cluster4>, <&mbox_c71_0>;
 	memory-region = <&c71_0_dma_memory_region>,
 			<&c71_0_memory_region>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index e90e43202546e..3c31ab57e959c 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -436,6 +436,7 @@ &c66_1 {
 };
 
 &c71_0 {
+	status = "okay";
 	mboxes = <&mailbox0_cluster4>, <&mbox_c71_0>;
 	memory-region = <&c71_0_dma_memory_region>,
 			<&c71_0_memory_region>;
-- 
2.39.2

