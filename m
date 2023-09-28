Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F557B1D18
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjI1Mzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjI1Mzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:55:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAC31A1;
        Thu, 28 Sep 2023 05:55:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b2b53e17feso402534566b.3;
        Thu, 28 Sep 2023 05:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695905746; x=1696510546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IjmABsbUI05o+ZavzLjhEq7Z627HD3chbAFdNF0zJvg=;
        b=TTkMQLk3I9njcpf5hQueq9cEVDSpBsxvD8SLqRsJd5tnzvMFx5Hm9Fvm6x6ydx7OkU
         U9NXh3dzbxO2ybpQHySKW/doHH/wCJI1UqmJYT6ckEF1DpB4mvifFVbmePirP/7qhrln
         J/UBY8Xj76jcB3ZBnDPkLtpncsi7K4XA1eBFHewnpN6K3vMTIfXf1DLPCTbN4nJl+r76
         fOdN7s+72pndChPOpSWAIffVbymUGXBxKIV91zmvplOhYNjNOnPrZzDQaFJSG3RsqfhW
         fzVGGrQ4YaG5cWn+PqzPDiDazV+jJwPPqO2+3KpkiYZ37Z/4rWfkolKAhY2X3TwIWD9w
         k1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695905746; x=1696510546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjmABsbUI05o+ZavzLjhEq7Z627HD3chbAFdNF0zJvg=;
        b=PMzsaP8dpWqd83tbS+Sa0XOU02hEzAqkTeB9bSKpeuZY49rZpuEwNfGNYQWCcAh6XR
         wPgSsC7A8UwjDNvXfvzVfro0bJ3xjWR2V8L8e+ljgIiQmHQ6xFWpcMM+XzaOlvnOCQaX
         8PFHZ2sMc41VEL1gbjPRrEsUoCVzXcZcC6G+2nemnQuZDYOsIE4d6ENNHRNN2KYz9Ru8
         euGckHnzm1hRAnPIM7XZd0W8ON21xBmu5uTGXS3zqPl7Gl8Pl1oIzpieAuq1AHLMpWc5
         nTzOfQZj1FHUCtjAfyezVCgCXYlV9GH0irdpg7erqQ93tzBMzFqp16ShpsWEWrol1ZBr
         ySgg==
X-Gm-Message-State: AOJu0YyeHe8rWVEeng62SOr728rsmWIaBsndJvA2FIzpSecAfD/TIC2v
        B9l9JySpB2uW8N0fx/6zqXQ=
X-Google-Smtp-Source: AGHT+IFtNeoLNoLDkcr4QfSp2qY6+buxJfNcj8i4yaqq92Ic2jUBbdQN9m3MHm3/F3W0nNO0K0Rvbw==
X-Received: by 2002:a17:907:2e01:b0:9b0:169b:eee2 with SMTP id ig1-20020a1709072e0100b009b0169beee2mr1078693ejc.10.1695905745460;
        Thu, 28 Sep 2023 05:55:45 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id p26-20020a170906229a00b009ad8338aafasm11027787eja.13.2023.09.28.05.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:55:44 -0700 (PDT)
From:   Dumitru Ceclan <mitrutzceclan@gmail.com>
To:     mitrutzceclan@gmail.com
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: adc: add AD7173
Date:   Thu, 28 Sep 2023 15:54:42 +0300
Message-Id: <20230928125443.615006-1-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.39.2
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

The AD7173 family offer a complete integrated Sigma-Delta ADC solution
which can be used in high precision, low noise single channel applications
or higher speed multiplexed applications. The Sigma-Delta ADC is intended
primarily for measurement of signals close to DC but also delivers
outstanding performance with input bandwidths out to ~10kHz.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 .../bindings/iio/adc/adi,ad7173.yaml          | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
new file mode 100644
index 000000000000..a0f437297a23
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7173.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7173 ADC device driver
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
+  required:
+    - compatible
+    - reg
+    - interrupts
+
+patternProperties:
+  "^channel@[0-9a-f]$":
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@0 {
+        compatible = "adi,ad7173-8";
+        reg = <0>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-parent = <&gpio>;
+        spi-max-frequency = <5000000>;
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
2.39.2

