Return-Path: <linux-kernel+bounces-5920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E8481918A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22786B25266
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3239AEC;
	Tue, 19 Dec 2023 20:32:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2F39AD0;
	Tue, 19 Dec 2023 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJI4Nsj024775;
	Tue, 19 Dec 2023 15:32:27 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3v3g4s8f76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 15:32:26 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3BJKWPNJ064498
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Dec 2023 15:32:25 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Dec 2023 15:32:24 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Dec 2023 15:32:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 19 Dec 2023 15:32:24 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BJKW5Om030174;
	Tue, 19 Dec 2023 15:32:07 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dan.carpenter@linaro.org>,
        <dlechner@baylibre.com>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 09/11] dt-bindings: iio: Add AD7091R-8
Date: Tue, 19 Dec 2023 17:32:04 -0300
Message-ID: <632eb34801ae54feda453b6a65d60fc8ac2891fd.1703013352.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1703013352.git.marcelo.schmitt1@gmail.com>
References: <cover.1703013352.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 4pq9g2vjMxkJG4rhify5c23kyB9YT0k2
X-Proofpoint-GUID: 4pq9g2vjMxkJG4rhify5c23kyB9YT0k2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312190153

Add device tree documentation for AD7091R-8.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 .../bindings/iio/adc/adi,ad7091r5.yaml        | 82 ++++++++++++++++++-
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
index ce7ba634643c..ddec9747436c 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
@@ -4,36 +4,92 @@
 $id: http://devicetree.org/schemas/iio/adc/adi,ad7091r5.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices AD7091R5 4-Channel 12-Bit ADC
+title: Analog Devices AD7091R-2/-4/-5/-8 Multi-Channel 12-Bit ADCs
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
 
 description: |
-  Analog Devices AD7091R5 4-Channel 12-Bit ADC
+  Analog Devices AD7091R5 4-Channel 12-Bit ADC supporting I2C interface
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7091r-5.pdf
+  Analog Devices AD7091R-2/AD7091R-4/AD7091R-8 2-/4-/8-Channel 12-Bit ADCs
+  supporting SPI interface
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7091R-2_7091R-4_7091R-8.pdf
 
 properties:
   compatible:
     enum:
+      - adi,ad7091r2
+      - adi,ad7091r4
       - adi,ad7091r5
+      - adi,ad7091r8
 
   reg:
     maxItems: 1
 
+  vdd-supply:
+    description:
+      Provide VDD power to the sensor (VDD range is from 2.7V to 5.25V).
+
+  vdrive-supply:
+    description:
+      Determines the voltage level at which the interface logic will operate.
+      The V_drive voltage range is from 1.8V to 5.25V and must not exceed VDD by
+      more than 0.3V.
+
   vref-supply:
     description:
       Phandle to the vref power supply
 
-  interrupts:
+  convst-gpios:
+    description:
+      GPIO connected to the CONVST pin.
+      This logic input is used to initiate conversions on the analog
+      input channels.
     maxItems: 1
 
+  reset-gpios:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt for signaling when conversion results exceed the high limit for
+      ADC readings or fall below the low limit for them. Interrupt source must
+      be attached to ALERT/BUSY/GPO0 pin.
+    maxItems: 1
 
 required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  # AD7091R-2 does not have ALERT/BUSY/GPO pin
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7091r2
+    then:
+      properties:
+        interrupts: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7091r2
+              - adi,ad7091r4
+              - adi,ad7091r8
+    then:
+      required:
+        - convst-gpios
+
+unevaluatedProperties: false
 
 examples:
   - |
@@ -51,4 +107,22 @@ examples:
             interrupt-parent = <&gpio>;
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7091r8";
+            reg = <0x0>;
+            spi-max-frequency = <1000000>;
+            vref-supply = <&adc_vref>;
+            convst-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
+            reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+            interrupts = <22 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+        };
+    };
 ...
-- 
2.42.0


