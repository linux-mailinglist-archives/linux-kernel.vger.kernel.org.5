Return-Path: <linux-kernel+bounces-21875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518368295B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8BF1C21694
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9610B3BB4C;
	Wed, 10 Jan 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LuFTYoR0"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479083B787
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e490c2115so16382545e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704877559; x=1705482359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGn05+FOp2S6kGAYx1CC3XYu3wPlmxWSpkBFMyATYt8=;
        b=LuFTYoR0IVXxHT8hgg40KLgFQv/7HjpvXeQpUc0kqD/O5qwK1o0lJaubSjFPttny+a
         L2LnyGzzX1Nd8VEhdgv8kLsFa8+Sk0G/mxONzDOeTCA+oeETh+yb205SKK9fEwyrOz/r
         NbP+fod4TV/pgT4vVIh5FcAc7ALRUqeaVs6CEGkjxuHaFSLAl+OyKuNvsCxAGyKPIAZx
         Nz81QNsioQ5Wu31sW9Hcoak8HFBjFeSLIoSAd21NpoZptNl4A/GbThS71Xp/jajRDlsD
         YvVbDxch2gbfQzN9ecsRDUMv27HJhNl/JmhUVewklc3RAyL1KWtJJ02EeRVDCZRLVN7I
         WC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704877559; x=1705482359;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YGn05+FOp2S6kGAYx1CC3XYu3wPlmxWSpkBFMyATYt8=;
        b=Iub1ej4TUOuXiVGFCKMKQRuaFCgQ8haJumXrKZZNvwef8wQKFgGJuq6O5PxjMIbvCU
         6aVgI5oYirGRixXFPtwYaKF2Eb2r//YP2e6v/b0ruZzN8pbBCoAXdPgHFCaNEq2031sI
         BDOCPiRGK/b95vvrWUyYCVF3wiOFLgT3Pv98vFkJafMsvh1TM5ZRwU+1/xfcVUBFi6tf
         ufIy1+rvZoiU1VGaz/hxTPnCH7z3VOccwf/eYnYGqZpFQ6GKbH4LRugcMJdMuWTHY4Pf
         tQ7DAej9/lq0CATlj1LiocujFVQj3UlzV6rb+oLq/A2cJzYaHamNjpVAdhH/8bo2dlrl
         ZooA==
X-Gm-Message-State: AOJu0YxG8vGypdOnUJGTYudpNTAXDyCLpnFb9qXqIZmVQXJcQ8EVHy1X
	wj/iakNU5/ija6C/BKtSE31nK0ZgpA+btQ==
X-Google-Smtp-Source: AGHT+IEFouJoUbml6X/7HBn2vGnyrbIlj3qsE0X5+d3U6eg+CtsrfuuLfyDPpRGpHb1rp2//5OPqsQ==
X-Received: by 2002:a05:600c:1e84:b0:40e:4a73:f6b7 with SMTP id be4-20020a05600c1e8400b0040e4a73f6b7mr374107wmb.150.1704877559419;
        Wed, 10 Jan 2024 01:05:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5dee:51de:9349:2adf? ([2a01:e0a:982:cbb0:5dee:51de:9349:2adf])
        by smtp.gmail.com with ESMTPSA id fs14-20020a05600c3f8e00b0040e38b7cfdasm1412519wmb.4.2024.01.10.01.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 01:05:58 -0800 (PST)
Message-ID: <80b898a0-1f44-4623-9df2-edccb9307098@linaro.org>
Date: Wed, 10 Jan 2024 10:05:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: panel-simple: Add
 compatible property for waveshare 7inch touchscreen panel
Content-Language: en-US, fr
To: Conor Dooley <conor@kernel.org>,
 Shengyang Chen <shengyang.chen@starfivetech.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 quic_jesszhan@quicinc.com, sam@ravnborg.org, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, wahrenst@gmx.net, dave.stevenson@raspberrypi.com,
 thierry.reding@gmail.com, changhuang.liang@starfivetech.com,
 keith.zhao@starfivetech.com, jack.zhu@starfivetech.com,
 linux-kernel@vger.kernel.org
References: <20240109070949.23957-1-shengyang.chen@starfivetech.com>
 <20240109070949.23957-2-shengyang.chen@starfivetech.com>
 <20240109-worsening-material-fae02ff4e611@spud>
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
In-Reply-To: <20240109-worsening-material-fae02ff4e611@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/01/2024 17:32, Conor Dooley wrote:
> On Tue, Jan 09, 2024 at 03:09:48PM +0800, Shengyang Chen wrote:
>> The waveshare 7" 800x480 panel is a clone of Raspberry Pi 7" 800x480 panel
>> It can be drived by Raspberry Pi panel's process but it needs different
>> timing from Raspberry Pi panel. Add compatible property for it.
>>
>> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
>> Signed-off-by: Shengyang Chen <shengyang.chen@starfivetech.com>
>> ---
>>   .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
>> index 11422af3477e..02f6b1b2ddc9 100644
>> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
>> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
>> @@ -335,6 +335,8 @@ properties:
>>         - vivax,tpc9150-panel
>>           # VXT 800x480 color TFT LCD panel
>>         - vxt,vl050-8048nt-c01
>> +        # Waveshare 7" (800x480) touchscreen LCD panel
>> +      - waveshare,7inch-touchscreen
> 
> Is "7inch-touchscreen" really a specific enough identifier for this
> device?

Waveshare has very precise SKUs, this should be something like waveshare,7inch-dsi-sku19885 perhaps

Neil

> 
>>           # Winstar Display Corporation 3.5" QVGA (320x240) TFT LCD panel
>>         - winstar,wf35ltiacd
>>           # Yes Optoelectronics YTC700TLAG-05-201C 7" TFT LCD panel
>> -- 
>> 2.17.1
>>


