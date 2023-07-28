Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C16766A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjG1K3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbjG1K2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:28:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B40420C;
        Fri, 28 Jul 2023 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540081; x=1722076081;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J56scc4lwCw64Hq+Y3iwSMBkAqaw8UYobN/SUdebGoM=;
  b=graE0EyjMkCzCLWPAb73xwFmqzqzj+4yCRK46Mce2/X6nwXJAukeynpz
   gRcmwpcEAlBVhKCKBct5TumVbV8S+2pQ2ll7fzsmtEUZp/RBHtio9VDd2
   fQjkApDW3Wb0snZHCFrQpPLbmxVrlUejcXDBdeucxt9OObhGvaDoJKkNb
   PVtTXEFWThe7gHAMjRLoF9ZrzMT2X48m9aldaPTNqaOkvaMsvabbydgEP
   n9vnTbuM4vJcnDG9+peY61l0nKmSjAtOu2bRFzvx/yjITLq74qIeDyNgG
   CdgOVcmNPYrZFny0w88XY9uiWxv96aD1Tx7xKkDbl1OX8zqCtaWnFBqWw
   A==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="238401601"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:28:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:28:00 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:27:56 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 27/50] dt-bindings: usb: atmel: add sam9x7
Date:   Fri, 28 Jul 2023 15:57:53 +0530
Message-ID: <20230728102753.266660-1-varshini.rajendran@microchip.com>
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

Add sam9x7 bindings.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 Documentation/devicetree/bindings/usb/atmel-usb.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
index 12183ef47ee4..82bd0dbc2a48 100644
--- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
+++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
@@ -3,8 +3,9 @@ Atmel SOC USB controllers
 OHCI
 
 Required properties:
- - compatible: Should be "atmel,at91rm9200-ohci" for USB controllers
-   used in host mode.
+ - compatible: Should be "atmel,at91rm9200-ohci" or
+   "microchip,sam9x7-ohci", "atmel,at91rm9200-ohci"
+   for USB controllers used in host mode.
  - reg: Address and length of the register set for the device
  - interrupts: Should contain ohci interrupt
  - clocks: Should reference the peripheral, host and system clocks
@@ -30,8 +31,9 @@ usb0: ohci@500000 {
 EHCI
 
 Required properties:
- - compatible: Should be "atmel,at91sam9g45-ehci" for USB controllers
-   used in host mode.
+ - compatible: Should be "atmel,at91sam9g45-ehci" or
+   "microchip,sam9x7-ehci", "atmel,at91sam9g45-ehci"
+   for USB controllers used in host mode.
  - reg: Address and length of the register set for the device
  - interrupts: Should contain ehci interrupt
  - clocks: Should reference the peripheral and the UTMI clocks
@@ -87,6 +89,7 @@ Required properties:
 	       "atmel,at91sam9g45-udc"
 	       "atmel,sama5d3-udc"
 	       "microchip,sam9x60-udc"
+	       "microchip,sam9x7-udc", "microchip,sam9x60-udc"
 	       "microchip,lan9662-udc"
 	       For "microchip,lan9662-udc" the fallback "atmel,sama5d3-udc"
 	       is required.
-- 
2.25.1

