Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163F2784899
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjHVRnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjHVRnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:43:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE6A35B6;
        Tue, 22 Aug 2023 10:43:02 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MEHoFt015975;
        Tue, 22 Aug 2023 17:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=LZJQzYxrlJqS6Vj3qo/uLJKmhxdl1cWhlHZ0Ht7T5kI=;
 b=OMO2O7GOa0QqwV0cqbjMTtGj0kLHcXavMSF9yikKjbEYev+okEIqmm33VpGRLW/HuKZn
 /5ZljX8/2Wa74kXHzfeJU+2ZrAxXhgSt/vBVHpPsRmzB+AB6HE7r5fKgQLqBCUcXX+AH
 A/CoDSjHwkT/+KpTfo6gVBuoLe5Mw5HQrlTYxeQM+nKUmbJYVYKITnuGgE1ju+ZfOZvW
 xclntcbJMHhII/ijmxHsDQ+9VVdAWsjPCSh5azxxwqZiPMUpbkPx28S+M0UAYnYlmzDF
 JtkU3O8pUmDKtCG6o2LZJyD6wtdQxU0vGuVE7/u+G/w3t6hAeICpRl+g2nm7cetjKEkB eQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sm6f9utrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 17:42:45 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MHgjAO008654
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 17:42:45 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 22 Aug 2023 10:42:44 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: [PATCH v4 0/4] drm/msm: Enable widebus for DSI
Date:   Tue, 22 Aug 2023 10:42:03 -0700
Message-ID: <20230822-add-widebus-support-v4-0-9dc86083d6ea@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGvz5GQC/32OzW7CMBCEXwX53K1sB9uUU888AoiDfzZkpcZJ7
 SSAUN69DhckQD3Ozs43c2MZE2Fm29WNJZwoUxeLWH+smG9sPCFQKJpJLiuupAIbApwpoBsz5LH
 vuzRAbTZKrTWiUYKVpLMZwSUbfbNkd3tocwsRLwP8jK09LT99wpou9+bDseiG8tCl633IJJbr/
 52TAA7ecP1VS6y9Fd+/I3mK/tN3LVuIk3xQjKjeUySIYvDiYRDG6VdK9aBsuHxPqcoWqbUocxx
 y/rRlnuc/vRQWkWgBAAA=
To:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     <quic_abhinavk@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692726164; l=3231;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=nENSaOGkqQwwPXORr3uhr+cPLvRtqvjbz0+QvO3L9uk=;
 b=FsppnpJJz5YEu5yYrRPFHf4cORjhixqp+J/u5QJPlTeHP17AFpSI9S4IOg8g6VQlitzbJN1hN
 fqEbfxw3PtrDH4AoDROX006CzodmdE9eEVC5uMsbujcltGeoIXxA/Cv
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RfNbT3Lr1VwS7ANt9G4TRkfR-3UmsQTk
X-Proofpoint-ORIG-GUID: RfNbT3Lr1VwS7ANt9G4TRkfR-3UmsQTk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_14,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSI 6G v2.5.x+ and DPU support a data-bus widen mode that allows DSI
to send 48 bits of compressed data per pclk instead of 24.

For all chipsets that support this mode, enable it whenever DSC is
enabled as recommended by the hardware programming guide.

Only enable this for command mode as we are currently unable to validate
widebus for video mode.

Note: The dsi.xml.h changes were generated using the headergen2 script in
envytools [2], but the changes to the copyright and rules-ng-ng source file
paths were dropped.

[1] https://patchwork.freedesktop.org/series/121742/
[2] https://github.com/freedreno/envytools/

--
Changes in v4:
- *_widebus_* -> *_wide_bus_* (Marijn)
- Moved dpu_enc::wide_bus setting to outside of DSC check (Dmitry)
- Switched order of dpu_enc::widebus setting (Dmitry)
- Added note about INTF_CONFIG2 being present for DPU 5.0+ (Dmitry)
- Added method stub for msm_dsi_is_widebus_enabled() as to not break compilation (Dmitry)
- Whitespace and formatting fixes (Dmitry)
- Edited commit msg for "Move DPU encoder wide_bus_en setting" for clarity (Dmitry, Marijn)
- Dropped redundant initialization of disp_info
- Picked up reviewed-by tags
- Link to v3: https://lore.kernel.org/r/20230802-add-widebus-support-v3-0-2661706be001@quicinc.com

Changes in v3:
- Split commit into DPU, dsi.xml.h, and DSI changes (Dmitry)
- Add DSC enabled check to DSI *_is_widebus_enabled() helper (Dmitry)
- Dropped mention of DPU in cover letter title
- Moved setting of dpu_enc->wide_bus_en to dpu_encoder_virt_atomic_enable()
- Link to v2: https://lore.kernel.org/r/20230713-add-widebus-support-v2-1-ad0added17b6@quicinc.com

Changes in v2:
- Rebased on top of "drm/msm/dpu: Re-introduce dpu core revision"
- Squashed all commits to avoid breaking feature if the series is only partially applied
- Moved DATABUS_WIDEN bit setting to dsi_ctr_enable() (Marijn)
- Have DPU check if wide bus is requested by output driver (Dmitry)
- Introduced bytes_per_pclk variable for dsi_timing_setup() hdisplay adjustment (Marijn)
- Link to v1: https://lore.kernel.org/r/20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com

---
Jessica Zhang (4):
      drm/msm/dpu: Move setting of dpu_enc::wide_bus_en to atomic enable()
      drm/msm/dpu: Enable widebus for DSI INTF
      drm/msm/dsi: Add DATABUS_WIDEN MDP_CTRL2 bit
      drm/msm/dsi: Enable widebus for DSI

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 14 +++++++---
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |  2 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |  7 +++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |  1 +
 drivers/gpu/drm/msm/dsi/dsi.c                      |  5 ++++
 drivers/gpu/drm/msm/dsi/dsi.h                      |  1 +
 drivers/gpu/drm/msm/dsi/dsi.xml.h                  |  1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c                 | 31 +++++++++++++++++++---
 drivers/gpu/drm/msm/msm_drv.h                      |  5 ++++
 9 files changed, 59 insertions(+), 8 deletions(-)
---
base-commit: 00ee72279c963989ab435b0bc90b5dc05a9aab79
change-id: 20230525-add-widebus-support-f785546ee751

Best regards,
-- 
Jessica Zhang <quic_jesszhan@quicinc.com>

