Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65E7801E61
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 21:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjLBTyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 14:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBTys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 14:54:48 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36435125
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 11:54:54 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-50abb83866bso4555036e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 11:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701546892; x=1702151692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mypENOTvjGc6UKp6SNlOk81hu+cXKNAEwrYZ0eb98SE=;
        b=gBgZYMDdfdndn4+su1fQ/6xNlU6hi5ZtgEg8RM9ZhAz3S3iDWuP3EW7iZUXTTsnxjx
         jTkzmNCAGFBgf+E2ZSCYgYvOsIJNpR+qW6UjE0kphwlDQjbXKuKCou3CYDWvoA60mzed
         22FnMi7AJPBIRpJz4R56teYQOWikdt0AJQhyDGHzfyPx/+QkvlqbzUDVzRRVPOSHE7wo
         Ywa0V4knZ9opXHGsDr87EPyhyMhbbYEB0w2JtgEqibyRpJQDIJHslpmPKsXjc5oCOwAQ
         55BNHduAInJEe5WZKFDRp4SP48kXOcKIP3521sxIw/KQklBTWWwLRaGOx7NSYQvAQ3T+
         c4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701546892; x=1702151692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mypENOTvjGc6UKp6SNlOk81hu+cXKNAEwrYZ0eb98SE=;
        b=H8zIR+69z5x1ALOlLli+Cjc88O9AGuyVpu/O1IIJjyxXKDUuvacY89vOtguKhHoE51
         uplklSEcUuht/OGj0wyCvcaQuA687Rkho1irwLerh41AzqBRJ8uMra9/T+TC13TLdKKN
         6IiVj3IuD4x0x3MCism3iBgfmDN4sGrqFXR4oo+QMT8e2QglZEd/2Ya+FHW2w4Dk0+Sn
         Kl1Wy5/RhasLdnR1949pAphKhexabATXYqrkppyXbBTHDSUSzCYmQ170JN/kun+DiR1Z
         Nfni+1B/P5AyGpfTxw8iXkCcuvV9vZf9Xsz5+KzlA+PsK+DaEFiSPbfrAqGC813mm+VQ
         Jlew==
X-Gm-Message-State: AOJu0YwXfibCA7F3N+x1VVJOBndxkvjy0pDgwbR4lL5lFsW4vO+G1imO
        FNX4SfKMetx+a7tYeF3/CX/vCQ==
X-Google-Smtp-Source: AGHT+IH3My8XPBaauAwFiRuvgLhrkMUD2b5HPKUvjhIU+O7KAUS3Yyc7nyJY4nMMh7APjo3+nzysjg==
X-Received: by 2002:a05:6512:10ce:b0:50b:d764:28ee with SMTP id k14-20020a05651210ce00b0050bd76428eemr1441389lfg.134.1701546892350;
        Sat, 02 Dec 2023 11:54:52 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id c27-20020ac25f7b000000b00507a0098424sm37426lfc.109.2023.12.02.11.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 11:54:51 -0800 (PST)
Message-ID: <77c229fd-5414-49ad-bccd-7a5732345695@linaro.org>
Date:   Sat, 2 Dec 2023 21:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/msm/dpu: Set input_sel bit for INTF
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231130-encoder-fixup-v1-0-585c54cd046e@quicinc.com>
 <20231130-encoder-fixup-v1-2-585c54cd046e@quicinc.com>
 <CAA8EJpqeu18q4jN82fUvsEdBRmEjG_mYLQQUWD+LDxjiQQQPsg@mail.gmail.com>
 <a076fced-f4b9-804e-eb73-1fbb510c4951@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <a076fced-f4b9-804e-eb73-1fbb510c4951@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2023 23:29, Abhinav Kumar wrote:
