Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962C27774A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjHJJet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjHJJeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:34:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A55610C0;
        Thu, 10 Aug 2023 02:34:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-997c4107d62so103771066b.0;
        Thu, 10 Aug 2023 02:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691660081; x=1692264881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1nIqINdHQXrWillK3v85OXlqyDwWxqm0ousdEBN4jxg=;
        b=SGh6KAh7ORHSUgE0+PQrbdYxkHqA2i106PGHnDMeoolJF5HzAgIARLVFtJiquzOjZY
         RqbcqOCXmp2OPZeKGc9ZL6ygmk+E0m2OOPFYUn94GmfT7bqWhXo62jsXq2Rfh+yOWVuY
         qg3Zx6KElUAlBa6Qp4AXBfHLGPzIAM17Qcl+3KSxBNG9fon0+VzHFIgfYOOplM8baDs6
         LJI4JnJITv8gTH9scvqMtB+YFu8PDbR5HszDjFhQQ7j4K6rXdFScmi/bQnROwm2SSvEi
         3T272bSnsiE/N1/3WZSx7HamveV7SfTLjTkywFfLVgzpNm7ze5MwxoahK2oi0vD/68dH
         aF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691660081; x=1692264881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nIqINdHQXrWillK3v85OXlqyDwWxqm0ousdEBN4jxg=;
        b=iHgDca+J7ctRhvruyOHFGOku4P7T1GUa5QpI23mZ66jvpxO5wBr2/IxjHtlJvhjzHs
         2WebLz2h5Y4p9GR1vfJ5j1L/xgtaMelyyfdCI7a3RAA6Zo2EaaC9dZircq8HV8rygA21
         KbjBAs6+sr7nlPXYjptFgwcocJCnp7xgN1n6ZpicxTVaYBaHufkMgFNv8RzY2w9E5Df0
         DF2+798weu/yZeMnbrzBX4uZcg/yRMHziqYjYM1v7fcvCbQ2yOF5R6XyH5gtojGUu445
         iuNdlZH4YdHQ6iGJGYS02FnZqBeJqr6G3L5c24G/NP3PolSKFGhqaNnXtVQkDalSGo2Z
         LL3g==
X-Gm-Message-State: AOJu0YyaOlESPJ0NZnepZrUtFD38zkkQmKhMQ5rbrgbXk0iMnRs37iS1
        f4hfd4vUh7X7M2pP1aYlm6s=
X-Google-Smtp-Source: AGHT+IEro+eV6orOS+w8/d3tF7IJMBWmhauNFp7qXFHLllH2RIySnF9Rh8TDdJCorldmYkQ+Lnz59Q==
X-Received: by 2002:a17:906:3d21:b0:99b:dea3:8d44 with SMTP id l1-20020a1709063d2100b0099bdea38d44mr1541329ejf.71.1691660081158;
        Thu, 10 Aug 2023 02:34:41 -0700 (PDT)
Received: from localhost.localdomain ([83.103.132.21])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709062dc800b0099b7276235esm673192eji.93.2023.08.10.02.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:34:40 -0700 (PDT)
From:   Dumitru Ceclan <mitrutzceclan@gmail.com>
To:     mitrutzceclan@gmail.com
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: adc: add AD717X
Date:   Thu, 10 Aug 2023 12:33:16 +0300
Message-Id: <20230810093322.593259-1-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD717x family offer a complete integrated Sigma-Delta ADC solution
which can be used in high precision, low noise single channel
applications or higher speed multiplexed applications. The Sigma-Delta
ADC is intended primarily for measurement of signals close to DC but also
delivers outstanding performance with input bandwidths out to ~10kHz.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 .../bindings/iio/adc/adi,ad717x.yaml          | 158 ++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad717x.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad717x.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad717x.yaml
new file mode 100644
index 000000000000..f12926e69958
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad717x.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad717x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD717X ADC family SPI driver
+
+maintainers:
+  - Ceclan Dumitru <dumitru.ceclan@analog.com>
+
+description: |
+  Bindings for the Analog Devices AD717X ADC's. Datasheets for supported chips:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-2.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7173-8.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7175-2.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7176-2.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7172-2
+      - adi,ad7173-8
+      - adi,ad7175-2
+      - adi,ad7176-2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  spi-cpol:
+    type: boolean
+
+  spi-cpha:
+    type: boolean
+
+  adi,temp-channel:
+    description:
+      Enables temperature reading channel
+    type: boolean
+
+  dependencies:
+    adi,temp-channel:
+      compatible:
+        enum:
+          - adi,ad7172-2
+          - adi,ad7173-8
+          - adi,ad7175-2
+
+
+  required:
+    - compatible
+    - reg
+    - interrupts
+    - spi-cpol
+    - spi-cpha
+
+patternProperties:
+  "^channel@([0-9a-f])$":
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: Channel number
+        minimum: 0
+        maximum: 15
+
+      diff-channels:
+        description:
+          Analog input pins
+        items:
+          minimum: 0
+          maximum: 31
+      
+      adi,bipolar:
+        description: Specify if the channel should measure in bipolar mode.
+        type: boolean
+
+    required:
+      - reg
+      - diff-channels
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+      status = "okay";
+
+      ad7173@0 {
+        compatible = "adi,ad7173-8";
+        reg = <0>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-parent = <&gpio>;
+        spi-max-frequency = <5000000>;
+        spi-cpol;
+        spi-cpha;
+
+        adi,temp-channel;
+
+        channel@0 {
+          reg = <0>;
+          adi,bipolar;
+
+          diff-channels = <0 1>;
+        };
+
+        channel@1 {
+          reg = <1>;
+
+          diff-channels = <2 3>;
+        };
+
+        channel@2 {
+          reg = <2>;
+          adi,bipolar;
+
+          diff-channels = <4 5>;
+        };
+
+        channel@3 {
+          reg = <3>;
+          adi,bipolar;
+
+          diff-channels = <6 7>;
+        };
+
+        channel@4 {
+          reg = <4>;
+
+          diff-channels = <8 9>;
+        };
+      };
+    };
-- 
2.30.2

