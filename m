Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4627C9676
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 23:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjJNVNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 17:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjJNVND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 17:13:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB86FD6;
        Sat, 14 Oct 2023 14:13:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50435ad51bbso4103185e87.2;
        Sat, 14 Oct 2023 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697317979; x=1697922779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJuOgt3q5HcDZrUvx1eiynZ1+P6CZ2zG/3oG/9FluxU=;
        b=l43NzB74BwNjd0g0EknT740CDTiHYy6J+OlN001SGZ9euOoxzZpgPpd+qMypvKD7FI
         K7SBNIFmctZfFZUKXYpq80TjpashojJYLWsRARdQv21QTg/SMXTzEzpLkAAH8c5QqtlP
         15yWOa+x8tD2deXV2L9VEsKvbDP8j4CG0ACZRSLk0l2N5gSMKHhjnEeNPNO9axzC1X05
         sygZFdZpT8R95ZhP4up0k0TDKrniYv66Ufyx27SqjzQdRpoboOrr8CV7rRuBngaiN+Cc
         mYVECX6M40mEmLkQGQd4NC5LVv1ACWCuoH6+SqMbllNqhJztI7qBJtoWayQZIOzOOYg1
         ofeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697317979; x=1697922779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJuOgt3q5HcDZrUvx1eiynZ1+P6CZ2zG/3oG/9FluxU=;
        b=fChltFkXIpuTzP7o+QsyAz09+NjlyfAoJsh1KPTV/0PxT2pVRT82LZGeyAFKcMS3pf
         W5b6ioRKhEfBjoOhYimkGy5yUcxGr+SB1WDA4kgha/lCiywb+dPDnIxQ+Na38CYmLvOd
         BY2NIUsf1jmbZv48PLcaZdNFAyTsxMsuEPRNj+GmCfaSaCL/odQwyWE9NuddqqeeDILe
         UOS87+f+8cjaYQLy8ObbtMzaFzVe6bsZohQBniYUryKRsPEVNAwj+M8ozNAVkk/8uFNh
         VOcDRk0C/bSyyhRQN8FEAjMYjGpeTuu8OxPLFm7mmMyVqmzkjjxX7Y/plrh5NvhqMsIL
         5/2g==
X-Gm-Message-State: AOJu0YwSRlWObaFdrMgeOy2NqLI6jbyYWXUM0wCEPdcIl/8V6yVBY8EV
        6ehTSFBA/oEadVPE+0FjuNI=
X-Google-Smtp-Source: AGHT+IERGuljfrVvKKeO6a5Ryhqh62xtOe8gWzADmEc/5xJ22EfFyrWKLdvEQOCTxKXCBdN+HneGfg==
X-Received: by 2002:a19:f516:0:b0:4fe:19ef:8791 with SMTP id j22-20020a19f516000000b004fe19ef8791mr22929664lfb.38.1697317978784;
        Sat, 14 Oct 2023 14:12:58 -0700 (PDT)
Received: from fr.lan ([46.31.31.132])
        by smtp.googlemail.com with ESMTPSA id g3-20020a056512118300b00507a9b2eff4sm78759lfr.22.2023.10.14.14.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 14:12:58 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH v6 1/2] dt-bindings: adc: provide max34408/9 device tree binding document
Date:   Sun, 15 Oct 2023 00:12:53 +0300
Message-ID: <20231014211254.16719-2-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231014211254.16719-1-fr0st61te@gmail.com>
References: <20231014211254.16719-1-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware binding for i2c current monitoring device with overcurrent
control.

Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
---
 .../bindings/iio/adc/maxim,max34408.yaml      | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
new file mode 100644
index 000000000000..4cba856e8d47
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX34408/MAX34409 current monitors with overcurrent control
+
+maintainers:
+  - Ivan Mikhaylov <fr0st61te@gmail.com>
+
+description: |
+  The MAX34408/MAX34409 are two- and four-channel current monitors that are
+  configured and monitored with a standard I2C/SMBus serial interface. Each
+  unidirectional current sensor offers precision high-side operation with a
+  low full-scale sense voltage. The devices automatically sequence through
+  two or four channels and collect the current-sense samples and average them
+  to reduce the effect of impulse noise. The raw ADC samples are compared to
+  user-programmable digital thresholds to indicate overcurrent conditions.
+  Overcurrent conditions trigger a hardware output to provide an immediate
+  indication to shut down any necessary external circuitry.
+
+  Specifications about the devices can be found at:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max34408
+      - maxim,max34409
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  powerdown-gpios:
+    description:
+      Shutdown Output. Open-drain output. This output transitions to high impedance
+      when any of the digital comparator thresholds are exceeded as long as the ENA
+      pin is high.
+    maxItems: 1
+
+  powerdown-status-gpios:
+    description:
+      SHTDN Enable Input. CMOS digital input. Connect to GND to clear the latch and
+      unconditionally deassert (force low) the SHTDN output and reset the shutdown
+      delay. Connect to VDD to enable normal latch operation of the SHTDN output.
+    maxItems: 1
+
+  vdd-supply: true
+
+patternProperties:
+  "^channel@[0-3]$":
+    $ref: adc.yaml
+    type: object
+    description:
+      Represents the internal channels of the ADC.
+
+    properties:
+      reg:
+        items:
+          - minimum: 0
+            maximum: 3
+
+      maxim,rsense-val-micro-ohms:
+        description:
+          Adjust the Rsense value to monitor higher or lower current levels for
+          input.
+        enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
+        default: 1000
+
+    required:
+      - reg
+      - maxim,rsense-val-micro-ohms
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: maxim,max34408
+    then:
+      patternProperties:
+        "^channel@[2-3]$": false
+        "^channel@[0-1]$":
+          properties:
+            reg:
+              maximum: 1
+    else:
+      patternProperties:
+        "^channel@[0-3]$":
+          properties:
+            reg:
+              maximum: 3
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@1e {
+              compatible = "maxim,max34409";
+              reg = <0x1e>;
+              powerdown-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+              powerdown-status-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
+
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              channel@0 {
+                  reg = <0x0>;
+                  maxim,rsense-val-micro-ohms = <5000>;
+              };
+
+              channel@1 {
+                  reg = <0x1>;
+                  maxim,rsense-val-micro-ohms = <10000>;
+             };
+        };
+    };
-- 
2.42.0

