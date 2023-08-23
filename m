Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472C3785C56
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjHWPo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjHWPo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:44:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17019E52;
        Wed, 23 Aug 2023 08:44:26 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NEOjcT016771;
        Wed, 23 Aug 2023 15:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=75OGKGZobLN86QE8S1Fo0Ia1BOGzr7bQSpO253BHSPs=;
 b=BTb924NduGGtIFoIPW28HWgs42y57fzPl5cS0brPAZdYc38PrRZvAWw0WTTBwxk7e6ST
 h/xzxAoHGDN0Vua+Kg5qsLUJaNEgRzp1Sdr4DeqWr5xPTWBDmRif2rXBU/QheUs1SHy4
 0PS4o0TLWSe/OhPO8FEbPm0MjZciVYmkmPqOiFt6JrTJM9cmu2cyAKo206wOJz6glFnM
 Jmf/ndD+K3KAUB/enj2NKbrOjq+/jC1KGEI3gX98SSjNgYM+DIYHP6mtFs34a1ubFypJ
 xZ4wGExdOm+UGcKNsxmxtgvaAxJXRqXjk8hxfWeM+owr8BOeSWJwe7TnRgcjtmXys2jk Ew== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snkumr7q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 15:44:19 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37NFiGgV029192;
        Wed, 23 Aug 2023 15:44:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sjptm3qdj-1;
        Wed, 23 Aug 2023 15:44:16 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37NFiG3I029185;
        Wed, 23 Aug 2023 15:44:16 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37NFiGRJ029179;
        Wed, 23 Aug 2023 15:44:16 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id C2AA95000AB; Wed, 23 Aug 2023 21:14:15 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V5 1/6] scsi: ufs: qcom: Update offset for core_clk_1us_cycles
Date:   Wed, 23 Aug 2023 21:14:08 +0530
Message-Id: <20230823154413.23788-2-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _bstBj6IkelJ-bSKnmj5RG9IYaWosgvD
X-Proofpoint-ORIG-GUID: _bstBj6IkelJ-bSKnmj5RG9IYaWosgvD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=978
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230142
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch updates offset for core_clk_1us_cycles in DME_VS_CORE_CLK_CTRL
register. Offset for core_clk_1us_cycles is changed from Qualcomm UFS
Controller V4.0.0 onwards.

Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 19 ++++++++++++++-----
 drivers/ufs/host/ufs-qcom.h |  2 ++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index f88febb23123..1108b0cd43b3 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1297,12 +1297,21 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
 }

 static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
-						       u32 clk_cycles)
+						       u32 clk_1us_cycles)
 {
-	int err;
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	u32 mask = DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
 	u32 core_clk_ctrl_reg;
+	u32 offset = 0;
+	int err;
+
+	/* Bit mask and offset changed on UFS host controller V4.0.0 onwards */
+	if (host->hw_ver.major >= 4) {
+		mask = MAX_CORE_CLK_1US_CYCLES_MASK_V4;
+		offset = MAX_CORE_CLK_1US_CYCLES_OFFSET_V4;
+	}

-	if (clk_cycles > DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK)
+	if (clk_1us_cycles > mask)
 		return -EINVAL;

 	err = ufshcd_dme_get(hba,
@@ -1311,8 +1320,8 @@ static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
 	if (err)
 		return err;

-	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
-	core_clk_ctrl_reg |= clk_cycles;
+	core_clk_ctrl_reg &= ~(mask << offset);
+	core_clk_ctrl_reg |= clk_1us_cycles << offset;

 	/* Clear CORE_CLK_DIV_EN */
 	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index d6f8e74bd538..a829296e11bb 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -129,6 +129,8 @@ enum {
 #define PA_VS_CONFIG_REG1	0x9000
 #define DME_VS_CORE_CLK_CTRL	0xD002
 /* bit and mask definitions for DME_VS_CORE_CLK_CTRL attribute */
+#define MAX_CORE_CLK_1US_CYCLES_MASK_V4		0xFFF
+#define MAX_CORE_CLK_1US_CYCLES_OFFSET_V4	0x10
 #define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT		BIT(8)
 #define DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK	0xFF

--
2.17.1

