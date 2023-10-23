Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329017D4084
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJWT43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJWT41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:56:27 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714AF8F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:56:22 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so54449971fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698090981; x=1698695781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mYhFOHXUbUUqAX9R5BipqQxHYfvxGQDwg7kFXGU8wT0=;
        b=sdrOchpYlCYRCOfEQUPFcKDl4U0d6kd5E4JIhdLDyk50/80977irilQO2hARSjnmb/
         ZdG78+/Pgv0eY8pIxQFHhlWM75V4KE+qwMFhNg00dB8LW6EeQ+dPegwTN3cNObMxM7Wx
         IpdxANo1iW2JCNopyixcQGwv0H4UDCNIC2VYF2ulFGEcSHWvPqACcwHhXgPIYd8nN6Z3
         BtgEdPolnJQNLkL9Tpo8Td9bjMPzsb5x4HPvlGnd+nmojAajpy+Z1UR6lKw+NQYmhpAo
         wa56dRlplKThCz2s92NlP09c4JL8Rvu+vvaQhbKB0SBdb5hrXTOCuAKD0P49CJ7gvSxD
         Jg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698090981; x=1698695781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYhFOHXUbUUqAX9R5BipqQxHYfvxGQDwg7kFXGU8wT0=;
        b=he6l6wuZhicIPEUmtLxNdXIGSGqNKjtHHHWhzdr4+iHcW3c4mKuBUzum8hkPn4b934
         neaX+MaJi+V534MClUkD7eGLwtqGPD4NA8JXQggPJDUw9512+ALzihjRXcPENBIH8ylJ
         h06pB/FTkaNHDmgKZgEpQTXFTKi8FLdojWfWFuixcsxF1/owcbG2ZIpiG/AdsCVlcw/d
         KbCWChJTWDAIdWDbiDTZJ4NcD423qfOOh0et8p2Ypbj2m6eZt61YDVOX7sjfT9moUng1
         Ei+DAf8IK2oJ6fTwv0dtefrBUc5W6PAkTlxolsDvvswrACWNUVmJ6SPCUKxJncz/y5zz
         0ZQQ==
X-Gm-Message-State: AOJu0YzpZdJgx8HqDdgea+8Xfgd7MU8EA2RZgt3LpkEwhcBk0bA2rh9e
        trds9H09kwUuYSiwaHBQbT1FBA==
X-Google-Smtp-Source: AGHT+IEZRo53eGHUkTmV9yAU/caZEovr8bcqahgYebYJKx9jWWwMrAx2HKht91PNWIGfd2HQU1VUQQ==
X-Received: by 2002:a19:6716:0:b0:500:9a29:bcb8 with SMTP id b22-20020a196716000000b005009a29bcb8mr6616129lfc.4.1698090980584;
        Mon, 23 Oct 2023 12:56:20 -0700 (PDT)
Received: from [172.30.205.82] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512200c00b005007da9f823sm1801580lfb.168.2023.10.23.12.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 12:56:20 -0700 (PDT)
Message-ID: <6a0398d1-22f4-4eb7-ba43-c448055be323@linaro.org>
Date:   Mon, 23 Oct 2023 21:56:16 +0200
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
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAF6AEGuS3PhNbh9Gmu1g9YpUcr3LOh1gZK-XBE+urdb5jRjorg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/23 21:42, Rob Clark wrote:
> On Mon, Oct 23, 2023 at 7:29 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> New GPUs still use the lower 2 bytes of the chip id (in whatever form
>> it comes) to signify silicon revision. Drop the warning that makes it
>> sound as if that was unintended.
>>
>> Fixes: 90b593ce1c9e ("drm/msm/adreno: Switch to chip-id for identifying GPU")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/adreno_gpu.h | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> index 80b3f6312116..9a1ec42155fd 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> @@ -203,11 +203,6 @@ struct adreno_platform_config {
>>
>>   static inline uint8_t adreno_patchid(const struct adreno_gpu *gpu)
>>   {
>> -       /* It is probably ok to assume legacy "adreno_rev" format
>> -        * for all a6xx devices, but probably best to limit this
>> -        * to older things.
>> -        */
>> -       WARN_ON_ONCE(gpu->info->family >= ADRENO_6XX_GEN1);
> 
> Maybe just change it to ADRENO_6XX_GEN4?
That also applies to 700

Konrad
