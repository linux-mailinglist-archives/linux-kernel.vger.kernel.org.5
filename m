Return-Path: <linux-kernel+bounces-67561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E68856D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B795A1C22827
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D89C139574;
	Thu, 15 Feb 2024 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IPDFJBIj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A10139563
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024580; cv=none; b=dcb/di1sD/7IJQhBEOgcJaxLJQrJs3smQgG7PQ7G8E2m7S6UhhhgrAlt6seBfmM/HUJd7VE8qPxliPAHuuX5dJsrD4jWcgxApgp60vfi/Qiu2j9hO8CVS02G6sM4IWFHg+Jcgy+tBzvI8ofuTp0saGC3GuzSW2D/turlLWFllp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024580; c=relaxed/simple;
	bh=A5vfHKGPj12dTNIK/i4MDdUnEZY45MV3bb0G7KPm7SM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gZ0m+7PfFi0F287yX+Hlgih6N1lyQQoEU9yKhAvSjJnqkSSkFt9+ICJDIH7EKwzs28FFPz+thR2UI0It/bO4Hg6dTGi68Ujj9TTNvehotytywKmBgNiWr/nVfDDbM7epKFC7gEwhZlGzH28VzwJhX3+4o0EBuUBbDHSP0X50OVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IPDFJBIj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FIhcOV028350;
	Thu, 15 Feb 2024 19:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=5JKqmrk
	fJABfYZUDeP6CxLqjc+esD9/niU7UB8pF9iE=; b=IPDFJBIjt6eQ3pMXlX7H4MJ
	Jy8ekGzdDGT/b3K9EY2X+c42Jj8vaCoCZunrr764X61cxU4Dvs7Y8gBgnyccLaF9
	SPYsw8VMllI26tQfEPNhHCsIGCbZ3vak6PZ2vFZwM0mn3JHcOeHCIANeBDm1qtUn
	86BfRWY7WK1xl5ANFJhhHEnpBdeWfHDybRM5N0+02638dnPepqaQopD8uWumOpYL
	fSvNIMKiRWgChbdUfWnDmd6FoS1yGF7SBpRJc/GziIWQeBp+arbqGPw8F+9aqAhc
	fybf/O9Y7y+4uLF6Mk6sqVYTvxMNZNveZSN/xfHX3EFVq3ytL9ynqqmnmlVuFoQ=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9fkf9s4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 19:16:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41FJG7NR021010
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 19:16:07 GMT
Received: from abhinavk-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 11:16:06 -0800
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
Subject: [PATCH v5] drm/dp: add an API to indicate if sink supports VSC SDP
Date: Thu, 15 Feb 2024 11:15:56 -0800
Message-ID: <20240215191556.3227259-1-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 06Dg6ymyuWe8JYZebRgPmoLvB9lxHZX7
X-Proofpoint-GUID: 06Dg6ymyuWe8JYZebRgPmoLvB9lxHZX7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_18,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150154

From: Paloma Arellano <quic_parellan@quicinc.com>

YUV420 format is supported only in the VSC SDP packet and not through
MSA. Hence add an API which indicates the sink support which can be used
by the rest of the DP programming.

changes in v5:
	- rebased on top of drm-tip

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
 include/drm/display/drm_dp_helper.h     |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 8d6ce46471ae..61b11cb45245 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -2913,6 +2913,29 @@ void drm_dp_vsc_sdp_log(struct drm_printer *p, const struct drm_dp_vsc_sdp *vsc)
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
index d02014a87f12..36351f3cdba9 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -100,6 +100,8 @@ struct drm_dp_vsc_sdp {
 
 void drm_dp_vsc_sdp_log(struct drm_printer *p, const struct drm_dp_vsc_sdp *vsc);
 
+bool drm_dp_vsc_sdp_supported(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
+
 int drm_dp_psr_setup_time(const u8 psr_cap[EDP_PSR_RECEIVER_CAP_SIZE]);
 
 static inline int
-- 
2.34.1


