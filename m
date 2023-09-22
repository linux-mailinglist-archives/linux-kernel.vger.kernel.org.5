Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042F57AB82E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjIVRv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjIVRvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:51:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C54C6;
        Fri, 22 Sep 2023 10:50:48 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MHKlot017535;
        Fri, 22 Sep 2023 17:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Tq6gJJYKIaOR288NhHGipRUExs1TJ3M3G1f6vr3gs7Q=;
 b=l0Y0qgLJaJOsjU3zSDtYSahlztNYDtgEoMnCKSDcRh3/0OXX2hDi429f0czi5vjWlfb+
 Hl65x3gq8GxRgmqeQhdBDsg3zj3jLVVR3mJNaaxUKesX6VM99QezrNpAGsfjmtd4g3V7
 5OOJpW7aho/tL5OQyOZ+gkNcdRM1InLlWdpJ8DGTqAVSueK/7LKr2+utN4VXwueqjDWV
 5THLkxGFY39R18qt7M8sLrXGJ0hrbyzbcrcO85msuIgSiEzEAEaVthQRcRkY6MOjLpze
 uPeOkt/PRCQvk7sxUjsdLlqrTMM5hotdv+nVtDxk6DKX6RqWbUP5E+vuw4UrMX76gotV dQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9f8b038p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 17:49:35 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38MHnYM2010168
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 17:49:34 GMT
Received: from [10.110.112.217] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 22 Sep
 2023 10:49:33 -0700
Message-ID: <752176d8-23f4-4689-8bf4-db27f153fd39@quicinc.com>
Date:   Fri, 22 Sep 2023 10:49:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Freedreno] [PATCH RFC v6 07/10] drm/atomic: Loosen FB atomic
 checks
To:     Pekka Paalanen <ppaalanen@gmail.com>
CC:     <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <sebastian.wick@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Sean Paul" <sean@poorly.run>, <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        <quic_abhinavk@quicinc.com>, "Maxime Ripard" <mripard@kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>, <contact@emersion.fr>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        <wayland-devel@lists.freedesktop.org>,
        "David Airlie" <airlied@gmail.com>, <ville.syrjala@linux.intel.com>
References: <20230828-solid-fill-v6-0-a820efcce852@quicinc.com>
 <20230828-solid-fill-v6-7-a820efcce852@quicinc.com>
 <20230829112230.7106a8bf@eldfell>
Content-Language: en-US
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20230829112230.7106a8bf@eldfell>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uf7t3up0j0GwKZ7poXrDXC5KIWUYWgH1
X-Proofpoint-ORIG-GUID: uf7t3up0j0GwKZ7poXrDXC5KIWUYWgH1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_15,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220154
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/2023 1:22 AM, Pekka Paalanen wrote:
> On Mon, 28 Aug 2023 17:05:13 -0700
> Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
> 
>> Loosen the requirements for atomic and legacy commit so that, in cases
>> where pixel_source != FB, the commit can still go through.
>>
>> This includes adding framebuffer NULL checks in other areas to account for
>> FB being NULL when non-FB pixel sources are enabled.
>>
>> To disable a plane, the pixel_source must be NONE or the FB must be NULL
>> if pixel_source == FB.
>>
>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>> ---
>>   drivers/gpu/drm/drm_atomic.c        | 20 +++++++++++---------
>>   drivers/gpu/drm/drm_atomic_helper.c | 36 ++++++++++++++++++++----------------
>>   include/drm/drm_atomic_helper.h     |  4 ++--
>>   include/drm/drm_plane.h             | 29 +++++++++++++++++++++++++++++
>>   4 files changed, 62 insertions(+), 27 deletions(-)
> 
> ...
> 
>> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
>> index a58f84b6bd5e..4c5b7bcdb25c 100644
>> --- a/include/drm/drm_plane.h
>> +++ b/include/drm/drm_plane.h
>> @@ -992,6 +992,35 @@ static inline struct drm_plane *drm_plane_find(struct drm_device *dev,
>>   #define drm_for_each_plane(plane, dev) \
>>   	list_for_each_entry(plane, &(dev)->mode_config.plane_list, head)
>>   
>> +/**
>> + * drm_plane_solid_fill_enabled - Check if solid fill is enabled on plane
>> + * @state: plane state
>> + *
>> + * Returns:
>> + * Whether the plane has been assigned a solid_fill_blob
>> + */
>> +static inline bool drm_plane_solid_fill_enabled(struct drm_plane_state *state)
>> +{
>> +	if (!state)
>> +		return false;
>> +	return state->pixel_source == DRM_PLANE_PIXEL_SOURCE_SOLID_FILL && state->solid_fill_blob;
>> +}
>> +
>> +static inline bool drm_plane_has_visible_data(const struct drm_plane_state *state)
>> +{
>> +	switch (state->pixel_source) {
>> +	case DRM_PLANE_PIXEL_SOURCE_NONE:
>> +		return false;
>> +	case DRM_PLANE_PIXEL_SOURCE_SOLID_FILL:
>> +		return state->solid_fill_blob != NULL;
> 
> This reminds me, new UAPI docs did not say what the requirements are for
> choosing solid fill pixel source. Is the atomic commit rejected if
> pixel source is solid fill, but solid_fill property has no blob?

Hi Pekka,

Yes, if pixel_source is solid_fill and the solid_fill property blob 
isn't set, the atomic commit should throw an error.

Will document this in the UAPI.

Thanks,

Jessica Zhang

> 
> This should be doc'd.
> 
> 
> Thanks,
> pq
> 
>> +	case DRM_PLANE_PIXEL_SOURCE_FB:
>> +	default:
>> +		WARN_ON(state->pixel_source != DRM_PLANE_PIXEL_SOURCE_FB);
>> +	}
>> +
>> +	return state->fb != NULL;
>> +}
>> +
>>   bool drm_any_plane_has_format(struct drm_device *dev,
>>   			      u32 format, u64 modifier);
>>   
>>
> 
