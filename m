Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1567E99DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjKMKM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjKMKM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:12:26 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F347AD4C;
        Mon, 13 Nov 2023 02:12:22 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AD86qPE006042;
        Mon, 13 Nov 2023 05:11:47 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3uaqmjkyr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 05:11:46 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3ADABjri000521
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Nov 2023 05:11:45 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 13 Nov
 2023 05:11:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 13 Nov 2023 05:11:44 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.148])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3ADABThw009585;
        Mon, 13 Nov 2023 05:11:31 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/2] dt-bindings: rtc: max31335: add max31335 bindings
Date:   Mon, 13 Nov 2023 12:11:06 +0200
Message-ID: <20231113101123.34767-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: pEIhBBQ2fyYa-wPUJcjj5ldSxRYQc_G4
X-Proofpoint-ORIG-GUID: pEIhBBQ2fyYa-wPUJcjj5ldSxRYQc_G4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_24,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311130083
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Analog Devices MAX31335 device tree bindings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../devicetree/bindings/rtc/adi,max31335.yaml | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/adi,max31335.yaml

diff --git a/Documentation/devicetree/bindings/rtc/adi,max31335.yaml b/Documentation/devicetree/bindings/rtc/adi,max31335.yaml
new file mode 100644
index 000000000000..0125cf6727cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/adi,max31335.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/adi,max31335.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX31335 RTC
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description:
+  Analog Devices MAX31335 I2C RTC ±2ppm Automotive Real-Time Clock with
+  Integrated MEMS Resonator.
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: adi,max31335
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#clock-cells":
+    description:
+      RTC can be used as a clock source through its clock output pin.
+    const: 0
+
+  adi,tc-diode:
+    description:
+      Select the diode configuration for the trickle charger.
+      schottky - Schottky diode in series.
+      standard+schottky - standard diode + Schottky diode in series.
+    enum: [schottky, standard+schottky]
+
+  trickle-resistor-ohms:
+    description:
+      Selected resistor for trickle charger. Should be specified if trickle
+      charger should be enabled.
+    enum: [3000, 6000, 11000]
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@68 {
+            compatible = "adi,max31335";
+            reg = <0x68>;
+            pinctrl-0 = <&rtc_nint_pins>;
+            interrupts-extended = <&gpio1 16 IRQ_TYPE_LEVEL_HIGH>;
+            aux-voltage-chargeable = <1>;
+            trickle-resistor-ohms = <6000>;
+            adi,tc-diode = "schottky";
+        };
+    };
+...
-- 
2.42.0

