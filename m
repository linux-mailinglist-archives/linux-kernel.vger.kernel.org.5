Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641E7766A30
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjG1KXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbjG1KXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:23:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD551FDA;
        Fri, 28 Jul 2023 03:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690539798; x=1722075798;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z8bPrfHdyCe3PLAOc0IGM9zltBj6HhwNodkZl406Bo8=;
  b=GuLxLrg+NkPep3zrf8WUlsFt7J7y+K7ybUxd5tYZbkQA/wf6LOFiGxmw
   xRDCb6P7z1tLpclRhE2m4NgQAbNTynIk0dzMqf8Tes3uG5wwT2zkB5aGc
   kL7p4iOnIaDqXuDUIhZSsscigAsTofkBaYY/6d63lXDm9LUxE6MdrBHmt
   0exzDSl812EaDEZsdwf2DeCtTXdxDv9wS9o+Pjiz9vICCtOOq1QTXXlfy
   EMPQx83x5+ym0JBp/H3sQl25p8QCJCS1gWblhDi3UMoOW02EMIvykB/x7
   uD63/YNxuOZrjPQSLz7qzI07ecGJZGgjCPPSCHnPLwCYYBbaBIIKZdig9
   g==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="225812856"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:23:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:23:17 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:23:12 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <varshini.rajendran@microchip.com>, <linux@roeck-us.net>,
        <sebastian.reichel@collabora.com>, <gregkh@linuxfoundation.org>,
        <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 01/50] dt-bindings: microchip: atmel,at91rm9200-tcb: add sam9x60, sam9x7 compatible
Date:   Fri, 28 Jul 2023 15:52:56 +0530
Message-ID: <20230728102256.265291-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sam9x60, sam9x7 compatible string support in the schema file.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
index a46411149571..912aea5abcf0 100644
--- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
+++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
@@ -15,13 +15,20 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - atmel,at91rm9200-tcb
-          - atmel,at91sam9x5-tcb
-          - atmel,sama5d2-tcb
-      - const: simple-mfd
-      - const: syscon
+    oneOf:
+      - items:
+          - enum:
+              - atmel,at91rm9200-tcb
+              - atmel,at91sam9x5-tcb
+              - atmel,sama5d2-tcb
+              - microchip,sam9x60-tcb
+          - const: simple-mfd
+          - const: syscon
+      - items:
+          - const: microchip,sam9x7-tcb
+          - const: atmel,sama5d2-tcb
+          - const: simple-mfd
+          - const: syscon
 
   reg:
     maxItems: 1
-- 
2.25.1

