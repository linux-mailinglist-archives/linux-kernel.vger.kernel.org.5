Return-Path: <linux-kernel+bounces-78388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8178612D1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B2F285C85
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D597F471;
	Fri, 23 Feb 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsA924Ru"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020357AE6E;
	Fri, 23 Feb 2024 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695487; cv=none; b=fLFQWj9y3Je9gx8SysFrsr8BCy9f/1zkJ9JRrbzvt12zcNUqOoYdwA3jXBG51L0k3u9Km0FcyNb4aCRoKluwPEei29biddmLAh652Zfm8CtVho7BcaQR9AqG4ISRZbmtaRTHL+ZpReIb17Xz8jH4OEVXqRgsdrMAVbwoxeqAQ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695487; c=relaxed/simple;
	bh=5ieuGD931HGPK6rLXZGzOee73cDPA9R58arcB59nvCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TbyymG8Wqutwt46jKgO54baUty8iTAVWJSchCXACL55urLggB5b29p3rccN6j6ORh51OaSqteU+Yaz/1DD3+KHyO8TqS5IT1yba+xASL0oNtOGNXzIkL9P2YYzkeUx/rXDMOtUxzMsLRUCkUGcOpLr6wqNGT6j802WJbD7Qc+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsA924Ru; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3f48422fb6so123011966b.3;
        Fri, 23 Feb 2024 05:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708695483; x=1709300283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7xWo64HPyceyCrU5fgBBH7VbC2lBdca093uyLG+HM+8=;
        b=QsA924RuxRvKfoPiNMpSyusFqfnrAUzWlrRRS52ueegWJONGUiMqWgwhEUlEUo9oRa
         Krn8IMrEaIoi5mWUKehfVMVIf+cdjCs0rOCR1YbhZwoxcnwJE/MxyXWTLZJOWkEjBt4Q
         LM0hxqmasrIEjOHgLQR1R/eEL6e3EQmuS7jD7wtp/Ust/rgD616fN3va+r0YQaQtIILU
         1gUSBaGiFaua90u3Pr38xOABCpzB9Ow0NRcxMSQHcoPEuc1GLvS57clj7+K18iKTz2/6
         ygCvnGXWBhnDXXYAvf1UniTz51v22UrFDJIVsArkFBzJOtrc3jYpaxp0BbpXtasIqgrX
         IV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708695483; x=1709300283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xWo64HPyceyCrU5fgBBH7VbC2lBdca093uyLG+HM+8=;
        b=eVj7sUfMBI4mfBlr2jqocEPXZitJwcp5O9RUNkdiEeIHUDq8iGXNDdVowOKjGhAPqP
         9kew72zLjDhvC6zKtOTuK3acQQPAmH0vheBQB6JuxGqjNrDo48Aj02rGWg9CAXhNaPSJ
         hhR5k/U+Pa+mlnWI50cq/TehbxUibpYJhdx+FTXkCkkcNzZezgwPRr2YbhY/5ymFto/h
         iqHbNgGx9nCCWp9yLKF5R+vjy3phK/am1JWbbWZPLSKHKjhm5UltY4Irb9Z1DGqS8VHQ
         zKxXEYE5s4zSlIjvMPRAt7pLlGNhCyFjqC+dEor4cAYHzcIFOWnHNngvkV1IZhJaODMw
         wBQg==
X-Forwarded-Encrypted: i=1; AJvYcCUHnYFo3ikLl7K0FouLUlzhznV209nV9eP/FiIfKc4eMmqRvMvrCxlL2O6XiqmdbtVoE6vg0XLnT/qTYIpBl1+N4mAbUc2MllpKAxkLBYyrXBRU9moNRWQdg2awIN/O6Wg0bH/oeznkZjbTbJ9dJd21bcv0z0/tOUM9PUFQ1G5tQdPMVepp5HbH71Qj8n6kpSl0foNqxuO6f1rfhOK6FrQ=
X-Gm-Message-State: AOJu0YykzVjha6PHgP1t++0qy7zn5ZbhmLKwG0eXJFHCyDH8krDU5UNL
	ujaJlb+7gcGUCofuLoYk0LW0lU/bt1mX/nk9pA6JPf2VBoEJjqLJ
X-Google-Smtp-Source: AGHT+IHSuJ0k6vRbHvVLRXkmiDeKhDXRdviKQl0ehB5fsFZRrRWY4C9VF4pdHPAiWswO8XQvXd7kRg==
X-Received: by 2002:a17:906:2608:b0:a3e:c680:ee3a with SMTP id h8-20020a170906260800b00a3ec680ee3amr1365827ejc.30.1708695482674;
        Fri, 23 Feb 2024 05:38:02 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([83.103.132.21])
        by smtp.gmail.com with ESMTPSA id h11-20020a17090634cb00b00a3d7bcfb9a1sm6911429ejb.128.2024.02.23.05.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:38:02 -0800 (PST)
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
	David Lechner <dlechner@baylibre.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v15 1/3] dt-bindings: adc: add AD7173
