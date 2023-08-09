Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB3E7766DC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjHISCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjHISCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:02:00 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B0C1736;
        Wed,  9 Aug 2023 11:01:57 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379I1nRS062917;
        Wed, 9 Aug 2023 13:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691604109;
        bh=5XC7IHqNeHF88ET4FV2U6UheHdVvXt6Qi6ZuCGWeDVQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gEPnebiTchlKxzx4rG0tb+1sgQWWsbdBlivo+25wLUpmf+wjPJxIKzaNkDqAJVdTU
         Gj28pRgXEq6Ow1iaz4zWohfrH92cAimmK4aeAGLczvLH7n7ry3fTjUyjV47vN5gNp8
         gkTj9c/zVZm3ehdzp2gL4lnYjwooyRoPuHb4UdTY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379I1n7s012097
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 13:01:49 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 13:01:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 13:01:48 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379I1k58103030;
        Wed, 9 Aug 2023 13:01:48 -0500
From:   Andrew Davis <afd@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Udit Kumar <u-kumar1@ti.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j721e: Enable C6x DSP nodes at the board level
Date:   Wed, 9 Aug 2023 13:01:45 -0500
Message-ID: <20230809180145.53158-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809180145.53158-1-afd@ti.com>
References: <20230809180145.53158-1-afd@ti.com>
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

C6x DSP nodes defined in the top-level J721e SoC dtsi files are incomplete
and will not be functional unless they are extended with both mboxes and
memory-region information.

As theses only known about at the board integration level, these nodes
should only be enabled when provided with this information.

Disable the C6x DSP nodes in the dtsi files and only enable the ones that
are given the required mboxes and memory-region on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 2 ++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          | 2 ++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             | 2 ++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index d1235e7c786d6..f6516a36f9039 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -1012,12 +1012,14 @@ &main_r5fss1_core1 {
 };
 
 &c66_0 {
+	status = "okay";
 	mboxes = <&mailbox0_cluster3>, <&mbox_c66_0>;
 	memory-region = <&c66_0_dma_memory_region>,
 			<&c66_0_memory_region>;
 };
 
 &c66_1 {
+	status = "okay";
 	mboxes = <&mailbox0_cluster3>, <&mbox_c66_1>;
 	memory-region = <&c66_1_dma_memory_region>,
 			<&c66_1_memory_region>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 1aeb97b42b34b..5da86921b1779 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -2109,6 +2109,7 @@ c66_0: dsp@4d80800000 {
 		ti,sci-proc-ids = <0x03 0xff>;
 		resets = <&k3_reset 142 1>;
 		firmware-name = "j7-c66_0-fw";
+		status = "disabled";
 	};
 
 	c66_1: dsp@4d81800000 {
@@ -2122,6 +2123,7 @@ c66_1: dsp@4d81800000 {
 		ti,sci-proc-ids = <0x04 0xff>;
 		resets = <&k3_reset 143 1>;
 		firmware-name = "j7-c66_1-fw";
+		status = "disabled";
 	};
 
 	c71_0: dsp@64800000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 377588ba30998..cce25f13cf8af 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -1098,12 +1098,14 @@ &main_r5fss1_core1 {
 };
 
 &c66_0 {
+	status = "okay";
 	mboxes = <&mailbox0_cluster3>, <&mbox_c66_0>;
 	memory-region = <&c66_0_dma_memory_region>,
 			<&c66_0_memory_region>;
 };
 
 &c66_1 {
+	status = "okay";
 	mboxes = <&mailbox0_cluster3>, <&mbox_c66_1>;
 	memory-region = <&c66_1_dma_memory_region>,
 			<&c66_1_memory_region>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index 3c31ab57e959c..eaf9e4564d032 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -424,12 +424,14 @@ &main_r5fss1_core1 {
 };
 
 &c66_0 {
+	status = "okay";
 	mboxes = <&mailbox0_cluster3>, <&mbox_c66_0>;
 	memory-region = <&c66_0_dma_memory_region>,
 			<&c66_0_memory_region>;
 };
 
 &c66_1 {
+	status = "okay";
 	mboxes = <&mailbox0_cluster3>, <&mbox_c66_1>;
 	memory-region = <&c66_1_dma_memory_region>,
 			<&c66_1_memory_region>;
-- 
2.39.2

