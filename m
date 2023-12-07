Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313388081F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjLGH3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjLGH3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:29:51 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80357D53;
        Wed,  6 Dec 2023 23:29:57 -0800 (PST)
Received: from loongson.cn (unknown [112.20.109.254])
        by gateway (Coremail) with SMTP id _____8Axjut0dHFl4o8_AA--.58534S3;
        Thu, 07 Dec 2023 15:29:56 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.254])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxnd5vdHFl7EhXAA--.63284S4;
        Thu, 07 Dec 2023 15:29:54 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>, devicetree@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, lvjianmin@loongson.cn,
        WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/2] dt-bindings: interrupt-controller: loongson,liointc: Fix dtbs_check warning for interrupt-names
Date:   Thu,  7 Dec 2023 15:29:39 +0800
Message-Id: <854c3c261072f9b97b9e61f318938ff81ff8fe7b.1701933946.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1701933946.git.zhoubinbin@loongson.cn>
References: <cover.1701933946.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxnd5vdHFl7EhXAA--.63284S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw43ZF4rKr1UAFWkGryxCrX_yoW5CF45pF
        ZrC3ZrXr48tF13C3yktw10kFn8Zrn5AwnI9as7C3y7GFnFqa48Zr43tF95XF4rGrZ3Xa4j
        qryF9ayIga47JabCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
        xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
        0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr6p9UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Loongson-2K0500/2K1000 CPUs have 64 interrupt sources as inputs, and
a route-mapped node handles up to 32 interrupt sources, so two liointc
nodes are defined in dts{i}.

Of course, we have to make sure that the routing outputs ("intx") of the
two nodes do not conflict, i.e. "int0" can only be used as a routing
output for one of them. Therefore, "interrupt-names" should be defined
as "pattern".

In addition, since "interrupt-names" and "interrupts" are one-to-one
correspondence, we pass it to get the corresponding interrupt number in
the driver. Setting it to "required" does not break ABI, because it
is already logically represented as "required".

This fixes dtbs_check warning:

DTC_CHK arch/loongarch/boot/dts/loongson-2k0500-ref.dtb
arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1fe11440: interrupt-names:0: 'int0' was expected
        From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1fe11440: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
        From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
DTC_CHK arch/loongarch/boot/dts/loongson-2k1000-ref.dtb
arch/loongarch/boot/dts/loongson-2k1000-ref.dtb: interrupt-controller@1fe01440: interrupt-names:0: 'int0' was expected
        From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
arch/loongarch/boot/dts/loongson-2k1000-ref.dtb: interrupt-controller@1fe01440: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
        From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/interrupt-controller/loongson,liointc.yaml    | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
index a3276c1d9b59..60441f0c5d72 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
@@ -51,11 +51,9 @@ properties:
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
@@ -75,6 +73,7 @@ required:
   - compatible
   - reg
   - interrupts
+  - interrupt-names
   - interrupt-controller
   - '#interrupt-cells'
   - loongson,parent_int_map
-- 
2.39.3

