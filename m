Return-Path: <linux-kernel+bounces-6772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37238819D51
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22242886F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDE32110F;
	Wed, 20 Dec 2023 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhlHKF+O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221CE21350;
	Wed, 20 Dec 2023 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cc6ea4452cso42597261fa.1;
        Wed, 20 Dec 2023 02:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703069300; x=1703674100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ThNtIfnlIGuBL4u3+JKBWwmpRKYHrtqm+ZdySwo/r7Y=;
        b=GhlHKF+OxW4dR7KN5Usp75bDBaoGsqi95AV+yE7TzQOtFqGKvaMO9vnBD1TW0QZOQm
         S5x9/SoOCr29BsZsHV5GU/P4g7J8W3yhX8n6tqpE+uWApj0FFleHl47gzk0V0NhACdD6
         5Dx+RqVBr4E2mdBPrm2qFEmFuJbkOBZBgaPkC4rpAVgQThxVBlkxjKO+Td/TolmyNIq0
         wb+AZjv86Sr+4T8WIrgczsgMkisXZfGLV1zFaQYSCXIyO1Y/WjsB6/AwbhhMu3gPup/J
         YPhU7beY9dc9gbbYmhi407LP+4jZMFt+hqy1VZvyLgwhU+crNPjP3z/yrKZ5cUBzWc8a
         1/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703069300; x=1703674100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThNtIfnlIGuBL4u3+JKBWwmpRKYHrtqm+ZdySwo/r7Y=;
        b=hQasAyUWAmmnLA2S+dW9cnRCE6tSjYPQ2J6hR2Y+5JbuNBsxYx/2bkf1AZ8PZvgC93
         7dgjJgItrnuBLiW7To8Bad/Q0B4NFXobhDiPoxayXy/TsukTGgpfKFXmQtOFFBDU3ARO
         FQX/Izzg8Z/vmRXLaEnPGasag2L2uJUtwk7SyPb0zDHQ1okpn5exx+Ty/3IJeRRG3bqB
         G+w4hoRin04ogemTpiVZV6xQGnGO1MTkAn4JugsVdEadf1giCaBUnRvrVkJU/AxFPiWa
         86Pi2ZHDW02AKLdZEsgzF65hhOLQ4dS86FgwhIr6DgDj5EHY59v2TCG4zH1NFpIm6A96
         ECdA==
X-Gm-Message-State: AOJu0YwpoGN0Jp+E/jkjOxLazYUoTFlwgCzT03uA1jTp6Nl6GPGZR4Lp
	nhvvvL3uxghlaLxT6ZyKcG0=
X-Google-Smtp-Source: AGHT+IG7dlKniwOxuWH6xHGqWIz/OdpfrFThiRi4i2YoF5zExz/Vi/LEw9ureDOZEvqmbm11j9Bilg==
X-Received: by 2002:a05:651c:226:b0:2cc:769e:723d with SMTP id z6-20020a05651c022600b002cc769e723dmr1926964ljn.87.1703069299819;
        Wed, 20 Dec 2023 02:48:19 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.193.82])
        by smtp.gmail.com with ESMTPSA id x12-20020a5d650c000000b003366c058509sm1904063wru.23.2023.12.20.02.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 02:48:19 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org,
	linux-gpio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
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
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v11 1/2] dt-bindings: adc: add AD7173
Date: Wed, 20 Dec 2023 12:48:04 +0200
Message-ID: <20231220104810.3179-1-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AD7173 family offer a complete integrated Sigma-Delta ADC solution
which can be used in high precision, low noise single channel applications
or higher speed multiplexed applications. The Sigma-Delta ADC is intended
primarily for measurement of signals close to DC but also delivers
outstanding performance with input bandwidths out to ~10kHz.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
V10->V11
 - Fix example warning: '#gpio-cells' is a dependency of 'gpio-controller'
 - Add description to #gpio-cells property
V9->V10
 - Fix dt_binding_check type warning from adi,reference-select
V8->v9
 - Add gpio-controller and "#gpio-cells" properties
 - Add missing avdd2 and iovdd supplies
 - Add string type to reference-select
V7->V8
 - include missing fix from V6
V6->V7 <no changes>
V5->V6
 - Moved global required property to proper placement
V4 -> V5
 - Use string enum instead of integers for "adi,reference-select"
 - Fix conditional checking in regards to compatible
V3 -> V4
 - include supply attributes
 - add channel attribute for selecting conversion reference
V2 -> V3
 - remove redundant descriptions
 - use referenced 'bipolar' property
 - remove newlines from example
V1 -> V2 <no changes>

 .../bindings/iio/adc/adi,ad7173.yaml          | 188 ++++++++++++++++++
 1 file changed, 188 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
new file mode 100644
index 000000000000..7c8caef76528
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -0,0 +1,188 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7173.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7173 ADC
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
+  gpio-controller:
+    description: Marks the device node as a GPIO controller.
+
+  "#gpio-cells":
+    const: 2
+    description:
+      The first cell is the GPIO number and the second cell specifies
+      GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
+
+  refin-supply:
+    description: external reference supply, can be used as reference for conversion.
+
+  refin2-supply:
+    description: external reference supply, can be used as reference for conversion.
+
+  avdd-supply:
+    description: avdd supply, can be used as reference for conversion.
+
+  avdd2-supply:
+    description: avdd2 supply, used as the input to the internal voltage regulator.
+
+  iovdd-supply:
+    description: iovdd supply, used for the chip digital interface.
+
+patternProperties:
+  "^channel@[0-9a-f]$":
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 15
+
+      diff-channels:
+        items:
+          minimum: 0
+          maximum: 31
+
+      adi,reference-select:
+        description: |
+          Select the reference source to use when converting on
+          the specific channel. Valid values are:
+          refin      : REFIN(+)/REFIN(−).
+          refin2     : REFIN2(+)/REFIN2(−)
+          refout-avss: REFOUT/AVSS (Internal reference)
+          avdd       : AVDD
+
+          External reference refin2 only available on ad7173-8.
+          If not specified, internal reference used.
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - refin
+          - refin2
+          - refout-avss
+          - avdd
+        default: refout-avss
+
+    required:
+      - reg
+      - diff-channels
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: adi,ad7173-8
+    then:
+      properties:
+        refin2-supply: false
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
+            adi,reference-select:
+              enum:
+                - refin
+                - refout-avss
+                - avdd
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
+        gpio-controller;
+        #gpio-cells = <2>;
+
+        refin-supply = <&dummy_regulator>;
+
+        channel@0 {
+          reg = <0>;
+          bipolar;
+          diff-channels = <0 1>;
+          adi,reference-select = "refin";
+        };
+
+        channel@1 {
+          reg = <1>;
+          diff-channels = <2 3>;
+        };
+
+        channel@2 {
+          reg = <2>;
+          bipolar;
+          diff-channels = <4 5>;
+        };
+
+        channel@3 {
+          reg = <3>;
+          bipolar;
+          diff-channels = <6 7>;
+        };
+
+        channel@4 {
+          reg = <4>;
+          diff-channels = <8 9>;
+          adi,reference-select = "avdd";
+        };
+      };
+    };
-- 
2.42.0


