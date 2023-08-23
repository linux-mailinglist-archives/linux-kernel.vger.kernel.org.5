Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033CB785C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbjHWPoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjHWPo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:44:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE16E74;
        Wed, 23 Aug 2023 08:44:26 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NCfFkJ016733;
        Wed, 23 Aug 2023 15:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=PS3vlouwj5egAo3Gab+lQecEijSEJeLMGrvijAFhtS4=;
 b=WPLKZ1QavQyr9bWxallXRoV9jBzFBAJPdEBVRJytKsNgDBXJG/NcgKpBANN/DzjVWYks
 1fB4LqLTS67TREvV2GF6a3C99OOi0wI4AoH6R8KQwO3N6TYRq7tzNfyBpJYUHvIESDNj
 oB4O0iu+SgiB2BYoTzGmFQz/ZArIX1BWM8PZELhCoeIvm6bWD9vz1Pm+RLY3lUnrhXu7
 jUDtud7rENmZl8RGgZ2Yy/cv0sEDEzo7a/DImnLy8lrYzPpHqvQPn5d9b7N4M6I0PCbV
 dlPlhErMxBFEfwNYx/v2z9B44b/KwegTWt4IUvN3FJvigNl18aJ+nWmaWFHqsLTA3mjI jA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn25kad06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 15:44:20 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37NFiHdL029208;
        Wed, 23 Aug 2023 15:44:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sjptm3qds-1;
        Wed, 23 Aug 2023 15:44:17 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37NFiHOT029201;
        Wed, 23 Aug 2023 15:44:17 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37NFiGXs029193;
        Wed, 23 Aug 2023 15:44:17 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 407945000AD; Wed, 23 Aug 2023 21:14:16 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V5 2/6] scsi: ufs: qcom: Configure PA_VS_CORE_CLK_40NS_CYCLES for Unipro core clk
Date:   Wed, 23 Aug 2023 21:14:09 +0530
Message-Id: <20230823154413.23788-3-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: v3omIW6haYxcnA7CQdVLpkXdnvRhHutr
X-Proofpoint-GUID: v3omIW6haYxcnA7CQdVLpkXdnvRhHutr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230142
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Qualcomm UFS controller V4.0 and above PA_VS_CORE_CLK_40NS_CYCLES
attribute needs to be programmed with frequency of unipro core clk.
Hence Configure PA_VS_CORE_CLK_40NS_CYCLES attribute for Unipro core clk.

Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 45 ++++++++++++++++++++++++++++---------
 drivers/ufs/host/ufs-qcom.h |  2 ++
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 1108b0cd43b3..abc0e7f7d1b0 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -93,8 +93,9 @@ static const struct __ufs_qcom_bw_table {
 static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];

 static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
-static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
-						       u32 clk_cycles);
+static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
+					u32 clk_cycles,
+					u32 clk_40ns_cycles);

 static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
 {
@@ -690,8 +691,7 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
 			 * set unipro core clock cycles to 150 & clear clock
 			 * divider
 			 */
-			err = ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba,
-									  150);
+			err = ufs_qcom_set_core_clk_ctrl(hba, 150, 6);

 		/*
 		 * Some UFS devices (and may be host) have issues if LCC is
@@ -1296,12 +1296,13 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
 	phy_exit(host->generic_phy);
 }

-static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
-						       u32 clk_1us_cycles)
+static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
+					u32 clk_1us_cycles,
+					u32 clk_40ns_cycles)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	u32 mask = DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
-	u32 core_clk_ctrl_reg;
+	u32 core_clk_ctrl_reg, reg;
 	u32 offset = 0;
 	int err;

@@ -1326,9 +1327,33 @@ static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
 	/* Clear CORE_CLK_DIV_EN */
 	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;

-	return ufshcd_dme_set(hba,
+	err = ufshcd_dme_set(hba,
 			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
 			    core_clk_ctrl_reg);
+	/*
+	 * UFS host controller V4.0.0 onwards needs to program
+	 * PA_VS_CORE_CLK_40NS_CYCLES attribute per programmed
+	 * frequency of unipro core clk of UFS host controller.
+	 */
+	if (!err && (host->hw_ver.major >= 4)) {
+		if (clk_40ns_cycles > PA_VS_CORE_CLK_40NS_CYCLES_MASK)
+			return -EINVAL;
+
+		err = ufshcd_dme_get(hba,
+				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
+				     &reg);
+		if (err)
+			return err;
+
+		reg &= ~PA_VS_CORE_CLK_40NS_CYCLES_MASK;
+		reg |= clk_40ns_cycles;
+
+		err = ufshcd_dme_set(hba,
+				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
+				     reg);
+	}
+
+	return err;
 }

 static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
@@ -1345,7 +1370,7 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
 		return 0;

 	/* set unipro core clock cycles to 150 and clear clock divider */
-	return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 150);
+	return ufs_qcom_set_core_clk_ctrl(hba, 150, 6);
 }

 static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
@@ -1381,7 +1406,7 @@ static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
 		return 0;

 	/* set unipro core clock cycles to 75 and clear clock divider */
-	return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 75);
+	return ufs_qcom_set_core_clk_ctrl(hba, 75, 3);
 }

 static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index a829296e11bb..325f08aca260 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -133,6 +133,8 @@ enum {
 #define MAX_CORE_CLK_1US_CYCLES_OFFSET_V4	0x10
 #define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT		BIT(8)
 #define DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK	0xFF
+#define PA_VS_CORE_CLK_40NS_CYCLES	0x9007
+#define PA_VS_CORE_CLK_40NS_CYCLES_MASK	0x3F

 static inline void
 ufs_qcom_get_controller_revision(struct ufs_hba *hba,
--
2.17.1

