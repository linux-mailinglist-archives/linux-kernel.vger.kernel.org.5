Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96728772BE3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjHGRAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHGRAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:00:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E852010D3;
        Mon,  7 Aug 2023 10:00:17 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377GR84H003920;
        Mon, 7 Aug 2023 16:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2H2FCkKP+T2JmARHpHPwC63TJXfE4g0cY/xMUvrrJu0=;
 b=UJIiuhH/h9aaNE2riQ4H+HrSeDOI8CJesK3RlPIOxRJoGAdC+0JmNsFC+mQklblMJxsS
 sKMvGc3mtxQPUvhY7CSdCua+ePgLqABQSf3ErvOePffvstlKRfFLXMJc/H4hsR2UNTbv
 RdxKNGnaVhl89jCxBbX4jFjoCQPG6B1PEQhImF+86xvlPqHdTSQces8rK77wGvBcH/yW
 BuQysYnqr4n+rOmye/71oomnc/GYcgKWj9vuXYjnmQylo8OBMb2/MmpUXrLPh+IzLPPa
 jKlztU/ptbKAnnUFYywPNV0z18rpstMB5rIAuCQWweqMnwqIZwIErj/frkImnArASWIC aw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9deem1yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 16:59:48 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377Gxl4o022663
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 16:59:47 GMT
Received: from [10.71.109.168] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 09:59:47 -0700
Message-ID: <705fbc71-7610-1567-42cd-b52caa94a12a@quicinc.com>
Date:   Mon, 7 Aug 2023 09:59:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 09/10] drm/msm/dpu: Use DRM solid_fill property
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
CC:     <quic_abhinavk@quicinc.com>, <ppaalanen@gmail.com>,
        <contact@emersion.fr>, <laurent.pinchart@ideasonboard.com>,
        <sebastian.wick@redhat.com>, <ville.syrjala@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <wayland-devel@lists.freedesktop.org>
