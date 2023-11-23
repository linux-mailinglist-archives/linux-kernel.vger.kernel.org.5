Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC17F6442
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345077AbjKWQmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjKWQmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:42:44 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294310E6;
        Thu, 23 Nov 2023 08:42:51 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AN9akVn030692;
        Thu, 23 Nov 2023 11:42:37 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3uhxk5th9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 11:42:37 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3ANGgaAH045872
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Nov 2023 11:42:36 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 23 Nov 2023 11:42:35 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 23 Nov 2023 11:42:35 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 23 Nov 2023 11:42:35 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3ANGgMhn019840;
        Thu, 23 Nov 2023 11:42:25 -0500
From:   Marcelo Schmitt <marcelo.schmitt@analog.com>
To:     <paul.cercueil@analog.com>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC:     Marcelo Schmitt <marcelo.schmitt@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/7] dt-bindings: iio: Add binding documentation for AD7091R-8
Date:   Thu, 23 Nov 2023 13:42:21 -0300
Message-ID: <8ce972a3708f7789237c86c44e23cdcb23a35103.1700751907.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: zc5I5fwgFqiZNYLULKEDHb6nP3v7qo-Z
X-Proofpoint-ORIG-GUID: zc5I5fwgFqiZNYLULKEDHb6nP3v7qo-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311060001
 definitions=main-2311230122
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding documentation for AD7091R-8.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 .../bindings/iio/adc/adi,ad7091r8.yaml        | 101 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
new file mode 100644
index 000000000000..3f09f3091a90
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7091r8.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7091R8 8-Channel 12-Bit ADC
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+
+description: |
+  Analog Devices AD7091R-8 8-Channel 12-Bit ADC
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7091R-2_7091R-4_7091R-8.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7091r2
+      - adi,ad7091r4
+      - adi,ad7091r8
+
+  reg:
+    maxItems: 1
+
+  vref-supply: true
+
+  spi-max-frequency: true
+
+  adi,conversion-start-gpios:
+    description:
+      Device tree identifier of the CONVST pin.
+      This logic input is used to initiate conversions on the analog
+      input channels.
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+patternProperties:
+  "^channel@[0-7]$":
+    $ref: adc.yaml
+    type: object
+    description: Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 7
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - adi,conversion-start-gpios
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  # AD7091R-2 does not have ALERT/BUSY/GPO pin
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7091r4
+              - adi,ad7091r8
+    then:
+      properties:
+        interrupts: true
+    else:
+      properties:
+        interrupts: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+                compatible = "adi,ad7091r8";
+                reg = <0x0>;
+                spi-max-frequency = <45454545>;
+                vref-supply = <&adc_vref>;
+                adi,conversion-start-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
+                reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+                interrupts = <22 IRQ_TYPE_EDGE_FALLING>;
+                interrupt-parent = <&gpio>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 008f0e73bead..6e7c6c866396 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1132,6 +1132,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
 F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.c
 F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.h
 F:	drivers/iio/adc/drivers/iio/adc/ad7091r5.c
-- 
2.42.0

