Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10D77F5B95
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbjKWJqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344449AbjKWJpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:45:44 -0500
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970CE2110;
        Thu, 23 Nov 2023 01:44:39 -0800 (PST)
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AN7S7oX021016;
        Thu, 23 Nov 2023 04:44:18 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3uj2ch0fkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 04:44:18 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3AN9iHuo035654
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Nov 2023 04:44:17 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 23 Nov
 2023 04:44:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 23 Nov 2023 04:44:16 -0500
Received: from KPALLER2-L02.ad.analog.com (KPALLER2-L02.ad.analog.com [10.117.220.25])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3AN9i3Rf026190;
        Thu, 23 Nov 2023 04:44:06 -0500
From:   Kim Seer Paller <kimseer.paller@analog.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: iio: frequency: add admfm2000
Date:   Thu, 23 Nov 2023 17:43:56 +0800
Message-ID: <20231123094357.222371-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: QUbZ20-qEl5F0MkPFeQwlvFjvdhVQkoI
X-Proofpoint-ORIG-GUID: QUbZ20-qEl5F0MkPFeQwlvFjvdhVQkoI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_07,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311060001 definitions=main-2311230069
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dual microwave down converter module with input RF and LO frequency
ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
for each down conversion path.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
V3 -> V4: Updated the description of the properties with multiple entries and
          defined the order.
V2 -> V3: Adjusted indentation to resolve wrong indentation warning. 
          Changed node name to converter. Updated the descriptions to clarify
          the properties.
V1 -> V2: Removed '|' after description. Specified the pins connected to
          the GPIOs. Added additionalProperties: false. Changed node name to gpio.
          Aligned < syntax with the previous syntax in the examples.

 .../bindings/iio/frequency/adi,admfm2000.yaml | 154 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
new file mode 100644
index 000000000..037438737
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2023 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,admfm2000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADMFM2000 Dual Microwave Down Converter
+
+maintainers:
+  - Kim Seer Paller <kimseer.paller@analog.com>
+
+description:
+  Dual microwave down converter module with input RF and LO frequency ranges
+  from 0.5 to 32 GHz and an output IF frequency range from 0.1 to 8 GHz.
+  It consists of a LNA, mixer, IF filter, DSA, and IF amplifier for each down
+  conversion path.
+
+properties:
+  compatible:
+    enum:
+      - adi,admfm2000
+
+  switch1-gpios:
+    items:
+      - description: B15 GPIO, when high (and B16 low) channel 1 is in
+          Direct IF mode.
+      - description: B16 GPIO, when high (and B15 low) channel 1 is in
+          Mixer mode.
+
+  switch2-gpios:
+    items:
+      - description: K14 GPIO, when high (and L14 low) channel 2 is in
+          Mixer mode.
+      - description: L14 GPIO, when high (and K14 low) channel 2 is in
+          Direct IF mode.
+
+  attenuation1-gpios:
+    description: |
+      Choice of attenuation:
+      D15 D14 C16 C15 C14
+      1   1   1   1   1   0 dB
+      1   1   1   1   0   -1 dB
+      1   1   1   0   1   -2 dB
+      1   1   0   1   1   -4 dB
+      1   0   1   1   1   -8 dB
+      0   1   1   1   1   -16 dB
+      0   0   0   0   0   -31 dB
+
+    items:
+      - description: C14 GPIO
+      - description: C15 GPIO
+      - description: C16 GPIO
+      - description: D14 GPIO
+      - description: D15 GPIO
+
+  attenuation2-gpios:
+    description: |
+      Choice of attenuation:
+      M16 M15 M14 L16 L15
+      1   1   1   1   1   0 dB
+      1   1   1   1   0   -1 dB
+      1   1   1   0   1   -2 dB
+      1   1   0   1   1   -4 dB
+      1   0   1   1   1   -8 dB
+      0   1   1   1   1   -16 dB
+      0   0   0   0   0   -31 dB
+
+    items:
+      - description: L15 GPIO
+      - description: L16 GPIO
+      - description: M14 GPIO
+      - description: M15 GPIO
+      - description: M16 GPIO
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^channel@[0-1]$":
+    type: object
+    description: Represents a channel of the device.
+
+    additionalProperties: false
+
+    properties:
+      reg:
+        description:
+          The channel number.
+        minimum: 0
+        maximum: 1
+
+      adi,mode:
+        description:
+          RF path selected for the channel.
+            0 - Direct IF mode
+            1 - Mixer mode
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1]
+
+    required:
+      - reg
+      - adi,mode
+
+required:
+  - compatible
+  - switch1-gpios
+  - switch2-gpios
+  - attenuation1-gpios
+  - attenuation2-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    converter {
+      compatible = "adi,admfm2000";
+
+      switch1-gpios = <&gpio 1 GPIO_ACTIVE_LOW>,
+                      <&gpio 2 GPIO_ACTIVE_HIGH>;
+
+      switch2-gpios = <&gpio 3 GPIO_ACTIVE_LOW>,
+                      <&gpio 4 GPIO_ACTIVE_HIGH>;
+
+      attenuation1-gpios = <&gpio 17 GPIO_ACTIVE_LOW>,
+                           <&gpio 22 GPIO_ACTIVE_LOW>,
+                           <&gpio 23 GPIO_ACTIVE_LOW>,
+                           <&gpio 24 GPIO_ACTIVE_LOW>,
+                           <&gpio 25 GPIO_ACTIVE_LOW>;
+
+      attenuation2-gpios = <&gpio 0 GPIO_ACTIVE_LOW>,
+                           <&gpio 5 GPIO_ACTIVE_LOW>,
+                           <&gpio 6 GPIO_ACTIVE_LOW>,
+                           <&gpio 16 GPIO_ACTIVE_LOW>,
+                           <&gpio 26 GPIO_ACTIVE_LOW>;
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      channel@0 {
+        reg = <0>;
+        adi,mode = <1>;
+      };
+
+      channel@1 {
+        reg = <1>;
+        adi,mode = <1>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 0e79e24b6..f1692ec68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1247,6 +1247,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
 F:	drivers/hwmon/adm1177.c
 
+ANALOG DEVICES INC ADMFM2000 DRIVER
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
+
 ANALOG DEVICES INC ADMV1013 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org

base-commit: c2d5304e6c648ebcf653bace7e51e0e6742e46c8
-- 
2.34.1

