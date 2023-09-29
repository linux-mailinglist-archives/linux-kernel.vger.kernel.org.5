Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28677B336B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjI2NUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjI2NUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:20:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E34BE7;
        Fri, 29 Sep 2023 06:20:02 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TBCfn4027588;
        Fri, 29 Sep 2023 13:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=djF4G+3iPZueudohzeoKOdNApP2XEG/pet+/xmFU4zQ=;
 b=dNLtYD8RP15vX9qqdXjQkxdpcbna31xU5369E7ykaPfCmWXV5E7j+pijhfDPMQUHEmxT
 Ay1vZEomC2YRMnEXv+4P9VCiK+3UAja0S1NsaBQ+JUbb0rPfAnphm8IL4ZZVTh3q+l/D
 9I96LcSeiLxVhUp5aUNDxU6iWSyUrJXyn3s6FcTHRTNRwkGfvCNR9PnQxgVYcwRCeHLw
 aEX10F3X651SzKRLSx/nQ3wOhAiAdS/Fln0Q2m0l4iP8x+ozi3ApFrRhX9XVYC0KtT0V
 RySZtKy0DeweqlILqqNnVQuz8O/jnlE3xLlhvMmSWjrzm0vLFFFo/IyAfXXtTkGRSfeP Yg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tdwgkrd8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 13:19:49 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38TDJjmu018522;
        Fri, 29 Sep 2023 13:19:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3t9s3m3gcw-1;
        Fri, 29 Sep 2023 13:19:45 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TDJj1U018516;
        Fri, 29 Sep 2023 13:19:45 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 38TDJi8H018513;
        Fri, 29 Sep 2023 13:19:45 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 267E2571638; Fri, 29 Sep 2023 18:49:44 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, alim.akhtar@samsung.com, bvanassche@acm.org,
        avri.altman@wdc.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V4 1/4] scsi: ufs: qcom: dt-bindings: Add SC7280 compatible string
Date:   Fri, 29 Sep 2023 18:49:33 +0530
Message-Id: <20230929131936.29421-2-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230929131936.29421-1-quic_nitirawa@quicinc.com>
References: <20230929131936.29421-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: srU-mkXPKW5d8gGJR_FnUpm0wjVl6Rzo
X-Proofpoint-GUID: srU-mkXPKW5d8gGJR_FnUpm0wjVl6Rzo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=843
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290114
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible string for the UFS found on SC7280.

Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 462ead5a1cec..802640efa956 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,msm8996-ufshc
           - qcom,msm8998-ufshc
           - qcom,sa8775p-ufshc
+          - qcom,sc7280-ufshc
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
           - qcom,sm6115-ufshc
@@ -117,6 +118,7 @@ allOf:
             enum:
               - qcom,msm8998-ufshc
               - qcom,sa8775p-ufshc
+              - qcom,sc7280-ufshc
               - qcom,sc8280xp-ufshc
               - qcom,sm8250-ufshc
               - qcom,sm8350-ufshc
--
2.17.1

