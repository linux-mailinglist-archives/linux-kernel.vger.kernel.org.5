Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721B27D601E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjJYCye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjJYCyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:54:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1794910DD;
        Tue, 24 Oct 2023 19:54:25 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39P2ouN2012000;
        Wed, 25 Oct 2023 02:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=hn9mhR5RMtGp/VREWzead47cBu+WM56qoLsJ7Pvx7NU=;
 b=GkEJFeCJK/72N0zpFzohRnCkZqd7jK1HptY+n2lA3OcGe2URI5riVZQrPwkSCihHHDnd
 LIV3Qcu+8nRbQGxGkMudPWOGiVFbs6wp8cffdKaBawEcdjKd51SCO35uZnfPYjieoWNT
 8wy5+bRiBrZhJ8mzKR0mz8ZIri3jmczhEWKXnHNLMYhPGKWzJBni/BFpv5WplcbmpIYt
 fQ2MqZX+ILT4IZoTPMJxNtIt4tl7qHtv+DndW4dSiC/lv+IRDyWElikMM4L6ltRg81FH
 7l+XZfg93WTwk6Cn8uLg9pt8pP74c+xzZFPmRKoWqbrjtFSRsMJeeaJu8QhzpR0dSnT4 1A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txtbf00tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 02:54:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39P2ru33013200
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 02:53:56 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 24 Oct 2023 19:53:51 -0700
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
Subject: [PATCH v2 1/8] dt-bindings: arm: Add support for CMB element size
Date:   Wed, 25 Oct 2023 10:53:21 +0800
Message-ID: <1698202408-14608-2-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698202408-14608-1-git-send-email-quic_taozha@quicinc.com>
References: <1698202408-14608-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yEy50KHFJhsXy1LqSYB8y5G6KE5cQOAK
X-Proofpoint-ORIG-GUID: yEy50KHFJhsXy1LqSYB8y5G6KE5cQOAK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=883 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add property "qcom,cmb-elem-size" to support CMB(Continuous
Multi-Bit) element for TPDM. The associated aggregator will read
this size before it is enabled. CMB element size currently only
supports 32-bit and 64-bit.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../bindings/arm/qcom,coresight-tpdm.yaml          | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 61ddc3b..f9a2025 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -52,6 +52,14 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint8
     enum: [32, 64]
 
+  qcom,cmb-element-size:
+    description:
+      Specifies the CMB(Continuous Multi-Bit) element size supported by
+      the monitor. The associated aggregator will read this size before it
+      is enabled. CMB element size currently only supports 32-bit and 64-bit.
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [8, 32, 64]
+
   qcom,dsb-msrs-num:
     description:
       Specifies the number of DSB(Discrete Single Bit) MSR(mux select register)
@@ -110,4 +118,23 @@ examples:
       };
     };
 
+    tpdm@6c29000 {
+      compatible = "qcom,coresight-tpdm", "arm,primecell";
+      reg = <0x06c29000 0x1000>;
+      reg-names = "tpdm-base";
+
+      qcom,cmb-element-size = /bits/ 8 <64>;
+
+      clocks = <&aoss_qmp>;
+      clock-names = "apb_pclk";
+
+      out-ports {
+        port {
+          tpdm_ipcc_out_funnel_center: endpoint {
+            remote-endpoint =
+              <&funnel_center_in_tpdm_ipcc>;
+          };
+        };
+      };
+    };
 ...
-- 
2.7.4

