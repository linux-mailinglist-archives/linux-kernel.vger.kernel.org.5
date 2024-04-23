Return-Path: <linux-kernel+bounces-155341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF448AE91F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8F91F2360E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D74138499;
	Tue, 23 Apr 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S6z+Zc0s"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AAA137918
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881328; cv=none; b=GW3Si7h4f24VKNkIKPTOMhU60Jx4BglWwz0KaQViIGxGLGTf1lo+INipzpDjvsGXxFxNVukeLMuqh1yNK+jsWzhEfBlO42zGi5YKupKAgg9sp3OztjbakppBWwe8GwYrD5UDn3Obdw+ewGHrVljij550uhGlVetvZdsda/aVtdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881328; c=relaxed/simple;
	bh=IWCU0w3VL0cvSLjhHzfvAO7YugroezgVY+Qah+oy6jg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=b1KUAoVRFlNPiO2OagcOKICETXjNz0ce75k5L/SnE39fVR7GaHMQcBmcpU0m4NBDr6mjQdVtPuEZ8a3Vc7rsZp3f1BQoHx8bWVt9XIIpquxFq5b3D7A5DonA3CVjDSak7fP0+7VBmDl5Gdcc6mawZRINmb0GGbDQCzQYKlviZoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S6z+Zc0s; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso30313695e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713881325; x=1714486125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1BoVNFpU0aThQ3DZVA1XTVmetSk4HOUliHNQd7s2Lg=;
        b=S6z+Zc0sptV3BqEA8gjLQ0GBFmeaePjtrgZe1OYsPNtu7dlgOo1SnuXeU3bPxgqBti
         0pkuJRao7uvEZ7KMe1DpFUcKO5Se+82PaFhc+xKKjAQFT8t9/APdOL90NvDqethvMEXU
         SCuvVw+RCNMVXk9kz1zxhqZl5ND21Scj1NwhFzNujtJtRy9F2I06XZqAf43RTJq2cQJE
         UyRXzs1ZMfbNPpK7vDjZA3/qyf9jWYpLdnsj18Rw2S1RAccBBdjmsJdpx9OQykZgF6Vb
         eLeXvxnLPEbKRNH4pRRaOCy0W/7p1G7e6QPpMMBdjCWtTapVqwonSilSnIjIzwpo/7YN
         wr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713881325; x=1714486125;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b1BoVNFpU0aThQ3DZVA1XTVmetSk4HOUliHNQd7s2Lg=;
        b=XmpDoQg865yQeFto3EAAayhoHrWRoeeQvghoHklEi01KWaJx6cgiYp1hn1bHEm+vEs
         Hn+SwjoXJV8p3yTQhFybYpz2+2dlV5C8fX1SZFriOkDXDchdWcc+9GRh2WIerOJoTJA0
         6Fz0UpfgP3wb2wlvPDn+9y9jl+wdEOvp+69sayJ/URx4SHYi3vUArk3ZVFFX+rtzfu8p
         lYn0XxRyhdAV0tr++lgSx8D7zmhNKavSSooejDFTCfBMZq6Jviwydl8C5q+mEFyKMkgO
         5OX1GDCp2DPoV237D86VYV4dWvVpT80RPbQdNCy1C//FNdtiPb8dz4wR1QR1mveCA1v0
         EEXw==
X-Forwarded-Encrypted: i=1; AJvYcCWZFlvMwHdCWUbSrW7alBNkIFBxHiudEm3KYXj8uine4aIBAHAwfJq0Zv61WmZl3c9P/0i+uh4t+ExhWhxwJpoyQSfm8zp1uKem4X16
X-Gm-Message-State: AOJu0Yz1gXppyWFIbdDc+5snLgI6TvkM3Ac6whiDq0DDMEy47GPyvVED
	0BYkX6plZFQjKc5RWWNcRhLspsFzDcFMnTEe2iwk07s/dQG8yu8VS4Rwn27YaZA=
X-Google-Smtp-Source: AGHT+IG40KDQ1MC6cSzKj7qM2lR4kQsCPwKdIVDQbpX2/BBZIqVwoVg6yVQRHufyqvSCY9BG+P/NYA==
X-Received: by 2002:a5d:4d4b:0:b0:33e:7fbc:caea with SMTP id a11-20020a5d4d4b000000b0033e7fbccaeamr9901956wru.34.1713881325174;
        Tue, 23 Apr 2024 07:08:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:dfee:1061:7e39:bfff? ([2a01:e0a:982:cbb0:dfee:1061:7e39:bfff])
        by smtp.gmail.com with ESMTPSA id q12-20020adfcd8c000000b00343cad2a4d3sm14625332wrj.18.2024.04.23.07.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 07:08:44 -0700 (PDT)
