Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19517B8529
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243395AbjJDQ1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243367AbjJDQ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:27:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1038BEA;
        Wed,  4 Oct 2023 09:27:24 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394F9E8r028969;
        Wed, 4 Oct 2023 16:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=E6IDeWpgjsGjXDLovNIfYyh6GfIotA/key1Ug1nkjrk=;
 b=etQLOoO2NMJsdKpzBt/1Y15NlqDaJwbaUULjTmfTC2MKQceH6YCrgaw8ImlBjyDpQVQ5
 wabmuJ3esKVfXp8To6C1yKUVMLCaPH9IU4vdlooXkeNSzk0eOKmIF/RVSSxMm8oM3Uix
 uGH0Du0IeBkVDfbQxtz/kiBqcUSd5Kj00kIS5qZ4GckAtZdOQUNZTv8dk5k5yYGdbHBM
 GIoG5GUEnsZHrkdCvweqoUxMlW1yotdd2WSl0rfF9FZw1z2uanrk7MxbwoZGZaBEOeZU
 L5LyTqD4ovumZ0qLGwOxzGLuVo8I1wR0Qoo45++2E773n+/4eJX1zyja3QCEsnaro3dY gQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th1cy1ehn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 16:27:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 394GRFD8031318
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 16:27:15 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 4 Oct 2023 09:27:14 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/7] drm/msm/dp: rename is_connected with link_ready
Date:   Wed, 4 Oct 2023 09:26:56 -0700
Message-ID: <1696436821-14261-3-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1696436821-14261-1-git-send-email-quic_khsieh@quicinc.com>
References: <1696436821-14261-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Qmbmz2Lcbr4MmirJVOlwGoVcon8Fu4QZ
X-Proofpoint-GUID: Qmbmz2Lcbr4MmirJVOlwGoVcon8Fu4QZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The is_connected flag is set to true after DP mainlink successfully
finishes link training to enter into ST_MAINLINK_READY state rather
than being set after the DP dongle is connected. Rename the
is_connected flag with link_ready flag to match the state of DP
driver's state machine.

Changes in v5:
-- reworded commit text according to review comments from change #4

Changes in v4:
-- reworded commit text

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 19 +++++++++----------
 drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
 drivers/gpu/drm/msm/dp/dp_drm.c     | 14 +++++++-------
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 940da48..9e51876 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -367,12 +367,11 @@ static void dp_display_send_hpd_event(struct msm_dp *dp_display)
 	drm_helper_hpd_irq_event(connector->dev);
 }
 
-
 static int dp_display_send_hpd_notification(struct dp_display_private *dp,
 					    bool hpd)
 {
-	if ((hpd && dp->dp_display.is_connected) ||
-			(!hpd && !dp->dp_display.is_connected)) {
+	if ((hpd && dp->dp_display.link_ready) ||
+			(!hpd && !dp->dp_display.link_ready)) {
 		drm_dbg_dp(dp->drm_dev, "HPD already %s\n",
 				(hpd ? "on" : "off"));
 		return 0;
@@ -382,7 +381,7 @@ static int dp_display_send_hpd_notification(struct dp_display_private *dp,
 	if (!hpd)
 		dp->panel->video_test = false;
 
-	dp->dp_display.is_connected = hpd;
+	dp->dp_display.link_ready = hpd;
 
 	drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
 			dp->dp_display.connector_type, hpd);
@@ -922,7 +921,7 @@ int dp_display_set_plugged_cb(struct msm_dp *dp_display,
 
 	dp_display->plugged_cb = fn;
 	dp_display->codec_dev = codec_dev;
-	plugged = dp_display->is_connected;
+	plugged = dp_display->link_ready;
 	dp_display_handle_plugged_change(dp_display, plugged);
 
 	return 0;
@@ -1355,16 +1354,16 @@ static int dp_pm_resume(struct device *dev)
 	 * also only signal audio when disconnected
 	 */
 	if (dp->link->sink_count) {
-		dp->dp_display.is_connected = true;
+		dp->dp_display.link_ready = true;
 	} else {
-		dp->dp_display.is_connected = false;
+		dp->dp_display.link_ready = false;
 		dp_display_handle_plugged_change(dp_display, false);
 	}
 
 	drm_dbg_dp(dp->drm_dev,
 		"After, type=%d sink=%d conn=%d core_init=%d phy_init=%d power=%d\n",
 		dp->dp_display.connector_type, dp->link->sink_count,
-		dp->dp_display.is_connected, dp->core_initialized,
+		dp->dp_display.link_ready, dp->core_initialized,
 		dp->phy_initialized, dp_display->power_on);
 
 	mutex_unlock(&dp->event_mutex);
@@ -1757,8 +1756,8 @@ void dp_bridge_hpd_notify(struct drm_bridge *bridge,
 		return;
 	}
 
-	if (!dp_display->is_connected && status == connector_status_connected)
+	if (!dp_display->link_ready && status == connector_status_connected)
 		dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
-	else if (dp_display->is_connected && status == connector_status_disconnected)
+	else if (dp_display->link_ready && status == connector_status_disconnected)
 		dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index b3c08de..d65693e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -16,7 +16,7 @@ struct msm_dp {
 	struct drm_bridge *bridge;
 	struct drm_connector *connector;
 	struct drm_bridge *next_bridge;
-	bool is_connected;
+	bool link_ready;
 	bool audio_enabled;
 	bool power_on;
 	unsigned int connector_type;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 785d766..ee945ca 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -24,10 +24,10 @@ static enum drm_connector_status dp_bridge_detect(struct drm_bridge *bridge)
 
 	dp = to_dp_bridge(bridge)->dp_display;
 
-	drm_dbg_dp(dp->drm_dev, "is_connected = %s\n",
-		(dp->is_connected) ? "true" : "false");
+	drm_dbg_dp(dp->drm_dev, "link_ready = %s\n",
+		(dp->link_ready) ? "true" : "false");
 
-	return (dp->is_connected) ? connector_status_connected :
+	return (dp->link_ready) ? connector_status_connected :
 					connector_status_disconnected;
 }
 
@@ -40,8 +40,8 @@ static int dp_bridge_atomic_check(struct drm_bridge *bridge,
 
 	dp = to_dp_bridge(bridge)->dp_display;
 
-	drm_dbg_dp(dp->drm_dev, "is_connected = %s\n",
-		(dp->is_connected) ? "true" : "false");
+	drm_dbg_dp(dp->drm_dev, "link_ready = %s\n",
+		(dp->link_ready) ? "true" : "false");
 
 	/*
 	 * There is no protection in the DRM framework to check if the display
@@ -55,7 +55,7 @@ static int dp_bridge_atomic_check(struct drm_bridge *bridge,
 	 * After that this piece of code can be removed.
 	 */
 	if (bridge->ops & DRM_BRIDGE_OP_HPD)
-		return (dp->is_connected) ? 0 : -ENOTCONN;
+		return (dp->link_ready) ? 0 : -ENOTCONN;
 
 	return 0;
 }
@@ -78,7 +78,7 @@ static int dp_bridge_get_modes(struct drm_bridge *bridge, struct drm_connector *
 	dp = to_dp_bridge(bridge)->dp_display;
 
 	/* pluggable case assumes EDID is read when HPD */
-	if (dp->is_connected) {
+	if (dp->link_ready) {
 		rc = dp_display_get_modes(dp);
 		if (rc <= 0) {
 			DRM_ERROR("failed to get DP sink modes, rc=%d\n", rc);
-- 
2.7.4

