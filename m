Return-Path: <linux-kernel+bounces-166686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3942F8B9E29
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99ED51F24B68
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6356B15CD7B;
	Thu,  2 May 2024 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKJb9Udf"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F0F15CD68
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665973; cv=none; b=BLyKaKE2Ow8Zg/ZZnW78pekHjYkU7ARytG2dPtj95loj/VfJOgh4fiw5WpWgLdFmUwz/xk6oqZhaIYXS8nCcJTZz7ApNKEoeOHrzycr6oGV056B8Llqwg8IeSlIF5gAWZG8lcMMMtFfEOFNEGlBN0XthOZxX61SJWItoUmahw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665973; c=relaxed/simple;
	bh=QnyA+11+ehV/nBSYMtRIK0mCW8vMKZV2j+QHH73T6Xc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=igzDy2RhDVG+GJMpr2HDPZd/LRbkkv9EAn6GH2fvak4YLEBrUV81jp+/LqApei7YqSjhFPqVK5VrZohM4wBCq1AGJX8yvgGbx9VTVoyB6Ew1MMf6VA5AhjPy3OMU7kt2TO3tOWtLWitqYBsTIVg9wAlGWj8s/VB0S+xb6krMoZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YKJb9Udf; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2dd6c14d000so100828081fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714665969; x=1715270769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25zwD18bgllLmVOobFWQB3f61c9JzC+LqF63JHzrYI4=;
        b=YKJb9UdftbyPyULHmyhofA6QSxXVLuwKTayshlTPJQMUMBS8nzYMmyT+jcmSw/is+N
         MAGmVF7VssTP+qS7YfiYd0sUxSUafyt1G3Td8N3xnE2OumAfCaST7A6wAtCpqifbrkZf
         fXwPvc8OkHK4sy+5TlnertyydAWJ3bKZK4/rv86xjn0WO3Hpe3OINQoDvP5RLWQ4VBG9
         2ujRp1iiqGMCCwfJhPYQmEaIay2PsvCM7MKiubd5E2c8NqJF5n7DfXCNI/cKxMl3fLXM
         6svNaqCv4BoIrrP9iVTm2/moZG9wGjC0epPUE9NKRgRp91VESDQPPxbFd+XlUmlQTLUQ
         W5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714665969; x=1715270769;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=25zwD18bgllLmVOobFWQB3f61c9JzC+LqF63JHzrYI4=;
        b=f9ws2TUJcsKp9x9zx+rT/BofS9dvyaZV0BmOHpjj6ZwF/Q728wgH6dtD/X0DSTORqK
         c4OBDdEla5OZZuQ2Zs8tenvQ8gAPiEQbQLa0qwk9UqOhekc2EghUx+9C3fQnhsN7yh64
         +ig2ydQDhZFPeAFRz+Fou3vLJJRJ9zoljC0aDZaK3dLwX9njU5YNWVxDKeCgtK61e2d8
         RkYoi/00Iu3TBm0hPndc94XQ7U+UcwdjkRljh61k+NVz9iy2psXuTMMw3Sl9iM8kV18s
         g2Q4yxinqSmENpQdDX6GhlnIBuPl7R3hndP+0qDgbzodrg2XGxMdAVmhjH432VywxhDP
         M19w==
X-Forwarded-Encrypted: i=1; AJvYcCUV9VA/YScln+jumu71TN7FpR+2rWswgHuJtgxmlRoOdA8Da/e77iI3UfEdrQEDxqIDJhKxIGo4VK+Mm4xelh81IEnCaN/Xwyqh2hlh
X-Gm-Message-State: AOJu0YxO4GJ9Keh1Oo1zrOKQOfJ7gAsVLuPAK86nEhVYKlDy9/dh0HRR
	HTzcF8uZMDPxG/iJEeRUVNva5N58ccMwrEbPHKOnFSpgpmboouuGHJiqfIAfMwQ=
X-Google-Smtp-Source: AGHT+IEfpb7WO5K6osyyTX1W+HrVT09aiTdeg/m4a7x7dxL4qsKN3OMLmb6BoSMXZxnecKOF22K9MA==
X-Received: by 2002:a2e:a9a4:0:b0:2e0:3f37:5af1 with SMTP id x36-20020a2ea9a4000000b002e03f375af1mr158689ljq.33.1714665967468;
        Thu, 02 May 2024 09:06:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:67e2:5e2:652b:4129? ([2a01:e0a:cad:2140:67e2:5e2:652b:4129])
        by smtp.gmail.com with ESMTPSA id c4-20020a5d5284000000b0034b1a91be72sm1577639wrv.14.2024.05.02.09.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 09:06:07 -0700 (PDT)
Message-ID: <35b899d2-fb47-403a-83d2-204c0800d496@linaro.org>
Date: Thu, 2 May 2024 18:05:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 0/9] drm/mipi-dsi: Reduce bloat and add funcs for
 cleaner init seqs
