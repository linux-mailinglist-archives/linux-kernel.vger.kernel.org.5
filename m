Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31C9773162
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjHGVlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjHGVlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:41:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D695A10C0;
        Mon,  7 Aug 2023 14:41:45 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377LbKl6010045;
        Mon, 7 Aug 2023 21:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=txCMsI9FeeRf4FCJ9Kg6dtIDawwAvkB1CCu/2ej2ynQ=;
 b=Dxc3nSg3xctecSip78iEM2lsBxZ0ww+JYIHQvnVcw3fFjZLly+MsmZrui0wNDPZ2ktlN
 ZwXC19tQGZ2Hcjwb0JbROKYIuk0e3QOJUfSR2hYsdY6USZKzyhJgPbTFvtDblV+fmeua
 DP8S4A+MwOUf42Jxh72KCTCSl0JFfjstm/HsJuPbYLQUdKvfLRJweTA671fldQKbjLrz
 23w4s1ywjwwLe3xaroTuDgphZbKJcD4CvoHne9IXUotlOCLRoEp7TFk2H2q1ZwbW89B5
 w42mTWUgDa+vOaU3P9gBRJ0cLZmv+8CHdI5IA+VbDtIgTJsJ16frysgpNRhoPIUZqUir Zw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9f6pmcnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 21:41:09 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377Lf8SO029431
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 21:41:08 GMT
Received: from [10.71.109.168] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 14:41:07 -0700
Message-ID: <26b4bb91-8786-c7cf-a821-eb2b881a42ab@quicinc.com>
Date:   Mon, 7 Aug 2023 14:41:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 02/10] drm: Introduce solid fill DRM plane property
Content-Language: en-US
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
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <CAA8EJpq=pbDoYc9wqKKrX+RahXp8zWTPFqVqA=S-0TkWXXJUjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NfEjm1oDtbzpMW5PEec7qI7MtPcp6l3B
X-Proofpoint-GUID: NfEjm1oDtbzpMW5PEec7qI7MtPcp6l3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_24,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/2023 6:27 AM, Dmitry Baryshkov wrote:
> On Fri, 28 Jul 2023 at 20:03, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>>
>> Document and add support for solid_fill property to drm_plane. In
>> addition, add support for setting and getting the values for solid_fill.
>>
>> To enable solid fill planes, userspace must assign a property blob to
>> the "solid_fill" plane property containing the following information:
>>
>> struct drm_mode_solid_fill {
>>          u32 version;
>>          u32 r, g, b;
>> };
>>
>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>> ---
>>   drivers/gpu/drm/drm_atomic_state_helper.c |  9 +++++
>>   drivers/gpu/drm/drm_atomic_uapi.c         | 55 +++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/drm_blend.c               | 30 +++++++++++++++++
>>   include/drm/drm_blend.h                   |  1 +
>>   include/drm/drm_plane.h                   | 35 ++++++++++++++++++++
>>   include/uapi/drm/drm_mode.h               | 24 ++++++++++++++
>>   6 files changed, 154 insertions(+)
>>
> 
> [skipped most of the patch]
> 
>> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
>> index 43691058d28f..53c8efa5ad7f 100644
>> --- a/include/uapi/drm/drm_mode.h
>> +++ b/include/uapi/drm/drm_mode.h
>> @@ -259,6 +259,30 @@ struct drm_mode_modeinfo {
>>          char name[DRM_DISPLAY_MODE_LEN];
>>   };
>>
>> +/**
>> + * struct drm_mode_solid_fill - User info for solid fill planes
>> + *
>> + * This is the userspace API solid fill information structure.
>> + *
>> + * Userspace can enable solid fill planes by assigning the plane "solid_fill"
>> + * property to a blob containing a single drm_mode_solid_fill struct populated with an RGB323232
>> + * color and setting the pixel source to "SOLID_FILL".
>> + *
>> + * For information on the plane property, see drm_plane_create_solid_fill_property()
>> + *
>> + * @version: Version of the blob. Currently, there is only support for version == 1
>> + * @r: Red color value of single pixel
>> + * @g: Green color value of single pixel
>> + * @b: Blue color value of single pixel
>> + */
>> +struct drm_mode_solid_fill {
>> +       __u32 version;
>> +       __u32 r;
>> +       __u32 g;
>> +       __u32 b;
> 
> Another thought about the drm_mode_solid_fill uABI. I still think we
> should add alpha here. The reason is the following:
> 
> It is true that we have  drm_plane_state::alpha and the plane's
> "alpha" property. However it is documented as "the plane-wide opacity
> [...] It can be combined with pixel alpha. The pixel values in the
> framebuffers are expected to not be pre-multiplied by the global alpha
> associated to the plane.".
> 
> I can imagine a use case, when a user might want to enable plane-wide
> opacity, set "pixel blend mode" to "Coverage" and then switch between
> partially opaque framebuffer and partially opaque solid-fill without
> touching the plane's alpha value.

Hi Dmitry,

I don't really agree that adding a solid fill alpha would be a good 
idea. Since the intent behind solid fill is to have a single color for 
the entire plane, I think it makes more sense to have solid fill rely on 
the global plane alpha.

As stated in earlier discussions, I think having both a solid_fill.alpha 
and a plane_state.alpha would be redundant and serve to confuse the user 
as to which one to set.

Thanks,

Jessica Zhang

> 
> -- 
> With best wishes
> Dmitry
