Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF3380F896
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377418AbjLLUx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377261AbjLLUxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:53:17 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92759BD;
        Tue, 12 Dec 2023 12:53:23 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCH5ccI016954;
        Tue, 12 Dec 2023 20:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=tsxYs1fuHcx4vLRl1xXfE1z7QmpFwUZYGeyYd91+J2Y=; b=N+
        1P1LhSmxq+Izpv055kiuy5z7pk5JwUDBxc1MuQp0dejN0Zx17ySABx2KA3dSUa8Z
        VM2P9cl4Otr1qCG2HXov4IYnhPJiQIlOxqzswItk2uCfGLcxPCz4qKuJUl+Wstz+
        LpKfk8C+Avm6HTdau1ejFrBFdX0Pk18AsluwMbrM62Bqkv2v6flt/63QTFYIejm7
        W3NMtEqDbvp1LCpV1/RMFyt2Up38kWyDlcuHThSaB9F0l64r7zNMaGyzTt+3nBXU
        GpWVSATi1Z+hVWd1pQjOkBdH9X3ISC/lwKELaMKwQ4HlOdERpI2sRQJka3AW42LJ
        rleuEXXLq15hz+RybSjw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxpsu9ajs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 20:53:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCKrFuX027263
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 20:53:15 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 12:53:15 -0800
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
Subject: [PATCH v4 06/15] drm/msm/dpu: add cdm blocks to sm8250 dpu_hw_catalog
Date:   Tue, 12 Dec 2023 12:52:44 -0800
Message-ID: <20231212205254.12422-7-quic_abhinavk@quicinc.com>
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
X-Proofpoint-GUID: Qgi07HRZ582qeU5L3vjW2QHgzO0thxgD
X-Proofpoint-ORIG-GUID: Qgi07HRZ582qeU5L3vjW2QHgzO0thxgD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=994 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
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

Add CDM blocks to the sm8250 dpu_hw_catalog to support
YUV format output from writeback block.

changes in v2:
	- re-use the cdm definition from sc7280

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
index 2359c16e9206..58b0f50518c8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
@@ -384,6 +384,7 @@ const struct dpu_mdss_cfg dpu_sm8250_cfg = {
 	.mdss_ver = &sm8250_mdss_ver,
 	.caps = &sm8250_dpu_caps,
 	.mdp = &sm8250_mdp,
+	.cdm = &sc7280_cdm,
 	.ctl_count = ARRAY_SIZE(sm8250_ctl),
 	.ctl = sm8250_ctl,
 	.sspp_count = ARRAY_SIZE(sm8250_sspp),
-- 
2.40.1

