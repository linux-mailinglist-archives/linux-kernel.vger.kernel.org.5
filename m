Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522417B38A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjI2RZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjI2RZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:25:51 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E441B3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:25:48 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57ad95c555eso7308197eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008348; x=1696613148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAQ+9OUUFA/CH23Ej2yuI6SPnrszEisFRJ29EV5BnFI=;
        b=fJ9L6eF1DYhOqrq7trKapPLzVGpj3IJ2kd5o+H0/UMVw1pMXDoPO+dvzC2fNlT7xk1
         iMx3MrghRU+3mWPB0UflEVae75Crb0GUqRzF4XhPRlsxZJxi1/+BYPIJX8MYnKCsx0Vt
         vQw01wI8XPrRliU96ZpKLolet5fmkvM6CrAaEBT/5PAER2Wa0FyJpdwJkH9f30yz+yPM
         +5jao/1FWt5alIN0qIW008o2yC2qgdUCa89ZwK9ezf+KsNk+fnoaStV0SRXlTdW+kXmu
         pLq4DM8R+dP5tPlxryXrATvu9z8pr079WsBtNOGQmQiRTvu9a6hazvY6sjk6M6/ZP2qw
         M7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008348; x=1696613148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAQ+9OUUFA/CH23Ej2yuI6SPnrszEisFRJ29EV5BnFI=;
        b=Ln9BjeN7jv5cWj0/rpg/nCJqyEF+D5IIGXpMnYwO+6Iyf5N8ZPLnsnhSdf90DwYsbI
         muzQjjF6MqmrIvPUsserDjL+PQG+EEBBP2xzZ+HCd5Tq+8XA1As4IzEPMMSDsvGxw8SG
         1HaYCHnR/qfA5TVaV43dsv05gvyWLPPnI5D+lxlr9NgLRpkjD64qFYWeLPqNvEqIPEzv
         HoC3XsTv57X4EcWubMqyQXPnUk26UAPLYdkN3xMj3+wg1HE5zD1M/eWoi0+m3feVIj/g
         QClVpo+kalrWgTMp8cXAN9K9Xs79zQ/rF2ETWin8vlojjWnNFAVsMqLNHFRd8SUGrpo7
         OymA==
X-Gm-Message-State: AOJu0Ywti8oQfh8V/UUPAcgU/smkmfqA944MZEbju88cTSXSBTgXA7uV
        Z8NxL3AMTxSJKFHi+XtQXPgu2g==
X-Google-Smtp-Source: AGHT+IE0GlYIhnui3UmneJph2JGLREScOwg+lRf9xJY5Sh9TRXNM4Bntai/NVcRpUOhG9UYvUjpumQ==
X-Received: by 2002:a4a:751d:0:b0:57b:5693:5ecb with SMTP id j29-20020a4a751d000000b0057b56935ecbmr4180070ooc.2.1696008347557;
        Fri, 29 Sep 2023 10:25:47 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:25:47 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org,
        David Lechner <dlechner@baylibre.com>,
        Apelete Seketeli <aseketeli@baylibre.com>
Subject: [PATCH v3 01/27] dt-bindings: iio: resolver: add devicetree bindings for ad2s1210
Date:   Fri, 29 Sep 2023 12:23:06 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-1-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

This adds new DeviceTree bindings for the Analog Devices, Inc. AD2S1210
resolver-to-digital converter.

