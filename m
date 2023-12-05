Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFE7804FE8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346809AbjLEJ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344921AbjLEJza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:55:30 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F143129;
        Tue,  5 Dec 2023 01:55:35 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 50F1B1C058A;
        Tue,  5 Dec 2023 18:46:25 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Damien Le Moal <dlemoal@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Guo Ren <guoren@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Bin Meng <bmeng@tinylab.org>,
        Max Filippov <jcmvbkbc@gmail.com>, Tom Rix <trix@redhat.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Sam Ravnborg <sam@ravnborg.org>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: [DO NOT MERGE v5 12/37] dt-bindings: pci: pci-sh7751: Add SH7751 PCI
Date:   Tue,  5 Dec 2023 18:45:31 +0900
Message-Id: <ca3122511b201a0da0a3f930c0f894bf11954423.1701768028.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1701768028.git.ysato@users.sourceforge.jp>
References: <cover.1701768028.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renesas SH7751 PCI Controller json-schema.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../bindings/pci/renesas,sh7751-pci.yaml      | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml

diff --git a/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml b/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
new file mode 100644
index 000000000000..c71ed56b7210
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/renesas,sh7751-pci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SH7751 PCI Host controller
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,sh7751-pci
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  "#interrupt-cells":
+    const: 1
+
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+  interrupt-controller: true
+
+  renesas,memory:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      PCI BMDMA src/dst memory area.
+
+  renesas,bcr1:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCIBCR1 value. This value makes add the value of BSC's BCR1.
+
+  renesas,mcrmask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCIMCR value. This value makes clear bit in the value of BSC's MCR.
+
+  renesas,intm:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCIINTM value.
+
+  renesas,aintm:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCIIANTM value.
+
+  renesas,lsr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCILSR0 and PCILSR1 values.
+      First word is PCILSR0, Second word is PCILSR1.
+
+  renesas,lar:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCILSA0 and PCILAR1 values.
+      First word is PCILAR0, Second word is PCILAR1.
+
+  renesas,dmabt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCIDMABT value.
+
+  renesas,pintm:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCIPINTM value.
+
+  renesas,config:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      SH7751 PCIC PCICONFIG values array. Register Number and value pair list.
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - interrupt-map
+  - interrupt-map-mask
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pci@fe200000 {
+            compatible = "renesas,sh7751-pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            device_type = "pci";
+            bus-range = <0 0>;
+            ranges = <0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>,
+                     <0x01000000 0 0x00000000 0xfe240000 0 0x00040000>;
+            reg = <0xfe200000 0x0400>,
+                  <0xff800000 0x0100>;
+            interrupt-map = <0x0000 0 0 1 &julianintc 5>,
+                            <0x0000 0 0 2 &julianintc 6>,
+                            <0x0000 0 0 3 &julianintc 7>,
+                            <0x0000 0 0 4 &julianintc 8>,
+                            <0x0800 0 0 1 &julianintc 6>,
+                            <0x0800 0 0 2 &julianintc 7>,
+                            <0x0800 0 0 3 &julianintc 8>,
+                            <0x0800 0 0 4 &julianintc 5>,
+                            <0x1000 0 0 1 &julianintc 7>,
+                            <0x1000 0 0 2 &julianintc 8>,
+                            <0x1000 0 0 3 &julianintc 5>,
+                            <0x1000 0 0 4 &julianintc 6>;
+            interrupt-map-mask = <0x1800 0 0 7>;
+    };
-- 
2.39.2

