Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BF378DEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244462AbjH3TPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242209AbjH3H1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:27:23 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99EDCC2;
        Wed, 30 Aug 2023 00:27:20 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37U7RFuf070622;
        Wed, 30 Aug 2023 02:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693380435;
        bh=PMgieLRCTCmON8suqmgdvIAH9uZY3L4itoLzEo06s+o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HmoNKePZmdccTTOWob4a2buGKxsYpdqgIpMTRHUNJrA0gcr8TA9M9uupqtSB2EzYx
         Oh3yDmCQxt6tNpIDIvq/ivThLpyokASl/GCAcAl09tT9PuPV1rw73YF+HEA8ueK6Td
         w3QW+OthddfXqmuXslIdQFkywtYePgHdTeL1BH6M=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37U7RFlp103932
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Aug 2023 02:27:15 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Aug 2023 02:27:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Aug 2023 02:27:14 -0500
Received: from localhost.localdomain (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37U7QuLL125116;
        Wed, 30 Aug 2023 02:27:11 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kristo@kernel.org>
CC:     <j-keerthy@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] arm64: dts: ti: k3-j721s2-main: Add main domain watchdog entries
Date:   Wed, 30 Aug 2023 12:56:21 +0530
Message-ID: <20230830072622.19539-5-j-keerthy@ti.com>
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

Add DT entries for main domain watchdog instances.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 87841bcc509d..33276d31faa1 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -1513,4 +1513,22 @@
 		reg = <0x0 0x700000 0x0 0x1000>;
 		ti,esm-pins = <344>, <345>;
 	};
+
+	watchdog0: watchdog@2200000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x0 0x2200000 0x0 0x100>;
+		clocks = <&k3_clks 286 1>;
+		power-domains = <&k3_pds 286 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 286 1>;
+		assigned-clock-parents = <&k3_clks 286 5>;
+	};
+
+	watchdog1: watchdog@2210000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x0 0x2210000 0x0 0x100>;
+		clocks = <&k3_clks 287 1>;
+		power-domains = <&k3_pds 287 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 287 1>;
+		assigned-clock-parents = <&k3_clks 287 5>;
+	};
 };
-- 
2.17.1

