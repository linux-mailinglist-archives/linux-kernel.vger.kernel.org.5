Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474ED7EF695
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346102AbjKQQvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQQu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:50:59 -0500
X-Greylist: delayed 464 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Nov 2023 08:50:55 PST
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64277D56;
        Fri, 17 Nov 2023 08:50:55 -0800 (PST)
Received: from localhost.localdomain (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id 9F67828F040;
        Fri, 17 Nov 2023 16:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1700239386;
        bh=QT8vpu+ylcxkag8lhmcsJJ4NYnz4R5VzA35fbKzvegw=;
        h=From:To:Cc:Subject:Date;
        b=KzLG9mzbk+hWS8oRpqEdF1tdUD+MXGnWAHpfXJv9gHmgxJRzWGsSxxrsd0Nekco0C
         6M/W5hHuVzMAim1hPU9h6PetYh7L3opB3w3T04s8eC5mjMKYmzyz8LiDcMt05yfQ6J
         +YEWRAUQJRymrrJCaWtQllJD9LB/xMl0234dafvs=
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     petre.rodan@subdimension.ro, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Date:   Fri, 17 Nov 2023 18:42:05 +0200
Message-ID: <20231117164232.8474-1-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds binding for digital Honeywell TruStability HSC and SSC series
pressure and temperature sensors.

Datasheet:
 [HSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
 [SSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 .../iio/pressure/honeywell,hsc030pa.yaml     | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,hsc0030pa.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
new file mode 100644
index 000000000000..777710790696
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/honeywell,hsc030pa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Honeywell TruStability HSC and SSC pressure sensor families
+
+maintainers:
+  - Petre Rodan <petre.rodan@subdimension.ro>
+
+description: |
+  support for Honeywell TruStability HSC and SSC digital pressure sensor
+  families.
+
+  These sensors have either an I2C, an SPI or an analog interface. Only the
+  digital versions are supported by this driver.
+
+  There are 118 models with different pressure ranges available in each family.
+  The vendor calls them "HSC series" and "SSC series". All of them have an
+  identical programming model but differ in pressure range, unit and transfer
+  function.
+
+  To support different models one need to specify the pressure range as well as
+  the transfer function. Pressure range can either be provided via range_str or
+  in case it's a custom chip via numerical range limits converted to pascals.
+
+  The transfer function defines the ranges of raw conversion values delivered
+  by the sensor. pmin-pascal and pmax-pascal corespond to the minimum and
+  maximum pressure that can be measured.
+
+  Specifications about the devices can be found at:
+  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
+  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf
+
+properties:
+  compatible:
+    enum:
+      - honeywell,hsc
+      - honeywell,ssc
+
+  reg:
+    maxItems: 1
+
+  honeywell,transfer-function:
+    description: |
+      Transfer function which defines the range of valid values delivered by
+      the sensor.
+      0 - A, 10% to 90% of 2^14
+      1 - B, 5% to 95% of 2^14
+      2 - C, 5% to 85% of 2^14
+      3 - F, 4% to 94% of 2^14
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  honeywell,range_str:
+    description: |
+      Five character string that defines "pressure range, unit and type"
+      as part of the device nomenclature. In the unlikely case of a custom
+      chip, set to "NA" and provide honeywell,pmin-pascal honeywell,pmax-pascal
+    enum: [ "001BA", "1.6BA", "2.5BA", "004BA", "006BA", "010BA", "1.6MD",
+            "2.5MD", "004MD", "006MD", "010MD", "016MD", "025MD", "040MD",
+            "060MD", "100MD", "160MD", "250MD", "400MD", "600MD", "001BD",
+            "1.6BD", "2.5BD", "004BD", "2.5MG", "004MG", "006MG", "010MG",
+            "016MG", "025MG", "040MG", "060MG", "100MG", "160MG", "250MG",
+            "400MG", "600MG", "001BG", "1.6BG", "2.5BG", "004BG", "006BG",
+            "010BG", "100KA", "160KA", "250KA", "400KA", "600KA", "001GA",
+            "160LD", "250LD", "400LD", "600LD", "001KD", "1.6KD", "2.5KD",
+            "004KD", "006KD", "010KD", "016KD", "025KD", "040KD", "060KD",
+            "100KD", "160KD", "250KD", "400KD", "250LG", "400LG", "600LG",
+            "001KG", "1.6KG", "2.5KG", "004KG", "006KG", "010KG", "016KG",
+            "025KG", "040KG", "060KG", "100KG", "160KG", "250KG", "400KG",
+            "600KG", "001GG", "015PA", "030PA", "060PA", "100PA", "150PA",
+            "0.5ND", "001ND", "002ND", "004ND", "005ND", "010ND", "020ND",
+            "030ND", "001PD", "005PD", "015PD", "030PD", "060PD", "001NG",
+            "002NG", "004NG", "005NG", "010NG", "020NG", "030NG", "001PG",
+            "005PG", "015PG", "030PG", "060PG", "100PG", "150PG", "NA" ]
+    $ref: /schemas/types.yaml#/definitions/string
+
+  honeywell,pmin-pascal:
+    description: |
+      Minimum pressure value the sensor can measure in pascal.
+      To be specified only if honeywell,range_str is set to "NA".
+    $ref: /schemas/types.yaml#/definitions/int32
+
+  honeywell,pmax-pascal:
+    description: |
+      Maximum pressure value the sensor can measure in pascal.
+      To be specified only if honeywell,range_str is set to "NA".
+    $ref: /schemas/types.yaml#/definitions/int32
+
+  vdd-supply:
+    description: |
+      Provide VDD power to the sensor (either 3.3V or 5V depending on the chip).
+      Optional, activate only if required by the target board.
+
+  spi-max-frequency:
+    description: SPI clock to be kept between 50 and 800kHz
+
+  clock-frequency:
+    description: i2c clock to be kept between 100 and 400kHz
+
+required:
+  - compatible
+  - reg
+  - honeywell,transfer-function
+  - honeywell,range_str
+  - clock-frequency
+  - spi-max-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        status = "okay";
+        clock-frequency = <400000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        HSCMRNN030PA2A3@28 {
+          status = "okay";
+          compatible = "honeywell,hsc";
+          reg = <0x28>;
+          honeywell,transfer-function = <0>;
+          honeywell,range_str = "030PA";
+          honeywell,pmin-pascal = <0>;
+          honeywell,pmax-pascal = <206850>;
+
+		      //vdd-supply = <&foo>;
+        };
+    };
+
+    spi {
+        # note that MOSI is not required by this sensor
+        status = "okay";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&spi0_pins>;
+
+        channel@0{
+          status = "disabled";
+          reg = <0>;
+        };
+
+        HSCMLNN100PASA3@0 {
+          status = "okay";
+          compatible = "honeywell,hsc";
+		      reg = <0>;
+		      spi-max-frequency = <800000>;
+
+		      honeywell,transfer-function = <0>;
+		      honeywell,range_str = "100PA";
+
+		      // in case of a custom range, use NA as range_str
+		      // and populate pmin-pascal and pmax-pascal
+		      // with the range limits converted into pascals
+		      //honeywell,range_str = "NA";
+		      //honeywell,pmin-pascal = <0>;
+		      //honeywell,pmax-pascal = <206850>;
+
+		      //vdd-supply = <&foo>;
+	      };
+    };
+
-- 
2.41.0

