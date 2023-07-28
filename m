Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE8766AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjG1Kat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjG1Ka1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:30:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE8659C6;
        Fri, 28 Jul 2023 03:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540133; x=1722076133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2p0mZJVu+p3/bzhmij45EcuZNnb/S3hGj7wJ9TXid3Y=;
  b=cfZvuJf3sO5BpzNKMJll7Xurb/jpOhksaZULxXpayM9CLcXNf31CHoGt
   qgegXxSP6YtbG06QiHl0M4kfpFNbxLuVOrTBUVqVkgjypFBpsY0Chqbvz
   NS1bQFEPakWyAny9bY2KYCga4YT1JMawGBvYEECxWGzF0h6c329BaDj+h
   6/ZaJO/URJx2m8b2FKahWtmZxHBWXE6U31yHPTU+iUHH8/VAiGqVYaeRH
   AE4n3oQiHDrcbUsAlfvEa7kK5L+cF1ft8OYjVMooORRCaH86MUorNyPnH
   kyer22No2MEjhE/4Dpw64sQhCuSdeqrtywU/nWz3gUnUvoweA0hoBUCvr
   A==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="225813662"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:28:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:28:50 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:28:47 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 33/50] dt-bindings: usb: add sam9x7
Date:   Fri, 28 Jul 2023 15:58:43 +0530
Message-ID: <20230728102843.266967-1-varshini.rajendran@microchip.com>
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

Document sam9x7 compatible for usb ohci.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 Documentation/devicetree/bindings/usb/generic-ohci.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
index be268e23ca79..a2490759f694 100644
--- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
@@ -57,6 +57,12 @@ properties:
               - nxp,ohci-nxp
               - st,spear600-ohci
           - const: usb-ohci
+      - items:
+          - enum:
+              - microchip,sam9x7-ohci
+          - enum:
+              - atmel,at91rm9200-ohci
+          - const: usb-ohci
 
   reg:
     maxItems: 1
-- 
2.25.1

