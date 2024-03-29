Return-Path: <linux-kernel+bounces-124102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2AA891241
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9FB1F2247F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ACD3A1A1;
	Fri, 29 Mar 2024 04:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gps1M8sH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAF71DDD6;
	Fri, 29 Mar 2024 04:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711684960; cv=none; b=udScVDy7RQ76wesSGGXn7YLcKJMX/aPsQmbXdK7Tx43+2MHRD+5qbI/4pVxTTJSUFxftOW6Jln/DvAjBl8JoGSW714Or87IA5UpqGraoHID4Q73gACGSyVfsCONbGTYQeL68uQFU7PnC9XFL8eyEz4V3VvKMHxBQOmBI0/Oihpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711684960; c=relaxed/simple;
	bh=wbNqEmNlTzUXmm+RxBhi8ZJm5Lkoter+ZIJFqBxiTaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=VoFsUqVw+xQNFnbRJdTV/lcqZfJRSo/AxW818Rxrx2dnOoiGG1OHok6qEzPJZtOQCxzphUkbZ6w/hlzvosBnXJTU8Xp/TEMeak0AN071sWDnJY1QV796TZArGlfLnLMb1fPUTdT4znu/ur91PqMfaQ41zc466YVmopJD3h4vz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gps1M8sH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T2O2CB008907;
	Fri, 29 Mar 2024 04:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=8y4
	h5xG32UjvngQoyYotUs53xOpH4Tr/lq4bw57G7Qg=; b=Gps1M8sHWOyIkxuDUDC
	OzDCcGWn66DB1FSulZ/ktbRJtBFFN3ZqwIX9KdhTSuBzZc2MqVuYgT0110TiYSbm
	G1vicWTAFh3TrPt1wUeArfh/PJQcmEqmfU/pHGc/n9Zzkwa2IyM7VqitN1dPmvy/
	FWyBKm/3uuXrX2lY57gEYNJJbmErXXzemptR7O8N5Z2PRE970cWns9isESDlMIlS
	oD8Mna7ZBBE2/GPzeIQdBAk4H0z/VALc5A+DFPVnzbPw4RS8exupAwfCyqC1uJkD
	8E9h02I2+m6/m/d9aPte5jL5FTeW/q/F6n3xsX2PyUbkZrVvOhf9VPhkn0OT/zmd
	m9w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5dkyh35r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 04:02:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T42H1q018649
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 04:02:17 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 21:02:17 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Thu, 28 Mar 2024 21:02:14 -0700
Subject: [PATCH] drm/msm/dp: Remove now unused connector_type from desc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240328-dp-connector-type-cleanup-v1-1-9bf84c5a6082@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEU9BmYC/x3MQQqDMBBG4avIrDsQE1tLr1JcxPjbDsgkJFoq4
 t0buvwW7x1UkAWFHs1BGR8pErWivTQU3l5fYJmqyRrbGWfvPCUOURVhjZnXPYHDAq9bYj/frqa
 F67vRUe1Txizf//s5nOcPkMY+omsAAAA=
To: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Abel Vesa
	<abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711684937; l=5625;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=wbNqEmNlTzUXmm+RxBhi8ZJm5Lkoter+ZIJFqBxiTaY=;
 b=rNUe4tpNyrtNcmMz9b6AgKTPdqalb6Svm9zM/2oRh6GAZD1TWS7w9iSsVz+XJ81sc+rVeJW2E
 jj+iio+5grTC55EA2OlbWKaYb2m3+PE0ip3erQu898AW/+mGMgy/b2I
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9BpHwmKtWjYRae01u1kHMexOzfZFhmde
X-Proofpoint-GUID: 9BpHwmKtWjYRae01u1kHMexOzfZFhmde
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_02,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290031

Now that the connector_type is dynamically determined, the
connector_type of the struct msm_dp_desc is unused. Clean it up.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
This cleans up after, and hence depends on,
https://lore.kernel.org/all/20240324-x1e80100-display-refactor-connector-v4-1-e0ebaea66a78@linaro.org/
---
 drivers/gpu/drm/msm/dp/dp_display.c | 41 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 521cba76d2a0..a18fb8b32c16 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -119,55 +119,54 @@ struct dp_display_private {
 struct msm_dp_desc {
 	phys_addr_t io_start;
 	unsigned int id;
-	unsigned int connector_type;
 	bool wide_bus_supported;
 };
 
 static const struct msm_dp_desc sc7180_dp_descs[] = {
-	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0 },
 	{}
 };
 
 static const struct msm_dp_desc sc7280_dp_descs[] = {
-	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
-	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_supported = true },
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
 	{}
 };
 
 static const struct msm_dp_desc sc8180x_dp_descs[] = {
-	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
-	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
-	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_eDP },
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0 },
+	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1 },
+	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2 },
 	{}
 };
 
 static const struct msm_dp_desc sc8280xp_dp_descs[] = {
-	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
-	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
-	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
-	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
-	{ .io_start = 0x22090000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
-	{ .io_start = 0x22098000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
-	{ .io_start = 0x2209a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
-	{ .io_start = 0x220a0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
+	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
+	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
+	{ .io_start = 0x22090000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{ .io_start = 0x22098000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
+	{ .io_start = 0x2209a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
+	{ .io_start = 0x220a0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
 	{}
 };
 
 static const struct msm_dp_desc sc8280xp_edp_descs[] = {
-	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_supported = true },
-	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_supported = true },
-	{ .io_start = 0x2209a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_supported = true },
-	{ .io_start = 0x220a0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_supported = true },
+	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
+	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
+	{ .io_start = 0x2209a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
+	{ .io_start = 0x220a0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
 	{}
 };
 
 static const struct msm_dp_desc sm8350_dp_descs[] = {
-	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0 },
 	{}
 };
 
 static const struct msm_dp_desc sm8650_dp_descs[] = {
-	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
+	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0 },
 	{}
 };
 

---
base-commit: 8780048e8c13990129e67c097ef580c3ae456650
change-id: 20240328-dp-connector-type-cleanup-af6501e374b3

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


