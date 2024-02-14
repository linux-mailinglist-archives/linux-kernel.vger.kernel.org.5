Return-Path: <linux-kernel+bounces-66002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 526D8855518
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763C81C224FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195EA141982;
	Wed, 14 Feb 2024 21:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ibq/1/om"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8621DDC1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707947031; cv=none; b=qklAMrgwX1y0MikbnEkBRIZ0u8/GM1nWR/IpXbNf1a33T+X3rwgXziVafb8QRlg4fXAlzXHpxYRz9EuxcbH/i0Oc1F4lojLSRPSwSwwfgqirnVcHfJR5B+EBZemRtM2BGjwt9/IA/0cpv2YFgh2fcfcdkRGsmMaK9lpVGWvSLso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707947031; c=relaxed/simple;
	bh=jzDKArta05/SueeyHjcOmqtwh2NVrtwFbWx9We1YttA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=op3ijijmfIJW6iJZY463CQ8StK9MifSoAR21wOzO3Wx48w58//ioSm7iQd9pNMIRK36wDtf0wqcny1VYMkYdsyLuAFOpA47R2RGGtINXV4f8AccceNJ5pJPU3u/Zija8CV9timVW1G4k0zN9g7rJRMJI9NowfA4Npyt6Oacsjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ibq/1/om; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3cb228b90bso15785066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707947026; x=1708551826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FH2C7vn8hDWw4rS59jrNqZ5mvcTJOw6OI/RhdHm4JoE=;
        b=Ibq/1/om0fxcRKJ5GRlcXUOArldx4Ov6HsknYQ1nQa+vM8h8Xr5+zWaMjnCKnGFA17
         ZolXRYC80/v85fUu6Rgpj7UT1ukAK0SfNI4xEUSfXOJxcw98rHlj2G54pgqOIryHpgu5
         t8ZCipLIVph47u2qyPGHaqsLZdA8zi/lcBDutDRaH3GoQMDn3VZpUK5nQZkm2K/hKl5p
         V+NHV5L+dxXHi27mQ7tHcnYOV2jsfivVeOB/hJtUURZXd0+nMtFr/B1e/i+Xpn5TuW7I
         uSHGc4ZYrWeDQUckNAUf5rrV1KdBSR7t7DK+X1w7LxJNp8EcwfDLmolakEC1ABA2AhCK
         4d0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707947026; x=1708551826;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FH2C7vn8hDWw4rS59jrNqZ5mvcTJOw6OI/RhdHm4JoE=;
        b=W6ffujdsHsKZCX31hNfFTsD5VWti4jz5WDz344aA5eJtiYJtbWwzwxq7kIYjVgwUXg
         8ecZLqrAStEO0ugtWSj5uSs/5KxoTIbMGUYPAJpqEhP4NFaeFTr1UOCHUjLN6HV1YAR8
         14fSMXRY9NdeCemSibKeZSlqXTKR8P35BL4mdZLPc7y5sLrYVW5RGR0CAG4L3TjS/TrN
         TeElBkoOiRc3u9cYcj5oBdjQRfATrjuif6uw7jHOFgLBsmZQmrY1r4/T7uhzd3WKMMU4
         xP+DFIQp+M/lKF8CNnuInoPOk2PX66u1LhemMEueXQiV9+QxSjALQbEC2BZzrWgMIIEM
         sZSw==
X-Forwarded-Encrypted: i=1; AJvYcCV6gXitSxoXagWaP2zH+2+cT62Ee7gYPw80UK/55jPlLRrztjbPiDulTT4jqAHiiY69IjB3f9+QlADHSQhPlTNHFTacLr5xh6lk1uQ9
X-Gm-Message-State: AOJu0YyBPLpaxFuWcX5XoG0uETWg+CcOB0ymld3vi/92r4qX5B3jyCBm
	WeeTXVehueRz0Zkfgc4RX0673Xz0Alqg5yerw6u5pS5/hdhkvrHXd5L921KXl0s=
