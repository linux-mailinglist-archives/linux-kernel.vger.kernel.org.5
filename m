Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3180766A57
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjG1KZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbjG1KZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:25:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85883C3C;
        Fri, 28 Jul 2023 03:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690539884; x=1722075884;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/3sXIUPjzYrz/PmPsWKLYQve9I+U2VFy5X/CCNE/2wE=;
  b=EWo0AN8hTBRtrOX/Wv5jT3XxXqWonLtQlYMSzaambbqVTfvW6v9YmrkY
   idZ2coaFO2LtDEmCwbO7QSlGFcAr/A7tqQXUzZPtylpBxZ8aj6C3yEDmE
   XI6XJaMjP85c6/a1YpO0JAEtOdEIm4MIaAAix8GUdg7v9hepDEAgGbQjh
   XiYpSjrI2QhLqVZqpSDn8T9jj+QS0/P5LWQnmoubrn8HW2sX8AfrnlfSJ
   7cZ2svyFGhf4jBMY3AEmWSWsAPTeSfAs21u3Qo+rF+F2g+QpLn37872q5
   Ceqf23mWCGGIiR/X17YDQUx4CkZKQ3JRA+zCWzaCPGIdqjIIp4/p5WJxU
   w==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="226622800"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:24:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:24:21 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:24:17 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <sebastian.reichel@collabora.com>,
        <varshini.rajendran@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 08/50] dt-bindings: atmel-sysreg: add sam9x7
Date:   Fri, 28 Jul 2023 15:54:14 +0530
Message-ID: <20230728102414.265666-1-varshini.rajendran@microchip.com>
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

Add RAM controller & SFR DT bindings.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 67a66bf74895..1339298203c6 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -11,7 +11,8 @@ PIT Timer required properties:
   shared across all System Controller members.
 
 PIT64B Timer required properties:
-- compatible: Should be "microchip,sam9x60-pit64b"
+- compatible: Should be "microchip,sam9x60-pit64b" or
+			"microchip,sam9x7-pit64b", "microchip,sam9x60-pit64b"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt for PIT64B timer
 - clocks: Should contain the available clock sources for PIT64B timer.
@@ -31,7 +32,8 @@ RAMC SDRAM/DDR Controller required properties:
 			"atmel,at91sam9g45-ddramc",
 			"atmel,sama5d3-ddramc",
 			"microchip,sam9x60-ddramc",
-			"microchip,sama7g5-uddrc"
+			"microchip,sama7g5-uddrc",
+			"microchip,sam9x7-ddramc", "atmel,sama5d3-ddramc".
 - reg: Should contain registers location and length
 
 Examples:
@@ -63,6 +65,7 @@ required properties:
 	"atmel,<chip>-sfrbu", "syscon"
   <chip> can be "sama5d3", "sama5d4" or "sama5d2".
   It also can be "microchip,sam9x60-sfr", "syscon".
+  It also can be "microchip,sam9x7-sfr", "microchip,sam9x60-sfr", "syscon".
 - reg: Should contain registers location and length
 
 	sfr@f0038000 {
-- 
2.25.1

