Return-Path: <linux-kernel+bounces-27178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D36B82EB9C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFFD285297
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5357212B90;
	Tue, 16 Jan 2024 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLa1BHrI"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE412B7D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e78238db9so16883245e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705397659; x=1706002459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scaiOvL+sHXGXBndgR8Y3X1QJKhL+HNInVidZxI8/34=;
        b=aLa1BHrIGoch8FCnzx5jyjkjn7cK5P+tY9o4IFRTXQUhsyf8nbPVDdjsfXY8oOQhTD
         Rt0Muzi4gZ8tBuZKpYp4RGPYxxwCo8ytTqZEju7SHz9vvn00HUDAyqKFAYdJ33doNP3i
         Oreuq3DNiIM+wpTnaHCTwtUt6AmuFy+O72M94swORCe1kJ/7+zWiUxq/FXXXIKNKRLNk
         Qx3lTn1C/v3XCxF+xbsmMJTnFg0q/bVPv8u3ththKezzJFDXhAxrvHcODktmBNY36B8B
         Rmtc5nVeT16py4QVrRiyIssB+dBTpcfaTj+na88hCzUBeZvBDuaLBObYkM6c5Somb3xR
         w9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705397659; x=1706002459;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=scaiOvL+sHXGXBndgR8Y3X1QJKhL+HNInVidZxI8/34=;
        b=I6xQKwwwABOoSp8vA8q2Mnj0J7EipDvDPUWlKkyWHZFhiwlq0v8HUmi36ZnFT6yAC5
         BIISHx3jgQYA2l+j/sXIYoy/5njCGBOGV5gHVNpqmOpdh8dcMInIVSv9UBSTIrhb9rcw
         grJ/uK83gnTLujhYuinPmzKGKqBHePaeYz2ECkLj2CqX+I4jdwMWj42gknOXQu0RaQDr
         efLArmyrSpXfl0POVpuZpnyc2VmCTNwIVpYxazjjAjgncEVQ4GOIBsk+dl6cdyuJnNyt
         0n9AbxE+0jaKcOPOSZp3kZXGAtvvyWOJ6o0H77evZ0uBH+ChEI0RGho38ZItRNl9hyIg
         YAZw==
X-Gm-Message-State: AOJu0YymsZcOggAR3Hpm/LdjWkU5szqp+p7B4fx6iwoZePbjhIr9Z8XL
	ida6o4QuTS3u3AlGymdWAAVI0DnbDwyMzg==
X-Google-Smtp-Source: AGHT+IGK1foTTcURYUk+FuNSxXLTJ3GwXxB9NPta21goS9Ylzyw9DDtzjlYaWBBRuYi91H+rCptOyQ==
X-Received: by 2002:a05:600c:a005:b0:40e:3772:cb56 with SMTP id jg5-20020a05600ca00500b0040e3772cb56mr3866601wmb.8.1705397659111;
        Tue, 16 Jan 2024 01:34:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:30a6:c236:cc88:349e? ([2a01:e0a:982:cbb0:30a6:c236:cc88:349e])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b0040e4746d80fsm18723036wmq.19.2024.01.16.01.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 01:34:18 -0800 (PST)
