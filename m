Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2D37F6B78
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 05:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjKXEun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 23:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXEul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 23:50:41 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC823D5A;
        Thu, 23 Nov 2023 20:50:47 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AO4oVfX042017;
        Thu, 23 Nov 2023 22:50:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700801431;
        bh=Y66vY2X0FSoszZvFJCIRRlSjk/xOWDd0eO4EuPQA1fE=;
        h=From:To:CC:Subject:Date;
        b=G3v09qh4GAxcVpiZWzpz50NXRPFzI4iSePPjyjzYtJeL1xVj/q6QIMEXJ+sEDoRTh
         bGe488vofkX9RFxpf9bugr5Lk0nPyUZhKAfJXC1ADH1yjPWDAha5dh2tB2lD6ZVFwB
         mAKVQHlc7jcCbcxi6h0YeSC7ddBNA+Ck8p1N96rE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AO4oVcX077165
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Nov 2023 22:50:31 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 22:50:31 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 22:50:31 -0600
Received: from santhoshkumark.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AO4oSji035953;
        Thu, 23 Nov 2023 22:50:29 -0600
From:   Santhosh Kumar K <s-k6@ti.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <miquel.raynal@bootlin.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] dt-bindings: mfd: ti,am3359-tscadc: Allow dmas property to be optional
Date:   Fri, 24 Nov 2023 10:20:19 +0530
Message-ID: <20231124045019.21003-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADC module can function without DMA, so there may not be dma channel
always associated with device. Hence, remove "dmas", "dma-names" from list
of required properties.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v2: Change the file prefix in $subject
    Collected the tags

v1: https://lore.kernel.org/linux-arm-kernel/20231122094747.34db981c@xps-13/T/#t

 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
index 23a63265be3c..70b5dfce07d2 100644
--- a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
@@ -61,8 +61,6 @@ required:
   - interrupts
   - clocks
   - clock-names
-  - dmas
-  - dma-names
 
 additionalProperties: false
 
-- 
2.34.1