Message-ID: <864063fb-eeae-4eb7-9089-0d98011a0343@linaro.org>
Date: Tue, 23 Apr 2024 16:08:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFT 0/7] arm64: qcom: allow up to 4 lanes for the Type-C
 DisplayPort Altmode
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Bjorn Andersson <andersson@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
 <CZUHV429NTF7.1GW9TN9NXB4J1@fairphone.com>
 <7a7aa05f-9ae6-4ca0-a423-224fc78fbd0c@linaro.org>
 <liah4xvkfattlen7s2zi3vt2bl5pbbxqgig3k5ljqpveoao656@iacnommxkjkt>
 <236a104c-fc16-4b3d-9a00-e16517c00e3a@linaro.org>
 <D064242SMIVM.1GUC1I9GE9IGC@fairphone.com>
 <963b60e5-6ab7-4d9f-885a-ba744c2b7991@linaro.org>
 <D0C42YR1270X.23P9WCWWNB8XF@fairphone.com>
 <f2d96f99-d8ac-4ff1-83fa-742e541565e4@linaro.org>
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
In-Reply-To: <f2d96f99-d8ac-4ff1-83fa-742e541565e4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/04/2024 15:03, Konrad Dybcio wrote:
> 
> 
> On 4/5/24 12:19, Luca Weiss wrote:
>> On Fri Apr 5, 2024 at 10:08 AM CEST, Neil Armstrong wrote:
>>> Hi Luca,
>>>
>>> On 29/03/2024 10:02, Luca Weiss wrote:
>>>> On Tue Mar 26, 2024 at 10:02 PM CET, Konrad Dybcio wrote:
>>>>> On 16.03.2024 5:01 PM, Bjorn Andersson wrote:
>>>>>> On Fri, Mar 15, 2024 at 06:35:15PM +0100, Neil Armstrong wrote:
>>>>>>> On 15/03/2024 18:19, Luca Weiss wrote:
>>>>>>>> On Thu Feb 29, 2024 at 2:07 PM CET, Neil Armstrong wrote:
>>>>>>>>> Register a typec mux in order to change the PHY mode on the Type-C
>>>>>>>>> mux events depending on the mode and the svid when in Altmode setup.
>>>>>>>>>
>>>>>>>>> The DisplayPort phy should be left enabled if is still powered on
>>>>>>>>> by the DRM DisplayPort controller, so bail out until the DisplayPort
>>>>>>>>> PHY is not powered off.
>>>>>>>>>
>>>>>>>>> The Type-C Mode/SVID only changes on plug/unplug, and USB SAFE states
>>>>>>>>> will be set in between of USB-Only, Combo and DisplayPort Only so
>>>>>>>>> this will leave enough time to the DRM DisplayPort controller to
>>>>>>>>> turn of the DisplayPort PHY.
>>>>>>>>>
>>>>>>>>> The patchset also includes bindings changes and DT changes.
>>>>>>>>>
>>>>>>>>> This has been successfully tested on an SM8550 board, but the
>>>>>>>>> Thinkpad X13s deserved testing between non-PD USB, non-PD DisplayPort,
>>>>>>>>> PD USB Hubs and PD Altmode Dongles to make sure the switch works
>>>>>>>>> as expected.
>>>>>>>>>
>>>>>>>>> The DisplayPort 4 lanes setup can be check with:
>>>>>>>>> $ cat /sys/kernel/debug/dri/ae01000.display-controller/DP-1/dp_debug
>>>>>>>>>     name = msm_dp
>>>>>>>>>     drm_dp_link
>>>>>>>>>         rate = 540000
>>>>>>>>>         num_lanes = 4
>>>>>>>>
>>>>>>>> Hi Neil,
>>>>>>>>
>>>>>>>> I tried this on QCM6490/SC7280 which should also support 4-lane DP but I
>>>>>>>> haven't had any success so far.
>>>>>>>>
>>>>>> [..]
>>>>>>>> [ 1775.563969] [drm:dp_ctrl_link_train] *ERROR* max v_level reached
>>>>>>>> [ 1775.564031] [drm:dp_ctrl_link_train] *ERROR* link training #1 failed. ret=-11
>>>>>>>
>>>>>>> Interesting #1 means the 4 lanes are not physically connected to the other side,
>>>>>>> perhaps QCM6490/SC7280 requires a specific way to enable the 4 lanes in the PHY,
>>>>>>> or some fixups in the init tables.
>>>>>>>
>>>>>>
>>>>>> I tested the same on rb3gen2 (qcs6490) a couple of weeks ago, with the
>>>>>> same outcome. Looking at the AUX reads, after switching to 4-lane the
>>>>>> link training is failing on all 4 lanes, in contrast to succeeding only
>>>>>> on the first 2 if you e.g. forget to mux the other two.
>>>>>>
>>>>>> As such, my expectation is that there's something wrong in the QMP PHY
>>>>>> (or possibly redriver) for this platform.
>>>>>
>>>>> Do we have any downstream tag where 4lane dp works? I'm willing to believe
>>>>> the PHY story..
>>>>
>>>> Just tested on Fairphone 5 downstream and 4 lane appears to work there.
>>>> This is with an USB-C to HDMI adapter that only does HDMI.
>>>>
>>>> FP5:/ # cat /sys/kernel/debug/drm_dp/dp_debug
>>>>           state=0x20a5
>>>>           link_rate=270000
>>>>           num_lanes=4
>>>>           resolution=2560x1440@60Hz
>>>>           pclock=241500KHz
>>>>           bpp=24
>>>>           test_req=DP_LINK_STATUS_UPDATED
>>>>           lane_count=4
>>>>           bw_code=10
>>>>           v_level=0
>>>>           p_level=0
>>>>
>>>> Sources are here:
>>>> https://gerrit-public.fairphone.software/plugins/gitiles/kernel/msm-5.4/+/refs/heads/odm/rc/target/13/fp5
>>>> And probably more importantly techpack/display:
>>>> https://gerrit-public.fairphone.software/plugins/gitiles/platform/vendor/opensource/display-drivers/+/refs/heads/odm/rc/target/13/fp5
>>>> Dts if useful:
>>>> https://gerrit-public.fairphone.software/plugins/gitiles/kernel/msm-extra/devicetree/+/refs/heads/kernel/13/fp5
>>>
>>> Could you retry with this applied ?
>>>
>>> https://lore.kernel.org/all/20240405000111.1450598-1-swboyd@chromium.org/
>>
>> Unfortunately I do not see any change with this on QCM6490 Fairphone 5
>> and 4-lane DP.
> 
> Hm, could you like dump all the PHY regions up and downstream with the display
> connected (and nothing connected) and compare them?

Yes would be great, PHY regions and DP regions as well.

Neil

> 
> Konrad


