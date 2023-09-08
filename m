Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7739F797FE6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbjIHAzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 20:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjIHAzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:55:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744C81BD3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 17:54:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso2018706a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 17:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694134498; x=1694739298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bXbb+IcSK9Tq00MQg5WGZXUVvdvtrV5bAF3gOE0KZbg=;
        b=CXJYRaXPWRWuQqphMpHp/kWTZj3SmVeUriZO/OWtuhmXdSpRkqh9INxCO/sDAqBJE4
         gyr9nhC9G3peYKJJ7Pelo/eakiK5s5hUkHp6iMl1rjwt5OnNvVvD5DVef85LtaBufVQY
         r+C+pvPOrOYEkCzcsohavJrN3dfPxlMlViI6/IsdLvEJUqui2dxtksEYscqS2IK0pJsO
         dV/wKoVwZONv6NHjVNaJZvcMUhVoDCNKvwUfyl/RLw+OVxzaaHDQ8HvxSuOOVCgM1C/z
         d4Vw5DByB4lGXQQqiDLPRb5RTv4/neVHvsiDRvnwLHQy/4SJu/HpDVHtRR8bwwT4Twic
         DCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694134498; x=1694739298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXbb+IcSK9Tq00MQg5WGZXUVvdvtrV5bAF3gOE0KZbg=;
        b=rdJ/Nv+nuaFRPbcB4MpFb0+mc2lOZweE+lwzY+wGGMs9aBHGn0KijEAmfeTrtjQETG
         Y3g7GS1XK7fmpH3qzEgD5TctnP8rlP3pbrWmz8gWLjHaXQso9gvSYHQHbbqVEQepfYJP
         whrWNBH6wYgcW1bvP4QVc97NoI2aZxdFwvUGeSzzU1wLDi/I3KBX0jNAUOWqYPNXznMZ
         a8or1FEn91u6tDmbYENwixy3IglzGQ9d37t1NqfeZ4VaMeatPmOOWTP96ChcK7M/iJuY
         80r2icL39KNBvCb1fNePJz8RY9N9gKdoOcubwSvKhu2cNPTlWlDjS1WjST0aGZNExm+Z
         yT+A==
X-Gm-Message-State: AOJu0YyH5vcmjXHAcD4NHTSfMKYAP3julAHQU/wgPKgUnJf0Jc+lLtv+
        fH/ndpwXNV3nmUPjwG51Jsklog==
X-Google-Smtp-Source: AGHT+IH4w/SdIUgkvoE9cLZ1q6yaPrRyI37jqw4LrrKMrrr1MrTCfZ/ppiYiIkr9K3p5y4n7I7exiQ==
X-Received: by 2002:a50:fe8e:0:b0:52c:84c4:a0bf with SMTP id d14-20020a50fe8e000000b0052c84c4a0bfmr574970edt.30.1694134497962;
        Thu, 07 Sep 2023 17:54:57 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id ca15-20020aa7cd6f000000b005256aaa6e7asm392737edb.78.2023.09.07.17.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 17:54:57 -0700 (PDT)
Message-ID: <f1ad3bb3-22e0-4b9d-bd94-ee2e89713cc7@linaro.org>
Date:   Fri, 8 Sep 2023 03:54:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: change _dpu_plane_calc_bw() to use u64 to
 avoid overflow
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, nespera@igalia.com,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230908003240.14104-1-quic_abhinavk@quicinc.com>
 <f110b0fa-f41f-47e8-a83b-30de2f2b128c@linaro.org>
 <19aa1b04-e136-2e19-785d-a7856f4e8e41@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <19aa1b04-e136-2e19-785d-a7856f4e8e41@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2023 03:52, Abhinav Kumar wrote:
> 
> 
> On 9/7/2023 5:35 PM, Dmitry Baryshkov wrote:
>> On 08/09/2023 03:32, Abhinav Kumar wrote:
>>> _dpu_plane_calc_bw() uses integer variables to calculate the bandwidth
>>> used during plane bandwidth calculations. However for high resolution
>>> displays this overflows easily and leads to below errors
>>
>> Can we move the u64 conversion closer to the place where we actually 
>> need it? Having u64 source width looks very strange.
>>
> 
> Its this math 
> https://gitlab.freedesktop.org/drm/msm/-/blob/msm-next/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c#L139 which overflows.
> 
> So its not just one variable but I can even change this to u32 as that 
> also fixes the issue. Let me know if u32 works better.
> 
> Perhaps I went too far to go from int to u64.

I'd prefer to have the u64 conversion around the actual calculations - 
so that we emphasise the issue, not the size of the width / etc.

> 
>>>
>>> [dpu error]crtc83 failed performance check -7
>>>
>>> Promote the intermediate variables to u64 to avoid overflow.
>>>
>>> Fixes: c33b7c0389e1 ("drm/msm/dpu: add support for clk and bw scaling 
>>> for display")
>>> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/32
>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>> ---
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>>> index ae970af1154f..c6193131beec 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>>> @@ -118,7 +118,7 @@ static u64 _dpu_plane_calc_bw(const struct 
>>> dpu_mdss_cfg *catalog,
>>>       const struct drm_display_mode *mode,
>>>       struct dpu_sw_pipe_cfg *pipe_cfg)
>>>   {
>>> -    int src_width, src_height, dst_height, fps;
>>> +    u64 src_width, src_height, dst_height, fps;
>>>       u64 plane_prefill_bw;
>>>       u64 plane_bw;
>>>       u32 hw_latency_lines;
>>

-- 
With best wishes
Dmitry

