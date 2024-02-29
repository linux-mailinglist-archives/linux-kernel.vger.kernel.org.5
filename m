Return-Path: <linux-kernel+bounces-87044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D953986CE98
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FEF1C22542
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216C97580D;
	Thu, 29 Feb 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="boProXf5"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B6D78260
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222269; cv=none; b=DeGSKJ3/kfnVzFdoJrlUe37lSYIX6JIqixCcBpUeWK7PyYrtgDbvCgiSN1L47jkE9/k8l+vdfg7byD+lZ1yBtlhiSzMoReerGcG9Nkht/WDP1kvM8nwq58eY2g3dbXAXQ8Bl+lHNlIbXwEWedzGM2ZTSmn4lUktXEv73Ugx8Y4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222269; c=relaxed/simple;
	bh=uy0F29C4AlGHMMm5EsQdc/gpki7i7E0BmXMpi6d1R3M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rRvOFwkIKbmaa5IPUOyEZ7JAY8JrVolvhSEsiaCS04w58yar+ZQJXPk013hIe013L09m7O109voQutxf2WlkMZTIBP6gRUxSROqsvvcaz02Ha9H8Vz3MHnJ34D6m22jhiLG4WH4ghkc6EMTdKfdSDgD8DiKnr56N7ggyjhyNk+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=boProXf5; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d26227d508so12074481fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709222265; x=1709827065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+rwDvBHwaTiXgJTFlspTAy/0AO9GOtYg0t1vv+rPRo=;
        b=boProXf5FrS9waFSmZtRO6ghFd/zYqiihZdnG9lVFouE9Y7o5QUt7lKQWsVsJ4dfaT
         5qkHQtJGXb5jF6hvxJtSadw52+yGV+tfZhdlci1N1RY22250mGM32gKzli69aKe1OF5n
         JKf42ZXBRcVfAL7PUvWsMhXVuy10FifGFLmvIbaiFXdJgqiUMZWPaq492I26U2DrP6UQ
         +R7EN0cwY//EtmAvAfvh38nTl00LZIM6b+obGxaBnmyENF8pqTsr+VWwGKAGjyzOflvC
         Jf/GTpk3rPA+NzJP5zOHdbgL6lNzgqeE2gw5DxQcxnCN2P+HhOwqIgPPNzMMGdls+7tu
         7wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709222265; x=1709827065;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E+rwDvBHwaTiXgJTFlspTAy/0AO9GOtYg0t1vv+rPRo=;
        b=izuApaAtSmUcjN3CoY8L0Z01nbq8xa8Wje7Fe+SH7Nyo3plkyM0fx5as0GH/242N4q
         exK1sFD1oLU1iXeSnDe1Lw9fuXxvNsjoX8jbnA4F65EGC9dhuwuLLlE1RINtNAacSeOt
         Fnfqg0UeXQyCPuX/v4GYWiCyiXRS6fgLjbcCBn2gAVo8kXVKD28WenbupWsRv8hl4AT0
         UVMXa5qdjjUkXw0XIiyRuGgkwVyZUxKN6WHCGOzAC8vbsv/gFKtxHOXsFCumjeAT95ar
         9vYR3DnlyV4yava/YIyoj3p3lnSJ0W7clJXvhBL/Nr3DNrzMnQBeG1M/j6f70tMouLdJ
         k8/A==
X-Forwarded-Encrypted: i=1; AJvYcCXvY8VNELRCp6+msP+fVPk9Gfhei+tThepyaN8CGUOCNwfKkB//d0A06GTUKTjt+wjzr1gEgWStRgrFM8pbXiIu6jSYkOxgOBsl9YIi
X-Gm-Message-State: AOJu0YxSviJlcayjQzSDvBpaieNedqcpOMqohJE+CklN/lUtbYKaLkLW
	RS1rtqI+CG76faU1cwfk+fwab/e4uQ+uRnx1GD2jf2/HB/NIWoEspDeua8aTzVM=
X-Google-Smtp-Source: AGHT+IGI2JH+zfnqb3Mv9icKAn7vZ+xHOoCRLh8m+XQgLc0NwrnMh2W2RRFh0niWjbPFKKVRZnJapw==
X-Received: by 2002:a05:651c:8c:b0:2d2:954e:aceb with SMTP id 12-20020a05651c008c00b002d2954eacebmr1627300ljq.53.1709222265542;
        Thu, 29 Feb 2024 07:57:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:651:5318:b12c:be82? ([2a01:e0a:982:cbb0:651:5318:b12c:be82])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c210a00b00410df4bf22esm5534462wml.38.2024.02.29.07.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 07:57:45 -0800 (PST)
Message-ID: <a0a082b6-7647-4fd9-b0da-db973ae09f27@linaro.org>
Date: Thu, 29 Feb 2024 16:57:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFT 4/7] phy: qcom: qmp-combo: register a typec mux to
 change the QPHY_MODE
Content-Language: en-US, fr
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
 <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-4-07e24a231840@linaro.org>
 <CAA8EJpoZn5V8N3=4x4AfYM91XBuCZx47vSS8tB-nCP=LvVsD6g@mail.gmail.com>
 <d50ca4c0-8954-4e4c-9ce9-2c40ebacf8b0@linaro.org>
 <CAA8EJpq0E_t6bi4TymtpxdX0ZHHNJgBU2gFEEZDWSUZg27pEvw@mail.gmail.com>
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
In-Reply-To: <CAA8EJpq0E_t6bi4TymtpxdX0ZHHNJgBU2gFEEZDWSUZg27pEvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/02/2024 16:54, Dmitry Baryshkov wrote:
> On Thu, 29 Feb 2024 at 17:47, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> On 29/02/2024 16:25, Dmitry Baryshkov wrote:
>>> On Thu, 29 Feb 2024 at 15:08, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>
>>>> Register a typec mux in order to change the PHY mode on the Type-C
>>>> mux events depending on the mode and the svid when in Altmode setup.
>>>>
>>>> The DisplayPort phy should be left enabled if is still powered on
>>>> by the DRM DisplayPort controller, so bail out until the DisplayPort
>>>> PHY is not powered off.
>>>>
>>>> The Type-C Mode/SVID only changes on plug/unplug, and USB SAFE states
>>>> will be set in between of USB-Only, Combo and DisplayPort Only so
>>>> this will leave enough time to the DRM DisplayPort controller to
>>>> turn of the DisplayPort PHY.
>>>
>>> I think this is not fully correct. Please correct me if I'm wrong, but
>>> it is possible to switch between USB / USB+DP / DP-only at runtime.
>>> See the Status Update and Configure commands.
>>
>> Yes, but the current implementation is still valid because we need to
>> have the DP powered-off before changing the PHY mode.
> 
> Even for switching between 2 lane and 4 lane modes?

So the Altmode pin assignment says how much lanes you can get (2 or 4),
and AUX data will say how much the adapter/display supports.

My native DP monitor uses the 4 lanes, while my USB-C->HDMI dongles
declares the 4lanes pin assigment but DP controller only ever tries 2 lanes.

I don't have USB-C->HDMI with 4lanes DP, but it should work fine.

Neil

> 
> I'll check how my USB-A+DP dongles work with respect to the altmode
> configuration.
> 
>>
>> I never encountered such setup and I have no idea how to test this.
>>
>>>
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> 


