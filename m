Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD6775FAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjGXPjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjGXPja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:39:30 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AE110E5;
        Mon, 24 Jul 2023 08:39:24 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36OFdDXc129939;
        Mon, 24 Jul 2023 10:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690213153;
        bh=m0JPQIMlSORdO/+H9YCrDGAmz9vrQDjNMA/fE+Y4ym8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=B1HBMc8mnZ204Jr1Yon5PtZxaWKI1wq/gRFTRlLXuq2+Z5Dn9sCoAwu5iCLqYfrLe
         9E5lChdgGsmqBzhSrinH+jKmjzFofTqPy07ZWCUw5+gi+aISKgyFF1w+JdS6o07y8l
         ep3pN8OWvXHPrcImAd+e2AcXr6PZbgNKGtBudywA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36OFdDn2081394
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jul 2023 10:39:13 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jul 2023 10:39:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jul 2023 10:39:13 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36OFdDqt001763;
        Mon, 24 Jul 2023 10:39:13 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/5] arm: dts: ti: omap: omap36xx: Rename opp_supply nodename
Date:   Mon, 24 Jul 2023 10:39:07 -0500
Message-ID: <20230724153911.1376830-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230724153911.1376830-1-nm@ti.com>
References: <20230724153911.1376830-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use opp-supply as the proper node name.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Should probably go via Tony's tree.

 arch/arm/boot/dts/ti/omap/omap36xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
index fff9c3d34193..50e640a32b5c 100644
--- a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
@@ -71,7 +71,7 @@ opp1g-1000000000 {
 		};
 	};
 
-	opp_supply_mpu_iva: opp_supply {
+	opp_supply_mpu_iva: opp-supply {
 		compatible = "ti,omap-opp-supply";
 		ti,absolute-max-voltage-uv = <1375000>;
 	};
-- 
2.40.0

