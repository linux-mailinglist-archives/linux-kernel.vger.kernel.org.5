Return-Path: <linux-kernel+bounces-3436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A964816C33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BE328444A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858E31A5AE;
	Mon, 18 Dec 2023 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AF4EEx1d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED10B199D3;
	Mon, 18 Dec 2023 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAsE2N014268;
	Mon, 18 Dec 2023 11:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=oKpFY6BB+SCt9JrJ+9BOpkSvsgCgf7eGhPjITeKw9Ms=; b=AF
	4EEx1d4M9v8Xjg6FUaf5Mxnm++SSuvk0ocWFjzZ8Gj4Yr/LRJgvxOujZotcVtQCA
	2tlP7kCLEMYoK8yEw4qhDgK4a+LAk4ASwN+Q5dUw/pt15SjDWeM6mpU0LMxKieH1
	WeVnjxTNkBhHX6fHp99+z8XOEFMtVSnsC6ooiXA+/MG9Y0lYrCRS9DH0XKNcgCsC
	dBHm8oNw+CixhuHbj6T8L5zvwK6SYcW03vng6XnfFpQLcm2YGqAElo6CsMg0XSc+
	pqgLsjje8DVEEBlqe+wu1ctMLo6Cc/cZcQol15/pIk00oXY6Kot3OBPAiHytiKyw
	AutiCNZx0E6/p1x2riag==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2jx0gb99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:33:09 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBVmpL028250;
	Mon, 18 Dec 2023 11:33:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyga-1;
	Mon, 18 Dec 2023 11:33:05 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX5Am029911;
	Mon, 18 Dec 2023 11:33:05 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX5xd029903;
	Mon, 18 Dec 2023 11:33:05 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 290F822C3; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 04/34] dt-bindings: media: Add sm8550 dt schema
Date: Mon, 18 Dec 2023 17:01:59 +0530
Message-Id: <1702899149-21321-5-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CUNoS0pzTmcp4Xvd6MVOsEby1DWN8UAv
X-Proofpoint-GUID: CUNoS0pzTmcp4Xvd6MVOsEby1DWN8UAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180083
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add a schema description for the iris video encoder/decoder
on sm8550.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../bindings/media/qcom,sm8550-iris.yaml           | 177 +++++++++++++++++++++
 1 file changed, 177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
new file mode 100644
index 0000000..a3d9233
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
@@ -0,0 +1,177 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/qcom,sm8550-iris.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IRIS video encode and decode accelerators
+
+maintainers:
+  - Vikash Garodia <quic_vgarodia@quicinc.com>
+  - Dikshita Agarwal <quic_dikshita@quicinc.com>
+
+description:
+  The Iris video processing unit is a video encode and decode accelerator
+  present on Qualcomm platforms.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - qcom,sm8550-iris
+
+  reg:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    minItems: 2
+    maxItems: 4
+
+  power-domain-names:
+    oneOf:
+      - items:
+          - const: iris-ctl
+          - const: vcodec
+          - const: mxc
+          - const: mmcx
+
+  operating-points-v2: true
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: gcc_video_axi0
+      - const: core_clk
+      - const: vcodec_core
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: iris-cnoc
+      - const: iris-ddr
+
+  memory-region:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: video_axi_reset
+
+  iommus:
+    maxItems: 2
+
+  dma-coherent: true
+
+  opp-table:
+    type: object
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - power-domains
+  - power-domain-names
+  - clocks
+  - clock-names
+  - interconnects
+  - interconnect-names
+  - memory-region
+  - resets
+  - reset-names
+  - iommus
+  - dma-coherent
+  - opp-table
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/clock/qcom,sm8550-gcc.h>
+    #include <dt-bindings/clock/qcom,sm8450-videocc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    iris: video-codec@aa00000 {
+        compatible = "qcom,sm8550-iris";
+
+        reg = <0 0x0aa00000 0 0xf0000>;
+        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+        power-domains = <&videocc VIDEO_CC_MVS0C_GDSC>,
+                        <&videocc VIDEO_CC_MVS0_GDSC>,
+                        <&rpmhpd SM8550_MXC>,
+                        <&rpmhpd SM8550_MMCX>;
+        power-domain-names = "iris-ctl", "vcodec", "mxc", "mmcx";
+        operating-points-v2 = <&iris_opp_table>;
+
+        clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
+                 <&videocc VIDEO_CC_MVS0C_CLK>,
+                 <&videocc VIDEO_CC_MVS0_CLK>;
+        clock-names = "gcc_video_axi0", "core_clk", "vcodec_core";
+
+        interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+                         &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ALWAYS>,
+                        <&mmss_noc MASTER_VIDEO QCOM_ICC_TAG_ALWAYS
+                         &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+        interconnect-names = "iris-cnoc", "iris-ddr";
+
+        /* FW load region */
+        memory-region = <&video_mem>;
+
+        resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
+        reset-names = "video_axi_reset";
+
+        iommus = <&apps_smmu 0x1940 0x0000>,
+                 <&apps_smmu 0x1947 0x0000>;
+        dma-coherent;
+
+        status = "disabled";
+
+        iris_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-240000000 {
+                opp-hz = /bits/ 64 <240000000>;
+                required-opps = <&rpmhpd_opp_svs>,
+                                <&rpmhpd_opp_low_svs>;
+           };
+
+           opp-338000000 {
+               opp-hz = /bits/ 64 <338000000>;
+               required-opps = <&rpmhpd_opp_svs>,
+                               <&rpmhpd_opp_svs>;
+           };
+
+           opp-366000000 {
+               opp-hz = /bits/ 64 <366000000>;
+               required-opps = <&rpmhpd_opp_svs_l1>,
+                               <&rpmhpd_opp_svs_l1>;
+           };
+
+           opp-444000000 {
+               opp-hz = /bits/ 64 <444000000>;
+               required-opps = <&rpmhpd_opp_turbo>,
+                               <&rpmhpd_opp_turbo>;
+           };
+
+           opp-533333334 {
+               opp-hz = /bits/ 64 <533333334>;
+               required-opps = <&rpmhpd_opp_turbo_l1>,
+                               <&rpmhpd_opp_turbo_l1>;
+           };
+       };
+    };
+...
-- 
2.7.4


