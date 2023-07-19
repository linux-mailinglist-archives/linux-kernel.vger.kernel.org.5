Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD92758D06
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjGSFXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGSFWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:22:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ED1119;
        Tue, 18 Jul 2023 22:22:51 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J2j3kb011000;
        Wed, 19 Jul 2023 05:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=DKDvLh8p2vRTJGtzgynlitJ7QsagG32ML00xgCT055k=;
 b=cFiX9c8xrYdBOk25esEn7atC0JKods2+EhgOZf+SouRRqBWqIlWYSlpJ1KV3Dhr//nh7
 NNRyhVQXlsMiJNWEpXM+/RQAviAuYHSd2IwPtqptd1DThxP98QqXZhsTitrFnK1B43yL
 P1/fGcv6iBT/6RreSz1pXpkHZWNcoBxMJyBCwKP0mRcg/FWruHPuBNBW+pEA+gyRpYTs
 f86DhMAAhe03W6pK5UZeFHK/XRDutvwiqyd+VTW9IGVUp/B/oADegS6SNIY9y+Awe7jm
 VLaxPyhQvqibjOFBljIYcKSdDr7/yHjNSnuYjRXmBlESw62kJ+UFcPDUuLS8C4RoyhQD kg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwps5acrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 05:22:47 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36J5MjAC004750;
        Wed, 19 Jul 2023 05:22:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rumhm1bce-1;
        Wed, 19 Jul 2023 05:22:44 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36J5Mi7f004723;
        Wed, 19 Jul 2023 05:22:44 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36J5MiUx004737;
        Wed, 19 Jul 2023 05:22:44 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 04948E07; Wed, 19 Jul 2023 10:52:44 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 2/2] soc: qcom: rpmhpd: Use the newly created generic RPMHPD bindings
Date:   Wed, 19 Jul 2023 10:52:42 +0530
Message-Id: <1689744162-9421-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8Khtt-dPajsYVUCmJ3C8gCKm3hm0Kh4y
X-Proofpoint-ORIG-GUID: 8Khtt-dPajsYVUCmJ3C8gCKm3hm0Kh4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_02,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=968 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190049
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the SoC SM8[2345]50 entries to use the new
generic RPMHPD bindings.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/soc/qcom/rpmhpd.c | 101 +++++++++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 50 deletions(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 63c35a3..18d8544 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -15,6 +15,7 @@
 #include <soc/qcom/cmd-db.h>
 #include <soc/qcom/rpmh.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/power/qcom,rpmhpd.h>
 
 #define domain_to_rpmhpd(domain) container_of(domain, struct rpmhpd, pd)
 
@@ -359,16 +360,16 @@ static const struct rpmhpd_desc sa8155p_desc = {
 
 /* SM8250 RPMH powerdomains */
 static struct rpmhpd *sm8250_rpmhpds[] = {
-	[SM8250_CX] = &cx_w_mx_parent,
-	[SM8250_CX_AO] = &cx_ao_w_mx_parent,
-	[SM8250_EBI] = &ebi,
-	[SM8250_GFX] = &gfx,
-	[SM8250_LCX] = &lcx,
-	[SM8250_LMX] = &lmx,
-	[SM8250_MMCX] = &mmcx,
-	[SM8250_MMCX_AO] = &mmcx_ao,
-	[SM8250_MX] = &mx,
-	[SM8250_MX_AO] = &mx_ao,
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_CX_AO] = &cx_ao_w_mx_parent,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
 };
 
 static const struct rpmhpd_desc sm8250_desc = {
@@ -378,19 +379,19 @@ static const struct rpmhpd_desc sm8250_desc = {
 
 /* SM8350 Power domains */
 static struct rpmhpd *sm8350_rpmhpds[] = {
-	[SM8350_CX] = &cx_w_mx_parent,
-	[SM8350_CX_AO] = &cx_ao_w_mx_parent,
-	[SM8350_EBI] = &ebi,
-	[SM8350_GFX] = &gfx,
-	[SM8350_LCX] = &lcx,
-	[SM8350_LMX] = &lmx,
-	[SM8350_MMCX] = &mmcx,
-	[SM8350_MMCX_AO] = &mmcx_ao,
-	[SM8350_MSS] = &mss,
-	[SM8350_MX] = &mx,
-	[SM8350_MX_AO] = &mx_ao,
-	[SM8350_MXC] = &mxc,
-	[SM8350_MXC_AO] = &mxc_ao,
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_CX_AO] = &cx_ao_w_mx_parent,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
 };
 
 static const struct rpmhpd_desc sm8350_desc = {
@@ -400,19 +401,19 @@ static const struct rpmhpd_desc sm8350_desc = {
 
 /* SM8450 RPMH powerdomains */
 static struct rpmhpd *sm8450_rpmhpds[] = {
-	[SM8450_CX] = &cx,
-	[SM8450_CX_AO] = &cx_ao,
-	[SM8450_EBI] = &ebi,
-	[SM8450_GFX] = &gfx,
-	[SM8450_LCX] = &lcx,
-	[SM8450_LMX] = &lmx,
-	[SM8450_MMCX] = &mmcx_w_cx_parent,
-	[SM8450_MMCX_AO] = &mmcx_ao_w_cx_parent,
-	[SM8450_MSS] = &mss,
-	[SM8450_MX] = &mx,
-	[SM8450_MX_AO] = &mx_ao,
-	[SM8450_MXC] = &mxc,
-	[SM8450_MXC_AO] = &mxc_ao,
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx_w_cx_parent,
+	[RPMHPD_MMCX_AO] = &mmcx_ao_w_cx_parent,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
 };
 
 static const struct rpmhpd_desc sm8450_desc = {
@@ -422,20 +423,20 @@ static const struct rpmhpd_desc sm8450_desc = {
 
 /* SM8550 RPMH powerdomains */
 static struct rpmhpd *sm8550_rpmhpds[] = {
-	[SM8550_CX] = &cx,
-	[SM8550_CX_AO] = &cx_ao,
-	[SM8550_EBI] = &ebi,
-	[SM8550_GFX] = &gfx,
-	[SM8550_LCX] = &lcx,
-	[SM8550_LMX] = &lmx,
-	[SM8550_MMCX] = &mmcx_w_cx_parent,
-	[SM8550_MMCX_AO] = &mmcx_ao_w_cx_parent,
-	[SM8550_MSS] = &mss,
-	[SM8550_MX] = &mx,
-	[SM8550_MX_AO] = &mx_ao,
-	[SM8550_MXC] = &mxc,
-	[SM8550_MXC_AO] = &mxc_ao,
-	[SM8550_NSP] = &nsp,
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx_w_cx_parent,
+	[RPMHPD_MMCX_AO] = &mmcx_ao_w_cx_parent,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_NSP] = &nsp,
 };
 
 static const struct rpmhpd_desc sm8550_desc = {
-- 
2.7.4

