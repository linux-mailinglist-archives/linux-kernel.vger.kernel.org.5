Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94CD78BBC2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjH1XqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjH1Xp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:45:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6823795;
        Mon, 28 Aug 2023 16:45:53 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SNN4xO031541;
        Mon, 28 Aug 2023 23:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KzpLzC0OmLztcMVqXQpb/mV3LqixUhSoPm43iK/1Ih4=;
 b=LeCUUQad8+VjaLeEqIf74gD1af6xhu0vVFipb9XHwX/64MyCvncn3evEDwKAWIMFZrbO
 TWFDbx3aXFJvbDAh7rQCqArZfnHHfCuKrZsLpShlCYUrJ9hJWjFfHH4BKRr7mbGKOFO6
 2uHkBVD80kUmsoJ7aZgfHkBCrLpWN1l9FP0H9wrt2rp41HV3meEPOe13hbYIcyRWK1+5
 YnnIu5Ug5A18HxvhmenOWU+ZQqS/Uh7K6xHrvYVR+0GKpkx63IzNTve24UOSogajbhso
 DN4HUYPiGwDEHgwkVwAmVFz1sY4qEsyg2sMAXqNfxNH49v39jc6JA0zqbgTQDvtqygf0 0g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq8ddmmb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 23:45:19 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SNjIVq001735
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 23:45:18 GMT
Received: from [10.71.109.168] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 16:45:17 -0700
Message-ID: <ae98c379-2ddb-6b4e-0de3-2b1c68a99ee7@quicinc.com>
Date:   Mon, 28 Aug 2023 16:45:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 02/10] drm: Introduce solid fill DRM plane property
Content-Language: en-US
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        <quic_abhinavk@quicinc.com>, <ppaalanen@gmail.com>,
        <contact@emersion.fr>, <laurent.pinchart@ideasonboard.com>,
        <sebastian.wick@redhat.com>, <ville.syrjala@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <wayland-devel@lists.freedesktop.org>
References: <20230728-solid-fill-v5-0-053dbefa909c@quicinc.com>
 <20230728-solid-fill-v5-2-053dbefa909c@quicinc.com>
 <CAA8EJpq=pbDoYc9wqKKrX+RahXp8zWTPFqVqA=S-0TkWXXJUjQ@mail.gmail.com>
 <26b4bb91-8786-c7cf-a821-eb2b881a42ab@quicinc.com>
 <656526F6-C123-4A5A-9E62-6ED092474113@linaro.org>
 <1dfcd37e-11a6-fa77-6440-f0e6bd06998d@quicinc.com>
