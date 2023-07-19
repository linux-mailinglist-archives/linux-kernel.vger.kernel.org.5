Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515497591A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjGSJaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjGSJaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:30:09 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99782103;
        Wed, 19 Jul 2023 02:29:47 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b95eac836eso2657841fa.3;
        Wed, 19 Jul 2023 02:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689758986; x=1692350986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=764uNe8yZm7sz/GcTw/EAZzTA3A1l6XubAU4wlTqzgY=;
        b=WtyGSSSayNMA5EwsKLHMT7gcUldcLUXSqpGw+KdYui0lh+FIB1vY2k4PXLSduF0GWD
         chr2tTiTNRGg8xrmwtd8oKk+K15fQ1j2X1wn1XtmCkLUU8vqd1vGLvsrXnI8TogNgwIv
         T+gXc+22pY1SLFKH5NuPzFXTTB4aXO3sRUoi9U2u7U9utnnYeVNMQ0fZsDXJ9phvwBqn
         F+cgzCL+lMcQXkil1Sp5LBtrgKHcG+QGv3n6NySnXGp9/0OHfUpo6KGBYDtyiMQ6wgIM
         ObAyKv/iSXGScTTevNB8PvkrylihvPnitmBlj4kdAkXOb0ABy9vbw/Z3JAqgpgVQZ2YA
         DfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689758986; x=1692350986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=764uNe8yZm7sz/GcTw/EAZzTA3A1l6XubAU4wlTqzgY=;
        b=R8wHN2W7qbo1thX71sQXTFxl25Gx33I3T1zqjHzdnlKQNiBWUSdPyRqFo48ByK9tTT
         u9D3BdLdQb8S+BS0/dr4NleyNRt+Q3VJrsc5NpvHTiwtw0PFuBm+SPb1e8C4QASfkEiH
         Za2Viyjnk1afRh0EHX46jB+sffdbH2e9qvrQo0E5JKPgq5MkdSCAhXjG7KUueeXqLsC8
         YVIAT28TSb0rLNwQArQNSUv0Sro05NPpzV+5OOMSoKsr/2QhDPgiiHKZTsSeN0IEPWoz
         w5XXeyXtblXNuM3B7n8ua5GnIyhrC22QSoEmhYJO14oSCEtfHJY2PUFGJ8R9Lc6JRUeE
         hvgg==
X-Gm-Message-State: ABy/qLbH2YO+2CmX+FzvmwRP8/N7Uxo9jzveZiCnHXNQ9Cfhipx95lbt
        vemH3OeZD8vCPoT8k4zPLrn1CoGBym0=
X-Google-Smtp-Source: APBJJlGKKMPrJ5vyhWPYN8A3dKaeAGyaNlSutPhGE3NWvOJfGAshqvIKHYQZekqG5NfAdBumoN63YA==
X-Received: by 2002:a2e:9947:0:b0:2b5:8bb9:4dd6 with SMTP id r7-20020a2e9947000000b002b58bb94dd6mr1469742ljj.12.1689758985835;
        Wed, 19 Jul 2023 02:29:45 -0700 (PDT)
Received: from localhost.localdomain ([86.57.157.184])
        by smtp.gmail.com with ESMTPSA id k12-20020a2ea28c000000b002b839578e56sm966154lja.11.2023.07.19.02.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 02:29:45 -0700 (PDT)
From:   Viktar Simanenka <viteosen@gmail.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Viktar Simanenka <viteosen@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: add vendor-prefixes and bindings for pcd8544 displays
Date:   Wed, 19 Jul 2023 12:29:02 +0300
Message-Id: <20230719092903.316452-1-viteosen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <02704840-ce8b-4f41-f8bf-3f200ca95a10@linaro.org>
References: <02704840-ce8b-4f41-f8bf-3f200ca95a10@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-18 08:35, Krzysztof Kozlowski wrote:
> Bindings are always separate patches.
> Please run scripts/checkpatch.pl and fix reported warnings.

Added vendor-prefix to fix warning.

> > + inverted:
> > +    maxItems: 1
> > +    description: Invert display colors
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.

revised the descriptions and added suitable types according to the
documentation

> Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint.

cleaned up unneccessary fields (leftovers) from tested binding

On 2023-07-18 9:19, Rob Herring wrote:
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date
> Please check and re-submit after running the above command yourself.

upgraded dtschema and found all the warnings. thanks. seems to be fixed

Signed-off-by: Viktar Simanenka <viteosen@gmail.com>
---
 .../bindings/display/philips,pcd8544.yaml     | 89 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/philips,pcd8544.yaml

diff --git a/Documentation/devicetree/bindings/display/philips,pcd8544.yaml b/Documentation/devicetree/bindings/display/philips,pcd8544.yaml
new file mode 100644
index 000000000000..ac880d9d8cc1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/philips,pcd8544.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/philips,pcd8544.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Philips PCD8544 LCD Display Controller
+
+maintainers:
+  - Viktar Simanenka <viteosen@gmail.com>
+
+description: |
+  Philips PCD8544 LCD Display Controller with SPI control bus.
+  Monochrome 84x48 LCD displays, such as Nokia 5110/3310 LCDs.
+  May contain backlight LED.
+
+allOf:
+  - $ref: panel/panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - philips,pcd8544
+
+  dc-gpios:
+    maxItems: 1
+    description: Data/Command selection pin (D/CX)
+
+  reset-gpios:
+    maxItems: 1
+    description: Display Reset pin (RST)
+
+  philips,inverted:
+    type: boolean
+    description: Display color inversion
+
+  philips,voltage-op:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 127
+    description: Display liquid crystal operation voltage
+
+  philips,bias:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    description: Display bias voltage system value
+
+  philips,temperature-coeff:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+    description: Display temperature compensation coefficient
+
+required:
+  - compatible
+  - reg
+  - dc-gpios
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "philips,pcd8544";
+            spi-max-frequency = <8000000>;
+            reg = <0>;
+
+            dc-gpios = <&pio 0 3 GPIO_ACTIVE_HIGH>; /* DC=PA3 */
+            reset-gpios = <&pio 0 1 GPIO_ACTIVE_HIGH>; /* RESET=PA1 */
+            backlight = <&backlight>;
+
+            philips,inverted;
+            philips,voltage-op = <0>;
+            philips,bias = <4>;
+            philips,temperature-coeff = <0>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index af60bf1a6664..0c3844af6776 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1037,6 +1037,8 @@ patternProperties:
     description: Pervasive Displays, Inc.
   "^phicomm,.*":
     description: PHICOMM Co., Ltd.
+  "^philips,.*":
+    description: Koninklijke Philips N.V.
   "^phytec,.*":
     description: PHYTEC Messtechnik GmbH
   "^picochip,.*":
-- 
2.34.1

