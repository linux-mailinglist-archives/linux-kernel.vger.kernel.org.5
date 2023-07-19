Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C2E759978
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjGSPWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjGSPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:22:04 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6981CC1;
        Wed, 19 Jul 2023 08:22:02 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id B481B1C0006;
        Wed, 19 Jul 2023 15:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689780121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99wH+vey50DngufvBEte5SfRinX7I5E5R5JRlIDEi1s=;
        b=U9DkZbPDgqJw5yvQZnLPqRpyfLrpUQV3Tuckf19C7rBPjMvtD5TWzeSh7/y7a/BGEHYqrv
        qxVjrZV76FMvhtYwLMfxPTOsWPpTsPJyTQQAHyMZlCLZ+gqWk7NQO4iU6Hyzrn4qDLggTT
        Xx1USkh+ftS/34NfF8rztyErvPYrBZK2Bamk+w/gNOLZsednmEbIRY32MBfIsKojEBdbSS
        E0iuBzgcMSQF6PAzfZjCkJEClSB9wKACCZaqET40hFfIzvBYyyF8uymvoG5Ml874Urvx0z
        rX56v9HyN0G7sArJwwLYAlpc8YQF028V3uD+B8eDszArWgleLnw+uNR99fxcnA==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 2/3] dt-bindings: display: panel: Add panels based on ILITEK ILI9806E
Date:   Wed, 19 Jul 2023 17:21:46 +0200
Message-Id: <20230719152147.355486-2-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719152147.355486-1-luca.ceresoli@bootlin.com>
References: <20230719152147.355486-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for LCD panels based on the ILITEK ILI9806E RGB controller
connected over SPI and the "ShenZhen New Display Co NDS040480800-V3"
480x800 panel based on it.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 .../display/panel/ilitek,ili9806e.yaml        | 69 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
new file mode 100644
index 000000000000..42abc6923065
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9806e.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ILI9806E display panels
+
+maintainers:
+  - Luca Ceresoli <luca.ceresoli@bootlin.com>
+
+description:
+  This binding is for display panels using an Ilitek ILI9806E controller in
+  SPI mode.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          # ShenZhen New Display Co 3.97" 480x800 RGB a-SI TFT LCD
+          - newdisplay,nds040480800-v3
+      - const: ilitek,ili9806e
+
+  reg: true
+  spi-max-frequency: true
+  reset-gpios: true
+  backlight: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    backlight: backlight {
+        compatible = "gpio-backlight";
+        gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+    };
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "newdisplay,nds040480800-v3", "ilitek,ili9806e";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_lcdgpios>;
+            reset-gpios = <&gpio 26 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
+
+            port {
+                ili9806e_in: endpoint {
+                    remote-endpoint = <&lcdif_out>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index aee340630eca..3c38699ee821 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6515,6 +6515,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/ilitek,ili9486.yaml
 F:	drivers/gpu/drm/tiny/ili9486.c
 
+DRM DRIVER FOR ILITEK ILI9806E PANELS
+M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
+
 DRM DRIVER FOR JADARD JD9365DA-H3 MIPI-DSI LCD PANELS
 M:	Jagan Teki <jagan@edgeble.ai>
 S:	Maintained
-- 
2.34.1

