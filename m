Return-Path: <linux-kernel+bounces-66541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4A5855E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DAB1C2262F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F58817730;
	Thu, 15 Feb 2024 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bnrl+yuV"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7AE17551
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989403; cv=none; b=Ta7WWxuu0GAyTt/G/S/AAIS+MhORkYWfNlcmjUZSBjwBTrDm4A7ZfeklgNi2GsxvsJe+4zCUWfX4urEMzx/VJhqNyydW2UvmDeOsQn+AbfMnjom8eKanO3xjDIJR7iAsuvXVbTRqWd3EH0m9GjNMs9409YYBRuMDhYoD6m6EOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989403; c=relaxed/simple;
	bh=sD1bsJwMjAFQ13ViHkkmSIV96Jgd7fYEtMS8umuilg0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JWjNWpjviA6Mfk5UX4QE9+a166l9Mx1eYcFVTmOO5OTmZ5npS1sVdiUFZX5GKkCKbfX4F279E8v/kjbW47QcAip0ZdH/SH+R42cbLPNU8D/YONrMXLKtddgPqnhVT0/IEO1b6F9HSuQdv3TGtL0Z4LuzCJO+gUge0rArSKRq3N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bnrl+yuV; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d10ad265d5so8299251fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707989399; x=1708594199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmOpXYe614s1w+uX5FaR6Zt6hCQGhtbYPhMdt0CcCLo=;
        b=Bnrl+yuVCsqw4eTWMKo6rcjFfj4MQqkw+i/n6v+T8v8OCXrxgUBuKMVqLmaHDya5eH
         3VBmEe0SCvNmIdoAE8KSgUBLeN6Zg42DSTF599MyMWXG6RfzAlbRzgEl5r85hXiZeelU
         mYaSjXHG+ExizlKAMBBKdtXaq3UjA6zx6kpnN0FHlzIcBUxkV8D1CzHTFKR1xF3z5XjA
         Vj5gKrFfdFfBqr+SNTaVp8c778+eO8cMRx+CQcRGEousHUs2jXYvnRjKGX2UGP+YgpBg
         Z0GELztWnJvDypduvVMPc1vsQYeRe+cy42cWKl2EvbgOM0l40ujNS/d1dEc14jmFc49x
         KOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989399; x=1708594199;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VmOpXYe614s1w+uX5FaR6Zt6hCQGhtbYPhMdt0CcCLo=;
        b=AcrBFAE4Y9mm+LPy9oNDzSNYJXNwxb3XgeJe8Iv/pdOJeHK8Ur0uxhFu8ZwzlvKIV1
         Q01b8uG5l2z35HJF2d8btKgbG/8j76ceKyDUIlFE+UEoIywbfeEBH5Kk0xZZ9nAbFMag
         yFqaF9OPRy3ezHDSxdtIB1hB+yf8hREBgEmoMQaeFsq7/qVY/1QdZx/zwNDyYwzT6yC2
         6vxC+AzkQWODrrah2apMYs/iAHIIAQjH2LwAHWLi6Wq8yKolemMR+9Ka0+BbDGongYJ9
         j/0wFFLMlGxBjy0pdrYtF4wz5Cu76lDjocL+ZDxPLBSrkIfP+F8UekYsnNj7a9IoGuFm
         sZaw==
X-Forwarded-Encrypted: i=1; AJvYcCUipYjUbensAYjkAvuup+gOb0ZU0xqaG34cAP67ZJG4D3l5X5xrWqt8TknoUu1/yskKpDzwmdBpjXiR7WLsNRAWJ6X3u5Yf2Jp0AFlW
X-Gm-Message-State: AOJu0YzO2QuwU1jSSI9WelTZ3/8HBleT8/9hB8jWS9zgW8C8lrDHI8GO
	vE9sY47YLVLTz/7otv/kE28tZSa6+Kd10N5OS4TKCUeZWB/4HMBfng2ey2oh7Vk=
X-Google-Smtp-Source: AGHT+IEuFGqFxGBfmmBUmEzoDATve7jHeXbEQRCoqEiqnF8PVK28X2sVOXLp6dDGXz+4L0UUY8TwFA==
X-Received: by 2002:a19:ca01:0:b0:511:79ac:ec0f with SMTP id a1-20020a19ca01000000b0051179acec0fmr963353lfg.26.1707989398807;
        Thu, 15 Feb 2024 01:29:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:4589:7160:c264:fa3b? ([2a01:e0a:982:cbb0:4589:7160:c264:fa3b])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b004120b4c57c9sm1398694wmo.4.2024.02.15.01.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 01:29:58 -0800 (PST)
Message-ID: <ffb16ef6-fc9a-42b1-b9c3-4e8f6b52d849@linaro.org>
Date: Thu, 15 Feb 2024 10:29:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/6] dt-bindings: arm-smmu: Document SM8650 GPU SMMU
Content-Language: en-US, fr
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org>
 <20240215-topic-sm8650-gpu-v2-2-6be0b4bf2e09@linaro.org>
 <CAA8EJprpYEhGi5b+uWGWtOa+qbSwUR8C0j9NLC+ah_-nvy-=Ng@mail.gmail.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <CAA8EJprpYEhGi5b+uWGWtOa+qbSwUR8C0j9NLC+ah_-nvy-=Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/02/2024 10:25, Dmitry Baryshkov wrote:
> On Thu, 15 Feb 2024 at 11:20, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Document the GPU SMMU found on the SM8650 platform.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index a4042ae24770..3ad5c850f3bf 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -93,6 +93,7 @@ properties:
>>                 - qcom,sm8350-smmu-500
>>                 - qcom,sm8450-smmu-500
>>                 - qcom,sm8550-smmu-500
>> +              - qcom,sm8650-smmu-500
>>             - const: qcom,adreno-smmu
>>             - const: qcom,smmu-500
>>             - const: arm,mmu-500
>> @@ -508,7 +509,10 @@ allOf:
>>     - if:
>>         properties:
>>           compatible:
>> -          const: qcom,sm8550-smmu-500
>> +          contains:
>> +            enum:
>> +              - qcom,sm8550-smmu-500
>> +              - qcom,sm8650-smmu-500
> 
> Doesn't this cause warnings for non-GPU SMMU on this platform?

No because it doesn't add those to required, it simply allows clock the properties.

> 
>>       then:
>>         properties:
>>           clock-names:
>> @@ -544,7 +548,6 @@ allOf:
>>                 - qcom,sdx65-smmu-500
>>                 - qcom,sm6350-smmu-500
>>                 - qcom,sm6375-smmu-500
>> -              - qcom,sm8650-smmu-500
>>                 - qcom,x1e80100-smmu-500
>>       then:
>>         properties:
>>
>> --
>> 2.34.1
>>
> 
> 


