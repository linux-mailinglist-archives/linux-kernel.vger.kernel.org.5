Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AB479E931
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240906AbjIMN0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240894AbjIMNZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:25:59 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F9519B1;
        Wed, 13 Sep 2023 06:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694611536; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tkzEkwOeUJv01yURRHeHIyGOGiqqaVxQu0qqmT/jCdHQ29Hu6bm9sCXD6+nSLrTwOk
    ciL7n6TuOj1FFviCOkFBBICNy/CWPfEr8LrEMScSzBJlgJL7mhOUI6VesexpZ51U1Vd0
    O1R+YiIbv4hXpYAWG9ZYCF1+IaCUSYTv71kMJg01fT33JORbJihtiDIGreXyrTP+yeg0
    8UVaxnDEBRfeJ7YjmxomiYcxYM4I0H6QPgg3mMaZPPyJ8ekFKl0LlUhbFf5XAvqeev5Q
    Txp3oWpU9/UbtvBTLUGzjv+hYcmf4z9mtVq47yA7knBKAOwBGA+5TNc6wOXzGM4j1577
    hBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694611536;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=RNAMCrasnlj8D5Pdrv0GTCtXqUlEz1t4mDDn9whPJsY=;
    b=EAJycT8/1+UKTqr0qGmdbHFKArVZnuhBj1IHL5zrgOFp9iAmuLjidp0/T0qbNqaqTm
    l4JoVrafT9wCdYzxamweOZvtAOtiBjiF85GmninS063k3l2p1HNoklEvjAckYzRyLSGc
    B/s1fZkTPD0TuC8gEjQcsoavCU1h3oNKi4ga81I0DlgxlFSPwzjmemrB2zifiEde3rZ6
    uIroX8A9OErYNg54wTho/nKspFYe17aoeN7c8ZGDuck/i4aZSxzP7H4zQ/1UFmkAz/3c
    /4ur9v0qCuqtrzkVqzwK1u7Dba215Q/HSqFAChjTGuM1tlR/002551AYOg4pkjysF0pz
    MZHw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694611536;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=RNAMCrasnlj8D5Pdrv0GTCtXqUlEz1t4mDDn9whPJsY=;
    b=g8x9acdvYy7pbGzbT960W4gX8wAXbkTXJN/9Ec4Mj8dK+xxbEUthLOSd7+HGMLrdfd
    0X4IBGIgx0zUXeLkP3Vgj03LQjt87ne2XnyMXgmiq4oEIRPjz+t1mPyMoId1pG50tKmB
    38sx0zpQ0TwTlFSdLxghzr/jBTdivWp176am56NVSkiq2xYOsC3HotZL8+Qs2AcZRh5l
    ZfzFhgperC5nN+YO6JXDa91wIMS1eLyshIXWci9hysrbYtcyBwhRBAi17Ci41fIuyTgg
    hPCoH/55b+/z5BG75cg3AqIbo1QR/IlEpcGNOSsjLhHnqUEGiIj3FS13s0f3Fvfvynuo
    /GLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694611536;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=RNAMCrasnlj8D5Pdrv0GTCtXqUlEz1t4mDDn9whPJsY=;
    b=o/tbulxC7hYOK9mNZArot+/7esmjhA7cSc3Or8CUfRkN0BwJ/3VCPFS1RUMny8gH+R
    v5BbMIakRQ68Ah5anlCw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4p3mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id xb560bz8DDPZuEI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 13 Sep 2023 15:25:35 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 13 Sep 2023 15:25:29 +0200
Subject: [PATCH 1/2] dt-bindings: input: touchscreen: document Himax
 HX852x(ES)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230913-hx852x-v1-1-9c1ebff536eb@gerhold.net>
References: <20230913-hx852x-v1-0-9c1ebff536eb@gerhold.net>
In-Reply-To: <20230913-hx852x-v1-0-9c1ebff536eb@gerhold.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
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

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/input/touchscreen/himax,hx852es.yaml  | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx852es.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx852es.yaml
new file mode 100644
index 000000000000..4ca43d7202eb
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
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
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

