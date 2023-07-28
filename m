Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4825766A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjG1K2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbjG1K2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:28:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C5C46B4;
        Fri, 28 Jul 2023 03:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540051; x=1722076051;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=igHDeF92LiyJV6CYdDteCC2bRTjg8rQRg4+bhnAd1mA=;
  b=GnelcdFdc5T07GjNr8NyiWx73LQld8w1hnu8JnmttAffVGbCP7a1kQGF
   Y9CwV3h3swFZBgviZ72twhGZuG9DapIWVDFrNycBgebnQNpo3Y2mavS+O
   UhpXHpC0VImANihPVZyxhKb/Tu9y1Kd1BwGMpG3z2+ybW1au8kaQbzoP5
   MrhZ/6TiG1Z03qsTqXr7eoRIR+pohwyvPnT81zX8lwuhl+ZuzTGFoXb7n
   x6ZX55iW0NGr8OCzOUTBByPFXzpaqrduwYgdvlWn7Oiv3FeXDgSI0xODF
   uvgXXK/jF1ukxWTFwFYsPdmFCq1Muq4Z7STPQtS2yvTZOW28lOl/cN7ee
   w==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="226623140"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:26:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:26:45 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:26:39 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <tudor.ambarus@linaro.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 20/50] dt-bindings: atmel-nand: add microchip,sam9x7-pmecc
Date:   Fri, 28 Jul 2023 15:56:36 +0530
Message-ID: <20230728102636.266309-1-varshini.rajendran@microchip.com>
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

Add microchip,sam9x7-pmecc to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 Documentation/devicetree/bindings/mtd/atmel-nand.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index 50645828ac20..4598930851d9 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -56,6 +56,7 @@ Required properties:
 	"atmel,sama5d4-pmecc"
 	"atmel,sama5d2-pmecc"
 	"microchip,sam9x60-pmecc"
+	"microchip,sam9x7-pmecc", "atmel,at91sam9g45-pmecc"
 - reg: should contain 2 register ranges. The first one is pointing to the PMECC
        block, and the second one to the PMECC_ERRLOC block.
 
-- 
2.25.1

