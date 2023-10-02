Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6837B500A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbjJBKTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbjJBKTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:19:31 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C284FB0;
        Mon,  2 Oct 2023 03:19:28 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3927iLD8026586;
        Mon, 2 Oct 2023 06:19:02 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tf0tf69tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 06:19:02 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 392AJ04P059434
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Oct 2023 06:19:00 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 2 Oct 2023
 06:18:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 2 Oct 2023 06:18:59 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.194])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 392AIk8G001378;
        Mon, 2 Oct 2023 06:18:49 -0400
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
Subject: [PATCH v2 1/2] dt-bindings: hwmon: ltc2991: add bindings
Date:   Mon, 2 Oct 2023 13:18:14 +0300
Message-ID: <20231002101835.39624-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: pGbmJk5q5RC2OGC3CG4wuNMU-ko32tVH
X-Proofpoint-ORIG-GUID: pGbmJk5q5RC2OGC3CG4wuNMU-ko32tVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_03,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310020076
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
changes in v2:
 - make compatible const type
 - remove `|` where not necessary
 - switch to micro-ohms for the shunt resistor property
 - add vendor prefix for temperature-enable
 .../bindings/hwmon/adi,ltc2991.yaml           | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
new file mode 100644
index 000000000000..3811ea07a04f
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
+          The value of curent sense resistor in miliohms. Enables differential
+          input pair.
+
+      adi,temperature-enable:
+        description:
+          Enables temperature readings for a input pair.
+        type: boolean
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

