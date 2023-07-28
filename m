Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071B6766A48
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjG1KYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbjG1KYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:24:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462F249CA;
        Fri, 28 Jul 2023 03:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690539857; x=1722075857;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ch6RgJfqhfAwYMvEoDOuJaJigXGoS/6/cRArcIZcR10=;
  b=pKbMnWErYPvcS9Vc8KUS5XULtnFCaZM62FBdPE2Es0x89CynqxdoNv/U
   0KrqgsmypNtgu8Uct/oneXb/+ZUswAFL3laCWjCh0U8VRsK+2LbkQLtZM
   7xQVO70h+SH+sr5X63K7aQSAKHCGdGtLMBM6I6pSBPi08/ldzQCIybHm6
   kKyGpsnOoCgeRW3b72X35grlTaNJqneajuCVZq8NyhTHi8cRHeezE4pQk
   4VtMK9beFfH67Hgm7fF5u5/RZmcq9LJlkJIHD089H8tRnC99xBSbB4NpC
   ZJqtdtUrO3QlWhRMOZAddPQH/I6JBmyBTWfmnuzEzNnE/md4oWTHE04U4
   A==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="226622739"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:24:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:23:49 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:23:44 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 04/50] dt-bindings: clk: at91: add sam9x7
Date:   Fri, 28 Jul 2023 15:53:37 +0530
Message-ID: <20230728102337.265471-1-varshini.rajendran@microchip.com>
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

Add bindings for SAM9X7's slow clock controller.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 .../devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
index 7be29877e6d2..94b83047c3cf 100644
--- a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
+++ b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
@@ -20,6 +20,9 @@ properties:
       - items:
           - const: microchip,sama7g5-sckc
           - const: microchip,sam9x60-sckc
+      - items:
+          - const: microchip,sam9x7-sckc
+          - const: microchip,sam9x60-sckc
 
   reg:
     maxItems: 1
-- 
2.25.1

