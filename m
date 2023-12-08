Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19A680A139
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573679AbjLHKiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573611AbjLHKiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:38:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D89B1994;
        Fri,  8 Dec 2023 02:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702031892; x=1733567892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GfT80d/okzC6viedL9X8itP99mbYjg+U5fLBnEZks9k=;
  b=NQh8oM1dSfclSRYE1H0NXbjlEfnYiopNwfLu8SrIE7hZVa9e9RhPAgpx
   E+bZGBWBD26ATNl2Xaa9H/P0E76yC7iJas3dv2SI7RfbDg3IzBwzS/G8c
   Z8JQSiOL2KfiVlqvTxoiLOXbMGL2oYUJ2pJVG761e0TmfJOJjYBW0ek0T
   NicWV3jpPG/PWxV5FvjjyNpf42EIGMcQY3+GAkTEhwR50pNlc59GjEydV
   2KWBcbGPeqv3ZM3rKb+7bByhdvYdVkVAyHNqhCeyAnNjU57IKDc28xqAe
   ay72Bf8AD/n+gxOqEKwbQabHtpUuC+ikRRPIC/F0brgwqe2ULwfj92LTt
   g==;
X-CSE-ConnectionGUID: fyOiA1txSLWOb88DmV8r+w==
X-CSE-MsgGUID: uCFtUYpPS+WMAhzQKqzSVA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="13315298"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2023 03:38:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 03:37:58 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 03:37:52 -0700
From:   shravan chippa <shravan.chippa@microchip.com>
To:     <green.wan@sifive.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasuresh.relli@microchip.com>, <praveen.kumar@microchip.com>,
        <shravan.chippa@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 2/4] dt-bindings: dma: sf-pdma: add new compatible name
Date:   Fri, 8 Dec 2023 16:08:54 +0530
Message-ID: <20231208103856.3732998-3-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208103856.3732998-1-shravan.chippa@microchip.com>
References: <20231208103856.3732998-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Add new compatible name microchip,mpfs-pdma to support
out of order dma transfers

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 .../devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index a1af0b906365..3b22183a1a37 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -29,6 +29,7 @@ properties:
   compatible:
     items:
       - enum:
+          - microchip,mpfs-pdma
           - sifive,fu540-c000-pdma
       - const: sifive,pdma0
     description:
-- 
2.34.1

