Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734547AF08E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjIZQVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjIZQVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:21:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C23311F;
        Tue, 26 Sep 2023 09:20:56 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QD7v2M022515;
        Tue, 26 Sep 2023 16:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=djF4G+3iPZueudohzeoKOdNApP2XEG/pet+/xmFU4zQ=;
 b=Y+NhnlEJgAtt6bPDEaHN4eWD0NymGvS0dVGfWb2K6UNXsdY92M0sUurQ0SgHGlEcxzZo
 HpdJA1I5FmBnXDDj+onz3uRSeepMfDFnkVciOYYqx1tVCqRUlFdhAaW3dHbSOdVBRO1S
 jo+p5pgwh/cVbjypY8eDWWGNBSEmnt6RupHwsUPusiv/QQVFtS8KTUapSIUxTM0mfR4+
 gJHzuUPvmOIK6curRyCLCGPZTAoYfPbu0Qbte+aFtYEIb/xq+nWaCszXWQJ7FcYSLNKQ
 dBoMO0S3IP3BbGevKTTeAhICGdeFkWljs6nD4v6Db2Qmz4lmvsopiToolnXaxICXE3L4 aA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbexgjkbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 16:20:48 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38QGKjvG010041;
        Tue, 26 Sep 2023 16:20:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3t9s3kk6mx-1;
        Tue, 26 Sep 2023 16:20:45 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QGKj64010035;
        Tue, 26 Sep 2023 16:20:45 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 38QGKjpx010032;
        Tue, 26 Sep 2023 16:20:45 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id A6949601918; Tue, 26 Sep 2023 21:50:44 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, alim.akhtar@samsung.com, bvanassche@acm.org,
        avri.altman@wdc.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V2 1/3] scsi: ufs: qcom: dt-bindings: Add SC7280 compatible string
Date:   Tue, 26 Sep 2023 21:50:40 +0530
Message-Id: <20230926162042.14180-2-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230926162042.14180-1-quic_nitirawa@quicinc.com>
References: <20230926162042.14180-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fs8-Hf2QEL75blzKQganX-ffZtdwx_ij
X-Proofpoint-GUID: fs8-Hf2QEL75blzKQganX-ffZtdwx_ij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=843
 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260142
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
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

