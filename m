Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D1780003E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377452AbjLAAfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377446AbjLAAfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:35:20 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7AB10DE;
        Thu, 30 Nov 2023 16:35:26 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUNNE44000304;
        Fri, 1 Dec 2023 00:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=ICdgyrkMliI33Zpw9gltYRMWGQds5j3xcF2jKWyi/WY=;
 b=CZwRLBHzw0oIL4/Thp39vVR6BdRlp0zjo7WDSvK3NdSA4DxZGEho3rLJefqqEM/+HFI2
 eokqYp2E+HI4RXi4+rWIVaugNTXwMiFADe3+fL8kf2iKdxuQJBQ2I7huPfFcdko/B2fh
 01VH4f/TF3WNcEAViWPWxZve9tswPkQrlUg5y58yJYz9ugd+0eiUFOm18w7NiwCzN1+Y
 LpL7fQTDXPuU+qW8Vrh7Cyyahmz2dty8+xS4JKZcNUaFOPhVIcDO8u7TaDe5bKYWG1yd
 Hq0QYcNJGmjDhNgMs06dHnnq00J7KyAqTyNhMiBHq7q7zvN5hFW64OKAvFIQUMHz6I93 BQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uprhdt13n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 00:35:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B10Z7Pa031593
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Dec 2023 00:35:07 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 30 Nov
 2023 16:35:07 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Thu, 30 Nov 2023 16:35:01 -0800
Subject: [PATCH] drm/msm/dpu: Add missing safe_lut_tbl in sc8180x catalog
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231130-sc8180x-dpu-safe-lut-v1-1-a8a6bbac36b8@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADQqaWUC/x2N0QqDMAwAf0XyvEBTwcl+ZeyhNskslE6adQjiv
 6/4eAfHHWBSkxg8hgOq/JKlT+lAtwHiGspbMHFn8M6PRKNDizPNbkfeGlpQwdy+qMqO1Xvi6Q4
 9XYIJLjWUuPa4tJy73Kpo2q/X83Wef6AHPT97AAAA
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Bjorn Andersson" <andersson@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701390907; l=1254;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=MEBwXB+U40Igb6rl9s9JdUj63wjC5O+InEcgkFNeMIA=;
 b=x7bPJlpmlUmEM2cThkbyeN+nKlbeopYuh/BL7ABKUpKBiPz+YHS0MdKpser8mH+VTK5k/WLm5bif
 qCT8UpHeDDXw/YprkmH6dAKoqpdJtto4+f0DjBmPPYhaWcKtfteM
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: krFbri4l06wzhX9N-6J09zRIA-AOB_oC
X-Proofpoint-GUID: krFbri4l06wzhX9N-6J09zRIA-AOB_oC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_25,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to SC8280XP, the misconfigured SAFE logic causes rather
significant delays in __arm_smmu_tlb_sync(), resulting in poor
performance for things such as USB.

Introduce appropriate SAFE values for SC8180X to correct this.

Fixes: f3af2d6ee9ab ("drm/msm/dpu: Add SC8180x to hw catalog")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
index e07f4c8c25b9..9ffc8804a6fc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
@@ -367,6 +367,7 @@ static const struct dpu_perf_cfg sc8180x_perf_data = {
 	.min_llcc_ib = 800000,
 	.min_dram_ib = 800000,
 	.danger_lut_tbl = {0xf, 0xffff, 0x0},
+	.safe_lut_tbl = {0xfff0, 0xf000, 0xffff},
 	.qos_lut_tbl = {
 		{.nentry = ARRAY_SIZE(sc7180_qos_linear),
 		.entries = sc7180_qos_linear

---
base-commit: 3cd3fe06ff81cfb3a969acb12a56796cff5af23d
change-id: 20231130-sc8180x-dpu-safe-lut-ffd0df221d67

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>

