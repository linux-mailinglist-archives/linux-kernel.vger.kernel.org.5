Return-Path: <linux-kernel+bounces-146007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD29C8A5E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCFF284D19
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29711159204;
	Mon, 15 Apr 2024 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyRC99q/"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF4158DDD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223861; cv=none; b=nTEdv8bpFBO6TtXu6wOHxJ4f6nL8nzNVeNbN9sXIcA8MlI++vVeiFlDHjprGJkth6wvn84ddcSmjN+08+usX/K7OSoRaEVm5pmIROPgxXbW5kZWdx96B8rwMWY3YBSpmLvTcdkUa8VTKky5mqadfDPRrXugvgDZW3J+azlE7H1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223861; c=relaxed/simple;
	bh=+b/kNZ4RcVokUqEMiWdeS9E1tYrTetsBur7rJILc1qo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jnUNztev0aJ+LTmEpL+Uw+pawDdGQy5HkwBv9evdw4py9mBL8HjVdVY9VJ/9aoQxofk0729ROBKIK4PO8QaaozPLGt92+5fKWZ31hzfHGsOg4loTx5lpTmAFSyLhbAZzTZQFigJ+R8LPLyCIAfAsFBBQ72VZ/z4OA0j97ozaHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YyRC99q/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41550858cabso23855175e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713223856; x=1713828656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbgOogGrd7KneMj6zTYHK/GfLd8TwApJl8NSTb8SGlA=;
        b=YyRC99q/bbnFHUilkatOkVNSaDlY7zYsVqOfSNLhik+gz28m7R2IOtIormtPWtFeS7
         J32TEktrs/N9Xw8CI4dXGNYXGnnICHZBPs9PmMnSMXrx1NxorNqYUCTLxkg0VgL468+9
         4Ttg9lVb2Nj6T5633hTFbjLJHAaiRVz+d2AjvbDSLI24raXZ9im33IMSHr5vTGlPVMHF
         5XppQX1UoVjS00egvBRt5zfWv/4LZS6UUpYqSZ0qtYSQpcVDp8AQvdZza34XE0SgyRl0
         MhjN5UyhMPMy61ts4cBfUkGEuNXB8zV+gsR14wyvX4J3ehW30EQPYpobFyGfT9LLEW8R
         ZrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713223856; x=1713828656;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sbgOogGrd7KneMj6zTYHK/GfLd8TwApJl8NSTb8SGlA=;
        b=LpV0rHeLUrUc7tIdiqlKkEV9+9jfXJDwL3/bGvNaq1vUEId+XXxDnU0u5vsiywY6/m
         KC3itKeaa/UWYYDHjyPC7+RkZUNiIwUQdIJ1IXVAKf7GRrpiK/B68uPlc/jWBKaNTf3T
         9UOeCug74AD+eUNz0Ve+msVJq5eq3ott9NTsXOtFgMEb2Frt3k7HdyQmwTuPq1Ocvctl
         ZaeEuO2fRXUPeBuKkZMnYZeZpsnGXVD3Pz7mjO42y0ps+cHyREZKF4Xw/0keV+quUAC7
         J5jE7VxW4GMUc7xzzUHN+iMhM0rcDYUW7BVe/sICXF5DvoBmKY+yD8/zeo+op76C14hq
         x0jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXSNgsPLRyVDITHif6Kh6bStFNdzoaslbG9gYix1NHuv97Pwb7s57t/DeUYxvA48VuPwpOQIv1J/udC3sN0862s5fmWOmYdKxltZOL
X-Gm-Message-State: AOJu0Yy6nDzL6O4hud2mjSagMHhtlAWdnudQ+lO/Sc6rKrm5OCCzlxQT
	n5M+z1GfVeFHchvTmm1k4h3chCZPtm84itryeGHEsl3pHuACdus3sdfcrUeGuPQ=
X-Google-Smtp-Source: AGHT+IHg/fk42jw6rlYve+PtuNCjcIGhx+aS7sngMv/JYvGAT/GBkMZPb0po+xBYLkmZmcqsfyAR5Q==
X-Received: by 2002:a05:600c:5128:b0:416:3de5:133d with SMTP id o40-20020a05600c512800b004163de5133dmr8063687wms.7.1713223855973;
        Mon, 15 Apr 2024 16:30:55 -0700 (PDT)
Received: from [172.20.10.2] ([37.169.26.183])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d69cb000000b00346bf37c97bsm12811551wrw.63.2024.04.15.16.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 16:30:55 -0700 (PDT)
Message-ID: <64c765e4-698f-49d6-8d17-4b512c3dc8ec@linaro.org>
Date: Tue, 16 Apr 2024 01:30:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add Amlogic T7 Reset Controller
To: Kelvin Zhang <kelvin.zhang@amlogic.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zelong Dong <zelong.dong@amlogic.com>
References: <20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com>
 <20240329-t7-reset-v1-1-4c6e2e68359e@amlogic.com>
 <927ad2cb-3b41-4eda-b930-856be64ae9ba@linaro.org>
 <10650c59-96f2-4234-b5fd-aa8efec90e5b@linaro.org>
 <579a1569-7bba-491f-ba5e-7cfcb34ccc1f@linaro.org>
 <c7e243e3-3f61-4d63-8727-3837838bdfcc@linaro.org>
 <48005005-54ad-473b-826d-23b0b3f3a52c@amlogic.com>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <48005005-54ad-473b-826d-23b0b3f3a52c@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/04/2024 12:31, Kelvin Zhang wrote:
