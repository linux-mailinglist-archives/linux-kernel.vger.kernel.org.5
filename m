Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096337ED8C0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 01:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344246AbjKPA5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 19:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPA53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 19:57:29 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAC6194;
        Wed, 15 Nov 2023 16:57:25 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AG0uiMi006003;
        Wed, 15 Nov 2023 19:57:05 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3uaqmk0xre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 19:57:04 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3AG0v31H031913
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Nov 2023 19:57:03 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 15 Nov 2023 19:57:02 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 15 Nov 2023 19:57:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 15 Nov 2023 19:57:02 -0500
Received: from KPALLER2-L02.ad.analog.com (KPALLER2-L02.ad.analog.com [10.117.220.22])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3AG0un02012837;
        Wed, 15 Nov 2023 19:56:51 -0500
From:   Kim Seer Paller <kimseer.paller@analog.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Kim Seer Paller" <kimseer.paller@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: frequency: add admfm2000
Date:   Thu, 16 Nov 2023 08:56:42 +0800
Message-ID: <20231116005643.245314-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: MXEbBJLSvpRIMrRLAFdEeS146aq_852f
X-Proofpoint-ORIG-GUID: MXEbBJLSvpRIMrRLAFdEeS146aq_852f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311160006
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
 .../bindings/iio/frequency/adi,admfm2000.yaml | 128 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
new file mode 100644
index 000000000..7ea5ede7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
@@ -0,0 +1,128 @@
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
+description: |
+    Dual microwave down converter module with input RF and LO frequency ranges
+    from 0.5 to 32 GHz and an output IF frequency range from 0.1 to 8 GHz.
+    It consists of a LNA, mixer, IF filter, DSA, and IF amplifier for each down
+    conversion path.
+
+properties:
+  compatible:
+    enum:
+      - adi,admfm2000
+
+  switch1-gpios:
+    description:
+      Must contain an array of 2 GPIO specifiers, referring to the GPIO pins
+      connected to the channel 1 switch controls.
+    minItems: 2
+    maxItems: 2
+
+  switch2-gpios:
+    description:
+      Must contain an array of 2 GPIO specifiers, referring to the GPIO pins
+      connected to the channel 2 switch controls.
+    minItems: 2
+    maxItems: 2
+
+  attenuation1-gpios:
+    description:
+      Must contain an array of 5 GPIO specifiers, referring to the GPIO pins
+      connected to the channel 1 DSA attenuation controls.
+    minItems: 5
+    maxItems: 5
+
+  attenuation2-gpios:
+    description:
+      Must contain an array of 5 GPIO specifiers, referring to the GPIO pins
+      connected to the channel 2 DSA attenuation controls.
+    minItems: 5
+    maxItems: 5
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
+    admfm2000 {
+      compatible = "adi,admfm2000";
+
+      switch1-gpios = <&gpio 1 GPIO_ACTIVE_LOW>,
+        <&gpio 2 GPIO_ACTIVE_HIGH>;
+
+      switch2-gpios = <&gpio 3 GPIO_ACTIVE_LOW>,
+        <&gpio 4 GPIO_ACTIVE_HIGH>;
+
+      attenuation1-gpios = <&gpio 17 GPIO_ACTIVE_LOW>,
+        <&gpio 22 GPIO_ACTIVE_LOW>,
+        <&gpio 23 GPIO_ACTIVE_LOW>,
+        <&gpio 24 GPIO_ACTIVE_LOW>,
+        <&gpio 25 GPIO_ACTIVE_LOW>;
+
+      attenuation2-gpios = <&gpio 0 GPIO_ACTIVE_LOW>,
+        <&gpio 5 GPIO_ACTIVE_LOW>,
+        <&gpio 6 GPIO_ACTIVE_LOW>,
+        <&gpio 16 GPIO_ACTIVE_LOW>,
+        <&gpio 26 GPIO_ACTIVE_LOW>;
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
index 5c9f868e1..505eb57eb 100644
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

base-commit: c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
-- 
2.34.1

