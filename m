Return-Path: <linux-kernel+bounces-149969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FC68A9892
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDD028413C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5298C15E7F7;
	Thu, 18 Apr 2024 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CX7AnHBj"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E84F15AD99
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713439901; cv=none; b=Z6Y2dNvPzfT1l1/Y6uVZfVLyCT59rzHwMRUHHvbcN7HcXjq/n4g6LT34uh7jgpKgKeaNLPNOFNDGhoZQzI7XaZN3UTCFli5zoksUXKj5UU3WIo9VfUMT2N5X6uorGf27a9/YUf3A614vyhVaI4gfbRSvbyqz9n3sb1DL7GiVV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713439901; c=relaxed/simple;
	bh=wMjzhmNcwcJa8Q8gnXG/YY/EB7MYL/bXGRm82Uqogzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAaEKkMiVzt1HoKZanLmSzb63ZdoZcxlZevqqyIkdYHODyxSW+QfAdn8v0W1SJgTILLW6TcHS5x9MGku0+Ea9QF31SBaxHLGUO2sMl+Hlw4lp9M+uVQPTgPdBwGcrG0i3FWX4O6Afd4X95PzkA+WW4NWQZYU9xF3TIWf8DWdXTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CX7AnHBj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51a7d4466bso80019466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713439897; x=1714044697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X8LbQ8g2eKHuVcN88bhcgCY+RDxNHv8wy3DmMUUp3G4=;
        b=CX7AnHBjvIh9Ab070lq+Zbl1Sx9c5x472NtUifjmgIU7rpfYyBOoAef1K816DosW9H
         /LS/EtafzRhEctZBSw3joqVgh0AZQsj2/P05kWPYssbMy0sd/9OdNM6yd2tRKYJ/VNu8
         9DxLFONlpLRerUKk0vK/KdVc+vlTY6isQ3tn/e6pqVMZv+vTrS+kwuVFMpAusAOLJjst
         dO5XIOo8GHe/2h0TjumFgWQZP/kmaSDjSJgiIzcjKtqb3RIxEDhjNqXSCjNutmbUHPr3
         jrH+pxi4zyJAiQkxyv4HDBOEHt0K+x3iKrbRuCkPAfSARWbdcuNYF0AggLZl10Y/4x87
         BQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713439897; x=1714044697;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8LbQ8g2eKHuVcN88bhcgCY+RDxNHv8wy3DmMUUp3G4=;
        b=tUrTa0aQyR5QHwqJ1vVj4Ua4ziTqC5k5/LfZiuj5h72+nkjCDY8UKdsYJVEkIDWjkY
         LOcCoJEcIIHnSaQ7CZieM0M3SGQZ4dwxEHKTcGpySxlWD2x8yRIs5ikSf8MAGXTm5/Ca
         aP01En6iJF+AMUVD0tBT2A4D9nBbGXFrtK6FDt9ir5I9tmqxfeiMMi70/0npx+9C80wB
         JuHJ9J+iFqdu7nXsUI2O+9ymUbY6CJLXWhBIPcioBnXrPcLr9eV+7gBrTVKACfXMXjvC
         ySwNK83QedC48SnE+gwL8BIf9BNAdrt0xa06/osqE1ygHWioFA2MeOJkd8xDj9aq5GrO
         5j8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2Nbg9mIBj0puK+6ta2pBOF5KXUUknupza2QD6U8ub4w1EW8hE7JlLsi0E7p8gqss0zYQr4+xH+lWgATOF0mRNJ371QNt5AHRIdJmv
X-Gm-Message-State: AOJu0YyswOJsDnwKE/7LU6puJ/9Ewg9urj35o4a4eF8T/Gurs1BDEyKM
	bEPFFWDYKytX/8GFStZq/dHEbRuk6hoadBi2Ucm0uOGT1O5nhujZz6DFMP7psVA=