X-Google-Smtp-Source: AGHT+IG7UQyEyDms50ny2v6l+WwpJ0LwBFQwJp87OYPcEEuRnmhBvrC48Jo9frT13TADGjAKcjdmrQ==
X-Received: by 2002:a17:906:1cd0:b0:a3d:5932:7f59 with SMTP id i16-20020a1709061cd000b00a3d59327f59mr1945165ejh.71.1707947025935;
        Wed, 14 Feb 2024 13:43:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+n+tcGDQQCOX21+nPmBrawzYkshOo9vWPljGBds4b7g2q8cM5IFouMZRoU+qnitU3L5Rbe3hXEEo5qfQcMJW9Yq50F1TwKjXqNt1GjVn0txnn7BH8JwJSU7hoFBwSrrw76BjuZYkHCbJ0WhNWjyEpnVzl4xh7vxHB7h5ytWaI9B1roXRtp8hdoiDojN6/6hxORYbHXIYfW+n+ZkPIysJ+R+Iua0A1qOonW3n19IDDhMC4FmC4BuYKTPtGxptu/+JxSJ8vIsIMgCcH+sNh+8jXdLrDlpPUhgMtbosP64grS5AeqNkJ7HOuc7vNRFHWKOEgwWVQRASjEfnKJ00s/pJJ1dckpg68xpWtmVHVtwNFs69iybWa7UAPeEt02b4nRg9Y1qx4QZ1qwPC32haGw90HI/B2kHLlaQjG0m53c4X7NpaANOuG3SzwS63F5Si8touyQG8kkD9fWg075wrUfLh2oFRVTlSpjmjXa3vX9i5MzeyEDZguO/w5IisoGBYezFEjuKXVn6Ss0A3sLjSlZXFsqGqLLq+mG6KlKkkvlO0ubAU3uXbRs0sfrkyPA5Fc8a2On/VMcdjb4eEQ1CB1llaIDNylVi222BLPiWFL1tOWDismznKU4I3bEMrKuXX0mlFrr47QQIAOxqQYvJsHLHrYkROFsxY+HKXSYh311+HSdeGnb+wZqP2rD5nYJe0Y7TpGPu8SOSw16Wz6ZWPX7t8t7eWhwQIv549wd2y3XDv4x4NOMm+A6YSPB+5fYG1nCTzR38h4EykOLrnCVGtWz0iL2NReuzZ+7DYURshGxC89RYM0zlm2rpZM477m
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id sa4-20020a1709076d0400b00a3d841e627bsm51757ejc.58.2024.02.14.13.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 13:43:45 -0800 (PST)
Message-ID: <13d65685-b306-43ad-b9ca-a799f2cf73e5@linaro.org>
Date: Wed, 14 Feb 2024 22:43:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm: msm: add support for A750 GPU
Content-Language: en-US
To: neil.armstrong@linaro.org, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20240212-topic-sm8650-gpu-v1-0-708a40b747b5@linaro.org>
 <20240212-topic-sm8650-gpu-v1-3-708a40b747b5@linaro.org>
 <b5d76a25-045a-4acd-ad20-d28855b40222@linaro.org>
 <bcad544c-7ca2-4b4f-805b-4ccaedbd091c@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <bcad544c-7ca2-4b4f-805b-4ccaedbd091c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12.02.2024 15:45, Neil Armstrong wrote:
> On 12/02/2024 11:46, Konrad Dybcio wrote:
>> On 12.02.2024 11:37, Neil Armstrong wrote:
>>> Add support for the A750 GPU found on the SM8650 platform
>>>
>>> Unlike the the very close A740 GPU on the SM8550 SoC, the A750 GPU
>>> doesn't have an HWCFG block but a separate register set.
>>>
>>> The missing registers are added in the a6xx.xml.h file that would
>>> require a subsequent sync and the non-existent hwcfg is handled
>>> in a6xx_set_hwcg().
>>
>> These should also be submitted to mesa to make sure the next header sync
>> doesn't wipe them
> 
> Ack submitting them right now: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27576

Thanks

