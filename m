Return-Path: <linux-kernel+bounces-56267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A6484C81C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8623B264ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054302420C;
	Wed,  7 Feb 2024 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4AW07qK"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4025571
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299842; cv=none; b=NNaSuxsmVcHcoAEnncg4QGnne41UBUCv4U9ijuC3YauJN7BaPqFH0Oxls4R6l2OG+MZpdRU39AF7W4DK16D70zl4bQ+WbGnAkjRUo3ctuor267XI+wMkWvCG9XXpxyMLwa24cq8ge6eMnQd8Yv/uY2kL2D2SFtomoxTTVs2KunQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299842; c=relaxed/simple;
	bh=dxOKRi+LOxJlRSQOxi/4X1R6GjNhpMp0FgfyP8KTUYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZK/rSW6k20/1WGrGRKveKNDnwIkCHMHJzoHuYlBKCHSeRlMys3nUsiS+CrMjAIrVqPp8Dn7Z4hwNSgEz3vb3C7KwV6Y95yVDy7AVWFjeyTy9kzVP87TdU06hCESKCJeD1tvd37UrKYY9YQagjUH8ZmV0l80iTCo1PySq5GZE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t4AW07qK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b29b5ea86so286993f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707299839; x=1707904639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gx39CCx3LV3xra6F49WIAUWpYypHNXn4vZiAEPHq23Y=;
        b=t4AW07qKH7ayeywW2JDVp1EfnH4oA5Emy0gKFFAXYWnuaBrhfKqcUiC+33i28Y/nFa
         cAStfGTKS7st6fuFMXW3QHueNdi4SGBF5gR9c/zUKvSJBh0CmdtZ6sJuEiiYJYbmidDd
         gKz53kO6i5ZHRjtgpThBzO4L3wthVjDzEh+BU24ojPqJbParAVonKb7Ynqzyy+bUto+7
         E7snwchxZ/HfJefKZq9tSje2nyGaVuOXxC5nZ6xT5+uR2VbNNAsGoTDA146QQ+PNgrvM
         evcqFVGpyh6On7u3uaKr/cJ3+IJbXHJpsItPOTZLllhrCsDS1jEc4S03GSLcMbpdK/i/
         iH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299839; x=1707904639;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gx39CCx3LV3xra6F49WIAUWpYypHNXn4vZiAEPHq23Y=;
        b=WJilwFqjwSP9yjiMv0fp3/2bxkLbqubLw/t2hlxMcX0q7w5KvCfxwVjUc5A0OtvcRe
         7YDKUgZ0FsVGebg8W/1x5Si0vZoYTV6Z64RmLj0TPLDNyyKQgur07f+l0UtS0PrDvxwA
         qZl20fu6p/BpqyK7h5rARdk7Ae9+mZcUrNVKfBJNyUw6T9ILqBd6aNeiOXMTnTleiF3a
         bpowbLJkr39SSYGxFzVLbKpHB1+1yqUOJBr1/nqgfxkAEmUFTxegNbR1woLvsIl4Kiut
         o84tKd1N0mxQ+0RvO0sRxg2VC75wn6RIYIx8fjlNbowcuwU4RfNq7+wtXh0k4CyXQx6D
         zh1Q==
X-Gm-Message-State: AOJu0Yx+/knfI8mirdV6FNq/RAOJ3/aXe2uHebuxR0J+los8OdVN2I1d
	0NwR+SnIo8sppH4fBoMvSzEZ0FR18PMosEeJ9YDssAEewItP3NjWB4KMxi4igT3i8pxwvWxmZBn
	T
X-Google-Smtp-Source: AGHT+IFSA/uuXQRSvU5s+OFgd2Yg4ghp+QE98rea879aa5rBau7ZIidLm7QgBopFs27SMF+kUZa2eA==
X-Received: by 2002:a05:6000:183:b0:33a:fe30:b8b4 with SMTP id p3-20020a056000018300b0033afe30b8b4mr3389120wrx.39.1707299839144;
        Wed, 07 Feb 2024 01:57:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXN8hhePPcbsQlP1wmVM7Eq/6ZQBEeZ6ForXFyqB8nkDI4Ruk18VowPPxsyMIzN14DyMqzqudPUomWk00NOg9CfwjsSwF01RYGA20r+pzz0psnnx7cJdc3zbGH3fll+xXMIw5BL8ft+6NH6fj+HC+1O5DoqT1ro1Pwa2TlhRCNHFcBeDTbLqAW8KzVgf7dSy41WSCSmPi6p8vlNg67u2fLGIb+2VsCWe9wFQtMhorSFgIRu7mpfm86Q7kwqYFWINCUCWIzTxP6wuSiU4gBg+jcEyNLIFGqFRbkqZarEMoUD+CUu3HRenILM3gWAVKT39Kjd1KINwW5lTHZdhqpmBOalWZpXASTTGS359QlWu4X2nwNK8M9hnnq1S6zO
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id y17-20020adffa51000000b0033ae4a3b285sm1083834wrr.36.2024.02.07.01.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 01:57:18 -0800 (PST)
Message-ID: <c687756a-1dcc-4103-b2ac-7c117ad792e2@linaro.org>
Date: Wed, 7 Feb 2024 10:57:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: usb: typec-tcpci: add tcpci compatible
 binding
