Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9896C766A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbjG1KYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjG1KXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:23:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB374222;
        Fri, 28 Jul 2023 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690539820; x=1722075820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XK07AlwoF/gbKHVZLICK+wzmR0BpaenZ7oeapx98PA4=;
  b=kZnEtXViaVW2GWD6GVztdjGuee9LqE/zqIO1uuHTBGPCwe4V75RA1Owr
   vjSDiqH+MTuLUVc5wvo9nGeIJ9MU5JMa2vLRcBL0BHaAH+HmiH/AThxW6
   1K2W4qTZuAHDlmTihSqjfICQ/T+jR6Mvxv5hl85VtgIYw9OBmd6US5w2E
   P6HEFmwIYraq9utyKDRwNbEqamaVV5G/Kl2MWmzdopt96CcC9zdU4bGdL
   KtQ0PZFJhczlDfhSIu39Up7fmEz7oZqj/6Zn9H6dgOmQ+woO5oV+9cavA
   EPMfo3E3uBZ8HD8M7k57ka6bTKJkAXgStOi8f4r2w6LcmN+T+Ax0Xxul7
   A==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="225812923"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:23:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:23:36 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:23:30 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 03/50] dt-bindings: net: cdns,macb: add sam9x7 ethernet interface
Date:   Fri, 28 Jul 2023 15:53:28 +0530
Message-ID: <20230728102328.265410-1-varshini.rajendran@microchip.com>
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

Add documentation for sam9x7 ethernet interface.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index bf8894a0257e..c9840a284322 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -59,6 +59,12 @@ properties:
           - cdns,gem                  # Generic
           - cdns,macb                 # Generic
 
+      - items:
+          - enum:
+              - microchip,sam9x7-gem  # Microchip SAM9X7 gigabit ethernet interface
+          - enum:
+              - microchip,sama7g5-gem # Microchip SAMA7G5 gigabit ethernet interface
+
   reg:
     minItems: 1
     items:
-- 
2.25.1

