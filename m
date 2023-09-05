Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0479792B8D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245375AbjIEQzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351673AbjIEFYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:24:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD9BE8;
        Mon,  4 Sep 2023 22:24:40 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3854cQJU021028;
        Tue, 5 Sep 2023 05:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=R2k4zuTcTVeTnuP3LgOzkRt4e7vTr+UwtAfQXt421wU=;
 b=PK2w96GBhfdqzACHf14H/flo86TU5yYc9AXtqpDFK8vG4Xn5C9LqlMj+wpWiqZaqzRuT
 vUZMslnG01tv8jN51M2fgHKmCtlnwNNEaViGyuvjLO0GVwN1LqW+OR5HC+tAUc4sfpUl
 iv/Rd8pP3hKXqNKtoQBct9QYPwZNakl/w6l/kq2A4iISXQGxE5atX/SjAU12PSkj9xsM
 0xcc1N565Uu57JE+TsU7nyasgwG4H+E8AjX9BAUzJ4S80oKRwQtzWFPfXMUk199GuI52
 /Ib3F1+kW80a/UFpwvPEM4xPdTU6kL53Og94IyKhnZVH6eAAIapw/U+flbb6FstCibjL LA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swfae1j0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 05:24:32 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3855O6I4029413;
        Tue, 5 Sep 2023 05:24:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3sux4kjpvd-1;
        Tue, 05 Sep 2023 05:24:06 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3855O5mK029347;
        Tue, 5 Sep 2023 05:24:06 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3855O5uJ029342;
        Tue, 05 Sep 2023 05:24:05 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id EA040504921; Tue,  5 Sep 2023 10:54:04 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V8 3/5] scsi: ufs: qcom: Add support to Configure PA_VS_CORE_CLK_40NS_CYCLES
Date:   Tue,  5 Sep 2023 10:53:58 +0530
Message-Id: <20230905052400.13935-4-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230905052400.13935-1-quic_nitirawa@quicinc.com>
References: <20230905052400.13935-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HzRZZGlrESHxgbYQ20M-I5k4ETKKwAg5
X-Proofpoint-ORIG-GUID: HzRZZGlrESHxgbYQ20M-I5k4ETKKwAg5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_04,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050048
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PA_VS_CORE_CLK_40NS_CYCLES attribute represents the required number of
Qunipro core clock for 40 nanoseconds. For UFS host controller V4 and
above PA_VS_CORE_CLK_40NS_CYCLES needs to be programmed as per frequency
of unipro core clk of UFS host controller.

Add Support to configure PA_VS_CORE_CLK_40NS_CYCLES for Controller V4 and
above to align with the hardware specification and to avoid functionality
issues like h8 enter/exit failure, command timeout.

Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 78 ++++++++++++++++++++++++++++++++++++-
 drivers/ufs/host/ufs-qcom.h | 12 ++++++
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index b2be9ff272a4..a4855f0b93b0 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1292,6 +1292,77 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
 	phy_exit(host->generic_phy);
 }

+/**
+ * ufs_qcom_set_clk_40ns_cycles - Configure 40ns clk cycles
+ *
+ * @hba: host controller instance
+ * @cycles_in_1us: No of cycles in 1us to be configured
+ *
+ * Returns error if dme get/set configuration for 40ns fails
+ * and returns zero on success.
+ */
+static int ufs_qcom_set_clk_40ns_cycles(struct ufs_hba *hba,
+					u32 cycles_in_1us)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	u32 cycles_in_40ns;
+	u32 reg;
+	int err;
+
+	/*
+	 * UFS host controller V4.0.0 onwards needs to program
+	 * PA_VS_CORE_CLK_40NS_CYCLES attribute per programmed
+	 * frequency of unipro core clk of UFS host controller.
+	 */
+	if (host->hw_ver.major < 4)
+		return 0;
+
+	/*
+	 * Generic formulae for cycles_in_40ns = (freq_unipro/25) is not
+	 * applicable for all frequencies. For ex: ceil(37.5 MHz/25) will
+	 * be 2 and ceil(403 MHZ/25) will be 17 whereas Hardware
+	 * specification expect to be 16. Hence use exact hardware spec
+	 * mandated value for cycles_in_40ns instead of calculating using
+	 * generic formulae.
+	 */
+	switch (cycles_in_1us) {
+	case UNIPRO_CORE_CLK_FREQ_403_MHZ:
+		cycles_in_40ns = 16;
+		break;
+	case UNIPRO_CORE_CLK_FREQ_300_MHZ:
+		cycles_in_40ns = 12;
+		break;
+	case UNIPRO_CORE_CLK_FREQ_201_5_MHZ:
+		cycles_in_40ns = 8;
+		break;
+	case UNIPRO_CORE_CLK_FREQ_150_MHZ:
+		cycles_in_40ns = 6;
+		break;
+	case UNIPRO_CORE_CLK_FREQ_100_MHZ:
+		cycles_in_40ns = 4;
+		break;
+	case  UNIPRO_CORE_CLK_FREQ_75_MHZ:
+		cycles_in_40ns = 3;
+		break;
+	case UNIPRO_CORE_CLK_FREQ_37_5_MHZ:
+		cycles_in_40ns = 2;
+		break;
+	default:
+		dev_err(hba->dev, "UNIPRO clk freq %u MHz not supported\n",
+				cycles_in_1us);
+		return -EINVAL;
+	}
+
+	err = ufshcd_dme_get(hba, UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES), &reg);
+	if (err)
+		return err;
+
+	reg &= ~PA_VS_CORE_CLK_40NS_CYCLES_MASK;
+	reg |= cycles_in_40ns;
+
+	return ufshcd_dme_set(hba, UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES), reg);
+}
+
 static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
@@ -1334,9 +1405,14 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up)
 	/* Clear CORE_CLK_DIV_EN */
 	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;

-	return ufshcd_dme_set(hba,
+	err = ufshcd_dme_set(hba,
 			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
 			    core_clk_ctrl_reg);
+	if (err)
+		return err;
+
+	/* Configure unipro core clk 40ns attribute */
+	return ufs_qcom_set_clk_40ns_cycles(hba, cycles_in_1us);
 }

 static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 3c6ef1259af3..264d429e72fe 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -132,6 +132,18 @@ enum {
 #define CLK_1US_CYCLES_MASK_V4				GENMASK(27, 16)
 #define CLK_1US_CYCLES_MASK				GENMASK(7, 0)
 #define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT	BIT(8)
+#define PA_VS_CORE_CLK_40NS_CYCLES			0x9007
+#define PA_VS_CORE_CLK_40NS_CYCLES_MASK			GENMASK(6, 0)
+
+
+/* QCOM UFS host controller core clk frequencies */
+#define UNIPRO_CORE_CLK_FREQ_37_5_MHZ          38
+#define UNIPRO_CORE_CLK_FREQ_75_MHZ            75
+#define UNIPRO_CORE_CLK_FREQ_100_MHZ           100
+#define UNIPRO_CORE_CLK_FREQ_150_MHZ           150
+#define UNIPRO_CORE_CLK_FREQ_300_MHZ           300
+#define UNIPRO_CORE_CLK_FREQ_201_5_MHZ         202
+#define UNIPRO_CORE_CLK_FREQ_403_MHZ           403

 static inline void
 ufs_qcom_get_controller_revision(struct ufs_hba *hba,
--
2.17.1

