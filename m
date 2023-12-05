Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24670804F28
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376599AbjLEJzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344899AbjLEJz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:55:28 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B957B2;
        Tue,  5 Dec 2023 01:55:34 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 8F90A1C077B;
        Tue,  5 Dec 2023 18:46:58 +0900 (JST)
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
Subject: [DO NOT MERGE v5 28/37] dt-bindings: soc: renesas: sh: Add SH7751 based target
Date:   Tue,  5 Dec 2023 18:45:47 +0900
Message-Id: <b2efb46abb08084d29598328b1e3070fb4cf3700.1701768028.git.ysato@users.sourceforge.jp>
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

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../devicetree/bindings/soc/renesas/sh.yaml   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/sh.yaml

diff --git a/Documentation/devicetree/bindings/soc/renesas/sh.yaml b/Documentation/devicetree/bindings/soc/renesas/sh.yaml
new file mode 100644
index 000000000000..3fbff2532ad3
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/renesas/sh.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/renesas/sh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SuperH Platform
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: RTS7751R2D Plus
+        items:
+          - enum:
+              - renesas,rts7751r2d # Renesas SH4 2D graphics board
+          - const: renesas,sh7751r
+
+      - description: Julian board
+        items:
+          - enum:
+              - iodata,landisk  # LANDISK HDL-U
+              - iodata,usl-5p   # USL-5P
+          - const: renesas,sh7751r
+
+additionalProperties: true
+
+...
-- 
2.39.2

