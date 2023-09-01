Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BFF78FC76
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349235AbjIALnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349212AbjIALnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:43:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B07410D5;
        Fri,  1 Sep 2023 04:43:03 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381A0Cit009800;
        Fri, 1 Sep 2023 11:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=IPdEplR1fA97t+2tm9I9JuniHz5TEiMiIVvWm/BaUPE=;
 b=cn1fmYC0+lNylkMm0e7DU8aWWIue4JK6rqzQuM+hKlyNvsDFnRtQjOp9g+7x0TE/8SZu
 43Qx1+u3JgCrT8zG1763DjBBvrgFXfxuNJxz27oQalrT1NHB/efk+WBTIJotOQklaE6k
 shPUi3Kj5GY/S1d8BNNMaiyap4Qusi40Mw++OFJiMnqZQWvBJHMryyElNVC9w3gC6K5e
 ciloFCivNaUAgNfHEahblR6XznkXdBl6XmmHJLhTqSyVKerSAkcmTSK7cDEcdUbus2TG
 +SaUwxYPRKibBLDfRykd4Aa5Y59eSWfEqi0RzU4ovzqVXzIzNZQsE/JFSoaLNJK5D3L4 Cg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stub8b3a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 11:42:52 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 381Bgm9H013931;
        Fri, 1 Sep 2023 11:42:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sqafmj03v-1;
        Fri, 01 Sep 2023 11:42:48 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 381Bgmws013924;
        Fri, 1 Sep 2023 11:42:48 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 381BgmcW013923;
        Fri, 01 Sep 2023 11:42:48 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id DBD335006A8; Fri,  1 Sep 2023 17:12:47 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V6 1/6] scsi: ufs: qcom: Align mask for core_clk_1us_cycles
Date:   Fri,  1 Sep 2023 17:12:37 +0530
Message-Id: <20230901114242.31219-2-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230901114242.31219-1-quic_nitirawa@quicinc.com>
References: <20230901114242.31219-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P5PS0SifPxXz9hF08BDiHQI1X225CNGx
X-Proofpoint-ORIG-GUID: P5PS0SifPxXz9hF08BDiHQI1X225CNGx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_09,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=979 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010109
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align core_clk_1us_cycles mask for Qualcomm UFS Controller V4.0.0
onwards as per Hardware Specification.

Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 28 ++++++++++++++++++----------
 drivers/ufs/host/ufs-qcom.h |  5 +++--
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index f88febb23123..fe36003faaa8 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1297,22 +1297,30 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
 }

 static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
-						       u32 clk_cycles)
+						       u32 cycles_in_1us)
 {
-	int err;
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	u32 core_clk_ctrl_reg;
+	int ret;

-	if (clk_cycles > DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK)
-		return -EINVAL;
-
-	err = ufshcd_dme_get(hba,
+	ret = ufshcd_dme_get(hba,
 			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
 			    &core_clk_ctrl_reg);
-	if (err)
-		return err;
+	if (ret)
+		return ret;

-	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
-	core_clk_ctrl_reg |= clk_cycles;
+	/* Bit mask is different for UFS host controller V4.0.0 onwards */
+	if (host->hw_ver.major >= 4) {
+		if (!FIELD_FIT(CLK_1US_CYCLES_MASK_V4, cycles_in_1us))
+			return -ERANGE;
+		core_clk_ctrl_reg &= ~CLK_1US_CYCLES_MASK_V4;
+		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK_V4, cycles_in_1us);
+	} else {
+		if (!FIELD_FIT(CLK_1US_CYCLES_MASK, cycles_in_1us))
+			return -ERANGE;
+		core_clk_ctrl_reg &= ~CLK_1US_CYCLES_MASK;
+		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK, cycles_in_1us);
+	}

 	/* Clear CORE_CLK_DIV_EN */
 	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index d6f8e74bd538..8a9d3dbec297 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -129,8 +129,9 @@ enum {
 #define PA_VS_CONFIG_REG1	0x9000
 #define DME_VS_CORE_CLK_CTRL	0xD002
 /* bit and mask definitions for DME_VS_CORE_CLK_CTRL attribute */
-#define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT		BIT(8)
-#define DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK	0xFF
+#define CLK_1US_CYCLES_MASK_V4				GENMASK(27, 16)
+#define CLK_1US_CYCLES_MASK				GENMASK(7, 0)
+#define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT	BIT(8)

 static inline void
 ufs_qcom_get_controller_revision(struct ufs_hba *hba,
--
2.17.1

