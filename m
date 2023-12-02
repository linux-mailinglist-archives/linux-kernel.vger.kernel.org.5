Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEC6801EF9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 23:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjLBWUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 17:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBWUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 17:20:21 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB7B119
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 14:20:26 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bef9b7a67so382840e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 14:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701555625; x=1702160425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ev48WhSxuIt318yon0pzoZ1KohyLW6w41dJCtn1iVzE=;
        b=mU+aP8MJ6RG1EPaQk9kaIByBsReFSmS/pYPB7R9IafEfgcH8K2tsK/yH/dZCrAQwOC
         c59C4AJKKTrO7xHpFYlKsbbWqay/QjobleBnGTFNUNJpb5hKZlErN+h/Qk1vOB3b9YYp
         FjTF0t6mtRE+3GCGS+1Bygc7QFArL3XyFUJWKZZR23NVxKCD35kcyHU+B6vT/EDG/n5m
         jJ1AjzmtRmqfPCgDPiIXPFyCI64Reo7G5iNyqWcn6jpuXtypPu/RX0G8++nhLbP9Y/0b
         GuOZqUqKZcbewXfym7N4fzWFmvuh/B+cdhoTafgNT0fV7mriR/dECwe3ejjs0Lxp0MBB
         skuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701555625; x=1702160425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ev48WhSxuIt318yon0pzoZ1KohyLW6w41dJCtn1iVzE=;
        b=BEakyVYIO/TWX6e/jMwSM4Z0IaeUhAZ2qw/c4DU0A6xpAqVQS76ngqLgrvxwNU2tux
         4tNId2TCP+fqxEo7rBg2gEQKHp8icomRW/nxzI/SWLLRaxuKK9Y0cg9Qsirjgy7YgDfM
         nc6nQsKfuzTqx/QVpHMsRQoAcc6q278kXfUqxeBwq3IuHACpOARAVLT/nue9k0Xr9oLJ
         iaxvYNOCaPpCkg7XNUs5pDsTW3Xo0l6i8CHeYjN/G8qv+sYyKecaAm4TfBJiwCDonB7v
         8MFjlnFmuuMHjlDViUwTDTJIvhHWEdSOhiQKYVEZ6EkPkP2Kar2NcveK/SiVYKDmecPO
         P63Q==
X-Gm-Message-State: AOJu0Yw7xYapN3SMctvJ5XafE/0SqGNKcfraLXmlSkkywP7F8OyfzVJB
        uxL3Xhgq1eePpg5BheJlBfH69A==
X-Google-Smtp-Source: AGHT+IGbjQPABgG+QUpn0WgrJETi3NKiVKW/2ZOl0KFy6XCqqXBc/S1CkBQzmaR+Yk1DIjvr1dLFHA==
X-Received: by 2002:a19:ca4d:0:b0:50b:c1b8:9442 with SMTP id h13-20020a19ca4d000000b0050bc1b89442mr1466391lfj.51.1701555624756;
        Sat, 02 Dec 2023 14:20:24 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l24-20020a19c218000000b005092e621916sm816406lfc.222.2023.12.02.14.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 14:20:24 -0800 (PST)
Message-ID: <d7199b2c-6baa-4241-b2e6-c739f7c540e1@linaro.org>
Date:   Sun, 3 Dec 2023 00:20:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] drm/msm/dpu: fix video mode DSC for DSI
Content-Language: en-GB
To:     Jonathan Marek <jonathan@marek.ca>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnaud Vrac <rawoul@gmail.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231114225857.19702-1-jonathan@marek.ca>
 <20231114225857.19702-2-jonathan@marek.ca>
 <CAA8EJpp0OGkgf0P6LcwE-H6BVN9kbtF_eRCsef+7NgDFmJOZfA@mail.gmail.com>
 <d93a7c6f-a798-c9ec-6c10-08e4e5a70f4d@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <d93a7c6f-a798-c9ec-6c10-08e4e5a70f4d@marek.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 20:30, Jonathan Marek wrote:
