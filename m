Return-Path: <linux-kernel+bounces-30115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18877831971
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1422864AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FC724B5E;
	Thu, 18 Jan 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo+VL9Xc"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741C24B3A;
	Thu, 18 Jan 2024 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582210; cv=none; b=uCQR0DenROXGIMcU9yXY+cTyZhFuZLr5ehz7neC7SdPQTWqyWQWWF5ZnTNLL5Rvt8mf4AULz675FDDHhLuC0gkonb0i1TdjlOULltoriUe5DgkxbCx93XTEuOn2tMvSSI7I2uVHvyxm5By/s/isIZTVhPdABtG3G1SZ9WuTvk+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582210; c=relaxed/simple;
	bh=Q56Fx4gTcJEFIsrNdmA5mKn8gURJYc88ZVBwHmVk28Q=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=XfGNSOK0WtfMXkS0xmIgL/Giem6meIExGeW5Ewt5HzVe/smYV4dd29psyYpvrVzXKsYClONxyYiUn7dXunOkq3LbKjVQXKsJGp04xylBrAconizcM8wQdcmnB+go6as4NJqDqnj/PideOMSyNdr0lpSkxCJTgMo/SlhwyX2uP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo+VL9Xc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2cea0563cbso946234366b.3;
        Thu, 18 Jan 2024 04:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705582207; x=1706187007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rumkJ80i+uymDdsR3wPobcZixA577ONpxP99gsV+kyc=;
        b=Mo+VL9XcQpUGOV9aGSp1i8AIOA9qZdAh2QIWxgSOzmmlSagoXSWOChLlqhYJYXt53q
         8315Djlhy0no4fUsM0eM/wD5+C7jh9joLQGFlRWE06wJPvTGbkw9BgcwPgi9iGS0W2lX
         zicV9liBIodIRBZudcFAtRC+0M9WcPTfgGr9/INp4+zRW3L9JH3y7O4b3KprcgW4V3He
         CDciu/5jETnG7LA+z8SZJwXcmMyf+zyQ5efWRRQJ3syAWE9HvLgGcNWil/36G6OwKGL6
         HB42+9AqWTItU5s42+nDD2laR4EUlpT8BMIjvBFuP3Ee6m/XSiZ95Eu2om6KhcPVX6WT
         NBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705582207; x=1706187007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rumkJ80i+uymDdsR3wPobcZixA577ONpxP99gsV+kyc=;
        b=UEDpHiEBdUaRmoiOOUd1LLkd3/XI6wkm+kvIUYpOY3J7DsEEs553OiNHiHkf8gARJQ
         TEqG7QFqx9QfQwAcTDOud9RgcALL0kj/htvj0uYRczqPp4/Yn46rYDnYYignNHQdybkS
         Tyni3sk8OUS7R4SsH1ospVvsNEyPBMm4CFWjFDhzg5+zcHiF9LA+XfI4MaBHQoIDSM+6
         sqa25+ISHbLSUZ+NKwNa+XA8+TKS70442VSRVsVTKd001epb/wufa3N+Fu/p2BSM38di
         NeNc1W2GbpvebCnTBGQ6IvQJHIH/q5SGMpd+oPgrm12tYO+xvFaq9+WAb5c2hAu9h3WA
         +oVQ==
X-Gm-Message-State: AOJu0Yw8egDesG5Wtqwg9ycqIMQlXYi/YEc3wigzes8P9NIidfSRNq4T
	H+9qr+kzoV5YmXO28ZPF0UkFvbbD5qse6f/h4yZ7prxUkNp/6lTB
X-Google-Smtp-Source: AGHT+IHZCKE8rWteASUPb7uBeaeCPwjzy6gECAQMIRcQlR+3+3ruQ/tBbHNpZJDv8i4+/VXMqIjVig==
X-Received: by 2002:a17:906:f185:b0:a2c:2f06:36f0 with SMTP id gs5-20020a170906f18500b00a2c2f0636f0mr475087ejb.154.1705582206751;
        Thu, 18 Jan 2024 04:50:06 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id rv25-20020a17090710d900b00a26c8c70069sm9069692ejb.48.2024.01.18.04.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 04:50:06 -0800 (PST)
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
Subject: [PATCH v12 1/2] dt-bindings: adc: add AD7173
Date: Thu, 18 Jan 2024 14:49:22 +0200
Message-ID: <20240118125001.12809-1-mitrutzceclan@gmail.com>
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

 .../bindings/iio/adc/adi,ad7173.yaml          | 242 ++++++++++++++++++
 1 file changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
new file mode 100644
index 000000000000..4d0870cc014c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -0,0 +1,242 @@
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
+    description: |
+      Ready interrupt: multiplexed with SPI data out. While SPI CS is low,
+      can be used to indicate the completion of a conversion.
+
+      Error: The three error bits in the status register (ADC_ERROR, CRC_ERROR,
+      and REG_ERROR) are OR'ed, inverted, and mapped to the ERROR pin. Therefore,
+      the ERROR pin indicates that an error has occurred.
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
+  "#gpio-cells":
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
+    description: avdd supply, can be used as reference for conversion.
+
+  avdd2-supply:
+    description: avdd2 supply, used as the input to the internal voltage regulator.
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
+  adi,clock-select:
+    description: |
+      Select the ADC clock source. Valid values are:
+      int         : Internal oscillator
+      int-out     : Internal oscillator with output on XTAL2 pin
+      ext-clk     : External clock input on XTAL2 pin
+      xtal        : External crystal on XTAL1 and XTAL2 pins
+
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - int
+      - int-out
+      - ext-clk
+      - xtal
+    default: int
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
+          avdd       : AVDD
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


