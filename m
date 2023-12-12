Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E8780F893
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377397AbjLLUx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377257AbjLLUxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:53:17 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B94139;
        Tue, 12 Dec 2023 12:53:22 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCH6p2j018580;
        Tue, 12 Dec 2023 20:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=b+wUBXTlE95QpNOkeGTGy7GlPPB1G4feQIK1dZtMJm0=; b=Qx
        /OP3OIOnGOrtigm+5rtlLrwOLbNmCp6HuHn7tp7+L46AMUz6BeEEl/CmPSHnGuEW
        qVRpMlKCJ9JsA9JgpLalOoUikSGtOxM6D8GU78TZx9oRImWB+w5/6QRtAPDdqGQT
        EdZm9AZ2AAWV2WeOx6EDX+bZ0nUisZ2QnZVpNd9vFgpfhZ7EFV+hUBqL10YaRjyJ
        4e3UNbYkzNsl8wXx9xjVNtGVgqRc8mEwIGMVhAGH/ptHDc7NNjxtFjFp+Iho9+2W
        pvndyj//3JbIYXH3RVPFwOxQb86L2Gka/+6ndufxnU/qpXTp5g35j5YVkQvLp5er
        RZOFl0axcALii9AraY1w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxpsu9ajp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 20:53:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCKrEGL011077
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 20:53:14 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 12:53:13 -0800
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <seanpaul@chromium.org>,
        <quic_jesszhan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 05/15] drm/msm/dpu: add cdm blocks to sc7280 dpu_hw_catalog
Date:   Tue, 12 Dec 2023 12:52:43 -0800
Message-ID: <20231212205254.12422-6-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212205254.12422-1-quic_abhinavk@quicinc.com>
References: <20231212205254.12422-1-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dBaWx6f86bpTnuX7k7ku-lTDkTSWIzrn
X-Proofpoint-ORIG-GUID: dBaWx6f86bpTnuX7k7ku-lTDkTSWIzrn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312120161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CDM blocks to the sc7280 dpu_hw_catalog to support
YUV format output from writeback block.

changes in v3:
	- change the comment from sub-blk to clk for CDM

changes in v2:
	- remove explicit zero assignment for features
	- move sc7280_cdm to dpu_hw_catalog from the sc7280
	  catalog file as its definition can be re-used

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h  |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c      | 10 ++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h      | 13 +++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h         |  5 +++++
 4 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
index 209675de6742..19c2b7454796 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
@@ -248,6 +248,7 @@ const struct dpu_mdss_cfg dpu_sc7280_cfg = {
 	.mdss_ver = &sc7280_mdss_ver,
 	.caps = &sc7280_dpu_caps,
 	.mdp = &sc7280_mdp,
+	.cdm = &sc7280_cdm,
 	.ctl_count = ARRAY_SIZE(sc7280_ctl),
 	.ctl = sc7280_ctl,
 	.sspp_count = ARRAY_SIZE(sc7280_sspp),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index d52aae54bbd5..b304bebedb84 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -426,6 +426,16 @@ static const struct dpu_dsc_sub_blks dsc_sblk_1 = {
 	.ctl = {.name = "ctl", .base = 0xF80, .len = 0x10},
 };
 
+/*************************************************************
+ * CDM block config
+ *************************************************************/
+static const struct dpu_cdm_cfg sc7280_cdm = {
+	.name = "cdm_0",
+	.id = CDM_0,
+	.len = 0x228,
+	.base = 0x79200,
+};
+
 /*************************************************************
  * VBIF sub blocks config
  *************************************************************/
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index e3c0d007481b..ba82ef4560a6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -682,6 +682,17 @@ struct dpu_vbif_cfg {
 	u32 memtype[MAX_XIN_COUNT];
 };
 
+/**
+ * struct dpu_cdm_cfg - information of chroma down blocks
+ * @name               string name for debug purposes
+ * @id                 enum identifying this block
+ * @base               register offset of this block
+ * @features           bit mask identifying sub-blocks/features
+ */
+struct dpu_cdm_cfg {
+	DPU_HW_BLK_INFO;
+};
+
 /**
  * Define CDP use cases
  * @DPU_PERF_CDP_UDAGE_RT: real-time use cases
@@ -805,6 +816,8 @@ struct dpu_mdss_cfg {
 	u32 wb_count;
 	const struct dpu_wb_cfg *wb;
 
+	const struct dpu_cdm_cfg *cdm;
+
 	u32 ad_count;
 
 	u32 dspp_count;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index a6702b2bfc68..f319c8232ea5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -185,6 +185,11 @@ enum dpu_dsc {
 	DSC_MAX
 };
 
+enum dpu_cdm {
+	CDM_0 = 1,
+	CDM_MAX
+};
+
 enum dpu_pingpong {
 	PINGPONG_NONE,
 	PINGPONG_0,
-- 
2.40.1

