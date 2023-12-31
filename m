Return-Path: <linux-kernel+bounces-13756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F8A820C21
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC05A1C21506
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842CA8F6F;
	Sun, 31 Dec 2023 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MOTX/gw/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E070BA55;
	Sun, 31 Dec 2023 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BVGxPfr002544;
	Sun, 31 Dec 2023 17:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=070XGU68ef7NhrUzwDUUN5wvB9ePbtUjHfA+YgVZndE=; b=MO
	TX/gw/9Z8wmURkyRopYJ3e+981zKXY0wGL7rI7a2jHl5drviIRujT+JwYdbghpb9
	EsbWrt9Tgs9IzD2pmiYRU+JAbh0U0MnTiCnytjZJ5TpiXhMqyQmi3A05AN1j2LAY
	SJWS8+X3k1X3tFB5U99Dfrtb5BSyjMSy6/7B6kNkMY4IRs7cis3UUOPKY/JeJmlQ
	WZNFERhzjJeDfnhq6Tk+kolh5cDPs7B2uagb7NkYLgVa2YBZlqhkMh4XAFSAEIUT
	y6q1yRKnOHJ6d+/6r07tgKIqOeVY2HifQGG40YHmZXPQzmqnRJxih5y793JwL6E+
	TZK/X5goA76D2AHk7GBA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vaccs1wrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Dec 2023 17:13:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BVHDP8S015703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Dec 2023 17:13:25 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 31 Dec 2023 09:13:12 -0800
From: Jishnu Prakash <quic_jprakash@quicinc.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <daniel.lezcano@linaro.org>,
        <dmitry.baryshkov@linaro.org>
CC: <quic_jprakash@quicinc.com>, <lars@metafoo.de>, <luca@z3ntu.xyz>,
        <marijn.suijten@somainline.org>, <agross@kernel.org>,
        <sboyd@kernel.org>, <rafael@kernel.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <linus.walleij@linaro.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_amelende@quicinc.com>, <quic_kamalw@quicinc.com>,
        <kernel@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <cros-qcom-dts-watchers@chromium.org>
Subject: [PATCH v3 2/3] dt-bindings: iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Date: Sun, 31 Dec 2023 22:42:36 +0530
Message-ID: <20231231171237.3322376-3-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CUID-sxCUx2KD50nvs4rjKWl8_UX8InF
X-Proofpoint-ORIG-GUID: CUID-sxCUx2KD50nvs4rjKWl8_UX8InF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312310141

For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.

It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
going through PBS(Programmable Boot Sequence) firmware through a single
register interface. This interface is implemented on an SDAM (Shared
Direct Access Memory) peripheral on the master PMIC PMK8550 rather
than a dedicated ADC peripheral.

Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
channels and virtual channels (combination of ADC channel number and
PMIC SID number) per PMIC, to be used by clients of this device.

Changes since v2:
- Moved ADC5 Gen3 documentation into a separate new file.

Changes since v1:
- Updated properties separately for all compatibles to clarify usage
  of new properties and updates in usage of old properties for ADC5 Gen3.
- Avoided updating 'adc7' name to 'adc5 gen2' and just left a comment
  mentioning this convention.
- Used predefined channel IDs in individual PMIC channel definitions
  instead of numeric IDs.
- Addressed other comments from reviewers.

Co-developed-by: Anjelique Melendez <quic_amelende@quicinc.com>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml | 212 ++++++++++++++++++
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550.h      |  50 +++++
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550b.h     |  89 ++++++++
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h    |  22 ++
 .../iio/adc/qcom,spmi-adc5-gen3-pmk8550.h     |  56 +++++
 .../iio/adc/qcom,spmi-adc7-pmr735b.h          |   2 +-
 .../iio/adc/qcom,spmi-adc7-smb139x.h          |   2 +-
 include/dt-bindings/iio/adc/qcom,spmi-vadc.h  |  81 +++++++
 8 files changed, 512 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