Date: Fri, 23 Feb 2024 15:37:28 +0200
Message-ID: <20240223133758.9787-1-mitrutzceclan@gmail.com>
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

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
V14->V15 <no changes>
V13->V14
 - Refer in descriptions of the avdd-supply as AVDD1 in concordance to datasheet
 - Fix typo
 - Place interrupts descriptions separately for each item
 - Restrict max channel reg to 3 for models AD717x-2
V12->V13
 - Remove adi,clock-select
 - Update avdd and avdd2 supply descriptions
 - Update adi,reference-select description to suggest that it is referenced to avss
 - Make clocks/clock-names and clock-controller mutually exclusive
V11->V12
 - Drop "binding", describe hardware in binding description
 - Rename refin and refin2 to vref and vref2
 - Add better description to external references to better show that the voltage
    value that needs to be specified is the difference between the positive and
    negative reference pins
 - Add optional clocks properties
 - Add optional adi,clock-select property
 - Add option for second interrupt, error
 - Add description to interrupts
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
 .../bindings/iio/adc/adi,ad7173.yaml          | 246 ++++++++++++++++++
 1 file changed, 246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
new file mode 100644
index 000000000000..36f16a325bc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -0,0 +1,246 @@
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
+  Analog Devices AD717x ADC's:
+  The AD717x family offer a complete integrated Sigma-Delta ADC solution which
+  can be used in high precision, low noise single channel applications
+  (Life Science measurements) or higher speed multiplexed applications
+  (Factory Automation PLC Input modules). The Sigma-Delta ADC is intended
+  primarily for measurement of signals close to DC but also delivers
+  outstanding performance with input bandwidths out to ~10kHz.
+
+  Datasheets for supported chips:
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
+    minItems: 1
+    items:
+      - description: |
+          Ready: multiplexed with SPI data out. While SPI CS is low,
+          can be used to indicate the completion of a conversion.
+
+      - description: |
+          Error: The three error bits in the status register (ADC_ERROR, CRC_ERROR,
+          and REG_ERROR) are OR'ed, inverted, and mapped to the ERROR pin.
+          Therefore, the ERROR pin indicates that an error has occurred.
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: rdy
+      - const: err
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
+  '#gpio-cells':
+    const: 2
+    description:
+      The first cell is the GPIO number and the second cell specifies
+      GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
+
+  vref-supply:
+    description: |
+      Differential external reference supply used for conversion. The reference
+      voltage (Vref) specified here must be the voltage difference between the
+      REF+ and REF- pins: Vref = (REF+) - (REF-).
+
+  vref2-supply:
+    description: |
+      Differential external reference supply used for conversion. The reference
+      voltage (Vref2) specified here must be the voltage difference between the
+      REF2+ and REF2- pins: Vref2 = (REF2+) - (REF2-).
+
+  avdd-supply:
+    description: Avdd supply, can be used as reference for conversion.
+                 This supply is referenced to AVSS, voltage specified here
+                 represents (AVDD1 - AVSS).
+
+  avdd2-supply:
+    description: Avdd2 supply, used as the input to the internal voltage regulator.
+                 This supply is referenced to AVSS, voltage specified here
+                 represents (AVDD2 - AVSS).
+
+  iovdd-supply:
+    description: iovdd supply, used for the chip digital interface.
+
+  clocks:
+    maxItems: 1
+    description: |
+      Optional external clock source. Can include one clock source: external
+      clock or external crystal.
+
+  clock-names:
+    enum:
+      - ext-clk
+      - xtal
+
+  '#clock-cells':
+    const: 0
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
+          vref       : REF+  /REF−
+          vref2      : REF2+ /REF2−
+          refout-avss: REFOUT/AVSS (Internal reference)
+          avdd       : AVDD  /AVSS
+
+          External reference ref2 only available on ad7173-8.
+          If not specified, internal reference used.
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - vref
+          - vref2
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
+        vref2-supply: false
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
+            adi,reference-select:
+              enum:
+                - vref
+                - refout-avss
+                - avdd
+            reg:
+              maximum: 3
+
+  - if:
+      anyOf:
+        - required: [clock-names]
+        - required: [clocks]
+    then:
+      properties:
+        '#clock-cells': false
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
+        interrupt-names = "rdy";
+        interrupt-parent = <&gpio>;
+        spi-max-frequency = <5000000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        #clock-cells = <0>;
+
+        vref-supply = <&dummy_regulator>;
+
+        channel@0 {
+          reg = <0>;
+          bipolar;
+          diff-channels = <0 1>;
+          adi,reference-select = "vref";
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


