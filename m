Return-Path: <linux-kernel+bounces-67348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9BA856A40
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447CE1C21CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174BF1369A8;
	Thu, 15 Feb 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="inbob8dm"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CB513699D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015991; cv=none; b=dp5/oz5wHxfWSWaWG2iKUn4uH9O2RrvhO12uFlzGU8Rz/FpFmxUEm9JZlOSZavvQLlu/nnCyRDBg9+GgGQdVF66IobfjgYRaPbneQlqBfWVmD0FIK6An/oGJHbzK8IiFq1QyWM0Qxyy7R39EQ3ALGNBZpKizp5UBE5Ne/z5HpPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015991; c=relaxed/simple;
	bh=IyYGjPhYNCPd0sxBKQKnhLHOEuzMo9MrbffUNR7qW8Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hzv5xRxMm18bNKqupNG3MT90zEmAqhnY3vegS9DOkAeRCW6M0HKSluLpw5LHb6gztIwh1IPdX3tC377EzS3ikwDvZYezJRNB5XJ7JztvKUL5bFGVuqpNXOCohLj3r5bnpJ4mqDDE+RjpFH3Y5Z3f7UdjodeXSTasPomGL4CSKeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=inbob8dm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4122acb7e56so3666375e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708015987; x=1708620787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfGWiGhKRU3uSSuobW+BB20XjEyAiHEhpvntN7DeWYM=;
        b=inbob8dmTzvx1cf2njlbUBc+SaS+lyISiUxC/xwc9Ew4EJ6Jg02jUrkxoFF+2ecxaq
         6Z4vQJHVbvyJ12b3WWxl2FhUgtgEE7yQhIWmuAO3KExHJqhBX6Uc3+ZNWm0SYkd2I3Dm
         z1CSqXDzKecD1yRzI7PDoY8XpBPGz1IGI3nsbJ+wk0yTeABsAqVn5xez32IjLayygEAw
         IZleCZtnQweCcFWJ2xctLwIVddKFEuHm8OuS5ZXUsndt5p/eX9orJyEuNqZ+IPeSRSUU
         E7HpZDvQGeu9huxBGs8G5i1ZBH2GUx8MC/2q3blOM0oVz77dpxK7ALu1SNty5sisG5F0
         NTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015987; x=1708620787;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cfGWiGhKRU3uSSuobW+BB20XjEyAiHEhpvntN7DeWYM=;
        b=IG82etAwa2C/4hs0unbpO5GmbQEgZvlwxXPCKzjxo11mzd2NWiI3f0uTbtrKV2JNsI
         h7qebUQHN4cqU3rABawH7yEz/a3zLrfqcC/c6VhFyr+iFZEK8+nbByfIwKpahhdrtwZ8
         xr0BcrXjHI99p3p1fDSRkAr3SmhvTvstxhFjCBaXCgyTRg8iUbl66Owb48cXQLwYXdl4
         jkdOv5hHlOTDBiMlfLr1RL9iLuagRrjOP+41UvER+ne5N/sTH9EgkK0FlaFEFv90vGoC
         YMlmf0TVNG2ozKutSG5xERdPR8T0dZb4ZWTsOSdxp7rwjGaPScffmTjEYRfRIZQWYbT/
         KZCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFa7v1JnxeFiA3XZzZrdu6u/cuvnlddefpO4j4xEtcFPjPcs8iIN0MQ/tmornGJzx+tUYJ6pMFfrpLZJpX7nJKb/zjcnrbXR+38LNm
X-Gm-Message-State: AOJu0YyvWfIF4/EEa0b6HZsMXtNKwJ+TBe9Ux/9Yv8USet0mQ7a17liJ
	p/FSq5ZNsDPRjq2dLYR45ZEHSAg/QhxaXqkSQ9j9tQVwJJekyKYSJLKu4pHQTlA=
X-Google-Smtp-Source: AGHT+IFv7zi2DukcZo5wAwXtWvb+A2E442R4EoH2HTJoL6C/0T7GiRiP0JdL5ZjRPZAQO/QaQaCHew==
X-Received: by 2002:a05:600c:190f:b0:412:1998:e250 with SMTP id j15-20020a05600c190f00b004121998e250mr1372368wmq.27.1708015987362;
        Thu, 15 Feb 2024 08:53:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7555:8187:c6f1:9c02? ([2a01:e0a:982:cbb0:7555:8187:c6f1:9c02])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bcb96000000b0040fafd84095sm5482931wmi.41.2024.02.15.08.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 08:53:07 -0800 (PST)