To: Doug Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Linus Walleij
 <linus.walleij@linaro.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Hsin-Yi Wang <hsinyi@google.com>, Brian Norris <briannorris@chromium.org>,
 Sam Ravnborg <sam@ravnborg.org>,
 Javier Martinez Canillas <javierm@redhat.com>, Joel Selvaraj
 <jo@jsfamily.in>, lvzhaoxiong@huaqin.corp-partner.google.com,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Jonathan Corbet <corbet@lwn.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240501154251.3302887-1-dianders@chromium.org>
 <a8a73fc4-7699-4c47-8970-cd68be0fe1d9@linaro.org>
 <CAD=FV=VciR5UEQpvizrUNYR7mhE2P4ESvM2T7v4mUT3UpdX3bg@mail.gmail.com>
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
In-Reply-To: <CAD=FV=VciR5UEQpvizrUNYR7mhE2P4ESvM2T7v4mUT3UpdX3bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/05/2024 16:27, Doug Anderson wrote:
> Hi,
> 
> On Thu, May 2, 2024 at 12:48 AM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>
>> Hi,
>>
>> On 01/05/2024 17:41, Douglas Anderson wrote:
>>> The consensus of many DRM folks is that we want to move away from DSI
>>> drivers defining tables of init commands. Instead, we want to move to
>>> init functions that can use common DRM functions. The issue thus far
>>> has been that using the macros mipi_dsi_generic_write_seq() and
>>> mipi_dsi_dcs_write_seq() bloats the driver using them.
>>>
>>> While trying to solve bloat, we realized that the majority of the it
>>> was easy to solve. This series solves the bloat for existing drivers
>>> by moving the printout outside of the macro.
>>>
>>> During discussion of my v1 patch to fix the bloat [1], we also decided
>>> that we really want to change the way that drivers deal with init
>>> sequences to make it clearer. In addition to being cleaner, a side
>>> effect of moving drivers to the new style reduces bloat _even more_.
>>>
>>> This series also contains a few minor fixes / cleanups that I found
>>> along the way.
>>>
>>> This series converts four drivers over to the new
>>> mipi_dsi_dcs_write_seq_multi() function. Not all conversions have been
>>> tested, but hopefully they are straightforward enough. I'd appreciate
>>> testing.
>>>
>>> NOTE: In v3 I tried to incorporate the feedback from v2. I also
>>> converted the other two panels I could find that used table-based
>>> initialization.
>>>
>>> [1] https://lore.kernel.org/r/20240424172017.1.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid
>>>
>>> Changes in v3:
>>> - ("mipi_dsi_*_write functions don't need to ratelimit...") moved earlier.
>>> - Add a TODO item for cleaning up the deprecated macros/functions.
>>> - Fix spacing of init function.
>>> - Inline kerneldoc comments for struct mipi_dsi_multi_context.
>>> - Rebased upon patch to remove ratelimit of prints.
>>> - Remove an unneeded error print.
>>> - Squash boe-tv101wum-nl6 lowercase patch into main patch
>>> - Use %zd in print instead of casting errors to int.
>>> - drm/panel: ili9882t: Don't use a table for initting panels
>>> - drm/panel: innolux-p079zca: Don't use a table for initting panels
>>>
>>> Changes in v2:
>>> - Add some comments to the macros about printing and returning.
>>> - Change the way err value is handled in prep for next patch.
>>> - Modify commit message now that this is part of a series.
>>> - Rebased upon patches to avoid theoretical int overflow.
>>> - drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_dcs_write_seq()
>>> - drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_generic_write_seq()
>>> - drm/mipi-dsi: Introduce mipi_dsi_*_write_seq_multi()
>>> - drm/mipi-dsi: mipi_dsi_*_write functions don't need to ratelimit prints
>>> - drm/panel: boe-tv101wum-nl6: Convert hex to lowercase
>>> - drm/panel: boe-tv101wum-nl6: Don't use a table for initting commands
>>> - drm/panel: novatek-nt36672e: Switch to mipi_dsi_dcs_write_seq_multi()
>>>
>>> Douglas Anderson (9):
>>>     drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_dcs_write_seq()
>>>     drm/mipi-dsi: Fix theoretical int overflow in
>>>       mipi_dsi_generic_write_seq()
>>>     drm/mipi-dsi: mipi_dsi_*_write functions don't need to ratelimit
>>>       prints
>>>     drm/mipi-dsi: Reduce driver bloat of mipi_dsi_*_write_seq()
>>>     drm/mipi-dsi: Introduce mipi_dsi_*_write_seq_multi()
>>>     drm/panel: novatek-nt36672e: Switch to mipi_dsi_dcs_write_seq_multi()
>>>     drm/panel: boe-tv101wum-nl6: Don't use a table for initting panels
>>>     drm/panel: ili9882t: Don't use a table for initting panels
>>>     drm/panel: innolux-p079zca: Don't use a table for initting panels
>>
>> Thanks Doug!
>>
>> I think we all agree on the core changes, now I think we can wait a few weeks
>> and try to get some test feedbacks on the indirectly and directly affected
>> panels, drm-misc-next won't be merged into linux-next until v6.10-rc1 anyway
>> so we have some time to test on our boards.
> 
> Great!
> 
> Just to be clear, are you suggesting that we leave these patches on
> the lists for a few weeks before landing in drm-misc-next, or are you
> suggesting that it's safe to land them in drm-misc-next because it
> won't make it to linuxnext for a while anyway? I assume the former
> (AKA leave it on the lists for a while) but just want to be clear. ;-)

Yes you assume right

> 
> There's nothing terribly urgent about these patches except that they
> are blocking Cong Yang's patch series [0] and lvzhaoxiong's patch
> series [1]. I think it would be fine for them to send out their patch
> series with mine marked as a dependency so we can finish reviewing
> their series and then when mine lands theirs will be good to go too.
> 
> Maybe we can aim for 2 weeks of stewing on the list if there are no
> issues during that time? I know landing in drm-misc during this time
> won't help get into mainline faster, but with ChromeOS's "upstream
> first" policy it saves us a bunch of headache if we can land things in
> our tree from a maintainer tree with stable git hashes (like
> drm-misc-next) instead of landing from a mailing list. Certainly that
> doesn't mean we want to rush patches in before they're ready, but I
> just want to say that there is still some benefit in getting the
> patches landed sooner rather than later. :-)

Yes let's wait 2 weeks and apply them

Neil

> 
> [0] https://lore.kernel.org/r/20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com
> [1] https://lore.kernel.org/r/20240418081548.12160-3-lvzhaoxiong@huaqin.corp-partner.google.com


