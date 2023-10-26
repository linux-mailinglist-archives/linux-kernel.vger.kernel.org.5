Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887AF7D88D6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjJZTQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZTQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:16:24 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793C61AE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:16:21 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507c78d258fso1923305e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698347780; x=1698952580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MmfACo16Znzmc2tlkLC7HANA11z5OmTtfKSPsuqMXkQ=;
        b=qELsQnqlMTAGGjktJNHhjSDa/9pxhjK3RuwRGfOf2PwOsxBIiEV/pOQax3MQAwPByN
         ZAjxCQvTyBiMrOJf9M5v4Mw3t5Wsvl9fSbsfNaHhq+E2Pffz04iVr7morU1c0SLmS/DW
         Z2W1WJZVdhLiyvXVwnZTIvTeoVrOFow211HCNVW6d1Nahjm1SXqvU8KcVqUaDMfCZ6F2
         q5PRsqnlIgSq6AGai5/ueYgsKRWeJ1BT+2Z9EocYIOoxX58GfjgzA3RUr/4afkP/51Zz
         BEr2l15DTd8QgwYu0/ymaZTnLMarW3y/GXmJ39aL2fESO6KNi+ESoqaNcdAj8J0OTKWe
         M9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698347780; x=1698952580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmfACo16Znzmc2tlkLC7HANA11z5OmTtfKSPsuqMXkQ=;
        b=vBWk49lUub/lud46LYM93Vncmd3jTIcITlUOw6850bmyW2/WjSKtEBR1x60FJ/mdJJ
         uelxpL0A3PJeotTIJh8cIRfbK9jx6/tOjQnO+JmqQC1QwM1k/wp57yXVY/8OxB9wW0WJ
         RXsXe41SU1299cqe4zDG6klpLj56vYpUWquDFI8ryZ6YmHDWhqI6yp3ZvGcgv2H2c64Y
         e2PSv5KmAkPKWANdLRBCxRJloUC58V8DQHde5AAd9pchw59BACFWYrs0/yhFmByh3Iad
         3pGMjPeY7NqEX3QQMVpmYmSDHSyRDHjO6r8ik/fZiLFI0ekhejTYMfixQKfNzD5igNaa
         AyRA==
X-Gm-Message-State: AOJu0YxL1xAUuJjL9xvQ0xcTc+xQDK0PycRGS0fZynjrOgVaKSj4C6BE
        bHCGB7XBvxAxi9CGKdn7oQoLMw==
X-Google-Smtp-Source: AGHT+IG+I8IqwyM3X+sAvm1ZUN54t+CWanNfCrnKDrk6SJrmu26XlqPpUrDfvcoLvyebrtu/2Fnzew==
X-Received: by 2002:a05:6512:1156:b0:503:7be:c85d with SMTP id m22-20020a056512115600b0050307bec85dmr246597lfg.35.1698347779684;
        Thu, 26 Oct 2023 12:16:19 -0700 (PDT)
Received: from [172.30.204.229] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id be43-20020a056512252b00b004f13cd61ebbsm3119078lfb.175.2023.10.26.12.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 12:16:19 -0700 (PDT)
Message-ID: <6146cc54-b3f9-4875-851e-3d2981b23ffc@linaro.org>
Date:   Thu, 26 Oct 2023 21:16:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: Drop WARN_ON from patchid lookup for new
 GPUs
To:     Rob Clark <robdclark@gmail.com>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
References: <20231023-topic-adreno_warn-v1-1-bb1ee9391aa2@linaro.org>
 <CAF6AEGuS3PhNbh9Gmu1g9YpUcr3LOh1gZK-XBE+urdb5jRjorg@mail.gmail.com>
 <6a0398d1-22f4-4eb7-ba43-c448055be323@linaro.org>
 <CAF6AEGuqrm0pssjRDa9DK=NppU4Qq5cPZicbGfxKH2czJmjK2A@mail.gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAF6AEGuqrm0pssjRDa9DK=NppU4Qq5cPZicbGfxKH2czJmjK2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/23 22:20, Rob Clark wrote:
> On Mon, Oct 23, 2023 at 12:56 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 10/23/23 21:42, Rob Clark wrote:
>>> On Mon, Oct 23, 2023 at 7:29 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>
>>>> New GPUs still use the lower 2 bytes of the chip id (in whatever form
>>>> it comes) to signify silicon revision. Drop the warning that makes it
>>>> sound as if that was unintended.
>>>>
>>>> Fixes: 90b593ce1c9e ("drm/msm/adreno: Switch to chip-id for identifying GPU")
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>    drivers/gpu/drm/msm/adreno/adreno_gpu.h | 5 -----
>>>>    1 file changed, 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>>>> index 80b3f6312116..9a1ec42155fd 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>>>> @@ -203,11 +203,6 @@ struct adreno_platform_config {
>>>>
>>>>    static inline uint8_t adreno_patchid(const struct adreno_gpu *gpu)
>>>>    {
>>>> -       /* It is probably ok to assume legacy "adreno_rev" format
>>>> -        * for all a6xx devices, but probably best to limit this
>>>> -        * to older things.
>>>> -        */
>>>> -       WARN_ON_ONCE(gpu->info->family >= ADRENO_6XX_GEN1);
>>>
>>> Maybe just change it to ADRENO_6XX_GEN4?
>> That also applies to 700
> 
> Then the warn is warning about what it is supposed to ;-)
> 
> I guess this is coming from a6xx_gmu_fw_start()?  I think we need a
> different way to construct the gmu chipid, since the point of this was
> to not depend on the low 8b having any particular meaning.  Perhaps we
> should just get the gmu chipid from the device table.
Guess that could work as well..

Konrad
