Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFD27D5AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344158AbjJXSgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344167AbjJXSgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:36:07 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A0C10DE;
        Tue, 24 Oct 2023 11:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698172554; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ja8T6NxLVZFtwNQxHTqJMik/bXM7QQpGElHC8shWYJlRVqxae/UhM7QTtMQiihod7x
    MPbN7ukblot6tEZV9l8KvvlLJaRp1IFkhwOBqukMB8ErAu4s++WJ6uG5nT7Mx4BC5SR5
    m3A+PQLwmnhCtN/GiZ7ulAywLbvIL9wEGj4qSCTeYgAr7p5VBx3Xlt95EN1S10Kmq7nz
    7v7V5qSofx7aiHyiQfuMmCQYuOs5hQw8HmbHXlf+h5XwHifURZHfDGUCpG4e/FKZA/ZU
    vUpeyCnFlxc9KGwu+KD2/PX18qi/jwIOmH7qRwhK3nHhR2xvK0Ccwy1Ln44mDVhacVS8
    fw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698172554;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=lUzNzqc8pnjA19u06jBcBi2HrnJlfBUjIE0lrHSoBuU=;
    b=DgmDauJ0SUoXAQFFlpfEJ62/Hhhmz6jc85pr7rear0KMMePocOl9Bkmmdn203/2pJV
    43jCJB99AEt8BdUg4DD6+x3AqtQMkeG8JZJap592mj0D6Pnvd/9OYHAac7tSyLSba3Yg
    rb1APRQfRtxobq2BspcpkVxbKB6bEXt4zFTKhqV2j8v3wFvUQg0MInZ1luFk+xk7nTXJ
    bu+xnFWMl7sNFBcVGRAepaun4k0gJHitwLxf3oRFcYaiwI+Jh9nSO+BwTgHAS9jl8NVH
    Os9Ajn39cCS3H0r2av04VKFhGfGzFOX3CDf33GVelf1CoaUawWGJnnKFtLMBwbwdaXax
    p2zw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698172554;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=lUzNzqc8pnjA19u06jBcBi2HrnJlfBUjIE0lrHSoBuU=;
    b=oKDlTZ/XFqSimcl59y2yt7OAFQ3KS49iFG7GwfERLff5ldCBQbhyCmmUcb8+bl3qGz
    GxzHiX4/T/K+TB92ZB/WTePT278ZtM7y8TTccO0zNFB2yYSofUtXfmYWC0K4PT0wP+V9
    hbGVEKDGMRq/CmByMpeLRyZRKDUK5S8GwasylgOlIr5bvgCKYwAaD5ySO+5CHMPnnzCK
    Q4HASkOnaKmSkb9tQEr8tUwQHxpUdKf/fLaByuNCb83R24uxo+eWWEFcDkoayY+1MBKF
    3u/prEMmoRL7njxbgIHpYYcIoF6ykjJvZluu0usisB5gV1/Ih8d8jnb6LtY2JuhsYTMk
    teXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698172554;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=lUzNzqc8pnjA19u06jBcBi2HrnJlfBUjIE0lrHSoBuU=;
    b=fBJsoTi8nmjIJ0YScR3LygOx2BI/VXb/KNrMD/sYk5VP4j+U0QMGkpWeHTweNIbMuQ
    0uzAd3TmASlWrWQ4RiDw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4p39TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id j34a49z9OIZrRxh
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 24 Oct 2023 20:35:53 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 24 Oct 2023 20:35:45 +0200
Subject: [PATCH v3 1/2] dt-bindings: input: touchscreen: document Himax
 HX852x(ES)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-hx852x-v3-1-a1890d3a81e9@gerhold.net>
References: <20231024-hx852x-v3-0-a1890d3a81e9@gerhold.net>
In-Reply-To: <20231024-hx852x-v3-0-a1890d3a81e9@gerhold.net>
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

