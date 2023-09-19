Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEED7A638F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjISMqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjISMqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:46:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957C919A;
        Tue, 19 Sep 2023 05:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695127584; x=1726663584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lOKXOWXpA0dFi3Me+J/143SlCxDleHXz5jbHcYgITZI=;
  b=BkjBRSWkIAq66xjeUfs9ukBZ6MJgyRXylySYqitMJfJ99WJhAj1WhIoA
   Eq4d+c9V1Bjyf54CB/QWqzLKBlyswL1TTplbHbnWrVA9nSKE6nuSyp+n/
   +1zaylOkRAQe/OxEZVApKfT+gJ1ykGNwBYsBpsqHsS8Qt92A7tytNhfKW
   /Jk7m5mAbNoRSqwb6QYeQaxfZxUO2e7b8XykVjB2nDqcnAbOLk5/qCwyV
   u2PD8QMcX+gcEwTyt1EqsXW/gbFDOBv27R33bP9dleN7to3G/U5Jg1QQg
   d8giVsk7+l9b9tT+DqlZ9QbZkD/w07zHIcA42wRDIPsdkgkFXcsjlKGTk
   A==;
X-CSE-ConnectionGUID: DgGj6kGSTqidKmkwxkBWsA==
X-CSE-MsgGUID: qrrs/xMHQ6aG8UTe6V4CuA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="5425155"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2023 05:46:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 19 Sep 2023 05:46:22 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 19 Sep 2023 05:46:19 -0700
From:   Mihai Sain <mihai.sain@microchip.com>
To:     <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <cristian.birsan@microchip.com>,
        <alexandre.belloni@bootlin.com>, <andre.przywara@arm.com>,
        <jerry.ray@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <andrei.simion@microchip.com>,
        Mihai Sain <mihai.sain@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: ARM: at91: Document Microchip SAMA5D29 Curiosity
Date:   Tue, 19 Sep 2023 15:46:04 +0300
Message-ID: <20230919124606.26898-2-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919124606.26898-1-mihai.sain@microchip.com>
References: <20230919124606.26898-1-mihai.sain@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Simion <andrei.simion@microchip.com>

Document device tree binding of SAMA5D29 Curiosity, from Microchip.

Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
Reviewed-by: Mihai Sain <mihai.sain@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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
2.42.0

