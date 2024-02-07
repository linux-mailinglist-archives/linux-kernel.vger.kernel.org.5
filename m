Return-Path: <linux-kernel+bounces-56676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2284784CD77
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470D41C25477
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195E27F465;
	Wed,  7 Feb 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OuLpKG+I"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88E7E784
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317882; cv=none; b=N4jVy8p8EICuipqJ39L4IYUpm8JB1XZcjVN0h0Sz9O7lhWw+73YMLxnIF3lSgK370130VVSjk+9Z/puOtfRjdtiaZi5Cd7aEtc1dtWNNQrXDgyzXfTpkLaxQD64tBhsU1+qEBzBtAF0xVzx9JukjwGyDBb7Mq1b2kftZhaPrWG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317882; c=relaxed/simple;
	bh=rM2+A4y8ut0HE5QBG5YZ2JHQfLBnTNBkBkI7m8+cGLM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TedGz2NpOOE5t/cupHgZNLX/Fn3vN4AwjmUGLguPEa1WhLTlJADw4hugh6zCULf8V4KEcHJrN1ZoRiCHZdZxdEgS/2EpQqntn4vOa8w2sKa5Gno/oxMDvno5yFf0f/7BUicX+SsDWjbTyYoEDFrytUv5wmpgDwVxrzSf0evN/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OuLpKG+I; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51032058f17so922379e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707317878; x=1707922678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yw+ZFLUeQpB09fZ01d0Kcu51k39UdmSHJS8VA8lDgcw=;
        b=OuLpKG+If3lXrZ5oiUO3/Kld62NxJy2em/FnlpuUWdf8a3CLNTJacfax9xNP0Yeb7r
         hQ86Ebx2eQHxnAV6IzcPAz2yfW8OX6gt7iyM37vB+fbQ8NY/bA57kKBmQS03y0ZkNZ9L
         tddXXB6Jl+5UsWLxhkLUe/JAAOeIHOQxpcm0yPYWCiuK5adWXhBVqXqseP9nSwzmqKlb
         6gCD2KWZKLxHsBY6ugqdZOzQpR2ZrBh8qww1IZNm64E/h2cU6Aj6pQ+I4ox1+OP9o5g2
         2n/yAGkXRBeJsydhMsHZ086ThYUq7LPBZlAPrwBuSEvVGk1b0AWBGvNfn2mMhgpsocPv
         l2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317878; x=1707922678;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yw+ZFLUeQpB09fZ01d0Kcu51k39UdmSHJS8VA8lDgcw=;
        b=lv4XF8b8ggVQhYGoN56f+LJ0xqdS8wuAjwN9v+hgT+QsYjSet2s06OfGO/wp32cX2W
         LFMvsgP2JQBYGWvVIsM7WhxxeAfkmYAJOOqiDfoEgmH6uetIWTt8GyVqtu4XpNzT3f5G
         F3HDdwS5GnCI2mv6socT2W4A5uBmFVs/mtWPWEu2NJTfusP3l7Im+fM15zSPc2o5spe1
         AajVssawzFQjIbNR312CJNjacMO+VdIG1gVaYid8ZIQFuYHC6KjNCNrjL/hVhmhOWHla
         qFbjbpd48Pr/kNbepisMrNufAGTpwpS7uDbWwHCmEnx5OLCz4hTMOtdTqRADhUPLSHJS
         zxFw==
X-Gm-Message-State: AOJu0YxG+c9P8/DazZ3AItQGtRzckS9/rBkAL38UroEv7XMwLdbPygy+
	RKqmyu4+JTKSjKMRlqi3z/s0895XDVNBHOPuzpzAvlelz6xKo37z5Mha6h72Was=
X-Google-Smtp-Source: AGHT+IEBuN+LXOLtqc7RSSzBK/j0MJWezurLCsLWC9vYUou93riQDpe07JLvts+6zF3X24MvXm+UXQ==
X-Received: by 2002:a05:6512:3084:b0:511:4cc9:33a4 with SMTP id z4-20020a056512308400b005114cc933a4mr5694360lfd.52.1707317877932;
        Wed, 07 Feb 2024 06:57:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlxRNSM79t9F4iAPhnvtvu9WOEBeOlCLIVOLECYq2ynGeg2l9/5JtgRkCvP/X4GN9DIUlg5exAOYRaOPaRYg+rVanDs8g8r9hqSwbo82gMnio+pkZThcC766hCsn44uJZ33WMcIwdYoGhCWdWc9p3Hveaz73ew0oU8XiXgTTsajH6iV8VFiiv9XLLFpVEUFxitAtWWYiAjBXbtPq+IE+Q+iQNJy3Ww4di1w1PBEtGAP1JlGLJ8OT2GNXTxc3/wx0WmjeylMo6WwE9DqX2KhALIaRxGDQR/MPve0qY0dvHAIy2dfzg4XZjrmTYplTylstb+zyXu7DfjXwa/I+7114TGHs+5i0/LQlPz6jUYVSui7Sy81QhU3NH+2T1iEmFbiFmcwg6Dw2oK2v0jL/3ZPrE4TwexUGHKIH8=
Received: from ?IPV6:2a01:e0a:982:cbb0:5ae7:7fdb:32ad:f6d7? ([2a01:e0a:982:cbb0:5ae7:7fdb:32ad:f6d7])
        by smtp.gmail.com with ESMTPSA id fa7-20020a05600c518700b0040ef3ae26cdsm2342311wmb.37.2024.02.07.06.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 06:57:57 -0800 (PST)
