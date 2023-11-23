Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ED17F60F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345675AbjKWODg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345657AbjKWODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:03:35 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448DCB9;
        Thu, 23 Nov 2023 06:03:41 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so1280537a12.0;
        Thu, 23 Nov 2023 06:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700748220; x=1701353020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RsVQHQgkmGnmkp/8Pi5Iy/1xJuykXLLuCKbsn14yEl4=;
        b=jf2tLJm/0jSkRKS31mZnzpOXPLUO8HbMwUpOWZi7LaxswMu7J/pgVTE/3t4zk7/8St
         TDhlwbGpcnGqfVp41WDrpqUSw+cwPej1S7jDmtsfvciHeSuvIXmbmktVCIOXdfGba5ao
         rAn6OULBJFmczbURxMNpIL5f720KRgHagucbM/CyR/stp5Fg8ZsmONBACPPlYABIP2TL
         R5ClCWjjPRTtMyQfdSHITrXhAlCl7EJ0eRYb6qsr3l4qqBuRwWAL9/QZj0JS82xuhp6D
         yrmORHDXq7q00RDpvZaT8SLVTX/Eb4tN7ydXbWBC5Ud2b+AX1J26WE8Ju8y8lio8wtdc
         W5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700748220; x=1701353020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RsVQHQgkmGnmkp/8Pi5Iy/1xJuykXLLuCKbsn14yEl4=;
        b=jGPpKOKtmBaaVUeT3PCz/dlpeg78DEaUkDYnGSRTT5XoZ0FaiOJcC8VswM9okm1IkA
         UGrRnB6eGXUphNphqO/m6ZdGxey9eeIlMV4aW1s4b0MGViqJskBOlymydpLjHSSxnqz1
         QevykvgnPB2v3SLMC8DZc2t3MkI2caxhXq0JDj42xcFkCEojciFpRckSaJEtCqwBvvc/
         ib92B06QlAgFkb0e5rYVYcjRVOxSzTDSkkv6GSJDxpCk8VLKJhX+ZAsYXFLr7UlsXPTn
         PFyDoWB3LWCGZ1UfwaATvLp8g3UNnKSFnrJc9JlT6O5gxym2jbVZOivUVNXfWi6Mas1Y
         fTbA==
X-Gm-Message-State: AOJu0YwxhTP/0tkOCgFEm79abEY5v/mvsMyJ5dhMqe8nKPlUCm7MR0ii
        97Q+9dmX/4KTlMc2wY/N6bI=
X-Google-Smtp-Source: AGHT+IEBdLrrqIFZid4k3hO5NBiGT4WuxXSRg5sgzPaCRaYX3sRhKvrHQlrjem3TuOVmnbCYqIBEHg==
X-Received: by 2002:a17:906:9d0b:b0:9e6:7e6c:4de4 with SMTP id fn11-20020a1709069d0b00b009e67e6c4de4mr3244649ejc.35.1700748219229;
        Thu, 23 Nov 2023 06:03:39 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id z2-20020a170906074200b009d268e3b801sm823125ejb.37.2023.11.23.06.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 06:03:38 -0800 (PST)
From:   mitrutzceclan <mitrutzceclan@gmail.com>
X-Google-Original-From: mitrutzceclan <CeclanDumitru>
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
        linux-kernel@vger.kernel.org,
        Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v5 1/2] dt-bindings: adc: add AD7173
Date:   Thu, 23 Nov 2023 16:02:55 +0200
Message-ID: <20231123140320.30409-1-user@HYB-hhAwRlzzMZb>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dumitru Ceclan <mitrutzceclan@gmail.com>

The AD7173 family offer a complete integrated Sigma-Delta ADC solution
which can be used in high precision, low noise single channel applications
or higher speed multiplexed applications. The Sigma-Delta ADC is intended
primarily for measurement of signals close to DC but also delivers
outstanding performance with input bandwidths out to ~10kHz.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
V4 -> V5
 - Use string enum instead of integers for "adi,reference-select"
 - Fix conditional checking in regards to compatible

 .../bindings/iio/adc/adi,ad7173.yaml          | 169 ++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
new file mode 100644
index 000000000000..32a59a2f2e91
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -0,0 +1,169 @@
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
+  refin-supply:
+    description: external reference supply, can be used as reference for conversion.
+
+  refin2-supply:
+    description: external reference supply, can be used as reference for conversion.
+
+  avdd-supply:
+    description: avdd supply, can be used as reference for conversion.
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
+        enum:
+          - refin
+          - refin2
+          - refout-avss
+          - avdd
+        default: refout-avss
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
2.42.0

