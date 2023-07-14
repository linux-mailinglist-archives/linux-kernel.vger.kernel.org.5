Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE35753635
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjGNJOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbjGNJOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:14:00 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E514270B;
        Fri, 14 Jul 2023 02:13:59 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36E9DbiU084105;
        Fri, 14 Jul 2023 04:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689326017;
        bh=suCPQPrzzGFfP4KenDy/T5byFv935u0r7FkdI3FxBb8=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=yDsraB1R72M5YVE5a/ocP3xlY06PBTiKS4HLZ8jGe4AA6yZWQ4hiHoGJAtQTuwjgF
         qL6J2cMRa9zfWHMyO1cU/M4bkyAWNVwH7zyD8/3j13ezyenHjT4w8KeNzUULNufPo4
         2BRjjrB0RGFNpr5nAh3wB0QhOddyRxdDMYrX6ODE=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36E9DbRC003874
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Jul 2023 04:13:37 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jul 2023 04:13:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jul 2023 04:13:37 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36E9Daxl098589;
        Fri, 14 Jul 2023 04:13:37 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Date:   Fri, 14 Jul 2023 14:42:41 +0530
Subject: [PATCH v5 1/2] dt-bindings: crypto: ti,sa2ul: make power-domains
 conditional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230614-sa3ul-v5-1-29dd2366fba3@ti.com>
References: <20230614-sa3ul-v5-0-29dd2366fba3@ti.com>
In-Reply-To: <20230614-sa3ul-v5-0-29dd2366fba3@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        "Tero Kristo" <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Tero Kristo" <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-crypto@vger.kernel.org>,
        Kamlesh Gurudasani <kamlesh@ti.com>,
        "Conor Dooley" <conor.dooley@microchip.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326014; l=1420;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=9fFLiJzU0nj0ThkjDNPisO+/050gLX2S2toEaa+3810=;
 b=3944vR9N2XayRctH8o/k6T8iHxdc9wOyUzVty1QefPpam/O4YvGyJuyj0AbKeiRtviCgLMhCs
 gfMmMeXBhe7A5DnlKVh960ZhcxSaBiP5EX68pveLBOC84hKudbTI26N
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
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

Devices specific to compatible ti,am62-sa3ul don't have control over
power of SA3UL from main domain.

"power-domains" property in crypto node tries to access
the SA3UL power, for which it gets NACK and hence, driver doesn't
probe properly for those particular devices.

Make "power-domains" property as false for devices with
compatible ti,am62-sa3ul.

Fixes: 2ce9a7299bf6 ("dt-bindings: crypto: Add TI SA2UL crypto accelerator documentation")

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
index 77ec8bc70bf7..f0ef7685550a 100644
--- a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
+++ b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
@@ -66,10 +66,22 @@ patternProperties:
 required:
   - compatible
   - reg
-  - power-domains
   - dmas
   - dma-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,am62-sa3ul
+    then:
+      properties:
+        power-domains: false
+    else:
+      required:
+        - power-domains
+
 additionalProperties: false
 
 examples:

-- 
2.34.1