Message-ID: <cc48bced-7591-4394-a1ad-4e7cd77a7844@linaro.org>
Date: Wed, 7 Feb 2024 15:57:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC 1/2] spmi: Add support for multi-master
Content-Language: en-US, fr
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Abel Vesa <abel.vesa@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240207-spmi-multi-master-support-v1-0-ce57f301c7fd@linaro.org>
 <20240207-spmi-multi-master-support-v1-1-ce57f301c7fd@linaro.org>
 <CAA8EJpqsJmv36=o1aTjVH6eMHXMg8BHNpiDvs+Q8YB23ezVGtQ@mail.gmail.com>
 <ZcMvFtAwQQjAZhk6@linaro.org>
 <CAA8EJprqWLX7_yWZzKp3FAKFGkSkk041f9hj1uXuRBrbH5APyQ@mail.gmail.com>
 <ZcNIddeG6VHxBEOQ@linaro.org>
 <CAA8EJpo-16u34Yc6MLmHSqFrQ0VrZAq6TwGeVc5WFwMmhruqoA@mail.gmail.com>
 <b4018932-2fcb-4a15-9ec4-e29e5761d3e0@collabora.com>
 <CAA8EJpo5bb+AWJra26MoDPKE_vF+eBAJAGoxenkMtGWz2N5Tuw@mail.gmail.com>
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
In-Reply-To: <CAA8EJpo5bb+AWJra26MoDPKE_vF+eBAJAGoxenkMtGWz2N5Tuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2024 15:22, Dmitry Baryshkov wrote:
> On Wed, 7 Feb 2024 at 14:46, AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 07/02/24 12:45, Dmitry Baryshkov ha scritto:
>>> On Wed, 7 Feb 2024 at 11:08, Abel Vesa <abel.vesa@linaro.org> wrote:
>>>>
>>>> On 24-02-07 09:23:09, Dmitry Baryshkov wrote:
>>>>> On Wed, 7 Feb 2024 at 09:19, Abel Vesa <abel.vesa@linaro.org> wrote:
>>>>>>
>>>>>> On 24-02-07 01:55:39, Dmitry Baryshkov wrote:
>>>>>>> On Wed, 7 Feb 2024 at 01:34, Abel Vesa <abel.vesa@linaro.org> wrote:
>>>>>>>>
>>>>>>>> Some newer SPMI controllers support multiple bus masters.
>>>>>>>> Such a master can control multiple slave devices. The generic
>>>>>>>> framework needs to be able to pass on the master id to the
>>>>>>>> controller-specific driver. So do that. The framework will
>>>>>>>> check if the devicetree child nodes are actually bus masters
>>>>>>>> and will register the devices for each master. The legacy
>>>>>>>> approach will still be supported for backwards compatibility.
>>>>>>>
>>>>>>> Please remind me, are those two actual bus musters driving a single
>>>>>>> bus in parallel or two SPMI buses being handled by a single device? In
>>>>>>> the latter case this implementation is incorrect. There should be
>>>>>>> multiple spmi_controller instances, one for each bus. Allocate them in
>>>>>>> a loop and set ctrl->dev.of_node after allocating.
>>>>>>
>>>>>> It's two SPMI buses (two sets of wires) handled by the same controller,
>>>>>> HW-wise.
>>>>>>
>>>>>> If we register two spmi controllers with the kernel framework, it will
>>>>>> be HW inaccurate, because there is just one controller which has
>>>>>> multiple masters.
>>>>>
>>>>> struct spmi_controller is a controller for a single bus. Inside your
>>>>> device you have two SPMI buses, each can be controlled by its own
>>>>> struct spmi_controller. Just like devices that control multiple I2C,
>>>>> SPI or USB busses register a separate instance of the bus controller.
>>>>
>>>> Well, this is what this patchset is trying to do in the generic part.
>>>> The SPMI controller supports multiple buses (HW-wise) and therefore SW
>>>> implementation shouldn't be tied to single bus requirement.
>>>
>>> So, after the off-line discussion:
>>> - add new compatible string for sm8450+
>>> - register two spmi controller instances
>>
>> Well, I don't know about the actual hardware that you're trying to implement
>> but, in my opinion, the "idea" of this series does actually make sense.
>>
>> The SPMI specification says that SPMI supports up to 4 masters, and up to
>> 16 slaves.
> 
> So, that is my main question: whether this supports multiple masters
> on a same bus or multiple buses. From the SoC pins description I
> assume the latter is the case.

This is clearly 2 separate physically separate busses, not 2 masters on the same bus.

We registers separate controllers for i2c, spi, 1w, ... in this case, why not here ?

Neil

> 
>>
>> Just my two cents.
>>
>> Cheers,
>> Angelo
>>
>>> - drop the master-id from the SPMI interface
>>> - optionally: think about having a new separate driver for v7 SPMI.
>>>
>>>>
>>>>>
>>>>>>
>>>>>> I'm not saying it might not work. But, to me, it looks more like a hack.
>>>>>>
>>>>>> Basically, we would be mapping HW bus masters to kernel controllers.
>>>>>
>>>>> Buses, not just masters.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>>>>>> ---
>>>>>>>>    drivers/spmi/spmi-mtk-pmif.c |  6 ++--
>>>>>>>>    drivers/spmi/spmi-pmic-arb.c | 10 +++---
>>>>>>>>    drivers/spmi/spmi.c          | 76 ++++++++++++++++++++++++++++++--------------
>>>>>>>>    include/linux/spmi.h         | 10 +++---
>>>>>>>>    4 files changed, 67 insertions(+), 35 deletions(-)
>>>>>>>
>>>>>>> --
>>>>>>> With best wishes
>>>>>>> Dmitry
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> With best wishes
>>>>> Dmitry
>>>
>>>
>>>
>>
>>
> 
> 