Content-Language: en-US
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, linux@roeck-us.net,
 heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <20240205164316.805408-1-m.felsch@pengutronix.de>
 <20240205164316.805408-2-m.felsch@pengutronix.de>
 <004dbeb3-f863-416c-a4e4-18739302ae58@linaro.org>
 <20240206145253.u555h3rvtetv3qaf@pengutronix.de>
 <8d4cf7f7-0ee0-49ab-994a-892b200347e8@linaro.org>
 <20240207090544.g7dy7grssah3o6n3@pengutronix.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240207090544.g7dy7grssah3o6n3@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2024 10:05, Marco Felsch wrote:
> On 24-02-06, Krzysztof Kozlowski wrote:
>> On 06/02/2024 15:52, Marco Felsch wrote:
>>> On 24-02-06, Krzysztof Kozlowski wrote:
>>>> On 05/02/2024 17:43, Marco Felsch wrote:
>>>>> This binding descripes the generic TCPCI specification [1]. So add the
>>>>
>>>> Typo: describes.
>>>
>>> Argh.
>>>
>>>> No, this binding describes PTN5110, not generic TCPCI. This is not
>>>> accurate commit description.
>>>
>>> This binding is currently missued if another TCPCI conform chip is used
>>
>> Why would people misuse binding instead of doing things properly? :)
> 
> You know people... ;)
> 
> ...
> 
>>>>>  properties:
>>>>>    compatible:
>>>>> -    const: nxp,ptn5110
>>>>> +    enum:
>>>>> +      - nxp,ptn5110
>>>>> +      - tcpci
>>>>
>>>> I don't think this is correct. First, this is binding for NXP chip, so
>>>> why generic implementation should be here? I would expect it in its own
>>>> dedicated binding.
>>>
>>> The nxp,ptn5110 device was the first driver which implements an TCPCI
>>> conform driver. The driver already support the tcpci binding for i2c-id
>>> devices as I mentioned above. IMHO this whole binding (file) should be
>>> converted and the nxp,ptn5110 compatible should be marked as deprecated.
>>
>> You speak about driver, but I was speaking about binding.
> 
> I know and I was afraid of mention the driver within this conversation
> since this is all about bindings and devices :)
> 
> Nevertheless this particular NXP device does support the generic "tcpci"
> compatible already. The support is pulled indirectly via the
> i2c_device_id.name which is in the end used for of/acpi/legacy devices.
> 
>>>> Second, we rarely want generic compatibles. Care to share more details?
>>>
>>> As said above this particular NXP chip is an TCPCI conform chip. There
>>> is nothing special about it. There are other vendors like OnSemi (in my
>>> case) which implement also an TCPCI conform chip. The (Linux) driver
>>> already binds to the generic tcpci compatible if the i2c-core falls back
>>> to the i2c-device id. It's even more confusing that the i2c-id supports
>>> only the generic binding the of-compatible support only the specifc one.
>>
>> I don't know much about TCPCI, so maybe questions are obvious: you are
>> claiming that there will be no differentiating hardware element, like
>> reset-gpios or power supply for none of TCPCI-conforming chips? All of
>> them will never need any different hardware configuration?
> 
> Of course TCPCI doesn't mention reset gpios or power supplies but if you
> use this argumentation the already supported NXP device shouldn't be
> available too since the binding is missing the VDD supply ;) Since we

The existing binding is incomplete and maybe, as you suggested, misused,
but this is not a reason to make it worse.

> never break compatibility, the vdd-supply have to be optional and the
> same can be done for reset-gpios.

So the answer to my questions is: They will not be 100% identical and
they will need customization?

> 
>> Is this what you claim?
> 
> Please see above.
> 
>> Just to remind: there was such claim for USB and PCI till we figured out
>> it was simply wrong and we are living now with on-board hubs and PCI
>> power-sequencing stuff.
> 
> Don't get me wrong, I get your point. In the end I don't care and can
> copy'n'paste the whole file and change the compatible to the OnSemi
> device or I can add the dedicated OnSemi compatible to this file. But I
> don't wanted to add an 2nd specific compatible while the device already
> supports the generic one but via i2c_device_id.name. Therefore I aligned
> the i2c_device_id with the of_device_id.

You can add generic compatible used as fallback. That's pretty common
practice.

> 
>>>> Are all details expected to follow spec, without need of quirks?
>>>
>>> Please see above, I hope this helps.
>>
>> Sorry, doesn't. You still speak about driver and how it can bind to
>> something. I did not ask about this at all.
>>
>> To be clear:
>> WE ARE NOT TALKING ABOUT LINUX DRIVER.
> 
> I KNOW
> 
>> We talk about hardware and how it is represented in Devicetree,
>> including its supplies, pins, GPIOs and any ideas hardware engineers
>> like to bring.

Then terms "driver" and "binding" (or matching) do not fit here as
arguments whether specific compatible should be there or not. There is
guideline for that: writing bindings, which exactly, 100% covers this
thing here.

Best regards,
Krzysztof


