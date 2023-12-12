Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BF880E00C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345571AbjLLAXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345556AbjLLAXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:23:09 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A317DD9;
        Mon, 11 Dec 2023 16:23:12 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBNDB6a005704;
        Tue, 12 Dec 2023 00:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=b+wUBXTlE95QpNOkeGTGy7GlPPB1G4feQIK1dZtMJm0=; b=MK
        Cv6n1ErKu+FU6zyK1Y2TBntsVy4GMTC+hj3EHJG8EbaZld2Sr1Ld/S8wdznNvA68
        qYPZ+qn8ispxTS9oZI5px2dv75y4kkG9OOSCOmaFejoEcp1aQglihhMpeXXFYSUf
        k1rT7om4vlQ7DIhJ4+BgRNs6rDOSEucp0nsONjuU629g/5CFgVX4og6PdrrNYltb
        Sjkb5se/LhEikMWENeHsExRlcLR0UCcmZMtXZbnMBeLqALe6tv3OBaNbEQl1zRXY
        VvYoK4tWljmHBbNez9b+cwLopjlHnr37nR3FOc4bEJXCgr0GiCpDzIRMdWfBmShc
        9tM2iBupjamoj8gkVPRA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ux28s9j23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 00:23:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BC0N5gh007315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 00:23:05 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 16:23:04 -0800
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
Subject: [PATCH v3 05/15] drm/msm/dpu: add cdm blocks to sc7280 dpu_hw_catalog
Date:   Mon, 11 Dec 2023 16:22:35 -0800
Message-ID: <20231212002245.23715-6-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212002245.23715-1-quic_abhinavk@quicinc.com>
References: <20231212002245.23715-1-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qmofbhnF_1A9daudpz1-okMLaWQ8EUJR
X-Proofpoint-GUID: qmofbhnF_1A9daudpz1-okMLaWQ8EUJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312120001
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

