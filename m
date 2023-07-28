Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9658766AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbjG1Kaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbjG1Kab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:30:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FF059C9;
        Fri, 28 Jul 2023 03:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540133; x=1722076133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MRaQpZ0O+GmIjSSPmtCqS1RhB+CH/HoJ5cNyVqtoWsM=;
  b=ZoecFRhzSBWUpzK+ahVPhg7Yd2xyujs3qvG4HUWDlqk6InTcD+Qlhfsj
   UrNV4rrOlYW2ANYMkmgUmg9+Qydab3m4jTipj3hlm48zUJkTNJ7titFyZ
   HvkXDqWnmVKJrEfa2jamWeTU8d2DS4FAUs/064yJZbSbajb1lUwh9BX9/
   Tc8mxdXiK6UoU07eWJru+HqawmkmVm5O9CeJifah02YOo5BVuBfxHvLwM
   QCsteCWRQHekgHlZKA8m+f6J/G/OQGxyX+K1UbSpz2Gjg7VnqLPN09X4K
   +h4R5Mxqm9bKpfXnqbv5+jXmaWmTuNeHMZ6h0dOAMrLyq1s3RS19OCTPg
   A==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="227047467"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:28:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:28:42 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:28:39 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 32/50] dt-bindings: usb: ehci: Add sam9x7
Date:   Fri, 28 Jul 2023 15:58:36 +0530
Message-ID: <20230728102836.266918-1-varshini.rajendran@microchip.com>
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

Document sam9x7 compatible for usb-ehci.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index e5c8f4e085de..afc4da89dde5 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -82,6 +82,12 @@ properties:
           - nuvoton,npcm845-ehci
           - ti,ehci-omap
           - usb-ehci
+      - items:
+          - enum:
+              - microchip,sam9x7-ehci
+          - enum:
+              - atmel,at91sam9g45-ehci
+          - const: usb-ehci
 
   reg:
     minItems: 1
-- 
2.25.1

