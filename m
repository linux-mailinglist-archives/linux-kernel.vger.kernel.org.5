Return-Path: <linux-kernel+bounces-73622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B2685C53D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54AE1F21B35
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FCC14A4D0;
	Tue, 20 Feb 2024 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MF31SjYL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382DE6BFB8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458851; cv=none; b=VmC5BmegnBepeaPOrTR3yflRFwNWrSw4/EtoZrM58jUYjsw1WOSucJeBkwZCcfTEToGoTN0ZbB5/UQXp81AzWYsD8JS4qpQqrSvM+cXvh5veizCDhuUXmraQsIRcFMwfnA9X3sbrs+8PYmNVODsSMtLFQndzlHmROSHsBGGw66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458851; c=relaxed/simple;
	bh=ofcmBlB61pfncK+lqFFnuyb5wHG6ps7OOLOSVhveehs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYxaHdz6zqLHRfq9nBfcCGpNORChVslctWLZ1Z+BAAEInfTHMP2kLMr9Rp9zfj3Cenx+jOtk4qTF45Ljt7G3Dd8ktlwokeNsgUe4WzcqS4fkRZ86JjU+Tu2Kdnki9qh6Kcaw0V09o905vQHgp4zLQCz0lnY2oAeq17n3yLQLqK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MF31SjYL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KJCd5p000605;
	Tue, 20 Feb 2024 19:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=kMBGN4lkN2oMFK9YeeSBL21U79zoUeATlaYcPPlP7IA=; b=MF
	31SjYLFCPOavY+iHqNC7LEiE0bFiu3Es+3fp9U9+ch0n7hU8W9ckeHWW9H3/hhns
	Qf8V3e4VZSPLJYh+cHzFTHcQN4W/wpKP2yykTlFUD5FCuL0lQFsc1LEoJ2JmQPkT
	WZXm/yXljyetwm2CQCX2q3SkNDe923tKBJlHJQjGHzW2YmdTegr/O/gT2imann5K
	eWRCKNsLPCmDD1Uev3MHtzzasa8d0KesKj1ifaOcY6ZowHHif+xXY6YDhQ6RuFtT
	vdRPhVeB1GL7E60IRV6MDRLcub4ycC4c2ZSUooKzZZPoGDvIFyE7lAGaTqkzzRiN
	s6bTT1QOs1Qw5FcQKTKg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd21s02t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 19:54:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KJs0wJ007926
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 19:54:00 GMT
Received: from abhinavk-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 11:53:59 -0800
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin
	<tvrtko.ursulin@linux.intel.com>
CC: Abhinav Kumar <quic_abhinavk@quicinc.com>, <robdclark@gmail.com>,
        <freedreno@lists.freedesktop.org>, <dmitry.baryshkov@linaro.org>,
        <intel-gfx@lists.freedesktop.org>, <ville.syrjala@linux.intel.com>,
        <quic_jesszhan@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <intel-xe@lists.freedesktop.org>
Subject: [PATCH v3 2/2] drm/dp: drop the size parameter from drm_dp_vsc_sdp_pack()
Date: Tue, 20 Feb 2024 11:53:47 -0800
Message-ID: <20240220195348.1270854-2-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220195348.1270854-1-quic_abhinavk@quicinc.com>
References: <20240220195348.1270854-1-quic_abhinavk@quicinc.com>
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
X-Proofpoint-ORIG-GUID: -kJVHc1oYzxBTxEza_WBzv1l8isSsmoE
X-Proofpoint-GUID: -kJVHc1oYzxBTxEza_WBzv1l8isSsmoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402200142

Currently the size parameter of drm_dp_vsc_sdp_pack() is always
the size of struct dp_sdp. Hence lets drop this parameter and
use sizeof() directly.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 8 ++------
 drivers/gpu/drm/i915/display/intel_dp.c | 3 +--
 include/drm/display/drm_dp_helper.h     | 3 +--
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 6c91f400ecb1..10ee82e34de7 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -2918,19 +2918,15 @@ EXPORT_SYMBOL(drm_dp_vsc_sdp_log);
  * @vsc: vsc sdp initialized according to its purpose as defined in
  *       table 2-118 - table 2-120 in DP 1.4a specification
  * @sdp: valid handle to the generic dp_sdp which will be packed
- * @size: valid size of the passed sdp handle
  *
  * Returns length of sdp on success and error code on failure
  */
 ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
-			    struct dp_sdp *sdp, size_t size)
+			    struct dp_sdp *sdp)
 {
 	size_t length = sizeof(struct dp_sdp);
 
-	if (size < length)
-		return -ENOSPC;
-
-	memset(sdp, 0, size);
+	memset(sdp, 0, sizeof(struct dp_sdp));
 
 	/*
 	 * Prepare VSC Header for SU as per DP 1.4a spec, Table 2-119
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index a9458df475e2..e13121dc3a03 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4181,8 +4181,7 @@ static void intel_write_dp_sdp(struct intel_encoder *encoder,
 
 	switch (type) {
 	case DP_SDP_VSC:
-		len = drm_dp_vsc_sdp_pack(&crtc_state->infoframes.vsc, &sdp,
-					  sizeof(sdp));
+		len = drm_dp_vsc_sdp_pack(&crtc_state->infoframes.vsc, &sdp);
 		break;
 	case HDMI_PACKET_TYPE_GAMUT_METADATA:
 		len = intel_dp_hdr_metadata_infoframe_sdp_pack(dev_priv,
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 8474504d4c88..1f41994796d3 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -812,7 +812,6 @@ int drm_dp_bw_overhead(int lane_count, int hactive,
 		       int bpp_x16, unsigned long flags);
 int drm_dp_bw_channel_coding_efficiency(bool is_uhbr);
 
-ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
-			    struct dp_sdp *sdp, size_t size);
+ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc, struct dp_sdp *sdp);
 
 #endif /* _DRM_DP_HELPER_H_ */
-- 
2.34.1


