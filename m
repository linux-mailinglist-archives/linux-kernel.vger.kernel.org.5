Return-Path: <linux-kernel+bounces-34871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EAC838896
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2221C23240
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D88956741;
	Tue, 23 Jan 2024 08:11:50 +0000 (UTC)
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE6E55E6E;
	Tue, 23 Jan 2024 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997510; cv=none; b=b5QawRif9Brsmx7mquhIeiquqAKq47DCHcxDD2RsH/8Zi2MCu62KkwUQns5vUGKLecB+YfBuHFC4IWp7MtBasYiaqn4pW5+GiEZBWR2yGo57xkd7LIk7WoluhBn62bgBXLG9q9yW3bT4SQKM5x3aDHikHyBXxrOaJYDspWN6BaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997510; c=relaxed/simple;
	bh=6/kVm0yG/eE7ipjEeC5gkP2B7Iq4UW3KGm4j/qJJrIU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HC0NFsDO56l2T6errtWaY7aECuL7Z2i03ad3JuYB3oYb0idVsSBEl0Z08aSaFZUBkiSClZRD1CBReeZHn5QihAgD66vXiUqnVfcSeDmcNlhTzvEVHKJy8+9SAdCFp+KIPK8ZEq7Xc0qKztWLJ7w3e/iOo6+Tlm5z7oj0jRiHy8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N65qlo028616;
	Tue, 23 Jan 2024 03:11:30 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3vt7vtrdx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 03:11:29 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 40N8BSpk023436
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 03:11:28 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 23 Jan
 2024 03:11:27 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 23 Jan 2024 03:11:27 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.34])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40N8BAa4032262;
	Tue, 23 Jan 2024 03:11:12 -0500
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
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<noname.nuno@gmail.com>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v8 1/2] dt-bindings: iio: frequency: add admfm2000
Date: Tue, 23 Jan 2024 16:10:58 +0800
Message-ID: <20240123081059.5746-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 0yzmBBGuVTTdrzfCc3p9xge881JsOp2l
X-Proofpoint-ORIG-GUID: 0yzmBBGuVTTdrzfCc3p9xge881JsOp2l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_02,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230058

Dual microwave down converter module with input RF and LO frequency
ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
for each down conversion path.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
V7 -> V8: Added adequate description for mixer mode property. Modified description
          for switch gpio property.
V6 -> V7: Changed RF path mode property to boolean.
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

 .../bindings/iio/frequency/adi,admfm2000.yaml | 127 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
new file mode 100644
index 000000000000..2bcf4bbc12e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2024 Analog Devices Inc.
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
+      adi,mixer-mode:
+        description:
+          Enable mixer mode for the channel. It downconverts RF between 5 GHz
+          and 32 GHz to IF between 0.5 GHz and 8 GHz. If not present, the channel
+          is in direct IF mode which bypasses the mixer and downconverts RF
+          between 2 GHz and 8 GHz to IF between 0.5 GHz and 8 GHz.
+        type: boolean
+
+      switch-gpios:
+        description: |
+          GPIOs to select the RF path for the channel. The same state of CTRL-A
+          and CTRL-B GPIOs is not permitted.
+          CTRL-A   CTRL-B    CH1 Status        CH2 Status
+          1        0         Direct IF mode    Mixer mode
+          0        1         Mixer mode        Direct IF mode
+
+        items:
+          - description: CTRL-A GPIO
+          - description: CTRL-B GPIO
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
+        adi,mixer-mode;
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
index 8d1052fa6a69..1f7cd2e848de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1267,6 +1267,13 @@ W:	https://ez.analog.com/linux-software-drivers
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

base-commit: 7ed2632ec7d72e926b9e8bcc9ad1bb0cd37274bf
-- 
2.34.1


