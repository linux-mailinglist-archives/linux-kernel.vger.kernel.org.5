Return-Path: <linux-kernel+bounces-39877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A936383D6E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9821C2E907
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6625BACA;
	Fri, 26 Jan 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="On48FVs5"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ADF5B5D7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259839; cv=none; b=tGlASj5ue3JKfcKMQKzbMTZy05sCOkZ4R/hy3+0+Wf2tPe4ikLLPGHemDqtakehPSiCBvxVKke59YyrwJwIxaELz5ZVSvZAcqokw8K9a0217UIZTq9MZAU7nFOt4rtn4i2oR507wQCrmavrdY7v1BlgFw7rGJjnV6tttfb0pqVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259839; c=relaxed/simple;
	bh=3LnmvNetm1QwgznC98yi3XYnV0Q3PjpkLrlwj9rwZx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEvmczwDiuftmNe8eyvzuThCbgUvZV+oFtoMJZyJbL/EPghnfzoL1sUWj0jTKOhirmLdZ0Oop2FbETKN9T6Rf/YwJeuPMtX9AQ5YFnOjEgs85MA6z3NzdUg/131k3ej/+zSTn6Zvpsq7uiwT8666VBkilpz2QutjbAKcwFqgfcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=On48FVs5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so113606a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706259836; x=1706864636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUogZIWl0s+Zj3EdGUH/qSBYhbrIOgv7SRqOagEMmc0=;
        b=On48FVs5XRH/ae92wJAFObx2xk4Di6SRILyzg/g0ECkNZ1A90i9o/ToOIMJKaohimV
         7SEynPNk52pKccd7PSAp5oAVNKAEeajWy25zpR7Z92r2wI9tDuJCnZY/quFPq5nLWoVN
         ddNsmygynsi0CksMJbe7UvANuj8VKQ1y4mll/Nn9oQ/OyRXQHB5iu1etddfAsSDhdUOq
         zZLAI+UpTAaOF2IqfHz/5VxIc7MYrWBK7YB+WbOrZnC48fiKj5EnbFkVQK96WUY7hLt0
         KB4ddue1btX9AHtk+lx7sFbhcq8S0X97z3Ku4fDr9eSAjHlI64W1y1vICS+qGdrXbGIQ
         Jbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706259836; x=1706864636;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUogZIWl0s+Zj3EdGUH/qSBYhbrIOgv7SRqOagEMmc0=;
        b=sXVoWzaB7nQh6UR7V2HuWIma97yskzwSf/JASPavszlJ3I1h4FZ2KsS9F+bevDoY0L
         whXew6XJ41BLvvjrO11eTK0i7WLmlrTDvyuU8IJeQX1/dt3JeM66+e8jK+YrrRrC09aW
         L2FCKs5Kl+2kBZfQabSs2ZOSJvgOzm7wShCBCWLvyUwYdLrauzrvNoDAIpBpYugK09Xd
         IF56Puj/TrM8lSbexdNJKpihgFAMoSQE4X5jr+LvSPNJUN+dDe9UxidjnbJB6vY0mmTh
         tBZ1ygCUFV2enxGxv1er/ypmkOPp6mjBA3ISnA1/Q0LDXPAiyRih/cGgX9JiWLXOHkSH
         fZvw==
X-Gm-Message-State: AOJu0YyHcEUdbMLFdfiqk6KqTW9TFACNHUuFpSkQILzdaO9I81LLUo7J
	3xOA0lOJl3gtTviGfITricvGgKQ3Vk3oL4+c0U1kyiiRMZ5yQl3+O9hOLPTxw1Q=
X-Google-Smtp-Source: AGHT+IHtocSuP9Gwsy3Jh+BKdTz2C5aBNFPV+8qkTgvdxysckcW2hYHiGcQrWucsjtJm/URpE3uoMA==
X-Received: by 2002:aa7:c510:0:b0:55a:ea3:c12a with SMTP id o16-20020aa7c510000000b0055a0ea3c12amr546874edq.20.1706259835789;
        Fri, 26 Jan 2024 01:03:55 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id z34-20020a509e25000000b00559dd0a5146sm390490ede.44.2024.01.26.01.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 01:03:55 -0800 (PST)
Message-ID: <58d24ddc-4e8f-4932-ac37-c9a699d36425@linaro.org>
Date: Fri, 26 Jan 2024 10:03:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] dt-bindings: power: reset: add bindings for NVMEM
 hardware storing PSCR Data
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <20240124122204.730370-1-o.rempel@pengutronix.de>
 <20240124122204.730370-5-o.rempel@pengutronix.de>
 <4e14b7c7-7f0a-437b-aa84-20fdc30a2361@linaro.org>
 <20240125171146.GC381737@pengutronix.de>
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
In-Reply-To: <20240125171146.GC381737@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/01/2024 18:11, Oleksij Rempel wrote:
> On Thu, Jan 25, 2024 at 11:57:18AM +0100, Krzysztof Kozlowski wrote:
>> On 24/01/2024 13:22, Oleksij Rempel wrote:
>>> Add device tree bindings that describe hardware implementations of
>>> Non-Volatile Memory (NVMEM) used for storing Power State Change Reasons
>>> (PSCR).
>>> +  that stores Power State Change Reasons (PSCR).
>>> +
>>> +allOf:
>>> +  - $ref: pscrr.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: pscrr-nvmem
>>> +
>>
>> So that's a driver :/. Maybe Rob will like it, but it's a no from me.
>> Please come up with something really suiting DEVICES, not DRIVERS.
> 
> If I understand your distinction between 'DEVICES' and 'DRIVERS'
> correctly, 'DEVICES' in the device tree context are meant to represent
> physical hardware components, while 'DRIVERS' refer to software

Yes.

> abstractions of these components. However, there are numerous device
> tree instances, like software-based implementations for SPI, I2C, or
> GPIO, which could also be interpreted as 'DRIVERS' in the context of

True. Yet they are still for physical interfaces. There is no DTS having
some virtual I2C for a board which does not have I2C.

> your email. Similarly, the binding for PSCRR represents functionality not
> fully implemented in hardware but supported by the hardware component of
> NVMEM, akin to how ramoops or other functionalities are represented.

You don't need a binding for your case. Instantiate it whatever you wish
- modprobe for example - and configure through approved kernel
interfaces - sysfs for example.

Best regards,
Krzysztof


