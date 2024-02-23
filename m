Return-Path: <linux-kernel+bounces-78430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE0861360
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16663B260CC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8866C2EAF7;
	Fri, 23 Feb 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tkv3VesT"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD53280C19
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696353; cv=none; b=f+TcnLY3VqxUEiglcx4Sybl831kZbKxC3213nss1kHqiYVIA83YSgd3sESzPeBAzskHzmYqfVymbcKmMMK4jSsHwBZDqmyIruZnw7eDrKP2HR5kHrgSTpbT6Ey4JkgJlsjUrYKHegpQDxlF+G99n895lU70czufQJAHoFQ0jexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696353; c=relaxed/simple;
	bh=NzFRH/hD+LHAn7VgPtmLztnUE0rHvW9QplrqkiMWXgk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JOp0+KJFBU+A/FlKsgeDP3l5/mMSQSMEQBAnnOJSQOVrhmZXg/PXvkDyFm7m4N9Rks4FTbuUGkubEKsTxZFux4CUnChizHA5lHZBkXfCleDzbkRHJo4GK6y/B4viYCGLYoLQZfoY+nCFGODT6uHjiDqbU3cEUa3oDc9m07fIESY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tkv3VesT; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d23114b19dso11500771fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708696350; x=1709301150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1CCwIgy2o0ymKg9g36BhlVJ3/o2uKolikgKrUSItNU=;
        b=Tkv3VesTeC4Pg0H5lbnPrHWmR0ZMsgFnMPZEL2q8MjwrvA6yec3OyYDiZBq2N211uV
         06dvFn+CLXiGL1YvB8RWXI3XE0TW4QS71QW3KKiMzNzhMM4ewXbObgBa/zelP99nAWZ4
         t155u0gdXOkXROqfW0bqsGjuYYyR7f+SVDAxqPbWPfwkNQlGGJxcuKh/8rxsdBcrzakU
         s5elG6eHNi3EF0JtT/E1GTFed+b7+IrMD+jpnXb2sOg7ddrIPMqKjkkhnylMzH9t6EZ8
         E4UJtidntQAOumnsEc8WuJrfVLL9Bm++qm7HEaKa5eDThj2I/yzdVCjHsYKE8NDvQstP
         ZBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708696350; x=1709301150;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w1CCwIgy2o0ymKg9g36BhlVJ3/o2uKolikgKrUSItNU=;
        b=TSNHRf3GaIz4sNEUhjTdJZ7L9KkZVXh4t1hJ/xGKxzdynuYb8FVJz5kFa3BHGpxCC7
         d7sqJceKbyaO8PlRFmtAouiHWdErhkDguV7D3zuGZhHHwMDaVdmfT/V877EyHVqBOVhj
         Dypv51KjnAgMseNnBGXJILgwXRhXQKjNtDSyT2hNsvXEcEApKFdel5P5NtH7vT9dyP08
         1dtx0U1NhmIhmIGoGsVODT4zmM2ihEsD0eduu8I4dGC/+rOkNbmue7fvX1RqjoIGtRjz
         1Yt23gBX5CR4f73zej6l0Ypxs9crB6htDj0Zl8zEK7DNjwArARigWebvKqQpDSKjJR8d
         ydwg==
X-Forwarded-Encrypted: i=1; AJvYcCXzUs1uZSLtqyXnE5aTt6hWbOAbCN6XKvy/O1lr+rsM5cdjHQbtL3MfSC9lZrwsFaaayzdRZryX/LnPCFJbnihogzCiEvEwvSZGd12h
X-Gm-Message-State: AOJu0Yzpd39wq+ytdM3pNE6iwOFyUEvOsz40/BIPVYlyW+cZ++oPPQEy
	Ou+NvVp2EtZSyUg+IfElknm5CdW4M2GfBm+g9PinJ1j2jF2WAdt4mzvkQwCp0HU=
X-Google-Smtp-Source: AGHT+IHwE4oGRP6USExRO9u406ra40dfIlFnqLpaAW/cH+0rg8oNyYrx9Dp27AHc45IId+0tm6AYEw==
X-Received: by 2002:a2e:7411:0:b0:2d2:3661:487a with SMTP id p17-20020a2e7411000000b002d23661487amr1474672ljc.9.1708696349892;
        Fri, 23 Feb 2024 05:52:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:58e3:6b80:c446:11f4? ([2a01:e0a:982:cbb0:58e3:6b80:c446:11f4])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c198600b004129228da2dsm2444760wmq.31.2024.02.23.05.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 05:52:29 -0800 (PST)
Message-ID: <d4049823-ad24-4426-887b-9c66cdd96318@linaro.org>
Date: Fri, 23 Feb 2024 14:52:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/6] soc: qcom: pmic_glink_altmode: fix drm bridge
 use-after-free
Content-Language: en-US, fr
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org
References: <20240217150228.5788-1-johan+linaro@kernel.org>
 <170868613914.4029284.5549880672870201262.b4-ty@linaro.org>
 <3c4246b6-431a-442e-8ace-3b0d0e67743f@linaro.org>
 <ZdiU2z8rzo542_Ih@hovoldconsulting.com>
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
In-Reply-To: <ZdiU2z8rzo542_Ih@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/02/2024 13:51, Johan Hovold wrote:
> On Fri, Feb 23, 2024 at 12:03:10PM +0100, Neil Armstrong wrote:
>> On 23/02/2024 12:02, Neil Armstrong wrote:
>>> Hi,
>>>
>>> On Sat, 17 Feb 2024 16:02:22 +0100, Johan Hovold wrote:
>>>> Starting with 6.8-rc1 the internal display sometimes fails to come up on
>>>> machines like the Lenovo ThinkPad X13s and the logs indicate that this
>>>> is due to a regression in the DRM subsystem [1].
>>>>
>>>> This series fixes a race in the pmic_glink_altmode driver which was
>>>> exposed / triggered by the transparent DRM bridges rework that went into
>>>> 6.8-rc1 and that manifested itself as a bridge failing to attach and
>>>> sometimes triggering a NULL-pointer dereference.
>>>>
>>>> [...]
>>>
>>> Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)
>>>
>>> [1/6] drm/bridge: aux-hpd: fix OF node leaks
>>>         https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9ee485bdda68d6d3f5728cbe3150eb9013d7d22b
>>> [2/6] drm/bridge: aux-hpd: separate allocation and registration
>>>         (no commit info)
>>> [3/6] soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
>>>         (no commit info)
>>> [4/6] soc: qcom: pmic_glink: Fix boot when QRTR=m
>>>         (no commit info)
>>> [5/6] phy: qcom-qmp-combo: fix drm bridge registration
>>>         (no commit info)
>>> [6/6] phy: qcom-qmp-combo: fix type-c switch registration
>>>         (no commit info)
>>>
>>
>> To clarify, I only applied patch 1 to drm-misc-fixes
> 
> Ok, but can you please not do that? :)
> 
> These patches should go in through the same tree to avoid conflicts.
> 
> I discussed this with Bjorn and Dmitry the other day and the conclusion
> was that it was easiest to take all of these through DRM.

I only applied patch 1, which is a standalone fix and goes into a separate tree,
for the next patches it would be indeed simpler for them to go via drm-misc when
they are properly acked.

Neil

> 
> With Vinod acking the PHY patches, I believe you have what you need to
> merge the whole series now?
> 
> Johan


