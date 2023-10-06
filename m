Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F47BB75E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjJFMLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjJFMLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:11:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E05C2;
        Fri,  6 Oct 2023 05:11:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so1965571f8f.2;
        Fri, 06 Oct 2023 05:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696594298; x=1697199098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LH5Dk/rqOIbw2uuFdQpiZE9NOb4+sgXhCj9XhWUlAJ0=;
        b=ESS1s2WIskeqg4L4u7VFsFxMwgOhZO75ksG/iBU1b0gL6Mryddp/VLWdWVzzHDN/T7
         N+XHGci4PDeetiG9wZ8FU7FZCBOC2WPgigBiv39eZq5wVUwT+2s/Rp49YQmBPJRwvSQJ
         nP1FhArJWEZjxZa4KamJ+dlO0D0R0+2VXhmVdnAnVOAlkeoRmAKGERpqE8nsOsPkUdd+
         q1qwcTj+X006B8F+gC1skCp2SCIdXI6zPFh0HO8oJzNcbLHrPuxwXsgz1R6oZHZvFDew
         sN580dP743IbTj6MjbvVsBT8dh8PvzNF42hnHHX6TdROa7DqMEB2ECXlwnotIJiaZ2OO
         NtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696594298; x=1697199098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LH5Dk/rqOIbw2uuFdQpiZE9NOb4+sgXhCj9XhWUlAJ0=;
        b=kbl1fAgi8pVRab++kLNqRRUjUCQxCPJYZXwYO1/IfkfQHuCdVkJ8DeJeF5D05S3wnw
         8EcH+2fZTHy7k4s8AhrTUqJnIyXAqiY4GaZwNfdkTqXkRXzIt9vH0SvgKxqQsQ9x1eJf
         X8KN5dULoN24k/EFyUw9JMmgahiqtdgM4IKMhdFzrwexKsLwMk+vcBnL1yOUVT2t6RJL
         e8c7XMzakKVLRtuY8rNjI0wAbBM0QnysTwzzbhX10DSMjixOZ2GHbpc+BKf9Q/bGUhfj
         EemmqT9G8OieOEE/DviijAIpw834e6QeVPDQ/412+wzqefkpcMzbSAYWVXQ+25B7Hp+1
         cYeA==
X-Gm-Message-State: AOJu0Yyg0u3Gs/twAqwLBQVctTBciFxV15YdSY1YMy6fWBd4f8oCOZCN
        CSkr1N10pf1RUxeSJwkRW+ACJKG3lhyEWmAE
X-Google-Smtp-Source: AGHT+IGThZ1J24Eqq8x6lbmIQWo31bIEREiBdxkXF1VP1ss9B9M4niGDiVT6pKvibhZJcqROBNT+fQ==
X-Received: by 2002:adf:f084:0:b0:314:a3f:9c08 with SMTP id n4-20020adff084000000b003140a3f9c08mr6983148wro.39.1696594297834;
        Fri, 06 Oct 2023 05:11:37 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:1aab:5b91:8fe9:69a7])
        by smtp.gmail.com with ESMTPSA id i12-20020a5d630c000000b00326b8a0e817sm1518859wru.84.2023.10.06.05.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 05:11:37 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 RESEND] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G2UL SoC
Date:   Fri,  6 Oct 2023 13:10:58 +0100
Message-Id: <20231006121058.13890-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document RZ/G2UL (R9A07G043U) IRQC bindings. The IRQC block on RZ/G2UL SoC
is almost identical to one found on the RZ/G2L SoC the only difference
being it can support BUS_ERR_INT for which it has additional registers.
Hence new generic compatible string "renesas,r9a07g043u-irqc" is added
for RZ/G2UL SoC.

Now that we have additional interrupt for RZ/G2UL and RZ/Five SoC
interrupt-names property is added so that we can parse them based on
names.

While at it updated the example node to four spaces and added
interrupt-names property.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Hi Marc,

This patch was missed to be picked up [0] so just resending it again.

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230102221815.273719-2-prabhakar.mahadev-lad.rj@bp.renesas.com/
Cheers, Prabhakar
---
 .../renesas,rzg2l-irqc.yaml                   | 225 +++++++++++++-----
 1 file changed, 170 insertions(+), 55 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index 33b90e975e33..fc900ce2fe0a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -19,13 +19,11 @@ description: |
     - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
       stand-up edge detection interrupts)
 
-allOf:
-  - $ref: /schemas/interrupt-controller.yaml#
-
 properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043u-irqc   # RZ/G2UL
           - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
           - renesas,r9a07g054-irqc    # RZ/V2L
       - const: renesas,rzg2l-irqc
