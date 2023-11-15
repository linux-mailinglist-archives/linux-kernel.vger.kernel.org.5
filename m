Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F8D7EC3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343989AbjKONps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbjKONpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:45:40 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801A39B;
        Wed, 15 Nov 2023 05:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700055936; x=1731591936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OeuBwu619sZ9CKoQPi5K5tN9S8LiI/QU+WIb+tJzElw=;
  b=K5qR9s7unnXRV3gVy9PsYjzG1vlOI8nl2W8EmYvJpcwh++32NUETLJyE
   fY6lW/X0ybZMYqGCElq5mqVwaGo6qP31u+ogmM5jKb4czzcfaGTNV3pvd
   lZ509x8vT8Vw+0utX1fbUYh+msZWP1Xy85jK1dF5Ju/ylD7hj6Z+B1t2s
   o5lMcb/OSI0NROzKeQHI6mbGyMg70zNCLtB938sFoAnYi2o+rvbdHlj4m
   ph7JAHJ11osBg0YCejBqPDTdf1ukG1qF/5jCAHRQquaAsJc6t80fMJAxd
   msf3jetbR6zX3xEFAorxRlSxXf+4kSrCLLEyi0iaDGrMGA3cIYUjNvJ09
   g==;
X-CSE-ConnectionGUID: 2CxX/TgFSY+eV5q6XTnYdw==
X-CSE-MsgGUID: vg1bWUbUSr6+Li1euWtieA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="178883589"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2023 06:45:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Nov 2023 06:45:03 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 15 Nov 2023 06:45:00 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: adding support for PAC193X
Date:   Wed, 15 Nov 2023 15:44:52 +0200
Message-ID: <20231115134453.6656-2-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115134453.6656-1-marius.cristea@microchip.com>
References: <20231115134453.6656-1-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Cristea <marius.cristea@microchip.com>

This is the device tree schema for iio driver for
Microchip PAC193X series of Power Monitors with Accumulator.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 .../bindings/iio/adc/microchip,pac1934.yaml   | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
new file mode 100644
index 000000000000..2609cb19c377
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/microchip,pac1934.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PAC1934 Power Monitors with Accumulator
+
+maintainers:
+  - Marius Cristea <marius.cristea@microchip.com>
+
+description: |
+  This device is part of the Microchip family of Power Monitors with Accumulator.
+  The datasheet for PAC1931, PAC1932, PAC1933 and PAC1934 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/PAC1931-Family-Data-Sheet-DS20005850E.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,pac1931
+      - microchip,pac1932
+      - microchip,pac1933
+      - microchip,pac1934
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+  microchip,slow-io:
+    type: boolean
+    description: |
+      A GPIO used to trigger a change is sampling rate (lowering the chip power consumption).
+      If configured in SLOW mode, if this pin is forced high, sampling rate is forced to eight
+      samples/second. When it is forced low, the sampling rate is 1024 samples/second unless
+      a different sample rate has been programmed.
+
+patternProperties:
+  "^channel@[1-4]+$":
+    type: object
+    $ref: adc.yaml
+    description: Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        items:
+          minimum: 1
+          maximum: 4
+
+      shunt-resistor-micro-ohms:
+        description: |
+          Value in micro Ohms of the shunt resistor connected between
+          the SENSE+ and SENSE- inputs, across which the current is measured. Value
+          is needed to compute the scaling of the measured current.
+
+    required:
+      - reg
+      - shunt-resistor-micro-ohms
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: interrupts
+    then:
+      properties:
+        microchip,slow-io: false
+    else:
+      if:
+        properties:
+          compatible:
+            contains:
+              const: microchip,slow-io
+      then:
+        properties:
+          interrupts: false
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pac193x: power-monitor@10 {
+            compatible = "microchip,pac1934";
+            reg = <0x10>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@1 {
+                reg = <0x1>;
+                shunt-resistor-micro-ohms = <24900000>;
+                label = "CPU";
+            };
+
+            channel@2 {
+                reg = <0x2>;
+                shunt-resistor-micro-ohms = <49900000>;
+                label = "GPU";
+            };
+
+            channel@3 {
+                reg = <0x3>;
+                shunt-resistor-micro-ohms = <75000000>;
+                label = "MEM";
+                bipolar;
+            };
+
+            channel@4 {
+                reg = <0x4>;
+                shunt-resistor-micro-ohms = <100000000>;
+                label = "NET";
+                bipolar;
+            };
+        };
+    };
+
+...
-- 
2.34.1

