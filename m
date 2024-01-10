Return-Path: <linux-kernel+bounces-22492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0E8829E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68531C20C28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E824CB41;
	Wed, 10 Jan 2024 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIImhYbd"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BBE4BAA0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e4d64a431so22001335e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704903929; x=1705508729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15bYShZuIS4+CSxAUIJl+wAlVTxXL5pj1PzzN1HPXTY=;
        b=ZIImhYbdJfHecAcJ+KWGlloFDo5EjjZ4Hpl3Cu0eUW75UO24tsJ0RnhkRGVY0flR04
         Jk381b7wpHiSZ0t/fEB5j9o4w50MqbtDZBAr00xHi8PrNuZyqyhKu9epyIZeVSCZ6938
         gyNfaMJwm6uUzlM6oRfI9VRgJrPz7tgNdZtHCVeA/Qoe+kvUqHXTdnjcEdyvGrPasPFU
         N7Ul0ADUy7mo5I/rf9QiZYwvzsxTzE0ks1zXayMf7MlU8DwluiFBlGUMA3hEuQjRy+IE
         vMGaxtUJV+kLIPMLY9iT8F0bAc1RqqbUpWLWWjbusVEY46Hl+YWwGOEWCr58e1mUycWF
         TBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704903929; x=1705508729;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=15bYShZuIS4+CSxAUIJl+wAlVTxXL5pj1PzzN1HPXTY=;
        b=H5sjvO6Dg2TUt+CIZj3r/Yxuf3eihoVSZP8Rn7370dourZs5xszZ73PkWhYsLM7jo1
         MeN8cA7YePrO3mSYiCmFj/28m5s0ToqCRWcFPrZDX2LR89oMTuG/rZxMst2xIhVeyAgZ
         wVb3uaB6I5sEp7QvP1d8lTCt4xwZNl2Sbcmwg4JdL8mc+xPY97ULJeQfuXTGmmNg7Wrs
         45WTD/mq9aX5F0nwRLqtcWozSrJSJJq1WFbe2gB4IFmZks9tI0AugjE6gWXl0wlTYMKE
         yXJqhpGAfE3qXT+GVIGGdZZzrAkKJjZNJVwbTjYd0uBVQ6H/5l98n1gIewxwjE137/UR
         ZWhQ==
X-Gm-Message-State: AOJu0Yy05LidJTvyCbzL/MkoCYpymfqE2XgZ7pf1RsbxFB1pUE45bRfL
	Lx3SkpQYYvTlRJ1/loix2WjpFwh0pLP++w==
X-Google-Smtp-Source: AGHT+IE9PekVK0Th6y6bMR8dNTYSBDVpdQ3lSyTVffa/xd/PVDY0KvfpkbBq+lP11myDdjPGXoiZqw==
X-Received: by 2002:a05:600c:3eca:b0:40d:763d:c7fe with SMTP id ek10-20020a05600c3eca00b0040d763dc7femr742455wmb.121.1704903929423;
        Wed, 10 Jan 2024 08:25:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5dee:51de:9349:2adf? ([2a01:e0a:982:cbb0:5dee:51de:9349:2adf])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b0040e3b12052bsm2752200wmg.5.2024.01.10.08.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 08:25:29 -0800 (PST)
Message-ID: <39a224f2-b245-4766-88f6-3af856ae7acb@linaro.org>
Date: Wed, 10 Jan 2024 17:25:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/etnaviv: Expose a few more chipspecs to userspace
Content-Language: en-US, fr
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Christian Gmeiner <cgmeiner@igalia.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240110153704.1364073-1-tomeu@tomeuvizoso.net>
 <170490387684.1887297.10058632363349793019.b4-ty@linaro.org>
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
In-Reply-To: <170490387684.1887297.10058632363349793019.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/01/2024 17:24, Neil Armstrong wrote:
> Hi,
> 
> On Wed, 10 Jan 2024 16:37:00 +0100, Tomeu Vizoso wrote:
>> These ones will be needed to make use fo the NN and TP units in the NPUs
>> based on Vivante IP.
>>
>>
> 
> Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.9/arm64-dt)
> 
> [1/2] drm/etnaviv: Expose a few more chipspecs to userspace
>        (no commit info)
> [2/2] arm64: dts: amlogic: meson-g12-common: Set the rates of the clocks for the NPU
>        https://git.kernel.org/amlogic/c/507b3e756ffcb174d383dd05df5084aed9bb6d14

To be clear, I only applied patch 2.

Neil

> 
> These changes has been applied on the intermediate git tree [1].
> 
> The v6.9/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
> for inclusion in their intermediate git branches in order to be sent to Linus during
> the next merge window, or sooner if it's a set of fixes.
> 
> In the cases of fixes, those will be merged in the current release candidate
> kernel and as soon they appear on the Linux master branch they will be
> backported to the previous Stable and Long-Stable kernels [2].
> 
> The intermediate git branches are merged daily in the linux-next tree [3],
> people are encouraged testing these pre-release kernels and report issues on the
> relevant mailing-lists.
> 
> If problems are discovered on those changes, please submit a signed-off-by revert
> patch followed by a corrective changeset.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 


