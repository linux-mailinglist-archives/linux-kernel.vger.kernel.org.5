Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61580774AD7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbjHHUgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbjHHUfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:35:46 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C4E270D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:06:25 -0700 (PDT)
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.spreadtrum.com with ESMTP id 3787NRFW028631
        for <linux-kernel@vger.kernel.org>; Tue, 8 Aug 2023 15:23:27 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3787MuLc026831;
        Tue, 8 Aug 2023 15:22:56 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RKl3L3dTlz2NsJlw;
        Tue,  8 Aug 2023 15:21:02 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 8 Aug 2023
 15:22:54 +0800
From:   Wenhua Lin <Wenhua.Lin@unisoc.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Holland <samuel@sholland.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: [PATCH 1/2] devicetree: bindings: Add keypad driver ducumentation
Date:   Tue, 8 Aug 2023 15:22:52 +0800
Message-ID: <20230808072252.3229-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 3787MuLc026831
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add keypad driver ducumentation.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 .../bindings/input/sprd-keypad.yaml           | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/sprd-keypad.yaml

diff --git a/Documentation/devicetree/bindings/input/sprd-keypad.yaml b/Documentation/devicetree/bindings/input/sprd-keypad.yaml
new file mode 100644
index 000000000000..51710e1eb389
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/sprd-keypad.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2023 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/sprd-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Device-Tree bindings for GPIO attached keys
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description: |
+    Keypad controller is used to interface a SoC with a matrix-keypad device.
+    The keypad controller supports multiple row and column lines.
+    A key can be placed at each intersection of a unique row and a unique column.
+    The keypad controller can sense a key-press and key-release and report the
+    event using a interrupt to the cpu.
+
+properties:
+    compatible:
+    const: sprd,sc9860-keypad
+
+    reg:
+        maxItems: 1
+
+    interrupts:
+        maxItems: 1
+
+    keypad,num-rows:
+    description: Number of row lines connected to the keypad controller.
+
+    keypad,num-columns:
+    description: Number of column lines connected to the keypad.
+
+    debounce-interval:
+    description:
+        Debouncing interval time in milliseconds. If not specified defaults to 5.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+    default: 5
+
+    linux,keymap:
+    description: An array of packed 1-cell entries containing the equivalent
+        of row, column and linux key-code. The 32-bit big endian cell is packed.
+
+required:
+        - compatible
+        - reg
+        - keypad,num-rows
+        - keypad,num-columns
+        - linux,keymap
+
+unevaluatedProperties: false
+
+
+examples:
+  - |
+	keypad@40250000 {
+		compatible = "sprd,sc9860-keypad";
+		reg = 	<0x40250000 0x1000>;
+		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&aonapb_gate CLK_KPD_EB>,
+			<&aonapb_gate CLK_KPD_RTC_EB>;
+		clock-names = "enable", "rtc";
+		keypad,num-rows= <3>;
+		keypad,num-columns = <3>;
+		debounce-interval = <5>;
+		linux,keymap = < 0x00000001
+				 0x01000002
+				 0x00020003>;
+		status = "okay";
+	};
+...
-- 
2.17.1

