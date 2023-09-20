Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0650F7A8D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjITUOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjITUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:14:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7B5AB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:14:28 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KIEkJu007325;
        Wed, 20 Sep 2023 20:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=zZxXZJcu+7jXEdG3EFHrpNBrQsAQooeCP1LQOLZ2Bn8=;
 b=TSZ3pmbwR1v/s1rbAkTttx5/DlgE2d8YUDo2uDRebvgHgeiO7VPJRlpUepT5/5NN8vm+
 9CuSyhSE2kuVEasCrjTjoKkBcdi0zWiktlajCcjepXGLFgnIq485aOk/j023P8UxdVRa
 eLJp4TipiWnZtW4/SwGGhmJ1RlDsLHM0979SbYjHgUm044BwcQNLJgPhGlLyvw4Pcy0l
 XPY/7rXvd+Ij6/6oC7SgzvuqBjq8aPKsc/4dSz+pIYBl/ve+YBopU8Nnz8Ep8rCnPu2R
 QJcMfJNs1eg/J3MOheK1sNqCMwFKmd1MUdq9iqxxAeTxIKUEGf9vZvo4pRYEltx3BwTk WQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7amnc39y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 20:14:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38KKEBmg008113
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 20:14:11 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 20 Sep 2023 13:14:10 -0700
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <quic_jesszhan@quicinc.com>,
        <quic_parellan@quicinc.com>, <laurent.pinchart@ideasonboard.com>,
        <andersson@kernel.org>, <jani.nikula@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: improve the documentation of connector hpd ops
Date:   Wed, 20 Sep 2023 13:13:58 -0700
Message-ID: <20230920201358.27597-1-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0uNC1Bf6DvnlTR5LUYEFIAAstZHZIdEl
X-Proofpoint-ORIG-GUID: 0uNC1Bf6DvnlTR5LUYEFIAAstZHZIdEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_10,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=825 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200169
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While making the changes in [1], it was noted that the documentation
of the enable_hpd() and disable_hpd() does not make it clear that
these ops should not try to do hpd state maintenance and should only
attempt to enable/disable hpd related hardware for the connector.

The state management of these calls to make sure these calls are
balanced is handled by the DRM core and we should keep it that way
to minimize the overhead in the drivers which implement these ops.

[1]: https://patchwork.freedesktop.org/patch/558387/

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 include/drm/drm_modeset_helper_vtables.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index e3c3ac615909..a33cf7488737 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1154,6 +1154,11 @@ struct drm_connector_helper_funcs {
 	 * This operation is optional.
 	 *
 	 * This callback is used by the drm_kms_helper_poll_enable() helpers.
+	 *
+	 * This operation does not need to perform any hpd state tracking as
+	 * the DRM core handles that maintenance and ensures the calls to enable
+	 * and disable hpd are balanced.
+	 *
 	 */
 	void (*enable_hpd)(struct drm_connector *connector);
 
@@ -1165,6 +1170,11 @@ struct drm_connector_helper_funcs {
 	 * This operation is optional.
 	 *
 	 * This callback is used by the drm_kms_helper_poll_disable() helpers.
+	 *
+	 * This operation does not need to perform any hpd state tracking as
+	 * the DRM core handles that maintenance and ensures the calls to enable
+	 * and disable hpd are balanced.
+	 *
 	 */
 	void (*disable_hpd)(struct drm_connector *connector);
 };
-- 
2.40.1

