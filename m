Return-Path: <linux-kernel+bounces-141856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64628A244B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB8A1F23B63
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C19A182A0;
	Fri, 12 Apr 2024 03:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vARRYLKU"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B43617BDD;
	Fri, 12 Apr 2024 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712892108; cv=none; b=EiHHip9S9dvcGbqCUiVpL6njlxKi8JZxkbY3TnxzRro5tJdJDUTJjn7dH75lCjnQXdcCKwgZgPzQcPcdBrYN98ELHoigShLo4tDkcvOSYAWIe4IGqdrWYZlbk6nHkkdvcOQcXAH6O7mE0uqcv3MdPV7ExoL6A3dAJ3Xlhfnja+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712892108; c=relaxed/simple;
	bh=s+F1rYLVRy1dOXfg23CCJa23oTKZl1cSQ0ziX+0Jaro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQxpfSCI0svzEBBddztF8qNgDJJ0msvmsqwX8SKys9z9ZON55EFQdptAGvlgRk4zB8hLor7KQmgT1dZeOzeoVya782uhJErgNi/wUeYmZLbwcNR6pn+hwWfczRM2zUQstH2hO9LOt1ehJleHCWuO+VHOx5KfIVj3+ABUF3gho60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vARRYLKU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C2Ov8s017716;
	Thu, 11 Apr 2024 23:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=DKIM;
	 bh=1ijHFhz8iTwpvxYF++KYxOUW8UaegzpYcDEeWD+FMxk=; b=vARRYLKUkuA/
	of8C+CSzqA6tw/4Sao5ObzY5LOcXUCGsTn6xAoMOTfkoDOASuHyv7eCsIeRoKRpl
	jDSgNqTiEimXU+Nwyu+FaQF03QKHVEDEyS5BqTUmQLcUtOQ+Jo5N6zWS4qEAXNpj
	4X2hlq0KaNdPUW7mTK6W/WJImpL1Cis/qppB8974bTxL6XArqYSxq9/Gp6iZXRLc
	nbsUksfp1HQ4Joqm49CyPXz1S++3XT+MqYOXcb5rJCTYC0IEusjlbF/oDkuU5FsE
	8JKfQxTFUwbh1pcVVTo3lVdJDFvx66uj8HZ0UhGB0kOFx4ktCKncnf0vqYa62eNq
	rxvmsQGNxQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3xek1et80t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 23:21:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 43C3LScg021567
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 23:21:28 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 11 Apr 2024 23:21:27 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 11 Apr 2024 23:21:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 11 Apr 2024 23:21:27 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.36])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 43C3L8pf021230;
	Thu, 11 Apr 2024 23:21:20 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "David Lechner" <dlechner@baylibre.com>,
        Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 1/4] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Date: Fri, 12 Apr 2024 11:20:59 +0800
Message-ID: <20240412032102.136071-2-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412032102.136071-1-kimseer.paller@analog.com>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: aV0YyGYa-J_CmqhskJGIr6HRmN35Om6P
X-Proofpoint-GUID: aV0YyGYa-J_CmqhskJGIr6HRmN35Om6P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120023

Add documentation for ltc2664 and ltc2672.

Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../bindings/iio/dac/adi,ltc2664.yaml         | 230 ++++++++++++++++++
 MAINTAINERS                                   |   8 +
 2 files changed, 238 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
