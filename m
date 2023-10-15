Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107267C9ADA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjJOSpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 14:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOSpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 14:45:33 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB94AB;
        Sun, 15 Oct 2023 11:45:29 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so601583866b.3;
        Sun, 15 Oct 2023 11:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697395528; x=1698000328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kTpg3JCWb8aZBFizVHxcNIM+2U6d4eSO0KhtJCpgmZw=;
        b=jJl5ZqcmhQaRf6o9SKO6n80JFaBOTbL8dafa3+ezWbwYKFOPpHJATnbAaOW/Y5FeuR
         Xex1gLUuM6Abn8WINM5Lln+GRTuFsz1CC3SLZBwxJESVrCFC0iJsVooAOsGTGM0pBpIb
         AthWK5I8LEU+6kF5GOWh0oJopjjdxCuXvFe0JoLTBvdTWD59DKeG8T5YV+tfn1gCiJy5
         lGV+lyGaKKKlS6bXOUmYF6+Bhgb5NObjAqvvHyy8UUSvxe20nYEJOg2TjmEieNcjRLjE
         Ude4uqlFJQnnPRIYDwMBC31q2FTToYygoWmkuJ0xQCAVCnXUU5iyir0P+aH1TaeHGR7H
         Qr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697395528; x=1698000328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTpg3JCWb8aZBFizVHxcNIM+2U6d4eSO0KhtJCpgmZw=;
        b=ZUnZV3QDsCWOCLC3MeQ6tbVEFhxpmeq4ZAfsdt/EYNSHl2nuNhRxO4BFNt493ut/g8
         98N8GlfUrlNWS0KDju0v0dFriSPHUnO0UclCl+rI8nVSNaRhNl/OkAtEjs4p++ea1rBU
         SLOCzKUjgChIbQ7FSLy8U2csiQjRbcQNagheJK4dKSwpanbY3ROj7UwhohcBzDmt1ple
         UbfIEbzH3fRyCWzc+rGwUhNGDjBkdfV3Hkq469ONHCib6gr8pHUZ6AMPKJt9gW3tnf6H
         VlmMZnHw3972BXAVnON041O9EK3I6Qn52bGHlJMBwzbGn+EaHK9U516sfGbYTepLUlOp
         akWA==
X-Gm-Message-State: AOJu0YwMkxKlmRx9WRde6rXFkFCoeiXG6Xg60HzB0nUZ/snnHtUncI5Y
        ScLbxFMSLmrvNRs7jHZfnFJ5XWgN3ZYCSQ==
X-Google-Smtp-Source: AGHT+IFruBgtsd7n7L074+8guktrs9jivFVKOewe8Cdwla5p1EUuRb87QVzqZI+aijQrRg6gtKmqew==
X-Received: by 2002:a17:906:da8c:b0:9a2:139:f45d with SMTP id xh12-20020a170906da8c00b009a20139f45dmr34428737ejb.43.1697395528148;
        Sun, 15 Oct 2023 11:45:28 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id ga19-20020a170906b85300b0099b76c3041csm2608200ejb.7.2023.10.15.11.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 11:45:27 -0700 (PDT)
From:   werneazc@gmail.com
X-Google-Original-From: andre.werner@systec-electronic.com
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lars@metafoo.de
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: ti,ads7038: Add description for ADS7038
Date:   Sun, 15 Oct 2023 20:32:20 +0200
Message-ID: <20231015184517.3582-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
v3:
- Delete ADS7138 compatible and comments.
- Add options for CRC, status and average samples as well as
  gpio-controller.
- Update example.
---
 .../bindings/iio/adc/ti,ads7038.yaml          | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
new file mode 100644
index 000000000000..323f86c5e682
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
@@ -0,0 +1,84 @@
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
+    enum: [0,1,2,3,4,5,6,7]
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
+  gpio-controller:
+    const: true
+    decription: Marks the device node as a GPIO controller.
+
+  "#gpio-cells":
+    const: 2
+    description: Should be 2. See gpio.txt in this directory for a
+                 description of the cells format.
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - dvdd-supply
+  - gpio-controller
+  - #gpio-cells
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
+            avdd-supply = <&refin_dvdd_supply>;
+            spi-max-frequency = <10000000>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
-- 
2.42.0