Message-ID: <4ce0ce11-771d-48b5-8ef1-e7671d7c9615@linaro.org>
Date: Tue, 16 Jan 2024 10:34:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/2] Add waveshare 7inch touchscreen panel support
Content-Language: en-US, fr
To: Shengyang Chen <shengyang.chen@starfivetech.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "quic_jesszhan@quicinc.com" <quic_jesszhan@quicinc.com>,
 "sam@ravnborg.org" <sam@ravnborg.org>, "airlied@gmail.com"
 <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "wahrenst@gmx.net" <wahrenst@gmx.net>,
 "dave.stevenson@raspberrypi.com" <dave.stevenson@raspberrypi.com>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Changhuang Liang <changhuang.liang@starfivetech.com>,
 Keith Zhao <keith.zhao@starfivetech.com>,
 Jack Zhu <jack.zhu@starfivetech.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240109070949.23957-1-shengyang.chen@starfivetech.com>
 <99d7bb85-17b0-4b5e-a6cf-f5957ad92298@linaro.org>
 <ZQ0PR01MB10626BCA7ACA6CB9754BB70BEF73A@ZQ0PR01MB1062.CHNPR01.prod.partner.outlook.cn>
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
In-Reply-To: <ZQ0PR01MB10626BCA7ACA6CB9754BB70BEF73A@ZQ0PR01MB1062.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/01/2024 10:32, Shengyang Chen wrote:
> Hi, Neil
> 
> Thanks for your comment.
> 
>> -----Original Message-----
>> From: neil.armstrong@linaro.org <neil.armstrong@linaro.org>
>> Sent: 2024年1月9日 19:19
>> To: Shengyang Chen <shengyang.chen@starfivetech.com>;
>> devicetree@vger.kernel.org; dri-devel@lists.freedesktop.org
>> Cc: quic_jesszhan@quicinc.com; sam@ravnborg.org; airlied@gmail.com;
>> daniel@ffwll.ch; maarten.lankhorst@linux.intel.com; mripard@kernel.org;
>> tzimmermann@suse.de; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; wahrenst@gmx.net;
>> dave.stevenson@raspberrypi.com; thierry.reding@gmail.com; Changhuang
>> Liang <changhuang.liang@starfivetech.com>; Keith Zhao
>> <keith.zhao@starfivetech.com>; Jack Zhu <jack.zhu@starfivetech.com>;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v2 0/2] Add waveshare 7inch touchscreen panel support
>>
>> Hi,
>>
>> On 09/01/2024 08:09, Shengyang Chen wrote:
>>> This patchset adds waveshare 7inch touchscreen panel support for the
>>> StarFive JH7110 SoC.
>>
>> Could you precise which SKU you're referring to ? is it 19885 =>
>> https://www.waveshare.com/7inch-dsi-lcd.htm ?
>>
> 
> yes, it is
> sorry for confusing you.
> 
>> Are you sure it requires different timings from the RPi one ? In the Waveshare
>> wiki it explicitly uses the rpi setup (vc4-kms-dsi-7inch) to drive it:
>> https://www.waveshare.com/wiki/7inch_DSI_LCD
>>
> 
> Referring to Keith's answer
> https://lists.freedesktop.org/archives/dri-devel/2023-December/434200.html
> the panel timing value is generated to fit phy's bitrate and prevent overflow and underflow.
> 
> Referring to the suggestion, we may try other timing from panel-simple to drive the panel.

Please implement a mode_fixup in your DSI host driver instead.

Neil

> 
>> Neil
>>
>>>
>>>
>>> changes since v1:
>>> - Rebased on tag v6.7.
>>>
>>> patch 1:
>>> - Gave up original changing.
>>> - Changed the commit message.
>>> - Add compatible in panel-simple.yaml
>>>
>>> patch 2:
>>> - Gave up original changing.
>>> - Changed the commit message.
>>> - Add new mode for the panel in panel-simple.c
>>>
>>> v1:
>>> https://patchwork.kernel.org/project/dri-devel/cover/20231124104451.44
>>> 271-1-shengyang.chen@starfivetech.com/
>>>
>>> Shengyang Chen (2):
>>>     dt-bindings: display: panel: panel-simple: Add compatible property for
>>>       waveshare 7inch touchscreen panel
>>>     gpu: drm: panel: panel-simple: add new display mode for waveshare
>>>       7inch touchscreen panel
>>>
>>>    .../bindings/display/panel/panel-simple.yaml  |  2 ++
>>>    drivers/gpu/drm/panel/panel-simple.c          | 28
>> +++++++++++++++++++
>>>    2 files changed, 30 insertions(+)
>>>
> 
> 
> Best Regards,
> Shengyang


