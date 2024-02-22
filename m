Return-Path: <linux-kernel+bounces-76385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA01F85F685
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A60C1C225DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A47F405E5;
	Thu, 22 Feb 2024 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0twM8Cq"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A83FB31;
	Thu, 22 Feb 2024 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600106; cv=none; b=DwX2SGyIIxSVXSPaFgdYnItHq9AlLgQnKLyBa75Voep+kHk1pxj9crbF9UqgcIJ9vGuUwNEH91eVmdfkG6TsWlrX/5pexU+4igQsIdIEkG+lpS5uglIcmppVc038zjVx1xRc/z5ncg2sH2pVfTO1q6IJZo3f/n8123LQKay9+GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600106; c=relaxed/simple;
	bh=uMcsARZAJ/pWtueCpdZWxsB/jQmR3DwOwdtTYUouGk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RydPpSMnulupIsXyX5uUaEVd59k2sl8aDHiFnJzol0YEL2ZamNjKF1ZuS86einBC+nLquZSSysqAv8d6HqM+JsjnjyeMCRWm6lbQebPMhT3tJBWkP1P/DWsc0uHSkLT16tImjX+BMxkm3Hu0tXW83JdFOu086evybQKX/5BwLlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0twM8Cq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso9673843a12.0;
        Thu, 22 Feb 2024 03:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708600103; x=1709204903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0whVvYDY95pBVQJ7bhciQeW66/kwSxxjH2jVbNo2XNk=;
        b=k0twM8CqBVJyM3AK5aWXrlnDep0HcMsc1X1xM1XujpPxqnTgVI/7WtlYT089l7z54u
         0Rrz/BIY721SKctJFmt1EXTryK4tgiKzTNY+NUH450XFYEZhSV7FI5DjVXMaAl+b2pY5
         UFSQCVSG07Oy5KFs5jV7lk/gSEqS4uiZZH2GoE18lZrxoLLwSpbUOvARqJwd3ZrLJl1h
         ozwF7QjUWcJWnAjEMec4ILBATlLBnTFd33zTTkQvlJDgTizIDmFJpoDDuDlZdzllFedE
         28+z5omPKJjzEgQim/RFVy5yJNsHfvEk+grQUs7IyP/umkPElf9WnlrGUmz6z0RzAok/
         rEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708600103; x=1709204903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0whVvYDY95pBVQJ7bhciQeW66/kwSxxjH2jVbNo2XNk=;
        b=EQzYhEILtO9yabCnYNO8mnnBTfiX1JNgUem8dXipAhN5zP5JzPIACATnahw1F98D4a
         WwfqRhNfb+0AufzWQZG7MlqdbgLgDbM+Jq4uvee6q9zVzVxkUJM6OknAegXR12OFIo6W
         LOcdT3Ti82CU8KhiKREPR9dI8+398DopwgCSVlkLBTFL+O/6E5uonZC7EVnbSZddbFQu
         3fe1kY3GwqU7j4mKoef1OVT9XCfJBamioi0gdp9ZT+JDCuuyhSfjeALcqSEt5oMyPxVX
         rJhFbPUtRGo6JVOUmRIVZgYZOukB7KI6UdTyQxwB+X+YIipwfqOvNQUaJnG+axcRScz6
         xlMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9iGbPi9f2mXHRIgQeuUcn0vRGjz1koV8I6JsMDVPhpgmY0Z3Z5mPQW5vJCL7xWJAohzIj+dC2uS822LQgZ/t2yL99CApJ83dgvde5nHbXuSCwwbZgQpR9zNFQux6b29d/FxzDYXX2AX0yTjtuFxSmC1PtsJzIg5iJzL/Co12tv9oZ9zr+XCh1A0gBQaEPQ4m2GxtdlJhzBE5JaVkYYYY=
X-Gm-Message-State: AOJu0YzOXs9H/eiFhkNbbxLx9juikTxj+5jrplMfNzRZ/3QGSQJxhvGl
	CDy5Vv6FIE2KvK49o1YgIyYszMJOTGs3ncCgP/YSmY3ddly36wwo
X-Google-Smtp-Source: AGHT+IHb1WcJuA/WNALHR6fhcWVrHPh+54mjtrmf4NW7jDX2/r8OUOKZvslgdTm426wmULAn1wadpA==
X-Received: by 2002:a05:6402:31f6:b0:564:dd13:56e9 with SMTP id dy22-20020a05640231f600b00564dd1356e9mr3906531edb.29.1708600102333;
        Thu, 22 Feb 2024 03:08:22 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([83.103.132.21])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b00563a3ff30basm5786350edi.59.2024.02.22.03.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:08:21 -0800 (PST)
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
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v14 1/3] dt-bindings: adc: add AD7173
Date: Thu, 22 Feb 2024 13:07:41 +0200
Message-ID: <20240222110817.29670-1-mitrutzceclan@gmail.com>
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


