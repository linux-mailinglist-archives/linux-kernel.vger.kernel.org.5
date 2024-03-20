Return-Path: <linux-kernel+bounces-109146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9A8881545
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F322A1C22D56
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADB155C3E;
	Wed, 20 Mar 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nRmMq1l4"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7A054FB7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950990; cv=none; b=Er2t3534TK4a7eo0fJRmbY/K5eXHeU/DHJ2aL2S6TryvHK+8FuVXpLHC81eUYwtNhnq3pYOxbDe/0Bh9XazkIJ/KFXuY87y3BK9kHAemTduljodjtldZIbnOxEwqhuMK6hDXeUJIGUAzp+rSaQiXHXVUL+ifHdiyifkbrz6LzDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950990; c=relaxed/simple;
	bh=Ek7uPBqyGIGGUJv1iralbPzzoloSPaePGC1EbKWFHfc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oWVqgYWABKUz2udVpjUmCcQRAKXknMz3ZZ8ZauXyp32IRo1AjhIDB62W1Mn2VT6kVaUR6hQPaBdaqbJqNm/BwBP8y/I0PS2ATyn+blLoKmZ7EwnsWwvHh3g5YBFiT98ArPAqod1xsEQ89Gf9Jq9WNgfIssVsKv/lKMgsd2oiEiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nRmMq1l4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4146f2bf8ecso2598835e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710950986; x=1711555786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Un+llHAoMrdFl+P+AaI+WdI4X8MRX2yHvC9/wPwSiTw=;
        b=nRmMq1l48JG2tSEIGQnMjXbnIqwpfphe/pOpJwXM7hEG8i0t6KArqBOPplFB5jUvXq
         R1bucIermyx3Eu42jf7XOZYlimPZANaX+mMcmlrNhMFElkOAVuMrnog5DsDKM+nanhwC
         GImM8Hfbv2WjjdWfRgPO2Zwu4+9V4BVqWOiI1ApI18KiDh8z4fWrUA6gyDO+JdXEDgWb
         V5tBnG8M/SMC9TlVy4XblyG+eWTca0fywL22+v840Ubzjp2xH3VuopIQA5+O7JB44MUf
         vL/KTxS9ivqnQxYHBAM4DB9FgQWYZlOTZgQLY93Of7HB+DeqAh9RxsUJif8Gkz5Si3+k
         fDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710950986; x=1711555786;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Un+llHAoMrdFl+P+AaI+WdI4X8MRX2yHvC9/wPwSiTw=;
        b=Cg5ZEdIsvYUJB62lP1A7zKTl703t/2WMeSjF+TkF9PRbR62D0/NrzGAr+ksnItW9h1
         rzIJb9b2lVsPz5bYDSzvB+sUCq9HwdNen7alHZxApfxrCljcTSZmOAt09jHjy7cKCqIB
         dFBql6L//Lmuv0Rv6mwo7OeofNmxMfDY0yNuyd6Q0g0ECL7DxtJyHSVplquTEvpntdoz
         OoNicHEN5Bk71D3duyU7YfBjCoNCgBm/SwX2VlFvmYeQeAGvcsk5j0VgtG6fNeU2VKxh
         qbkr59B8Y29uSs3A1ZYP1XZGkKJ1o/Ez2Y717kRTIbjFrH0dUgkkGm6y4KcWdK+4pVME
         c7yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz2xeO+bZFhQqP1sHHmvwaiB3IBzIAd06j/2cZ5AV+lXNZqftU/KAL9VTtDU+0uQdj0IhsYGlKJkObBHq399fdXp/Vt0QysNipXgPH
X-Gm-Message-State: AOJu0YxBx7KaAKTf5veNX3YBRXugHbG+s3znAQs4KYh4FhYVXydpwVZY
	kqNX5A1+dbm3jPeaQDy+OfyYeAYt7FilanhymcMmER1LoMpGTme6oFrpvxdj2hn5wPdriEb81vM
	M8Ho=
