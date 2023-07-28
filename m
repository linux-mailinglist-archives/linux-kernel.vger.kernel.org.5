Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67BD766AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjG1Ke5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbjG1Kec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:34:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B14744B2;
        Fri, 28 Jul 2023 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540332; x=1722076332;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1g44sE6+Od6SMEJPDEyOlmg+p5HZYIyXIwcF8EJ/S8U=;
  b=IViEiNPR2mh02KvIWH4JtQRBR2GhzBhV4K1akLKkAq/3K7xyA0e/xu5W
   HrnrfVQuq/g05yn+UTOCwUN5D4DvyPbMcAH7DHXcvVtPNYmY6W0G8GwJ6
   zfx6BQYuOAijmU58uUehNDRaB0r9pPg79LH/WoE/0TfMUCINqTsECicdI
   3DrXfX9VABw3EHueQKuBF4nrf7Ki3dHilb2egHAR4dnFEmM8Yy4pJxvzT
   +kg64qohaOQLuCJGJy/LF33QtydhEPPs7xJx+BnhsJU/YCyyHKgQXcksB
   q7ukHSK1zccoyRVqfY+M/UOA+ctkZI6bu+v5UhZKDN6jNi3hNmj2faFRk
   g==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="238401945"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:31:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:31:13 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:31:08 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <jerry.ray@microchip.com>, <durai.manickamkr@microchip.com>,
        <varshini.rajendran@microchip.com>, <andrew@lunn.ch>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 49/50] dt-bindings: arm: add sam9x75 curiosity board
Date:   Fri, 28 Jul 2023 16:01:06 +0530
Message-ID: <20230728103106.267793-1-varshini.rajendran@microchip.com>
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

Add documentation for SAM9X75 Curiosity board.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index dfb8fd089197..15b11feae46a 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -99,6 +99,12 @@ properties:
           - const: microchip,sam9x60
           - const: atmel,at91sam9
 
+      - description: Microchip SAM9X7 Evaluation Boards
+        items:
+          - const: microchip,sam9x75-curiosity
+          - const: microchip,sam9x7
+          - const: atmel,at91sam9
+
       - description: Nattis v2 board with Natte v2 power board
         items:
           - const: axentia,nattis-2
-- 
2.25.1

