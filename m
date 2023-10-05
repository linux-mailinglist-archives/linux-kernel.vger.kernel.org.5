Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807897B9FEA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjJEOao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbjJEO3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:29:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05D923D01;
        Thu,  5 Oct 2023 04:00:50 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50337b43ee6so1096485e87.3;
        Thu, 05 Oct 2023 04:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696503649; x=1697108449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4yKDLEpsQ7VNfIu4ns2cVaF5g5AlvkRxOThMkLNLu54=;
        b=DyYTpj5O3SDs1MUT4akrYSG3JSOgGJjRn1EwJpWinCaqSyL9jnGX1S7XrMww7JZwtc
         rpoe11uV7Z+g0eTnyKzi8xCbU5e2bAx1NBMS5D+JD7YJRIar7nkC3q55Q1Dl0Yle3IJr
         sqS86VcwmAX87PfQFFe/kxTaESCOppN3VpExGiTBc62V1y1nc/+lLHwCxbsE3y5sCaL5
         4D3Pkoym3b2QyijwL10TnFbcV5bbdzZJVsjCRs8uYpks/xHxrnY7tCQuiqclaq/7OPdC
         p1xg6tZIEMqvbqhrrXO1EEfl17hG5QFnk90u41WYid34RYoCrHYTQaFv39P1ZaSGDX39
         fUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696503649; x=1697108449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4yKDLEpsQ7VNfIu4ns2cVaF5g5AlvkRxOThMkLNLu54=;
        b=G9nM1blnRopCp6/ard/AfWg5PvGCdGxFBUeS+pfXKGuqJdTP7EOJL7miUqSdcjZpp2
         raKbyh2VW8kAdqYeOQJrC9kFNbYoji14ShLbfG1l48GVsP+wZrneYNaf/UotGqybydIW
         XXmOddeExtypN1Gksjh+EBdGpm6ppS9byGyCDMVadILCPONWptvkuIC9wlj9niifUx1v
         rH5tp1Nli3GC/SYZZ7GCPGC8wQ+KS2HNQ8xagI6Xieb28xChGqAwaDG7/p5P7/2oi370
         Yrv8yEBFjlaXKcp64Rmq+5l0ojEWNNKl01Yy+zWmaBztOPlfNE1W9epHl7thUa1cZEd1
         St9g==
X-Gm-Message-State: AOJu0YyD7mzVZNh0GfobWSWtXc22Ywvhup0pRvYUdgAPntzyaLIQw2v/
        nmB/4q6bCzv7ELFPH+XT0Wo=
X-Google-Smtp-Source: AGHT+IFvXRCpTbbGo0xm+WMtWgdEVQ3lrnpnQBX8o8q8w0En2Ih6C30E19ZNfYUh0gc/2I/xwbNrrg==
X-Received: by 2002:ac2:4ec1:0:b0:503:8fa:da22 with SMTP id p1-20020ac24ec1000000b0050308fada22mr3940230lfr.22.1696503648874;
        Thu, 05 Oct 2023 04:00:48 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id g11-20020aa7d1cb000000b0052c9f1d3cfasm890066edp.84.2023.10.05.04.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 04:00:47 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: adc: add AD7173
Date:   Thu,  5 Oct 2023 13:59:21 +0300
Message-Id: <20231005105921.460657-1-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.39.2
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

The AD7173 family offer a complete integrated Sigma-Delta ADC solution
which can be used in high precision, low noise single channel applications
or higher speed multiplexed applications. The Sigma-Delta ADC is intended
primarily for measurement of signals close to DC but also delivers
outstanding performance with input bandwidths out to ~10kHz.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
V2 -> V3
 - remove redundant descriptions
 - use referenced 'bipolar' property
 - remove newlines from example

 .../bindings/iio/adc/adi,ad7173.yaml          | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
new file mode 100644
index 000000000000..bf9e3cbf842e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -0,0 +1,130 @@
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
+        minimum: 0
+        maximum: 15
+
+      diff-channels:
+        items:
+          minimum: 0
+          maximum: 31
+
+      bipolar:
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
+          bipolar;
+          diff-channels = <0 1>;
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
+        };
+      };
+    };
-- 
2.39.2