Message-ID: <cbcd981f-bd5d-477e-8482-d3414be17057@linaro.org>
Date: Thu, 15 Feb 2024 17:53:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/dp: Don't attempt AUX transfers when eDP panels are
 not powered
Content-Language: en-US, fr
To: Doug Anderson <dianders@chromium.org>, Jani Nikula
 <jani.nikula@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, dri-devel@lists.freedesktop.org,
 eizan@chromium.org, Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Imre Deak <imre.deak@intel.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
 linux-kernel@vger.kernel.org
References: <20240202141109.1.I24277520ac754ea538c9b14578edc94e1df11b48@changeid>
 <CAJMQK-it9YMod4rHKnACq4O-iaGieK2SN4x5vQ018CghsA631A@mail.gmail.com>
 <CAD=FV=VfuFrK1cSKA0maMzT5dxzKEzADqrd69fZKXuAGrU2rmA@mail.gmail.com>
 <87sf1u58k0.fsf@intel.com>
 <CAD=FV=XQdLm3PcjEd_g_dBJ9QO8zAJtj5nrXS9=cjC80+-Jbfg@mail.gmail.com>
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
In-Reply-To: <CAD=FV=XQdLm3PcjEd_g_dBJ9QO8zAJtj5nrXS9=cjC80+-Jbfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Doug,

On 15/02/2024 16:08, Doug Anderson wrote:
> Hi,
> 
> On Thu, Feb 15, 2024 at 2:24 AM Jani Nikula <jani.nikula@intel.com> wrote:
>>
>> On Wed, 14 Feb 2024, Doug Anderson <dianders@chromium.org> wrote:
>>> Hi,
>>>
>>> On Tue, Feb 13, 2024 at 10:25 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>>>>
>>>> On Wed, Feb 14, 2024 at 2:23 PM Douglas Anderson <dianders@chromium.org> wrote:
>>>>>
>>>>> If an eDP panel is not powered on then any attempts to talk to it over
>>>>> the DP AUX channel will timeout. Unfortunately these attempts may be
>>>>> quite slow. Userspace can initiate these attempts either via a
>>>>> /dev/drm_dp_auxN device or via the created i2c device.
>>>>>
>>>>> Making the DP AUX drivers timeout faster is a difficult proposition.
>>>>> In theory we could just poll the panel's HPD line in the AUX transfer
>>>>> function and immediately return an error there. However, this is
>>>>> easier said than done. For one thing, there's no hard requirement to
>>>>> hook the HPD line up for eDP panels and it's OK to just delay a fixed
>>>>> amount. For another thing, the HPD line may not be fast to probe. On
>>>>> parade-ps8640 we need to wait for the bridge chip's firmware to boot
>>>>> before we can get the HPD line and this is a slow process.
>>>>>
>>>>> The fact that the transfers are taking so long to timeout is causing
>>>>> real problems. The open source fwupd daemon sometimes scans DP busses
>>>>> looking for devices whose firmware need updating. If it happens to
>>>>> scan while a panel is turned off this scan can take a long time. The
>>>>> fwupd daemon could try to be smarter and only scan when eDP panels are
>>>>> turned on, but we can also improve the behavior in the kernel.
>>>>>
>>>>> Let's let eDP panels drivers specify that a panel is turned off and
>>>>> then modify the common AUX transfer code not to attempt a transfer in
>>>>> this case.
>>>>>
>>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>>> ---
>>>>
>>>> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>>
>>> Thanks for the review!
>>>
>>> Given that this touches core DRM code and that I never got
>>> confirmation that Jani's concerns were addressed with my previous
>>> response, I'm still going to wait a little while before applying. I'm
>>> on vacation for most of next week, but if there are no further replies
>>> between now and then I'll plan to apply this to "drm-misc-next" the
>>> week of Feb 26th. If someone else wants to apply this before I do then
>>> I certainly won't object. Jani: if you feel this needs more discussion
>>> or otherwise object to this patch landing then please yell. Likewise
>>> if anyone else in the community wants to throw in their opinion, feel
>>> free.
>>
>> Sorry for dropping the ball after my initial response. I simply have not
>> had the time to look into this.
>>
>> It would be great to get, say, drm-misc maintainer ack on this before
>> merging. It's not fair for me to stall this any longer, I'll trust their
>> judgement.
>>
>> Reasonable?
> 
> I'd be more than happy for one of the drm-misc maintainers to Ack.
> I'll move Maxime, Thomas, and Maarten to the "To:" line to see if that
> helps get through their filters.

I'll like some test reports to be sure it doesn't break anything,
then I'll be happy to give my ack !

Thanks,
Neil

> 
> -Doug