@@ -44,7 +42,96 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 41
+    minItems: 41
+    items:
+      - description: NMI interrupt
+      - description: IRQ0 interrupt
+      - description: IRQ1 interrupt
+      - description: IRQ2 interrupt
+      - description: IRQ3 interrupt
+      - description: IRQ4 interrupt
+      - description: IRQ5 interrupt
+      - description: IRQ6 interrupt
+      - description: IRQ7 interrupt
+      - description: GPIO interrupt, TINT0
+      - description: GPIO interrupt, TINT1
+      - description: GPIO interrupt, TINT2
+      - description: GPIO interrupt, TINT3
+      - description: GPIO interrupt, TINT4
+      - description: GPIO interrupt, TINT5
+      - description: GPIO interrupt, TINT6
+      - description: GPIO interrupt, TINT7
+      - description: GPIO interrupt, TINT8
+      - description: GPIO interrupt, TINT9
+      - description: GPIO interrupt, TINT10
+      - description: GPIO interrupt, TINT11
+      - description: GPIO interrupt, TINT12
+      - description: GPIO interrupt, TINT13
+      - description: GPIO interrupt, TINT14
+      - description: GPIO interrupt, TINT15
+      - description: GPIO interrupt, TINT16
+      - description: GPIO interrupt, TINT17
+      - description: GPIO interrupt, TINT18
+      - description: GPIO interrupt, TINT19
+      - description: GPIO interrupt, TINT20
+      - description: GPIO interrupt, TINT21
+      - description: GPIO interrupt, TINT22
+      - description: GPIO interrupt, TINT23
+      - description: GPIO interrupt, TINT24
+      - description: GPIO interrupt, TINT25
+      - description: GPIO interrupt, TINT26
+      - description: GPIO interrupt, TINT27
+      - description: GPIO interrupt, TINT28
+      - description: GPIO interrupt, TINT29
+      - description: GPIO interrupt, TINT30
+      - description: GPIO interrupt, TINT31
+      - description: Bus error interrupt
+
+  interrupt-names:
+    minItems: 41
+    items:
+      - const: nmi
+      - const: irq0
+      - const: irq1
+      - const: irq2
+      - const: irq3
+      - const: irq4
+      - const: irq5
+      - const: irq6
+      - const: irq7
+      - const: tint0
+      - const: tint1
+      - const: tint2
+      - const: tint3
+      - const: tint4
+      - const: tint5
+      - const: tint6
+      - const: tint7
+      - const: tint8
+      - const: tint9
+      - const: tint10
+      - const: tint11
+      - const: tint12
+      - const: tint13
+      - const: tint14
+      - const: tint15
+      - const: tint16
+      - const: tint17
+      - const: tint18
+      - const: tint19
+      - const: tint20
+      - const: tint21
+      - const: tint22
+      - const: tint23
+      - const: tint24
+      - const: tint25
+      - const: tint26
+      - const: tint27
+      - const: tint28
+      - const: tint29
+      - const: tint30
+      - const: tint31
+      - const: bus-err
 
   clocks:
     maxItems: 2
@@ -72,6 +159,23 @@ required:
   - power-domains
   - resets
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a07g043u-irqc
+    then:
+      properties:
+        interrupts:
+          minItems: 42
+        interrupt-names:
+          minItems: 42
+      required:
+        - interrupt-names
+
 unevaluatedProperties: false
 
 examples:
@@ -80,55 +184,66 @@ examples:
     #include <dt-bindings/clock/r9a07g044-cpg.h>
 
     irqc: interrupt-controller@110a0000 {
-            compatible = "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
-            reg = <0x110a0000 0x10000>;
-            #interrupt-cells = <2>;
-            #address-cells = <0>;
-            interrupt-controller;
-            interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
-            clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
-                     <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
-            clock-names = "clk", "pclk";
-            power-domains = <&cpg>;
-            resets = <&cpg R9A07G044_IA55_RESETN>;
+        compatible = "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
+        reg = <0x110a0000 0x10000>;
+        #interrupt-cells = <2>;
+        #address-cells = <0>;
+        interrupt-controller;
+        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "nmi",
+                          "irq0", "irq1", "irq2", "irq3",
+                          "irq4", "irq5", "irq6", "irq7",
+                          "tint0", "tint1", "tint2", "tint3",
+                          "tint4", "tint5", "tint6", "tint7",
+                          "tint8", "tint9", "tint10", "tint11",
+                          "tint12", "tint13", "tint14", "tint15",
+                          "tint16", "tint17", "tint18", "tint19",
+                          "tint20", "tint21", "tint22", "tint23",
+                          "tint24", "tint25", "tint26", "tint27",
+                          "tint28", "tint29", "tint30", "tint31";
+        clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
+                 <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
+        clock-names = "clk", "pclk";
+        power-domains = <&cpg>;
+        resets = <&cpg R9A07G044_IA55_RESETN>;
     };
-- 
2.34.1

