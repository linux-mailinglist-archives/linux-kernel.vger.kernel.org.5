Return-Path: <linux-kernel+bounces-54753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB6D84B336
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6562814AB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61FA12F386;
	Tue,  6 Feb 2024 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BBiTWTDE"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDDF12F377
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217899; cv=none; b=Z5XYZQiJPILbCbBwg0qY0UsmG7cJLhEZyftyRTuhT2YtAa6GPbZANnHJXOIymSzRDVOhiK4msPUyNFsfAnvplhJbINHOVto5Tys3GGTg9cVazP6nAPV+jWlHY26m06zsNFeEYL2D5pbeqvmi/kVtA2DyMmtcVNggTZFH3P+dhaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217899; c=relaxed/simple;
	bh=3n1uciCeIu06dZp6krrMBk/NMHS+v5n7LWXZ3IZWV+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvFQPYpnAGrYRZJSGJoV1cUm/hQF13uaxdzsODhbAzg9Gov9pIkc5oYoMUNhE+q/homAmrCX6o8Oe0pzGaIyXBwV5ehfQziEAoom+EfQ20NMqqwVQFUeYahQ6gVQASUnakgyf0Ac7r/uKosnQj12Z5R3P6aZT/6gx/3cAzWGSs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BBiTWTDE; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-511413e52d4so3610669e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 03:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707217896; x=1707822696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLaBZa4xGxa8+RS/LCIRWz4jGPCQWzul7gdOT4bK6+E=;
        b=BBiTWTDEzL+YKMflLvZQ3ic/MZ0RSjt3HIyV4h5rUXFd6O4CxHVYMyKW3U8+aBznGv
         6hMeWmu9lOoVMlzIE9T3EUhypQbq2OgsXI/iftDCm2Kmtw4pcqME+w3KtH6aS7Es5J+d
         eSDjpC35Ha8b3l4VQ6VBIyOOjYSyyXyd6EWJXHiaz82Mx/q/h5HSzIr+Ycj1+aAY18ob
         km7wyzWVnyidtVIRRT/kpBit/hNZU7xvpuMu+J16OKKAg2W+zIXfYOATohT6If+EglXo
         aifHke3r1TCW/KqeIfoc61H9pYCDKYZt6n7GaINmyD8oSipVMbBrvesYMESm7am0eaSk
         1Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707217896; x=1707822696;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLaBZa4xGxa8+RS/LCIRWz4jGPCQWzul7gdOT4bK6+E=;
        b=lgLY+GSIUz4nH4XyMrd3n3UgGApd83z31jysL6muBJ4TQSkdiS/fs8f6ml4qCLNb+2
         R21iiiuBvMYZdhiijD8mvO9D10/Uhj04iONN+3i8K2h65tb/W40z5K4IwG3wM4KjTSgS
         HyZNJ1/4f69fj/bVgNatbBk+tLTq/1C1oSGF8z6+Z3pcNL5O7s8cUt1I7bJsJtbRxKmu
         5WfMk0liS2FFYVAWKfOTtwtFyibiIjybtmGxM4OteOHPSPtLTUFQITTeH4qaopKCKAlb
         7wTdNnRuiI3vzql41t94nUNIFzsE203KwNNL4vl9OMX90dWdqx3wBKFS+JfLWZBbkVIO
         Txvw==
X-Gm-Message-State: AOJu0Yw2hP3D+vB26gC9QI6KCEEf9q6YsWMIJYJhPQ7HE8VpRsCC+OZb
	f/qamEHbcvrYm4wNpfF4iibNOYQDVORgl0+WzWIy3+XOqnsTgsrNw/98eoLJmPs=