Co-developed-by: Apelete Seketeli <aseketeli@baylibre.com>
Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* Expanded top-level description of A0/A1 lines.
* Added required voltage -supply properties. (I did not pick up Rob's
  Reviewed-by since I wasn't sure if this was trivial enough.)

v2 changes:
* Add Co-developed-by:
* Remove extraneous quotes on strings
* Remove extraneous pipe on some multi-line descriptions

 .../bindings/iio/resolver/adi,ad2s1210.yaml        | 177 +++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml b/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
new file mode 100644
index 000000000000..8980b3cd8337
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
@@ -0,0 +1,177 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/resolver/adi,ad2s1210.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD2S1210 Resolver-to-Digital Converter
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  The AD2S1210 is a complete 10-bit to 16-bit resolution tracking
+  resolver-to-digital converter, integrating an on-board programmable
+  sinusoidal oscillator that provides sine wave excitation for
+  resolvers.
+
+  The AD2S1210 allows the user to read the angular position or the
+  angular velocity data directly from the parallel outputs or through
+  the serial interface.
+
+  The mode of operation of the communication channel (parallel or serial) is
+  selected by the A0 and A1 input pins. In normal mode, data is latched by
+  toggling the SAMPLE line and can then be read directly. In configuration mode,
+  data is read or written using a register access scheme (address byte with
+  read/write flag and data byte).
+
+    A1  A0  Result
+     0   0  Normal mode - position output
+     0   1  Normal mode - velocity output
+     1   0  Reserved
+     1   1  Configuration mode
+
+  In normal mode, the resolution of the digital output is selected using
+  the RES0 and RES1 input pins. In configuration mode, the resolution is
+  selected by setting the RES0 and RES1 bits in the control register.
+
+  RES1  RES0  Resolution (Bits)
+     0     0  10
+     0     1  12
+     1     0  14
+     1     1  16
+
+  Note on SPI connections: The CS line on the AD2S1210 should hard-wired to
+  logic low and the WR/FSYNC line on the AD2S1210 should be connected to the
+  SPI CSn output of the SPI controller.
+
+  Datasheet:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad2s1210.pdf
+
+properties:
+  compatible:
+    const: adi,ad2s1210
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 25000000
+
+  spi-cpha: true
+
+  avdd-supply:
+    description:
+      A 4.75 to 5.25 V regulator that powers the Analog Supply Voltage (AVDD)
+      pin.
+
+  dvdd-supply:
+    description:
+      A 4.75 to 5.25 V regulator that powers the Digital Supply Voltage (DVDD)
+      pin.
+
+  vdrive-supply:
+    description:
+      A 2.3 to 5.25 V regulator that powers the Logic Power Supply Input
+      (VDrive) pin.
+
+  clocks:
+    maxItems: 1
+    description: External oscillator clock (CLKIN).
+
+  reset-gpios:
+    description:
+      GPIO connected to the /RESET pin. As the line needs to be low for the
+      reset to be active, it should be configured as GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  sample-gpios:
+    description:
+      GPIO connected to the /SAMPLE pin. As the line needs to be low to trigger
+      a sample, it should be configured as GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  mode-gpios:
+    description:
+      GPIO lines connected to the A0 and A1 pins. These pins select the data
+      transfer mode.
+    minItems: 2
+    maxItems: 2
+
+  resolution-gpios:
+    description:
+      GPIO lines connected to the RES0 and RES1 pins. These pins select the
+      resolution of the digital output. If omitted, it is assumed that the
+      RES0 and RES1 pins are hard-wired to match the assigned-resolution-bits
+      property.
+    minItems: 2
+    maxItems: 2
+
+  fault-gpios:
+    description:
+      GPIO lines connected to the LOT and DOS pins. These pins combined indicate
+      the type of fault present, if any. As these pins a pulled low to indicate
+      a fault condition, they should be configured as GPIO_ACTIVE_LOW.
+    minItems: 2
+    maxItems: 2
+
+  adi,fixed-mode:
+    description:
+      This is used to indicate the selected mode if A0 and A1 are hard-wired
+      instead of connected to GPIOS (i.e. mode-gpios is omitted).
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [config, velocity, position]
+
+  assigned-resolution-bits:
+    description:
+      Resolution of the digital output required by the application. This
+      determines the precision of the angle and/or the maximum speed that can
+      be measured. If resolution-gpios is omitted, it is assumed that RES0 and
+      RES1 are hard-wired to match this value.
+    enum: [10, 12, 14, 16]
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - avdd-supply
+  - dvdd-supply
+  - vdrive-supply
+  - clocks
+  - sample-gpios
+  - assigned-resolution-bits
+
+oneOf:
+  - required:
+      - mode-gpios
+  - required:
+      - adi,fixed-mode
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        resolver@0 {
+            compatible = "adi,ad2s1210";
+            reg = <0>;
+            spi-max-frequency = <20000000>;
+            spi-cpha;
+            avdd-supply = <&avdd_regulator>;
+            dvdd-supply = <&dvdd_regulator>;
+            vdrive-supply = <&vdrive_regulator>;
+            clocks = <&ext_osc>;
+            sample-gpios = <&gpio0 90 GPIO_ACTIVE_LOW>;
+            mode-gpios = <&gpio0 86 0>, <&gpio0 87 0>;
+            resolution-gpios = <&gpio0 88 0>, <&gpio0 89 0>;
+            assigned-resolution-bits = <16>;
+        };
+    };

-- 
2.42.0

