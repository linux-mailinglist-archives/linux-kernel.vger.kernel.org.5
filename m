Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4DB7665BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjG1HuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbjG1HuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:50:00 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7A8B30E0;
        Fri, 28 Jul 2023 00:49:58 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8Dx6eokc8NkijsLAA--.22411S3;
        Fri, 28 Jul 2023 15:49:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx4eQbc8NkiQA+AA--.34001S3;
        Fri, 28 Jul 2023 15:49:53 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        Yinbo Zhu <zhuyinbo@loongson.cn>, Liu Yun <liuyun@loongson.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] soc: dt-bindings: add loongson-2 pm
Date:   Fri, 28 Jul 2023 15:49:43 +0800
Message-Id: <20230728074944.26746-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230728074944.26746-1-zhuyinbo@loongson.cn>
References: <20230728074944.26746-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx4eQbc8NkiQA+AA--.34001S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Loongson-2 SoC Power Management Controller binding with DT
schema format using json-schema.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../soc/loongson/loongson,ls2k-pmc.yaml       | 52 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml

diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
new file mode 100644
index 000000000000..da2dcfeebf12
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/loongson/loongson,ls2k-pmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-2 Power Manager controller
+
+maintainers:
+  - Yinbo Zhu <zhuyinbo@loongson.cn>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - loongson,ls2k0500-pmc
+          - loongson,ls2k1000-pmc
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  loongson,suspend-address:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description:
+      The "loongson,suspend-address" is a deep sleep state (Suspend To
+      RAM) firmware entry address which was jumped from kernel and it's
+      value was dependent on specific platform firmware code. In
+      addition, the PM need according to it to indicate that current
+      SoC whether support Suspend To RAM.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    power-management@1fe27000 {
+        compatible = "loongson,ls2k1000-pmc", "syscon";
+        reg = <0x1fe27000 0x58>;
+        interrupt-parent = <&liointc1>;
+        interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+        loongson,suspend-address = <0x0 0x1c000500>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a91f14cad2e..bcd05f1fa5c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12190,6 +12190,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
 F:	drivers/soc/loongson/loongson2_guts.c
 
+LOONGSON-2 SOC SERIES PM DRIVER
+M:	Yinbo Zhu <zhuyinbo@loongson.cn>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
+
 LOONGSON-2 SOC SERIES PINCTRL DRIVER
 M:	zhanghongchen <zhanghongchen@loongson.cn>
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
-- 
2.20.1

