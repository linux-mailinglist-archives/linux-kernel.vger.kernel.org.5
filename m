Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F32F766AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjG1KaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjG1K3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:29:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D731B4487;
        Fri, 28 Jul 2023 03:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540108; x=1722076108;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GSweIkrUGUAD4SStALMucylJ/QGEPeV03wfRlGauzT8=;
  b=XaOnKjM8AFWvNzIaK0F4abjmCytTN9mZZF0bKEG7bbGLPphFg6Zf04wK
   fAsIX/lR/Afs6WcTZN/b9AqOaWU62wroTeJLb7UQUY832byxYu61vY8Dw
   cUqSzXFg1wguD03CQk2HsoK7wZmOOnfyYJlaA3fjmycszPQtYxL5ZYgi7
   c0Q2ttitzAirMIA1k4xoMPuYtSsJxoVjhkzYgo2c59XbOMOFNL+24h9L/
   Oj1RIszLY+4EvP/HMB6J7YlJ+Y+11DZR5wtAtrKrfqvx3ZYNC5sucfXA1
   WsjWjFLwDbT0BnyBEo+99uKTQlDkF6upz888AtSRSv3q34iMfVrLr8cz7
   w==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="238401613"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:28:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:28:27 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:28:22 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <tudor.ambarus@linaro.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 30/50] spi: dt-bindings: atmel,at91rm9200-spi: remove 9x60 compatible from list
Date:   Fri, 28 Jul 2023 15:58:19 +0530
Message-ID: <20230728102819.266809-1-varshini.rajendran@microchip.com>
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

Remove microchip,sam9x60-spi compatible from the list as the fallback is
really atmel,at91rm9200-spi.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
index 58367587bfbc..32e7c14033c2 100644
--- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
@@ -22,7 +22,6 @@ properties:
           - const: atmel,at91rm9200-spi
       - items:
           - const: microchip,sam9x7-spi
-          - const: microchip,sam9x60-spi
           - const: atmel,at91rm9200-spi
 
   reg:
-- 
2.25.1

