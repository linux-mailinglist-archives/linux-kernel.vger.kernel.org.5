Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D227A804FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjLEKMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344941AbjLEJza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:55:30 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36193135;
        Tue,  5 Dec 2023 01:55:36 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id C45C01C05EE;
        Tue,  5 Dec 2023 18:46:35 +0900 (JST)
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
Subject: [DO NOT MERGE v5 17/37] dt-bindings: interrupt-controller: renesas,sh7751-intc: Add json-schema
Date:   Tue,  5 Dec 2023 18:45:36 +0900
Message-Id: <1fafcf1c70ee4e38847bac1379bcb4555a237505.1701768028.git.ysato@users.sourceforge.jp>
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

Renesas SH7751 INTC json-schema.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../renesas,sh7751-intc.yaml                  | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
new file mode 100644
index 000000000000..9d05c10f5c32
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/renesas,sh7751-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SH7751 Interrupt Controller
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+properties:
+  compatible:
+    items:
+      - const: renesas,sh7751-intc
+
+  '#interrupt-cells':
+    const: 1
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: ICR
+      - const: INTPRI00
+
+  renesas,icr-irlm:
+    type: boolean
+    description: If true ICR.IRLM=1
+
+  renesas,ipr-map:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      IRQ to IPR mapping definition.
+      1st - INTEVT
+      2nd - Register
+      3rd - bit index
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - reg
+  - reg-names
+  - renesas,ipr-map
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/sh_intc.h>
+    shintc: interrupt-controller@ffd00000 {
+            compatible = "renesas,sh7751-intc";
+            #interrupt-cells = <1>;
+            interrupt-controller;
+            reg = <0xffd00000 14>, <0xfe080000 128>;
+            reg-names = "ICR", "INTPRI00";
+            renesas,ipr-map = <0x240 IPRD IPR_B12>, /* IRL0 */
+                              <0x2a0 IPRD IPR_B8>,  /* IRL1 */
+                              <0x300 IPRD IPR_B4>,  /* IRL2 */
+                              <0x360 IPRD IPR_B0>,  /* IRL3 */
+                              <0x400 IPRA IPR_B12>, /* TMU0 */
+                              <0x420 IPRA IPR_B8>,  /* TMU1 */
+                              <0x440 IPRA IPR_B4>,  /* TMU2 TNUI */
+                              <0x460 IPRA IPR_B4>,  /* TMU2 TICPI */
+                              <0x480 IPRA IPR_B0>,  /* RTC ATI */
+                              <0x4a0 IPRA IPR_B0>,  /* RTC PRI */
+                              <0x4c0 IPRA IPR_B0>,  /* RTC CUI */
+                              <0x4e0 IPRB IPR_B4>,  /* SCI ERI */
+                              <0x500 IPRB IPR_B4>,  /* SCI RXI */
+                              <0x520 IPRB IPR_B4>,  /* SCI TXI */
+                              <0x540 IPRB IPR_B4>,  /* SCI TEI */
+                              <0x560 IPRB IPR_B12>, /* WDT */
+                              <0x580 IPRB IPR_B8>,  /* REF RCMI */
+                              <0x5a0 IPRB IPR_B4>,  /* REF ROVI */
+                              <0x600 IPRC IPR_B0>,  /* H-UDI */
+                              <0x620 IPRC IPR_B12>, /* GPIO */
+                              <0x640 IPRC IPR_B8>,  /* DMAC DMTE0 */
+                              <0x660 IPRC IPR_B8>,  /* DMAC DMTE1 */
+                              <0x680 IPRC IPR_B8>,  /* DMAC DMTE2 */
+                              <0x6a0 IPRC IPR_B8>,  /* DMAC DMTE3 */
+                              <0x6c0 IPRC IPR_B8>,  /* DMAC DMAE */
+                              <0x700 IPRC IPR_B4>,  /* SCIF ERI */
+                              <0x720 IPRC IPR_B4>,  /* SCIF RXI */
+                              <0x740 IPRC IPR_B4>,  /* SCIF BRI */
+                              <0x760 IPRC IPR_B4>,  /* SCIF TXI */
+                              <0x780 IPRC IPR_B8>,  /* DMAC DMTE4 */
+                              <0x7a0 IPRC IPR_B8>,  /* DMAC DMTE5 */
+                              <0x7c0 IPRC IPR_B8>,  /* DMAC DMTE6 */
+                              <0x7e0 IPRC IPR_B8>,  /* DMAC DMTE7 */
+                              <0xa00 INTPRI00 IPR_B0>,      /* PCIC PCISERR */
+                              <0xa20 INTPRI00 IPR_B4>,      /* PCIC PCIDMA3 */
+                              <0xa40 INTPRI00 IPR_B4>,      /* PCIC PCIDMA2 */
+                              <0xa60 INTPRI00 IPR_B4>,      /* PCIC PCIDMA1 */
+                              <0xa80 INTPRI00 IPR_B4>,      /* PCIC PCIDMA0 */
+                              <0xaa0 INTPRI00 IPR_B4>,      /* PCIC PCIPWON */
+                              <0xac0 INTPRI00 IPR_B4>,      /* PCIC PCIPWDWN */
+                              <0xae0 INTPRI00 IPR_B4>,      /* PCIC PCIERR */
+                              <0xb00 INTPRI00 IPR_B8>,      /* TMU3 */
+                              <0xb80 INTPRI00 IPR_B12>;     /* TMU4 */
+    };
+...
-- 
2.39.2

