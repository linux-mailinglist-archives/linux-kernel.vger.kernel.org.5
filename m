Return-Path: <linux-kernel+bounces-62112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59470851BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B381F22F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B224597D;
	Mon, 12 Feb 2024 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oV93OjvV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D0845BE3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759267; cv=none; b=q/HY124As23YaKb1U9fsZojD5Gg5yjgOaM31WjMaomW4y+e8lQfizIgup42VZmGf/yeeQHmpB0/ePy2QMdfdZ/+IbJuBXfxvUfKmjzTkJdo67wiYUk8eLNDfVJjZ4UcYmxM7CE1Ha2p0lyiO3Le78dbMakUHTkxjnTHHgRlhyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759267; c=relaxed/simple;
	bh=UErLGNLN+bkHULQl7INxGvmus6rXF07RAy36HFmAm9U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YU7dABCS9/ObxxSxmoNz9vFrH55CHjdCguUzjIqXfp59WxZA4zh2DS+ewgGfuAn0MfZI/teWi7Be3UqpY6Ft6m5osfDSrXcil5B5aN9c2ct06V7wKh1Oju9a4xTjkKsBxYCPMDNEB5QEIjbz8eyF8hAY64CErIeIbV4cVJxx1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oV93OjvV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CExrak009925;
	Mon, 12 Feb 2024 17:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=M48vkdZ
	0s2Pyp9OxRZ4mN+0EZPXt65Mq0CLdaBP2Bag=; b=oV93OjvVOEBir3PASs91FQ8
	vr1jwuS5B5FziIhrj11H+JET01w8AIIe4PMEii8EC+Zel3WhV6vvnPQYxn/P6KeG
	OBGCY8dx/4dCku6ICS73732PK3M6oRg/RcMaBmzW3X7zRl0lXFTTZfymxoMrbLTW
	d8NJD2p6TFFpqHOZkouGldrVWDslpJYyirsjpBckMV8EKEyE6cs9HRFrYnu2H/i8
	OVnUz4CZmQ/DhJ856/nfWHu6fj7GwQ3YS0cH1xGKDEmoBgoUiCQcs62veVjPaakP
	u5KfmZqEoTiDh7U1NpKteXEusdZe+f/8yoGxfMHm4+2YakU+1oOhz6EGHiUQZ9w=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7nk90bp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:34:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CHY5Zo021330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:34:05 GMT
Received: from abhinavk-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 09:34:04 -0800
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: Paloma Arellano <quic_parellan@quicinc.com>, <robdclark@gmail.com>,
        <freedreno@lists.freedesktop.org>, <dmitry.baryshkov@linaro.org>,
        <intel-gfx@lists.freedesktop.org>, <jani.nikula@linux.intel.com>,
        <ville.syrjala@linux.intel.com>, <quic_jesszhan@quicinc.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] drm/dp: add an API to indicate if sink supports VSC SDP
Date: Mon, 12 Feb 2024 09:33:55 -0800
Message-ID: <20240212173355.1857757-1-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: P8GmQe4ttF1H-u5Kesrhqz8l7SQF7vzY
X-Proofpoint-ORIG-GUID: P8GmQe4ttF1H-u5Kesrhqz8l7SQF7vzY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402120133

From: Paloma Arellano <quic_parellan@quicinc.com>

YUV420 format is supported only in the VSC SDP packet and not through
MSA. Hence add an API which indicates the sink support which can be used
by the rest of the DP programming.

changes in v4:
	- bail out early if dpcd rev check fails

changes in v3:
	- fix the commit title prefix to drm/dp
	- get rid of redundant !!
	- break out this change from series [1] to get acks from drm core
	  maintainers

Changes in v2:
	- Move VSC SDP support check API from dp_panel.c to
	  drm_dp_helper.c

[1]: https://patchwork.freedesktop.org/series/129180/

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Paloma Arellano <quic_parellan@quicinc.com>
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 23 +++++++++++++++++++++++
 include/drm/display/drm_dp_helper.h     |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index b1ca3a1100da..b10fb2be837e 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -2916,6 +2916,29 @@ void drm_dp_vsc_sdp_log(const char *level, struct device *dev,
 }
 EXPORT_SYMBOL(drm_dp_vsc_sdp_log);
 
+/**
+ * drm_dp_vsc_sdp_supported() - check if vsc sdp is supported
+ * @aux: DisplayPort AUX channel
+ * @dpcd: DisplayPort configuration data
+ *
+ * Returns true if vsc sdp is supported, else returns false
+ */
+bool drm_dp_vsc_sdp_supported(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+{
+	u8 rx_feature;
+
+	if (dpcd[DP_DPCD_REV] < DP_DPCD_REV_13)
+		return false;
+
+	if (drm_dp_dpcd_readb(aux, DP_DPRX_FEATURE_ENUMERATION_LIST, &rx_feature) != 1) {
+		drm_dbg_dp(aux->drm_dev, "failed to read DP_DPRX_FEATURE_ENUMERATION_LIST\n");
+		return false;
+	}
+
+	return (rx_feature & DP_VSC_SDP_EXT_FOR_COLORIMETRY_SUPPORTED);
+}
+EXPORT_SYMBOL(drm_dp_vsc_sdp_supported);
+
 /**
  * drm_dp_get_pcon_max_frl_bw() - maximum frl supported by PCON
  * @dpcd: DisplayPort configuration data
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 863b2e7add29..948381b2b0b1 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -100,6 +100,7 @@ struct drm_dp_vsc_sdp {
 
 void drm_dp_vsc_sdp_log(const char *level, struct device *dev,
 			const struct drm_dp_vsc_sdp *vsc);
+bool drm_dp_vsc_sdp_supported(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
 
 int drm_dp_psr_setup_time(const u8 psr_cap[EDP_PSR_RECEIVER_CAP_SIZE]);
 
-- 
2.34.1


