Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF08791A7A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353224AbjIDPV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242793AbjIDPVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:21:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8837CC4;
        Mon,  4 Sep 2023 08:21:16 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384EHCm1025760;
        Mon, 4 Sep 2023 15:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=ujAkzKfoJAD7OI+z7gmNkocWg2ZhUPj9x0EJEb3YVWA=;
 b=kkafFKjqgeT20v15yH+Cr0rIhDSO19dfQIPw2RnwxXQDUlevvuDOh3q06MZuYhUVMuVP
 Gx/4AGrC/1ba65jzoXdYEHjepHvVAbepNhHnWtNvbGvxuf4SNOU9lEVWuYnnSqRqYFbR
 Sl+sdwL/KamCeXNKEBOfDcPBpcRoR8/HneEHdbRj0OYu84jirQpDo5AdMrunLeHA5uXP
 JnoGvjDypPLHTg/d8UTSVQ2882yB1b3El7qQBge54b92S+bOFQAcI6d0A3hQLezyB8JT
 SQ7YZL/ozMu7/r9MiLJM4UhUOuehOz/0ZlonxGw8GkUAmr1gHv9LeE88gtLmPhLh2D2a 6w== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sux7tv0km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 15:21:08 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 384FL5jj023846;
        Mon, 4 Sep 2023 15:21:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4k8yqb-1;
        Mon, 04 Sep 2023 15:21:05 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 384FL43E023840;
        Mon, 4 Sep 2023 15:21:04 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 384FL4TY023839;
        Mon, 04 Sep 2023 15:21:04 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id B3FFC504920; Mon,  4 Sep 2023 20:51:03 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V7 1/5] scsi: ufs: qcom: Update MAX_CORE_CLK_1US_CYCLES for UFS V4 and above
Date:   Mon,  4 Sep 2023 20:50:56 +0530
Message-Id: <20230904152100.30404-2-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230904152100.30404-1-quic_nitirawa@quicinc.com>
References: <20230904152100.30404-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ErKIOTAH3md0qp4wRPU8z0sIlfqbPDdM
X-Proofpoint-GUID: ErKIOTAH3md0qp4wRPU8z0sIlfqbPDdM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_08,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040137
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS Controller V4 and above, the register layout for DME_VS_CORE_CLK_CTRL
register has changed. MAX_CORE_CLK_1US_CYCLES offset has changed from
0 to 0x10 and length of attrbute is changed from 8bit to 12bit.

Add support to configure MAX_CORE_CLK_1US_CYCLES for UFS V4 and above
as per new register layout.

Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 18 +++++++++++++-----
 drivers/ufs/host/ufs-qcom.h |  5 +++--
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index d1149b1c3ed5..d846e68a5734 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1299,20 +1299,28 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
 static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
 						       u32 clk_cycles)
 {
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	int err;
 	u32 core_clk_ctrl_reg;

-	if (clk_cycles > DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK)
-		return -EINVAL;
-
 	err = ufshcd_dme_get(hba,
 			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
 			    &core_clk_ctrl_reg);
 	if (err)
 		return err;

-	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
-	core_clk_ctrl_reg |= clk_cycles;
+	/* Bit mask is different for UFS host controller V4.0.0 onwards */
+	if (host->hw_ver.major >= 4) {
+		if (!FIELD_FIT(CLK_1US_CYCLES_MASK_V4, clk_cycles))
+			return -ERANGE;
+		core_clk_ctrl_reg &= ~CLK_1US_CYCLES_MASK_V4;
+		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK_V4, clk_cycles);
+	} else {
+		if (!FIELD_FIT(CLK_1US_CYCLES_MASK, clk_cycles))
+			return -ERANGE;
+		core_clk_ctrl_reg &= ~CLK_1US_CYCLES_MASK;
+		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK, clk_cycles);
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

