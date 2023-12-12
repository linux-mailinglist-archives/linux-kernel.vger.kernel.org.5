Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C463B80DFFA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbjLLAXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345449AbjLLAXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:23:00 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BC6A7;
        Mon, 11 Dec 2023 16:23:06 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBLWkKS009499;
        Tue, 12 Dec 2023 00:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=3pk4IXZbRx2JyIzDXcHhLUpgk64hLdQD05kGrB0UJdw=; b=aE
        q/RnNlA6ZJ6Hdxtzmfg808S6/m3urDVXDl3b2NveLPt3FJF+r1p6wTj8rYsw7zl0
        CL5choZ9GrVr5ykSqYtJBfWDeWkD9vqr90OxAZ5a+AYukP1TugRrxPbKmmkYGOWq
        8QnqdAmnTusMn3AMwXCC0sRkDaZVCHFv03k9+Tvw7SnO/68gMXGtHFNbcRLXB6tL
        gMX/5XZcaGeH5kjS0BRS0u+GwVeQbbB42YmpJY5q6HswHn2GW4mOvyRomFFEHA3w
        rVMqKd99TZTC7UNoNxSa1z9lapbimE4pOwYweNxXMH2yCQPLf4Ak9CiHxal/zTH2
        bDu2f80WEUOTVi1YRT7A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxa8jga40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 00:22:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BC0MxOL000320
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 00:22:59 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 16:22:58 -0800
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
Subject: [PATCH v3 02/15] drm/msm/dpu: rename dpu_encoder_phys_wb_setup_cdp to match its functionality
Date:   Mon, 11 Dec 2023 16:22:32 -0800
Message-ID: <20231212002245.23715-3-quic_abhinavk@quicinc.com>
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
X-Proofpoint-GUID: nKQmzFCPIkovHhnJSvbehitHwm9XRxsF
X-Proofpoint-ORIG-GUID: nKQmzFCPIkovHhnJSvbehitHwm9XRxsF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120001
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dpu_encoder_phys_wb_setup_cdp() is not programming the chroma down
prefetch block. Its setting up the display ctl path for writeback.

Hence rename it to dpu_encoder_phys_wb_setup_ctl() to match what its
actually doing.

Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback")
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index 425415d45ec1..8f05f2a1fc24 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -207,10 +207,10 @@ static void dpu_encoder_phys_wb_setup_fb(struct dpu_encoder_phys *phys_enc,
 }
 
 /**
- * dpu_encoder_phys_wb_setup_cdp - setup chroma down prefetch block
+ * dpu_encoder_phys_wb_setup_ctl - setup wb pipeline for ctl path
  * @phys_enc:Pointer to physical encoder
  */
-static void dpu_encoder_phys_wb_setup_cdp(struct dpu_encoder_phys *phys_enc)
+static void dpu_encoder_phys_wb_setup_ctl(struct dpu_encoder_phys *phys_enc)
 {
 	struct dpu_hw_wb *hw_wb;
 	struct dpu_hw_ctl *ctl;
@@ -382,7 +382,7 @@ static void dpu_encoder_phys_wb_setup(
 
 	dpu_encoder_phys_wb_setup_fb(phys_enc, fb);
 
-	dpu_encoder_phys_wb_setup_cdp(phys_enc);
+	dpu_encoder_phys_wb_setup_ctl(phys_enc);
 
 }
 
-- 
2.40.1

