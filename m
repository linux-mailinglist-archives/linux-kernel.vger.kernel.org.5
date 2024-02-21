Return-Path: <linux-kernel+bounces-75644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E81185ECCE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B266B25F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82953133985;
	Wed, 21 Feb 2024 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DDfmZCck"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D118128808;
	Wed, 21 Feb 2024 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557569; cv=none; b=Bj41r0rXiJudXPqa8CgV8NyYTbEJXQNb05YfK2PMA1ic0ab5vJ8928W4JvWNoSU9MA0fp/HLFnQcUQjZIiinYgg4TCqqYvp/xceOFTBw3Xw3hAm6ZS+ZMbimfoMwrdV4xLcbArptdkkZnd8QXSFM5zNX7pZbVPooMm21/AgLsDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557569; c=relaxed/simple;
	bh=xeV1ToLPdTsfBTdAmMyqgxgVXBjOacL5GwLnom0Crtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ub/gwluW4KA/PHq/3N+AtinWLjWwrTPK0ScvDdjJGUHoC4VifoquwAh+3w9OWeelP7XUv/EGSr7BbW/JrczTPxIe56ACpMbbpOwc/oOScm5+ZJD9u582uTSrhILOIngRW+4bSqq69FPrQBcZjarQ6+bxPZbS0dbG0pwufMInF+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DDfmZCck; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LNJG0L017953;
	Wed, 21 Feb 2024 23:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=yfAT0/T92lmK4FtwYwglO51/H3PSfEs7Olu7AyGqwWY
	=; b=DDfmZCcksbYFT3YxdRFJpX6B8H3FBmNObzeVYtnlHGB5k62/TH7saE7Ym3F
	Jj0ZjxW+MaJupdnLO4vywxonNRyVEWJM3JI0jLa3dOGf8TKAhdn75EQWQh1OtUKn
	3f4/xtXNPEGKKdTEFb5AT2pB0Wl4hmXMP+Md0RsOnLFhX8u2ZC91BP0BYQzfqdJr
	hYRQy2PKJZzyCKYve8XDRgUMUDd8Qb+Bf5nbkmAbm6rfel41Lng5iNy1l/vkgeHO
	vsnTli7qzGaK9U5JfwF56rpJtjzs3EERa5snpOAPttBhc0UkXmSxa/IyH8//LGSD
	xWMEj2ML8BoFHHJAhccfQbQtK0g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdfm39nqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:19:15 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LNJEKP028446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:19:14 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:19:13 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Wed, 21 Feb 2024 15:19:09 -0800
Subject: [PATCH 1/9] drm/msm/dp: Add DP support to combo instance in SC7280
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240221-rb3gen2-dp-connector-v1-1-dc0964ef7d96@quicinc.com>
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
In-Reply-To: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
To: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708557553; l=2017;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=xeV1ToLPdTsfBTdAmMyqgxgVXBjOacL5GwLnom0Crtg=;
 b=B/NtNOd3/1fyvoIJ4xw1MisB8yYP1zGrdP9Q4mD3KfGjF1XMFwkluz5P1fyOFHUy/9BbZ8uam
 qijbX4ib8NODtsVIZ/NYwyXXo7vToa/tL+8+5YiCn+AGPCLJ7E9FUBz
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DMTaaOvqnB3G9dRlf70wpjuxKZSGCYSB
X-Proofpoint-ORIG-GUID: DMTaaOvqnB3G9dRlf70wpjuxKZSGCYSB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210184

When upstreamed the SC7280 DP controllers where described as one being
DP and one eDP, but they can infact both be DP or eDP.

Extend the list of DP controllers to cover both instances, and rely on
the newly introduced mechanism for selecting which mode they should
operate in.

Move qcom,sc7280-edp to a dedicated list, to ensure existing DeviceTree
will continue to select eDP.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 7b8c695d521a..1792ba9f7259 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -129,7 +129,12 @@ static const struct msm_dp_desc sc7180_dp_descs[] = {
 };
 
 static const struct msm_dp_desc sc7280_dp_descs[] = {
-	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_en = true },
+	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .wide_bus_en = true },
+	{}
+};
+
+static const struct msm_dp_desc sc7280_edp_descs[] = {
 	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
 	{}
 };
@@ -182,7 +187,7 @@ static const struct msm_dp_desc x1e80100_dp_descs[] = {
 static const struct of_device_id dp_dt_match[] = {
 	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_descs },
 	{ .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_descs },
-	{ .compatible = "qcom,sc7280-edp", .data = &sc7280_dp_descs },
+	{ .compatible = "qcom,sc7280-edp", .data = &sc7280_edp_descs },
 	{ .compatible = "qcom,sc8180x-dp", .data = &sc8180x_dp_descs },
 	{ .compatible = "qcom,sc8180x-edp", .data = &sc8180x_dp_descs },
 	{ .compatible = "qcom,sc8280xp-dp", .data = &sc8280xp_dp_descs },

-- 
2.25.1


