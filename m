Return-Path: <linux-kernel+bounces-86351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF7D86C449
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27B11F24F26
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBD454BFC;
	Thu, 29 Feb 2024 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGtnU4jw"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592A354FB3
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196905; cv=none; b=oa9eLewkleo61taOvUVDhVDQoXo1tPv9hN5dXMTcEiXqj05vdqxKZe8+ueJKN2/4P5tFdAY6U65Bxzg5l9rsDbbsqxXLCYUGt5SJmiPn8QRCCg6ANv5VA2loMt4x0PaLEOnUgSMNjL40dgfSqpfA1Klrvp2yQsrfUBxXaOUX/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196905; c=relaxed/simple;
	bh=uluz/TMXAdWyvD9rEkUpkGLQATNqVeyl49P41KHktQI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Oe5a7Urq3Zc61GIPfvJ+qXuAhLSOpBRAkZ761Hpz6mrTpQk+1lWg89gF+scrLsoolc3OmaIXtnNj+c6NYvvZ+nYWg6fYsvSeqezJTEGvKDJtRbbPkCwIKEj7nbYlwRv8UQcjG52BKuvbRlE2R6hOOAxG0xgpQLYqRNhtPABDgoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bGtnU4jw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412a9e9c776so10595425e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709196901; x=1709801701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bywCsrw+XZLoeXDHPoYCv95po2j/Way1FVc9H/uzC18=;
        b=bGtnU4jwhklmKNZFseGnWMrGYzmXz3Q8q11AlUvQH3uq3fC/XLbeVHGTjQBXoc7VEG
         VWoEBNGfMpHgTERR4kGauxYwIDcg1prYedpV0fWBkrdD9mhUrInVnKcgYdxx1HJEsbIS
         hbuIyFwXk6IXeFdFKJzi4onkKS5LkUoSvB50xHtCMOQGJPHmf93PJTD4YeSiR3ahxix6
         5DYHCwcdzx4IyeSNfvRG8G+MJsmeWwBgCZ9aXuLG/7H2wBXiCSJoZ9t/xkK1uQiCjWGv
         A6P2vq2inO5NzM3VFvxWnE3utotXlpmUagqVafmwbWjq+71iS5Y4b+UG/nkr+zpo8r1n
         tZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709196901; x=1709801701;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bywCsrw+XZLoeXDHPoYCv95po2j/Way1FVc9H/uzC18=;
        b=EpAYnrNfHbGEtP6il7svJPXPCjA/7vr/7oaXZK4fWCIrpBj0rON9P2ZiVdo+E+NcZJ
         9sH9PBuDBN2s5sMYNjJE9SmV9GEW/npUkvsmaZILLp/r2pqFlbTFi0Ab0TG0AQ4oTrbK
         SgctOxeDGtggrHu470Z4tfaQR5x9i5bkyKLV0jPZ+P693yuRi0I4Rl9FxHOR3Z14HRbl
         cUuvvFzPlkRSrRCQK7KyfqkoF/D5yY/BA+0GDf/KopjRMulIqpIPh0DJEyaowby2EHsW
         jIVNDvtnNgcLIE7/14sye7eD6VIbfKvBIXQTBRLkSLfsE3zJgi+GAo2tgO7hsRH5DVWi
         1Bhg==
X-Forwarded-Encrypted: i=1; AJvYcCWn8lMVlf7/qYuUyT6mRyQZgA0CS+W/KFMLeta6Xp5nMvtNJQ+rBeuYnOU4VkySVspbnz0B1uOu8v+H5VgQ4pZ7Oq17KS8T0ORITBgJ
X-Gm-Message-State: AOJu0YxDSieFf7Yi+hABb1835vQbRMKmqBsqSvT4QBZvwXyUyKLCj3uA
	zLzbPRKCxJPiPntwb5QQUrAS8G+fw19ER+HWS2/RaxinI6JePTvxz0fDQVdZbi4=
X-Google-Smtp-Source: AGHT+IGhwBfki4H2etcVqI2wWOlCAK4Oa7uGbH0TNjA60QSjyGlk9/cDjceeJdn4BFzAS7udycYwbA==
X-Received: by 2002:adf:a308:0:b0:33d:608c:da8d with SMTP id c8-20020adfa308000000b0033d608cda8dmr903741wrb.9.1709196900689;
        Thu, 29 Feb 2024 00:55:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:651:5318:b12c:be82? ([2a01:e0a:982:cbb0:651:5318:b12c:be82])
        by smtp.gmail.com with ESMTPSA id bp16-20020a5d5a90000000b0033e0567e90bsm1200056wrb.5.2024.02.29.00.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 00:55:00 -0800 (PST)
Message-ID: <23832e29-5bf4-4dab-ac00-4a4090233c3f@linaro.org>
Date: Thu, 29 Feb 2024 09:54:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] dt-bindings: Add Crystal Clear Technology vendor
 prefix
Content-Language: en-US, fr
To: Conor Dooley <conor@kernel.org>,
 =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?= <jeremie.dautheribes@bootlin.com>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Yen-Mei Goh <yen-mei.goh@keysight.com>
References: <20240223134517.728568-1-jeremie.dautheribes@bootlin.com>
 <20240223134517.728568-2-jeremie.dautheribes@bootlin.com>
 <20240223-prepay-stadium-f09044e3e123@spud>
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
In-Reply-To: <20240223-prepay-stadium-f09044e3e123@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jérémie,

On 23/02/2024 19:22, Conor Dooley wrote:
> On Fri, Feb 23, 2024 at 02:45:15PM +0100, Jérémie Dautheribes wrote:
>> Update Documentation/devicetree/bindings/vendor-prefixes.yaml to
>> include "cct" as a vendor prefix for "Crystal Clear Technology". CCT is
>> the vendor of the CMT430B19N00 TFT-LCD panel.
>>
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> And add a
> Link: http://www.cct.com.my/
> as that actually explains why "cct" is the right choice.

Can you send a v2 with this change ?

Thanks,
Neil

> 
> Cheers,
> Conor.
> 
>> Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
>> ---
>>   Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> index fef2e12b504e..96e47742e250 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -248,6 +248,8 @@ patternProperties:
>>       description: Catalyst Semiconductor, Inc.
>>     "^cavium,.*":
>>       description: Cavium, Inc.
>> +  "^cct,.*":
>> +    description: Crystal Clear Technology Sdn. Bhd.
>>     "^cdns,.*":
>>       description: Cadence Design Systems Inc.
>>     "^cdtech,.*":
>> -- 
>> 2.34.1
>>


