Return-Path: <linux-kernel+bounces-29925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C9F831544
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AE7288660
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800EF1D6B1;
	Thu, 18 Jan 2024 08:59:43 +0000 (UTC)
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F712E73;
	Thu, 18 Jan 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568382; cv=none; b=TP1KanatwKlE0HYYxiP1Sm8iPuUjQ07DY5aEkL2T+FXX8q+t99Cu/cQ/BL2dVftvWGX4sDSZJNoyhLXjvPlkeJX/OIQ+JHD/2SYU/i7W5thO8Bwlm5/On9PqQbEb5O1GXPKM4JC/CMftpOHyZDbiuaMirVaue7qEIPQfDCaoY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568382; c=relaxed/simple;
	bh=jG5dFO+oAm7Mx46m57mxnrrnfF8Nl/zSkDVb0/C+v2k=;
	h=Received:Received:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=uZy2aFWQDYgONchBWjqePMQ/lBh04hbxSXlVi6jyNULaAAMT+RcLS9hgNeOubxHXPDFh4exAgfPBNhApH8zydCAQuIvHn844YPhXZ60BtvGpZBnjqYcDq1ORgOnlaXyn2mKCwitms1f/Sh42NT3aqMyfqcCzgIdpToz6z9ACYiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I6lXxE003659;
	Thu, 18 Jan 2024 03:59:25 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3vpy1fgfkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 03:59:24 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 40I8xNtu001133
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jan 2024 03:59:23 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 18 Jan
 2024 03:59:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 18 Jan 2024 03:59:22 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.242.67])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40I8x0RC005188;
	Thu, 18 Jan 2024 03:59:14 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Crt
 Mori <cmo@melexis.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz
 Golaszewski <brgl@bgdev.pl>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v6 1/2] dt-bindings: iio: frequency: add admfm2000
Date: Thu, 18 Jan 2024 16:58:55 +0800
Message-ID: <20240118085856.70758-2-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118085856.70758-1-kimseer.paller@analog.com>
References: <20240118085856.70758-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: -oVpBpJr9cfTjbHoXnz-U5EAWF4YbPbA
X-Proofpoint-GUID: -oVpBpJr9cfTjbHoXnz-U5EAWF4YbPbA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_04,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401180063

Dual microwave down converter module with input RF and LO frequency
ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
for each down conversion path.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
V5 -> V6: Moved array of switch and attenuation GPIOs to the channel node.
          Changed pin coords with friendly names. Removed Reviewed-by tag.
V4 -> V5: Added Reviewed-by tag.
V3 -> V4: Updated the description of the properties with multiple entries and
          defined the order.
V2 -> V3: Adjusted indentation to resolve wrong indentation warning. 
          Changed node name to converter. Updated the descriptions to clarify
          the properties.
V1 -> V2: Removed '|' after description. Specified the pins connected to
          the GPIOs. Added additionalProperties: false. Changed node name to gpio.
          Aligned < syntax with the previous syntax in the examples.

 .../bindings/iio/frequency/adi,admfm2000.yaml | 129 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
new file mode 100644
index 000000000000..6f2c91c38666
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
@@ -0,0 +1,129 @@
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
+description:
+  Dual microwave down converter module with input RF and LO frequency ranges
+  from 0.5 to 32 GHz and an output IF frequency range from 0.1 to 8 GHz.
+  It consists of a LNA, mixer, IF filter, DSA, and IF amplifier for each down
+  conversion path.
+
+properties:
+  compatible:
+    enum:
+      - adi,admfm2000
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
+    additionalProperties: false
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
+      switch-gpios:
+        description: |
+          GPIOs to select the RF path for the channel.
+          SW-CH1   CTRL-A   CTRL-B
+          SW-CH2   CTRL-A   CTRL-B    CH1 Status        CH2 Status
+                   1        0         Direct IF mode    Mixer mode
+                   0        1         Mixer mode        Direct IF mode
+
+        items:
+          - description: SW-CH-CTRL-A GPIO
+          - description: SW-CH-CTRL-B GPIO
+
+      attenuation-gpios:
+        description: |
+          Choice of attenuation:
+          DSA-V4  DSA-V3  DSA-V2  DSA-V1  DSA-V0
+          1       1       1       1       1        0 dB
+          1       1       1       1       0        -1 dB
+          1       1       1       0       1        -2 dB
+          1       1       0       1       1        -4 dB
+          1       0       1       1       1        -8 dB
+          0       1       1       1       1        -16 dB
+          0       0       0       0       0        -31 dB
+
+        items:
+          - description: DSA-V0 GPIO
+          - description: DSA-V1 GPIO
+          - description: DSA-V2 GPIO
+          - description: DSA-V3 GPIO
+          - description: DSA-V4 GPIO
+
+    required:
+      - reg
+      - adi,mode
+      - switch-gpios
+      - attenuation-gpios
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    converter {
+      compatible = "adi,admfm2000";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      channel@0 {
+        reg = <0>;
+        adi,mode = <1>;
+        switch-gpios = <&gpio 1 GPIO_ACTIVE_LOW>,
+                       <&gpio 2 GPIO_ACTIVE_HIGH>;
+
+        attenuation-gpios = <&gpio 17 GPIO_ACTIVE_LOW>,
+                            <&gpio 22 GPIO_ACTIVE_LOW>,
+                            <&gpio 23 GPIO_ACTIVE_LOW>,
+                            <&gpio 24 GPIO_ACTIVE_LOW>,
+                            <&gpio 25 GPIO_ACTIVE_LOW>;
+      };
+
+      channel@1 {
+        reg = <1>;
+        adi,mode = <1>;
+        switch-gpios = <&gpio 3 GPIO_ACTIVE_LOW>,
+                       <&gpio 4 GPIO_ACTIVE_HIGH>;
+
+        attenuation-gpios = <&gpio 0 GPIO_ACTIVE_LOW>,
+                            <&gpio 5 GPIO_ACTIVE_LOW>,
+                            <&gpio 6 GPIO_ACTIVE_LOW>,
+                            <&gpio 16 GPIO_ACTIVE_LOW>,
+                            <&gpio 26 GPIO_ACTIVE_LOW>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2d94c72c3742..3a86f9d6cb98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1260,6 +1260,13 @@ W:	https://ez.analog.com/linux-software-drivers
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
-- 
2.34.1