new file mode 100644
index 000000000..2f581a9e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
@@ -0,0 +1,230 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ltc2664.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LTC2664 and LTC2672 DAC
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Kim Seer Paller <kimseer.paller@analog.com>
+
+description: |
+  Analog Devices LTC2664 4 channel, 16 bit, +-10V DAC
+  Analog Devices LTC2672 5 channel, 16 bit, 300mA DAC
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2664.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2672.pdf
+
+$defs:
+  toggle-operation:
+    type: object
+    description: Toggle mode channel setting.
+
+    properties:
+      reg:
+        description: Channel number.
+        minimum: 0
+        maximum: 4
+
+      adi,toggle-mode:
+        description:
+          Set the channel as a toggle enabled channel. Toggle operation enables
+          fast switching of a DAC output between two different DAC codes without
+          any SPI transaction.
+        type: boolean
+
+patternProperties:
+  "^channel@[0-4]$":
+    type: object
+
+properties:
+  compatible:
+    enum:
+      - adi,ltc2664
+      - adi,ltc2672
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 50000000
+
+  vcc-supply:
+    description: Analog Supply Voltage Input.
+
+  iovcc-supply:
+    description: Digital Input/Output Supply Voltage.
+
+  vref-supply:
+    description:
+      Reference Input/Output. The voltage at the REF pin sets the full-scale
+      range of all channels. If not provided the internal reference is used and
+      also provided on the VREF pin.
+
+  clr-gpios:
+    description:
+      If specified, it will be asserted during driver probe. As the line is
+      active low, it should be marked GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ltc2664
+    then:
+      properties:
+        adi,manual-span-operation-config:
+          description:
+            This property must mimic the MSPAN pin configurations.
+            By tying the MSPAN pins (MSP2, MSP1 and MSP0) to GND
+            and/or VCC, any output range can be hardware-configured
+            with different mid-scale or zero-scale reset options.
+            The hardware configuration is latched during power on reset
+            for proper operation.
+              0 - MPS2=GND, MPS1=GND, MSP0=GND
+              1 - MPS2=GND, MPS1=GND, MSP0=VCC
+              2 - MPS2=GND, MPS1=VCC, MSP0=GND
+              3 - MPS2=GND, MPS1=VCC, MSP0=VCC
+              4 - MPS2=VCC, MPS1=GND, MSP0=GND
+              5 - MPS2=VCC, MPS1=GND, MSP0=VCC
+              6 - MPS2=VCC, MPS1=VCC, MSP0=GND
+              7 - MPS2=VCC, MPS1=VCC, MSP0=VCC (enables SoftSpan feature)
+          $ref: /schemas/types.yaml#/definitions/uint32
+          enum: [0, 1, 2, 3, 4, 5, 6, 7]
+          default: 7
+
+      patternProperties:
+        "^channel@([0-3])$":
+          $ref: '#/$defs/toggle-operation'
+          unevaluatedProperties: false
+
+          description: Channel in toggle functionality.
+
+          properties:
+            adi,output-range-microvolt:
+              description: Specify the channel output full scale range.
+              oneOf:
+                - items:
+                    - const: 0
+                    - enum: [5000000, 10000000]
+                - items:
+                    - const: -5000000
+                    - const: 5000000
+                - items:
+                    - const: -10000000
+                    - const: 10000000
+                - items:
+                    - const: -2500000
+                    - const: 2500000
+
+          required:
+            - adi,output-range-microvolt
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ltc2672
+    then:
+      properties:
+        adi,rfsadj-ohms:
+          description: If FSADJ is tied to VCC, an internal RFSADJ (20 kΩ) is
+            selected, which results in nominal output ranges. When an external
+            resistor of 19 kΩ to 41 kΩ can be used instead by connecting the
+            resistor between FSADJ and GND it controls the scaling of the
+            ranges, and the internal resistor is automatically disconnected.
+          minimum: 19000
+          maximum: 41000
+          default: 20000
+
+      patternProperties:
+        "^channel@([0-4])$":
+          $ref: '#/$defs/toggle-operation'
+          unevaluatedProperties: false
+
+          description: Configuration properties for a channel in toggle mode
+
+          properties:
+            adi,output-range-microamp:
+              description: Specify the channel output full scale range.
+              $ref: /schemas/types.yaml#/definitions/uint32
+              enum: [3125000, 6250000, 12500000, 25000000, 50000000, 100000000,
+                     200000000, 300000000]
+
+          required:
+            - adi,output-range-microamp
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - vcc-supply
+  - iovcc-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          dac@0 {
+                  compatible = "adi,ltc2664";
+                  reg = <0>;
+                  spi-max-frequency = <10000000>;
+
+                  vcc-supply = <&vcc>;
+                  iovcc-supply = <&vcc>;
+                  vref-supply = <&vref>;
+
+                  #address-cells = <1>;
+                  #size-cells = <0>;
+                  channel@0 {
+                          reg = <0>;
+                          adi,toggle-mode;
+                          adi,output-range-microvolt = <(-10000000) 10000000>;
+                  };
+
+                  channel@1 {
+                          reg = <1>;
+                          adi,output-range-microvolt = <0 10000000>;
+                  };
+          };
+    };
+  - |
+    spi {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          dac@0 {
+                  compatible = "adi,ltc2672";
+                  reg = <0>;
+                  spi-max-frequency = <10000000>;
+
+                  vcc-supply = <&vcc>;
+                  iovcc-supply = <&vcc>;
+                  vref-supply = <&vref>;
+
+                  #address-cells = <1>;
+                  #size-cells = <0>;
+                  channel@0 {
+                          reg = <0>;
+                          adi,toggle-mode;
+                          adi,output-range-microamp = <3125000>;
+                  };
+
+                  channel@1 {
+                          reg = <1>;
+                          adi,output-range-microamp = <6250000>;
+                  };
+          };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a7287cf44..bd8645f6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12836,6 +12836,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
 F:	drivers/iio/dac/ltc1660.c
 
+LTC2664 IIO DAC DRIVER
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
+
 LTC2688 IIO DAC DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.34.1


