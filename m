Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A0879AE1E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjIKVDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244237AbjIKToi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:44:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D86918D;
        Mon, 11 Sep 2023 12:44:34 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJSpZs016187;
        Mon, 11 Sep 2023 19:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=kxo6YzH9eE3FtnDbczOy69opAxVkAeFdpBT9zrHMX8k=;
 b=VVCD2qLS2EaiPntJh/5eoW52dbhaFAmU0KtPa7ufTQQ6yvhMqfsdlqxTsk6m0knt+vdC
 nsBc8P5kg3fED/U2UV36oue6of0IG5L4DuaAFGpqj1g80dB2xHWZGwKT3UpcZVCr6ytb
 zti1GbB5Ur77ZxNpnL3tr53XTex21ItFZMWUYzXOVncPzL5UDwhtFrg+JQ0GYtRG/BZ4
 cWirOatNBuDNUNN2lPyYbtQ58NSv/sCxobp26L5qLeCVT7saKtbhYYA7rEVvf0IptMuC
 6jAytRFwuCEwuDq1NZE3AQrxnS3NMacXWcf2boApmwtmkZIAMMLtkAxr7LMjMBNt46Ev 7Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t25yx0hjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 19:44:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BJiPUh022547
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 19:44:25 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 11 Sep 2023 12:44:24 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v4 3/4] dt-bindings: arm: Add new compatible for smc/hvc transport for SCMI
Date:   Mon, 11 Sep 2023 12:43:58 -0700
Message-ID: <20230911194359.27547-4-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230911194359.27547-1-quic_nkela@quicinc.com>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qF5iy2JemLgJWWScj9h8d_OVYnJgXrbw
X-Proofpoint-GUID: qF5iy2JemLgJWWScj9h8d_OVYnJgXrbw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_15,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce compatible "qcom,scmi-hvc-shmem" for SCMI smc/hvc
transport channel for Qualcomm virtual platforms.
The compatible mandates a shared memory channel.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 8d54ea768d38..4090240f45b1 100644
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
@@ -320,6 +323,15 @@ allOf:
       required:
         - linaro,optee-channel-id
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,scmi-hvc-shmem
+    then:
+      required:
+        - shmem
+
 examples:
   - |
     firmware {
-- 
2.17.1

