Return-Path: <linux-kernel+bounces-24091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1156782B6B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290E91C23DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1653D58202;
	Thu, 11 Jan 2024 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AWrg1wFM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951FF3B198;
	Thu, 11 Jan 2024 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BLVRYY020187;
	Thu, 11 Jan 2024 21:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9skgMF499mKm9d9AVt+z+xIQxaH31o4zQYYS34pttdQ=; b=AW
	rg1wFM51GGQkH89mh8sCCHiPuj1fzqjsqKRE4M68Pbbu1MUO27fBBO55mRV2F83x
	nmwLtJ4t16QOlKckQ7TQ5YR5ThS3soYuAWNRi+/qfkp4YtCbUIC5tF4bCw/MhkZd
	b8YgYKd0UBW8fYYmZXwDdccXcGYunmnkNJPa9VWQN5AJfERbWr8CFK38ni+57c0k
	qMC7pdOrF2X9O3ll1QVnGwt4Ba0fTye3k5B2lMW/agof9ezk5ERP/jSjeXMuwgiZ
	XPPpONtzUAdd7AJ5H1HJz2HZXSiXPZ+uQXE/APhXdyFIe96+dYoUMGDJcjcjO+U0
	etkq8A9mwidJMCjtelzw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vj6c8jnmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 21:35:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BLZXou024192
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 21:35:33 GMT
Received: from [10.110.91.77] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 13:35:31 -0800
Message-ID: <d2fc43b0-6a7b-9d50-238b-c95439695a0f@quicinc.com>
Date: Thu, 11 Jan 2024 13:35:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] drm/msm/dp: correct configure Colorimetry Indicator
 Field at MISC0
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <quic_abhinavk@quicinc.com>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1704917888-30039-1-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJprkotYgo8je2+N=aZGxEReHgLR_rooKQBOWqRn+dgKtSQ@mail.gmail.com>
Content-Language: en-US
From: Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAA8EJprkotYgo8je2+N=aZGxEReHgLR_rooKQBOWqRn+dgKtSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4UGW-jkM4Od05Vr8fR_pNzvHGV1hb-lE
X-Proofpoint-GUID: 4UGW-jkM4Od05Vr8fR_pNzvHGV1hb-lE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401110168