> 
>>
>> [...]
>>
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>> @@ -958,10 +958,11 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
>>>       struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>>>       struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>>>       const struct adreno_reglist *reg;
>>> +    bool skip_programming = !(adreno_gpu->info->hwcg || adreno_is_a7xx(adreno_gpu));
>>
>> is_a750?
> 
> OK right, I was thinking of the next gpu which will probably also miss an hwcfg
> 
>>
>>>       unsigned int i;
>>>       u32 val, clock_cntl_on, cgc_mode;
>>>   -    if (!adreno_gpu->info->hwcg)
>>> +    if (skip_programming)
>>>           return;
>>>         if (adreno_is_a630(adreno_gpu))
>>> @@ -982,6 +983,25 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
>>>                 state ? 0x5555 : 0);
>>>       }
>>>   +    if (!adreno_gpu->info->hwcg) {
>>
>> I don't think this block of code is reachable now, no?
> 
> It is because we didn't skip when adreno_is_a7xx(adreno_gpu)

Ahh I misread the brackets within the assignment

> 
>>
>> Maybe remove the skip_programming and if_a750 here?
> This would require:
>>> -    if (!adreno_gpu->info->hwcg || )
>>> +    if (!(adreno_gpu->info->hwcg || adreno_is_a750(adreno_gpu)))
> 
> and:
> 
>>> +    if (adreno_is_a750(adreno_gpu)) {
> 
> But if the next gpu also doesn't have an hwcfg, we will need to use
> the current design...
> 
> I just tried with:
> ====================><===============================
> @@ -961,7 +961,7 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
>         unsigned int i;
>         u32 val, clock_cntl_on, cgc_mode;
> 
> -       if (!adreno_gpu->info->hwcg)
> +       if (!(adreno_gpu->info->hwcg || adreno_is_a750(adreno_gpu)))
>                 return;
> 
>         if (adreno_is_a630(adreno_gpu))
> @@ -982,6 +982,25 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
>                           state ? 0x5555 : 0);
>         }
> 
> +       if (adreno_is_a750(adreno_gpu)) {
> +               gpu_write(gpu, REG_A7XX_RBBM_CLOCK_CNTL_GLOBAL, 1);
> +               gpu_write(gpu, REG_A7XX_RBBM_CGC_GLOBAL_LOAD_CMD, state ? 1 : 0);
> +
> +               if (state) {
> +                       gpu_write(gpu, REG_A7XX_RBBM_CGC_P2S_TRIG_CMD, 1);
> +
> +                       if (gpu_poll_timeout(gpu, REG_A7XX_RBBM_CGC_P2S_STATUS, val,
> +                                            val & A7XX_RBBM_CGC_P2S_STATUS_TXDONE, 1, 10)) {
> +                               dev_err(&gpu->pdev->dev, "RBBM_CGC_P2S_STATUS TXDONE Poll failed\n");
> +                               return;
> +                       }
> +
> +                       gpu_write(gpu, REG_A7XX_RBBM_CLOCK_CNTL_GLOBAL, 0);
> +               }
> +
> +               return;
> +       }
> +
>         val = gpu_read(gpu, REG_A6XX_RBBM_CLOCK_CNTL);
> 
>         /* Don't re-program the registers if they are already correct */
> ====================><===============================
> 
> And it works fine, does it work it for you ?

Let's keep it as-is in the original submission, as I've mentioned, I had
misread the code

Konrad

> 
>>
>>> +        gpu_write(gpu, REG_A7XX_RBBM_CLOCK_CNTL_GLOBAL, 1);
>>> +        gpu_write(gpu, REG_A7XX_RBBM_CGC_GLOBAL_LOAD_CMD, state ? 1 : 0);
>>> +
>>> +        if (state) {
>>> +            gpu_write(gpu, REG_A7XX_RBBM_CGC_P2S_TRIG_CMD, 1);
>>> +
>>> +            if (gpu_poll_timeout(gpu, REG_A7XX_RBBM_CGC_P2S_STATUS, val,
>>> +                         val & BIT(0), 1, 10)) {
>>
>> We should define that bit name (the err suggests it's
>> REG_A7XX_RBBM_GCC_P2S_STATUS_TXDONE or so)
>>
>> [...]
>>
>>> +static inline int adreno_is_a750(struct adreno_gpu *gpu)
>>> +{
>>> +    return gpu->info->chip_ids[0] == 0x43051401;
>>> +}
>>> +
>>>   /* Placeholder to make future diffs smaller */
>>
>> Please also remove this comment now that it's invalid
> 
> Ack
> 
>>
>> Konrad
> 
> Thanks,
> Neil
> 