new file mode 100644
index 000000000000..ed5bb53e7628
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
@@ -0,0 +1,212 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-adc5-gen3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's SPMI PMIC ADC5 Gen3
+
+maintainers:
+  - Jishnu Prakash <quic_jprakash@quicinc.com>
+
+description: |
+  SPMI PMIC5 Gen3 voltage ADC (ADC) provides interface to
+  clients to read voltage. It is a 16-bit sigma-delta ADC.
+  It also performs the same thermal monitoring function as
+  the existing ADC_TM devices.
+
+properties:
+  compatible:
+    const: qcom,spmi-adc5-gen3
+
+  reg:
+    description: |
+      - Each reg corresponds to an SDAM peripheral base address that is being used for ADC.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  "#thermal-sensor-cells":
+    const: 1
+    description:
+      Number of cells required to uniquely identify the thermal sensors. Since
+      we have multiple sensors this is set to 1. This property is required for
+      ADC devices with channels used for TM (thermal monitoring) functionality.
+
+  '#io-channel-cells':
+    const: 1
+
+  interrupts:
+    description: |
+      End of conversion interrupt. Interrupts are defined for each SDAM being used.
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 10
+    items:
+      pattern: "^adc-sdam[0-9]+$"
+    description: |
+      Names should be defined as "adc-sdam<N>" where <N> represents the SDAM index.
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+  - '#io-channel-cells'
+  - interrupts
+  - interrupt-names
+
+patternProperties:
+  "^channel@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+    description: |
+      Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        maxItems: 1
+        description: |
+          ADC channel number.
+          See include/dt-bindings/iio/adc/qcom,spmi-vadc.h
+          For PMIC5 Gen3 ADC, the channel numbers are specified separately
+          per PMIC in the PMIC-specific files in include/dt-bindings/iio/adc.
+
+      label:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: |
+            ADC input of the platform as seen in the schematics.
+            For thermistor inputs connected to generic AMUX or GPIO inputs
+            these can vary across platform for the same pins. Hence select
+            the platform schematics name for this channel.
+
+      qcom,decimation:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+            This parameter is used to decrease ADC sampling rate.
+            Quicker measurements can be made by reducing decimation ratio.
+        enum: [ 85, 340, 1360 ]
+        default: 1360
+
+      qcom,pre-scaling:
+        description: |
+            Used for scaling the channel input signal before the signal is
+            fed to VADC. The configuration for this node is to know the
+            pre-determined ratio and use it for post scaling. It is a pair of
+            integers, denoting the numerator and denominator of the fraction by which
+            input signal is multiplied. For example, <1 3> indicates the signal is scaled
+            down to 1/3 of its value before ADC measurement.
+            If property is not found default value depending on chip will be used.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        items:
+          - const: 1
+          - enum: [ 1, 3, 6, 16 ]
+
+      qcom,ratiometric:
+        description: |
+            Channel calibration type.
+            - If this property is specified VADC will use the VDD reference (1.875V)
+              and GND for channel calibration. If property is not found, channel will be
+              calibrated with 0V and 1.25V reference channels, also known as
+              absolute calibration.
+        type: boolean
+
+      qcom,hw-settle-time:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+            Time between AMUX getting configured and the ADC starting
+            conversion. The 'hw_settle_time' is an index used from valid values
+            and programmed in hardware to achieve the hardware settling delay.
+        enum: [ 15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000,
+                8000, 16000, 32000, 64000, 128000 ]
+        default: 15
+
+      qcom,avg-samples:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+            Number of samples to be used for measurement.
+            Averaging provides the option to obtain a single measurement
+            from the ADC that is an average of multiple samples. The value
+            selected is 2^(value).
+        enum: [ 1, 2, 4, 8, 16 ]
+        default: 1
+
+      qcom,adc-tm:
+        description: |
+            Indicates if ADC_TM monitoring is done on this channel.
+            Defined for compatible property "qcom,spmi-adc5-gen3".
+            This is the same functionality as in the existing QCOM ADC_TM
+            device, documented at devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.
+        type: boolean
+
+    required:
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      /* VADC node */
+      pmk8550_vadc: vadc@9000 {
+        compatible = "qcom,spmi-adc5-gen3";
+        reg = <0x9000>, <0x9100>;
+        interrupts = <0x0 0x90 0x1 IRQ_TYPE_EDGE_RISING>,
+                <0x0 0x91 0x1 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "adc-sdam0", "adc-sdam1";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #io-channel-cells = <1>;
+        #thermal-sensor-cells = <1>;
+
+        /* PMK8550 Channel nodes */
+        channel@3 {
+          reg = <PMK8550_ADC5_GEN3_DIE_TEMP>;
+          label = "pmk8550_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+
+        channel@44 {
+          reg = <PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_100K_PU>;
+          label = "pmk8550_xo_therm";
+          qcom,pre-scaling = <1 1>;
+          qcom,ratiometric;
+          qcom,hw-settle-time = <200>;
+          qcom,adc-tm;
+        };
+
+        /* PM8550 Channel nodes */
+        channel@103 {
+          reg = <PM8550_ADC5_GEN3_DIE_TEMP>;
+          label = "pm8550_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+
+        /* PM8550B Channel nodes */
+        channel@78f {
+          reg = <PM8550B_ADC5_GEN3_VBAT_SNS_QBG>;
+          label = "pm8550b_vbat_sns_qbg";
+          qcom,pre-scaling = <1 3>;
+        };
+
+        /* PM8550VS_C Channel nodes */
+        channel@203 {
+          reg = <PM8550VS_ADC5_GEN3_DIE_TEMP(2)>;
+          label = "pm8550vs_c_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+      };
+    };
diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
new file mode 100644
index 000000000000..0f25ef87ed5c
--- /dev/null
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H
+
+#ifndef PM8550_SID
+#define PM8550_SID		1
+#endif
+
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
+
+/* ADC channels for PM8550_ADC for PMIC5 Gen3 */
+#define PM8550_ADC5_GEN3_REF_GND			(PM8550_SID << 8 | ADC5_GEN3_REF_GND)
+#define PM8550_ADC5_GEN3_1P25VREF			(PM8550_SID << 8 | ADC5_GEN3_1P25VREF)
+#define PM8550_ADC5_GEN3_VREF_VADC			(PM8550_SID << 8 | ADC5_GEN3_VREF_VADC)
+#define PM8550_ADC5_GEN3_DIE_TEMP			(PM8550_SID << 8 | ADC5_GEN3_DIE_TEMP)
+
+#define PM8550_ADC5_GEN3_AMUX_THM1			(PM8550_SID << 8 | ADC5_GEN3_AMUX1_THM)
+#define PM8550_ADC5_GEN3_AMUX_THM2			(PM8550_SID << 8 | ADC5_GEN3_AMUX2_THM)
+#define PM8550_ADC5_GEN3_AMUX_THM3			(PM8550_SID << 8 | ADC5_GEN3_AMUX3_THM)
+#define PM8550_ADC5_GEN3_AMUX_THM4			(PM8550_SID << 8 | ADC5_GEN3_AMUX4_THM)
+#define PM8550_ADC5_GEN3_AMUX_THM5			(PM8550_SID << 8 | ADC5_GEN3_AMUX5_THM)
+#define PM8550_ADC5_GEN3_AMUX_THM6_GPIO2		(PM8550_SID << 8 | ADC5_GEN3_AMUX6_THM)
+#define PM8550_ADC5_GEN3_AMUX1_GPIO3			(PM8550_SID << 8 | ADC5_GEN3_AMUX1_GPIO)
+#define PM8550_ADC5_GEN3_AMUX2_GPIO4			(PM8550_SID << 8 | ADC5_GEN3_AMUX2_GPIO)
+#define PM8550_ADC5_GEN3_AMUX3_GPIO7			(PM8550_SID << 8 | ADC5_GEN3_AMUX3_GPIO)
+#define PM8550_ADC5_GEN3_AMUX4_GPIO12			(PM8550_SID << 8 | ADC5_GEN3_AMUX4_GPIO)
+
+/* 100k pull-up */
+#define PM8550_ADC5_GEN3_AMUX_THM1_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX1_THM_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX_THM2_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX2_THM_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX_THM3_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX3_THM_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX_THM4_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX4_THM_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX_THM5_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX5_THM_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX_THM6_GPIO2_100K_PU	(PM8550_SID << 8 | ADC5_GEN3_AMUX6_THM_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX1_GPIO3_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX1_GPIO_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX2_GPIO4_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX2_GPIO_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX3_GPIO7_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX3_GPIO_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX4_GPIO12_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX4_GPIO_100K_PU)
+
+/* 1/3 Divider */
+#define PM8550_ADC5_GEN3_AMUX3_GPIO7_DIV3		(PM8550_SID << 8 | ADC5_GEN3_AMUX3_GPIO_DIV3)
+#define PM8550_ADC5_GEN3_AMUX4_GPIO12_DIV3		(PM8550_SID << 8 | ADC5_GEN3_AMUX4_GPIO_DIV3)
+
+#define PM8550_ADC5_GEN3_VPH_PWR			(PM8550_SID << 8 | ADC5_GEN3_VPH_PWR)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H */
diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
new file mode 100644
index 000000000000..47116bbe45de
--- /dev/null
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H
+
+#ifndef PM8550B_SID
+#define PM8550B_SID		7
+#endif
+
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
+
+/* ADC channels for PM8550B_ADC for PMIC5 Gen3 */
+#define PM8550B_ADC5_GEN3_REF_GND			(PM8550B_SID << 8 | ADC5_GEN3_REF_GND)
+#define PM8550B_ADC5_GEN3_1P25VREF			(PM8550B_SID << 8 | ADC5_GEN3_1P25VREF)
+#define PM8550B_ADC5_GEN3_VREF_VADC			(PM8550B_SID << 8 | ADC5_GEN3_VREF_VADC)
+#define PM8550B_ADC5_GEN3_DIE_TEMP			(PM8550B_SID << 8 | ADC5_GEN3_DIE_TEMP)
+
+#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM		(PM8550B_SID << 8 | ADC5_GEN3_AMUX1_THM)
+#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID		(PM8550B_SID << 8 | ADC5_GEN3_AMUX2_THM)
+#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V		(PM8550B_SID << 8 | ADC5_GEN3_AMUX3_THM)
+#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM		(PM8550B_SID << 8 | ADC5_GEN3_AMUX4_THM)
+#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION		(PM8550B_SID << 8 | ADC5_GEN3_AMUX5_THM)
+#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10		(PM8550B_SID << 8 | ADC5_GEN3_AMUX6_THM)
+#define PM8550B_ADC5_GEN3_AMUX1_GPIO1			(PM8550B_SID << 8 | ADC5_GEN3_AMUX1_GPIO)
+#define PM8550B_ADC5_GEN3_AMUX2_GPIO5			(PM8550B_SID << 8 | ADC5_GEN3_AMUX2_GPIO)
+#define PM8550B_ADC5_GEN3_AMUX3_GPIO6			(PM8550B_SID << 8 | ADC5_GEN3_AMUX3_GPIO)
+#define PM8550B_ADC5_GEN3_AMUX4_GPIO12			(PM8550B_SID << 8 | ADC5_GEN3_AMUX4_GPIO)
+
+#define PM8550B_ADC5_GEN3_CHG_TEMP			(PM8550B_SID << 8 | ADC5_GEN3_CHG_TEMP)
+#define PM8550B_ADC5_GEN3_USB_SNS_V_16			(PM8550B_SID << 8 | ADC5_GEN3_USB_SNS_V_16)
+#define PM8550B_ADC5_GEN3_VIN_DIV16_MUX			(PM8550B_SID << 8 | ADC5_GEN3_VIN_DIV16_MUX)
+#define PM8550B_ADC5_GEN3_VREF_BAT_THERM		(PM8550B_SID << 8 | ADC5_GEN3_VREF_BAT_THERM)
+#define PM8550B_ADC5_GEN3_IIN_FB			(PM8550B_SID << 8 | ADC5_GEN3_IIN_FB)
+#define PM8550B_ADC5_GEN3_TEMP_ALARM_LITE		(PM8550B_SID << 8 | ADC5_GEN3_TEMP_ALARM_LITE)
+#define PM8550B_ADC5_GEN3_SMB_IIN			(PM8550B_SID << 8 | ADC5_GEN3_IIN_SMB)
+#define PM8550B_ADC5_GEN3_SMB_ICHG			(PM8550B_SID << 8 | ADC5_GEN3_ICHG_SMB)
+#define PM8550B_ADC5_GEN3_ICHG_FB			(PM8550B_SID << 8 | ADC5_GEN3_ICHG_FB)
+
+/* 30k pull-up */
+#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM_30K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX1_THM_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID_30K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX2_THM_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V_30K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX3_THM_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM_30K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX4_THM_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION_30K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX5_THM_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10_30K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX6_THM_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_30K_PU		(PM8550B_SID << 8 | ADC5_GEN3_AMUX1_GPIO_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_30K_PU		(PM8550B_SID << 8 | ADC5_GEN3_AMUX2_GPIO_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_30K_PU		(PM8550B_SID << 8 | ADC5_GEN3_AMUX3_GPIO_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX4_GPIO12_30K_PU		(PM8550B_SID << 8 | ADC5_GEN3_AMUX4_GPIO_30K_PU)
+
+/* 100k pull-up */
+#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM_100K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX1_THM_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID_100K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX2_THM_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V_100K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX3_THM_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM_100K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX4_THM_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION_100K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX5_THM_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10_100K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX6_THM_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_100K_PU		(PM8550B_SID << 8 | ADC5_GEN3_AMUX1_GPIO_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_100K_PU		(PM8550B_SID << 8 | ADC5_GEN3_AMUX2_GPIO_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_100K_PU		(PM8550B_SID << 8 | ADC5_GEN3_AMUX3_GPIO_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX4_GPIO12_100K_PU		(PM8550B_SID << 8 | ADC5_GEN3_AMUX4_GPIO_100K_PU)
+
+/* 400k pull-up */
+#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM_400K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX1_THM_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID_400K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX2_THM_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V_400K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX3_THM_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM_400K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX4_THM_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION_400K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX5_THM_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10_400K_PU	(PM8550B_SID << 8 | ADC5_GEN3_AMUX6_THM_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_400K_PU		(PM8550B_SID << 8 | ADC5_GEN3_AMUX1_GPIO_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_400K_PU		(PM8550B_SID << 8 | ADC5_GEN3_AMUX2_GPIO_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_400K_PU		(PM8550B_SID << 8 | ADC5_GEN3_AMUX3_GPIO_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX4_GPIO12_400K_PU		(PM8550B_SID << 8 | ADC5_GEN3_AMUX4_GPIO_400K_PU)
+
+/* 1/3 Divider */
+#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_DIV3		(PM8550B_SID << 8 | ADC5_GEN3_AMUX1_GPIO_DIV3)
+#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_DIV3		(PM8550B_SID << 8 | ADC5_GEN3_AMUX2_GPIO_DIV3)
+#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_DIV3		(PM8550B_SID << 8 | ADC5_GEN3_AMUX3_GPIO_DIV3)
+
+#define PM8550B_ADC5_GEN3_VPH_PWR			(PM8550B_SID << 8 | ADC5_GEN3_VPH_PWR)
+#define PM8550B_ADC5_GEN3_VBAT_SNS_QBG			(PM8550B_SID << 8 | ADC5_GEN3_VBAT_SNS_QBG)
+#define PM8550B_ADC5_GEN3_VBAT_SNS_CHGR			(PM8550B_SID << 8 | ADC5_GEN3_VBAT_SNS_CHGR)
+#define PM8550B_ADC5_GEN3_VBAT_2S_MID_QBG		(PM8550B_SID << 8 | ADC5_GEN3_VBAT_2S_MID_QBG)
+#define PM8550B_ADC5_GEN3_VBAT_2S_MID_CHGR		(PM8550B_SID << 8 | ADC5_GEN3_VBAT_2S_MID_CHGR)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H */
diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
new file mode 100644
index 000000000000..360f2245d582
--- /dev/null
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H
+
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
+
+/* ADC channels for PM8550VX_ADC for PMIC5 Gen3 */
+#define PM8550VS_ADC5_GEN3_REF_GND(sid)			((sid) << 8 | ADC5_GEN3_REF_GND)
+#define PM8550VS_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | ADC5_GEN3_1P25VREF)
+#define PM8550VS_ADC5_GEN3_VREF_VADC(sid)			((sid) << 8 | ADC5_GEN3_VREF_VADC)
+#define PM8550VS_ADC5_GEN3_DIE_TEMP(sid)			((sid) << 8 | ADC5_GEN3_DIE_TEMP)
+
+#define PM8550VE_ADC5_GEN3_OFFSET_REF(sid)			((sid) << 8 | ADC5_GEN3_REF_GND)
+#define PM8550VE_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | ADC5_GEN3_1P25VREF)
+#define PM8550VE_ADC5_GEN3_VREF_VADC(sid)			((sid) << 8 | ADC5_GEN3_VREF_VADC)
+#define PM8550VE_ADC5_GEN3_DIE_TEMP(sid)		((sid) << 8 | ADC5_GEN3_DIE_TEMP)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H */
diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
new file mode 100644
index 000000000000..3fc829ebdf6d
--- /dev/null
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H
+
+#ifndef PMK8550_SID
+#define PMK8550_SID		0
+#endif
+
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
+
+/* ADC channels for PMK8550_ADC for PMIC5 Gen3 */
+#define PMK8550_ADC5_GEN3_REF_GND			(PMK8550_SID << 8 | ADC5_GEN3_REF_GND)
+#define PMK8550_ADC5_GEN3_1P25VREF			(PMK8550_SID << 8 | ADC5_GEN3_1P25VREF)
+#define PMK8550_ADC5_GEN3_VREF_VADC			(PMK8550_SID << 8 | ADC5_GEN3_VREF_VADC)
+#define PMK8550_ADC5_GEN3_DIE_TEMP			(PMK8550_SID << 8 | ADC5_GEN3_DIE_TEMP)
+
+#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM		(PMK8550_SID << 8 | ADC5_GEN3_AMUX1_THM)
+#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1		(PMK8550_SID << 8 | ADC5_GEN3_AMUX2_THM)
+#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2		(PMK8550_SID << 8 | ADC5_GEN3_AMUX3_THM)
+#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3		(PMK8550_SID << 8 | ADC5_GEN3_AMUX4_THM)
+#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4		(PMK8550_SID << 8 | ADC5_GEN3_AMUX5_THM)
+#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5		(PMK8550_SID << 8 | ADC5_GEN3_AMUX6_THM)
+#define PMK8550_ADC5_GEN3_AMUX1_GPIO6			(PMK8550_SID << 8 | ADC5_GEN3_AMUX1_GPIO)
+
+/* 30k pull-up */
+#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_30K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX1_THM_30K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1_30K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX2_THM_30K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2_30K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX3_THM_30K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3_30K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX4_THM_30K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4_30K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX5_THM_30K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5_30K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX6_THM_30K_PU)
+#define PMK8550_ADC5_GEN3_AMUX1_GPIO6_30K_PU		(PMK8550_SID << 8 | ADC5_GEN3_AMUX1_GPIO_30K_PU)
+
+/* 100k pull-up */
+#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_100K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX1_THM_100K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1_100K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX2_THM_100K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2_100K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX3_THM_100K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3_100K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX4_THM_100K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4_100K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX5_THM_100K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5_100K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX6_THM_100K_PU)
+#define PMK8550_ADC5_GEN3_AMUX1_GPIO6_100K_PU		(PMK8550_SID << 8 | ADC5_GEN3_AMUX1_GPIO_100K_PU)
+
+/* 400k pull-up */
+#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_400K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX1_THM_400K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1_400K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX2_THM_400K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2_400K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX3_THM_400K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3_400K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX4_THM_400K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4_400K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX5_THM_400K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5_400K_PU	(PMK8550_SID << 8 | ADC5_GEN3_AMUX6_THM_400K_PU)
+#define PMK8550_ADC5_GEN3_AMUX1_GPIO6_400K_PU		(PMK8550_SID << 8 | ADC5_GEN3_AMUX1_GPIO_400K_PU)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H */
diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735b.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735b.h
index fdb8dd9ae541..812f33872e5e 100644
--- a/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735b.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735b.h
@@ -10,7 +10,7 @@
 #define PMR735B_SID					5
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* ADC channels for PMR735B_ADC for PMIC7 */
 #define PMR735B_ADC7_REF_GND			(PMR735B_SID << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h
index c0680d1285cf..750a526af2c1 100644
--- a/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h
@@ -6,7 +6,7 @@
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
 #define _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 #define SMB139x_1_ADC7_SMB_TEMP			(SMB139x_1_SID << 8 | ADC7_SMB_TEMP)
 #define SMB139x_1_ADC7_ICHG_SMB			(SMB139x_1_SID << 8 | ADC7_ICHG_SMB)
diff --git a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
index ef07ecd4d585..cfe653d945a4 100644
--- a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2012-2014,2018,2020 The Linux Foundation. All rights reserved.
+ *
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_H
@@ -300,4 +302,83 @@
 #define ADC7_SBUx				0x94
 #define ADC7_VBAT_2S_MID			0x96
 
+/* ADC channels for PMIC5 Gen3 */
+
+#define ADC5_GEN3_REF_GND			0x00
+#define ADC5_GEN3_1P25VREF			0x01
+#define ADC5_GEN3_VREF_VADC			0x02
+#define ADC5_GEN3_DIE_TEMP			0x03
+
+#define ADC5_GEN3_AMUX1_THM			0x04
+#define ADC5_GEN3_AMUX2_THM			0x05
+#define ADC5_GEN3_AMUX3_THM			0x06
+#define ADC5_GEN3_AMUX4_THM			0x07
+#define ADC5_GEN3_AMUX5_THM			0x08
+#define ADC5_GEN3_AMUX6_THM			0x09
+#define ADC5_GEN3_AMUX1_GPIO			0x0a
+#define ADC5_GEN3_AMUX2_GPIO			0x0b
+#define ADC5_GEN3_AMUX3_GPIO			0x0c
+#define ADC5_GEN3_AMUX4_GPIO			0x0d
+
+#define ADC5_GEN3_CHG_TEMP			0x10
+#define ADC5_GEN3_USB_SNS_V_16			0x11
+#define ADC5_GEN3_VIN_DIV16_MUX			0x12
+#define ADC5_GEN3_VREF_BAT_THERM		0x15
+#define ADC5_GEN3_IIN_FB			0x17
+#define ADC5_GEN3_TEMP_ALARM_LITE		0x18
+#define ADC5_GEN3_IIN_SMB			0x19
+#define ADC5_GEN3_ICHG_SMB			0x1b
+#define ADC5_GEN3_ICHG_FB			0xa1
+
+/* 30k pull-up1 */
+#define ADC5_GEN3_AMUX1_THM_30K_PU		0x24
+#define ADC5_GEN3_AMUX2_THM_30K_PU		0x25
+#define ADC5_GEN3_AMUX3_THM_30K_PU		0x26
+#define ADC5_GEN3_AMUX4_THM_30K_PU		0x27
+#define ADC5_GEN3_AMUX5_THM_30K_PU		0x28
+#define ADC5_GEN3_AMUX6_THM_30K_PU		0x29
+#define ADC5_GEN3_AMUX1_GPIO_30K_PU		0x2a
+#define ADC5_GEN3_AMUX2_GPIO_30K_PU		0x2b
+#define ADC5_GEN3_AMUX3_GPIO_30K_PU		0x2c
+#define ADC5_GEN3_AMUX4_GPIO_30K_PU		0x2d
+
+/* 100k pull-up2 */
+#define ADC5_GEN3_AMUX1_THM_100K_PU		0x44
+#define ADC5_GEN3_AMUX2_THM_100K_PU		0x45
+#define ADC5_GEN3_AMUX3_THM_100K_PU		0x46
+#define ADC5_GEN3_AMUX4_THM_100K_PU		0x47
+#define ADC5_GEN3_AMUX5_THM_100K_PU		0x48
+#define ADC5_GEN3_AMUX6_THM_100K_PU		0x49
+#define ADC5_GEN3_AMUX1_GPIO_100K_PU		0x4a
+#define ADC5_GEN3_AMUX2_GPIO_100K_PU		0x4b
+#define ADC5_GEN3_AMUX3_GPIO_100K_PU		0x4c
+#define ADC5_GEN3_AMUX4_GPIO_100K_PU		0x4d
+
+/* 400k pull-up3 */
+#define ADC5_GEN3_AMUX1_THM_400K_PU		0x64
+#define ADC5_GEN3_AMUX2_THM_400K_PU		0x65
+#define ADC5_GEN3_AMUX3_THM_400K_PU		0x66
+#define ADC5_GEN3_AMUX4_THM_400K_PU		0x67
+#define ADC5_GEN3_AMUX5_THM_400K_PU		0x68
+#define ADC5_GEN3_AMUX6_THM_400K_PU		0x69
+#define ADC5_GEN3_AMUX1_GPIO_400K_PU		0x6a
+#define ADC5_GEN3_AMUX2_GPIO_400K_PU		0x6b
+#define ADC5_GEN3_AMUX3_GPIO_400K_PU		0x6c
+#define ADC5_GEN3_AMUX4_GPIO_400K_PU		0x6d
+
+/* 1/3 Divider */
+#define ADC5_GEN3_AMUX1_GPIO_DIV3		0x8a
+#define ADC5_GEN3_AMUX2_GPIO_DIV3		0x8b
+#define ADC5_GEN3_AMUX3_GPIO_DIV3		0x8c
+#define ADC5_GEN3_AMUX4_GPIO_DIV3		0x8d
+
+#define ADC5_GEN3_VPH_PWR			0x8e
+#define ADC5_GEN3_VBAT_SNS_QBG			0x8f
+
+#define ADC5_GEN3_VBAT_SNS_CHGR			0x94
+#define ADC5_GEN3_VBAT_2S_MID_QBG		0x96
+#define ADC5_GEN3_VBAT_2S_MID_CHGR		0x9d
+
+#define ADC5_GEN3_OFFSET_EXT2			0xf8
+
 #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_H */
-- 
2.25.1


