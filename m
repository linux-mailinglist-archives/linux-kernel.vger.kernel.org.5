Return-Path: <linux-kernel+bounces-47452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBB4844E23
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CAE1C25A97
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C46210D;
	Thu,  1 Feb 2024 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KRelzAet"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F621FC8;
	Thu,  1 Feb 2024 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748490; cv=none; b=ZRg/Hu7cR3Q1MPPp9o/5LMjemqFquSbD4zanQBRKn5w7XFNf7RSxWqk8RTGLKhXxZAZUWcTT37/NSVgxLidvM4a5hsqF6TyclXefqHFnQTZCIZT1v/to2dMeO9qOZZ93Zjwt3hY1fQxsF7J65nvHMIZRE9WvsIORHb1jsf9f2wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748490; c=relaxed/simple;
	bh=ZMYXqfFvDta/ItLAjZaVINVEnkjHndsS8Rkjv9I2BIs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z5GWF3TRRLXU9eA+oeyipfiuL1xkkc8Udr9Bg4phVdx42X5TpkwKGOYM9lBMCz4GB053Xs77dF3VdfTAFPZFy4ov5Idz1QVqAxKnUtrqYqLmb61XSMbHirlz4KShldEVxdRdanPiCVQ7HKadFY3rwl+KpY2GexhZ5jE+q6LQVzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KRelzAet; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VNgZ5t018185;
	Thu, 1 Feb 2024 00:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=f4wB/zP
	Z0RVJ8FW1yM3ScdvW2VMg6+4NuyBlqUf5leY=; b=KRelzAet8e5xcvvAJ08elKv
	fSrFf/e4QIaHi0dcaQvpIDUG3XYkfGDcjTVlm7fPTj9OKuIZ1bM7Q+Zo7bgKM/dm
	q1tWVtXPllGAGOQeymz8xySWJqX7FQweOuOtB/GE0p/ou6Rw5XzJzMccMKhCiFH9
	sgqzyKj1mTGdK59IvDOD6lThTr81QodM4rkL0TEw7KXl9oJHxPdMmJ8TnFsCJi3b
	UB284u18rLEdbFycro6JKtjbsL3sLHFagKM4PZ9DBrlfq9tMcywVncCblII44K1F
	IXCDgrD50s9LvtIqqVTYaIYittGitI+aLsi0qidPrMhxzpdCApCfP3vO2HR2gzQ=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyuatguvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 00:47:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4110lw7w008757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 00:47:58 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 31 Jan 2024 16:47:57 -0800
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh
	<quic_khsieh@quicinc.com>
CC: <dri-devel@lists.freedesktop.org>, <seanpaul@chromium.org>,
        <quic_jesszhan@quicinc.com>, <quic_parellan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/msm/dpu: fix the programming of INTF_CFG2_DATA_HCTL_EN
Date: Wed, 31 Jan 2024 16:47:36 -0800
Message-ID: <20240201004737.2478-1-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9urCH-BBPDWuw4QHBmTJ2vE-CbHkaqGz
X-Proofpoint-GUID: 9urCH-BBPDWuw4QHBmTJ2vE-CbHkaqGz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=949 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010004

Currently INTF_CFG2_DATA_HCTL_EN is coupled with the enablement
of widebus but this is incorrect because we should be enabling
this bit independent of widebus except for cases where compression
is enabled in one pixel per clock mode.

Fix this by making the condition checks more explicit and enabling
INTF_CFG2_DATA_HCTL_EN for all other cases when supported by DPU.

Fixes: 3309a7563971 ("drm/msm/dpu: revise timing engine programming to support widebus feature")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c       |  7 +++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h       |  7 +++++++
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c       | 15 +++++++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h       |  1 +
 5 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 83380bc92a00..467f874979d5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -230,6 +230,13 @@ bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc)
 	return dpu_enc->wide_bus_en;
 }
 
+bool dpu_encoder_is_dsc_enabled(const struct drm_encoder *drm_enc)
+{
+	const struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
+
+	return dpu_enc->dsc ? true : false;
+}
+
 int dpu_encoder_get_crc_values_cnt(const struct drm_encoder *drm_enc)
 {
 	struct dpu_encoder_virt *dpu_enc;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index 4c05fd5e9ed1..fe6b1d312a74 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -158,6 +158,13 @@ int dpu_encoder_get_vsync_count(struct drm_encoder *drm_enc);
 
 bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc);
 
+/**
+ * dpu_encoder_is_dsc_enabled - indicate whether dsc is enabled
+ *				for the encoder.
+ * @drm_enc:    Pointer to previously created drm encoder structure
+ */
+bool dpu_encoder_is_dsc_enabled(const struct drm_encoder *drm_enc);
+
 /**
  * dpu_encoder_get_crc_values_cnt - get number of physical encoders contained
  *	in virtual encoder that can collect CRC values
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index d0f56c5c4cce..f562beb6f797 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -102,6 +102,7 @@ static void drm_mode_to_intf_timing_params(
 	}
 
 	timing->wide_bus_en = dpu_encoder_is_widebus_enabled(phys_enc->parent);
+	timing->compression_en = dpu_encoder_is_dsc_enabled(phys_enc->parent);
 
 	/*
 	 * for DP, divide the horizonal parameters by 2 when
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 6bba531d6dc4..965692ef7892 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -163,13 +163,8 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
 	hsync_ctl = (hsync_period << 16) | p->hsync_pulse_width;
 	display_hctl = (hsync_end_x << 16) | hsync_start_x;
 
-	/*
-	 * DATA_HCTL_EN controls data timing which can be different from
-	 * video timing. It is recommended to enable it for all cases, except
-	 * if compression is enabled in 1 pixel per clock mode
-	 */
 	if (p->wide_bus_en)
-		intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN | INTF_CFG2_DATA_HCTL_EN;
+		intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN;
 
 	data_width = p->width;
 
@@ -229,6 +224,14 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
 	DPU_REG_WRITE(c, INTF_CONFIG, intf_cfg);
 	DPU_REG_WRITE(c, INTF_PANEL_FORMAT, panel_format);
 	if (ctx->cap->features & BIT(DPU_DATA_HCTL_EN)) {
+		/*
+		 * DATA_HCTL_EN controls data timing which can be different from
+		 * video timing. It is recommended to enable it for all cases, except
+		 * if compression is enabled in 1 pixel per clock mode
+		 */
+		if (!(p->compression_en && !p->wide_bus_en))
+			intf_cfg2 |= INTF_CFG2_DATA_HCTL_EN;
+
 		DPU_REG_WRITE(c, INTF_CONFIG2, intf_cfg2);
 		DPU_REG_WRITE(c, INTF_DISPLAY_DATA_HCTL, display_data_hctl);
 		DPU_REG_WRITE(c, INTF_ACTIVE_DATA_HCTL, active_data_hctl);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
index 0bd57a32144a..6f4c87244f94 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
@@ -33,6 +33,7 @@ struct dpu_hw_intf_timing_params {
 	u32 hsync_skew;
 
 	bool wide_bus_en;
+	bool compression_en;
 };
 
 struct dpu_hw_intf_prog_fetch {
-- 
2.40.1


