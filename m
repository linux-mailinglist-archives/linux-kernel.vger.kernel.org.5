Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3340791178
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 08:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbjIDGhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 02:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjIDGhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:37:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C28E6;
        Sun,  3 Sep 2023 23:37:11 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3846Sa70026747;
        Mon, 4 Sep 2023 06:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=RVSgOjjc8Lx1PtMbNzGlpI095je4DEkWdb2qJnArQSQ=;
 b=kc5XV8ZHre/AGvuo6Wxi31eDBRe0TjNGxWjDOWhXUN/BsqNUQSAGoFptMHR4BfA3bBET
 9CVhkPpjUGvQ3E4QZFH4ues1AFyaGaCAzmHYCSK4udGJM/gbT/SQ0jJOClCN/Vjy2LLw
 tV79yU/zUUsUMeMADvoQRKfPCZ6jJejuernKrXWzToj2fcAj8ZHne46mz1DVkeZRoS35
 FwmaIf0FDHLNTGej3s+ibP1CuBnQTDMHtJ00E3+owW3dg4BeaVhaI26ZY1Mv/GvCTet1
 sgUla8JBiiQoq1TYvjbJvwfqsjPHh0ueLy20APAAPObD21SDFzDAMEn0VHmwiTIzQ3sE 4g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suxbftv4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 06:37:02 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3846b2Ui009181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 06:37:02 GMT
Received: from nsekar-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 3 Sep 2023 23:36:56 -0700
From:   Nitheesh Sekar <quic_nsekar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
CC:     Nitheesh Sekar <quic_nsekar@quicinc.com>
Subject: [PATCH V4 1/4] dt-bindings: phy: qcom,m31: Add IPQ5018 compatible
Date:   Mon, 4 Sep 2023 12:06:32 +0530
Message-ID: <20230904063635.24975-2-quic_nsekar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230904063635.24975-1-quic_nsekar@quicinc.com>
References: <20230904063635.24975-1-quic_nsekar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4XYTPBwGTatoAc-Ez-vhCHZihjmbULTa
X-Proofpoint-ORIG-GUID: 4XYTPBwGTatoAc-Ez-vhCHZihjmbULTa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=860 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040059
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5332 qcom,m31 phy driver can support IPQ5018.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
---
 .../devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml       | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
index 2671a048c926..e77576d06c0e 100644
--- a/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
@@ -17,7 +17,9 @@ description:
 properties:
   compatible:
     items:
-      - const: qcom,ipq5332-usb-hsphy
+      - enum:
+          - qcom,ipq5018-usb-hsphy
+          - qcom,ipq5332-usb-hsphy
 
   "#phy-cells":
     const: 0
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

