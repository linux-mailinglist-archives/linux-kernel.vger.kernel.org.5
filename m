Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DCF7AEEF0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjIZOJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjIZOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:09:00 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ACB101;
        Tue, 26 Sep 2023 07:08:53 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38QDe2TP032200;
        Tue, 26 Sep 2023 10:08:37 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tbx5xs6dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 10:08:36 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 38QE7V5L048058
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 10:07:31 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 26 Sep 2023 10:07:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 26 Sep 2023 10:07:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 26 Sep 2023 10:07:30 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.194])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 38QE7Gh8009810;
        Tue, 26 Sep 2023 10:07:19 -0400
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
Subject: [PATCH 1/2] dt-bindings: hwmon: ltc2991: add bindings
Date:   Tue, 26 Sep 2023 17:05:29 +0300
Message-ID: <20230926140544.80934-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 0imFy5U2fkCxeEN4rjH8_SvFYCuj7IFn
X-Proofpoint-GUID: 0imFy5U2fkCxeEN4rjH8_SvFYCuj7IFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_10,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309260124
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
 .../bindings/hwmon/adi,ltc2991.yaml           | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
new file mode 100644
index 000000000000..6174e0113ef8
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
@@ -0,0 +1,114 @@
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
+    enum:
+      - adi,ltc2991
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
+    description: |
+      Represents the differential/temperature channels.
+
+    properties:
+      reg:
+        description: |
+          The channel number. LTC2992 can monitor 4 currents/temperatures.
+        items:
+          minimum: 0
+          maximum: 3
+
+      shunt-resistor-mili-ohms:
+        description:
+          The value of curent sense resistor in miliohms. Enables differential
+          input pair.
+
+      temperature-enable:
+        description:
+          Enables temperature readings for a input pair.
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
+                    shunt-resistor-mili-ohms = <100>;
+            };
+
+            channel@1 {
+                    reg = <0x1>;
+                    shunt-resistor-mili-ohms = <100>;
+            };
+
+            channel@2 {
+                    reg = <0x2>;
+                    temperature-enable;
+            };
+
+            channel@3 {
+                    reg = <0x3>;
+                    temperature-enable;
+            };
+        };
+    };
+...
-- 
2.42.0

