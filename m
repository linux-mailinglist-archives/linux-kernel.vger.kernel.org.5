Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DEF7894F3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 11:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjHZI7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 04:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjHZI7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 04:59:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729CA1FC3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 01:59:08 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ff8cf11b90so2594456e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 01:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693040347; x=1693645147;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VMV0LkL6XTvk7F0cHIqMZf1QrNVpfMIvkj9fG41FagQ=;
        b=lgk2m4D5SV3fD/P2u4/1d+8AR6SPFpPi+2GPAd3p+2w4cKz0cR+4UosIMI/GZIwuiG
         32WstuPhV1vP1jVIZPJad66p7yFiwZe6qAuseRXmMNCWjqJ3GWKNjP0H2gGTHIcewCe7
         YrZvAbTwmF3C+Vi6Limdkzb8MihLQYT2aQNni5guI4Tk0994CuKSg+yQY+ZYQY1NRxr8
         603vcX7SftjJaZsKCRFS24pAiQqbtVirE4Ci4AigQjRhaXw1nkXmW/ZFUCAai0dw5EhQ
         OGzkuXdUa8DmlxtyHKY+zNd+lyPkCuGHHyZ2+1suZOUxANqqfoVI9weuDEbQuvZLdUg2
         iC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693040347; x=1693645147;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMV0LkL6XTvk7F0cHIqMZf1QrNVpfMIvkj9fG41FagQ=;
        b=iedpXCMAQHX62jXL4jCY895Iz0F/Qsd0vt43LVLMbLG7GdSZE0hOwobnfz9+rm4PGc
         naTChoodjqbElgIUOEJAazverL+BwQWqR6EFzVLixgcoW6o7P/bPOIRbehj9HacYmzRO
         m6EOu5F4f7oAETSLlPKKuVblEO+K5EL8I2J0WQuRM+xGdsHPzd7jiWFZbLq7DV67+BZg
         gSy2P8vN/QcDaRvN177TOkVRUPb/aDW0Ewc5Qx2CgDftxez9ZjAozz6VuttX/dpgOzsW
         KhelgskkTkA68s/cGMZO5oMdZRiA9AdWuyawqhi1AozKfgs9J7sQhFTeS8sl1xuHxkDN
         74Rw==
X-Gm-Message-State: AOJu0YxNAQ3PvwzQ74uWZfrXjNGZU7Ia+HphPLqqI3+nzACOFbsvXcyK
        dh6q+wLZsC9tRePP2N+WJxqN5g==
X-Google-Smtp-Source: AGHT+IGNz3iCa5gUvcXoBK3a6bk4ESqUsl3Vqx26TgGDafVng3nY3NLrZPaFN8CklqhDuZLTOwb8nA==
X-Received: by 2002:ac2:4c82:0:b0:4ff:87f6:6ee5 with SMTP id d2-20020ac24c82000000b004ff87f66ee5mr13340004lfl.10.1693040346718;
        Sat, 26 Aug 2023 01:59:06 -0700 (PDT)
Received: from [192.168.1.101] (abyl74.neoplus.adsl.tpnet.pl. [83.9.31.74])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651204cc00b004fe0760354bsm631206lfq.275.2023.08.26.01.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 01:59:06 -0700 (PDT)
Message-ID: <83b9eb79-ba6d-4485-a945-c9a14bbd18d2@linaro.org>
Date:   Sat, 26 Aug 2023 10:59:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: Fix SM6375 GPU ID
To:     Rob Clark <robdclark@gmail.com>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230825-topic-6375_gpu_id-v1-1-e24f46d7f139@linaro.org>
 <CAF6AEGsNr+5zaXqKRhyeY6NV+iRD+Yz8ftqiX6Z08esoyh=DzQ@mail.gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAF6AEGsNr+5zaXqKRhyeY6NV+iRD+Yz8ftqiX6Z08esoyh=DzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.08.2023 03:29, Rob Clark wrote:
> On Fri, Aug 25, 2023 at 2:11 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> SM6375 comes with a patchlevel=1. Fix the chipid up to reflect that.
>>
>> Fixes: 90b593ce1c9e ("drm/msm/adreno: Switch to chip-id for identifying GPU")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> index 575e7c56219f..f2d9d34ed50f 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> @@ -331,7 +331,7 @@ static const struct adreno_info gpulist[] = {
>>                 ),
>>         }, {
>>                 .machine = "qcom,sm6375",
>> -               .chip_ids = ADRENO_CHIP_IDS(0x06010900),
>> +               .chip_ids = ADRENO_CHIP_IDS(0x06010901),
> 
> r-b, but maybe we should list both to be safe?  But unsure if any
> patchlevel=0 things are out there in the wild...
AFAICT only 1 for this soc

Konrad

I guess we could add
> it back in later if needed
> 
> BR,
> -
> 
>>                 .family = ADRENO_6XX_GEN1,
>>                 .revn = 619,
>>                 .fw = {
>>
>> ---
>> base-commit: 6269320850097903b30be8f07a5c61d9f7592393
>> change-id: 20230825-topic-6375_gpu_id-cf1596e2b147
>>
>> Best regards,
>> --
>> Konrad Dybcio <konrad.dybcio@linaro.org>
>>
