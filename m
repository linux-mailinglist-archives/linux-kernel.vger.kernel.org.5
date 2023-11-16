Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E047EDA23
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344839AbjKPD0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344770AbjKPD0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:26:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF8919F;
        Wed, 15 Nov 2023 19:26:34 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG30W3f006834;
        Thu, 16 Nov 2023 03:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=7EEdbWxl1uPgetxSROpvlc5OHQ4lqYKJLNLHVtW2TZI=;
 b=KcirtG9Ua5o19gFpG7suh2z8LpntNAROTlqCgS1eYTZtmNTXxNEZY5u16Sx6s6Iqno9N
 NTOdzzR1/ZPiL7HiGEEh5X/Rro5OLtkzjnKIL1bCemGtl6p+GC0Cv9gWZn8Yb7wgMONi
 K0foI0XbS+SeTgFgXNNBL7uEWyy0Ju697IVIFUir70TymqFapi5f//h+9PkA88BpK7Re
 ML01TPIzZdBUOIJJ3K3gPDYGlli4bqG3ENttNDU/GNzmQ8SCqx5/YcmojShuLatHf1XH
 6BZyWtOOLi0T5QI0m/TLXOkATmuDiT/AG3VLS2V2LQwwxsZpo77BZzYiZI0wp7haU9IV ug== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucfkabp37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 03:26:12 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG3QCBX023671
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 03:26:12 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 15 Nov 2023 19:25:59 -0800
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <daniel.lezcano@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linus.walleij@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_amelende@quicinc.com>,
        <quic_kamalw@quicinc.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marijn.suijten@somainline.org>
CC:     <lars@metafoo.de>, <luca@z3ntu.xyz>, <linux-iio@vger.kernel.org>,
        <lee@kernel.org>, <rafael@kernel.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <cros-qcom-dts-watchers@chromium.org>,
        <sboyd@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <kernel@quicinc.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: [PATCH V2 1/3] dt-bindings: iio: adc: Add QCOM PMIC5 Gen3 ADC bindings
Date:   Thu, 16 Nov 2023 08:55:28 +0530
Message-ID: <20231116032530.753192-2-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116032530.753192-1-quic_jprakash@quicinc.com>
References: <20231116032530.753192-1-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sFC3lWratlEbOWiP37zV3LwZcKy9kI4h
X-Proofpoint-GUID: sFC3lWratlEbOWiP37zV3LwZcKy9kI4h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160025
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 181 ++++++++++++++++--
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550.h      |  50 +++++
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550b.h     |  89 +++++++++
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h    |  22 +++
 .../iio/adc/qcom,spmi-adc5-gen3-pmk8550.h     |  56 ++++++
 include/dt-bindings/iio/qcom,spmi-vadc.h      |  81 ++++++++
 6 files changed, 464 insertions(+), 15 deletions(-)
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index ad7d6fc49de5..c988bd74a247 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -13,8 +13,10 @@ maintainers:
 description: |
   SPMI PMIC voltage ADC (VADC) provides interface to clients to read
   voltage. The VADC is a 15-bit sigma-delta ADC.
-  SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
-  voltage. The VADC is a 16-bit sigma-delta ADC.
+  SPMI PMIC5/PMIC7/PMIC5 Gen3 voltage ADC (ADC) provides interface to
+  clients to read voltage. The VADC is a 16-bit sigma-delta ADC.
+  Note that PMIC7 ADC is the generation between PMIC5 and PMIC5 Gen3 ADC,
+  it can be considered like PMIC5 Gen2.
 
 properties:
   compatible:
@@ -23,14 +25,18 @@ properties:
           - const: qcom,pms405-adc
           - const: qcom,spmi-adc-rev2
       - enum:
-          - qcom,spmi-vadc
-          - qcom,spmi-adc5
           - qcom,spmi-adc-rev2
+          - qcom,spmi-adc5
+          - qcom,spmi-adc5-gen3
           - qcom,spmi-adc7
+          - qcom,spmi-vadc
 
   reg:
-    description: VADC base address in the SPMI PMIC register map
-    maxItems: 1
+    description: |
+      - For compatible properties "qcom,spmi-vadc", "qcom,spmi-adc5", "qcom,spmi-adc-rev2"
+        and "qcom,spmi-adc7", reg is the VADC base address in the SPMI PMIC register map.
+      - For compatible property "qcom,spmi-adc5-gen3", each reg corresponds
+        to an SDAM peripheral base address that is being used for ADC.
 
   '#address-cells':
     const: 1
@@ -38,13 +44,26 @@ properties:
   '#size-cells':
     const: 0
 
+  "#thermal-sensor-cells":
+    const: 1
+    description:
+      Number of cells required to uniquely identify the thermal sensors. Since
+      we have multiple sensors this is set to 1. For compatible property
+      "qcom,spmi-adc5-gen3", this property is required for ADC_TM device.
+
   '#io-channel-cells':
     const: 1
 
   interrupts:
-    maxItems: 1
-    description:
+    description: |
       End of conversion interrupt.
+      - For compatible property "qcom,spmi-adc5-gen3", interrupts are defined
+        for each SDAM being used.
+
+  interrupt-names:
+    description: |
+      For compatible property "qcom,spmi-adc5-gen3", names should be defined
+      as "adc-sdam<N>" where <N> represents the SDAM index.
 
 required:
   - compatible