> 
> 
> On 11/30/2023 11:36 PM, Dmitry Baryshkov wrote:
>> On Fri, 1 Dec 2023 at 03:31, Jessica Zhang <quic_jesszhan@quicinc.com> 
>> wrote:
>>>
>>> Set the input_sel bit for encoders as it was missed in the initial
>>> implementation.
>>>
>>> Reported-by: Rob Clark <robdclark@gmail.com>
>>> Fixes: 91143873a05d ("drm/msm/dpu: Add MISR register support for 
>>> interface")
>>> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/39
>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>> ---
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 2 +-
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c   | 2 +-
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c | 7 ++++++-
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h | 4 +++-
>>>   4 files changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
>>> index 3442cf65b86f..d0884997ecb7 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
>>> @@ -320,7 +320,7 @@ static u32 dpu_hw_intf_get_line_count(struct 
>>> dpu_hw_intf *intf)
>>>
>>>   static void dpu_hw_intf_setup_misr(struct dpu_hw_intf *intf)
>>>   {
>>> -       dpu_hw_setup_misr(&intf->hw, INTF_MISR_CTRL);
>>> +       dpu_hw_setup_misr(&intf->hw, INTF_MISR_CTRL, true);
>>>   }
>>>
>>>   static int dpu_hw_intf_collect_misr(struct dpu_hw_intf *intf, u32 
>>> *misr_value)
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
>>> index f38473e68f79..77b14107c84a 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
>>> @@ -83,7 +83,7 @@ static void dpu_hw_lm_setup_border_color(struct 
>>> dpu_hw_mixer *ctx,
>>>
>>>   static void dpu_hw_lm_setup_misr(struct dpu_hw_mixer *ctx)
>>>   {
>>> -       dpu_hw_setup_misr(&ctx->hw, LM_MISR_CTRL);
>>> +       dpu_hw_setup_misr(&ctx->hw, LM_MISR_CTRL, false);
>>>   }
>>>
>>>   static int dpu_hw_lm_collect_misr(struct dpu_hw_mixer *ctx, u32 
>>> *misr_value)
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
>>> index a8a0a4e76b94..f441df47fdde 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
>>> @@ -481,7 +481,8 @@ void _dpu_hw_setup_qos_lut(struct 
>>> dpu_hw_blk_reg_map *c, u32 offset,
>>>                        cfg->danger_safe_en ? 
>>> QOS_QOS_CTRL_DANGER_SAFE_EN : 0);
>>>   }
>>>
>>> -void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map *c, u32 
>>> misr_ctrl_offset)
>>> +void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map *c, u32 
>>> misr_ctrl_offset,
>>> +               bool set_input_sel)
>>>   {
>>>          u32 config = 0;
>>>
>>> @@ -491,6 +492,10 @@ void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map 
>>> *c, u32 misr_ctrl_offset)
>>>          wmb();
>>>
>>>          config = MISR_FRAME_COUNT | MISR_CTRL_ENABLE | 
>>> MISR_CTRL_FREE_RUN_MASK;
>>> +
>>> +       if (set_input_sel)
>>> +               config |= MISR_CTRL_INPUT_SEL;
>>> +
>>>          DPU_REG_WRITE(c, misr_ctrl_offset, config);
>>>   }
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
>>> index bb496ebe283b..793670d62414 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
>>> @@ -17,6 +17,7 @@
>>>   #define MISR_CTRL_ENABLE                BIT(8)
>>>   #define MISR_CTRL_STATUS                BIT(9)
>>>   #define MISR_CTRL_STATUS_CLEAR          BIT(10)
>>> +#define MISR_CTRL_INPUT_SEL             BIT(24)
>>
>> The public apq8916 TRM documents this as a 4-bit field. I think this
>> was followed into the later generations. Can we please document it
>> correctly and use an uint instead of just bool for set_input_sel?
>>
> 
> Can you pls point us to this document you are referring?

I have this link in my bookmarks, which doesn't seem to work no longer:

https://developer.qualcomm.com/download/sd410/snapdragon-410e-technical-reference-manual.pdf?referrer=node/29241

96boards forum has several links and mentions of this doc.

> 
> I was not aware that bit level details are revealed in external 
> documents :)
> 
> Even though its a 4-bit field, it only takes a 0 or 1 as others are 
> undefined.
> 
> Exposing all the bits will only cause more confusion like it did for 
> others thinking that input select is actually configurable when its not.
> 
> I think what we should do is just pass "misr_type" to this API to tell 
> whether its lm misr or intf misr and set BIT(24) based on that.

This would be another simplification. Can we instead just use values 0 
and 1 instead and maybe document that by default everybody should use 0.

> 
> 
>>>   #define MISR_CTRL_FREE_RUN_MASK         BIT(31)
>>>
>>>   /*
>>> @@ -357,7 +358,8 @@ void _dpu_hw_setup_qos_lut(struct 
>>> dpu_hw_blk_reg_map *c, u32 offset,
>>>                             bool qos_8lvl,
>>>                             const struct dpu_hw_qos_cfg *cfg);
>>>
>>> -void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map *c, u32 
>>> misr_ctrl_offset);
>>> +void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map *c, u32 
>>> misr_ctrl_offset,
>>> +                      bool set_input_sel);
>>>
>>>   int dpu_hw_collect_misr(struct dpu_hw_blk_reg_map *c,
>>>                  u32 misr_ctrl_offset,
>>>
>>> -- 
>>> 2.43.0
>>>
>>
>>

-- 
With best wishes
Dmitry

