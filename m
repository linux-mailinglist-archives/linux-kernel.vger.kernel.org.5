Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D877F3F43
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjKVHxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbjKVHxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:53:01 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968C79D;
        Tue, 21 Nov 2023 23:52:56 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ALNnkAC013914;
        Wed, 22 Nov 2023 08:52:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=PYBD9ai4sl4Xolbd216HtolrqOUVlc2ca/ALeXci+oA=; b=gi
        Qr6GAyX3/N8/HfQiCxH9OEFTYQd3Az9q2h1U/t47n19yQPq+HoZ451EwScGJ3gMF
        2LehXR7T4AT6LD9AHeTirmu3ktdL2xjpm+COB96/1USxf+J5dbiA54NOSErKuGks
        A+rbzhrMLXQJXJrdF7pOvvpvSiSqlbwuSqECDZr22fHmAQIa17u4jYR+pyqlZxUN
        2xzdBX82wBdy3TZdviQXz1qyTPSQ71QNWFrLe12O0+u+KT//u8ZBMJjt/myN1ps9
        28fDtFtZDNqWNwCOgSfDQVyx9DwK1fm+mSfNRPZw/ApT5IYeqHlu2jw+jNaW53+S
        nF6BsMX9EqdDpSRE1pyw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ugwu0xmn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 08:52:45 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4933510002A;
        Wed, 22 Nov 2023 08:52:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3E2D52128AA;
        Wed, 22 Nov 2023 08:52:45 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 22 Nov
 2023 08:52:45 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Pavel Machek <pavel@ucw.cz>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/3] dt-bindings: media: i2c: add galaxycore,gc2145 dt-bindings
Date:   Wed, 22 Nov 2023 08:51:48 +0100
Message-ID: <20231122075154.789431-3-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122075154.789431-1-alain.volmat@foss.st.com>
References: <20231122075154.789431-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduction of the Galaxy Core GC2145 XVGA CMOS camera sensor.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/media/i2c/galaxycore,gc2145.yaml | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
new file mode 100644
index 000000000000..1726ecca4c77
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/galaxycore,gc2145.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Galaxy Core 1/5'' UXGA CMOS Image Sensor
+
+maintainers:
+  - Alain Volmat <alain.volmat@foss.st.com>
+
+description:
+  The Galaxy Core GC2145 is a 2 Megapixel CMOS image sensor, for mobile
+  phone camera applications and digital camera products. GC2145 incorporates a
+  1616V x 1232H active pixel array, on-chip 10-bit ADC, and image signal
+  processor allowing AE/AWB/interpolation/de-noise/color-conversion and
+  gamma correction. Bayer RGB, RGB565 and YCbCr 4:2:2 can be provided by the
+  sensor. It is programmable through an I2C interface. Image data is sent
+  either through a parallel interface or through MIPI CSI-2.
+
+allOf:
+  - $ref: ../video-interface-devices.yaml#
+
+properties:
+  compatible:
+    const: galaxycore,gc2145
+
+  reg:
+    const: 0x3c
+
+  clocks:
+    maxItems: 1
+
+  powerdown-gpios:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  iovdd-supply:
+    description: Power Supply for I/O circuits (1.7 - 3V).
+
+  avdd-supply:
+    description: Power for analog circuit/sensor array (2.7 - 3V).
+
+  dvdd-supply:
+    description: Power for digital core (1.7 - 1.9V).
+
+  orientation: true
+
+  rotation: true
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          link-frequencies: true
+
+        required:
+          - link-frequencies
+
+    required:
+      - endpoint
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - powerdown-gpios
+  - reset-gpios
+  - iovdd-supply
+  - avdd-supply
+  - dvdd-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        camera@3c {
+            compatible = "galaxycore,gc2145";
+            reg = <0x3c>;
+            clocks = <&clk_ext_camera>;
+            iovdd-supply = <&scmi_v3v3_sw>;
+            avdd-supply = <&scmi_v3v3_sw>;
+            dvdd-supply = <&scmi_v3v3_sw>;
+            powerdown-gpios = <&mcp23017 3 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
+            reset-gpios = <&mcp23017 4 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&mipid02_0>;
+                    data-lanes = <1 2>;
+                    link-frequencies = /bits/ 64 <120000000 192000000 240000000>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.25.1

