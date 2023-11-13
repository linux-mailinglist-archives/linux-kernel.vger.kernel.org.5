Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250AA7E951C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 03:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjKMCgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 21:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjKMCgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 21:36:44 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8B7010D;
        Sun, 12 Nov 2023 18:36:40 -0800 (PST)
Received: from loongson.cn (unknown [112.20.112.120])
        by gateway (Coremail) with SMTP id _____8CxyOi1i1FlbW45AA--.11597S3;
        Mon, 13 Nov 2023 10:36:37 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.120])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxvdyui1FltFJAAA--.9944S3;
        Mon, 13 Nov 2023 10:36:34 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, lvjianmin@loongson.cn,
        WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v4 1/5] dt-bindings: interrupt-controller: loongson,liointc: Standardize the naming of 'loongson,parent-int-map'
Date:   Mon, 13 Nov 2023 10:36:21 +0800
Message-Id: <84cb3df17eee993fc6a10e965b3f438f9034d2de.1699521866.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1699521866.git.zhoubinbin@loongson.cn>
References: <cover.1699521866.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxvdyui1FltFJAAA--.9944S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4rZFy5uF4rtFy7Xw4xAFc_yoW8Cw48pF
        sxC3WDGr48tF17A390qa4vyF1fZFn5A3ZrWFZ7Ja1xAFWqqw1DXrW3KF15A3W3CrWUXFy7
        XryFgayUKa47AabCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
        6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4YLvDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the 'loongson,parent_int_map' attribute naming is non-standard, we
should use 'loongson,parent-int-map' instead.
Also, 'loongson,parent_int_map' will be marked as deprecated.

Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 .../interrupt-controller/loongson,liointc.yaml    | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
index 00b570c82903..0d9511b8a792 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
@@ -55,6 +55,7 @@ properties:
     const: 2
 
   loongson,parent_int_map:
+    deprecated: true
     description: |
       This property points how the children interrupts will be mapped into CPU
       interrupt lines. Each cell refers to a parent interrupt line from 0 to 3
@@ -65,14 +66,21 @@ properties:
     minItems: 4
     maxItems: 4
 
+  loongson,parent-int-map:
+    description: |
+      Exactly the same as 'loongson,parent_int_map', we just replaced the
+      unstandardized use of underscores.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 4
+
 required:
   - compatible
   - reg
   - interrupts
   - interrupt-controller
   - '#interrupt-cells'
-  - loongson,parent_int_map
-
+  - loongson,parent-int-map
 
 unevaluatedProperties: false
 
@@ -109,11 +117,10 @@ examples:
       interrupts = <2>, <3>;
       interrupt-names = "int0", "int1";
 
-      loongson,parent_int_map = <0xf0ffffff>, /* int0 */
+      loongson,parent-int-map = <0xf0ffffff>, /* int0 */
                                 <0x0f000000>, /* int1 */
                                 <0x00000000>, /* int2 */
                                 <0x00000000>; /* int3 */
-
     };
 
 ...
-- 
2.39.3

