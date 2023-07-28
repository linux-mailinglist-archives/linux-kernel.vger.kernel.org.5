Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1530F766A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjG1KaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbjG1K3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:29:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3733549FC;
        Fri, 28 Jul 2023 03:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540106; x=1722076106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZK4suKsWSD/apdAFux8fihXNiLNnU7yVoM0dU8atgjc=;
  b=bqAzc5Z8YiE5B0gfL3OyQUAj+ObD5UmjJajYdh6BAJOgLrOsZR8fy4E4
   DUsZ9eABJMnYo7Fw1xYcHuTZENNbUSzzJCn6rNCKZUBXFFwurWGevI3w5
   2obH6QAAkAxMSvKc81MlLVM1I5qSP8yCeLBwyRTZ1SVzEpV/q9V8xarYu
   0PBZmHVR9cEt1UjcczwRcUoDqyPqvk1fU6zzHTrG1L6UzOdSwJTKnE6ou
   PNtPjTbS9UqDgG2VJVeM4lWC4G8BZ1N2stjpRsirHF+TXyaImwbBKqWD6
   I3kPgQi0JKR9p7JMrSel1pN4boOuIaqC6KHd0dSgGwaK5iDQAYwHIcMrc
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="226623304"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:28:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:28:09 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:28:05 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <eugen.hristev@collabora.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 28/50] dt-bindings: watchdog: sama5d4-wdt: add compatible for sam9x7-wdt
Date:   Fri, 28 Jul 2023 15:58:01 +0530
Message-ID: <20230728102801.266709-1-varshini.rajendran@microchip.com>
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

Add compatible microchip,sam9x7-wdt to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 .../bindings/watchdog/atmel,sama5d4-wdt.yaml      | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
index 816f85ee2c77..ce3d046e7244 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
@@ -14,10 +14,17 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - atmel,sama5d4-wdt
-      - microchip,sam9x60-wdt
-      - microchip,sama7g5-wdt
+    oneOf:
+      - items:
+          - enum:
+              - atmel,sama5d4-wdt
+              - microchip,sam9x60-wdt
+              - microchip,sama7g5-wdt
+      - items:
+          - enum:
+              - microchip,sam9x7-wdt
+          - enum:
+              - microchip,sam9x60-wdt
 
   reg:
     maxItems: 1
-- 
2.25.1

