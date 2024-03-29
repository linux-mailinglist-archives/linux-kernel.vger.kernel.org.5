Return-Path: <linux-kernel+bounces-125351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F0F892478
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EEA285130
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1140213A3E5;
	Fri, 29 Mar 2024 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IFjh+8YT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98942139D04;
	Fri, 29 Mar 2024 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741615; cv=none; b=eNGBWYZhfcfnRXAdMZQok4v1ZdEdZJZ4XDTc+nUL/JTTZFPNiXl2HTooORig6+lsQ7CJc2qe3LC/SLpYfUhblKe9hviYJDTHXrGr6a/oFKDjykxdBcwTjAzEFopGfG+EdwYIXfqHLjXJqiogM5vEJeeBBySgJ+thyW53vqtHli0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741615; c=relaxed/simple;
	bh=sEQf6CnSvy+gsfHmMbdCzoWhb1Yw2wM8Mgp7wb8eskQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tKMkbQtKfunBCMltOiI87AoI9NIWxGUpHj6GkoP6SDDTSTHZTXM6yIJY7TS7EBURHpPdv0qTKgxGWXzgO3CFsPkjN/7ZUPYs/H2Hmydg4h2uR52gzjI+TNdpllYSBK7pFDy30JFZoS8OYdfiKxFcUYYQm1Ls0HBGpK5LLxKOMGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IFjh+8YT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THeogV013524;
	Fri, 29 Mar 2024 19:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=LAxtLydJPleoJCOd3e+tShPjSv1jB48d2EKqaJMIysE=; b=IF
	jh+8YT+vn8MCESavNSYJOT/HdL5aQaYHUXzv653HD6WAz9oPapt3Pf6DlBnYU50r
	UxTl5r9aIpe9LA9ShVJx8FvfFpJxqSORguoAaZtSVVYpyiXNyWiUwBl1pIRGn8Xf
	icANIKlJ1rOl6dqDrK/hCbQkNJWH8UDvt5brjrWl7QSNeXU/IBPRo3kawBdF93eL
	mYojcZJ/0oNe8DrdjJ9iC67UGMnKWUAoGhd4NsNhQXIZrb1PkhcZNOgt1CpiLL0t
	lDbmZZr65NDsAlAjcBI1hb6BW1idl7NUbdsp2z5DoASe2ewtaFX6hz4Wg4F+DQ2A
	Q08fuaY7hYPWS4JXG8Lw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5vn991ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 19:46:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TJkaWe013541
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 19:46:36 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 12:46:35 -0700
From: Kuogee Hsieh <quic_khsieh@quicinc.com>
To: <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <abel.vesa@linaro.org>, <andersson@kernel.org>
CC: Kuogee Hsieh <quic_khsieh@quicinc.com>, <quic_abhinavk@quicinc.com>,
        <quic_jesszhan@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <marijn.suijten@somainline.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] drm/msm/dp: assign correct DP controller ID to x1e80100 interface table
Date: Fri, 29 Mar 2024 12:46:26 -0700
Message-ID: <1711741586-9037-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZzA3Ud7yVWBvIk4yOqwb7wHuwySHghy2
X-Proofpoint-GUID: ZzA3Ud7yVWBvIk4yOqwb7wHuwySHghy2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290177

At current x1e80100 interface table, interface #3 is wrongly
connected to DP controller #0 and interface #4 wrongly connected
to DP controller #2. Fix this problem by connect Interface #3 to
DP controller #0 and interface #4 connect to DP controller #1.
Also add interface #6, #7 and #8 connections to DP controller to
complete x1e80100 interface table.

Changs in V3:
-- add v2 changes log

Changs in V2:
-- add x1e80100 to subject
-- add Fixes

Fixes: e3b1f369db5a ("drm/msm/dpu: Add X1E80100 support")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h   | 34 ++++++++++++++++++++--
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
index 9a9f709..a3e60ac 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
@@ -324,6 +324,7 @@ static const struct dpu_wb_cfg x1e80100_wb[] = {
 	},
 };
 
+/* TODO: INTF 3, 8 and 7 are used for MST, marked as INTF_NONE for now */
 static const struct dpu_intf_cfg x1e80100_intf[] = {
 	{
 		.name = "intf_0", .id = INTF_0,
@@ -358,8 +359,8 @@ static const struct dpu_intf_cfg x1e80100_intf[] = {
 		.name = "intf_3", .id = INTF_3,
 		.base = 0x37000, .len = 0x280,
 		.features = INTF_SC7280_MASK,
-		.type = INTF_DP,
-		.controller_id = MSM_DP_CONTROLLER_1,
+		.type = INTF_NONE,
+		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
 		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 31),
@@ -368,7 +369,7 @@ static const struct dpu_intf_cfg x1e80100_intf[] = {
 		.base = 0x38000, .len = 0x280,
 		.features = INTF_SC7280_MASK,
 		.type = INTF_DP,
-		.controller_id = MSM_DP_CONTROLLER_2,
+		.controller_id = MSM_DP_CONTROLLER_1,
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 20),
 		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 21),
@@ -381,6 +382,33 @@ static const struct dpu_intf_cfg x1e80100_intf[] = {
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 22),
 		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 23),
+	}, {
+		.name = "intf_6", .id = INTF_6,
+		.base = 0x3A000, .len = 0x280,
+		.features = INTF_SC7280_MASK,
+		.type = INTF_DP,
+		.controller_id = MSM_DP_CONTROLLER_2,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
+	}, {
+		.name = "intf_7", .id = INTF_7,
+		.base = 0x3b000, .len = 0x280,
+		.features = INTF_SC7280_MASK,
+		.type = INTF_NONE,
+		.controller_id = MSM_DP_CONTROLLER_2,	/* pair with intf_6 for DP MST */
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 18),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 19),
+	}, {
+		.name = "intf_8", .id = INTF_8,
+		.base = 0x3c000, .len = 0x280,
+		.features = INTF_SC7280_MASK,
+		.type = INTF_NONE,
+		.controller_id = MSM_DP_CONTROLLER_1,	/* pair with intf_4 for DP MST */
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13),
 	},
 };
 
-- 
2.7.4