> 
> On 2024/4/13 02:03, Krzysztof Kozlowski wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On 12/04/2024 19:57, Krzysztof Kozlowski wrote:
>>> On 12/04/2024 15:12, Neil Armstrong wrote:
>>>> Hi,
>>>>
>>>> On 29/03/2024 20:39, Krzysztof Kozlowski wrote:
>>>>> On 29/03/2024 10:17, Kelvin Zhang via B4 Relay wrote:
>>>>>> From: Zelong Dong <zelong.dong@amlogic.com>
>>>>>>
>>>>>> Add a new compatible and the related header file
>>>>>> for Amlogic T7 Reset Controller.
>>>>>>
>>>>>> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
>>>>>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
>>>>>> ---
>>>>>>    .../bindings/reset/amlogic,meson-reset.yaml        |   1 +
>>>>>>    include/dt-bindings/reset/amlogic,t7-reset.h       | 197 +++++++++++++++++++++
>>>>>>    2 files changed, 198 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>>>> index f0c6c0df0ce3..fefe343e5afe 100644
>>>>>> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>>>> @@ -19,6 +19,7 @@ properties:
>>>>>>          - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
>>>>>>          - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
>>>>>>          - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
>>>>>> +      - amlogic,t7-reset # Reset Controller on T7 and compatible SoCs
>>>>>>
>>>>>
>>>>> If there is going to be any resend, please drop the comment. It's not
>>>>> really helpful and makes it trickier to read.
>>>>>
>>>>>>      reg:
>>>>>>        maxItems: 1
>>>>>> diff --git a/include/dt-bindings/reset/amlogic,t7-reset.h b/include/dt-bindings/reset/amlogic,t7-reset.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..ca4a832eeeec
>>>>>> --- /dev/null
>>>>>> +++ b/include/dt-bindings/reset/amlogic,t7-reset.h
>>>>>> @@ -0,0 +1,197 @@
>>>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>>>>>> +/*
>>>>>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>>>>>> + */
>>>>>> +
>>>>>> +#ifndef _DT_BINDINGS_AMLOGIC_T7_RESET_H
>>>>>> +#define _DT_BINDINGS_AMLOGIC_T7_RESET_H
>>>>>> +
>>>>>> +/* RESET0 */
>>>>>> +/*                                        0-3     */
>>>>>
>>>>> I assume this matches existing drivers which do not use IDs but map the
>>>>> binding to hardware value? I remember we talked about changing it, so if
>>>>> something happened about this and it could be changed: please change.
>>>>
>>>> I'm not aware of such discussion, and I don't really see the issue...
>>>> thoses are IDs, and yes they match the Hardware offsets, and ?
>>>
>>> Bindings are not for hardware offsets/values/addresses. It's just not a
>>> binding.
>>>
>>> I quickly looked at your driver patch and it confirms: not a binding.
>>> Binding constant is used by the driver and DTS consumer.
>>>
>>> I am really sure we had this talk in the past, but could be I think
>>> about different platform. Since this is not a binding, I do not think
>>> claiming there is any ABI here is reasonable. Feel free to store them
>>> with other hardware values, like in DTS headers etc. We already moved to
>>> DTS headers several such "non-binding" constants.
>>
>> Un-acked.
>>
>> I looked at my archives and we did talk about it and you were CCed:
>>
>> https://lore.kernel.org/linux-devicetree/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
>> simple-reset is an exception.
>>
>> So to recap:
>> That's not a binding. Don't add some real values to binding headers
>> because it is not a binding then.

So what's exactly a binding then? random linear numbers that means nothing can be a binding
but registers numbers can't be ? why ? I still don't understand, why this suddenly gets problematic ?

>>
>> https://lore.kernel.org/linux-devicetree/CAK8P3a1APzs74YTcZ=m43G3zrmwJZKcYSTvV5eDDQX-37UY7Tw@mail.gmail.com/
>> https://lore.kernel.org/linux-devicetree/CAK8P3a0fDJQvGLEtG0fxLkG08Fh9V7LEMPsx4AaS+2Ldo_xWxw@mail.gmail.com/
>> https://lore.kernel.org/linux-devicetree/b60f5fd2-dc48-9375-da1c-ffcfe8292683@linaro.org/
>> https://lore.kernel.org/linux-devicetree/418c5f0c-5279-41f5-3705-345ec9a97ea2@linaro.org/
>> https://lore.kernel.org/all/201401111415.29395.arnd@arndb.de/
>>
> Got it. Will delete amlogic,t7-reset.h and use the hardware numbers
> directly in the DT. >
> Hi Neil,
> As you know, Amlogic reset controller is divided into several groups: reset0, reset1, ..., resetN. I'd like to discuss the rationality of splitting the one device node of reset controller into device nodes according to the groups. Then we can use the bit number within the 'resets' property.
> reset0: reset-controller@2000 {
> ...
> };
> 
> reset1: reset-controller@2004 {
> ...
> };
> ...
> 
> What do you think?

No since you'll basically add a node per register, you need to add a node for the while reset HW function, another
solution would be to split the phandle arguments in 2, the first first would be the reset bank, and the second one
the reset line for the bank.

But still it's a regression in readability to drop the macros, until gpios or pins the reset number doesn't mean anything per se.

Neil


Neil

> Thanks!
>>
>> Best regards,
>> Krzysztof
>>