References: <20230728-solid-fill-v5-0-053dbefa909c@quicinc.com>
 <20230728-solid-fill-v5-9-053dbefa909c@quicinc.com>
 <de406c53-023d-f477-17f2-7d6dabf838bd@linaro.org>
 <b2c55511-f44d-1c5a-a59b-108d57a07864@quicinc.com>
 <23cf0a04-7988-9d83-7411-eec1ff270fad@linaro.org>
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <23cf0a04-7988-9d83-7411-eec1ff270fad@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2m-p9BfwEucAIgFUNtCEIwMoF2me9Z7X
X-Proofpoint-ORIG-GUID: 2m-p9BfwEucAIgFUNtCEIwMoF2me9Z7X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_18,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/2023 5:52 PM, Dmitry Baryshkov wrote:
> On 01/08/2023 03:39, Jessica Zhang wrote:
>>
>>
>> On 7/30/2023 9:15 PM, Dmitry Baryshkov wrote:
>>> On 28/07/2023 20:02, Jessica Zhang wrote:
>>>> Drop DPU_PLANE_COLOR_FILL_FLAG and check the DRM solid_fill property to
>>>> determine if the plane is solid fill. In addition drop the DPU plane
>>>> color_fill field as we can now use drm_plane_state.solid_fill instead,
>>>> and pass in drm_plane_state.alpha to _dpu_plane_color_fill_pipe() to
>>>> allow userspace to configure the alpha value for the solid fill color.
>>>>
>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>>> ---
>>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 24 
>>>> ++++++++++++++++++------
>>>>   1 file changed, 18 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c 
>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>>>> index 114c803ff99b..95fc0394d13e 100644
>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>>>> @@ -42,7 +42,6 @@
>>>>   #define SHARP_SMOOTH_THR_DEFAULT    8
>>>>   #define SHARP_NOISE_THR_DEFAULT    2
>>>> -#define DPU_PLANE_COLOR_FILL_FLAG    BIT(31)
>>>>   #define DPU_ZPOS_MAX 255
>>>>   /*
>>>> @@ -82,7 +81,6 @@ struct dpu_plane {
>>>>       enum dpu_sspp pipe;
>>>> -    uint32_t color_fill;
>>>>       bool is_error;
>>>>       bool is_rt_pipe;
>>>>       const struct dpu_mdss_cfg *catalog;
>>>> @@ -606,6 +604,20 @@ static void _dpu_plane_color_fill_pipe(struct 
>>>> dpu_plane_state *pstate,
>>>>       _dpu_plane_setup_scaler(pipe, fmt, true, &pipe_cfg, 
>>>> pstate->rotation);
>>>>   }
>>>> +static uint32_t _dpu_plane_get_bgr_fill_color(struct drm_solid_fill 
>>>> solid_fill)
>>>
>>> As I commented for v4 (please excuse me for not responding to your 
>>> email at thattime), we can return abgr here, taking 
>>> plane->state->alpha into account.
>>
>> Hi Dmitry,
>>
>> Since it seems that this comment wasn't resolved, I can drop your R-B 
>> tag in the next revision.
> 
> It's a minor issue, so no need to drop the tag.
> 
>>
>>  From my previous response, I pointed out that the color parameter 
>> expects an RGB value [1].
>>
>> So is the intention here to refactor _dpu_plane_color_fill() to accept 
>> an ABGR8888 color?
> 
> That's what I'm suggesting.

Hi Dmitry,

Got it, sounds good to me.

Thanks,

Jessica Zhang

> 
>>
>> Thanks,
>>
>> Jessica Zhang
>>
>> [1] 
>> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c#L676
>>
>>>
>>>> +{
>>>> +    uint32_t ret = 0;
>>>> +    uint8_t b = solid_fill.b >> 24;
>>>> +    uint8_t g = solid_fill.g >> 24;
>>>> +    uint8_t r = solid_fill.r >> 24;
>>>> +
>>>> +    ret |= b << 16;
>>>> +    ret |= g << 8;
>>>> +    ret |= r;
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>>   /**
>>>>    * _dpu_plane_color_fill - enables color fill on plane
>>>>    * @pdpu:   Pointer to DPU plane object
>>>> @@ -977,9 +989,9 @@ void dpu_plane_flush(struct drm_plane *plane)
>>>>       if (pdpu->is_error)
>>>>           /* force white frame with 100% alpha pipe output on error */
>>>>           _dpu_plane_color_fill(pdpu, 0xFFFFFF, 0xFF);
>>>> -    else if (pdpu->color_fill & DPU_PLANE_COLOR_FILL_FLAG)
>>>> -        /* force 100% alpha */
>>>> -        _dpu_plane_color_fill(pdpu, pdpu->color_fill, 0xFF);
>>>> +    else if (drm_plane_solid_fill_enabled(plane->state))
>>>> +        _dpu_plane_color_fill(pdpu, 
>>>> _dpu_plane_get_bgr_fill_color(plane->state->solid_fill),
>>>> +                plane->state->alpha);
>>>>       else {
>>>>           dpu_plane_flush_csc(pdpu, &pstate->pipe);
>>>>           dpu_plane_flush_csc(pdpu, &pstate->r_pipe);
>>>> @@ -1024,7 +1036,7 @@ static void dpu_plane_sspp_update_pipe(struct 
>>>> drm_plane *plane,
>>>>       }
>>>>       /* override for color fill */
>>>> -    if (pdpu->color_fill & DPU_PLANE_COLOR_FILL_FLAG) {
>>>> +    if (drm_plane_solid_fill_enabled(plane->state)) {
>>>>           _dpu_plane_set_qos_ctrl(plane, pipe, false);
>>>>           /* skip remaining processing on color fill */
>>>>
>>>
>>> -- 
>>> With best wishes
>>> Dmitry
>>>
> 
> -- 
> With best wishes
> Dmitry
> 
