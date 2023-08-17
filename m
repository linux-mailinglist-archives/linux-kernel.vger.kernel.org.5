Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D18E77FC86
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353824AbjHQRHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353821AbjHQRHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:07:11 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9482C30C2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:07:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so10730278a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692292027; x=1692896827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+SXi8NxNvzClt206ZYu7BQotGewF/k7fWXbsVFMs0g=;
        b=MD3wZSf6KPnikBXVO7cWOAPTpV4s8nTFPFX1YpgpF6YAddXF4riEdJSbkxZ2d9sz5V
         Dsna/rKX9OgnOf2A/POCxcOd9ygNG/RDWmugUAZQlIRs0L0LtNI/xURGUVwuZGIHetnT
         PYd/593qRgzRFx3aQZ2MXhsu2EINCI2gBXV/ysouOEh25BF6fU2Rmxp/bsD+cRPbTtfW
         9tROMtyrA7TrJHAE9aGZidkT/WsgGwFqdywqbWAI8FOrJxgXEEKInzeNODEAz9uvBA9+
         d0DhYiLMCw/0QX/sc9SzCu8WVrrVXhtNP+8ZzG82vv3cKwQmzZDXDzcIXHHasleuWWdH
         /Alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692292027; x=1692896827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+SXi8NxNvzClt206ZYu7BQotGewF/k7fWXbsVFMs0g=;
        b=BcdGYqRYXiw7WuvqXF+9SPgSbo48PigX/IY5pLIq8M/Uh+o15dfjE6+8sgsNtM3LcJ
         vdHOLv+/p9CZhIMLyCvc0oqVwUqG0Ck5dxIIWrsPDedefStPSY9ClcwKe7NeJZ3yfiKB
         hJo4HxiaqjJvBNDgLpBioUWpq2Q8a8eEnzMi4PoSaAzB1M2T7tYiXIyaRDIOwLT8q02L
         0vKs3B522+oZOM4CSoFSWJDVljrIaQbApsM8LN9NOCqjOJqHALPY5cYLxTMSQXLK6Qk3
         rmb3XnNkMmu+QzmfqztuxXOO4CYhogFSsa3SjyYIg+DJqbVTqSe3A4+iJ+rb9aLxf5IE
         n0vQ==
X-Gm-Message-State: AOJu0YxAxfqazAypKoLGkr72gl5oFKm7zH+I/poFQ38+HNmRboP/aqjK
        AwQKapMCu8U27wZVkkQOOxgPRWIuG9oRRGDHKYBflA==
X-Google-Smtp-Source: AGHT+IGR6FHDHLEB7JT4lPOySOl0W5l8tLy4Ib1OMiQcJHZZ+sD6GWAjdH84ie6V1awGmErBWSvPtg==
X-Received: by 2002:a17:906:59:b0:99d:f3ae:9a3e with SMTP id 25-20020a170906005900b0099df3ae9a3emr49117ejg.38.1692292027065;
        Thu, 17 Aug 2023 10:07:07 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id kk3-20020a170907766300b0098e2eaec395sm10388443ejc.130.2023.08.17.10.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 10:07:06 -0700 (PDT)
Message-ID: <f1b89b4c-bf6c-42c9-8a62-acc41747cb1e@linaro.org>
Date:   Thu, 17 Aug 2023 20:07:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] drm/msm/dpu: Enable widebus for DSI INTF
Content-Language: en-GB
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_abhinavk@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230802-add-widebus-support-v3-0-2661706be001@quicinc.com>
 <20230802-add-widebus-support-v3-2-2661706be001@quicinc.com>
 <CAA8EJpoPd_T+vLVrJ6RpCrYY6H1xLF4eFYVGV4N-wS3g+5cR-w@mail.gmail.com>
 <34598a37-7431-4f7e-7809-928bce65d237@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <34598a37-7431-4f7e-7809-928bce65d237@quicinc.com>
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

On 08/08/2023 00:40, Jessica Zhang wrote:
> 
> 
> On 8/2/2023 11:20 AM, Dmitry Baryshkov wrote:
>> On Wed, 2 Aug 2023 at 21:09, Jessica Zhang <quic_jesszhan@quicinc.com> 
>> wrote:

>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
>>> index df88358e7037..dace6168be2d 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
>>> @@ -69,8 +69,10 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
>>>                                  phys_enc->hw_intf,
>>>                                  phys_enc->hw_pp->idx);
>>>
>>> -       if (intf_cfg.dsc != 0)
>>> +       if (intf_cfg.dsc != 0) {
>>>                  cmd_mode_cfg.data_compress = true;
>>> +               cmd_mode_cfg.wide_bus_en = 
>>> dpu_encoder_is_widebus_enabled(phys_enc->parent);
>>> +       }
>>
>> This embeds the knowledge that a wide bus can only be enabled when DSC
>> is in use. Please move the wide_bus_en assignment out of conditional
>> code.
> 
> Wide bus for DSI will only be enabled if DSC is enabled, so this is 
> technically not wrong, as DP will use the video mode path.
> 
>>
>>>
>>>          if (phys_enc->hw_intf->ops.program_intf_cmd_cfg)
>>>                  
>>> phys_enc->hw_intf->ops.program_intf_cmd_cfg(phys_enc->hw_intf, 
>>> &cmd_mode_cfg);
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
>>> index 8ec6505d9e78..dc6f3febb574 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
>>> @@ -521,6 +521,9 @@ static void 
>>> dpu_hw_intf_program_intf_cmd_cfg(struct dpu_hw_intf *ctx,
>>
>> This function is only enabled for DPU >= 7.0, while IIRC wide bus can
>> be enabled even for some of the earlier chipsets.
> 
> The command mode path is only called for DSI, which only supports wide 
> bus for DPU 7.0+.

After second consideration, let's ignore this part, as wide bus will 
only be enabled for DSI / CMD after 7.0. If we ever have SoC that has 
CMD + wide_bus earlier than 5.0, we can reconsider this code pice.

Can you please add a comment that the register itself is present earlier 
(5.0), but it doesn't have to be programmed since the flags will not be 
set anyway.

> 
>>
>>>          if (cmd_mode_cfg->data_compress)
>>>                  intf_cfg2 |= INTF_CFG2_DCE_DATA_COMPRESS;
>>>
>>> +       if (cmd_mode_cfg->wide_bus_en)
>>> +               intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN;
>>> +
>>>          DPU_REG_WRITE(&ctx->hw, INTF_CONFIG2, intf_cfg2);
>>>   }
>>>



-- 
With best wishes
Dmitry

