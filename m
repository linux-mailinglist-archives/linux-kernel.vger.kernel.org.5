Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600A87857A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbjHWMLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjHWMLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:11:04 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49763172C;
        Wed, 23 Aug 2023 05:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692792643; x=1724328643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6mGZCtgVpzhya/jeIDBbXhi3sMtCHvzhr/SBd9rvOPU=;
  b=QoY7JRa7tPyV32F+hJP1LD1mWPZ5xXXjAjbDlm3CM+veKI1M45CFxW+r
   SbnAGPe6GAtOwuZHYIuyffXkCdLl9F+QYvaX8kc7pX0GJDI9Rt4igbb8x
   FuCEFeRqC77Ws/cTa3kTzGCAOreG+9OA3JA6VZO4SUI9hvY76BFuGPBgw
   jJ9g6lA30jJ059MpdlVPpDPzo39FJTRd6spmskEXBZ6cRb2CDxa3xDOJj
   rlSyPyf7AN7n4eQ66REm3tA30z7Zn0KcETKCM9NZviEYapHvDIM3Og81E
   yDzQsyW5YxiaDNFJHhow1o+7ulgLwyJYP183ZNcmNLd5ARiN5vQLcNjsW
   g==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684792800"; 
   d="scan'208";a="32586563"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Aug 2023 14:10:01 +0200
Received: from herburgerg-w2.tq-net.de (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6BD98280085;
        Wed, 23 Aug 2023 14:10:01 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: [PATCH 2/6] dt-bindings: arm: fsl: Add TQ-Systems LS1043A/LS1046A based boards
Date:   Wed, 23 Aug 2023 14:09:48 +0200
Message-Id: <20230823120952.317740-3-gregor.herburger@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823120952.317740-1-gregor.herburger@ew.tq-group.com>
References: <20230823120952.317740-1-gregor.herburger@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TQMLS1043A and TQMLS1046A use the LS1043A LS1046A SOC on a common
layout.
MBLS10XXA is a starterkit baseboard usable for both SOMs.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 9450b2c8a678..55e8279d834b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1389,6 +1389,13 @@ properties:
               - fsl,ls1043a-qds
           - const: fsl,ls1043a
 
+      - description: TQ-Systems LS1043A based Boards
+        items:
+          - enum:
+              - tq,ls1043a-tqmls1043a-mbls10xxa
+          - const: tq,ls1043a-tqmls1043a
+          - const: fsl,ls1043a
+
       - description: LS1046A based Boards
         items:
           - enum:
@@ -1397,6 +1404,13 @@ properties:
               - fsl,ls1046a-rdb
           - const: fsl,ls1046a
 
+      - description: TQ-Systems LS1046A based Boards
+        items:
+          - enum:
+              - tq,ls1046a-tqmls1046a-mbls10xxa
+          - const: tq,ls1046a-tqmls1046a
+          - const: fsl,ls1046a
+
       - description: LS1088A based Boards
         items:
           - enum:
-- 
2.34.1

