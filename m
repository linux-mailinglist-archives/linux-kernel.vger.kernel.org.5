Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F41782377
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjHUGNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjHUGNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:13:37 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD412A2;
        Sun, 20 Aug 2023 23:13:34 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8AxFvGKAONkIYAaAA--.53908S3;
        Mon, 21 Aug 2023 14:13:30 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxWM2HAONk7kdfAA--.37876S2;
        Mon, 21 Aug 2023 14:13:28 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, diasyzhang@tencent.com,
        linux-kernel@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc: Fix warnings about liointc-2.0
Date:   Mon, 21 Aug 2023 14:13:15 +0800
Message-Id: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxWM2HAONk7kdfAA--.37876S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw4rGw1xArWfKFWrAF48Xwc_yoWrKF4xpF
        W3CanxWr4UtF17Cw4rtFy0k3Z8Ar98ArnxCws7A3y7Ga9Fqa4jqr43KFyrJa13WryIqa4j
        9F4Fkw4xWasrAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8svtJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit f4dee5d8e1fa ("dt-bindings: interrupt-controller: Add
Loongson-2K1000 LIOINTC"), the loongson liointc supports configuring
routes for 64-bit interrupt sources.

For liointc-2.0, we need to define two liointc nodes in dts, one for
"0-31" interrupt sources and the other for "32-63" interrupt sources.
This applies to mips Loongson-2K1000.

Unfortunately, there are some warnings about "loongson,liointc-2.0":
1. "interrupt-names" should be "required", the driver gets the parent
interrupts through it.

2. Since not all CPUs are multicore, e.g. Loongson-2K0500 is a
single-core CPU, there is no core1-related registers. So "reg" and
"reg-names" should be set to "minItems 2".

3. Routing interrupts from "int0" is a common solution in practice, but
theoretically there is no such requirement, as long as conflicts are
avoided. So "interrupt-names" should be defined by "pattern".

This fixes dtbs_check warning:

DTC_CHK arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb
arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: interrupt-controller@1fe11440: interrupt-names:0: 'int0' was expected
      From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: interrupt-controller@1fe11440: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
      From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml

Fixes: f4dee5d8e1fa ("dt-bindings: interrupt-controller: Add Loongson-2K1000 LIOINTC")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
V2:
1. Update commit message;
2. "interruprt-names" should be "required", the driver gets the parent
interrupts through it;
3. Add more descriptions to explain the rationale for multiple nodes;
4. Rewrite if-else statements.

Link to V1:
https://lore.kernel.org/all/20230815084713.1627520-1-zhoubinbin@loongson.cn/

 .../loongson,liointc.yaml                     | 74 +++++++++----------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
index 00b570c82903..f695d3a75ddf 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
@@ -11,11 +11,11 @@ maintainers:
 
 description: |
   This interrupt controller is found in the Loongson-3 family of chips and
-  Loongson-2K1000 chip, as the primary package interrupt controller which
+  Loongson-2K series chips, as the primary package interrupt controller which
   can route local I/O interrupt to interrupt lines of cores.
-
-allOf:
-  - $ref: /schemas/interrupt-controller.yaml#
+  In particular, the Loongson-2K1000/2K0500 has 64 interrupt sources that we
+  need to describe with two dts nodes. One for interrupt sources "0-31" and
+  the other for interrupt sources "32-63".
 
 properties:
   compatible:
@@ -24,15 +24,9 @@ properties:
       - loongson,liointc-1.0a
       - loongson,liointc-2.0
 
-  reg:
-    minItems: 1
-    maxItems: 3
+  reg: true
 
-  reg-names:
-    items:
-      - const: main
-      - const: isr0
-      - const: isr1
+  reg-names: true
 
   interrupt-controller: true
 
@@ -45,11 +39,9 @@ properties:
   interrupt-names:
     description: List of names for the parent interrupts.
     items:
-      - const: int0
-      - const: int1
-      - const: int2
-      - const: int3
+      pattern: int[0-3]
     minItems: 1
+    maxItems: 4
 
   '#interrupt-cells':
     const: 2
@@ -69,32 +61,41 @@ required:
   - compatible
   - reg
   - interrupts
+  - interrupt-names
   - interrupt-controller
   - '#interrupt-cells'
   - loongson,parent_int_map
 
-
 unevaluatedProperties: false
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - loongson,liointc-2.0
-
-then:
-  properties:
-    reg:
-      minItems: 3
-
-  required:
-    - reg-names
-
-else:
-  properties:
-    reg:
-      maxItems: 1
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - loongson,liointc-2.0
+    then:
+      properties:
+        reg:
+          minItems: 2
+          items:
+            - description: Interrupt routing registers.
+            - description: Low/high 32-bit interrupt status routed to core0.
+            - description: Low/high 32-bit interrupt status routed to core1.
+        reg-names:
+          minItems: 2
+          items:
+            - const: main
+            - const: isr0
+            - const: isr1
+      required:
+        - reg-names
+    else:
+      properties:
+        reg:
+          maxItems: 1
 
 examples:
   - |
@@ -113,7 +114,6 @@ examples:
                                 <0x0f000000>, /* int1 */
                                 <0x00000000>, /* int2 */
                                 <0x00000000>; /* int3 */
-
     };
 
 ...
-- 
2.39.3

