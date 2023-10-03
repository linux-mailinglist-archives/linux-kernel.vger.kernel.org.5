Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C4E7B630E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbjJCIBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjJCIBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:01:51 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E3BA1;
        Tue,  3 Oct 2023 01:01:49 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39376Fua020801;
        Tue, 3 Oct 2023 04:01:27 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tegk3ypcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 04:01:26 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 39381PvK027344
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 04:01:25 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 3 Oct 2023
 04:01:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 3 Oct 2023 04:01:24 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.194])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 393814Mx012373;
        Tue, 3 Oct 2023 04:01:07 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: hwmon: ltc2991: add bindings
Date:   Tue, 3 Oct 2023 11:00:39 +0300
Message-ID: <20231003080059.8041-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: RnXSYrQcCB2MDOXZu0k9c1grQvddaMBY
X-Proofpoint-GUID: RnXSYrQcCB2MDOXZu0k9c1grQvddaMBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2309180000
 definitions=main-2310030056
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for ltc2991 octal i2c voltage, current and temperature
monitor.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - expand description for differential channels and temperature channels by
   mentioning the pin configuration that is set via these properties.
 - add `additionalProperties: false` for the channel properties
 - make `reg` required for channel properties
 - make `adi,temperature-enable` and `shunt-resistor-micro-ohms` mutually
   exclusive following the approach suggested in review.
 .../bindings/hwmon/adi,ltc2991.yaml           | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
new file mode 100644
index 000000000000..011e5b65c79c
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/adi,ltc2991.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LTC2991 Octal I2C Voltage, Current and Temperature Monitor
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+  The LTC2991 is used to monitor system temperatures, voltages and currents.
+  Through the I2C serial interface, the eight monitors can individually measure
+  supply voltages and can be paired for differential measurements of current
+  sense resistors or temperature sensing transistors.
+
+  Datasheet:
+    https://www.analog.com/en/products/ltc2991.html
+
+properties:
+  compatible:
+    const: adi,ltc2991
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  vcc-supply: true
+
+patternProperties:
+  "^channel@[0-3]$":
+    type: object
+    description:
+      Represents the differential/temperature channels.
+
+    properties:
+      reg:
+        description:
+          The channel number. LTC2991 can monitor 4 currents/temperatures.
+        items:
+          minimum: 0
+          maximum: 3
+
+      shunt-resistor-micro-ohms:
+        description:
+          The value of curent sense resistor in micro ohms. Pin configuration is
+          set for differential input pair.
+
+      adi,temperature-enable:
+        description:
+          Enables temperature readings. Pin configuration is set for remote
+          diode temperature measurement.
+        type: boolean
+
+    required:
+      - reg
+
+    allOf:
+      - if:
+          required:
+            - shunt-resistor-micro-ohms
+        then:
+          properties:
+            adi,temperature-enable: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hwmon@48 {
+            compatible = "adi,ltc2991";
+            reg = <0x48>;
+            vcc-supply = <&vcc>;
+        };
+    };
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hwmon@48 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            compatible = "adi,ltc2991";
+            reg = <0x48>;
+            vcc-supply = <&vcc>;
+
+            channel@0 {
+                    reg = <0x0>;
+                    shunt-resistor-micro-ohms = <100000>;
+            };
+
+            channel@1 {
+                    reg = <0x1>;
+                    shunt-resistor-micro-ohms = <100000>;
+            };
+
+            channel@2 {
+                    reg = <0x2>;
+                    adi,temperature-enable;
+            };
+
+            channel@3 {
+                    reg = <0x3>;
+                    adi,temperature-enable;
+            };
+        };
+    };
+...
-- 
2.42.0

