Return-Path: <linux-kernel+bounces-29449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185F5830E69
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C436B283DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C6F25568;
	Wed, 17 Jan 2024 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eiqWlZTS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072862555B;
	Wed, 17 Jan 2024 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526045; cv=none; b=AhcZTk2EzTEtajS45n5HQX4v4VuSti2OQno8ZP4gEntDEi5W12RD20iow3dJLbSZqkdSZKsFXvWNQmGoftnDSIzb+SP30bCgYJQL/+AdNit5bRBfvB3x00lbHs7arU62AGrRLuhaioQP7r7nSicYAZaoeVc8wJt6fQtMJ4LEBNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526045; c=relaxed/simple;
	bh=lq7fwNY+8BklN0z0pETnNfRZRTZ+/oGKQ0bwnLkh5PE=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=CCBIJEoBkTi6C6YZIpDDzvwOQ0EUPy9zWMJpQ74wmxs6Uca+l6kgLtaLAs7ZVtedl46f8ATm5QrLQmNPiEsCDre/yhGgrmq5C50kcMzetJsIRGyiPV7Cm0cZghCsVlYYrWH5vZPHAq8z5qlZYJsPjTlTXa0+hGoVGGZUfFjpqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eiqWlZTS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HLA63A011740;
	Wed, 17 Jan 2024 21:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=bQDgy9xDLgmnYLFuYDo7Y/1XGAsi2c5U1sJTHjU5QmM=; b=ei
	qWlZTSbn+wlI+Mn4d+EvM2Qy2vRwM350b+H67blizbMmX7Ffl0ElVZrnBIx/ZamN
	qxRmLm899oQiGjepwzLD0pLlumia0xsukYvgRi19rgKpLj3ZyRi1MNKh4aZps+RN
	Zd1tEZDpA5hUnw8+TtSlEr+pKFaj1bslAitbFQk3nZXfDCuCrKb0L9fyilrtnYOh
	h9FKteRp4he18id60rHXanrsSQm0vmX5LPzY27X0wW6AHNvv+xMBwILE1vBZ82M4
	q7lz0/BX/10F31RSThk1Ehts7CrZsWXWdOGif9HnDCV+A9oZ9aA4svgdQYF7kYL7
	DMXRcFsV88dEvBTTCSKA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp6p3t703-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 21:13:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HLDckP023566
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 21:13:38 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 13:13:37 -0800
From: Kuogee Hsieh <quic_khsieh@quicinc.com>
To: <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC: Kuogee Hsieh <quic_khsieh@quicinc.com>, <quic_abhinavk@quicinc.com>,
        <quic_jesszhan@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <marijn.suijten@somainline.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] drm/msm/dp: return correct Colorimetry for DP_TEST_DYNAMIC_RANGE_CEA case
Date: Wed, 17 Jan 2024 13:13:30 -0800
Message-ID: <1705526010-597-1-git-send-email-quic_khsieh@quicinc.com>
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
X-Proofpoint-GUID: Fzn28BTqKuncmYkGgN8Wug8X72hDAS6b
X-Proofpoint-ORIG-GUID: Fzn28BTqKuncmYkGgN8Wug8X72hDAS6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170150

MSA MISC0 bit 1 to 7 contains Colorimetry Indicator Field.
dp_link_get_colorimetry_config() returns wrong colorimetry value
in the DP_TEST_DYNAMIC_RANGE_CEA case in the current implementation.
Hence fix this problem by having dp_link_get_colorimetry_config()
return defined CEA RGB colorimetry value in the case of
DP_TEST_DYNAMIC_RANGE_CEA.

Changes in V2:
-- drop retrieving colorimetry from colorspace
-- drop dr = link->dp_link.test_video.test_dyn_range assignment

Changes in V3:
-- move defined MISCr0a Colorimetry vale to dp_reg.h
-- rewording commit title
-- rewording commit text to more precise describe this patch

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_link.c | 12 +++++++-----
 drivers/gpu/drm/msm/dp/dp_reg.h  |  3 +++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index 98427d4..5284e48 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -7,6 +7,7 @@
 
 #include <drm/drm_print.h>
 
+#include "dp_reg.h"
 #include "dp_link.h"
 #include "dp_panel.h"
 
@@ -1082,7 +1083,7 @@ int dp_link_process_request(struct dp_link *dp_link)
 
 int dp_link_get_colorimetry_config(struct dp_link *dp_link)
 {
-	u32 cc;
+	u32 cc = DP_MISC0_COLORIMERY_CFG_LEGACY_RGB;
 	struct dp_link_private *link;
 
 	if (!dp_link) {
@@ -1096,10 +1097,11 @@ int dp_link_get_colorimetry_config(struct dp_link *dp_link)
 	 * Unless a video pattern CTS test is ongoing, use RGB_VESA
 	 * Only RGB_VESA and RGB_CEA supported for now
 	 */
-	if (dp_link_is_video_pattern_requested(link))
-		cc = link->dp_link.test_video.test_dyn_range;
-	else
-		cc = DP_TEST_DYNAMIC_RANGE_VESA;
+	if (dp_link_is_video_pattern_requested(link)) {
+		if (link->dp_link.test_video.test_dyn_range &
+					DP_TEST_DYNAMIC_RANGE_CEA)
+			cc = DP_MISC0_COLORIMERY_CFG_CEA_RGB;
+	}
 
 	return cc;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index ea85a69..78785ed 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -143,6 +143,9 @@
 #define DP_MISC0_COLORIMETRY_CFG_SHIFT		(0x00000001)
 #define DP_MISC0_TEST_BITS_DEPTH_SHIFT		(0x00000005)
 
+#define DP_MISC0_COLORIMERY_CFG_LEGACY_RGB	(0)
+#define DP_MISC0_COLORIMERY_CFG_CEA_RGB		(0x04)
+
 #define REG_DP_VALID_BOUNDARY			(0x00000030)
 #define REG_DP_VALID_BOUNDARY_2			(0x00000034)
 
-- 
2.7.4


