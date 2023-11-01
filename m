Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05407DDB4C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376759AbjKAC6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376749AbjKAC6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:58:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643C0F4;
        Tue, 31 Oct 2023 19:58:38 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A12wQnkD944736, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 3A12wQnkD944736
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 10:58:26 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 1 Nov 2023 10:58:25 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 1 Nov 2023 10:58:23 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Wed, 1 Nov 2023 10:58:23 +0800
From:   Tzuyi Chang <tychang@realtek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, TY Chang <tychang@realtek.com>
Subject: [PATCH 2/2] dt-bindings: gpio: realtek: Add realtek,rtd-gpio bindings
Date:   Wed, 1 Nov 2023 10:58:02 +0800
Message-ID: <20231101025802.3744-3-tychang@realtek.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231101025802.3744-1-tychang@realtek.com>
References: <20231101025802.3744-1-tychang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS06.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: license violation
X-KSE-Antivirus-Attachment-Filter-Interceptor-Info: license violation
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree bindings for the Realtek DHC RTD SoCs
GPIO controllers.

Signed-off-by: Tzuyi Chang <tychang@realtek.com>
---
 .../bindings/gpio/realtek,rtd-gpio.yaml       | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml b/Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
new file mode 100644
index 000000000000..6cab7ec50c88
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Realtek Semiconductor Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/realtek,rtd-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC GPIO controller
+
+maintainers:
+  - TY Chang <tychang@realtek.com>
+
+properties:
+  compatible:
+    enum:
+      - realtek,rtd-gpio
+      - realtek,rtd1295-misc-gpio
+      - realtek,rtd1295-iso-gpio
+      - realtek,rtd1395-iso-gpio
+      - realtek,rtd1619-iso-gpio
+
+  reg:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 2
+
+  gpio-ranges: true
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - gpio-ranges
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio@100 {
+      compatible = "realtek,rtd-gpio";
+      reg = <0x100 0x100>,
+            <0x000 0x0b0>;
+      interrupt-parent = <&iso_irq_mux>;
+      interrupts = <19>, <20>;
+      gpio-ranges = <&pinctrl 0 0 82>;
+      gpio-controller;
+      #gpio-cells = <2>;
+    };
-- 
2.42.0

