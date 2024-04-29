Return-Path: <linux-kernel+bounces-161865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955628B526F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83771C21222
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F3F14A9F;
	Mon, 29 Apr 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uDB5j69l"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1C51426E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376173; cv=none; b=n/3g+bcIKSZAIkYaCNVcpvyAtwL4X1BOBbPupUsH4S5vRn+5u4CwqUDE+TLAPfxZwLXs9TK+R6p4x/kSAzzbeH3QYNJbxlwhb1BFztr0yO+Az+ecdEG/SKxcPxI0r3qbVveI6uvnmPR4LzY6sQgIEz9v2HSqSH+MJtt0YlogoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376173; c=relaxed/simple;
	bh=33GlNWDoneeKLX4h7qhhA3i8Q9JLIcERc+9AZY2t3hY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kugvS+oPx3rRP7xfMrQ9eAIr0sWeUXvVjguavAs8tRfJCMoMjTq+xgQ+rF32HiXKqNFe9M+sr7tJhf+qpcLbOGSmpKjuse1dfMp5CLoY23UI+Up25ZgMDAaTPQRt7TG1YjnME4/P5TWHhJx8rRXzFVxpnwdwm3UZrbcdPuxTL9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uDB5j69l; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b869326daso17934675e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 00:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714376170; x=1714980970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YPpX3LmNwDjVUlNB/0j3ZN9nZwfzcoxuiregVpsmGM=;
        b=uDB5j69lAJ0QSAVsQrN7Xr0CfdOHoeDCmLqhW1vudwTv5Z2Es167dS91vf2yOav2Vg
         pGfs7nvCLcwq5qpvCxElnkJtfT3i1r/HejbboGseVdbb+iL6e/oNOtC9ssqWO4LJt6c1
         8wL3vs1ojcxvaZ1/yt5e1ODQPlAX2G2DUZ2rpIelGofkXpLcltnsm1SfKJvPYFWMDi8b
         mZqzsVR6bI569Xtt9WoUQGGS4UeHkaIZAHB6mIHaJF8VTNEUxY/iXG+KbsjUbfSGgGcS
         j5d+eRjHDOoEwwswA1J6i49IFONmya5xVRHefpN4fgp7xcYCl/UXvJQYe/1k6IGXYjjZ
         /jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714376170; x=1714980970;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2YPpX3LmNwDjVUlNB/0j3ZN9nZwfzcoxuiregVpsmGM=;
        b=jkHWPd+rX+n7p9/8erIqJH/RyNTvJIPGtl/Zmy0MhBScUtiHa091VzR5ac7E4YWCAx
         RYJX35/5fXhEKxaUdQjjy8b387sf7jSGulOYUftPC5zJHkw3yGMRHioINw0UKaB+efj9
         mSYEh/S32ZtC/zRpki48riDaTY6YXnPegsazCudpxnN/5cVGD5dIZc7Lopp+ICme7/Ub
         9UPlwxdteRpi7NBMbgIcxP1UNiSTKsXfPd2LWcQoMMLUo4YJBzkjK2bqXw97yDS08d0C
         NDqc3FRaTaWoX1nE035mQHHYvJMOzWxMQvhossIW6A8kHX1lR/561FdiVPjbQ0Inn2Hh
         jf3A==
X-Forwarded-Encrypted: i=1; AJvYcCWjMkkGF2x2WQiBDi48Rwa0j9oXFfygKCrFf9x2vOR6BGCelS7YxA/a0Ci7KpVFzhgRAaMWcmkzt/Ahks14yK4BMBU3Wlzrk+HavHF3
X-Gm-Message-State: AOJu0YziIIIqOd4odLU+tWui1yImSQG4PXLws+oixK6zclbWXqtmnf0S
	psu+YUiok784wihGKU07i9Rr8iziKbU7yOsBhFrl271IzPbeRjGNuigrtDMpY4Y=
X-Google-Smtp-Source: AGHT+IGUFxK98NOI5jFo2xQj8ldkC/5ShZT8LR1GFygIJ814JksY0q9Y/IXVYd6vZcmGjJbsKUX/qA==
X-Received: by 2002:a05:600c:4508:b0:41b:f28a:a11e with SMTP id t8-20020a05600c450800b0041bf28aa11emr4477073wmo.22.1714376169980;
        Mon, 29 Apr 2024 00:36:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:d72:4b40:65fa:89e6? ([2a01:e0a:cad:2140:d72:4b40:65fa:89e6])
        by smtp.gmail.com with ESMTPSA id bi7-20020a05600c3d8700b0041be609b1c7sm7391629wmb.47.2024.04.29.00.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 00:36:09 -0700 (PDT)
Message-ID: <91d8143f-b79f-4108-8593-ac0165628728@linaro.org>
Date: Mon, 29 Apr 2024 09:36:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] serial: msm: Unify TX and RX DMA paths
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>
References: <CGME20240423120821eucas1p2e8eb7aa059e00ee2bc6272cda24d1457@eucas1p2.samsung.com>
 <20240423120809.2678030-1-m.szyprowski@samsung.com>
 <4813aa76-6ce7-403d-8bff-1fb6e1d3f0a2@linaro.org>
 <2024042342-unmade-surely-da1c@gregkh>
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
In-Reply-To: <2024042342-unmade-surely-da1c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

On 24/04/2024 01:33, Greg Kroah-Hartman wrote:
> On Tue, Apr 23, 2024 at 04:08:04PM +0200, neil.armstrong@linaro.org wrote:
>> Hi Marek,
>>
>> On 23/04/2024 14:08, Marek Szyprowski wrote:
>>> Use scatterlist-based API also for RX mode to unify TX and RX DMA paths
>>> as well as simplify the whole driver code a bit.
>>
>> Thanks for the patch, I have no idea if this is right or wrong.
>>
>> Greg, I think we should wait until this change is fully tested on multiple
>> platforms including DMA usage (bluetooth) before aplying it.
> 
> Great, who is going to test that without me adding it to linux-next?

Qcom developers, reviewers and maintainers will review it and test it like
any other patch affecting the qcom platform.

Thanks,
Neil

> 
> thanks,
> 
> greg k-h