X-Google-Smtp-Source: AGHT+IFXAEv2dQujiMudZjdH4Jo+U+1BCSZeFI6KsmvGQHHlkv1adS//I7ozxirdiRz1KxZIz5+J7Q==
X-Received: by 2002:ac2:530c:0:b0:510:a34:5121 with SMTP id c12-20020ac2530c000000b005100a345121mr1610608lfh.52.1707217895936;
        Tue, 06 Feb 2024 03:11:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUpbHio/rk3DCHzWGjDRYyw/+jXZ/O2A8F6ndxKhccnIp9/qlLJ+Q9+gGHout8TD4DOJBLaCI6D/VyhPyTwTFP5owr85ViXRFs5Ys9fK26/FQc8Dbp93aNrNKJZlHhrILS2VTStqvjVQWnQ7WQ/t5pzsUeHfiDMSsb++KCHWvkUC7D0WpTk53exU8HFKWc76noyyfuEQvbOfucXBNZ2XdVgtYdaQKVGo+Iaie4ikmC4AEUPqmkw6BAZof8F8bxJirlo8Zi+JKkLR/kp+4fehzscBSyKj9wSt5jR7FY9fsINoK17jmSEXRFpeg7W3E0=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d5584000000b0033b1b1da2adsm1820284wrv.99.2024.02.06.03.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 03:11:35 -0800 (PST)
Message-ID: <803fd797-50d7-42a6-8723-6d001f80f7bf@linaro.org>
Date: Tue, 6 Feb 2024 12:11:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: Update pattern property case
Content-Language: en-US
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, mazziesaccount@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240205110244.676779-1-naresh.solanki@9elements.com>
 <8714b420-58b9-4d5b-a489-31670c8d325f@linaro.org>
 <CABqG17jfHpi5oDt+=E925Fp6DN2OftmDEjpmvb5=3nxMt+d2iw@mail.gmail.com>
 <47d66b4a-5608-4fc9-88bc-911f74d62819@linaro.org>
 <CABqG17gS6kdXKdVOc-CFEQp_BGJBANdCmEhUvQ1t=Tx=vw-9pg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CABqG17gS6kdXKdVOc-CFEQp_BGJBANdCmEhUvQ1t=Tx=vw-9pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 12:07, Naresh Solanki wrote:
> Hi Krzysztof,
> 
> 
> On Tue, 6 Feb 2024 at 13:06, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 05/02/2024 15:00, Naresh Solanki wrote:
>>> Hi Krzysztof,
>>>
>>>
>>> On Mon, 5 Feb 2024 at 18:38, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 05/02/2024 12:02, Naresh Solanki wrote:
>>>>> Driver expects regulator child node in upper case.
>>>>> Hence align with the same.
>>>>
>>>> Did the driver have DT support before? I think no, so why aligning that
>>>> way? I would argue that driver should be aligned with bindings, the
>>>> moment you add DT for the first time.
>>> Yes the driver has DT support already.
>>> This patch is to align with driver:
>>> https://github.com/torvalds/linux/blob/master/drivers/regulator/max5970-regulator.c#L381
>>
>> That's not support for DT, but just naming regulators.
> I'm not sure if I get your perspective right & please correct me if I'm wrong,
> I'm just trying to adjust the dt binding of max5970 because found
> errors related to
> regulator child node SW0/SW1.
> Regulator driver expects to have regulators child nodes as SW0/1(upper case)
> But dt binding expects it to be lower case.
> Thus there is misalignment & due to which, when running CHECK_DTBS for my
> mainboard DTS, I see some errors.

I understood that, no need to clarify, it is kind of obvious. I still
claim the same: When the binding was added? Mid 2023. When the driver
was added? Much earlier. So someone posted driver bypassing DT
documentation and review and now you claim we need to accept the driver
choice. Do you think this is correct process?

If so, what stops people from sending all the driver changes without DT
and documenting whatever they had post-factum?

> 
>>
>>>
>>> It was aligned but I missed on case sensitivity.
>>
>> I don't see the alignment. Where did you align it? Which commit?
> The current patch is to address the regulators child node name with driver.

So it was not aligned? Confused...

Best regards,
Krzysztof


