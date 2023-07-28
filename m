Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33426766A82
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjG1K2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236121AbjG1K22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:28:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5774EC4;
        Fri, 28 Jul 2023 03:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540058; x=1722076058;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CtUQ7Ed42c3S8j1DbF/KeQU1RlwOzIIywOKkg6O+2sw=;
  b=pk4G6I0rXsAjwuY5Qfbal+0nFse6fSft1YMp/b9KEFRIGMDdTsfHpyl2
   NFbpA1FWcdFqzZkNl0qVHDLOAAaKXbYlhDTBBRJ1r1VdShez/4WoVuQf5
   r8MV2ef+LhbDTBUHS+ADc0P+9R+eM9/DjfcU7u30OVZ/V2w0h9IqE0Dja
   OQB6E59WSOxZ5cmp9MKr86yV5+OEn7ky2f/Vhot2fH5sDLeGWBJSo/byx
   gJ61TQVbBIVmr5tuwJOJ5Ybz5ZEqpsB4WOY0Y1Ss+3H3G+3vYRagP2p+J
   ESp5zN6vLNEXynqO/eCQXzonKGut7+GfkL/5KVwNjWAXjdjAZyT5xqk1C
   A==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="238401538"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:27:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:27:29 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:27:25 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <claudiu.beznea@microchip.com>, <linux-rtc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 24/50] dt-bindings: rtt: at91rm9260: add sam9x7 compatible
Date:   Fri, 28 Jul 2023 15:57:18 +0530
Message-ID: <20230728102718.266507-1-varshini.rajendran@microchip.com>
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

Add compatible for SAM9X7 RTT.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 .../devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
index b80b85c394ac..8426810518e1 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
@@ -21,6 +21,9 @@ properties:
       - items:
           - const: microchip,sam9x60-rtt
           - const: atmel,at91sam9260-rtt
+      - items:
+          - const: microchip,sam9x7-rtt
+          - const: atmel,at91sam9260-rtt
       - items:
           - const: microchip,sama7g5-rtt
           - const: microchip,sam9x60-rtt
-- 
2.25.1

