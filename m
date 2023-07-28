Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377CF766A77
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjG1K1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbjG1K1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:27:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB114EE4;
        Fri, 28 Jul 2023 03:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690539989; x=1722075989;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ywnTS5Lw8wKAM3P0r7KJql/2o/vnY0M20hU7in09Pzw=;
  b=DvlFAud79Hiqt3aGsVs3craerh0YcXduvB8QXkYyltdRf6ex3HmEZwkT
   KtVegr7u9W+RVp/nyvslpZL7NGKtZMiLyGsXr0hhM3v99iSm8SN/5jhCX
   R2I7ch5nE+MMb1zQ6qLLGnV+cC1oCJQiEPf2XcYNOuYFjxpyjWm2wZ1XS
   hef7tWEWcW6mgTW5aKzlg2xXneRLe4uxb8NbRO8c6md+HMav+cMUZnfbr
   Vhn6pt68MWbPbVEjJ2rG3pybd3xqqUTOfRSTo8bekptaNT9ctYLplxbsc
   ZLAbjxMwyfoqpc0Wa35zfaoC+zFeDU76XOVpjkLqQ2fLWjacFglEGB/Cq
   g==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="227047036"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:25:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:25:38 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:25:34 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 15/50] dt-bindings: atmel-gpbr: add microchip,sam9x7-gpbr
Date:   Fri, 28 Jul 2023 15:55:29 +0530
Message-ID: <20230728102529.266030-1-varshini.rajendran@microchip.com>
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

Add microchip,sam9x7-gpbr to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 Documentation/devicetree/bindings/mfd/atmel-gpbr.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-gpbr.txt b/Documentation/devicetree/bindings/mfd/atmel-gpbr.txt
index e8c525569f10..3c989d1760a2 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-gpbr.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-gpbr.txt
@@ -6,6 +6,7 @@ Required properties:
 - compatible:		Should be one of the following:
 			"atmel,at91sam9260-gpbr", "syscon"
 			"microchip,sam9x60-gpbr", "syscon"
+			"microchip,sam9x7-gpbr", "microchip,sam9x60-gpbr", "syscon"
 - reg:			contains offset/length value of the GPBR memory
 			region.
 
-- 
2.25.1