On 1/10/2024 3:38 PM, Dmitry Baryshkov wrote:
> On Wed, 10 Jan 2024 at 22:18, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>> MSA MISC0 bit 1 to 7 contains Colorimetry Indicator Field. At current
>> implementation, Colorimetry Indicator Field of MISC0 is not configured
>> correctly. This patch add support of RGB formats Colorimetry.
> https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
>
> Also the commit message doesn't provide any details or what was incorrect.
>
>> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c  |  5 ++--
>>   drivers/gpu/drm/msm/dp/dp_link.c  | 26 ++++++++++++++++-----
>>   drivers/gpu/drm/msm/dp/dp_panel.c | 48 +++++++++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/dp/dp_panel.h |  2 ++
>>   4 files changed, 73 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 77a8d93..2ef89fb 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /*
>> - * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2012-2023, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved
>>    */
>>
>>   #define pr_fmt(fmt)    "[drm-dp] %s: " fmt, __func__
>> @@ -172,7 +173,7 @@ static void dp_ctrl_configure_source_params(struct dp_ctrl_private *ctrl)
>>
>>          tb = dp_link_get_test_bits_depth(ctrl->link,
>>                  ctrl->panel->dp_mode.bpp);
>> -       cc = dp_link_get_colorimetry_config(ctrl->link);
>> +       cc = dp_panel_get_misc_colorimetry_val(ctrl->panel);
>>          dp_catalog_ctrl_config_misc(ctrl->catalog, cc, tb);
>>          dp_panel_timing_cfg(ctrl->panel);
>>   }
>> diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
>> index 98427d4..21fa1a2 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_link.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_link.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /*
>>    * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved
>>    */
>>
>>   #define pr_fmt(fmt)    "[drm-dp] %s: " fmt, __func__
>> @@ -12,6 +13,11 @@
>>
>>   #define DP_TEST_REQUEST_MASK           0x7F
>>
>> +enum dynamic_range {
>> +       DP_DYNAMIC_RANGE_RGB_VESA,
>> +       DP_DYNAMIC_RANGE_RGB_CEA,
>> +};
>> +
>>   enum audio_sample_rate {
>>          AUDIO_SAMPLE_RATE_32_KHZ        = 0x00,
>>          AUDIO_SAMPLE_RATE_44_1_KHZ      = 0x01,
>> @@ -1083,6 +1089,7 @@ int dp_link_process_request(struct dp_link *dp_link)
>>   int dp_link_get_colorimetry_config(struct dp_link *dp_link)
>>   {
>>          u32 cc;
>> +       enum dynamic_range dr;
>>          struct dp_link_private *link;
>>
>>          if (!dp_link) {
>> @@ -1092,14 +1099,21 @@ int dp_link_get_colorimetry_config(struct dp_link *dp_link)
>>
>>          link = container_of(dp_link, struct dp_link_private, dp_link);
>>
>> -       /*
>> -        * Unless a video pattern CTS test is ongoing, use RGB_VESA
>> -        * Only RGB_VESA and RGB_CEA supported for now
>> -        */
>> +       /* unless a video pattern CTS test is ongoing, use CEA_VESA */
>>          if (dp_link_is_video_pattern_requested(link))
>> -               cc = link->dp_link.test_video.test_dyn_range;
>> +               dr = link->dp_link.test_video.test_dyn_range;
> test_dyn_range has the value of (dpcd[DP_TEST_MISC0] &
> DP_TEST_DYNAMIC_RANGE_CEA), so it can not be assigned to dr.
>
> I don't feel like this has been tested.

yes, you are correct.

This code derived from down stream code.

I will fix it.

>>          else
>> -               cc = DP_TEST_DYNAMIC_RANGE_VESA;
>> +               dr = DP_DYNAMIC_RANGE_RGB_VESA;
>> +
>> +       /* Only RGB_VESA and RGB_CEA supported for now */
>> +       switch (dr) {
>> +       case DP_DYNAMIC_RANGE_RGB_CEA:
>> +               cc = BIT(2);
> No undefined magic, please.
>
>> +               break;
>> +       case DP_DYNAMIC_RANGE_RGB_VESA:
>> +       default:
>> +               cc = 0;
>> +       }
>>
>>          return cc;
>>   }
>> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
>> index 127f6af..785bb59 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /*
>>    * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved
>>    */
>>
>>   #include "dp_panel.h"
>> @@ -386,6 +387,53 @@ int dp_panel_init_panel_info(struct dp_panel *dp_panel)
>>          return 0;
>>   }
>>
>> +/*
>> + * Mapper function which outputs colorimetry to be used for a
>> + * given colorspace value when misc field of MSA is used to
>> + * change the colorimetry. Currently only RGB formats have been
>> + * added. This API will be extended to YUV once it's supported on DP.
>> + */
>> +u8 dp_panel_get_misc_colorimetry_val(struct dp_panel *dp_panel)
>> +{
>> +       u8 colorimetry;
>> +       u32 colorspace;
>> +       u32 cc;
>> +       struct dp_panel_private *panel;
>> +
>> +       panel = container_of(dp_panel, struct dp_panel_private, dp_panel);
>> +
>> +       cc = dp_link_get_colorimetry_config(panel->link);
>> +       /*
>> +        * If there is a non-zero value then compliance test-case
>> +        * is going on, otherwise we can honor the colorspace setting
>> +        */
>> +       if (cc)
>> +               return cc;
>> +
>> +       colorspace = dp_panel->connector->state->colorspace;
> The driver doesn't attach the colorspace property, so this part is
> useless. Anyway, I think adding colorimetry support will require more
> changes than just setting the register in the DisplayPort controller.

agree,

this is just provision here for the future.

most likely, dp_panel->connector->state->colorspace will have value of 0 
which will return colorimetry = 0 (legacy rgb mode) at end of this function.

>
>> +       drm_dbg_dp(panel->drm_dev, "colorspace=%d\n", colorspace);
>> +
>> +       switch (colorspace) {
>> +       case DRM_MODE_COLORIMETRY_DCI_P3_RGB_D65:
>> +       case DRM_MODE_COLORIMETRY_DCI_P3_RGB_THEATER:
>> +               colorimetry = 0x7;
>> +               break;
>> +       case DRM_MODE_COLORIMETRY_RGB_WIDE_FIXED:
>> +               colorimetry = 0x3;
>> +               break;
>> +       case DRM_MODE_COLORIMETRY_RGB_WIDE_FLOAT:
>> +               colorimetry = 0xb;
>> +               break;
>> +       case DRM_MODE_COLORIMETRY_OPRGB:
>> +               colorimetry = 0xc;
> Please define these magic values.
>
>> +               break;
>> +       default:
>> +               colorimetry = 0;        /* legacy RGB mode */
>> +       }
>> +
>> +       return colorimetry;
>> +}
>> +
>>   struct dp_panel *dp_panel_get(struct dp_panel_in *in)
>>   {
>>          struct dp_panel_private *panel;
>> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
>> index a0dfc57..c34a51d 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_panel.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_panel.h
>> @@ -1,6 +1,7 @@
>>   /* SPDX-License-Identifier: GPL-2.0-only */
>>   /*
>>    * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved
>>    */
>>
>>   #ifndef _DP_PANEL_H_
>> @@ -65,6 +66,7 @@ int dp_panel_get_modes(struct dp_panel *dp_panel,
>>                  struct drm_connector *connector);
>>   void dp_panel_handle_sink_request(struct dp_panel *dp_panel);
>>   void dp_panel_tpg_config(struct dp_panel *dp_panel, bool enable);
>> +u8 dp_panel_get_misc_colorimetry_val(struct dp_panel *dp_panel);
>>
>>   /**
>>    * is_link_rate_valid() - validates the link rate
>> --
>> 2.7.4
>>
>

