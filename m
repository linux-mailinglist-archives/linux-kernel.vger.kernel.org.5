Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A6C7B9E33
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjJEN7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjJEN5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:57:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F49628126;
        Thu,  5 Oct 2023 06:45:51 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3952Wv5l000725;
        Thu, 5 Oct 2023 04:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aNc/qQqVLrd5xCqMkKsIbyqjupUyO0PkNQXzy7ahMHA=;
 b=T2bMfJeSlP+bWY+aPttMPiUF7rC/gMuqJ42qsO0bYvxjWrEz+mLZyWkEEY+cX+wi1cP/
 0C4YVlBpN1JId0nBVc8wW7tU8X4BBpcppHnrZUVX7TPT3ppG6ORaX4ST64kDVuSLRqT9
 GzH3d0/5gJw4i9e4GOO818F6POEqb4X6xIfbIr1M/8E3Xu6688pY94DeRR3vtOJNv5ZB
 ql+6RpO77DOOcHgpgtvr/PLhM39tCzSab2M9OpFhb9mnfM9sSSDTsC+NQSWyGur98gNu
 1LD38eK/P5fhD4JCtSAQoK1gJLgsgnQYvR3QDZzbc8k17U9BnYwz71Jmy+GSQ9++hgdi CA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgqth3th1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 04:31:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3954VvpI011499
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 04:31:57 GMT
Received: from hu-devipriy-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 4 Oct 2023 21:31:51 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thierry.reding@gmail.com>, <ndesaulniers@google.com>,
        <trix@redhat.com>, <baruch@tkos.co.il>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
CC:     <linux-pwm@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <nathan@kernel.org>
Subject: [PATCH V14 2/4] dt-bindings: pwm: add IPQ6018 binding
Date:   Thu, 5 Oct 2023 10:01:25 +0530
Message-ID: <20231005043127.2690639-3-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005043127.2690639-1-quic_devipriy@quicinc.com>
References: <20231005043127.2690639-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lhP7K0QSAbvAMaOZtoyHr8rw6AgOtNox
X-Proofpoint-GUID: lhP7K0QSAbvAMaOZtoyHr8rw6AgOtNox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT binding for the PWM block in Qualcomm IPQ6018 SoC.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
v14:

  Picked up the R-b tag

v13:

  Updated the file name to match the compatible
  
  Sorted the properties and updated the order in the required field

  Dropped the syscon node from examples

v12:

  Picked up the R-b tag

v11:

  No change

v10:

  No change

v9:

  Add 'ranges' property to example (Rob)

  Drop label in example (Rob)

v8:

  Add size cell to 'reg' (Rob)

v7:

  Use 'reg' instead of 'offset' (Rob)

  Drop 'clock-names' and 'assigned-clock*' (Bjorn)

  Use single cell address/size in example node (Bjorn)

  Move '#pwm-cells' lower in example node (Bjorn)

  List 'reg' as required

v6:

  Device node is child of TCSR; remove phandle (Rob Herring)

  Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)

v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
    Andersson, Kathiravan T)

v4: Update the binding example node as well (Rob Herring's bot)

v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)

v2: Make #pwm-cells const (Rob Herring)

 .../bindings/pwm/qcom,ipq6018-pwm.yaml        | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
new file mode 100644
index 000000000000..6d0d7ed271f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/qcom,ipq6018-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ6018 PWM controller
+
+maintainers:
+  - Baruch Siach <baruch@tkos.co.il>
+
+properties:
+  compatible:
+    const: qcom,ipq6018-pwm
+
+  reg:
+    description: Offset of PWM register in the TCSR block.
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#pwm-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
+
+    pwm: pwm@a010 {
+        compatible = "qcom,ipq6018-pwm";
+        reg = <0xa010 0x20>;
+        clocks = <&gcc GCC_ADSS_PWM_CLK>;
+        assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+        assigned-clock-rates = <100000000>;
+        #pwm-cells = <2>;
+    };
-- 
2.34.1

