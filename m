Return-Path: <linux-kernel+bounces-54408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3114784AED6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7FE28AE5D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BE5129A77;
	Tue,  6 Feb 2024 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OAjeVwYd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF591129A71;
	Tue,  6 Feb 2024 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203778; cv=none; b=k2py5HCvSDcm01xKuKjl9V7MDBR/zZ1INU0NF5v3Zrrgwhuwwb+IYg52KMwR/y+Ymhry5zj2YW3FMIhvzbLLSjipkkR5sJ9ni+AVFZZZy/5qEIyciR6ltUUxLB0nvaJ+sXs546hgwC7WqcOkpaL9C5T2eb721tezcS1YXc6TPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203778; c=relaxed/simple;
	bh=G73UOIZHUoBlQlZPuWmrNuNj2g0YHaUM9YuJ9fYywrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHzfjwHUbQpLTSrfPq8ON9lJqEpoou7x3E7XldjeKrSoJJM3roz2PxQmrAwWtWWDFpXeA+oJA5zgvlqXpATTe7XhhW9NubSOyLSbZTOYe6k/+OQe4EcyWX8KuyYby3dWMWOhY06rnT87dysgaHy6dUXhJlQwnEKgJQujqga6c14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OAjeVwYd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4165JHSj014648;
	Tue, 6 Feb 2024 07:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=OyCGSgHlaRgP/FXM0vLKmicI6YEQn3T3JC8A8kIYHks=; b=OA
	jeVwYdm9Q7JE6BWo2Jng1Xy5DuFsdL8sWi5uJ8RFK43gtMKF5BFKdu9u5Kcu5J+t
	Z+zeRjS248RxESSyOy5PQE+yLk3JaKg9xSyxnlKrD43jVRs+p8XlsRDUh4EYSjqg
	ZeR4EEEJGqKwsBCvyZ8U6HJDluPGoXbCheKHFtykyy66eONtAG81AEsczAh2XL/9
	NnUaoOnhbEVtz9NChx0QwEFb6vH8AGYLDp7BmtCSxgF4noZv2veqGJPBzoROM66d
	JYTuxWyFWHRwo77T5iPSarU5xgni/Ag3irnL99z9tfWyAhLJ6XQmg2JsxJAnUoA5
	76nQxFljyh5o3RlpgsRg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w31wnsvje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 07:16:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4167GCvZ013029
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 07:16:12 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 23:16:07 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
Subject: [PATCH v2 5/5] soc: qcom: llcc: Add regmap for Broadcast_AND region
Date: Mon, 5 Feb 2024 23:15:56 -0800
Message-ID: <169277f53affed98ef41e5a7cbf2401fe62716bd.1707202761.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1707202761.git.quic_uchalich@quicinc.com>
References: <cover.1707202761.git.quic_uchalich@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CbHdw5ne1g_R6mPFZgulWanPqWDvBiiq
X-Proofpoint-GUID: CbHdw5ne1g_R6mPFZgulWanPqWDvBiiq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_01,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=922 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060049

Define new regmap structure for Broadcast_AND region and initialize
regmap for Broadcast_AND region when HW block version
is greater than 4.1 for backwards compatibility.

Switch from broadcast_OR to broadcast_AND region for checking
status bit 1 as Broadcast_OR region checks only for bit 0.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c       | 22 +++++++++++++++++++---
 include/linux/soc/qcom/llcc-qcom.h |  4 +++-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 4ca88eaebf06..fbd2542cd4c5 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -849,9 +849,14 @@ static int llcc_update_act_ctrl(u32 sid,
 		return ret;
 
 	if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
-		ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
-				      slice_status, (slice_status & ACT_COMPLETE),
-				      0, LLCC_STATUS_READ_DELAY);
+		if (!drv_data->bcast_and_regmap)
+			ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
+					slice_status, (slice_status & ACT_COMPLETE),
+					0, LLCC_STATUS_READ_DELAY);
+		else
+			ret = regmap_read_poll_timeout(drv_data->bcast_and_regmap, status_reg,
+					slice_status, (slice_status & ACT_COMPLETE),
+					0, LLCC_STATUS_READ_DELAY);
 		if (ret)
 			return ret;
 	}
@@ -1282,6 +1287,17 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 
 	drv_data->version = version;
 
+	if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
+		drv_data->bcast_and_regmap = qcom_llcc_init_mmio(pdev, i + 1, "llcc_broadcast_and_base");
+		if (IS_ERR(drv_data->bcast_and_regmap)) {
+			ret = PTR_ERR(drv_data->bcast_and_regmap);
+			if (ret == -EINVAL)
+				drv_data->bcast_and_regmap = NULL;
+			else
+				goto err;
+		}
+	}
+
 	llcc_cfg = cfg->sct_data;
 	sz = cfg->size;
 
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index 1a886666bbb6..9e9f528b1370 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -115,7 +115,8 @@ struct llcc_edac_reg_offset {
 /**
  * struct llcc_drv_data - Data associated with the llcc driver
  * @regmaps: regmaps associated with the llcc device
- * @bcast_regmap: regmap associated with llcc broadcast offset
+ * @bcast_regmap: regmap associated with llcc broadcast OR offset
+ * @bcast_and_regmap: regmap associated with llcc broadcast AND offset
  * @cfg: pointer to the data structure for slice configuration
  * @edac_reg_offset: Offset of the LLCC EDAC registers
  * @lock: mutex associated with each slice
@@ -129,6 +130,7 @@ struct llcc_edac_reg_offset {
 struct llcc_drv_data {
 	struct regmap **regmaps;
 	struct regmap *bcast_regmap;
+	struct regmap *bcast_and_regmap;
 	const struct llcc_slice_config *cfg;
 	const struct llcc_edac_reg_offset *edac_reg_offset;
 	struct mutex lock;
-- 
2.25.1


