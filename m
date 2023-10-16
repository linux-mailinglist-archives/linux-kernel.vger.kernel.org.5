Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B587CA012
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjJPHDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjJPHDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:03:30 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239CAEB;
        Mon, 16 Oct 2023 00:03:28 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id e9e14a558f8ab-35749556444so12754655ab.1;
        Mon, 16 Oct 2023 00:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697439807; x=1698044607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLJbO+EIJJiDFsSKcJDqvmRwk3aK8ZgxXFUwOOoaZfU=;
        b=FHmLqwIgP8rR0HmFbrl5vT/Ybm9kKVbJAsS91URjkZbS4E4ymshzIzd/rCQdKTa06f
         y1BZHetas5CLOzxY5Q/FDG42EnIm0ZOOPIpcMO3E3bCP6hAbHJyuMSEWTDwdE6whAGlk
         ldDMY2W4yfkyNpGXvb7D96dgb4w9fjCexusSmJnlhWyERvu0kBnFARhnxM3fvCpUZ72S
         vkc5E/LmcqlCsgLRGSNH/ouoQNRq/0Njo4Kao0GiSmmpntIPk2ihuzCsBYFMHBO58Tgi
         p+lyzcmdJOgRQIgLjEA0i5nruAAktvezAp5Wj0AqQqsaElUGu2y+Waz1ts2a58hgnefX
         cLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697439807; x=1698044607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLJbO+EIJJiDFsSKcJDqvmRwk3aK8ZgxXFUwOOoaZfU=;
        b=pu4x5so2yqZkZvSblo35sNNhqsLtJMBQXQVExGgwGZKYP7tHWkPK4BZcQn3w5gJGDw
         iNpcuvDm9nSQXkqknYjkQpPiGmhP2LrBXan8i8WtkmQMFmrjUabksdXzBkbicG5EZqXO
         rWMzuAdumHWyKzTXkn7oy67AsmaUEpjCZxQTQrQwJycHRmzU15/ESogifdJ3yibFPkQI
         gW1le+eCTK9YcKsL1CtASMzY9GRncqkJ5VDUQlp4Ud6VncGKrIEKYLSyaIiKstt/eHln
         Dys2mvnItYpsiXlTyga1lTc5IaMqchmcGRKmDGK0KHz5sC41H9de7JW/0hVEAXy7yMVM
         nDKQ==
X-Gm-Message-State: AOJu0YyAU62TY+GztM2MVAeGPgZLvNGKZv+snVdU0ieGp50xpY7mZecL
        HEeiVGVWcoiGARCMltz9n24=
X-Google-Smtp-Source: AGHT+IF99mWDnJ8aI9TBkq1u3lz/abMZyyl+nEE18PPTAhSAuEy4H6ulHsglpGQiYe93QT/rMDAxeQ==
X-Received: by 2002:a05:6e02:1a48:b0:357:4779:9dbc with SMTP id u8-20020a056e021a4800b0035747799dbcmr5267997ilv.10.1697439807356;
        Mon, 16 Oct 2023 00:03:27 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id a10-20020a92d58a000000b00351076c43e3sm3244553iln.4.2023.10.16.00.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:03:26 -0700 (PDT)
From:   werneazc@gmail.com
X-Google-Original-From: andre.werner@systec-electronic.com
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lars@metafoo.de
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: ti,ads7038: Add description for ADS7038
Date:   Mon, 16 Oct 2023 09:02:04 +0200
Message-ID: <20231016070318.28355-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.42.0
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

From: Andre Werner <andre.werner@systec-electronic.com>

Add basic description for ADS7038 ADC devices.
The devicetree adds the following device specific options:

- average-samples: Program device's programmable average filter.
- crc-enabled: Enable the CRC check for SPI transfers. Sadly, this
  option has currently no effect in the driver.
- status-enabled: Enable the appending of the device's status on the
  measure value transmission.
- gpio-controller: Sadly function not implemented yet in the driver.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
v3
- Delete ADS7138 compatible and comments.
- Add options for CRC, status and average samples as well as
  gpio-controller.
- Update example.
- add regulator for digital IO voltage.
---
 .../bindings/iio/adc/ti,ads7038.yaml          | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
new file mode 100644
index 000000000000..fc1054ca93f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads7038.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS7038 and similar ADCs
+
+maintainers:
+  - Andre Werner <andre.werner@systec-electronic.com>
+
+description: |
+  Family of 7 channel, 12 bit ADCs with SPI interface.
+
+  Datasheet: https://www.ti.com/lit/gpn/ads7038
+
+properties:
+  compatible:
+    enum:
+      - ti,ads7038
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 60000000
+
+  avdd-supply:
+    description: Analog supply voltage, also used as the reference voltage to the ADC.
+
+  dvdd-supply:
+    description: Digital I/O supply voltage.
+
+  average-samples:
+    description: |
+      If specified ADC is configured for avaraging measurements (OSR_CFG Register).
+      This effects output format for measurement and sampling time.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3, 4, 5, 6, 7]
+
+  status-enabled:
+    description: |
+      If specified ADC transmits chip status (DATA_CFG Register).
+
+  crc-enabled:
+    description: |
+      Checking the integrity of the data bits exchanged over
+      SPI interface (GENERAL_CFG Register).
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description: |
+      Should be 2. See gpio.txt in this directory for a
+      description of the cells format.
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - dvdd-supply
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads7038";
+            reg = <0>;
+            avdd-supply = <&refin_avdd_supply>;
+            dvdd-supply = <&refin_dvdd_supply>;
+            spi-max-frequency = <10000000>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
-- 
2.42.0

