Return-Path: <linux-kernel+bounces-149844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0848F8A96B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3C51C20A17
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B657115B54C;
	Thu, 18 Apr 2024 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jtd1XF+U"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07715AD86
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433883; cv=none; b=lb+P+3eKUDKvSgO/5lt5RqREkn5ahGTxejPBGZeISoDpcDGr+e7ZlU4xDhwc2keMFkAFsU9roqCtUTqTNBdHf1XtSCysE12vbDLtQn+ogam+IILLJIae5vkQEhV9EDSslC1Mz707P6kY3liELoenh1hrGEYjyn/qJpVpm673cAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433883; c=relaxed/simple;
	bh=CmkAx09d7unD9qOUxiMbRZMA780DM6Gi/Z/Ysdz0BIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKCEnpRA0plvfHNsGX8H42HJGUBWgk8AzQbtHLDbShLmK0hOKtInbmC8EgYleo9VUwALSzi9zMe7Nvp5EfuBNhQDx7U1Odi7j8xUckDvfs5ApBp7wPjTDOwwT76F1EtikDTbQn9LlR8zqF13i1ax5l86hfW8qV/bXXfZqBdcRjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jtd1XF+U; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso1049226a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713433880; x=1714038680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OGBY5n0lkuic0XzOyZry0BISQT6Vj4C0SqZCz5uX33M=;
        b=Jtd1XF+UC11q92Vf1ok4gytCI42vyCt93cIX689IBUYr5XtTkIIrJyUD9njzGDdU8r
         eYBQgJRPx92dhB9V7Jv0SDIoJEyzrHIU0UG1vI2JnYTj4zIr2jpSeNooNYVaUAqD5u3F
         rR3fFrrlLk1EwAnBf0IILrgUYMrH8FFeWCxYCrr06h4zqB6g0kRTrBd+/o5KlD41U+Mr
         qzQC7JTPkozO1F6yXGCOoCiQRQMcZY31zB5l0UlPmdS3aN0H4RqnRkPOKiEDdAd3dZD1
         YEKyVGhuc2Php1YNE6VjS9cwDJKKGXKdUu3TaUibHSrENU57Op/2uL85MAp9T78AjdmK
         bNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433880; x=1714038680;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGBY5n0lkuic0XzOyZry0BISQT6Vj4C0SqZCz5uX33M=;
        b=wSC+cnICE/qYK0GLBvdKvGlsn2m4my9VIDhbEkyOj9CNeJXEJjsAwKHXq18tIX84sn
         SygIzQf40JwI/nGvGdHy/mQLyYqP5Zncz6+ijxXCqUmj79qCaCJ+Tc13Hj4vugel0w3i
         T68nLhMWEjPLso/THmvm+K7ZbbE/RcuZCu8sNX36ksMfnzk8ePsV2OF5uaGPKt9Rp7AY
         LaW51kXgfxGOcwVompVGHjwHnjK/oCGuWHjEN2YjN9Okn8voBMyspx35WG3aDYH5hQZV
         nggSycIjta+GIsslljA1dIhD50OHtuZNDTXYKITunbrqG1dkfz4E9z0CxOZazLLp708z
         Toug==
X-Forwarded-Encrypted: i=1; AJvYcCUvqxufgchD+EnjKrGmfl59JuFHwOFVES75NIPd9x9fxIpsgo/SfU13pAW+/VyfP2/3Uqc+RA9ZUedRwmSHtjLvJOAqaJduWbth69kO
X-Gm-Message-State: AOJu0YyQCdc4sSSLX7+WjAak/wrNLDjbR+MOkzh0/0a6JuxV2INvOMiu
	dSLJa0dOV1zlZCwcb9D8v33In30qUWFA8etZPJHRKMxihrnJOhYzOqPiM2H5JgOh8FarIhWMSd2
	h
X-Google-Smtp-Source: AGHT+IEEkKZPQY7QzwTKRJ0bNeVqexAdC7M3xSccRFnfmZoQdKknEIXHCT2bcHYHrhmFkBAsMjYF1w==
X-Received: by 2002:a17:906:4151:b0:a52:c873:a66 with SMTP id l17-20020a170906415100b00a52c8730a66mr1316386ejk.34.1713433879768;
        Thu, 18 Apr 2024 02:51:19 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709067f8500b00a5559f0f9dcsm669994ejr.79.2024.04.18.02.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:51:18 -0700 (PDT)
Message-ID: <bfd6aa32-a28e-47a4-82c7-76c5dd99a44d@linaro.org>
Date: Thu, 18 Apr 2024 11:51:16 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <hi7vzqm5ebypzs6m6bw64ghgfwsdzuaxy65jpah37iw5ww7fku@n3c5sucic27i>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.04.2024 1:43 AM, Dmitry Baryshkov wrote:
> On Wed, Apr 17, 2024 at 10:02:55PM +0200, Konrad Dybcio wrote:
>> On recent (SM8550+) Snapdragon platforms, the GPU speed bin data is
>> abstracted through SMEM, instead of being directly available in a fuse.
>>
>> Add support for SMEM-based speed binning, which includes getting
>> "feature code" and "product code" from said source and parsing them
>> to form something that lets us match OPPs against.
>>
>> Due to the product code being ignored in the context of Adreno on
>> production parts (as of SM8650), hardcode it to SOCINFO_PC_UNKNOWN.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---

[...]

>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> @@ -6,6 +6,8 @@
>>   * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
>>   */
>>  
>> +#include <linux/soc/qcom/socinfo.h>
>> +
> 
> Stray leftover?

Looks like

[...]

>> +
>> +#ifdef CONFIG_QCOM_SMEM
> 
> Please extract to a separate function and put the function under ifdef
> (providing a stub otherwise). Having #ifndefs inside funciton body is
> frowned upon.

Hm, this looked quite sparse and straightforward, but I can do that.

[...]

>> +/* As of SM8650, PCODE on production SoCs is meaningless wrt the GPU bin */
>> +#define ADRENO_SKU_ID_FCODE		GENMASK(15, 0)
>> +#define ADRENO_SKU_ID(fcode)	(SOCINFO_PC_UNKNOWN << 16 | fcode)
> 
> If we got rid of PCode matching, is there a need to actually use
> SOCINFO_PC_UNKNOWN here? Or just 0 would be fine?

The IDs need to stay constant for mesa

I used the define here to:

a) define the SKU_ID structure so that it's clear what it's comprised of
b) make it easy to add back Pcode in case it becomes useful with future SoCs
c) avoid mistakes - PC_UNKNOWN happens to be zero, but that's a lucky
   coincidence

We don't *match* based on PCODE, but still need to construct the ID properly

Another option would be to pass the real pcode and add some sort of
"pcode_invalid" property that if found would ignore this part of the
SKU_ID in mesa, but that sounds overly and unnecessarily complex.

Konrad

Konrad

