Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD48766A93
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbjG1K3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjG1K3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:29:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3072949F3;
        Fri, 28 Jul 2023 03:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540086; x=1722076086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rJtzpp4B8syipLQfPojstoT7Q44bLhfc2vm+myC71tg=;
  b=SrLhSnKWJmlFGOgkEFMnGeHLFtejgn9Z4IpCnDZP+hFoRsZ1UimtLbXi
   ceqSc1bibEhGeyPflIGq70ysTCvYcgR2TyvQRuFwH3iQ1fpcAzWkHdZBz
   JgGfuk1ybP1oR6SBzJeLEeYAZQfjGWmov1/jGTj+xC1WPuSss6Yny7aX1
   LEFyYtCzd6urYkTNCipfOptgUcw9s1kV1DMu+PfxQd2Y1Y58ClvhZrPWE
   NRrS7kst3Mo324BLPtL08jRTOH/dfsZwcDQvZPsmVNZ0/rKENELTRUYTA
   NBGstKzF9wKvjwVfNj8kxsYcKU5wpMfyIK6no+kdv6JaUK3pXTw38ND87
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="163712691"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:27:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:27:17 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:27:13 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <claudiu.beznea@microchip.com>, <linux-rtc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 23/50] dt-bindings: rtc: at91rm9200: add sam9x7 compatible
Date:   Fri, 28 Jul 2023 15:57:10 +0530
Message-ID: <20230728102710.266457-1-varshini.rajendran@microchip.com>
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

Add compatible for SAM9X7 RTC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 .../bindings/rtc/atmel,at91rm9200-rtc.yaml     | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
index 4d2bef15fb7a..c8bb2eef442d 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
@@ -14,13 +14,17 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - atmel,at91rm9200-rtc
-      - atmel,at91sam9x5-rtc
-      - atmel,sama5d4-rtc
-      - atmel,sama5d2-rtc
-      - microchip,sam9x60-rtc
-      - microchip,sama7g5-rtc
+    oneOf:
+      - enum:
+          - atmel,at91rm9200-rtc
+          - atmel,at91sam9x5-rtc
+          - atmel,sama5d4-rtc
+          - atmel,sama5d2-rtc
+          - microchip,sam9x60-rtc
+          - microchip,sama7g5-rtc
+      - items:
+          - const: microchip,sam9x7-rtc
+          - const: microchip,sam9x60-rtc
 
   reg:
     maxItems: 1
-- 
2.25.1

