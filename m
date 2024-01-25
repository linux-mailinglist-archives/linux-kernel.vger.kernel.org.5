Return-Path: <linux-kernel+bounces-38108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D14983BB06
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4FD28B46E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D9517575;
	Thu, 25 Jan 2024 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFFXTkFF"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A117582
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169217; cv=none; b=srrviUlu4auLTsu1sMfBtFUB6GXwa1uRSjNdftiHqRi8D2gq9XQFgkO5mu7LUsSDrxIcAumvwNhDl0gJq5cEa7boSyy0+ILPcuCEqAGz9qK3sLfw+66P0f4BWOOqmlioCgQc/CNmvU/87NYmEBFomUYsZUxsnbU5pEZhxHjRjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169217; c=relaxed/simple;
	bh=i9VNXGfaiN/l/XalCDfaFnHnjrYBtyPvkRxLcVqbWZ0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ooPTxS/S0xFYDMxxAHa1ZofiZSNlSdDf5A6ttSA0BHf6HAKd7DhzTUbxNHn95dr9QOUnf0Zo7BeEFPJ+gDKufB8jIbsOXtFiFoMiECFKCdAUFlD77NG/zBt/V9JSrly+t3AAdPC9L2jmqCWzMCTgwiY6VPtvN7GrGWlmeac1sOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HFFXTkFF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33921b95dddso231306f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 23:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706169214; x=1706774014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYRx1TvAQfGyLvVsVin1GHvu8ITzf9xdpcm8DHtMUFo=;
        b=HFFXTkFFkOX25WjmXD3B51PV7hOIZnj//7ZMB9dJLySLoiA8PBxwApVQso8KTZ+fPH
         SlsX0qUeD1iYZYxHKnTEpLXo9zxynd38nAvNBgJyPUkXjrMVS2LdvG4T+uqoFY/Xh68P
         u0g6uE5Gy/6O10pQ28XzKWhBZzuJK1N5UXiwFPy2c/dobyPCWIrsSPAtMRW9VahPeuHY
         xHHE1KNiCTLoYFyKghr0jMAC5dRJgzzqOIFB6Gt7fn2hopwQ5mtKMfMKJqnW8Zgnu09K
         Xe0TppN3Yh97cNUb1Q6gAqgDQnnsDlPiKDmj4gOy9v7UL+1By3rg+4rXpirgwFzIsvrX
         NIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706169214; x=1706774014;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iYRx1TvAQfGyLvVsVin1GHvu8ITzf9xdpcm8DHtMUFo=;
        b=B2EHtIF61YBBejjFIRnaVq2lVGIEgW6HPhZHvE8T6qL/GM9S8uJ6kXJ1Rtu/xOYViU
         VaTBsWl1v9EtUji6K/FqipBYADZoUkG6cJAML8sZ6iYwmj1Jm3GYp9S5kPb7S7U/cxwu
         TaHZ9dCZPCZELPRbwxEKvG1e34Hy8h4cEHhh0wBMPgdLJcA9md4hlpAouTKrfSjScvBb
         Z53LKADqvOg4JtUb15qT5Haf5vK1W8HH4ZHaWz2fDT4wxXk3MP2iV9yMLroi+ufu2jy/
         PyY4vPIDx4EwiH46oKKpL/OCelUXahFzOsvWJVogzGBGPF9Mn1Zie5YUyuXCF26ygUR3
         dtKQ==
X-Gm-Message-State: AOJu0YxI7h6pL0wi2zBFntSVVNwFvllFUNf8qAYsXyUHXZuKVONGftrt
	srdWYZ8IlddEpSNv4aWHo00VP7/9JxQ6caCb0gquTLnDLk/buqw+U4hwaDW9L6k=
