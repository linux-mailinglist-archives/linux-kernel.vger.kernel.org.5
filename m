Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EDB76096C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjGYFjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGYFjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:39:14 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312011BD3;
        Mon, 24 Jul 2023 22:39:08 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36P5d3Od049700;
        Tue, 25 Jul 2023 00:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690263543;
        bh=UMFtptzY6+rXg55b5S+EeQ1L1IsRBMWP719LxrE4Y1E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=di/5HYIZQpARDluJgZzFPsxVfpqd/5G6AYtryAGDuWUnLdiaWUG0ubpny0BJ+GwFN
         T9Dts2fzoRurLjO76TqzW//guYAxVhVhNzPGqJ9G2oPdCnv7Z0r9CIx8ScrMVnSgyW
         L3iP3IU+tThOxNUmjCNMJBijyOjQdRSn9g491b2A=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36P5d39E052867
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 00:39:03 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 00:39:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 00:39:03 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36P5cu76064880;
        Tue, 25 Jul 2023 00:39:00 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Udit Kumar <u-kumar1@ti.com>, Chai Wenle <Wenle.Chai@windriver.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j784s4-main: Add DT node for UFS
Date:   Tue, 25 Jul 2023 11:08:42 +0530
Message-ID: <20230725053843.1721028-2-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725053843.1721028-1-u-kumar1@ti.com>
References: <20230725053843.1721028-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds UFS support present in J784S4 SOC.

UFS is documentend in J784S4 TRM[1]
Section 12.3.7 'Universal Flash Storage (UFS) Interface'

[1] http://www.ti.com/lit/zip/spruj52

Cc: Chai Wenle <Wenle.Chai@windriver.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 11f163e5cadf..f1db1ca5d6b1 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -1370,6 +1370,30 @@ main_spi7: spi@2170000 {
 		status = "disabled";
 	};
 
+	ufs_wrapper: ufs-wrapper@4e80000 {
+		compatible = "ti,j721e-ufs";
+		reg = <0x0 0x4e80000 0x0 0x100>;
+		power-domains = <&k3_pds 387 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 387 3>;
+		assigned-clocks = <&k3_clks 387 3>;
+		assigned-clock-parents = <&k3_clks 387 6>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		status = "disabled";
+
+		ufs@4e84000 {
+			compatible = "cdns,ufshc-m31-16nm", "jedec,ufs-2.0";
+			reg = <0x0 0x4e84000 0x0 0x10000>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			freq-table-hz = <250000000 250000000>, <19200000 19200000>,
+					<19200000 19200000>;
+			clocks = <&k3_clks 387 1>, <&k3_clks 387 3>, <&k3_clks 387 3>;
+			clock-names = "core_clk", "phy_clk", "ref_clk";
+			dma-coherent;
+		};
+	};
+
 	main_r5fss0: r5fss@5c00000 {
 		compatible = "ti,j721s2-r5fss";
 		ti,cluster-mode = <1>;
-- 
2.34.1

