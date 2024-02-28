Return-Path: <linux-kernel+bounces-85392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D216E86B552
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AE01F26B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB6120B14;
	Wed, 28 Feb 2024 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYulpfDQ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700506EF0E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139134; cv=none; b=jaDWEhUWGq179g9Oh8GHlcrMqDKH5EiLOAzFsXf7BWORVbcbpvZPxJclDBqVvGqKP6d3SyuKS6+sxaSo2S384PsWKwzHrqoYxgVMXVdNeijx5vf+/VgBv/cNpmiBF1UzjhJlDYV3YBKkPwi9HAn//Dz34hjY8n3XyBUeCcnu66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139134; c=relaxed/simple;
	bh=hZjavC1d5KsXTVImzNF3ZHRRrkeQfF0vEU2wpm2WSCY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qvBA+PkvTrV/KQpvR3bsIWjfx8jK++uVbzDvQdNDelCcEksHtZRWmUOQYB4uuY7yFZBrP9MOyjw5eUwEXVFooazW4BJAM23IYGoQx6prCWq2vL9+yD+jFLWLXO0PlrI6JAf1/2k3mQtLsCY4iyszR6XRLXpSEpKZMzhUXd//B4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYulpfDQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d509ab80eso2734340f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709139131; x=1709743931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3vtv3FCJxPFF29J4MZq7l8JyQ9EslqYGbZf8qcGPf4=;
        b=pYulpfDQK8yzd3vIZ3bfM/jDIRxU3AimMce7vAQrSVV23wCunZPG9W2gfpJPV0JTJe
         1O/ZR8X9CRUXA1hxawe5GBT/HtF5+A3aOGEhzQEz82nw9gMA7uZjZjd8c4qBxiMgSeVK
         aBPOw+tC3Q6DekUG/1e3Pg0egfPEnE6BtSdP3QOGZxw6HNBKsOLTE5e0gQE/NLqzp4dn
         awroAiGznEoew6CeA8zm2dmeGbIFYfsVgKCLmORx63n0gyEa6/wQBvnLaWmGht169C8w
         o7ivtjAFsw/EZNpTUUmGZIEOumU/eK3VXP/QUZUs1xwx4SVL0UoQ5qiDwIb4JD1Z+U4I
         Cn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709139131; x=1709743931;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+3vtv3FCJxPFF29J4MZq7l8JyQ9EslqYGbZf8qcGPf4=;
        b=dRj42KEtX30Rg7o2WjCQUvVweTw/mEo4o1fJG0wX8zs6OBiPJjMkGblXLhDyx8rgvQ
         F6ZJA5nra9hcxPj111TLWiMaBhw+kH9Arp3o2N3avjdUvMNLjFS9KxGZCbS/F/AGaQoX
         7HtvrsZUkkl1oJ2W3fSzVJKKbvWNfT1vZ+CwziuQt2ZcjoMGLiOwHITpLPK6FUVEv2+C
         MgiQKLnKqZJkvhdWWV9Ss6SF8WnExxeftzFWWE/8HC9e1gy3k9vxrz5G8BEtNazrGkqm
         /d0b6TkTTuEwuYetQzGDgbdjzS+XbyZJKR3sfg5MEeNjXo/48+BlqV90QWAanYITKULq
         Stjw==
X-Forwarded-Encrypted: i=1; AJvYcCWrwmtKXG9xVtJvlEVYDqt2V9rC71QoHFLhAEfyB+d3eIK7E2YLMcvuKiiRs7eAVAcHrgufxC0CnbQdoEJQ8np2CXnp4VRcPn56jAWL
X-Gm-Message-State: AOJu0YxK59aT1E+3h0jN4+FK6a98Xxw7/G4TExW748n2t0yBrbdK9d1u
	rUsTYVbRUqDe44PprShonEiOrPBpGMzXJZ8Zem9Rp62+VWuJF1gBqwgHEZ8eTh4=
X-Google-Smtp-Source: AGHT+IHts9s9sJoLSp1tFY54//RVdJbrTkVB8QmQJgQYYzT+6medIFxeXXEtpfzFAlR3cphvkabkSg==
X-Received: by 2002:adf:a1c5:0:b0:33d:d799:ef6c with SMTP id v5-20020adfa1c5000000b0033dd799ef6cmr75625wrv.66.1709139130640;
        Wed, 28 Feb 2024 08:52:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8e80:16d6:ae57:b1cb? ([2a01:e0a:982:cbb0:8e80:16d6:ae57:b1cb])
        by smtp.gmail.com with ESMTPSA id c3-20020adfe703000000b0033d6fe3f6absm15026035wrm.62.2024.02.28.08.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:52:10 -0800 (PST)
Message-ID: <b4266102-3354-4d4a-8368-c143b12dbead@linaro.org>
Date: Wed, 28 Feb 2024 17:52:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/dp: Don't attempt AUX transfers when eDP panels are
 not powered