In-Reply-To: <1dfcd37e-11a6-fa77-6440-f0e6bd06998d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yfA8ljycEPFAuUUYHS3pkUhtW2-BmOnO
X-Proofpoint-GUID: yfA8ljycEPFAuUUYHS3pkUhtW2-BmOnO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/2023 3:57 PM, Jessica Zhang wrote:
> 
> 
> On 8/7/2023 6:07 PM, Dmitry Baryshkov wrote:
>>
>>
>> On 8 August 2023 00:41:07 GMT+03:00, Jessica Zhang 
>> <quic_jesszhan@quicinc.com> wrote:
>>>
>>>
>>> On 8/4/2023 6:27 AM, Dmitry Baryshkov wrote:
>>>> On Fri, 28 Jul 2023 at 20:03, Jessica Zhang 
>>>> <quic_jesszhan@quicinc.com> wrote:
>>>>>
>>>>> Document and add support for solid_fill property to drm_plane. In
>>>>> addition, add support for setting and getting the values for 
>>>>> solid_fill.
>>>>>
>>>>> To enable solid fill planes, userspace must assign a property blob to
>>>>> the "solid_fill" plane property containing the following information:
>>>>>
>>>>> struct drm_mode_solid_fill {
>>>>>           u32 version;
>>>>>           u32 r, g, b;
>>>>> };
>>>>>
>>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>>>> ---
>>>>>    drivers/gpu/drm/drm_atomic_state_helper.c |  9 +++++
>>>>>    drivers/gpu/drm/drm_atomic_uapi.c         | 55 
>>>>> +++++++++++++++++++++++++++++++
>>>>>    drivers/gpu/drm/drm_blend.c               | 30 +++++++++++++++++
>>>>>    include/drm/drm_blend.h                   |  1 +
>>>>>    include/drm/drm_plane.h                   | 35 ++++++++++++++++++++
>>>>>    include/uapi/drm/drm_mode.h               | 24 ++++++++++++++
>>>>>    6 files changed, 154 insertions(+)
>>>>>
>>>>
>>>> [skipped most of the patch]
>>>>
>>>>> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
>>>>> index 43691058d28f..53c8efa5ad7f 100644
>>>>> --- a/include/uapi/drm/drm_mode.h
>>>>> +++ b/include/uapi/drm/drm_mode.h
>>>>> @@ -259,6 +259,30 @@ struct drm_mode_modeinfo {
>>>>>           char name[DRM_DISPLAY_MODE_LEN];
>>>>>    };
>>>>>
>>>>> +/**
>>>>> + * struct drm_mode_solid_fill - User info for solid fill planes
>>>>> + *
>>>>> + * This is the userspace API solid fill information structure.
>>>>> + *
>>>>> + * Userspace can enable solid fill planes by assigning the plane 
>>>>> "solid_fill"
>>>>> + * property to a blob containing a single drm_mode_solid_fill 
>>>>> struct populated with an RGB323232
>>>>> + * color and setting the pixel source to "SOLID_FILL".
>>>>> + *
>>>>> + * For information on the plane property, see 
>>>>> drm_plane_create_solid_fill_property()
>>>>> + *
>>>>> + * @version: Version of the blob. Currently, there is only support 
>>>>> for version == 1
>>>>> + * @r: Red color value of single pixel
>>>>> + * @g: Green color value of single pixel
>>>>> + * @b: Blue color value of single pixel
>>>>> + */
>>>>> +struct drm_mode_solid_fill {
>>>>> +       __u32 version;
>>>>> +       __u32 r;
>>>>> +       __u32 g;
>>>>> +       __u32 b;
>>>>
>>>> Another thought about the drm_mode_solid_fill uABI. I still think we
>>>> should add alpha here. The reason is the following:
>>>>
>>>> It is true that we have  drm_plane_state::alpha and the plane's
>>>> "alpha" property. However it is documented as "the plane-wide opacity
>>>> [...] It can be combined with pixel alpha. The pixel values in the
>>>> framebuffers are expected to not be pre-multiplied by the global alpha
>>>> associated to the plane.".
>>>>
>>>> I can imagine a use case, when a user might want to enable plane-wide
>>>> opacity, set "pixel blend mode" to "Coverage" and then switch between
>>>> partially opaque framebuffer and partially opaque solid-fill without
>>>> touching the plane's alpha value.
>>>
>>> Hi Dmitry,
>>>
>>> I don't really agree that adding a solid fill alpha would be a good 
>>> idea. Since the intent behind solid fill is to have a single color 
>>> for the entire plane, I think it makes more sense to have solid fill 
>>> rely on the global plane alpha.
>>>
>>> As stated in earlier discussions, I think having both a 
>>> solid_fill.alpha and a plane_state.alpha would be redundant and serve 
>>> to confuse the user as to which one to set.
>>
>> That depends on the blending mode: in Coverage mode one has 
>> independent plane and contents alpha values. And I consider alpha 
>> value to be a part of the colour in the rgba/bgra modes.
> 
> Acked -- taking Sebastian's concern into consideration, I think I'll 
> have "PIXEL_SOURCE_SOLID_FILL_RGB" and add a separate 
> "PIXEL_SOURCE_SOLID_FILL_RGBA".

Hi Dmitry,

Since it looks like there's still some ongoing discussion with Pekka 
about whether to support an RGBA solid fill source, I'll just leave a 
note to add an RGBA source in the future.

Thanks,

Jessica Zhang

> 
> Thanks,
> 
> Jessica Zhang
> 
>>
>>
>>>
>>> Thanks,
>>>
>>> Jessica Zhang
>>>
>>>>
>>>> -- 
>>>> With best wishes
>>>> Dmitry
>>
>> -- 
>> With best wishes
>> Dmitry
