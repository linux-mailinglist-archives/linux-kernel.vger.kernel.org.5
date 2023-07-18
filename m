Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184837581C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjGRQJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjGRQJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:09:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08EEF1;
        Tue, 18 Jul 2023 09:09:45 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IEvqlG011907;
        Tue, 18 Jul 2023 16:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=2oGvnkersZscNerNLghM9qcUlAK4d1uqGuCo7ejD2vY=;
 b=j+ymbiLbNfUG8CX11HFMlf9pND/3UTk4/xhgBOhgOrBqqilIDJyQg8ChmrSTuaEwMCUE
 AiujO8dm+xGNaI2/Y6Vuz9Xte1THMs4kQkq8QXtC2Mn7lCME7MiAS/6uibfRnxRSEdWu
 Kd0Sag8BUsYJGKjVRBaNvkI+xhFeEXWzvodg2L53NVlsOWkoht5kCNo64c8uBzyADzyy
 xzg0QAdWuTJQrLhaCFVpRM/GnoYozu01G4Svf4qtkjEEA834pJcmWCZFy3Kj7LElycen
 5xF/Ksc/eXiE2hdqo8DwO3dPu99dQApxZTKdKmfcYStVPN3vgtdykmXJMgZjMbLN5Etr Ug== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwqqg926t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 16:09:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36IG901N019332
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 16:09:00 GMT
Received: from car-linux11.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 09:08:59 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: arm: Add qcom specific hvc transport for SCMI
Date:   Tue, 18 Jul 2023 09:08:32 -0700
Message-ID: <20230718160833.36397-2-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230718160833.36397-1-quic_nkela@quicinc.com>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aYY46OFvVDFhcECyN0Rv5QmCOB7TrfDt
X-Proofpoint-ORIG-GUID: aYY46OFvVDFhcECyN0Rv5QmCOB7TrfDt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_12,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307180149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce compatible "qcom,scmi-hvc-shmem" for SCMI
transport channel for Qualcomm virtual platforms.
The compatible mandates a shared memory channel.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---
 .../bindings/firmware/arm,scmi.yaml           | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index b138f3d23df8..605b1e997a85 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -45,6 +45,9 @@ properties:
       - description: SCMI compliant firmware with OP-TEE transport
         items:
           - const: linaro,scmi-optee
+      - description: SCMI compliant firmware with Qualcomm hvc/shmem transport
+        items:
+          - const: qcom,scmi-hvc-shmem
 
   interrupts:
     description:
@@ -321,6 +324,16 @@ else:
       required:
         - linaro,optee-channel-id
 
+    else:
+      if:
+        properties:
+          compatible:
+            contains:
+              const: qcom,scmi-hvc-shmem
+      then:
+        required:
+          - shmem
+
 examples:
   - |
     firmware {
@@ -444,6 +457,62 @@ examples:
         };
     };
 
+  - |
+    firmware {
+        scmi_dpu {
+            compatible = "qcom,scmi-hvc-shmem";
+            shmem = <&shmem_dpu>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            scmi_pd_dpu: protocol@11 {
+                reg = <0x11>;
+                #power-domain-cells = <1>;
+            };
+        };
+
+        scmi_gpu {
+            compatible = "qcom,scmi-hvc-shmem";
+            shmem = <&shmem_gpu>;
+
+            interrupts = <GIC_SPI 931 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "a2p";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            scmi_pd_gpu: protocol@11 {
+                reg = <0x11>;
+                #power-domain-cells = <1>;
+            };
+        };
+    };
+
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        sram@95c00000 {
+            compatible = "mmio-sram";
+            reg = <0x95c00000 0x10000>;
+
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges;
+
+            shmem_dpu: scmi-sram-dpu@95c00000 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x95c00000 0x3f0>;
+            };
+
+            shmem_gpu: scmi-sram-gpu@95c00400 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x95c00400 0x3f0>;
+            };
+        };
+    };
+
   - |
     firmware {
         scmi {
-- 
2.17.1

