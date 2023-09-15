Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897427A13A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjIOCQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIOCQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:16:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A671BEB;
        Thu, 14 Sep 2023 19:16:26 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F2CoId030005;
        Fri, 15 Sep 2023 02:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=CzljRTMc/zu3dH+lKmgupmInQF/zW9+MGXIGV/jNRs8=;
 b=F9R2+elhmKcF63g8PRw5OO9dDOHwNH+t6r3oSGAnHK/jF1lRw/Gd6Wa4qb6MSf/+trGL
 rHs5R4t5aNDrwOrwpZjCSocmrG4fCYf1AcHe9j5H3uIvLccsI523x0sE5a0qSSIOOiKI
 dXZDVNwW7NLEsRw7tqWoiB/C+LiEmM57ai9v3R5wW3KDTFMlT1kF7+6oIAyHcKTQ4teu
 bUicZu9h5T5lO7KpbdeYXy5aPA3EH70jAFQX7pwnjs0+T503VomZ/+BJBLGnEsFVxGMp
 9xBjcXsH73I/YzxUmwaU+mzfczpaetPnNnOlO+Pz8jxXNPKQ1MOs+mldpway52YVN15/ Uw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4e9br08x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:16:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F2Fu8f022235
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:15:56 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 19:15:47 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <catalin.marinas@arm.com>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v2 4/8] dt-bindings: arm-smmu: Add compatible for SM4450 SoC
Date:   Fri, 15 Sep 2023 10:15:02 +0800
Message-ID: <20230915021509.25773-3-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230915021509.25773-1-quic_tengfan@quicinc.com>
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iZTvOr-X4MaL_lxxf_nYnfIMmM1NxLlp
X-Proofpoint-GUID: iZTvOr-X4MaL_lxxf_nYnfIMmM1NxLlp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_02,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=711 phishscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SoC specific compatible for SM4450 implementing arm,mmu-500.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index cf29ab10501c..b57751c8ad90 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -47,6 +47,7 @@ properties:
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
               - qcom,sdx75-smmu-500
+              - qcom,sm4450-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500
               - qcom,sm6350-smmu-500
@@ -70,6 +71,7 @@ properties:
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
               - qcom,sdm845-smmu-500
+              - qcom,sm4450-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
@@ -468,6 +470,7 @@ allOf:
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
+              - qcom,sm4450-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
               - qcom,sm8350-smmu-500
-- 
2.17.1

