Return-Path: <linux-kernel+bounces-8967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DACA81BEA2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C065F1F2662C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717C7745CE;
	Thu, 21 Dec 2023 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nsVdOGbN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB565198;
	Thu, 21 Dec 2023 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BLIlZAm011610;
	Thu, 21 Dec 2023 18:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=1HUSwf5UnAAxqLxWlgYuCZyM9L3vVruMBgJS0YdxQco=; b=ns
	VdOGbNfnm/DzrkMq9RS5yUP9gGdeJxGD9vO9JeMRVl3z0IqkTPBC3MDF2GUog6/Q
	UCiBQNeQKW7HC9A/im81LbkOw5cyrYp51AZMhCb6YJhOa5TgaS2oUyoWNNxbpvAW
	70DsGwf7w1tiwQqSMTVvOJV02Sq7OUuYMMLrwx3CoK9Ny9acIxn7DLFuOAiZdUe6
	g/e1jDiOOri/+IYVESJVgWtJO/vpfLqHqwfRnkLUAGyP1IZjg4Lh6upyPl4ypN3S
	0FFxLhgyFZh/jP1IUzFEWMV1fhXGjmeeO9UBeF58TmBCyG4DQuyg4n7PxPSKyaiS
	2rIdn8eT6S7BQF40ZDpQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4gvh245d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 18:59:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BLIx0Hg006261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 18:59:00 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 10:59:00 -0800
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC: <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <quic_gurus@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        "Anjelique
 Melendez" <quic_amelende@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 2/7] dt-bindings: leds: leds-qcom-lpg: Add support for LPG PPG
Date: Thu, 21 Dec 2023 10:58:32 -0800
Message-ID: <20231221185838.28440-3-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231221185838.28440-1-quic_amelende@quicinc.com>
References: <20231221185838.28440-1-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kb524ejp2YpefyANoSSB1ui8jA_KaeaE
X-Proofpoint-GUID: kb524ejp2YpefyANoSSB1ui8jA_KaeaE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0 suspectscore=0
 mlxlogscore=818 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210144

Update leds-qcom-lpg binding to support LPG PPG.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/leds/leds-qcom-lpg.yaml          | 82 ++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index ea84ad426df1..6649ca2ec805 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: >
   The Qualcomm Light Pulse Generator consists of three different hardware blocks;
-  a ramp generator with lookup table, the light pulse generator and a three
+  a ramp generator with lookup table (LUT), the light pulse generator and a three
   channel current sink. These blocks are found in a wide range of Qualcomm PMICs.
 
 properties:
@@ -63,6 +63,29 @@ properties:
         - description: dtest line to attach
         - description: flags for the attachment
 
+  nvmem:
+    description: >
+      This property is required for PMICs that supports PPG, which is when a
+      PMIC stores LPG per-channel data and pattern LUT in SDAM modules instead
+      of in a LUT peripheral. For PMICs, such as PM8350C, per-channel data
+      and pattern LUT is separated into 2 SDAM modules. In that case, phandles
+      to both SDAM modules need to be specified.
+    minItems: 1
+    maxItems: 2
+
+  nvmem-names:
+    minItems: 1
+    items:
+      - const: lpg_chan_sdam
+      - const: lut_sdam
+
+  qcom,pbs:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: >
+      Phandle of the Qualcomm Programmable Boot Sequencer node (PBS).
+      PBS node is used to trigger LPG pattern sequences for PMICs that support
+      single SDAM PPG.
+
   multi-led:
     type: object
     $ref: leds-class-multicolor.yaml#
@@ -106,6 +129,32 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,pmi632-lpg
+    then:
+      properties:
+        nvmem:
+          maxItems: 1
+        nvmem-names:
+          maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8350c-pwm
+              - qcom,pm8550-pwm
+    then:
+      properties:
+        nvmem:
+          minItems: 2
+        nvmem-names:
+          minItems: 2
+
 examples:
   - |
     #include <dt-bindings/leds/common.h>
@@ -191,4 +240,35 @@ examples:
       compatible = "qcom,pm8916-pwm";
       #pwm-cells = <2>;
     };
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    led-controller {
+      compatible = "qcom,pmi632-lpg";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #pwm-cells = <2>;
+      nvmem-names = "lpg_chan_sdam";
+      nvmem = <&pmi632_sdam_7>;
+      qcom,pbs = <&pmi632_pbs_client3>;
+
+      led@1 {
+        reg = <1>;
+        color = <LED_COLOR_ID_RED>;
+        label = "red";
+      };
+
+      led@2 {
+        reg = <2>;
+        color = <LED_COLOR_ID_GREEN>;
+        label = "green";
+      };
+
+      led@3 {
+        reg = <3>;
+        color = <LED_COLOR_ID_BLUE>;
+        label = "blue";
+      };
+    };
+
 ...
-- 
2.41.0


