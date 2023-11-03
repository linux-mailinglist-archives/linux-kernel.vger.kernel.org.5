Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C447E0871
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344848AbjKCSri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjKCSrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:47:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CAB134;
        Fri,  3 Nov 2023 11:47:31 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3Btkh5007974;
        Fri, 3 Nov 2023 18:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=10R8wpCXS8Tle4evBg077a29dkzx8gBjNZutPNsOfRs=;
 b=HhF+CutUX5VN8s0JoBJ4ai/KeOO7GwP2F9OUHrK5ZNz/XWBaADIw6Rvzu7hcXBhEoQJy
 W4Zh52o6x/R0wcdsuP1jb+oSNjSUEGN/fzuFLCMjG9Ir+XnreYNtlhIVrVv0aDgYg3R+
 jAUlb9LvIhGDgdr2/epDAWHO+0Yon+w3mUndCMuFAsqxyQZ7ggmkA8DAU5z6vCmpWnXe
 LQGjiWGoycaCTYZvLD4y07StdZbqYQ9t6j6NPpTtlhvSP6UesLRZNzPjBOmtPNd8h7ro
 9GSBcDfcZWXvTAeu4t9iy2WIvG4wWWWOyj4fPBB4SeNqD5ZMCuNBDFOa2c2S6LHHq5Be Nw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4sft9s80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 18:47:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3IlOdT018706
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 18:47:24 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 11:47:20 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_nainmeht@quicinc.com>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [RFC PATCH 1/2] dt-bindings: arm: qcom: Add QCM6490 IDP and RB3 board
Date:   Sat, 4 Nov 2023 00:16:54 +0530
Message-ID: <20231103184655.23555-2-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231103184655.23555-1-quic_kbajaj@quicinc.com>
References: <20231103184655.23555-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0P_qNtU8NRNO7_duJUZGIzOK3i65bJzc
X-Proofpoint-ORIG-GUID: 0P_qNtU8NRNO7_duJUZGIzOK3i65bJzc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_18,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=784 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the qcom,qcm6490-idp and qcm6490-rb3 board based off
qcm6490 SoC.

Co-developed-by: Naina Mehta <quic_nainmeht@quicinc.com>
Signed-off-by: Naina Mehta <quic_nainmeht@quicinc.com>
Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 76934f4772e9..6f8a08d2eb99 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -395,6 +395,8 @@ properties:
       - items:
           - enum:
               - fairphone,fp5
+              - qcom,qcm6490-idp
+              - qcom,qcm6490-rb3
           - const: qcom,qcm6490

       - description: Qualcomm Technologies, Inc. Distributed Unit 1000 platform
--
2.42.0

