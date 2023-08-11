Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4196177973C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbjHKSpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbjHKSpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:45:02 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD51330E8;
        Fri, 11 Aug 2023 11:45:01 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BIijA3119117;
        Fri, 11 Aug 2023 13:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691779485;
        bh=oWKm8EWHt81q+nl5Qjq5h6GkmdfCMeUaEqcttXLUbgI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VyBYH3Nb7qo4yPP/oZR0YLazui9jf4SPwvTWQr9uR3/elM9l0bnKFIhH/EYShP2b6
         jiw8gxXT8lq4Qww8890lxPjSzfM9HKICGiWzGUmfTYSDIqy/FUfYwsrF+sGBuCg+QM
         G4ENQnAgJrOtJOy3iDEVKG4zyQXqYIhoyrg8gsfI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BIijQ1001400
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 13:44:45 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 13:44:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 13:44:44 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BIicWr018168;
        Fri, 11 Aug 2023 13:44:42 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <afd@ti.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: ti: Add bindings for AM62P5 SoCs
Date:   Sat, 12 Aug 2023 00:14:30 +0530
Message-ID: <20230811184432.732215-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811184432.732215-1-vigneshr@ti.com>
References: <20230811184432.732215-1-vigneshr@ti.com>
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

From: Bryan Brattlof <bb@ti.com>

Add bindings for TI's AM62P5 family of devices.

Signed-off-by: Bryan Brattlof <bb@ti.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 5ca6af492507..03d2a0d79fb0 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -25,6 +25,12 @@ properties:
               - ti,am62a7-sk
           - const: ti,am62a7
 
+      - description: K3 AM62P5 SoC and Boards
+        items:
+          - enum:
+              - ti,am62p5-sk
+          - const: ti,am62p5
+
       - description: K3 AM625 SoC PHYTEC phyBOARD-Lyra
         items:
           - const: phytec,am625-phyboard-lyra-rdk
-- 
2.41.0

