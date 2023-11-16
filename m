Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C663B7EDA37
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344854AbjKPD2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbjKPD16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:27:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE48131;
        Wed, 15 Nov 2023 19:27:53 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG1RVh8030709;
        Thu, 16 Nov 2023 03:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Vua+glkd/hI643/FFIY8otGm7DG0Fd/isimxDm4R6sA=;
 b=WqG+5Yb9CsXreqC4fmYwJ6/wBg+l/xGASSk9AoXTKzHnDcagg7XHswgwJ2lN+llDcNO8
 GQHEzttXF7yeqIOA7Mc6ahw6pvs1EAjM6C3slndvqMBPxursAsWGcRwP2wbFqtNBVM82
 5xfr6q8hSdJmHQf/c/QxWVJVDEm8RxpOld2KcVVKfA+6IvA9G9vzYcir/CxTsUWwpqKo
 WeZ6DROgIDfQAimMZZtZUfbuDaeRKS3eSmDswEFohfLM/23Jd9ekDTvGQL4iWifS2PkY
 NH1IIHU4DF0GtkbOu/gCRW+iw6660jmJAcCePAwFMTky0STeRxLIYCqlpxBqaQghhD06 Nw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ud5pf0jw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 03:27:30 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG3RTWr022259
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 03:27:29 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 15 Nov 2023 19:27:17 -0800
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
Subject: [PATCH V2 3/3] dt-bindings: iio/adc: Move QCOM ADC bindings to iio/adc folder
Date:   Thu, 16 Nov 2023 08:56:44 +0530
Message-ID: <20231116032644.753370-2-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116032644.753370-1-quic_jprakash@quicinc.com>
References: <20231116032644.753370-1-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iaq7enPkbirlHimlPqWEPI18d2IAVGs9
X-Proofpoint-ORIG-GUID: iaq7enPkbirlHimlPqWEPI18d2IAVGs9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=918 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several files containing QCOM ADC macros for channel names
right now in the include/dt-bindings/iio folder. Since all of these
are specifically for adc, move the files to the
include/dt-bindings/iio/adc folder.

Also update all affected devicetree and driver files to fix compilation
errors seen with this move and update documentation files to fix
dtbinding check errors for the same.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml       | 4 ++--
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 +-
 .../devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml  | 2 +-
 .../devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml    | 6 +++---
 arch/arm64/boot/dts/qcom/pm2250.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm6125.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm6150.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm6150l.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/pm660.dtsi                       | 2 +-
 arch/arm64/boot/dts/qcom/pm660l.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm7250b.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/pm8150.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm8150b.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/pm8150l.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm8950.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm8953.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pmi632.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pmi8950.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi                 | 2 +-
 arch/arm64/boot/dts/qcom/pmp8074.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/pms405.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts                   | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                  | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                | 4 ++--
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi               | 2 +-
 .../arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 6 +++---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts         | 2 +-
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts                   | 8 ++++----
 drivers/iio/adc/qcom-spmi-adc5-gen3.c                     | 2 +-
 drivers/iio/adc/qcom-spmi-adc5.c                          | 2 +-
 drivers/iio/adc/qcom-spmi-vadc.c                          | 2 +-
 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h  | 2 +-
 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h | 2 +-
 .../dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h    | 2 +-
 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h | 2 +-
 include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h | 2 +-
 .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h    | 2 +-
 .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h    | 2 +-
 .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h    | 2 +-
 .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h    | 0
 include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h        | 0
 44 files changed, 51 insertions(+), 51 deletions(-)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (100%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (100%)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index c988bd74a247..9b7b773ed7f8 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -367,8 +367,8 @@ examples:
     };
 
   - |
