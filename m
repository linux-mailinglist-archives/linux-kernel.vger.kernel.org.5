Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7195A77C99F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbjHOIrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbjHOIrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:47:33 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEFBBE65;
        Tue, 15 Aug 2023 01:47:29 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.245])
        by gateway (Coremail) with SMTP id _____8BxuOifO9tk87EYAA--.15037S3;
        Tue, 15 Aug 2023 16:47:27 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.245])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_yOeO9tkRQdbAA--.51920S2;
        Tue, 15 Aug 2023 16:47:26 +0800 (CST)
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>, diasyzhang@tencent.com,
        linux-kernel@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH] dt-bindings: interrupt-controller: loongson,liointc: Fix warnings about reg and interrupt description
Date:   Tue, 15 Aug 2023 16:47:13 +0800
Message-Id: <20230815084713.1627520-1-zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_yOeO9tkRQdbAA--.51920S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFWkGF4rKF4rKFy3Cw4xZrc_yoW8ZFWrpF
        W3CanxWF48tF13u3y8ta40krnxZrn5A3ZIkrs7Jay7GFnFq34jqr43KFn5JF1fGrW2qa4j
        vr4FkayUKa47ArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we know, some Loongson-2K CPUs are single-core, e.g. Loongson-2K0500,
and the "isr1" means routing interrupts to core1, which should be
optional. So add maxItems/minItems limits to reg/reg-names.
Also, The interrupt-names attribute represents a list of parent
interrupt names that should change with interrupts.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 .../interrupt-controller/loongson,liointc.yaml     | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
index 00b570c82903..adb428211a72 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   This interrupt controller is found in the Loongson-3 family of chips and
-  Loongson-2K1000 chip, as the primary package interrupt controller which
+  Loongson-2K series chips, as the primary package interrupt controller which
   can route local I/O interrupt to interrupt lines of cores.
 
 allOf:
@@ -33,6 +33,7 @@ properties:
       - const: main
       - const: isr0
       - const: isr1
+    minItems: 2
 
   interrupt-controller: true
 
@@ -45,11 +46,9 @@ properties:
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
@@ -73,7 +72,6 @@ required:
   - '#interrupt-cells'
   - loongson,parent_int_map
 
-
 unevaluatedProperties: false
 
 if:
@@ -86,7 +84,8 @@ if:
 then:
   properties:
     reg:
-      minItems: 3
+      minItems: 2
+      maxItems: 3
 
   required:
     - reg-names
@@ -113,7 +112,6 @@ examples:
                                 <0x0f000000>, /* int1 */
                                 <0x00000000>, /* int2 */
                                 <0x00000000>; /* int3 */
-
     };
 
 ...
-- 
2.39.3