To: Doug Anderson <dianders@chromium.org>
Cc: Jani Nikula <jani.nikula@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>, dri-devel@lists.freedesktop.org,
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
 <cbcd981f-bd5d-477e-8482-d3414be17057@linaro.org>
 <CAD=FV=UtpL=Wy7jnUFkTF8WtMjWa3ZfJXsXDX=Q=j6o_6rd4AQ@mail.gmail.com>
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
In-Reply-To: <CAD=FV=UtpL=Wy7jnUFkTF8WtMjWa3ZfJXsXDX=Q=j6o_6rd4AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/02/2024 17:40, Doug Anderson wrote:
> Neil,
> 
> On Thu, Feb 15, 2024 at 8:53 AM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>
>> Hi Doug,
>>
>> On 15/02/2024 16:08, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Thu, Feb 15, 2024 at 2:24 AM Jani Nikula <jani.nikula@intel.com> wrote:
>>>>
>>>> On Wed, 14 Feb 2024, Doug Anderson <dianders@chromium.org> wrote:
>>>>> Hi,
>>>>>
>>>>> On Tue, Feb 13, 2024 at 10:25 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>>>>>>
>>>>>> On Wed, Feb 14, 2024 at 2:23 PM Douglas Anderson <dianders@chromium.org> wrote:
>>>>>>>
>>>>>>> If an eDP panel is not powered on then any attempts to talk to it over
>>>>>>> the DP AUX channel will timeout. Unfortunately these attempts may be
>>>>>>> quite slow. Userspace can initiate these attempts either via a
>>>>>>> /dev/drm_dp_auxN device or via the created i2c device.
>>>>>>>
>>>>>>> Making the DP AUX drivers timeout faster is a difficult proposition.
>>>>>>> In theory we could just poll the panel's HPD line in the AUX transfer
>>>>>>> function and immediately return an error there. However, this is
>>>>>>> easier said than done. For one thing, there's no hard requirement to
>>>>>>> hook the HPD line up for eDP panels and it's OK to just delay a fixed
>>>>>>> amount. For another thing, the HPD line may not be fast to probe. On
>>>>>>> parade-ps8640 we need to wait for the bridge chip's firmware to boot
>>>>>>> before we can get the HPD line and this is a slow process.
>>>>>>>
>>>>>>> The fact that the transfers are taking so long to timeout is causing
>>>>>>> real problems. The open source fwupd daemon sometimes scans DP busses
>>>>>>> looking for devices whose firmware need updating. If it happens to
>>>>>>> scan while a panel is turned off this scan can take a long time. The
>>>>>>> fwupd daemon could try to be smarter and only scan when eDP panels are
>>>>>>> turned on, but we can also improve the behavior in the kernel.
>>>>>>>
>>>>>>> Let's let eDP panels drivers specify that a panel is turned off and
>>>>>>> then modify the common AUX transfer code not to attempt a transfer in
>>>>>>> this case.
>>>>>>>
>>>>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>>>>> ---
>>>>>>
>>>>>> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>>>>
>>>>> Thanks for the review!
>>>>>
>>>>> Given that this touches core DRM code and that I never got
>>>>> confirmation that Jani's concerns were addressed with my previous
>>>>> response, I'm still going to wait a little while before applying. I'm
>>>>> on vacation for most of next week, but if there are no further replies
>>>>> between now and then I'll plan to apply this to "drm-misc-next" the
>>>>> week of Feb 26th. If someone else wants to apply this before I do then
>>>>> I certainly won't object. Jani: if you feel this needs more discussion
>>>>> or otherwise object to this patch landing then please yell. Likewise
>>>>> if anyone else in the community wants to throw in their opinion, feel
>>>>> free.
>>>>
>>>> Sorry for dropping the ball after my initial response. I simply have not
>>>> had the time to look into this.
>>>>
>>>> It would be great to get, say, drm-misc maintainer ack on this before
>>>> merging. It's not fair for me to stall this any longer, I'll trust their
>>>> judgement.
>>>>
>>>> Reasonable?
>>>
>>> I'd be more than happy for one of the drm-misc maintainers to Ack.
>>> I'll move Maxime, Thomas, and Maarten to the "To:" line to see if that
>>> helps get through their filters.
>>
>> I'll like some test reports to be sure it doesn't break anything,
>> then I'll be happy to give my ack !
> 
> Are you looking for any more test reports at this point? Eizan did
> some testing and provided a tag, though this was also on ChromeOS.
> Steev also tested on two non-ChromeOS environments and provided his
> tag. It's also been another two weeks of this being rolled out to some
> Chromebook users and I haven't heard any reports of problems. If
> somehow something was missed, I'm happy to follow-up and provide
> additional fixes if some report comes in later.

Sure, thx I think you can apply it now

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

> 
> Thanks!
> 
> -Doug


