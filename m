Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403537BC756
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343988AbjJGMBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343911AbjJGMAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:00:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC0B6
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:00:50 -0700 (PDT)
Date:   Sat, 07 Oct 2023 12:00:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696680049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYLHC9U7kPuDfxsDlF3mapnm6QhMu14KdRfEE+aGdgA=;
        b=w8igbKe1kw/SVi3G8hzZL3eY3CPh3eK7iBeLJVJQeRxoebISblPFcqMi+OJgfKsX4cDE3c
        ZRGvymfixgLPu3PPDgUC8be5I5U/7OC3Ke2u4E5zcR5eR27wVE32BlrioEQVr72WsGC8mG
        pbkBFP59hnKdsd5btKfuJXnRCMdcGftnhH/yQq1xDeJn/xiokA18J51TC4oi6Hv+wMU8eR
        G8qzPnexg+imMVWVNhqMHovcDF48O3mkV/l7IksleA7NVUEDmglYA/WFoA8XPg8oxe52i/
        GGUKmOmvS0V4ddAc03iRau2qHbf+dSt/tCc8gdozfC0AIoIFF1rkTPpLQOUwYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696680049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYLHC9U7kPuDfxsDlF3mapnm6QhMu14KdRfEE+aGdgA=;
        b=Lv6dp0l/qgZJW+2kyi/s7n6nDF5qM8uVvHjLiH2QTMwNHvGoLhKxl2F33+kvc57mOZt7AB
        BqYZHbBWUDaoMfAw==
From:   "irqchip-bot for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/G2UL SoC
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20231006121058.13890-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231006121058.13890-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <169668004801.3135.16099929262408472906.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     db712c0089bd8e9e47c286ed772d86fb187d0854
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/db712c0089bd8e9e47c286ed772d86fb187d0854
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Fri, 06 Oct 2023 13:10:58 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 07 Oct 2023 12:27:39 +01:00

dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G2UL SoC

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
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20231006121058.13890-1-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml | 225 ++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 170 insertions(+), 55 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index ea7db36..2ef3081 100644
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
@@ -45,7 +43,96 @@ properties:
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
@@ -73,6 +160,23 @@ required:
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
@@ -81,55 +185,66 @@ examples:
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
