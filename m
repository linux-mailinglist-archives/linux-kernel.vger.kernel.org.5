Return-Path: <linux-kernel+bounces-3296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93955816A94
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F55B281C86
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F97134CC;
	Mon, 18 Dec 2023 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JF0b82/A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DFE134A9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c517d0de5so30703045e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702894197; x=1703498997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yk43Q72iETuPthnLG45NM2SPpQ2a0jDA3/fdMy7aOrk=;
        b=JF0b82/AJtAVNF7lFknKK1shMD9EoFMsP+6ZUZibj3xGXmC9ZR2tt1fho7vnKgp3jt
         J/z+hDNMwpmFPJmYTBp2c4dHl7qE40IZdMM+wgZin+N28OlLxOHvmRDT7pYW24Vmpwxz
         rGPFeA2Y9u398q2t+R+gKfMAugEAnT1fBnoX8x1FB9pS1EZymUd/TkNQvkg6UYUZ4pwq
         mJjelJ01Yb238+qYJhhOXbRsPC8jMSq7ArpLllP+5x0DveEckY2tC5QUMnf2oLwc3nF2
         N4Nd6uCh+ZVXOKsWaRbYP+zyAWLN+JdcYi6X2ggOhWJ52sUwIGZYE6VRQjRM11sgJcEy
         GTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894197; x=1703498997;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yk43Q72iETuPthnLG45NM2SPpQ2a0jDA3/fdMy7aOrk=;
        b=M6+ZqU4PjK1JfASay+h78iuvzPWR7x88em8+fqGaZsKaL1Z0HbtjGAnwDsmG1Ro8GP
         sTOiHKbqN6PPSr57xMzSD5lPW26lRANL90TEZgdlC9UP83tRQewUNvUVaKLEpbWFpihg
         w+UsR6bf2Mlve7kz/sSjkG0LCJSPkiwl6RqTAxqQjvD9sVIe1FHPcYVmz8x6ZbM2rCgh
         g7Hcc6KFiatI2KVV5yfGg3IOTWCZCA8bL4AvwKR7sGkUsaYEJ8PBWPJkFXTm4rd82Hwi
         MBxx9M+ST0Z1C0qqsxKyJttR38a0qV1cy+bIhTxqo+DKRtGS7BmnL1HZ6jDewUV6pwis
         a6Ug==
X-Gm-Message-State: AOJu0YxEeIKkkeMIdDsWsTJ1PH732U+bV0TVmiznHzLoRiOYHExSiVI8
	RmDSH1OjGXta91CScJfJBIL+bQ==
X-Google-Smtp-Source: AGHT+IEvLiv5uIxBczewJQUxj3fyC40lQRJ6wj3sekEPYc6kDhXo4TU081kFJ09+vbAPnCAWateKBQ==
X-Received: by 2002:a05:600c:4509:b0:40c:2518:687c with SMTP id t9-20020a05600c450900b0040c2518687cmr8146291wmo.61.1702894196975;
        Mon, 18 Dec 2023 02:09:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b425:da5d:c0cf:a505? ([2a01:e0a:982:cbb0:b425:da5d:c0cf:a505])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm43664215wms.30.2023.12.18.02.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:09:56 -0800 (PST)
Message-ID: <34b07b10-a70c-4599-8ae2-304e386fe9b2@linaro.org>
Date: Mon, 18 Dec 2023 11:09:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: defconfig: enable GPU clock controller for
 SM8[45]50
Content-Language: en-US, fr
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231204-topic-sm8x50-upstream-gpucc-defconfig-v1-1-e615df0c4af9@linaro.org>
 <5kkk7j6425wshf2bmmhrh26jwc3rstcrm6kgxyyzowq2qqrfw2@u2mgm6qefxvk>
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
In-Reply-To: <5kkk7j6425wshf2bmmhrh26jwc3rstcrm6kgxyyzowq2qqrfw2@u2mgm6qefxvk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/12/2023 06:11, Bjorn Andersson wrote:
> On Mon, Dec 04, 2023 at 02:01:47PM +0100, Neil Armstrong wrote:
>> Enable GPU Clock Controller for SM8450 and SM8550 to allow using
>> Adreno GPU on these SoCs.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/configs/defconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 5ad2b841aafc..56aebbdcdd40 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -1266,6 +1266,8 @@ CONFIG_SM_TCSRCC_8550=y
>>   CONFIG_SM_GPUCC_6115=m
>>   CONFIG_SM_GPUCC_8150=y
>>   CONFIG_SM_GPUCC_8250=y
>> +CONFIG_SM_GPUCC_8450=y
>> +CONFIG_SM_GPUCC_8550=y
> 
> I don't think these needs to be builtin, and if they do I'd like to see
> the reason captured in the commit message.

I don't have any good reasons... I'll resend with modules
since in my tests it worked fine as modules.

Neil

> 
> Regards,
> Bjorn
> 
>>   CONFIG_SM_VIDEOCC_8250=y
>>   CONFIG_QCOM_HFPLL=y
>>   CONFIG_CLK_GFM_LPASS_SM8250=m
>>
>> ---
>> base-commit: 9046d05c6ad632a271fc4173624e26f396975a80
>> change-id: 20231204-topic-sm8x50-upstream-gpucc-defconfig-3e3dc264be08
>>
>> Best regards,
>> -- 
>> Neil Armstrong <neil.armstrong@linaro.org>
>>