> On 11/15/23 3:53 AM, Dmitry Baryshkov wrote:
>> On Wed, 15 Nov 2023 at 01:00, Jonathan Marek <jonathan@marek.ca> wrote:
>>>
>>> Add necessary DPU changes for DSC to work with DSI video mode.
>>>
>>> Note this changes the logic to enable HCTL to match downstream, it will
>>> now be enabled for the no-DSC no-widebus case.
>>>
>>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>>> ---
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c         |  2 +-
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h    |  2 +-
>>>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c    | 11 +++++++++++
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c         | 13 ++++++++++++-
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h         |  1 +
>>>   5 files changed, 26 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> index 1cf7ff6caff4..d745c8678b9d 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> @@ -2477,7 +2477,7 @@ enum dpu_intf_mode 
>>> dpu_encoder_get_intf_mode(struct drm_encoder *encoder)
>>>          return INTF_MODE_NONE;
>>>   }
>>>
>>> -unsigned int dpu_encoder_helper_get_dsc(struct dpu_encoder_phys 
>>> *phys_enc)
>>> +unsigned int dpu_encoder_helper_get_dsc(const struct 
>>> dpu_encoder_phys *phys_enc)
>>
>> Why?
>>
> 
> drm_mode_to_intf_timing_params has "phys_enc" pointer declared as const, 
> so one of them needs to change to call dpu_encoder_helper_get_dsc
> 
>>>   {
>>>          struct drm_encoder *encoder = phys_enc->parent;
>>>          struct dpu_encoder_virt *dpu_enc = 
>>> to_dpu_encoder_virt(encoder);
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
>>> index 6f04c3d56e77..7e27a7da0887 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
>>> @@ -332,7 +332,7 @@ static inline enum dpu_3d_blend_mode 
>>> dpu_encoder_helper_get_3d_blend_mode(
>>>    *   used for this encoder.
>>>    * @phys_enc: Pointer to physical encoder structure
>>>    */
>>> -unsigned int dpu_encoder_helper_get_dsc(struct dpu_encoder_phys 
>>> *phys_enc);
>>> +unsigned int dpu_encoder_helper_get_dsc(const struct 
>>> dpu_encoder_phys *phys_enc);
>>>
>>>   /**
>>>    * dpu_encoder_helper_split_config - split display configuration 
>>> helper function
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>> index a01fda711883..df10800a9615 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>> @@ -100,6 +100,8 @@ static void drm_mode_to_intf_timing_params(
>>>          }
>>>
>>>          timing->wide_bus_en = 
>>> dpu_encoder_is_widebus_enabled(phys_enc->parent);
>>> +       if (dpu_encoder_helper_get_dsc(phys_enc))
>>> +               timing->compression_en = true;
>>>
>>>          /*
>>>           * for DP, divide the horizonal parameters by 2 when
>>> @@ -112,6 +114,15 @@ static void drm_mode_to_intf_timing_params(
>>>                  timing->h_front_porch = timing->h_front_porch >> 1;
>>>                  timing->hsync_pulse_width = 
>>> timing->hsync_pulse_width >> 1;
>>>          }
>>> +
>>> +       /*
>>> +        * for DSI, if compression is enabled, then divide the 
>>> horizonal active
>>> +        * timing parameters by compression ratio.
>>> +        */
>>> +       if (phys_enc->hw_intf->cap->type != INTF_DP && 
>>> timing->compression_en) {
>>> +               timing->width = timing->width / 3; /* XXX: don't 
>>> assume 3:1 compression ratio */
>>
>> Is this /3 from bpp / compressed_bpp?
>>
> 
> It is the compression ratio of DSC for 8bpc (24bpp) compressed to 8bpp. 
> DSI driver doesn't support any other cases so this assumption should be 
> OK for now (the other common ratio is 3.75 for 10bpc compressed to 8bpp 
> - from downstream driver it appears this would mean a division by 3.75 
> here).
> 
>>> +               timing->xres = timing->width;
>>> +       }
>>>   }
>>>
>>>   static u32 get_horizontal_total(const struct 
>>> dpu_hw_intf_timing_params *timing)
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
>>> index e8b8908d3e12..d6fe45a6da2d 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
>>> @@ -166,10 +166,21 @@ static void 
>>> dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>>>           * video timing. It is recommended to enable it for all 
>>> cases, except
>>>           * if compression is enabled in 1 pixel per clock mode
>>>           */
>>> +       if (!p->compression_en || p->wide_bus_en)
>>> +               intf_cfg2 |= INTF_CFG2_DATA_HCTL_EN;
>>> +
>>>          if (p->wide_bus_en)
>>> -               intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN | 
>>> INTF_CFG2_DATA_HCTL_EN;
>>> +               intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN;
>>>
>>>          data_width = p->width;
>>> +       if (p->wide_bus_en && !dp_intf)
>>> +               data_width = p->width >> 1;
>>> +
>>> +       if (p->compression_en)
>>> +               intf_cfg2 |= INTF_CFG2_DCE_DATA_COMPRESS;
>>> +
>>> +       if (p->compression_en && dp_intf)
>>> +               DPU_ERROR("missing adjustments for DSC+DP\n");
>>>
>>>          hsync_data_start_x = hsync_start_x;
>>>          hsync_data_end_x =  hsync_start_x + data_width - 1;
>>
>> This should go into a separate commit with the proper justification.
>>
> 
> All of it? setting the INTF_CFG2_DCE_DATA_COMPRESS flag at least doesn't 
> make sense to make a separate patch. And DSI widebus is only used with 
> DSC (and always used when available), so IMO also in the scope of this 
> commit.

Excuse me for being not precise. I'm more concerned about 
INTF_CFG2_DATA_HCTL_EN change. They way you have added it doesn't have 
anything to do with the DSC support. If we ever want to revert just that 
clause to check anything, we wil have to revert the whole DSC-DSI-video 
commit, which doesn't seem correct.

> 
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
>>> index c539025c418b..15a5fdadd0a0 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
>>> @@ -33,6 +33,7 @@ struct dpu_hw_intf_timing_params {
>>>          u32 hsync_skew;
>>>
>>>          bool wide_bus_en;
>>> +       bool compression_en;
>>>   };
>>>
>>>   struct dpu_hw_intf_prog_fetch {
>>> -- 
>>> 2.26.1
>>>
>>
>>

-- 
With best wishes
Dmitry

