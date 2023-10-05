Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FE27BA988
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjJES4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjJESz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:55:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039179B;
        Thu,  5 Oct 2023 11:55:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50435ad51bbso1686912e87.2;
        Thu, 05 Oct 2023 11:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696532153; x=1697136953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W67NqH9c8zeb7HC14GCOy1jZno6eL79OOZCnPnFozWo=;
        b=fVBUtrrRZBDcLMpfLbzaCIXwp4cRr5ROZot8HY0BNDjOtPO+m9o+wEui233bsZf/Ww
         F4u0DWvmERwiGs2dWya8vSB71dXxWlBfDXy/PfLqDTMt9hiHRQQvx9dz82Y1+Em+KTsi
         r1cKJCKjMqmRbsbqyLp2tyKIirkFXua3Rd2BKTT/Is9T+FEvukkuExf/5c3x1La7e/ST
         uNBDJ1/qt9TdTau88SJiLVW1JOkA0E3+6BcD4V2s1h8HoXfs525oyS+Xd/bfGaoXXgof
         95jqiOPiX2h0SJRSaa2Hr5PHU39iRjAycwDc/jmFD21o2jGhHI3CtjHHF5uaN2TF+1hi
         Hvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696532153; x=1697136953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W67NqH9c8zeb7HC14GCOy1jZno6eL79OOZCnPnFozWo=;
        b=IbMD/wi605mV9BAqtP5+0h1/14dbs7zIZxuTRC5MO8rxn2Bl8GAmzI8fjFzuHc5zbK
         MWdKCunCToejmxY9NC9hpyFNznYPkuNzIaSKG/HnwQ6kBOs8dZ49oA/aXINc5oDv87Ax
         +h/BLVCDW9ZaGKssBE5K5l3MSdiQQZzD/waDd2SzckRhkltLy+KRbJWe7S9v181GdiRi
         klgl2epkutdgLMk08o92lYvZlORg2lsSa7ysuwErX2COryUXhfm51/AxbOyW/8tbynlU
         p4CDIcFi4B3nBFBO+BOkGrd/JgtEcJJfyRUvTvmlK+g9LyfCOk/cnKTwRB07psWaLMGt
         aqew==
X-Gm-Message-State: AOJu0YzuCoR8UV6IC9wWh0xxvvVpgdHVWJE1Xrwg/P8J0WgWB7FTrnRo
        /ZCyS+7ifrONmGUnrxbz4qyJMNmm9eWX0tf+
X-Google-Smtp-Source: AGHT+IE273ZU58hTX3fzcFP+u/5LTHAHOayTqd5BwlJ13vCU1g0gSyyLBl3CoyPb4eeW+cC8F3jxWg==
X-Received: by 2002:a05:6512:2396:b0:500:8fcd:c3b5 with SMTP id c22-20020a056512239600b005008fcdc3b5mr7314730lfv.12.1696532153008;
        Thu, 05 Oct 2023 11:55:53 -0700 (PDT)
Received: from fr.lan ([46.31.31.132])
        by smtp.googlemail.com with ESMTPSA id q1-20020ac246e1000000b004fe48d0b639sm402341lfo.83.2023.10.05.11.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:55:52 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: adc: provide max34408/9 device tree binding document
Date:   Thu,  5 Oct 2023 21:55:36 +0300
Message-ID: <20231005185537.32267-2-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005185537.32267-1-fr0st61te@gmail.com>
References: <20231005185537.32267-1-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware binding for i2c current monitoring device with overcurrent
control.

Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
---
 .../bindings/iio/adc/maxim,max34408.yaml      | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
new file mode 100644
index 000000000000..4262bedb4bfa
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Two- and four-channel current monitors with overcurrent control
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
+  shutdown-gpios:
+    description:
+      Shutdown Output. Open-drain output. This output transitions to high impedance
+      when any of the digital comparator thresholds are exceeded as long as the ENA
+      pin is high.
+    maxItems: 1
+
+  shtdn-enable-gpios:
+    description:
+      SHTDN Enable Input. CMOS digital input. Connect to GND to clear the latch and
+      unconditionally deassert (force low) the SHTDN output and reset the shutdown
+      delay. Connect to VDD to enable normal latch operation of the SHTDN output.
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
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
+          minimum: 0
+          maximum: 3
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
+              minimum: 0
+              maximum: 1
+    else:
+      patternProperties:
+        "^channel@[0-3]$":
+          properties:
+            reg:
+              minimum: 0
+              maximum: 3
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@1e {
+              compatible = "maxim,max34409";
+              reg = <0x1e>;
+
+              #address-cells = <1>;
+              #size-cells = <0>;
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

