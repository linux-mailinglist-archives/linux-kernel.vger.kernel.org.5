Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3DD7E952D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 03:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjKMChK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 21:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjKMChD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 21:37:03 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 460EC1BF7;
        Sun, 12 Nov 2023 18:36:56 -0800 (PST)
Received: from loongson.cn (unknown [112.20.112.120])
        by gateway (Coremail) with SMTP id _____8Bx5fDGi1FlxG45AA--.48217S3;
        Mon, 13 Nov 2023 10:36:54 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.120])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxvi_Bi1Fly1JAAA--.9842S4;
        Mon, 13 Nov 2023 10:36:52 +0800 (CST)
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
Subject: [PATCH v4 5/5] MIPS: Loongson64: DTS: Fix 'loongson,parent_int_map' references
Date:   Mon, 13 Nov 2023 10:36:47 +0800
Message-Id: <5673f5d246625397595803c3f5f9b70397930ca7.1699521866.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1699521866.git.zhoubinbin@loongson.cn>
References: <cover.1699521866.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxvi_Bi1Fly1JAAA--.9842S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr13Zry7Xw1UAF4xAr1fGrX_yoW5tF48pw
        43Aa18Gw4xKr17A398G34UJr1fZFZ0yFZrWF4xGFW8A39aga4UXr1fJF1rtrs3Gry5Xa42
        9r1vgrWUKFykCabCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
        XVW3AwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
        0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
        xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0eOJUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 'loongson,parent_int_map' has been deprecated, replace all
relevant references in the MIPS loongson dts{i} with
'loongson,parent-int-map'.

Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi       | 4 ++--
 arch/mips/boot/dts/loongson/loongson64c-package.dtsi     | 2 +-
 arch/mips/boot/dts/loongson/loongson64g-package.dtsi     | 2 +-
 arch/mips/boot/dts/loongson/loongson64v_4core_virtio.dts | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
index f878f47e4501..36f499a3772e 100644
--- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
@@ -71,7 +71,7 @@ liointc0: interrupt-controller@1fe11400 {
 			interrupts = <2>;
 			interrupt-names = "int0";
 
-			loongson,parent_int_map = <0xffffffff>, /* int0 */
+			loongson,parent-int-map = <0xffffffff>, /* int0 */
 						<0x00000000>, /* int1 */
 						<0x00000000>, /* int2 */
 						<0x00000000>; /* int3 */
@@ -91,7 +91,7 @@ liointc1: interrupt-controller@1fe11440 {
 			interrupts = <3>;
 			interrupt-names = "int1";
 
-			loongson,parent_int_map = <0x00000000>, /* int0 */
+			loongson,parent-int-map = <0x00000000>, /* int0 */
 						<0xffffffff>, /* int1 */
 						<0x00000000>, /* int2 */
 						<0x00000000>; /* int3 */
diff --git a/arch/mips/boot/dts/loongson/loongson64c-package.dtsi b/arch/mips/boot/dts/loongson/loongson64c-package.dtsi
index 5bb876a4de52..38de0108e804 100644
--- a/arch/mips/boot/dts/loongson/loongson64c-package.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson64c-package.dtsi
@@ -35,7 +35,7 @@ liointc: interrupt-controller@3ff01400 {
 			interrupts = <2>, <3>;
 			interrupt-names = "int0", "int1";
 
-			loongson,parent_int_map = <0xf0ffffff>, /* int0 */
+			loongson,parent-int-map = <0xf0ffffff>, /* int0 */
 						<0x0f000000>, /* int1 */
 						<0x00000000>, /* int2 */
 						<0x00000000>; /* int3 */
diff --git a/arch/mips/boot/dts/loongson/loongson64g-package.dtsi b/arch/mips/boot/dts/loongson/loongson64g-package.dtsi
index d4314f62ccc2..8972adcb83d6 100644
--- a/arch/mips/boot/dts/loongson/loongson64g-package.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson64g-package.dtsi
@@ -32,7 +32,7 @@ liointc: interrupt-controller@3ff01400 {
 			interrupts = <2>, <3>;
 			interrupt-names = "int0", "int1";
 
-			loongson,parent_int_map = <0x00ffffff>, /* int0 */
+			loongson,parent-int-map = <0x00ffffff>, /* int0 */
 						<0xff000000>, /* int1 */
 						<0x00000000>, /* int2 */
 						<0x00000000>; /* int3 */
diff --git a/arch/mips/boot/dts/loongson/loongson64v_4core_virtio.dts b/arch/mips/boot/dts/loongson/loongson64v_4core_virtio.dts
index d0588d81e0c2..88642fee1bbd 100644
--- a/arch/mips/boot/dts/loongson/loongson64v_4core_virtio.dts
+++ b/arch/mips/boot/dts/loongson/loongson64v_4core_virtio.dts
@@ -34,7 +34,7 @@ liointc: interrupt-controller@3ff01400 {
 			interrupts = <2>, <3>;
 			interrupt-names = "int0", "int1";
 
-			loongson,parent_int_map = <0x00000001>, /* int0 */
+			loongson,parent-int-map = <0x00000001>, /* int0 */
 						<0xfffffffe>, /* int1 */
 						<0x00000000>, /* int2 */
 						<0x00000000>; /* int3 */
-- 
2.39.3

