Return-Path: <linux-kernel+bounces-158145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372958B1C23
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71FA4B2508B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA246EB58;
	Thu, 25 Apr 2024 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiLEZv0/"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B167A1A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031258; cv=none; b=oI4kJXF9g1HrP3xDHZKIrHd31Wsvpm8kVvsUI46Zo46SjnscZjkALy3wkeJGzZobq4EAjvstVJrjTbRJb2ixSXajEzNVt3n/yo/jaTRoMuJ8zu7otM9zBzkkx2Y5MuoCdnRGVZ/V0fFSFnl1A/M2yVw1djqnlLCtrxeJwikzgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031258; c=relaxed/simple;
	bh=iAHuugcSZ7gNPb/Zbw8nWBC0N1+7iJ0C+P+QylIbZeI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=j8TaU1ratCHY/tLfKh/zIGkNY1KQPkmEUOYu9BoOMSYEE5K0MUKql8Jw3WUI7qcV2Lmqfnb2iadtUTgg5znKIYQCif6e1Mn5aQ/JQk00wjtlcz+83qR8rpIpp/VdLx/xKJIPdJz2vAgh6MrGTntjqeO0hxPXU8WGkpy8QdsC6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MiLEZv0/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41b4fd421c8so1577365e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714031255; x=1714636055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPJqdD/Tzg33ESGXWGEoqq776wvQs8gtsYLZyLqRGzk=;
        b=MiLEZv0/6U0i4DDNEjAOPSBy5yEQ2ACgSdUsahVRPVIvcy1j/1RD4VYsuzkxfsCC9C
         3jSsOX0rwowBgrnbr8B2+LkmX+YMwemh1YpgUJQlpYIZaCEsi60t47Zria5RC041CnoY
         jVVZZPJto+uhdn+zwuRYezh+CmlM4HMyJ0W2W7kauLkki9pjvjdgUnKBdYVP5usRPvVA
         D0XyAPygqnsrajisQQubFALcRMb2KlLHaJ8lcYDie2kR0a1/jvqIz+nHx2csNFijKGum
         Xy7qqwGG+QfLdGxudbXP/St6zgoSCRs3iispAru8qM3l5+4WznVJUePeo7lF8dxIY2HL
         9Gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714031255; x=1714636055;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wPJqdD/Tzg33ESGXWGEoqq776wvQs8gtsYLZyLqRGzk=;
        b=PKJrMMThrdDZiT5vj/OPZQbJXBQKpkUmlQsINlI1tI9OtJXrrk+1bJEQ6kQIBorbZJ
         uKW9fHF9kGnYDOCKNC9KlpJaGkghB/wPtIgayftLFJtLJyBs45+J4drIWrkeSRMTYlKv
         69w1xsebImvFb1Rie0PwbC9sbC7GnkSbr4Mv7m6I2yIhjwIqKU3XL+DALKDe+RpAIUxZ
         K6tgABmMQk4vhpkDjl/8UIxVorbecdxWJmTIWVUjHJ/Crl/MtgfVLhFGzw+Bd39Y+7nm
         k4E3vPAfJ5ifwIrfAovUQXGtXLxLhA6IF/IhA0rrWxw/NMoy6KWl2kjLQphlChbWVn8c
         hD0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwuz0wqQ9C6xntKLifvFE1Euz8XiYa0ETwKf4T20TxdOUTxdlChXc5lWLx7hFU5WYbgO8XsEusRNSHMR1RiIX7czLTFZo1FuDgTzcz
X-Gm-Message-State: AOJu0YzNDcWiW1Xta2kCQJDjze3np5hd3UZENIjRvoplNdJrLJ6ZPNJi
	4A8oCE//ipXGko6PIXJg5+WNTOEuqSeEgo0BsIoQnEwzgj4PFlVDR1z4nZaSb6Q=
X-Google-Smtp-Source: AGHT+IGttzD9sok4hMZTxcAKeLHuq311JK4wtR4ABqpIEMGOh2yM6/pg2BssKk4024XY4L3VCE4gqA==
X-Received: by 2002:a05:600c:3b8e:b0:41a:aa6:b68c with SMTP id n14-20020a05600c3b8e00b0041a0aa6b68cmr3882881wms.6.1714031254803;
        Thu, 25 Apr 2024 00:47:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15c7:bd9c:c500:ed62? ([2a01:e0a:982:cbb0:15c7:bd9c:c500:ed62])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c4e4600b0041b43e301e8sm1384692wmq.42.2024.04.25.00.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 00:47:34 -0700 (PDT)
Message-ID: <16de57e6-39c1-4528-b9a7-8b8af2ec6880@linaro.org>
Date: Thu, 25 Apr 2024 09:47:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] drm/bridge: chipone-icn6211: drop driver owner
 assignment
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240330202741.83867-1-krzysztof.kozlowski@linaro.org>
 <ul5vzz54kppxo6zkr7k6seejmmlgp3d4dqfzjlj5la3e5ltolo@ug5dtoknkibu>
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
In-Reply-To: <ul5vzz54kppxo6zkr7k6seejmmlgp3d4dqfzjlj5la3e5ltolo@ug5dtoknkibu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 24/04/2024 11:12, Dmitry Baryshkov wrote:
> On Sat, Mar 30, 2024 at 09:27:40PM +0100, Krzysztof Kozlowski wrote:
>> Core in mipi_dsi_driver_register() already sets the .owner, so driver
>> does not need to.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   drivers/gpu/drm/bridge/chipone-icn6211.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> 

I tried to apply them but you already applied them... could you make sure to notify the list when applying ?

Thanks,
Neil

