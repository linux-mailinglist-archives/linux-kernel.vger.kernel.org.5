Return-Path: <linux-kernel+bounces-158159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AF78B1C54
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFAD21F22E60
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0B56EB40;
	Thu, 25 Apr 2024 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QnkjS4YI"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129B16E605
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031866; cv=none; b=fmav9sg5sHIV6nWHhOJZbzDM5g8hntjM4DbDMO1axapninGwrX6diCx4g/AwU1KSrG90X+FusOQSn2D7YRl3ReWKLiuPdn7mS1mKCVDOvOFojaSu/BTcdZRBtIQTP+b42AjWO+iypI690k9/u5Jovl7Wx7L53TDg5XJWHAJW9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031866; c=relaxed/simple;
	bh=PBSIenB57GzBOC3DNr8CreMwJgWwbmdkburzd3odZfI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hjmiFRGuMiDIVZrBRlL50MEIWo8NVHLxoiRcipyEaQ9LY3+CPP55UBIqesMLuI7hN7sqi6DLMSt8RmPO2AQ2q17RsnIR9lWG6HFLy1KFlYatzayKM4gH78TQINDBPTNvy5cZ67ksulFPSI/ScI+CbusCmpYwQ1ZLENzmNOxezv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QnkjS4YI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41adf3580dbso3884075e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714031863; x=1714636663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zlRN8GDdJRPh97Fl0bz7cJhpbCIiQnJ+fEE7Z9TrLA=;
        b=QnkjS4YItWZ39Z/xMN0XPD30R0GK6JQefXwutLIdSW4gPXeKm94TZXwxB1DjpWxjb3
         MJJ1uNPzodww2xnmL13XoUuondd/AakoeUv4ukXW8UzvPQB9qft7jn+ASAtHiCaDP490
         hBsvUAjCJWEn6Yr6Nbz4f4vdt81Td2RD7HaeiF8TQqexDM4ipOAG3sTNu8fz/C41CTM5
         xW66L5Qdjn0wy7kgulISRB3w9X73hJireu0hGRNbVuiyanlyAY1CTqhIPnoqtLu9HR0w
         FylJqdMeqozM/fuMH3IXkKkAb40Fd2iDrwYE4WiLx4ak0uyQ1zkfy/ovL6ZZ++EunV7a
         eJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714031863; x=1714636663;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8zlRN8GDdJRPh97Fl0bz7cJhpbCIiQnJ+fEE7Z9TrLA=;
        b=nS6KACOmq/pv59QR+C4a4KSOlfhQin6MZEagNmY2qc8T4xg08WYtuATML2DfNLml+l
         Co8b3YfoBvJWtdesw0df95g4hgadnA2n+AO6myhw8zONTWy9xi+TEuBYq6K1PBqvLj1R
         4ui0jafHufk58LVPJhXwZ+brFlw2P6LWNV3qqtnkVVwy+nEJvY8wOSxvwB4lMXhNvjSB
         F30+vHmXcNEVsXl2XH4RRdoF9/PWGE9kJwh10ufzXH98gmRYbQYb23KH+eCfEeXrgkoL
         mEtxZwV4RBf2fTAvqlHt7WYFRoq1ssMahpYy96SAeYhj2h5abPYhpevEFnKrVdGitoFY
         rP9A==
X-Forwarded-Encrypted: i=1; AJvYcCVQUVjwrKKaIPYIkJ48pqROJGcFlOpSwndK+r7gMywUJMJJL5SVTVPiFPkmUbyZq+6gxVhQpytvYJzQUNLT/Fm3hAmtH4O1Y2xqsRXI
X-Gm-Message-State: AOJu0YwYeUpNh0ZcqNTxng4pudBq/muK2oKTQz5KMLSVXCQXb2ysIocl
	WueFbn/Lw3/N1o11bTUI+Hhjw+sSRTiUnjAEB0zszSUseCL9aAFn88t10f1znh0=
X-Google-Smtp-Source: AGHT+IEpMpy5TC3zOgYRtvmVoIm1qs4qkyA+/az+AVHs/P5SNCTPkiTTQpAEom45V2JdpFsBAoc5Dw==
X-Received: by 2002:a05:600c:4694:b0:419:f4d6:463b with SMTP id p20-20020a05600c469400b00419f4d6463bmr1330537wmo.14.1714031862971;
        Thu, 25 Apr 2024 00:57:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15c7:bd9c:c500:ed62? ([2a01:e0a:982:cbb0:15c7:bd9c:c500:ed62])
        by smtp.gmail.com with ESMTPSA id m25-20020a05600c3b1900b0041816c3049csm26579080wms.11.2024.04.25.00.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 00:57:42 -0700 (PDT)
Message-ID: <bed21ca2-54c0-473d-b84b-2b404899a050@linaro.org>
Date: Thu, 25 Apr 2024 09:57:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 02/10] pwm: Add SI-EN SN3112 PWM support
To: Junhao Xie <bigfoot@classfun.cn>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, wuxilin123@gmail.com,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Molly Sophia <mollysophia379@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-2-e0aa05c991fd@gmail.com>
 <af62742c-8d6d-4fa9-b2e4-f83253e6e388@linaro.org>
 <361fc6a0-f0d0-49b2-b885-3b197294ec9f@classfun.cn>
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
In-Reply-To: <361fc6a0-f0d0-49b2-b885-3b197294ec9f@classfun.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/04/2024 02:57, Junhao Xie wrote:
> On 2024/4/25 03:37, Konrad Dybcio wrote:
>> On 4/24/24 17:29, Xilin Wu via B4 Relay wrote:
>>> From: Junhao Xie <bigfoot@classfun.cn>
>>>
>>> Add a new driver for the SI-EN SN3112 12-channel 8-bit PWM LED controller.
>>>
>>> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
>>> ---
>> [...]
>>> +    return sn3112_write_reg(priv, SN3112_REG_PWM_EN + reg,
>>> +                priv->pwm_en_reg[reg]);
>>
>> This looks like a weird reimplementation of regmap_update_bits
>>
> 
> We cannot use regmap_update_bits because this chip does not support read command.
> It will discard all read command.

You could use regmap cache with all registers marked as cacheable, but not sure it's worth
doing this.

Neil

> 
>>> +}
>>> +
> [...]
>>
>> devm_pwmchip_add?
>>
>> Konrad
> 
> Thank you for your reply, I will fix them.
> 


