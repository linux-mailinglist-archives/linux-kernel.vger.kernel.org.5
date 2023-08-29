Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9085678C17F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjH2J33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjH2J3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:29:14 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0E81BD;
        Tue, 29 Aug 2023 02:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1693301345; x=1724837345;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=kwAaeY34PuijN5T4G25vZVYO2L20JJLnudOwAtYeu3Q=;
  b=byrF54Z6BeJLWlgRxSSJmPBlRiOf56UjAHUlMhLKYQ3IeDN2bTk802vj
   aVjQ52ra0aHmfdmxI8csIey4xmDWWvk8F1YBbH/cY2QfhQhvv6hUb8G6z
   nz4nLE63lbd0yHWkuZGJAx/WXaT85GQHdklcQgN/L/8hbUcNtEfNeviOd
   lpZgJsjW4IaPlxNerDrgqtG8w2HmFW2J3W6rN83HgkUwFWYnWeF4PqCUJ
   bxJ54SHWBHNuDaUxYRvdmZQVKI+LV6duTHdDAmfqPgp/3oCMQ/L2C9Qog
   u3K46rxhQymqdCilFCTGO3MfQUZyb4NdgCPQX64YKalCv36/KWPbM8LYq
   A==;
X-IronPort-AV: E=Sophos;i="6.02,210,1688421600"; 
   d="scan'208";a="32672404"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Aug 2023 11:27:25 +0200
Received: from [127.0.1.1] (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id D8555280085;
        Tue, 29 Aug 2023 11:27:24 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date:   Tue, 29 Aug 2023 11:26:58 +0200
Subject: [PATCH v2 2/6] dt-bindings: arm: fsl: Add TQ-Systems
 LS1043A/LS1046A based boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230829-for-ml-tqmls10xxa-v2-test-v2-2-b1da63785b25@ew.tq-group.com>
References: <20230829-for-ml-tqmls10xxa-v2-test-v2-0-b1da63785b25@ew.tq-group.com>
In-Reply-To: <20230829-for-ml-tqmls10xxa-v2-test-v2-0-b1da63785b25@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        gregor.herburger@ew.tq-group.com,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693301244; l=1459;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=ra4pYAnTXQuv5XqJ16KtPV7ONrsZHuo5ifdORBsAF0A=;
 b=EGkUPrEELwYuiKK7Fg0Bp9sdyEvMR3ZpTjHamcJcMoCcskU4RLvmBuWst6RPR0a1E1dWfXZtY
 pjvKuFzvhlPC4zfYzyExvHcV2bojK7zB2svs3V5X5uA+hQJBjbxPqSk
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TQMLS1043A and TQMLS1046A use the LS1043A LS1046A SOC on a common
layout.
MBLS10XXA is a starterkit baseboard usable for both SOMs.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