X-Google-Smtp-Source: AGHT+IFZBWaL9q4qqsJ4/QwRyxBVHVegYNkev4N/HvJrN2plT9bgS3FGPggcIPHvWdIFXwlOdmjMlA==
X-Received: by 2002:a17:906:1c10:b0:a47:20c3:7c51 with SMTP id k16-20020a1709061c1000b00a4720c37c51mr1422968ejg.71.1713439896601;
        Thu, 18 Apr 2024 04:31:36 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id dq16-20020a170907735000b00a524318c380sm768037ejc.80.2024.04.18.04.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 04:31:35 -0700 (PDT)
Message-ID: <2b5f33ba-2108-464c-b4d2-eff2cc6e59cf@linaro.org>
Date: Thu, 18 Apr 2024 13:31:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] drm/msm/adreno: Implement SMEM-based speed bin
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
 <20240404-topic-smem_speedbin-v2-3-c84f820b7e5b@linaro.org>
 <hi7vzqm5ebypzs6m6bw64ghgfwsdzuaxy65jpah37iw5ww7fku@n3c5sucic27i>
 <bfd6aa32-a28e-47a4-82c7-76c5dd99a44d@linaro.org>
 <7ynodjzjuxwwqkjgns5jtnkckw52qyldfpsqpjh7645swva4xk@7wucftyjyyy3>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <7ynodjzjuxwwqkjgns5jtnkckw52qyldfpsqpjh7645swva4xk@7wucftyjyyy3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.04.2024 1:07 PM, Dmitry Baryshkov wrote:
> On Thu, Apr 18, 2024 at 11:51:16AM +0200, Konrad Dybcio wrote:
>> On 18.04.2024 1:43 AM, Dmitry Baryshkov wrote:
>>> On Wed, Apr 17, 2024 at 10:02:55PM +0200, Konrad Dybcio wrote:
>>>> On recent (SM8550+) Snapdragon platforms, the GPU speed bin data is
>>>> abstracted through SMEM, instead of being directly available in a fuse.
>>>>
>>>> Add support for SMEM-based speed binning, which includes getting
>>>> "feature code" and "product code" from said source and parsing them
>>>> to form something that lets us match OPPs against.
>>>>
>>>> Due to the product code being ignored in the context of Adreno on
>>>> production parts (as of SM8650), hardcode it to SOCINFO_PC_UNKNOWN.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>
>> [...]
>>
>>>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>>>> @@ -6,6 +6,8 @@
>>>>   * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
>>>>   */
>>>>  
>>>> +#include <linux/soc/qcom/socinfo.h>
>>>> +
>>>
>>> Stray leftover?
>>
>> Looks like
>>
>> [...]
>>
>>>> +
>>>> +#ifdef CONFIG_QCOM_SMEM
>>>
>>> Please extract to a separate function and put the function under ifdef
>>> (providing a stub otherwise). Having #ifndefs inside funciton body is
>>> frowned upon.
>>
>> Hm, this looked quite sparse and straightforward, but I can do that.
>>
>> [...]
>>
>>>> +/* As of SM8650, PCODE on production SoCs is meaningless wrt the GPU bin */
>>>> +#define ADRENO_SKU_ID_FCODE		GENMASK(15, 0)
>>>> +#define ADRENO_SKU_ID(fcode)	(SOCINFO_PC_UNKNOWN << 16 | fcode)
>>>
>>> If we got rid of PCode matching, is there a need to actually use
>>> SOCINFO_PC_UNKNOWN here? Or just 0 would be fine?
>>
>> The IDs need to stay constant for mesa
>>
>> I used the define here to:
>>
>> a) define the SKU_ID structure so that it's clear what it's comprised of
>> b) make it easy to add back Pcode in case it becomes useful with future SoCs
>> c) avoid mistakes - PC_UNKNOWN happens to be zero, but that's a lucky
>>    coincidence
>>
>> We don't *match* based on PCODE, but still need to construct the ID properly
>>
>> Another option would be to pass the real pcode and add some sort of
>> "pcode_invalid" property that if found would ignore this part of the
>> SKU_ID in mesa, but that sounds overly and unnecessarily complex.
> 
> It's fine, just add a comment please. Maybe we can rename PC_UNKNOWN to
> PC_PRODUCTION?

I don't think that's right. The SoC "product code" may actually mean something
(again, not necessarily for Adreno specifically), and with Adreno in mind, it
being only meaningful for engineering samples may change in the future.

Konrad