@@ -71,8 +90,8 @@ patternProperties:
         description: |
           ADC channel number.
           See include/dt-bindings/iio/qcom,spmi-vadc.h
-          For PMIC7 ADC, the channel numbers are specified separately per PMIC
-          in the PMIC-specific files in include/dt-bindings/iio/.
+          For PMIC7 and PMIC5 Gen3 ADC, the channel numbers are specified separately
+          per PMIC in the PMIC-specific files in include/dt-bindings/iio/.
 
       label:
         $ref: /schemas/types.yaml#/definitions/string
@@ -114,11 +133,12 @@ patternProperties:
               channel calibration. If property is not found, channel will be
               calibrated with 0.625V and 1.25V reference channels, also
               known as absolute calibration.
-            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7" and
-              "qcom,spmi-adc-rev2", if this property is specified VADC will use
-              the VDD reference (1.875V) and GND for channel calibration. If
-              property is not found, channel will be calibrated with 0V and 1.25V
-              reference channels, also known as absolute calibration.
+            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7",
+              "qcom,spmi-adc-rev2" and "qcom,spmi-adc5-gen3", if this property
+              is specified VADC will use the VDD reference (1.875V) and GND for
+              channel calibration. If property is not found, channel will be
+              calibrated with 0V and 1.25V reference channels, also known as
+              absolute calibration.
         type: boolean
 
       qcom,hw-settle-time:
@@ -136,6 +156,14 @@ patternProperties:
             from the ADC that is an average of multiple samples. The value
             selected is 2^(value).
 
+      qcom,adc-tm:
+        description: |
+            Indicates if ADC_TM monitoring is done on this channel.
+            Defined for compatible property "qcom,spmi-adc5-gen3".
+            This is the same functionality as in the existing QCOM ADC_TM
+            device, documented at devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.
+        type: boolean
+
     required:
       - reg
 
@@ -147,6 +175,13 @@ allOf:
             const: qcom,spmi-vadc
 
     then:
+      properties:
+        reg:
+          maxItems: 1
+        interrupts:
+          maxItems: 1
+        "#thermal-sensor-cells": false
+        interrupt-names: false
       patternProperties:
         "^channel@[0-9a-f]+$":
           properties:
@@ -163,6 +198,8 @@ allOf:
               enum: [ 1, 2, 4, 8, 16, 32, 64, 128, 256, 512 ]
               default: 1
 
+            qcom,adc-tm: false
+
   - if:
       properties:
         compatible:
@@ -170,6 +207,13 @@ allOf:
             const: qcom,spmi-adc-rev2
 
     then:
+      properties:
+        reg:
+          maxItems: 1
+        interrupts:
+          maxItems: 1
+        "#thermal-sensor-cells": false
+        interrupt-names: false
       patternProperties:
         "^channel@[0-9a-f]+$":
           properties:
@@ -186,6 +230,8 @@ allOf:
               enum: [ 1, 2, 4, 8, 16 ]
               default: 1
 
+            qcom,adc-tm: false
+
   - if:
       properties:
         compatible:
@@ -193,6 +239,13 @@ allOf:
             const: qcom,spmi-adc5
 
     then:
+      properties:
+        reg:
+          maxItems: 1
+        interrupts:
+          maxItems: 1
+        "#thermal-sensor-cells": false
+        interrupt-names: false
       patternProperties:
         "^channel@[0-9a-f]+$":
           properties:
@@ -209,6 +262,8 @@ allOf:
               enum: [ 1, 2, 4, 8, 16 ]
               default: 1
 
+            qcom,adc-tm: false
+
   - if:
       properties:
         compatible:
@@ -216,6 +271,41 @@ allOf:
             const: qcom,spmi-adc7
 
     then:
+      properties:
+        reg:
+          maxItems: 1
+        interrupts:
+          maxItems: 1
+        "#thermal-sensor-cells": false
+        interrupt-names: false
+      patternProperties:
+        "^channel@[0-9a-f]+$":
+          properties:
+            qcom,decimation:
+              enum: [ 85, 340, 1360 ]
+              default: 1360
+
+            qcom,hw-settle-time:
+              enum: [ 15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000,
+                      8000, 16000, 32000, 64000, 128000 ]
+              default: 15
+
+            qcom,avg-samples:
+              enum: [ 1, 2, 4, 8, 16 ]
+              default: 1
+
+            qcom,adc-tm: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,spmi-adc5-gen3
+
+    then:
+      required:
+        - interrupts
+        - interrupt-names
       patternProperties:
         "^channel@[0-9a-f]+$":
           properties:
@@ -307,3 +397,64 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h>
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
index 000000000000..4c1ef10a4607
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
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
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
index 000000000000..b62971243700
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
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
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
index 000000000000..175bba532ee9
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
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
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
index 000000000000..4d32e13bb8d6
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
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
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
diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
index 08adfe25964c..97a050dd3271 100644
--- a/include/dt-bindings/iio/qcom,spmi-vadc.h
+++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2012-2014,2018,2020 The Linux Foundation. All rights reserved.
+ *
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_H
@@ -297,4 +299,83 @@
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

