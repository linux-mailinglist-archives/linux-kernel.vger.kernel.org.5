Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3DE78DD94
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245233AbjH3SwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242210AbjH3H1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:27:23 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128C61BB;
        Wed, 30 Aug 2023 00:27:21 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37U7R9uA085018;
        Wed, 30 Aug 2023 02:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693380429;
        bh=niKbTQJGclEsvx1DPokUG6j47jvcqy01MpWXxzZcfrQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Ws7uDHDqVtYtKNFEkIaY24gdgWfm8NDx1VAQzsWpCgaZMtlBuO/smuTn/DQcAxsu4
         /1ga7gd6QCRRODbwuWa7B2Qb+ZwGFbPXmOpsfPCKQ6AtXUZ7eKhr4XqYzQg2xxHrD/
         G5KiltMGSRvtWYlXeW7QBWkIAd2GKcjkslCSTnUE=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37U7R9Gn103873
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Aug 2023 02:27:09 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Aug 2023 02:27:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Aug 2023 02:27:07 -0500
Received: from localhost.localdomain (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37U7QuLJ125116;
        Wed, 30 Aug 2023 02:27:04 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kristo@kernel.org>
CC:     <j-keerthy@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] arm64: dts: ti: k3-j784s4: Add ESM instances
Date:   Wed, 30 Aug 2023 12:56:19 +0530
Message-ID: <20230830072622.19539-3-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230830072622.19539-1-j-keerthy@ti.com>
References: <20230830072622.19539-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds the ESM instances for j784s4. It has 3 instances.
One in the main domain and two in the mcu-wakeup domian.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       |  6 ++++++
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 2ea0adae6832..34ceb50b2051 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -1537,4 +1537,10 @@
 		resets = <&k3_reset 40 1>;
 		firmware-name = "j784s4-c71_3-fw";
 	};
+
+	main_esm: esm@700000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x0 0x700000 0x0 0x1000>;
+		ti,esm-pins = <688>, <689>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 657fb1d72512..8492b7e2c0ba 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -690,4 +690,16 @@
 			status = "disabled";
 		};
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

