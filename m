Return-Path: <linux-kernel+bounces-79617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAFA8624BD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7858EB216B1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23D539AC3;
	Sat, 24 Feb 2024 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ma8pONkV"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205772E3FD
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775492; cv=none; b=DpO3JktL7g+yYTU2JNf8B71+/zMOETlYv6bgrrWrjBgjjMKvXm4unY0xA9tmX7B8070AfeaVZ8OO8w7LIuCImit63xsm44d5orUMFk5CSue1mWRAJzGx8Z2e3sSMsXzi3iBokzhnxvBFT8fZPODlog9ohIL1E1SeQYAzt1po9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775492; c=relaxed/simple;
	bh=1ZVaoX/vtCZst0YCdndUJ/OiT7J1WXVdIUQKOi04vbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c01b7ZckPN0NYv2CDGZg4dCV6UrCndxQ0geTteR//0C3dM9AjDfWgMKvknoUexDRVU79C0aVrZtWkMcNtxeYghw5bZ+V48m4jICHDnVNb4tbAd6o87nH5NrAnmeMill5du8E0TaJtep9kh8rONCbWcTL76X3mrICW/E5rdhKVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ma8pONkV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5648d92919dso1972210a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775489; x=1709380289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZWuN56T1LgisnRrY6Bcpyd8W/T98thea21LZidgs8M=;
        b=ma8pONkVpPRTX9GEqA1bTpdVHB3A4/kA6eA7NmXmVXpfkDJHHJc9rZlkL5eWVf3BfO
         RIzfY2lKYo2vw9eWjsWvyv9DWEkq3tzG2yOQGl7FecPJutCjtrT1etNXyU+N9/NwcCBz
         IHIbT2aquh345rUeK2nQaAs7TuOlpFlecKCsSL0WWo/lMEOvLwGdiDQkM2dymZ7jpoYw
         tGBSdNIQY8+d8d9Riq5E0pyvAmMJ19tjWkmaibDA7bXFs7BgRUawLZO9W5I8i1WpaDJx
         Bix66WLZ6NJsWJjuB6GPcFToMNjdXSkkSnCja5g1FMrnjZyEAPWCLHvtjrbS10b72AJU
         3zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775489; x=1709380289;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZWuN56T1LgisnRrY6Bcpyd8W/T98thea21LZidgs8M=;
        b=EBCEIzDpXc6XG1q77MVfa5MRNhqoLm4SUVuiW9NCsr0mZKfUUPkn21UYVQTAPuUI7t
         0OqxkCo3vQ2FB0ChwRVRM/79E2l4S/lDNaSDEaUKkUbZZ3zZ6ETkzIHt35ju/Uohya87
         pQYwyBLJetVaQYzFsQULkMpLYUDE7OnL+htkU7mJNWTCG9+hI98YRSgGTS9Qh9Td9/p4
         uEa5eINIbvwKnlOjxNFy5goTe+7jMCOp+shWTF5IK8QgbUVJZfrzddg6KrLt8y7+iHvV
         7McIF+KjhpQl6gpYu976lQ3ojl7lJG4Waj8VB051IykXkBGzsrNlZXlfvjorLNoloUg1
         NIQw==
X-Forwarded-Encrypted: i=1; AJvYcCXBrnRikD1657frRsZCDEwZHdgctDC889InhuNxZk4wNkYB0PIPVywA7GqfbpI8wlbcUG1AUy7H3yHkS2J97D+Lw8aTHWHtIylj58DM
X-Gm-Message-State: AOJu0Yx98acRMgQxCHv2cDEYo9hh89s6rmlNlT1CXZ5qUMgoRYfJuQQJ
	TGYSE/HloOuocRXenl5pU1g3IEUXvPaBKvGWiv+vtOI2Amd5RKx5i9AaAHzNj3Y=
X-Google-Smtp-Source: AGHT+IHPXSZVhMs9sYnhvpROn+JNrGhfGk4wXZqe3vjgS31h3SP0lGUCY1qzO5b+OjIbJzG8VkyPzw==
X-Received: by 2002:a05:6402:5148:b0:565:bb25:bb7b with SMTP id n8-20020a056402514800b00565bb25bb7bmr89120edd.6.1708775489534;
        Sat, 24 Feb 2024 03:51:29 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402401200b005640022af58sm476693eda.83.2024.02.24.03.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 03:51:29 -0800 (PST)
Message-ID: <24d8bfe7-3f10-4970-8999-c436e9c9b711@linaro.org>
Date: Sat, 24 Feb 2024 12:51:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: add hisilicon,hi3798mv200-dwc3
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240224-dwc3-v2-0-8e4fcd757175@outlook.com>
 <20240224-dwc3-v2-1-8e4fcd757175@outlook.com>
 <b64155f2-2965-4ea1-8c23-7c79d7a01c9f@linaro.org>
 <SEZPR06MB695934A8E7DEAD4366433AA496542@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB695934A8E7DEAD4366433AA496542@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/02/2024 12:33, Yang Xiwen wrote:
> On 2/24/2024 6:28 PM, Krzysztof Kozlowski wrote:
>> On 23/02/2024 22:43, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> Document the DWC3 controller used by Hi3798MV200.
>>>
>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: hisilicon,hi3798mv200-dwc3
>>> +
>>> +  '#address-cells':
>>> +    const: 1
>>> +
>>> +  '#size-cells':
>>> +    const: 1
>>> +
>>> +  reg: true
>> Constraints. maxItems: X
> 
> 
> Is it mandatory to have this property if this node is going to be under 
> a "simple-bus"? I'm taking rk3399-dwc3.yaml as reference. In fact, dwc3 
> wrapper on mv200 does not have an extra register space. The wrapper only 
> needs to turn on the clocks and deassert the resets. It does not 
> need/have a register space.

Then why did you add it? No, the property is not mandatory. Write
bindings in a way they match hardware...

> 
> 
> I don't think it makes sense duplicating the same address twice.
> 
> 
> But reg property is required by "simple-bus" so i don't know why there 
> is no warning for rk3399-dwc3.

I don't think it is. ranges or reg is.

Best regards,
Krzysztof


