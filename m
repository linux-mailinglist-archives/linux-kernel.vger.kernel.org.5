Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1D07766D3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjHISAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHISAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:00:03 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63F31FC2;
        Wed,  9 Aug 2023 11:00:01 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379Hxtl0048735;
        Wed, 9 Aug 2023 12:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691603995;
        bh=dcWUHHkD1z6r14RpPtMdnBSuoZsZMHfcZiRvND4wEIQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mNrPeL7T1cw2Uiz5yq7z0M9Rip2EIXCkNDjkX0KJUJftpKSuOyhcHfneb937XFecq
         kHPMtP8vOUixcq/afiSbWdl3B8xIXyttdh7drtpHEC8sOeUQFJ2rFbM5WyKF2eW/zv
         CF4CW6z6FW1Xrq7aVrGVHAkNeaMjBjCXRph0m//c=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379HxtUE094146
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 12:59:55 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 12:59:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 12:59:55 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Hxm6H098813;
        Wed, 9 Aug 2023 12:59:52 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] dt-bindings: soc: ti: k3-ringacc: Describe cfg reg region
Date:   Wed, 9 Aug 2023 23:29:31 +0530
Message-ID: <20230809175932.2553156-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809175932.2553156-1-vigneshr@ti.com>
References: <20230809175932.2553156-1-vigneshr@ti.com>
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

RINGACC module on K3 SoCs have CFG register region which is usually
configured by a Device Management firmware. But certain entities such as
bootloader (like U-Boot) may have to access them directly. Describe this
region in the binding documentation for completeness of module
description.

Keep the binding compatible with existing DTS files by requiring first
four regions to be present at least.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
index 22cf9002fee7..a08959c6e072 100644
--- a/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
@@ -34,18 +34,22 @@ properties:
       - const: ti,am654-navss-ringacc
 
   reg:
+    minItems: 4
     items:
       - description: real time registers regions
       - description: fifos registers regions
       - description: proxy gcfg registers regions
       - description: proxy target registers regions
+      - description: configuration registers region
 
   reg-names:
+    minItems: 4
     items:
       - const: rt
       - const: fifos
       - const: proxy_gcfg
       - const: proxy_target
+      - const: cfg
 
   msi-parent: true
 
@@ -80,8 +84,9 @@ examples:
             reg = <0x0 0x3c000000 0x0 0x400000>,
                   <0x0 0x38000000 0x0 0x400000>,
                   <0x0 0x31120000 0x0 0x100>,
-                  <0x0 0x33000000 0x0 0x40000>;
-            reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+                  <0x0 0x33000000 0x0 0x40000>,
+                  <0x0 0x31080000 0x0 0x40000>;
+                  reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
             ti,num-rings = <818>;
             ti,sci-rm-range-gp-rings = <0x2>; /* GP ring range */
             ti,sci = <&dmsc>;
-- 
2.41.0