X-Google-Smtp-Source: AGHT+IFB4sW0msAL+NpLgtyBr8Djuh672Yx0WUtzXlzM5hFUfy3/3/hI5lKiAwg9GeCdQZjd0yGcaw==
X-Received: by 2002:a05:600c:220a:b0:40e:44bd:dc39 with SMTP id z10-20020a05600c220a00b0040e44bddc39mr259135wml.84.1706169213711;
        Wed, 24 Jan 2024 23:53:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1a7d:7b36:3842:9bc3? ([2a01:e0a:982:cbb0:1a7d:7b36:3842:9bc3])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b0040e549c77a1sm1599408wmq.32.2024.01.24.23.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 23:53:33 -0800 (PST)
Message-ID: <aa445a92-e640-4f1d-969c-20cafefcf44e@linaro.org>
Date: Thu, 25 Jan 2024 08:53:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] phy: qcom: qmp-pcie: Update PCIe PHY settings for
 SM8550
To: Qiang Yu <quic_qianyu@quicinc.com>, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
 kishon@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, quic_cang@quicinc.com, quic_mrana@quicinc.com
References: <1703742157-69840-1-git-send-email-quic_qianyu@quicinc.com>
 <e6b8befb-82e8-4803-929c-32e86d1e825a@linaro.org>
 <0a3f486d-0135-454e-9da6-b888e516a39e@quicinc.com>
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
Organization: Linaro Developer Services
In-Reply-To: <0a3f486d-0135-454e-9da6-b888e516a39e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/01/2024 03:59, Qiang Yu wrote:
> 
> On 1/24/2024 4:58 PM, neil.armstrong@linaro.org wrote:
>> On 28/12/2023 06:42, Qiang Yu wrote:
>>> Align PCIe0/PCIe1 PHY settings with SM8550 latest PCIe PHY Hardware
>>> Programming Guide.
>>>
>>> Can Guo (1):
>>>    phy: qcom: qmp-pcie: Update PCIe1 PHY settings for SM8550
>>>
>>> Qiang Yu (1):
>>>    phy: qcom: qmp-pcie: Update PCIe0 PHY settings for SM8550
>>>
>>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c             | 20 ++++++++++++++------
>>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h      |  2 ++
>>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h   |  2 ++
>>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h        |  1 +
>>>   .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h   |  2 ++
>>>   5 files changed, 21 insertions(+), 6 deletions(-)
>>>
>>
>> - On SM8550-HDK:
>> # lspci
>> 0000:00:00.0 PCI bridge: Qualcomm Device 0113
>> 0000:01:00.0 Network controller: Qualcomm Device 1107 (rev 01)
>> 0001:00:00.0 PCI bridge: Qualcomm Device 0113
>> 0001:01:00.0 Non-Volatile memory controller: Phison Electronics Corporation E12 NVMe Controller (rev 01)
>>
>>
>> # lspci -nvv
>> 0000:00:00.0 0604: 17cb:0113 (prog-if 00 [Normal decode])
>>         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L0s L1, Exit Latency L0s <4us, L1 <8us
>>         LnkSta:    Speed 5GT/s, Width x2
>> 0001:00:00.0 0604: 17cb:0113 (prog-if 00 [Normal decode])
>>         LnkCap:    Port #0, Speed 16GT/s, Width x2, ASPM L0s L1, Exit Latency L0s <4us, L1 <8us
>>         LnkSta:    Speed 8GT/s, Width x2
>>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK
>>
>> - On SM8550-QRD:
>> # lspci
>> 00:00.0 PCI bridge: Qualcomm Device 0113
>> 01:00.0 Network controller: Qualcomm Device 1107 (rev 01)
>>
>> # lspci -nvv
>>         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L0s L1, Exit Latency L0s <4us, L1 <8us
>>         LnkSta:    Speed 5GT/s, Width x2
>>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
>>
>> Thanks,
>> Neil
> 
> Hi Neil,
> 
> Thanks for testing this patch. I verified on aim300, did not see speed downgrade. Let me have a try on HDK8550.

I haven't seen speed downgrade either on the HDK8550

Neil

> 
> Thanks,
> Qiang
> 


