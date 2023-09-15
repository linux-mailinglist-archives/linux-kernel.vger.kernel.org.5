Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6307A2898
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbjIOUth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbjIOUtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:49:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E802703;
        Fri, 15 Sep 2023 13:48:42 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FKg25X031610;
        Fri, 15 Sep 2023 20:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=RiCjPrtpVUW00c7AtKHMRiOzXtqM7t36NMj0yfFk7pc=;
 b=XWQ9N2DX+ziE/YWBD11pEc8dmbE+NS5UU+PcapW4VcjWbkQyEz6JDgqTsUGcm3tsDQzy
 FEOr6evAP5/I/hUnjgz6wxJSLwtOxSOM7pr8robZeVulyu3HpItyFewZ9/QgvxsBCh7K
 UKvjurJb7Nbljv4aD/YzuTKnLIXD80RETYLyztHkQmTNXwcRQwLU6e9GZGAzDDk7F235
 pCzxWAy1VMj2EcNlDgPOE5n4JD+4onTAoo6UwrPE5fwo6+PyRb2rnoPcosP5mHwsAB6Z
 6qP2mV47Ue88q63hwtY2wDijj4VBltdl6PaOInIW0KEIJ0fb2v3dQ2ziwFiI6pXPTwmq nA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4fwn243r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 20:48:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FKmYr2025954
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 20:48:34 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 15 Sep 2023 13:48:33 -0700
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
Subject: [PATCH v2 5/7] drm/msm/dp: delete EV_HPD_INIT_SETUP
Date:   Fri, 15 Sep 2023 13:48:06 -0700
Message-ID: <1694810888-24461-6-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694810888-24461-1-git-send-email-quic_khsieh@quicinc.com>
References: <1694810888-24461-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tjDXB7UTV4jErvWvsD_iUvJMAL7o00Gq
X-Proofpoint-ORIG-GUID: tjDXB7UTV4jErvWvsD_iUvJMAL7o00Gq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_17,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EV_HPD_INIT_SETUP flag is used to trigger the initialization of external
DP host controller. Since external DP host controller initialization had
been incorporated into pm_runtime_resume(), this flag become obsolete.
Lets get rid of it.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |  4 ----
 drivers/gpu/drm/msm/dp/dp_display.c     | 16 ----------------
 drivers/gpu/drm/msm/msm_drv.h           |  5 -----
 3 files changed, 25 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index aa8499d..71d0670 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -870,7 +870,6 @@ static int dpu_irq_postinstall(struct msm_kms *kms)
 {
 	struct msm_drm_private *priv;
 	struct dpu_kms *dpu_kms = to_dpu_kms(kms);
-	int i;
 
 	if (!dpu_kms || !dpu_kms->dev)
 		return -EINVAL;
@@ -879,9 +878,6 @@ static int dpu_irq_postinstall(struct msm_kms *kms)
 	if (!priv)
 		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(priv->dp); i++)
-		msm_dp_irq_postinstall(priv->dp[i]);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e7af7f7..b6992202 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -55,7 +55,6 @@ enum {
 enum {
 	EV_NO_EVENT,
 	/* hpd events */
-	EV_HPD_INIT_SETUP,
 	EV_HPD_PLUG_INT,
 	EV_IRQ_HPD_INT,
 	EV_HPD_UNPLUG_INT,
@@ -1092,8 +1091,6 @@ static int hpd_event_thread(void *data)
 		spin_unlock_irqrestore(&dp_priv->event_lock, flag);
 
 		switch (todo->event_id) {
-		case EV_HPD_INIT_SETUP:
-			break;
 		case EV_HPD_PLUG_INT:
 			dp_hpd_plug_handle(dp_priv, todo->data);
 			break;
@@ -1469,19 +1466,6 @@ void __exit msm_dp_unregister(void)
 	platform_driver_unregister(&dp_display_driver);
 }
 
-void msm_dp_irq_postinstall(struct msm_dp *dp_display)
-{
-	struct dp_display_private *dp;
-
-	if (!dp_display)
-		return;
-
-	dp = container_of(dp_display, struct dp_display_private, dp_display);
-
-	if (!dp_display->is_edp)
-		dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 0);
-}
-
 bool msm_dp_wide_bus_available(const struct msm_dp *dp_display)
 {
 	struct dp_display_private *dp;
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index e13a8cb..ff8be59 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -381,7 +381,6 @@ int __init msm_dp_register(void);
 void __exit msm_dp_unregister(void);
 int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
 			 struct drm_encoder *encoder);
-void msm_dp_irq_postinstall(struct msm_dp *dp_display);
 void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display);
 
 void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor);
@@ -402,10 +401,6 @@ static inline int msm_dp_modeset_init(struct msm_dp *dp_display,
 	return -EINVAL;
 }
 
-static inline void msm_dp_irq_postinstall(struct msm_dp *dp_display)
-{
-}
-
 static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
 {
 }
-- 
2.7.4

