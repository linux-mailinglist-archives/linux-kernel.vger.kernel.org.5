Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE627BA35A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjJEPzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237527AbjJEPyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:54:35 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72D722E2F;
        Thu,  5 Oct 2023 08:13:32 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395FDEfa049285;
        Thu, 5 Oct 2023 10:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696518794;
        bh=tc+4Knb3rB+SSc4axXMPlZYO5tdt4xokQuqcWG7C2UM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rlNkeKROw/pu3xJSN1NFnQCDihuIzllaylun2AmDooU/NzJO/xCokmp5dNDbq2/rm
         YKdNWXN+xLHF7ckYIXCWo4rkct+3CCbC/YsPrJeSVbvDr32MjcD9F+sllDVTIcFjlQ
         YLzU4juq59/nzDoNW5FbSIN5tIpkpR6kQedM5kBM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395FDE8Y028174
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Oct 2023 10:13:14 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 10:13:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 10:13:14 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395FD7Pc027216;
        Thu, 5 Oct 2023 10:13:11 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] arm64: dts: ti: k3-*: Convert DMSS to simple-bus
Date:   Thu, 5 Oct 2023 20:43:01 +0530
Message-ID: <20231005151302.1290363-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005151302.1290363-1-vigneshr@ti.com>
References: <20231005151302.1290363-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"simple-mfd" as standalone compatible is frowned upon, so model DMSS
(Data Movement Subsystem) node as simple-bus as there is really no need
for these nodes to be MFD.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 2 +-
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index ac760d9b831d..e5c64c86d1d5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -82,7 +82,7 @@ audio_refclk1: clock-controller@82e4 {
 
 	dmss: bus@48000000 {
 		bootph-all;
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		dma-ranges;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index c24ff905437f..fcbfb1b5242b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -42,7 +42,7 @@ gic_its: msi-controller@1820000 {
 
 	dmss: bus@48000000 {
 		bootph-all;
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		dma-ranges;
diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 2e50030d09ad..0be642bc1b86 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -99,7 +99,7 @@ gic_its: msi-controller@1820000 {
 
 	dmss: bus@48000000 {
 		bootph-all;
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		dma-ranges;
-- 
2.42.0

