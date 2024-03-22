Return-Path: <linux-kernel+bounces-112057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F2D8874B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABA6283463
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC328173D;
	Fri, 22 Mar 2024 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WZEKZf+A"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EEF80C02;
	Fri, 22 Mar 2024 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145141; cv=none; b=jby1h46CdEFYyW/LKsF01HGq5H4bRTRaqBR5yLZ1GlTUih9wENxiDN8t9kL6RrlmlBkBbEbg5TjEcWaXNWoZrGU6YganVHq6imRWkU2VEgLSdqFBhj7uFzE8JtWf6HQeHfWW3lnlANF2BaBWsF5dAGMi6zXpjPH2yvC7t59ezI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145141; c=relaxed/simple;
	bh=C5LyfniSOaNMUpzLjG4M78U8PNEf4IgkZRSXKPOOES0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HD0lSV1Jf2k/t5FIfPPSrl2nWasoIesMa9nS/EFc7Co1HQYvtvu3QfCo/C6bF+sI7b20s48KYG5VpUZdIehrX+AK+ZRPE/kqQWQBHmqjVG8wwFtvY/yi4CcDtr0ffVUFulyLkRoh65RCDD/jUHEfp3xK9PVk1UQbSwAZZISpdY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WZEKZf+A; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42MHMPOg014783;
	Fri, 22 Mar 2024 18:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=DKIM;
	 bh=8conlbypa1PS8WhKHiTW25hv7hi1LPKKYb7Qq9hY7vo=; b=WZEKZf+A+IVl
	CbBdxt5USJ17aOWttPT2xrQUeGgn0y04GhoGVTxI75JHF5dEo2WXilJS5q6+lZq+
	w85DqKof7OxfkDoFGansha1sSqqh2+C84G8ANd9mpNrc9B7MLHorXDzcx6DADEVB
	0evwyp+eP2N+HL3fgdBmqWHJt4EHgiHxLt87t4HChfFcpzSELzpt2nn2pUrZ+iHX
	062HBNk8RUU90J8XOmyVL9IpkKBEI4cV8Ez7SKKozFEOa37j1IkTHoiBjxY4wi1I
	NL65JGEmfrFTsPZ1ctyYNCkJ+qknHoE7cQ6N36Yo8VkzKJ1VmIuz3WY55okSrtJL
	MBa0h5Bf7g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3x0wxbcbah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 18:05:23 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 42MM5MBp023788
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Mar 2024 18:05:22 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 22 Mar
 2024 18:05:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 22 Mar 2024 18:05:21 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 42MM58bR028921;
	Fri, 22 Mar 2024 18:05:11 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: adc: Add AD4000
Date: Fri, 22 Mar 2024 19:05:08 -0300
Message-ID: <81665b5f0d37d593e6d299528de8d68da8574077.1711131830.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1711131830.git.marcelo.schmitt@analog.com>
References: <cover.1711131830.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: bflccPvWxkuPKL3lww15GGBN0eYuPXVY
X-Proofpoint-ORIG-GUID: bflccPvWxkuPKL3lww15GGBN0eYuPXVY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_14,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403220160

Add device tree documentation for AD4000 series of ADC devices.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Pasting relevant comment from cover letter here to aid reviewers.

These devices have the same SPI (Strange Peripheral Interface) as AD7944
devices, which has been documented in ad7944.rst [1].
The device tree description for SPI connections and mode can be the same as of
ad7944 adi,spi-mode [2].
Because ad4000 driver does not currently support daisy-chain mode, I simplified
things a little bit. If having a more complete doc is preferred, I'm fine
changing to that.

[1]: https://lore.kernel.org/linux-iio/20240313-mainline-ad7944-doc-v1-2-7860416726e4@baylibre.com/
[2]: https://lore.kernel.org/linux-iio/20240304-ad7944-mainline-v5-1-f0a38cea8901@baylibre.com/

 .../bindings/iio/adc/adi,ad4000.yaml          | 151 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
new file mode 100644
index 000000000000..9e3d6a3920ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4000 ADC device driver
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+
+description: |
+  Analog Devices AD4000 family of Analog to Digital Converters with SPI support.
+  Specifications can be found at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4000
+      - adi,ad4001
+      - adi,ad4002
+      - adi,ad4003
+      - adi,ad4004
+      - adi,ad4005
+      - adi,ad4006
+      - adi,ad4007
+      - adi,ad4008
+      - adi,ad4010
+      - adi,ad4011
+      - adi,ad4020
+      - adi,ad4021
+      - adi,ad4022
+      - adi,adaq4001
+      - adi,adaq4003
+
+  reg: true
+  spi-max-frequency: true
+
+  vref-supply:
+    description: Phandle to the regulator for ADC reference voltage.
+
+  adi,gain-milli:
+    description: |
+      The hardware gain applied to the ADC input (in milli units).
+      The gain provided by the ADC input scaler is defined by the hardware
+      connections between chip pins OUT+, R1K-, R1K1-, R1K+, R1K1+, and OUT-.
+      If not present, default to 1000 (no actual gain applied).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [454, 909, 1000, 1900]
+    default: 1000
+
+  adi,spi-cs-mode:
+    type: boolean
+    description: |
+      This property indicates the SPI wiring configuration.
+
+      When this property is omitted, it indicates that the device SDI pin is
+      connected to SPI controller CS line and device CNV pin has been connected
+      to a GPIO. Datasheets call this "4-wire mode".
+
+      When this property is present, the driver must assume standard SPI
+      connections which, for these devices, consists of connecting the
+      controller CS line to device CNV pin. This configuration is
+      (misleadingly) called "3-wire mode" in datasheets.
+
+  cnv-gpios:
+    description: The GPIO connected to the CNV pin.
+    maxItems: 1
+
+patternProperties:
+  "^channel@([0-1])$":
+    $ref: adc.yaml
+    type: object
+    description: Represents the external channel connected to the ADC.
+
+    properties:
+      reg:
+        maxItems: 1
+
+      diff-channels: true
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        adi,spi-cs-mode: false
+    then:
+      required:
+        - cnv-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        /* Example for a AD4000 devices */
+        adc@0 {
+            compatible = "adi,ad4020";
+            reg = <0>;
+            spi-max-frequency = <71000000>;
+            vref-supply = <&vref>;
+            cnv-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                diff-channels = <0 1>;
+            };
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        /* Example for a ADAQ4000 devices */
+        adc@0 {
+            compatible = "adi,adaq4003";
+            reg = <0>;
+            spi-max-frequency = <80000000>;
+            vref-supply = <&vref>;
+            adi,spi-cs-mode;
+            adi,gain-milli = <454>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                diff-channels = <0 1>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2662ec49b297..3ca90f842298 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1135,6 +1135,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
 F:	drivers/iio/dac/ad3552r.c
 
+ANALOG DEVICES INC AD4000 DRIVER
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
+
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.43.0