X-Google-Smtp-Source: AGHT+IGwlgkNcQfHchLSVvAQXtFi8Dw1HoghSxCI8lwBRMqbAhnbx+HiiUQX1ndX7cQHgHU8Q0sWhg==
X-Received: by 2002:a05:600c:3c86:b0:414:286:fd1f with SMTP id bg6-20020a05600c3c8600b004140286fd1fmr9845788wmb.11.1710950986293;
        Wed, 20 Mar 2024 09:09:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:13bb:18cc:75cc:ae59? ([2a01:e0a:982:cbb0:13bb:18cc:75cc:ae59])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b004146f728906sm686840wmq.7.2024.03.20.09.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 09:09:45 -0700 (PDT)
Message-ID: <dbdc34a0-bead-491e-a0fb-2f74416b7366@linaro.org>
Date: Wed, 20 Mar 2024 17:09:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: atna33xc20: Fix unbalanced regulator in the
 case HPD doesn't assert
To: Doug Anderson <dianders@chromium.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240313-homestarpanel-regulator-v1-1-b8e3a336da12@chromium.org>
 <098d8dda-75fe-45b8-ad36-a21ed44c4555@quicinc.com>
 <CAD=FV=WE4Y1Nk8UL+z7fLsU=zr-Y_2vQe0xuBSbg8_1CLRQjYQ@mail.gmail.com>
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
Organization: Linaro Developer Services
In-Reply-To: <CAD=FV=WE4Y1Nk8UL+z7fLsU=zr-Y_2vQe0xuBSbg8_1CLRQjYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/03/2024 16:33, Doug Anderson wrote:
> Hi,
> 
> On Thu, Mar 14, 2024 at 3:32 PM Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>>
>> On 3/13/2024 2:12 PM, Douglas Anderson via B4 Relay wrote:
>>> From: Douglas Anderson <dianders@chromium.org>
>>>
>>> When the atna33xc20 driver was first written the resume code never
>>> returned an error. If there was a problem waiting for HPD it just
>>> printed a warning and moved on. This changed in response to review
>>> feedback [1] on a future patch but I accidentally didn't account for
>>> rolling back the regulator enable in the error cases. Do so now.
>>>
>>> [1] https://lore.kernel.org/all/5f3cf3a6-1cc2-63e4-f76b-4ee686764705@linaro.org/
>>>
>>> Fixes: 3b5765df375c ("drm/panel: atna33xc20: Take advantage of wait_hpd_asserted() in struct drm_dp_aux")
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>>    drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 22 +++++++++++++---------
>>>    1 file changed, 13 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
>>> index 76c2a8f6718c..9c336c71562b 100644
>>> --- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
>>> +++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
>>> @@ -109,19 +109,17 @@ static int atana33xc20_resume(struct device *dev)
>>>                if (hpd_asserted < 0)
>>>                        ret = hpd_asserted;
>>>
>>> -             if (ret)
>>> +             if (ret) {
>>>                        dev_warn(dev, "Error waiting for HPD GPIO: %d\n", ret);
>>> -
>>> -             return ret;
>>> -     }
>>> -
>>> -     if (p->aux->wait_hpd_asserted) {
>>> +                     goto error;
>>> +             }
>>> +     } else if (p->aux->wait_hpd_asserted) {
>>
>> Hi Doug,
>>
>> Acked-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> 
> Pushed with Jessica's Ack to drm-misc-next.
> 
> 5e842d55bad7 drm/panel: atna33xc20: Fix unbalanced regulator in the
> case HPD doesn't assert
> 
> I chose drm-misc-next instead of drm-misc-fixes because this isn't
> super urgent and the patch would have to be modified on drm-misc-fixes
> because we don't have commit 8df1ddb5bf11 ("drm/dp: Don't attempt AUX
> transfers when eDP panels are not powered") there.

Thx I wasn't really sure where to push this so I waited v6.9-rc1 to decide!

