Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED7F76B2E0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjHALPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjHALPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:15:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E777C2135;
        Tue,  1 Aug 2023 04:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690888347; x=1722424347;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Uc2/TaIjjT+W+Km3r2kbpsUywlkWiagtSXjUBtzYV8Y=;
  b=Qpe+avq9fZ9/CKXRZrj/DepFmNpfqq/bqD4wlvfLS2nAfXooByOkuV82
   ycjL4ti8AkmhZn5h0x086XxC2LYkme1KjtukSLhyMn/R9+iRCtNDn2atK
   iwQY1+b4i3l8ipx6hO28sxxSIZ8O51yMaq5UwENKlQyPUfaaowCZMDl6m
   S+Qc0GUgdjYTwSrsAEYi+3MO1f+VJUnDSPahyg6lf66ubQmPOMlWxNHx/
   i+VzJ95s1usmhHMxlYhe7f5SS/IqAL0Eu5NXtEeGR9BwejRoAkpNzijIY
   //Yy9gNo1y/QIj50bJV+fHuLXf0EjeADO5LvAnLc0sOmyzGM19c+0ye39
   g==;
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="227318088"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Aug 2023 04:12:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 1 Aug 2023 04:12:23 -0700
Received: from virtualbox.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 1 Aug 2023 04:12:20 -0700
From:   Mihai Sain <mihai.sain@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <andre.przywara@arm.com>, <andrei.simion@microchip.com>,
        <jerry.ray@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <cristian.birsan@microchip.com>,
        Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 1/2] dt-bindings: ARM: at91: Document Microchip SAMA5D29 Curiosity
Date:   Tue, 1 Aug 2023 14:11:50 +0300
Message-ID: <20230801111151.6546-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Simion <andrei.simion@microchip.com>

Document device tree binding of SAMA5D29 Curiosity, from Microchip.

Reviewed-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index dfb8fd089197..89d75fbb1de4 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -79,6 +79,13 @@ properties:
           - const: atmel,sama5d2
           - const: atmel,sama5
 
+      - description: Microchip SAMA5D29 Curiosity
+        items:
+          - const: microchip,sama5d29-curiosity
+          - const: atmel,sama5d29
+          - const: atmel,sama5d2
+          - const: atmel,sama5
+
       - items:
           - const: atmel,sama5d27
           - const: atmel,sama5d2
-- 
2.41.0

