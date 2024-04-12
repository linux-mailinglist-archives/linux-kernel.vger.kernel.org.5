Return-Path: <linux-kernel+bounces-142696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A89208A2F12
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2C8B230BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EDE5DF0D;
	Fri, 12 Apr 2024 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBCCiHRx"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA155F547
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927525; cv=none; b=NjXOM7OnS+LpDJI/3hRmuw+ED2UoTW6Xu3UqEhBZcegSbyCTbCjnnF7/74XTLOVvba+rl9HxLD74vXqu05CNJv9FZ/fFUfOflSr0po8LDq0QltBgHWvNiHjb2enQ8XRGjX8duFoFbrhAFLVchFo/Q0+F5QoVYlw3Jv3X548fEhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927525; c=relaxed/simple;
	bh=phON+SCPikA3YrvYAY5Xqtals9OPuiY14/DTyk9Cm7Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dn/0VzyW5WxovTAnytBRP2ClFrSltusSIsiKKUTOwpZDu+KLMpOiqX3KwtAu+iF2xiNXlTSlYG6pseVraXbTtEoYgyoWCvP8JQwc3ci5z0DnA3grv7DpRiPPtshpBD/lMCsZM7ocn2KQmO1Z0ISMySZfIfchYWu8q0tIACRHvP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SBCCiHRx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3455ff1339dso550862f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712927522; x=1713532322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQ0L1lTlp0VaxEc/hCXJVTS/lOCsBpaPDpagV2ZMnic=;
        b=SBCCiHRxS5tgmAuH5xbf9PrMTgRKKcitHZ9NRtduJF05OmNGChPSMXMgBRBB/rdJ9Q
         z9ihu9yUsSQBs+pDeZWWtgwz+613LhvJtvEw0Pa4ygt1EPxaTev8+ufjrQ/GSs2qxxwQ
         l1z1cuuS/57EPwKW7SHD2LoZ5WWlhrS2VhD0EkzioBJ0ISKXlwBTb4esJo+ZnUykCKx7
         ulO2RHq9TGNq/azI05k2Zh11pwLFcwRtCTM1nlg4jn9AHoBzMVVSVjgpT0fAs7yVZD/T
         BDYbY8F3PhSB+a8mvKOvVH6qJH1f8qx5IJjJN3R/u/EN6oGUc1P0hM/u47RwzfNeRUcL
         dqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927522; x=1713532322;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HQ0L1lTlp0VaxEc/hCXJVTS/lOCsBpaPDpagV2ZMnic=;
        b=d5Ctsjfcdgy7mF/oQ6ca+JNFQe1sIEJTxSWn3mmRm0JksqyVYCoZspK1f6nnK496B/
         4J4B+as7X2sWpYOh3hvgG8bE1iD77wttUqeC/6Pjvx7ZRs4XRt3sxMj76R7XN3vdN3Un
         rxTZ/L9FRiLm1/WSjsluBFjlVgqX6ct8Ez0q8hnOoIz3sJxMaglSlw3xoYpAP7WWGN8x
         kRlHnXUL+NgMrrD1MXJmys1Jyqpz8vpckiYPIszDsqkXovZNM4aSMw9XfEcMFsFqO+ON
         bhsg399VE5QPzF9zmZPcPSWRoE+/hbzk7F89VYgCd1rsENgSG6ZuetY4xoSe4nJCRNba
         a0gg==
X-Forwarded-Encrypted: i=1; AJvYcCU9H3yuyGRyQKXUNFmvFUjdqDJoz9GcM12YY6sEAe0tZIXdJ7fkG46v3+1ExzB3aoldEWJav5k4oP4LcjoILRN3S7NeBvawWXO91QH7
X-Gm-Message-State: AOJu0Yz/1hq8DOPZu2X7OsdSqL2mDHvRi11/q4mHIDZDmNCeiZm0rTN5
	//gQC4bBV1AvVCRha+3zBlmHo1PDB7HarpKs2pnD4Bk4zUTzcqymAM1KhExTBBA=
X-Google-Smtp-Source: AGHT+IE5Zi7ZrlXGaEdi53dt4XiFi3zXa53JxDtMekuN6h8VpfwL+rzY9QfseJ9e4XvEwbI3EVbvvA==
X-Received: by 2002:adf:e5c5:0:b0:347:ced:c7c7 with SMTP id a5-20020adfe5c5000000b003470cedc7c7mr1491393wrn.9.1712927522091;
        Fri, 12 Apr 2024 06:12:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:986c:54c:12ce:a121? ([2a01:e0a:982:cbb0:986c:54c:12ce:a121])
        by smtp.gmail.com with ESMTPSA id h6-20020a5d5046000000b00346df659e7dsm2857058wrt.17.2024.04.12.06.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:12:01 -0700 (PDT)
Message-ID: <10650c59-96f2-4234-b5fd-aa8efec90e5b@linaro.org>
Date: Fri, 12 Apr 2024 15:12:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add Amlogic T7 Reset Controller
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 kelvin.zhang@amlogic.com, Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zelong Dong <zelong.dong@amlogic.com>
References: <20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com>
 <20240329-t7-reset-v1-1-4c6e2e68359e@amlogic.com>
 <927ad2cb-3b41-4eda-b930-856be64ae9ba@linaro.org>
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
In-Reply-To: <927ad2cb-3b41-4eda-b930-856be64ae9ba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 29/03/2024 20:39, Krzysztof Kozlowski wrote:
> On 29/03/2024 10:17, Kelvin Zhang via B4 Relay wrote:
>> From: Zelong Dong <zelong.dong@amlogic.com>
>>
>> Add a new compatible and the related header file
>> for Amlogic T7 Reset Controller.
>>
>> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
>> ---
>>   .../bindings/reset/amlogic,meson-reset.yaml        |   1 +
>>   include/dt-bindings/reset/amlogic,t7-reset.h       | 197 +++++++++++++++++++++
>>   2 files changed, 198 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>> index f0c6c0df0ce3..fefe343e5afe 100644
>> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>> @@ -19,6 +19,7 @@ properties:
>>         - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
>>         - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
>>         - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
>> +      - amlogic,t7-reset # Reset Controller on T7 and compatible SoCs
>>   
> 
> If there is going to be any resend, please drop the comment. It's not
> really helpful and makes it trickier to read.
> 
>>     reg:
>>       maxItems: 1
>> diff --git a/include/dt-bindings/reset/amlogic,t7-reset.h b/include/dt-bindings/reset/amlogic,t7-reset.h
>> new file mode 100644
>> index 000000000000..ca4a832eeeec
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/amlogic,t7-reset.h
>> @@ -0,0 +1,197 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>> +/*
>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_AMLOGIC_T7_RESET_H
>> +#define _DT_BINDINGS_AMLOGIC_T7_RESET_H
>> +
>> +/* RESET0 */
>> +/*					0-3	*/
> 
> I assume this matches existing drivers which do not use IDs but map the
> binding to hardware value? I remember we talked about changing it, so if
> something happened about this and it could be changed: please change.

I'm not aware of such discussion, and I don't really see the issue...
thoses are IDs, and yes they match the Hardware offsets, and ?

> 
> Otherwise, it's fine:
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks,
Neil

> 
> 
> Best regards,
> Krzysztof
> 


