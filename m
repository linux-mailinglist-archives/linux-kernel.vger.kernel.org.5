Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB777B41A7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjI3Pcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjI3Pco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:32:44 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C49EE6;
        Sat, 30 Sep 2023 08:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696087943; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PO+IflfTAql3V+GGvnVr1MW4fk7Y2EOLB+yXPCfXGaKY9llJNy19YW5fwJrMVyqD7B
    lmNSvHM7a3vyFGy21auCz70rBVOmHfcrV/tJfhPQNGKtcoQu3cYqTLaXBZbaHtIAgSwq
    cuW/2d8I81hJJhtW8CAukcNuRqRroq2WLsHYLCHXS7TvNFMdhOcUfArpt4K4OgNlm2G2
    7iQXYgohTgnkgeGq2TLAlyPHyXZMLePG5SYOZCgY/uK4DC2edvqNbxuzTHUcNy5LQhIY
    4+qXe4C7eossLhmG6KZTSUPzQXb5AUYotL5peFi21MJu7jAoQ99/o6ylTCdu0aMBpsgZ
    JnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696087943;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=lUzNzqc8pnjA19u06jBcBi2HrnJlfBUjIE0lrHSoBuU=;
    b=SZovMR2J3GFg4ZaEGZmVEiIfFsn2wxDD8NUZncXW5L1XKnpbnsPgvP02FhUwaY5PRE
    1/GplIw4hoRTjWuAaTmtAkMmctx9thT06Q6IgS43VBbRvON+il6zojGUs5yvWU+Xxdtr
    2gbJ+EP2d2O/IGKzpMejm43kkJM5blQBlwvPIT6JRg6iHqWq5IX29jDy0xamx4GNX7h1
    J7945RaHJORoXAxuO+95u3P3JGOVFUB/B4uwn7+PFbAu8BVjRsiaDuCayFFBUd3gjmpU
    DgpNZyQ3sUR5XnA2SfCDU6Fpjbt+W/Mk+I4PazJJ3y15R/LPwrZkYYKSUxuOVVQdFgQ6
    wDOw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696087943;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=lUzNzqc8pnjA19u06jBcBi2HrnJlfBUjIE0lrHSoBuU=;
    b=N8aOspzkomxdBHfCJb2xiJMnBdmQx9U5aTQLhkn1s/VgFNH5h+hTJKS+BzRjeOS5Z4
    QCbRQH8AHFWPeM6th/UqMLcFUjsOesZvpzrMwvadEw3bYGAbd8kzEy0rWgIogimaB9dg
    bMUFgBJFCQylwhcsvS8yeRwMfkgcIDvxOchf/MBDRh/bilEHtlOcBsUHwC9Gz1I4GNFV
    izi+Y24bCY8a6Y8HpGKexwh2WCTPSBQMUE/2MA1e6Rhqm67f40mtx8ojhWkylolR+QrR
    VXtRIU8a5b4oCPnJHZ5VP64sRsl/fxd6m1Jgq4jbE4RjzzWvJkpZEdAxZCK2jFNWZA+d
    yuXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696087943;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=lUzNzqc8pnjA19u06jBcBi2HrnJlfBUjIE0lrHSoBuU=;
    b=tODsa4OMuslrCCAI7bwyow0oV2U6K2H4jvO3P9G1ANXSgo9ANz/ITGn/cXWjPbSGoZ
    5Yb6gPcdfH21Jcwe22CQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8UFWNtXR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 30 Sep 2023 17:32:23 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Sat, 30 Sep 2023 17:32:00 +0200
Subject: [PATCH v2 1/2] dt-bindings: input: touchscreen: document Himax
 HX852x(ES)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230930-hx852x-v2-1-c5821947b225@gerhold.net>
References: <20230930-hx852x-v2-0-c5821947b225@gerhold.net>
In-Reply-To: <20230930-hx852x-v2-0-c5821947b225@gerhold.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Himax HX852x(ES) is a touch panel controller with optional support
for capacitive touch keys.

Unfortunately, the model naming is quite unclear and confusing. There
seems to be a distinction between models (e.g. HX8526) and the "series"
suffix (e.g. -A, -B, -C, -D, -E, -ES). But this doesn't seem to be
applied very consistently because e.g. HX8527-E(44) actually seems to
belong to the -ES series.

The compatible consists of the actual part number followed by the
"series" as fallback compatible. Typically only the latter will be
interesting for drivers as there is no relevant difference on the
driver side.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/input/touchscreen/himax,hx852es.yaml  | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx852es.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx852es.yaml
new file mode 100644
index 000000000000..40a60880111d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx852es.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/himax,hx852es.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Himax HX852x(ES) touch panel controller
+
+maintainers:
+  - Stephan Gerhold <stephan@gerhold.net>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - himax,hx8525e
+          - himax,hx8526e
+          - himax,hx8527e
+      - const: himax,hx852es
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: Touch Screen Interrupt (TSIX), active low
+
+  reset-gpios:
+    maxItems: 1
+    description: External Reset (XRES), active low
+
+  vcca-supply:
+    description: Analog power supply (VCCA)
+
+  vccd-supply:
+    description: Digital power supply (VCCD)
+
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-swapped-x-y: true
+
+  linux,keycodes:
+    minItems: 1
+    maxItems: 4
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      touchscreen@48 {
+        compatible = "himax,hx8527e", "himax,hx852es";
+        reg = <0x48>;
+        interrupt-parent = <&tlmm>;
+        interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&tlmm 12 GPIO_ACTIVE_LOW>;
+        vcca-supply = <&reg_ts_vcca>;
+        vccd-supply = <&pm8916_l6>;
+        linux,keycodes = <KEY_BACK KEY_HOMEPAGE KEY_APPSELECT>;
+      };
+    };
+
+...

-- 
2.42.0

