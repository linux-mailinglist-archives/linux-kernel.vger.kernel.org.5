Return-Path: <linux-kernel+bounces-40591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2696483E2E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EECFEB21DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBB224A1F;
	Fri, 26 Jan 2024 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vce4AKX7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA75249F4;
	Fri, 26 Jan 2024 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298477; cv=none; b=KqUVNhp92S5OL4s58UicdFogCp9Wc1DiJPfm3xDpqqOTWtHbajAQppWS4Yqmf2/ICitQWb6FD7MW5+sQCGGEX4uZAnQIjj036RrG6ilF2V0C2d1PdZ49ZJQRHCkan8/MLp/BiASfR2eC5QnC56HKkPsW9Mx71mI+R//eN0LEOCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298477; c=relaxed/simple;
	bh=Ji8V8/6QMqSvyXwiNVz2SRVGYMhG6xJrSjLOiHKq3hc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJ+f7YtT/hpUNNUFK5DoKKeUEk90K2kUpfrWF08/mgciOAqGdlrddEIyy89Qow+HGUx49gS6iijl6wkWrgXeOGQLbxdCsV7GY3ZTJXGdF592C0e4mO185EV4EQ7B0UOkMd7DSJdamzps2tq6puwlmLH6Lid317EW2d0BisnzKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vce4AKX7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QGP9sN013289;
	Fri, 26 Jan 2024 19:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Dwty2lX8ZQK/jKvohsYqyBDwT9yvmSCvSC15xrKSkq0=; b=Vc
	e4AKX7a+3qwG3cj4fw78NbzGkNt9pjiMoUVe55F/jzVhcxaQ5n52EviheXxNM08D
	M7cMYA7FlTcy2OIuSRLh91d2Tj2Fw2R5mHs+/kDInSRqxVHTSWLU6RZe4tKvl5Ql
	LOEVbvVcd0L/i3sY+3O3kYay0dhwsxhSODtnN2iYNYjerVg7m9d2qM+wP/D0luHi
	gIeSVbUyMlskQxIuTwj4mYWzrErKZ6cdtp4nbC+7dz8qrRxO7QNau4rOAxdB9fN3
	gOv+NENkJ+wkQ8jIE/CenDGlO15BhnDC+qcm9V8icte8tWFSvKNqEoLwj+smVZjF
	Lz4R1VEp0BI6j0cHluCg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvfc8gkab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 19:47:36 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QJlZRG010276
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 19:47:35 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 11:47:32 -0800
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
Subject: [PATCH 5/5] soc: qcom: llcc: Add regmap for Broadcast_AND region
Date: Fri, 26 Jan 2024 11:47:21 -0800
Message-ID: <12bfdd23772c49530b8b0993cc82bc89b3eb4ada.1706296015.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1706296015.git.quic_uchalich@quicinc.com>
References: <cover.1706296015.git.quic_uchalich@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3wlWglaAQShM26e0Aof2sS0qzvkWn8-z
X-Proofpoint-ORIG-GUID: 3wlWglaAQShM26e0Aof2sS0qzvkWn8-z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=894
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260146

To support CSR programming, a broadcast interface is used to program
all channels in a single command. Until SM8450 there was only one
broadcast region (Broadcast_OR) used to broadcast write and check
for status bit 0. From SM8450 onwards another broadcast region
(Broadcast_AND) has been added which checks for status bit 1.

Update llcc_drv_data structure with new regmap for Broadcast_AND
region and initialize regmap for Broadcast_AND region when HW block
version is greater than 4.1 for backwards compatibility.

Switch from broadcast_OR to broadcast_AND region for checking
status bit 1 as Broadcast_OR region checks only for bit 0.
While at it, also check return value after reading Broadcast_OR
region in llcc_update_act_ctrl().

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c       | 12 +++++++++++-
 include/linux/soc/qcom/llcc-qcom.h |  4 +++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 4ca88eaebf06..5a2dac2d4772 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -849,7 +849,7 @@ static int llcc_update_act_ctrl(u32 sid,
 		return ret;
 
 	if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
-		ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
+		ret = regmap_read_poll_timeout(drv_data->bcast_and_regmap, status_reg,
 				      slice_status, (slice_status & ACT_COMPLETE),
 				      0, LLCC_STATUS_READ_DELAY);
 		if (ret)
@@ -859,6 +859,8 @@ static int llcc_update_act_ctrl(u32 sid,
 	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
 				      slice_status, !(slice_status & status),
 				      0, LLCC_STATUS_READ_DELAY);
+	if (ret)
+		return ret;
 
 	if (drv_data->version >= LLCC_VERSION_4_1_0_0)
 		ret = regmap_write(drv_data->bcast_regmap, act_clear_reg,
@@ -1282,6 +1284,14 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 
 	drv_data->version = version;
 
+	if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
+		drv_data->bcast_and_regmap = qcom_llcc_init_mmio(pdev, i + 1, "llcc_broadcast_and_base");
+		if (IS_ERR(drv_data->bcast_and_regmap)) {
+			ret = PTR_ERR(drv_data->bcast_and_regmap);
+			goto err;
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