-    #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-    #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
     spmi {
diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 9fa568603930..f04b46553aad 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -261,7 +261,7 @@ examples:
     #include <dt-bindings/input/input.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/iio/qcom,spmi-vadc.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
     #include <dt-bindings/spmi/spmi.h>
 
     pmic@0 {
diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
index 01253d58bf9f..6dc01512cc70 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
@@ -112,7 +112,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/iio/qcom,spmi-vadc.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     spmi_bus {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
index 3c81def03c84..e27f34da9165 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -165,7 +165,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/iio/qcom,spmi-vadc.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     spmi_bus {
         #address-cells = <1>;
@@ -204,8 +204,8 @@ examples:
     };
 
   - |
-    #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-    #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     spmi_bus {
         #address-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/pm2250.dtsi b/arch/arm64/boot/dts/qcom/pm2250.dtsi
index 5f1d15db5c99..a26466de03ad 100644
--- a/arch/arm64/boot/dts/qcom/pm2250.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm2250.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2023, Linaro Ltd
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm6125.dtsi b/arch/arm64/boot/dts/qcom/pm6125.dtsi
index 99369a0cdb61..c10625728d23 100644
--- a/arch/arm64/boot/dts/qcom/pm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6125.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index ddbaf7280b03..844e77de1fa0 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2019, The Linux Foundation. All rights reserved.
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
index d13a1ab7c20b..208b5ec8dca6 100644
--- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2019, The Linux Foundation. All rights reserved.
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index 98dc04962fe3..bc5ce1ae9920 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2020, Konrad Dybcio
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm660l.dtsi b/arch/arm64/boot/dts/qcom/pm660l.dtsi
index 6fdbf507c262..c16dc3c4a6a3 100644
--- a/arch/arm64/boot/dts/qcom/pm660l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660l.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2020, Konrad Dybcio
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index 3bf7cf5d1700..e5ea669795a3 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -3,7 +3,7 @@
  * Copyright (C) 2022 Luca Weiss <luca.weiss@fairphone.com>
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index 3ba3ba5d8fce..5dbfebc43847 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -7,7 +7,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index 1aee3270ce7b..68d612d4277d 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -4,7 +4,7 @@
  * Copyright (c) 2019, Linaro Limited
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index ac08a09c64c2..a0b89a43baf0 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -4,7 +4,7 @@
  * Copyright (c) 2019, Linaro Limited
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index f4de86787743..76b6be98945b 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm8950.dtsi b/arch/arm64/boot/dts/qcom/pm8950.dtsi
index f03095779de0..33b401c9e70d 100644
--- a/arch/arm64/boot/dts/qcom/pm8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8950.dtsi
@@ -5,7 +5,7 @@
  * Copyright (c) 2022, Marijn Suijten <marijn.suijten@somainline.org>
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
diff --git a/arch/arm64/boot/dts/qcom/pm8953.dtsi b/arch/arm64/boot/dts/qcom/pm8953.dtsi
index 1067e141be6c..5e2a7a3783b5 100644
--- a/arch/arm64/boot/dts/qcom/pm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8953.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause
 /* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
index d44a95caf04a..cfa4eb5723a6 100644
--- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 3f82715392c6..26f46f898eb6 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /* Copyright 2018 Google LLC. */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pmi632.dtsi b/arch/arm64/boot/dts/qcom/pmi632.dtsi
index 4eb79e0ce40a..09f7af85d39b 100644
--- a/arch/arm64/boot/dts/qcom/pmi632.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi632.dtsi
@@ -3,7 +3,7 @@
  * Copyright (C) 2023 Luca Weiss <luca@z3ntu.xyz>
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
index 1029f3b1bb9a..6fd1acdab640 100644
--- a/arch/arm64/boot/dts/qcom/pmi8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019, AngeloGioacchino Del Regno <kholk11@gmail.com>
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
index dbd4b91dfe06..6d95a1352db1 100644
--- a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
@@ -6,7 +6,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
index 0d0a846ac8d9..9f3e4121d834 100644
--- a/arch/arm64/boot/dts/qcom/pmp8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
 
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 &spmi_bus {
 	pmic@0 {
diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 461ad97032f7..673a8ea5b64d 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -5,7 +5,7 @@
 
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/input/linux-event-codes.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index b5fe7356be48..1dd4aa300f7f 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -7,7 +7,7 @@
 
 /dts-v1/;
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h>
 #include "sc7280-idp.dtsi"
 #include "pmr735a.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 2ff549f4dc7a..63bc5c8ca6df 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -5,7 +5,7 @@
  * Copyright (c) 2021, The Linux Foundation. All rights reserved.
  */
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include "sc7280.dtsi"
 #include "pm7325.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index f9b96bd2477e..ecd17cbaa966 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -11,8 +11,8 @@
  * Copyright 2022 Google LLC.
  */
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
index ddc84282f142..931a8d911229 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
@@ -7,7 +7,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index f2055899ae7a..1abad151d61f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -7,9 +7,9 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index ade619805519..c20abdf34eb7 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -14,7 +14,7 @@
 
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 20153d08edde..11416c504822 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -6,10 +6,10 @@
 /dts-v1/;
 
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350b.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350b.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include "sm8450.dtsi"
 #include "pm8350.dtsi"
diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index 7cb0692fe612..2c7decca5c6c 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -23,7 +23,7 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 #define ADC5_GEN3_HS				0x45
 #define ADC5_GEN3_HS_BUSY			BIT(7)
diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index b6b612d733ff..4225952001f3 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -20,7 +20,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 #define ADC5_USR_REVISION1			0x0
 #define ADC5_USR_STATUS1			0x8
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index f5c6f1f27b2c..c3602c53968a 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -20,7 +20,7 @@
 #include <linux/slab.h>
 #include <linux/log2.h>
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* VADC register and bit definitions */
 #define VADC_REVISION2				0x1
diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
index 4c1ef10a4607..0f25ef87ed5c 100644
--- a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
@@ -10,7 +10,7 @@
 #define PM8550_SID		1
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* ADC channels for PM8550_ADC for PMIC5 Gen3 */
 #define PM8550_ADC5_GEN3_REF_GND			(PM8550_SID << 8 | ADC5_GEN3_REF_GND)
diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
index b62971243700..47116bbe45de 100644
--- a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
@@ -10,7 +10,7 @@
 #define PM8550B_SID		7
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* ADC channels for PM8550B_ADC for PMIC5 Gen3 */
 #define PM8550B_ADC5_GEN3_REF_GND			(PM8550B_SID << 8 | ADC5_GEN3_REF_GND)
diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
index 175bba532ee9..360f2245d582 100644
--- a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
@@ -6,7 +6,7 @@
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H
 #define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* ADC channels for PM8550VX_ADC for PMIC5 Gen3 */
 #define PM8550VS_ADC5_GEN3_REF_GND(sid)			((sid) << 8 | ADC5_GEN3_REF_GND)
diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
index 4d32e13bb8d6..3fc829ebdf6d 100644
--- a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
@@ -10,7 +10,7 @@
 #define PMK8550_SID		0
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* ADC channels for PMK8550_ADC for PMIC5 Gen3 */
 #define PMK8550_ADC5_GEN3_REF_GND			(PMK8550_SID << 8 | ADC5_GEN3_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h
similarity index 98%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h
index 5d98f7d48a1e..ef818248ec8c 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h
@@ -6,7 +6,7 @@
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
 #define _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* ADC channels for PM8350_ADC for PMIC7 */
 #define PM8350_ADC7_REF_GND(sid)			((sid) << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350b.h
similarity index 99%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350b.h
index 57c7977666d3..d841bf00b7b0 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350b.h
@@ -10,7 +10,7 @@
 #define PM8350B_SID					3
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* ADC channels for PM8350B_ADC for PMIC7 */
 #define PM8350B_ADC7_REF_GND			(PM8350B_SID << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h
similarity index 97%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h
index 3d1a41a22cef..161b211ec126 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h
@@ -10,7 +10,7 @@
 #define PMK8350_SID					0
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* ADC channels for PMK8350_ADC for PMIC7 */
 #define PMK8350_ADC7_REF_GND			(PMK8350_SID << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h
similarity index 95%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h
index c5adfa82b20d..fedc9e3882b8 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h
@@ -10,7 +10,7 @@
 #define PMR735A_SID					4
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* ADC channels for PMR735A_ADC for PMIC7 */
 #define PMR735A_ADC7_REF_GND			(PMR735A_SID << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735b.h
similarity index 100%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735b.h
diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
similarity index 100%
rename from include/dt-bindings/iio/qcom,spmi-vadc.h
rename to include/dt-bindings/iio/adc/qcom,spmi-vadc.h
-- 
2.25.1

