Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A057EEE7A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbjKQJ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbjKQJ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:28:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400E0D51;
        Fri, 17 Nov 2023 01:28:28 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH68obv025683;
        Fri, 17 Nov 2023 09:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=tV4ChuQEIG4h7iNbZIHpIZiDq4WwG3YyiYQ4bU1vDgI=;
 b=dQCoY1Ffupq9TlsNG33421g9qNpFCelNw4+KA25JPqkpQRDCKonMep3zKxozkCyOGS1M
 VffPHUtDDXiI9QXxeczCAbrZafBXojPf6V+HnKFjyOTP4NUjgKWTaKoUl5UAqH1i9Ibx
 wii+TdoHaICfYnP6ZdGfUcdb+jYVCSf7UlqftqvNODfciovJ9YPZukEEZJ63K89nlBzl
 mmrzFLHkdtWQwDcd1YETdxDE0T2ZqvnvDL5jvpoS7Me1cuseTMmOpa/y8qP41yvpkYfM
 jyp9rrbCk/DEq9z2oKbPlvTwOn9trysAMaQyv/EtKtokNGyUhGcHDvw+EQsxRtEk4Tvf 0A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ue2na0dr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:28:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AH9SNP5007377
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:28:23 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 17 Nov 2023 01:28:17 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_tdas@quicinc.com>, <quic_rjendra@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>,
        <quic_tsoni@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V2 3/4] dt-bindings: clock: qcom-rpmhcc: Add RPMHCC bindings for X1E80100
Date:   Fri, 17 Nov 2023 14:57:36 +0530
Message-ID: <20231117092737.28362-4-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231117092737.28362-1-quic_sibis@quicinc.com>
References: <20231117092737.28362-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kxctvb5vt1grnOIYzt5McQScF6LOd4Vh
X-Proofpoint-ORIG-GUID: Kxctvb5vt1grnOIYzt5McQScF6LOd4Vh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_07,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=897 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311170069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <quic_rjendra@quicinc.com>

Add bindings and update documentation for clock rpmh driver on X1E80100
SoCs.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v2:
* Update the part number from sc8380xp to x1e80100.
* Pick-up Rbs from the list.

 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index 4eb5e59f6772..603da187d62e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -35,6 +35,7 @@ properties:
       - qcom,sm8350-rpmh-clk
       - qcom,sm8450-rpmh-clk
       - qcom,sm8550-rpmh-clk
+      - qcom,x1e80100-rpmh-clk
 
   clocks:
     maxItems: 1
-- 
2.17.1

