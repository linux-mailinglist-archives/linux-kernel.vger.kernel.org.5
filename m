Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16E9766A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjG1K2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjG1K1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:27:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289A64C19;
        Fri, 28 Jul 2023 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540011; x=1722076011;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=snGvRxqDl4Xo+zB7DnmX/dsdA0/0jKTp/eDmSa1ira8=;
  b=ywZ6G8LEa168vv1mOoHfOvW3RqK9AdJM1MdY/8s21yGvbzBb1kh0lonI
   MkiaT35+Oz0amXW9YzlO5PyvXTXdjvmP+Aj5vpfs7BcA1mKeZwawa+qnY
   TXEcLxwcCO2iUmE+vxXA7VTcfB+SA1OwbpqwCJxYbH5o1AGdEmXb4qL1K
   oXl6cLQrZljlnQc+KK3QiLLURSiJiHeZgWyoFpKqJtvnuEkzDxgiKWSTe
   S9plJ14Nl8ixaJbiRJZTWQwukrRjVtPul6Vqx0aPVr+B8oaKkk3OSfL5P
   mL4bJn/otD/PSbjTFyephetiqjvfpurLcwqNhwlO5uPI93F2sDB5+0c9J
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="238401022"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:25:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:25:49 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:25:45 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 16/50] dt-bindings: atmel-matrix: add microchip,sam9x7-matrix
Date:   Fri, 28 Jul 2023 15:55:39 +0530
Message-ID: <20230728102539.266085-1-varshini.rajendran@microchip.com>
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

Add microchip,sam9x7-matrix to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 Documentation/devicetree/bindings/mfd/atmel-matrix.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-matrix.txt b/Documentation/devicetree/bindings/mfd/atmel-matrix.txt
index 89d05c64fb01..6e5f83614e83 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-matrix.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-matrix.txt
@@ -14,6 +14,7 @@ Required properties:
 			"atmel,at91sam9x5-matrix", "syscon"
 			"atmel,sama5d3-matrix", "syscon"
 			"microchip,sam9x60-matrix", "syscon"
+			"microchip,sam9x7-matrix", "atmel,at91sam9x5-matrix", "syscon"
 - reg:			Contains offset/length value of the Bus Matrix
 			memory region.
 
-- 
2.25.1

