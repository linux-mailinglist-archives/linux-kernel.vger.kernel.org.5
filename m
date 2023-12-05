Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD65B804FEF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346395AbjLEKM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344981AbjLEJzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:55:31 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D399A116;
        Tue,  5 Dec 2023 01:55:36 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 33C531C0509;
        Tue,  5 Dec 2023 18:46:46 +0900 (JST)
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
Subject: [DO NOT MERGE v5 22/37] dt-bindings: display: smi,sm501: SMI SM501 binding json-schema
Date:   Tue,  5 Dec 2023 18:45:41 +0900
Message-Id: <f671beae8a8ebfd361f4c903bccce713135a169f.1701768028.git.ysato@users.sourceforge.jp>
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

Define SM501 functions and modes.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../bindings/display/smi,sm501.yaml           | 134 ++++++++++++++++++
 include/dt-bindings/display/sm501.h           |  25 ++++
 2 files changed, 159 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/smi,sm501.yaml
 create mode 100644 include/dt-bindings/display/sm501.h

diff --git a/Documentation/devicetree/bindings/display/smi,sm501.yaml b/Documentation/devicetree/bindings/display/smi,sm501.yaml
new file mode 100644
index 000000000000..df46600b8d4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/smi,sm501.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/smi,sm501.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Motion SM501 Mobile Multimedia Companion Chip
+
+maintainers:
+  - Yoshinori Sato <ysato@user.sourceforge.jp>
+
+description: |
+  These DT bindings describe the SM501.
+
+properties:
+  compatible:
+    const:
+      smi,sm501
+
+  reg:
+    maxItems: 2
+    description: |
+     First entry: System Configuration register
+     Second entry: IO space (Display Controller register)
+
+  interrupts:
+    description: SM501 interrupt to the cpu should be described here.
+
+  interrupt-name: true
+
+  mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: select a video mode
+
+  edid:
+    description: |
+      verbatim EDID data block describing attached display.
+      Data from the detailed timing descriptor will be used to
+      program the display controller.
+
+  little-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: available on big endian systems, to set different foreign endian.
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: available on little endian systems, to set different foreign endian.
+
+  swap-fb-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: swap framebuffer byteorder.
+
+  route-crt-panel:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Panel output merge to CRT.
+
+  crt:
+    description: CRT output control
+
+  panel:
+    description: Panel output control
+
+  bpp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Color depth
+
+  smi,flags:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Display control flags.
+
+  smi,devices:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: SM501 device function select.
+
+  smi,mclk:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: mclk frequency.
+
+  smi,m1xclk:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: m1xclk frequency.
+
+  smi,misc-timing:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Miscellaneous Timing reg value.
+
+  smi,misc-control:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Miscellaneous Control reg value.
+
+  smi,gpio-low:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: GPIO0 to 31 Control reg value.
+
+  smi,gpio-high:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: GPIO32 to 63 Control reg value.
+
+  smi,gpio-i2c:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 5
+    description: |
+      GPIO I2C bus number
+      1st field - I2C bus number
+      2nd Field - GPIO SDA
+      3rd Field - GPIO SCL
+      4th Field - Timeout
+      5th Field - udelay
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+
+examples:
+  # MPC5200
+  - |
+    display@1,0 {
+        compatible = "smi,sm501";
+        reg = <0x00000000 0x00800000
+               0x03e00000 0x00200000>;
+        interrupts = <1 1 3>;
+        mode = "640x480-32@60";
+        edid = [00 ff ff ff ff ff ff 00 00 00 00 00 00 00 00 00
+                00 00 01 04 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 f0 0a 80 fb 20 e0 25 10 32 60
+                02 00 00 00 00 00 00 06 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 bd];
+    };
diff --git a/include/dt-bindings/display/sm501.h b/include/dt-bindings/display/sm501.h
new file mode 100644
index 000000000000..1be8490d7635
--- /dev/null
+++ b/include/dt-bindings/display/sm501.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+/* Platform data definitions */
+
+#define SM501FB_FLAG_USE_INIT_MODE	(1<<0)
+#define SM501FB_FLAG_DISABLE_AT_EXIT	(1<<1)
+#define SM501FB_FLAG_USE_HWCURSOR	(1<<2)
+#define SM501FB_FLAG_USE_HWACCEL	(1<<3)
+#define SM501FB_FLAG_PANEL_NO_FPEN	(1<<4)
+#define SM501FB_FLAG_PANEL_NO_VBIASEN	(1<<5)
+#define SM501FB_FLAG_PANEL_INV_FPEN	(1<<6)
+#define SM501FB_FLAG_PANEL_INV_VBIASEN	(1<<7)
+
+#define SM501_USE_USB_HOST	(1<<0)
+#define SM501_USE_USB_SLAVE	(1<<1)
+#define SM501_USE_SSP0		(1<<2)
+#define SM501_USE_SSP1		(1<<3)
+#define SM501_USE_UART0		(1<<4)
+#define SM501_USE_UART1		(1<<5)
+#define SM501_USE_FBACCEL	(1<<6)
+#define SM501_USE_AC97		(1<<7)
+#define SM501_USE_I2S		(1<<8)
+#define SM501_USE_GPIO		(1<<9)
+
+#define SM501_USE_ALL		(0xffffffff)
-- 
2.39.2

